###############################################
# Configuration Variables
###############################################

# This depends on your clouds.yaml:
ADMIN_OS_CLOUD="beaker"
TENANT_OS_CLOUD="tenant_user"
HUB_OS_CLOUD="hub_user"

HUB_PROJECT="hub-tenant"
TENANT_PROJECT="customer-tenant"
HUB_USER="hub-user"
TENANT_USER="tenant-user"
HUB_PASSWORD="HubPassword123!"
TENANT_PASSWORD="TenantPassword123!"

DNS_NAMESERVER="1.1.1.1"

# Network and subnet details for the customer hostedcluster1 network
NETWORK_NAME="customer_network_hc1"
SUBNET_NAME="customer_subnet_hc1"
ROUTER_NAME="customer_router_hc1"
EXTERNAL_NETWORK_NAME="hostonly"
CIDR="192.168.100.0/24"

# Network and subnet details for the customer kubeapi endpoints network
API_NETWORK_NAME="customer_network_api"
API_SUBNET_NAME="customer_subnet_api"
API_ROUTER_NAME="customer_router_api"
API_CIDR="192.168.101.0/24"

ROUTER_NAMES=("$ROUTER_NAME" "$API_ROUTER_NAME")
SUBNET_NAMES=("$SUBNET_NAME" "$API_SUBNET_NAME")
NETWORK_NAMES=("$NETWORK_NAME" "$API_NETWORK_NAME")

# This depends on the Hub cluster:
HUB_CLUSTER_SUBNET_ID="97129ed6-a8f7-44c0-bd74-80447b6f9b1b"

# RBAC Action: allow hub tenant to use the network as shared
RBAC_ACTION="access_as_shared"

# Hypershift related:
RELEASE_IMAGE="registry.build06.ci.openshift.org/ci-ln-9g2hptk/release:latest"
INGRESS_FIP="192.168.25.51"
RHCOS_IMAGE="rhcos-4.19"
PULL_SECRET="~/hypershift/pull-secret.json"
SSH_KEY="~/hypershift/id_rsa.pub"
