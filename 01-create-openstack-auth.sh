#!/bin/bash
set -euo pipefail

# Load configuration variables
source 00-vars.sh

# Admin credendtials
export OS_CLOUD="$ADMIN_OS_CLOUD"

###############################################
# Create Projects (Tenants) and unlimited quotas
###############################################
echo "Creating projects..."
openstack project create "$HUB_PROJECT"
openstack project create "$TENANT_PROJECT"
openstack quota set --cores -1 --ram -1 "$HUB_PROJECT"
openstack quota set --cores -1 --ram -1 "$TENANT_PROJECT"

###############################################
# Create Users
###############################################
echo "Creating users..."
openstack user create --password "$HUB_PASSWORD" --project "$HUB_PROJECT" "$HUB_USER"
openstack user create --password "$TENANT_PASSWORD" --project "$TENANT_PROJECT" "$TENANT_USER"

# Grant member to these users
echo "Assigning roles..."
openstack role add --project "$HUB_PROJECT" --user "$HUB_USER" member
openstack role add --project "$TENANT_PROJECT" --user "$TENANT_USER" member

###############################################
# Summary Output
###############################################
echo "Setup complete."
echo "Hub Tenant Credentials:"
echo "  Project: $HUB_PROJECT"
echo "  User:    $HUB_USER"
echo "  Password: $HUB_PASSWORD"
echo
echo "Customer Tenant Credentials:"
echo "  Project: $TENANT_PROJECT"
echo "  User:    $TENANT_USER"
echo "  Password: $TENANT_PASSWORD"
echo
echo "Now, update your clouds.yaml"
