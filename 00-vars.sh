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

DNS_NAMESERVER="10.11.5.160"

# Network and subnet details for the customer hostedcluster1 network
NETWORK_NAME="customer_network_hc1"
SUBNET_NAME="customer_subnet_hc1"
ROUTER_NAME="customer_router_hc1"
KAS_VIP_PORT_NAME="kas_vip_hc1"
EXTERNAL_NETWORK_NAME="hostonly"
CIDR="192.168.100.0/24"

ROUTER_NAMES=("$ROUTER_NAME")
SUBNET_NAMES=("$SUBNET_NAME")
NETWORK_NAMES=("$NETWORK_NAME")
PORT_NAMES=("$KAS_VIP_PORT_NAME")

# RBAC Action: allow hub tenant to use the network as shared
RBAC_ACTION="access_as_shared"

# Hypershift related:
RELEASE_IMAGE="registry.build06.ci.openshift.org/ci-ln-tzqs0jb/release:latest"
INGRESS_FIP="192.168.25.177"
RHCOS_IMAGE="rhcos-4.19"
PULL_SECRET="${HOME}/hypershift/pull-secret.json"
SSH_KEY="${HOME}/hypershift/id_rsa.pub"
