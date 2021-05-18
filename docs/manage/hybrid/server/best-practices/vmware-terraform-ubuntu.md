---
title: Use a Terraform plan to deploy a VMware Ubuntu virtual machine and connect it to Azure Arc
description: Use a Terraform plan to deploy a VMware Ubuntu virtual machine and connect it to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

<!-- cspell:ignore tfvars winsrv -->

# Use a Terraform plan to deploy a VMware Ubuntu virtual machine and connect it to Azure Arc

This article provides guidance for using the provided [Terraform](https://www.terraform.io/) plan to deploy an Ubuntu server, VMware vSphere virtual machine and connect it as an Azure Arc enabled server resource.

## Prerequisites

1. Clone the Azure Arc Jumpstart repository.

    ```console
    git clone https://github.com/microsoft/azure_arc.git
    ```

2. [Install or update Azure CLI to version 2.7 and above](/cli/azure/install-azure-cli). Use the following command to check your current installed version.

    ```console
    az --version
    ```

3. [Install Terraform >= 0.12](https://learn.hashicorp.com/tutorials/terraform/install-cli)

4. A VMware vCenter Server user with [permissions to deploy](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-4D0F8E63-2961-4B71-B365-BBFA24673FDB.html) a virtual machine from a template in the vSphere web client.

5. Create an Azure service principal.

    To connect the VMware vSphere virtual machine to Azure Arc, an Azure service principal assigned with the Contributor role is required. To create it, sign in to your Azure account and run the following command. You can also run this command in [Azure Cloud Shell](https://shell.azure.com/).

    ```bash
    az login
    az ad sp create-for-rbac -n "<Unique SP Name>" --role contributor
    ```

    For example:

    ```console
    az ad sp create-for-rbac -n "http://AzureArcServers" --role contributor
    ```

    Output should look like this:

    ```json
    {
      "appId": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX",
      "displayName": "AzureArcServers",
      "name": "http://AzureArcServers",
      "password": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX",
      "tenant": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    }
    ```

    > [!NOTE]
    > We highly recommend that you scope the service principal to a specific [Azure subscription and resource group](/cli/azure/ad/sp).

### Preparing an Ubuntu server VMware vSphere VM template

Before using the below guide to deploy an Ubuntu server VM and connect it to Azure Arc, a VMware vSphere template is required. [This article](./vmware-ubuntu-template.md) shows how to easily create such a template using VMware vSphere 6.5 and above.

> [!NOTE]
> If you already have an Ubuntu server VM template, you should still use the guide as a reference.

## Deployment

Before executing the Terraform plan, you must set the environment variables which will be used by the plan. These variables are based on the Azure service principal you've just created, your Azure subscription and tenant, and your VMware vSphere credentials.

1. Retrieve your Azure subscription ID and tenant ID using the `az account list` command.

2. The Terraform plan creates resources in both Microsoft Azure and VMware vSphere. It then executes a script on the virtual machine to install the Azure Arc agent and all necessary artifacts. This script requires certain information about your VMware vSphere and Azure environments. Edit [`scripts/vars.sh`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/ubuntu/terraform/scripts/vars.sh) and update each of the variables with the appropriate values.

    - `TF_VAR_subscription_id` = Your Azure subscription ID
    - `TF_VAR_client_id` = Your Azure service principal name
    - `TF_VAR_client_secret`= Your Azure service principal password
    - `TF_VAR_tenant_id` = Your Azure tenant ID
    - `TF_VAR_resourceGroup` = Azure resource group name
    - `TF_VAR_location` = Azure region
    - `TF_VAR_vsphere_user` = vCenter admin username
    - `TF_VAR_vsphere_password` = vCenter admin password
    - `TF_VAR_vsphere_server` = vCenter server FQDN/IP
    - `TF_VAR_admin_user` =OS admin username
    - `TF_VAR_admin_password` = OS admin password

3. From CLI, navigate to the `azure_arc_servers_jumpstart/vmware/ubuntu/terraform` directory of the cloned repo.

4. Export the environment variables you edited by running [`scripts/vars.sh`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/ubuntu/terraform/scripts/vars.sh) with the source command as shown below. Terraform requires these to be set for the plan to execute properly. Note that this script will also be automatically executed remotely on the virtual machine as part of the Terraform deployment.

    `source ./scripts/vars.sh`

5. In addition to the `TF_VAR` environment variables you've just exported, edit the Terraform variables in the [`terraform.tfvars`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/ubuntu/terraform/terraform.tfvars) to match your VMware vSphere environment.

    ![A screenshot of the `TF_VAR` environment variables](./media/vmware-terraform-ubuntu/variables.png)

6. Run the `terraform init` command which will download the Terraform AzureRM, local, and vSphere providers.

    ![A screenshot of the `terraform init` command.](./media/vmware-terraform-ubuntu/terraform-init.png)

7. Run the `terraform apply --auto-approve` command and wait for the plan to finish.

8. Once the Terraform deployment is completed, a new Ubuntu server VM will be up and running and will be projected as an Azure Arc enabled server resource in a newly created Azure resource group.

    ![A screenshot of `terraform apply` completed.](./media/vmware-terraform-ubuntu/terraform-apply.png)

    ![A screenshot of a new VMware vSphere Ubuntu server virtual machine.](./media/vmware-terraform-ubuntu/new-vm.png)

    ![A screenshot of an Azure Arc enabled server in an Azure resource group.](./media/vmware-terraform-ubuntu/server-1.png)

    ![Another screenshot of an Azure Arc enabled server in an Azure resource group.](./media/vmware-terraform-ubuntu/server-2.png)

## Delete the deployment

- The most straightforward way is to delete the Azure Arc resource via the Azure portal, just select the resource and delete it. In addition, delete the VMware vSphere VM.

  ![A screenshot of an Azure Arc enabled server being deleted.](./media/vmware-terraform-ubuntu/delete-server.png)

  If you delete the instance manually, then you should also delete `install_arc_agent.sh`, which is created by the Terraform plan.

- If you want to tear down the entire environment, use the `terraform destroy --auto-approve` command as shown below.

  ![A screenshot of the `terraform destroy` command.](./media/vmware-terraform-ubuntu/terraform-destroy.png)
