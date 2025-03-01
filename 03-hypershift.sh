#!/bin/bash

# Load configuration variables
source 00-vars.sh

export OS_CLOUD="$TENANT_OS_CLOUD"
EXTERNAL_NET_ID=$(openstack network show -f value -c id $EXTERNAL_NETWORK_NAME)
HC_NETWORK_ID=$(openstack network show -f value -c id $NETWORK_NAME)
HC_SUBNET_ID=$(openstack subnet show -f value -c id $SUBNET_NAME)
HC_ROUTER_ID=$(openstack router show -f value -c id $ROUTER_NAME)
API_SUBNET_ID=$(openstack subnet show -f value -c id $API_SUBNET_NAME)

hypershift-byon install --hypershift-image quay.io/emilien/hypershift:byon --tech-preview-no-upgrade
echo "Wait for the Operator to be ready..."
sleep 20

hcp-byon create cluster openstack \
	--control-plane-availability-policy SingleReplica \
	--infra-availability-policy SingleReplica \
	--node-pool-replicas 1 \
	--base-domain shiftstack-dev.devcluster.openshift.com \
	--name emacchi-hcp-byon \
	--release-image "${RELEASE_IMAGE}" \
 	--openstack-node-image-name "${RHCOS_IMAGE}" \
	--openstack-external-network-id "${EXTERNAL_NET_ID}" \
	--openstack-ingress-floating-ip "${INGRESS_FIP}" \
	--openstack-node-flavor m1.large \
	--openstack-network-id "$HC_NETWORK_ID" \
	--openstack-subnet-ids "$HC_SUBNET_ID" \
	--openstack-router-id "$HC_ROUTER_ID" \
	--openstack-api-server-subnet-id "$API_SUBNET_ID" \
	--machine-cidr "$CIDR" \
	--pull-secret "$PULL_SECRET" \
	--ssh-key "$SSH_KEY"
