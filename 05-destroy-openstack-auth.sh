#!/bin/bash
set -euo pipefail

# Load configuration variables
source 00-vars.sh

# Admin credentials
export OS_CLOUD="$ADMIN_OS_CLOUD"

###############################################
# Delete OpenStack Resources
###############################################

echo "Deleting users..."
openstack user delete "$HUB_USER" || true
openstack user delete "$TENANT_USER" || true

echo "Deleting projects..."
openstack project delete "$HUB_PROJECT" || true
openstack project delete "$TENANT_PROJECT" || true

echo "Cleanup complete."
