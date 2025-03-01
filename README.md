# OpenStack Automation Scripts

This repository contains a set of scripts to automate the setup and teardown of OpenStack authentication and networking, along with support for deploying HyperShift on OpenStack.

## Prerequisites

Ensure you have the following dependencies installed:
- OpenStack CLI (`openstack` command-line tool)
- A valid `clouds.yaml` configuration file for OpenStack authentication

## Scripts Overview

### Configuration
- **`00-vars.sh`**: Defines essential variables for OpenStack authentication and networking.

### Setup Scripts
- **`01-create-openstack-auth.sh`**: Sets up OpenStack authentication for admin and tenant users.
- **`02-create-openstack-network.sh`**: Creates an OpenStack network for tenant users.
- **`03-hypershift.sh`**: Deploys HyperShift on OpenStack using preconfigured network settings.

### Teardown Scripts
- **`04-destroy-openstack-network.sh`**: Removes the OpenStack network and related resources.
- **`05-destroy-openstack-auth.sh`**: Cleans up OpenStack authentication credentials.

## Usage

### Running the Setup
Execute the scripts in the following order to provision OpenStack authentication and networking:
```sh
source 00-vars.sh
./01-create-openstack-auth.sh
./02-create-openstack-network.sh
./03-hypershift.sh
```

### Destroying the Setup
To clean up resources, run:
```sh
./04-destroy-openstack-network.sh
./05-destroy-openstack-auth.sh
```

## Notes
- Modify `00-vars.sh` to match your OpenStack environment.
- These scripts assume a preconfigured OpenStack environment with the necessary access rights.
