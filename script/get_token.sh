#!/bin/bash

# Function to extract SDDCUSER and SDDCPASS from arguments
extract_credentials() {
    if [ $# -ne 2 ]; then
        echo "Usage: $0 <SDDCUSER> <SDDCPASS>"
        return 1
    fi

    SDDCUSER=$1
    SDDCPASS=$2
}

# Extract SDDCUSER and SDDCPASS from arguments
extract_credentials "$@" || true

# Request bearer token
response=$(
    curl -s -k -X POST https://sddc-manager-paris.corp.vmbeans.com/v1/tokens \
        -H 'Content-Type: application/json' \
        -d "{\"username\": \"$SDDCUSER\",\"password\": \"$SDDCPASS\"}"
)

# Extract token from response
token=$(echo "$response" | jq '.accessToken')

# Set token as environment variable
export TOKEN="$token"

# Print token for verification
echo "Bearer token: $TOKEN"


