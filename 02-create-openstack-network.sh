#!/bin/bash
set -euo pipefail

# Load configuration variables
source 00-vars.sh

# Customer credendtials
export OS_CLOUD="$TENANT_OS_CLOUD"

###############################################
# Create Networks and Subnets in the Tenant Project
###############################################
echo "Creating networks and subnets in the customer tenant..."
openstack network create "$NETWORK_NAME"
openstack subnet create \
  --network "$NETWORK_NAME" \
  --subnet-range "$CIDR" \
  --dns-nameserver "$DNS_NAMESERVER" \
  "$SUBNET_NAME"

###############################################
# Create Routers and connect the Subnets.
###############################################
echo "Creating router and connect the HostedCluster Nodepool subnet"
openstack router create --external-gateway "$EXTERNAL_NETWORK_NAME" "$ROUTER_NAME"
openstack router add subnet "$ROUTER_NAME" "$SUBNET_NAME"

NETWORK_ID=$(openstack network show "$NETWORK_NAME" -f value -c id)
SUBNET_ID=$(openstack subnet show "$SUBNET_NAME" -f value -c id)        
ROUTER_ID=$(openstack router show "$ROUTER_NAME" -f value -c id)

###############################################
# Allow Hub Tenant to Create Ports on the Tenant's Network
###############################################

export OS_CLOUD="$HUB_OS_CLOUD"
HUB_PROJECT_ID=$(openstack token issue -c project_id -f value)
export OS_CLOUD="$TENANT_OS_CLOUD"

echo "Configuring RBAC: Allowing hub tenant to create ports on $NETWORK_NAME..."
openstack network rbac create \
  --target-project "$HUB_PROJECT_ID" \
  --action "$RBAC_ACTION" \
  --type network \
  "$NETWORK_NAME"

###############################################
# Create VIP for KAS
###############################################

echo "Creating VIP for KAS..."
openstack port create --network "$NETWORK_NAME" "$KAS_VIP_PORT_NAME"
