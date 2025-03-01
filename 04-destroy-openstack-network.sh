#!/bin/bash
set -euo pipefail

# Load configuration variables
source 00-vars.sh

# Admin credentials
export OS_CLOUD="$ADMIN_OS_CLOUD"

###############################################
# Delete OpenStack Resources
###############################################

echo "Deleting routers..."
for ROUTER in "${ROUTER_NAMES[@]}"; do
    if openstack router show "$ROUTER" >/dev/null 2>&1; then
        openstack router unset --external-gateway "$ROUTER" || true
        for SUBNET in "${SUBNET_NAMES[@]}"; do
            openstack router remove subnet "$ROUTER" "$SUBNET" || true
        done
        openstack router delete "$ROUTER"
    fi
done

echo "Deleting subnets..."
for SUBNET in "${SUBNET_NAMES[@]}"; do
    openstack subnet delete "$SUBNET" || true
done

echo "Deleting networks..."
for NETWORK in "${NETWORK_NAMES[@]}"; do
    openstack network delete "$NETWORK" || true
done

echo "Cleanup complete."
