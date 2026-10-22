#!/bin/bash
# Enables NCache TLS on this container once the NCache service is running.
# Started in the background by startup.sh just before the NCache daemon becomes PID 1.
#
# Environment variables
#   NC_ENABLE_TLS                 true enables TLS on this container's IP address
#   NC_MUTUAL_TLS                 true enables mutual TLS with the certificates below
#   NC_TLS_CUSTOM_CERTIFICATE     server certificate PEM (private key, certificate, intermediates)
#   NC_TLS_CUSTOM_PASSWORD        password of the encrypted private key in NC_TLS_CUSTOM_CERTIFICATE
#   NC_TLS_CLIENT_CERTIFICATE     client certificate PEM
#   NC_TLS_CLIENT_PASSWORD        password of the encrypted private key in NC_TLS_CLIENT_CERTIFICATE
#   NC_TLS_PROTOCOL_VERSION       tls12 (default), tls13 or auto
#   NC_BIND_IP                    (ipbinding.sh) the address NCache binds to; TLS is enabled on the same address

export LOG_SOURCE="${LOG_SOURCE:-docker}"
export LOG_APPDOMAIN="${LOG_APPDOMAIN:-ncache-docker}"
export LOG_LOGGER="enable-tls.sh"
export LOG_THREAD="main"

NCACHE_LOGGER="/opt/ncache/ext/resources/kubernetes/ncache-logger.sh"
if [ -f "$NCACHE_LOGGER" ]; then
    source "$NCACHE_LOGGER"
else
    log_info() { echo "[INFO] $*"; }
    log_error() { echo "[ERROR] $*" >&2; }
fi

STATUS_FILE="/tmp/ncache-tls-ready"
KUBERNETES_HTTP_HELPER="/opt/ncache/ext/resources/kubernetes/ncache-http-helper.sh"
SERVICE_ACCOUNT_NAMESPACE="/var/run/secrets/kubernetes.io/serviceaccount/namespace"

report_tls_state() {
    [ -f "$SERVICE_ACCOUNT_NAMESPACE" ] && [ -f "$KUBERNETES_HTTP_HELPER" ] || return 0
    ( source "$KUBERNETES_HTTP_HELPER" && http_save_tls_node_state "$(hostname)" "$1" "$(cat "$SERVICE_ACCOUNT_NAMESPACE")" ) > /dev/null 2>&1 || true
}

fail() {
    log_error "TLS was not enabled: $*"
    rm -f "$STATUS_FILE"
    log_error "Stopping the container because NC_ENABLE_TLS=true and TLS could not be enabled."
    kill -TERM 1
    exit 1
}

# The address ipbinding.sh bound the NCache service to; the service listens only on it.
bound_ip() {
    local ip
    ip=$(sed -n 's/.*key="NCacheServer.BindToClientServerIP" value="\([^"]*\)".*/\1/p' /opt/ncache/bin/service/Alachisoft.NCache.Daemon.dll.config 2>/dev/null | head -n 1)
    [ -n "$ip" ] || ip=$(hostname -I 2> /dev/null | awk '{print $1}')
    echo "$ip"
}

wait_for_service() {
    local node="$1" deadline
    deadline=$(( $(date +%s) + 300 ))
    until timeout 5 bash -c "cat < /dev/null > /dev/tcp/$node/9803" 2> /dev/null; do
        [ "$(date +%s)" -lt "$deadline" ] || return 1
        sleep 3
    done
}

enable_tls() {
    local node="$1" mutual="$2" output status
    output=$(cd /opt/ncache/lib && NO_COLOR=1 TLS_NODE="$node" TLS_MUTUAL="$mutual" pwsh -NoProfile -NonInteractive -Command '
        $ErrorActionPreference = "Stop"
        try {
            Import-Module /opt/ncache/lib/tools/ncacheps
            $arguments = @{ Node = $env:TLS_NODE; NoLogo = $true }
            # The custom certificate applies to one-way and mutual TLS alike.
            if ($env:NC_TLS_CUSTOM_CERTIFICATE) { $arguments.CustomCertificatePath = $env:NC_TLS_CUSTOM_CERTIFICATE }
            if ($env:NC_TLS_CUSTOM_CERTIFICATE -and $env:NC_TLS_CUSTOM_PASSWORD) { $arguments.CustomCertificatePassword = $env:NC_TLS_CUSTOM_PASSWORD }
            if ($env:TLS_MUTUAL -eq "true") {
                $arguments.UseMutualTls = $true
                if ($env:NC_TLS_CLIENT_CERTIFICATE -and (Test-Path $env:NC_TLS_CLIENT_CERTIFICATE)) { $arguments.TlsCertPath = $env:NC_TLS_CLIENT_CERTIFICATE }
                if ($env:NC_TLS_CLIENT_PASSWORD) { $arguments.TlsCertPassword = $env:NC_TLS_CLIENT_PASSWORD }
            }
            if ($env:NC_TLS_PROTOCOL_VERSION) { $arguments.ProtocolVersion = $env:NC_TLS_PROTOCOL_VERSION }
            $result = Enable-NCacheTLS @arguments *>&1 | Out-String
        } catch {
            Write-Output $_.Exception.Message
            exit 1
        }
        Write-Output $result
        if ($result -notmatch "enabled successfully" -or $result -match "Failed to enable|An error of type|Invalid value|not provided") { exit 1 }
    ' 2>&1)
    status=$?
    echo "$output"
    return "$status"
}

main() {
    local node mutual=false
    rm -f "$STATUS_FILE"
    if [[ "${NC_ENABLE_TLS,,}" != "true" ]]; then
        echo disabled > "$STATUS_FILE"
        report_tls_state disabled
        exit 0
    fi
    report_tls_state pending

    log_info "================ ENABLE TLS START ================"
    node=$(bound_ip)
    [ -n "$node" ] || fail "the container IP address could not be determined; set NC_BIND_IP"
    if [ -n "${NC_TLS_CUSTOM_CERTIFICATE:-}" ] && [ ! -f "$NC_TLS_CUSTOM_CERTIFICATE" ]; then
        fail "NC_TLS_CUSTOM_CERTIFICATE '$NC_TLS_CUSTOM_CERTIFICATE' does not exist in the container; mount it with -v before the image name"
    fi
    case "${NC_TLS_PROTOCOL_VERSION,,}" in
        ""|tls12|tls13|auto) ;;
        *) fail "NC_TLS_PROTOCOL_VERSION '$NC_TLS_PROTOCOL_VERSION' is not valid; use tls12, tls13 or auto" ;;
    esac
    if [[ "${NC_MUTUAL_TLS,,}" == "true" ]]; then
        mutual=true
        if [ -n "${NC_TLS_CLIENT_CERTIFICATE:-}" ] && [ ! -f "$NC_TLS_CLIENT_CERTIFICATE" ]; then
            fail "NC_TLS_CLIENT_CERTIFICATE '$NC_TLS_CLIENT_CERTIFICATE' does not exist in the container"
        fi
    fi
    log_info "TLS on $node (mutual: $mutual, custom certificate: ${NC_TLS_CUSTOM_CERTIFICATE:-none}, client certificate: ${NC_TLS_CLIENT_CERTIFICATE:-none}, protocol: ${NC_TLS_PROTOCOL_VERSION:-tls12})"

    log_info "Waiting up to 300s for the NCache service on $node:9803"
    wait_for_service "$node" || fail "the NCache service did not start listening on port 9803"

    enable_tls "$node" "$mutual" || fail "Enable-NCacheTLS failed"
    echo enabled > "$STATUS_FILE"
    report_tls_state enabled
    log_info "TLS enabled on $node"
    log_info "================ ENABLE TLS END =================="
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    main "$@"
fi
