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

openstack network create "$API_NETWORK_NAME"
openstack subnet create \
  --network "$API_NETWORK_NAME" \
  --subnet-range "$API_CIDR" \
  --dns-nameserver "$DNS_NAMESERVER" \
  "$API_SUBNET_NAME"

###############################################
# Create Routers and connect the Subnets.
###############################################
echo "Creating router and connect the HostedCluster Nodepool subnet and the Hosted Control plane API subnet"
openstack router create --external-gateway "$EXTERNAL_NETWORK_NAME" "$ROUTER_NAME"
openstack router add subnet "$ROUTER_NAME" "$SUBNET_NAME"
openstack router add subnet "$ROUTER_NAME" "$API_SUBNET_NAME"

NETWORK_ID=$(openstack network show "$NETWORK_NAME" -f value -c id)
API_NETWORK_ID=$(openstack network show "$API_NETWORK_NAME" -f value -c id)
SUBNET_ID=$(openstack subnet show "$SUBNET_NAME" -f value -c id)        
API_SUBNET_ID=$(openstack subnet show "$API_SUBNET_NAME" -f value -c id)
ROUTER_ID=$(openstack router show "$ROUTER_NAME" -f value -c id)

###############################################
# Allow Hub Tenant to Create Ports on the Tenant's Network
###############################################

export OS_CLOUD="$HUB_OS_CLOUD"
HUB_PROJECT_ID=$(openstack subnet show "$HUB_CLUSTER_SUBNET_ID" -f value -c project_id)
export OS_CLOUD="$TENANT_OS_CLOUD"

echo "Configuring RBAC: Allowing hub tenant to create ports on $API_NETWORK_NAME..."
openstack network rbac create \
  --target-project "$HUB_PROJECT_ID" \
  --action "$RBAC_ACTION" \
  --type network \
  "$API_NETWORK_NAME"

###############################################
# Create a Router that connects the Hub subnet
# and Tenant's API network
###############################################

# Switch to the hub credentials
export OS_CLOUD="$HUB_OS_CLOUD"
echo "Creating router and connect the Hosted Control plane API subnet and the Hub cluster subnet"
openstack router create "$API_ROUTER_NAME"
API_ROUTER_ID=$(openstack router show "$API_ROUTER_NAME" -f value -c id)
openstack router add subnet "$API_ROUTER_NAME" "$API_SUBNET_NAME"
openstack router add subnet "$API_ROUTER_NAME" "$HUB_CLUSTER_SUBNET_ID"

###############################################
# Summary Output
###############################################
echo "HostedCluster Network Details:"
echo "  Network Name: $NETWORK_NAME"
echo "  Network ID:   $NETWORK_ID"
echo "  Subnet ID:    $SUBNET_ID"
echo "  Router ID:    $ROUTER_ID"

echo "API Network Details:"
echo "  Network Name: $API_NETWORK_NAME"
echo "  Network ID:   $API_NETWORK_ID"
echo "  Subnet ID:    $API_SUBNET_ID"
echo "  Router ID:    $API_ROUTER_ID"
