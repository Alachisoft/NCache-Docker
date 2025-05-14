#!/usr/bin/env bash

# Paths to NCache tools (adjust if needed)
TOOLS_DIR="/opt/ncache/bin/tools"

# Environment variables expected
# - NC_LICENSE_KEY (for full license)
# - NC_INSTALL_KEY (for evaluation)
# - NC_FIRST_NAME, LAST_NAME, EMAIL, COMPANY, ENVIRONMENT
# - NC_REGISTER_AS (optional: CacheServer|RemoteClient|Developer)

# Validate common user info variables and build common args string
build_common_args() {
  # Check required env vars
  local missing_vars=()
  for var in NC_FIRST_NAME NC_LAST_NAME NC_EMAIL NC_COMPANY; do
    if [ -z "${!var}" ]; then
      missing_vars+=("$var")
    fi
  done

  if [ ${#missing_vars[@]} -ne 0 ]; then
    echo "ERROR: Missing required environment variables: ${missing_vars[*]}"
    exit 1
  fi

  # Build common args string
  local args="-FirstName \"$NC_FIRST_NAME\" -LastName \"$NC_LAST_NAME\" -Email \"$NC_EMAIL\" -Company \"$NC_COMPANY\""

  # Build optional RegisterAs argument
  if [ -n "$NC_REGISTER_AS" ]; then
    args+=" -RegisterAs \"$NC_REGISTER_AS\""
  fi

  echo "$args"
}

if [ -n "$NC_LICENSE_KEY" ] && [ -n "$NC_ENVIRONMENT" ]; then
   eval "$TOOLS_DIR/register-ncache -Key $NC_LICENSE_KEY -Environment $NC_ENVIRONMENT " $(build_common_args)
   status=$?
elif [ -n "$NC_INSTALL_KEY" ]; then
	eval "$TOOLS_DIR/register-ncacheevaluation -Key $NC_INSTALL_KEY " $(build_common_args)
	status=$?
fi

if [ $status -eq 0 ]; then
  echo "NCache activated successfully."
else
  echo "NCache activation failed."
  exit 1
fi
