#!/usr/bin/env bash

# Configure logger before sourcing
export LOG_SOURCE="docker"
export LOG_APPDOMAIN="ncache-docker"
export LOG_LOGGER="activate.sh"
export LOG_THREAD="main"

log_info() { echo "[INFO] $*"; }
log_error() { echo "[ERROR] $*" >&2; }

# Environment variables expected
#
# Activation:
# - NC_LICENSE_KEY          (for licensed activation)
# - NC_KEY          (for evaluation activation)
# - NC_LICENSE_ENV          (required for licensed activation)
# - NC_REGISTER_AS          (optional: Server | Client | Developer)
# - NC_INSTALL_ENV          (optional: passed as -InstallType to both activation commands)
#
# Kubernetes:
# - KUBERNETES_SERVICE_HOST (for Kubernetes only)
# - NC_LOCAL_KUBERNETES     (for local Kubernetes environments without public internet access)
#
# TLS is enabled by enable-tls.sh after the NCache service starts (see startup.sh).

VALID_ROLES=("server" "client" "developer")


# ============================================================
# Normalize and validate NC_REGISTER_AS
# ============================================================

if [ -n "${NC_REGISTER_AS:-}" ]; then
    INPUT="$(echo "$NC_REGISTER_AS" | tr '[:upper:]' '[:lower:]')"

    VALID=false

    for r in "${VALID_ROLES[@]}"; do
        if [ "$INPUT" == "$r" ]; then
            VALID=true
            break
        fi
    done

    if [ "$VALID" = false ]; then
        log_error "Invalid NC_REGISTER_AS value: '$NC_REGISTER_AS'. Allowed values: Server | Client | Developer"
        exit 1
    fi

    # overwrite with normalized value
    NC_REGISTER_AS="$INPUT"
fi


# ============================================================
# Build common arguments
# ============================================================

LOCAL_ARGS=()

if [[ -n "${KUBERNETES_SERVICE_HOST:-}" && "${NC_LOCAL_KUBERNETES:-}" == "true" ]]; then
    LOCAL_ARGS+=("-local" "true")
fi

if [[ "$NC_IS_HOURLY" == "true" ]]; then
    NC_LICENSE_KEY="xxxxxxxx-xxxxxx-xxxxxxxx"
fi

status=0
output=""
activation_attempted=false


# ============================================================
# Licensed activation
# ============================================================

if [ -n "${NC_LICENSE_KEY:-}" ] && [ -n "${NC_LICENSE_ENV:-}" ]; then

    activation_attempted=true

    log_info "Starting licensed activation."

    CMD="Register-NCacheLicense -Key '$NC_LICENSE_KEY' -Environment '$NC_LICENSE_ENV' -Force"


if [[ "$NC_IS_HOURLY" == "true" ]]; then
        log_info "Hourly activation detected."
        CMD+=" -LicenseDuration Hourly"
fi

    # Add RegisterAs when provided
    if [ -n "${NC_REGISTER_AS:-}" ]; then
        CMD="$CMD -RegisterAs '$NC_REGISTER_AS'"
    fi

    # Add InstallType when provided
    if [ -n "${NC_INSTALL_ENV:-}" ]; then
        CMD="$CMD -InstallType '$NC_INSTALL_ENV'"
    fi

    # Add local Kubernetes option when applicable
    if [ "${#LOCAL_ARGS[@]}" -gt 0 ]; then
        CMD="$CMD -local true"
    fi

    log_info "Executing NCache licensed activation."

    output=$(pwsh -NoProfile -Command "$CMD" 2>&1)
    status=$?

    # If activation fails because the machine has a different configuration,
    # attempt reactivation.
    if echo "$output" | grep -qi "The machine has already been activated with a different configuration"; then
        log_info "Different configuration detected. Attempting reactivation..."

        CMD="$CMD -Reactivate"

        output=$(pwsh -NoProfile -Command "$CMD" 2>&1)
        status=$?
    fi


# ============================================================
# Evaluation activation
# ============================================================

elif [ -n "${NC_KEY:-}" ]; then

    activation_attempted=true

    log_info "Starting evaluation activation."

    CMD="Register-NCache -Key '$NC_KEY' -Force"

    # Add RegisterAs when provided
    if [ -n "${NC_REGISTER_AS:-}" ]; then
        CMD="$CMD -RegisterAs '$NC_REGISTER_AS'"
    fi

    # Add InstallType when provided
    if [ -n "${NC_INSTALL_ENV:-}" ]; then
        CMD="$CMD -InstallType '$NC_INSTALL_ENV'"
    fi

    # Add local Kubernetes option when applicable
    if [ "${#LOCAL_ARGS[@]}" -gt 0 ]; then
        CMD="$CMD -local true"
    fi

    log_info "Executing NCache evaluation activation."

    output=$(pwsh -NoProfile -Command "$CMD" 2>&1)
    status=$?


# ============================================================
# No activation information provided
# ============================================================

else
    log_info "No activation information provided. Skipping activation."
fi


# ============================================================
# Activation result
# ============================================================

if [ "$activation_attempted" = true ]; then

    # Log activation output when available
    if [ -n "$output" ]; then
        echo "$output"
    fi

    if [ "$status" -eq 0 ]; then
        log_info "NCache activated successfully."
    else
        log_error "NCache activation failed with exit code $status."
        exit 1
    fi
fi


exit 0