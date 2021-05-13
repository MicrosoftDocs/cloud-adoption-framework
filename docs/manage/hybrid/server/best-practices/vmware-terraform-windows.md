---
title: Use a Terraform plan to deploy a VMware Windows virtual machine and connect it to Azure Arc
description: Use a Terraform plan to deploy a VMware Windows virtual machine and connect it to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

# Use a Terraform plan to deploy a VMware Windows virtual machine and connect it to Azure Arc

This article provides guidance for using the provided [Terraform](https://www.terraform.io/) plan to deploy a Windows Server, VMware vSphere virtual machine and connect it as an Azure Arc enabled server resource.

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

    ```console
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

### Prepare a Windows Server VMware vSphere VM template

Before using this guidance to deploy a Windows Server VM and connect it to Azure Arc, a VMware vSphere template is required. You can [easily create such a template using VMware vSphere 6.5 and above](./vmware-windows-template.md).

**The Terraform plan used the `remote-exec` provisioner which uses the WinRM protocol to copy and execute the required Azure Arc script. To allow WinRM connectivity to the VM, run the [`allow_winrm`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/winsrv/terraform/scripts/allow_winrm.ps1) PowerShell script on your VM before converting it to template.**

> [!NOTE]
> If you already have a Windows Server VM template, you should still use the guide as a reference.

## Deployment

Before executing the Terraform plan, you must set the environment variables which will be used by the plan. These variables are based on the Azure service principal you've just created, your Azure subscription and tenant, and your VMware vSphere credentials.

1. Retrieve your Azure subscription ID and tenant ID using the `az account list` command.

2. The Terraform plan creates resources in both Microsoft Azure and VMware vSphere. It then executes a script on the virtual machine to install the Azure Arc agent and all necessary artifacts. This script requires certain information about your VMware vSphere and Azure environments. Edit [`scripts/vars.sh`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/winsrv/terraform/scripts/vars.sh) and update each of the variables with the appropriate values.

    - `TF_VAR_subscription_id` = Your Azure subscription ID
    - `TF_VAR_client_id` = Your Azure service principal name
    - `TF_VAR_client_secret` = Your Azure service principal password
    - `TF_VAR_tenant_id` = Your Azure tenant ID
    - `TF_VAR_resourceGroup` = Azure resource group name
    - `TF_VAR_location` = Azure Region
    - `TF_VAR_vsphere_user` = vCenter Admin Username
    - `TF_VAR_vsphere_password` = vCenter Admin Password
    - `TF_VAR_vsphere_server` = vCenter server FQDN/IP
    - `TF_VAR_admin_user` = OS Admin Username
    - `TF_VAR_admin_password` = OS Admin Password

3. From CLI, navigate to the `azure_arc_servers_jumpstart/vmware/winsrv/terraform` directory of the cloned repo.

4. Export the environment variables you edited by running [`scripts/vars.sh`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/winsrv/terraform/scripts/vars.sh) with the source command as shown below. Terraform requires these to be set for the plan to execute properly. Note that this script will also be automatically executed remotely on the virtual machine as part of the Terraform deployment.

    ```console
    source ./scripts/vars.sh
    ```

5. In addition to the `TF_VAR` environment variables you've just exported, edit the Terraform variables in the [`terraform.tfvars`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/winsrv/terraform/terraform.tfvars) to match your VMware vSphere environment.

    ![A screenshot of the `TF_VAR` environment variables](./media/vmware-terraform-windows/windows-variables.png)

6. Run the `terraform init` command which will download the Terraform AzureRM, local and vSphere providers.

    ![A screenshot of the `terraform init` command.](./media/vmware-terraform-windows/terraform-init.png)

7. Run the `terraform apply --auto-approve` command and wait for the plan to finish. Once the Terraform deployment is completed, a new Windows Server VM will be up and running and will be projected as an Azure Arc server resource in a newly created Azure resource group.

    ![A screenshot of `terraform apply` completed.](./media/vmware-terraform-windows/terraform-apply.png)

    ![A screenshot of a new VMware vSphere Windows Server virtual machine.](./media/vmware-terraform-windows/new-vm.png)

    ![A screenshot of an Azure Arc enabled server in an Azure resource group.](./media/vmware-terraform-windows/server-1.png)

    ![Another screenshot of an Azure Arc enabled server in an Azure resource group.](./media/vmware-terraform-windows/server-2.png)

## Delete the deployment

- The most straightforward way is to delete the Azure Arc resource via the Azure portal, just select the resource and delete it. In addition, delete the VMware vSphere VM.

    ![A screenshot of an Azure Arc enabled server being deleted.](./media/vmware-terraform-windows/delete-server.png)

- If you delete the instance manually, then you should also delete `install_arc_agent.ps1`, which is created by the Terraform plan.

- If you want to tear down the entire environment, use the `terraform destroy --auto-approve` command as shown below.

    ![A screenshot of the `terraform destroy` command.](./media/vmware-terraform-windows/terraform-destroy.png)
