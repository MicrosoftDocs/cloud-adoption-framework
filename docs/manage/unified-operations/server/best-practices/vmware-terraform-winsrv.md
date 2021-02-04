---
title: Use a terraform plan to deploy a VMware Windows virtual machine and connect it to Azure Arc
description: Use a terraform plan to deploy a VMware Windows virtual machine and connect it to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: think-tank, e2e-hybrid
---

# Use a terraform plan to deploy a VMware Windows virtual machine and connect it to Azure Arc

The following README will guide you on how to use the provided [Terraform](https://www.terraform.io/) plan to deploy a Windows Server, VMware vSphere virtual machine and connect it as an Azure-Arc-enabled server resource.

## Prerequisites

* Clone the Azure Arc Jumpstart repository

    ```console
    git clone https://github.com/microsoft/azure-arc.git
    ```

* [Install or update Azure CLI to version 2.7 and above](https://docs.microsoft.com/cli/azure/install-azure-cli). Use the below command to check your current installed version.

  ```console
  az --version
  ```

* [Install Terraform >=0.12](https://learn.hashicorp.com/terraform/getting-started/install.html)

* A VMware vCenter Server user with [permissions to deploy](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.vm-admin.doc/GUID-8254CD05-CC06-491D-BA56-A773A32A8130.html) a Virtual Machine from a Template in the vSphere Web Client.

* Create Azure service principal (SP)

    To connect the VMware vSphere virtual machine to Azure Arc, an Azure service principal assigned with the "Contributor" role is required. To create it, login to your Azure account run the below command (this can also be done in [Azure Cloud Shell](https://shell.azure.com/)).

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

    > **Note: It is optional but highly recommended to scope the SP to a specific [Azure subscription and resource group](https://docs.microsoft.com/cli/azure/ad/sp)**

### Preparing a Window Server VMware vSphere VM Template

Before using the below guide to deploy a Windows Server VM and connect it to Azure Arc, a VMware vSphere Template is required. [The following README](./vmware-winsrv2k19-template.md) will instruct you how to easily create such a template using VMware vSphere 6.5 and above.

**The Terraform plan leveraged the *remote-exec* provisioner which uses the WinRM protocol to copy and execute the required Azure Arc script. To allow WinRM connectivity to the VM, run the [*allow-winrm*](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/vmware/winsrv/terraform/scripts/allow-winrm.ps1) PowerShell script on your VM before converting it to template.**

> **Note: If you already have a Windows Server VM template it is still recommended to use the guide as a reference.**

## Deployment

Before executing the Terraform plan, you must set the environment variables which will be used by the plan. These variables are based on the Azure service principal you've just created, your Azure subscription and tenant, and your VMware vSphere credentials.

* Retrieve your Azure subscription ID and tenant ID using the ```az account list``` command.

* The Terraform plan creates resources in both Microsoft Azure and VMware vSphere. It then executes a script on the virtual machine to install the Azure Arc agent and all necessary artifacts. This script requires certain information about your VMware vSphere and Azure environments. Edit [*scripts/vars.sh*](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/vmware/winsrv/terraform/scripts/vars.sh) and update each of the variables with the appropriate values.

  * TF-VAR-subscription-id=Your Azure subscription ID
  * TF-VAR-client-id=Your Azure service principal name
  * TF-VAR-client-secret=Your Azure service principal password
  * TF-VAR-tenant-id=Your Azure tenant ID
  * TF-VAR-resourceGroup=Azure resource group name
  * TF-VAR-location=Azure Region
  * TF-VAR-vsphere-user=vCenter Admin Username
  * TF-VAR-vsphere-password=vCenter Admin Password
  * TF-VAR-vsphere-server=vCenter server FQDN/IP
  * TF-VAR-admin-user=OS Admin Username
  * TF-VAR-admin-password=OS Admin Password

* From CLI, navigate to the *azure-arc-servers-jumpstart/vmware/winsrv/terraform* directory of the cloned repo.

* Export the environment variables you edited by running [*scripts/vars.sh*](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/vmware/winsrv/terraform/scripts/vars.sh) with the source command as shown below. Terraform requires these to be set for the plan to execute properly. Note that this script will also be automatically executed remotely on the virtual machine as part of the Terraform deployment.

    ```console
    source ./scripts/vars.sh
    ```

* In addition to the *TF-VAR* environment variables you've just exported, edit the Terraform variables in the [*terraform.tfvars*](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/vmware/winsrv/terraform/terraform.tfvars) to match your VMware vSphere environment.

    ![A screenshot of TF-VAR environment variables](./img/vmware-terraform-winsrv/winsrv-variables.png)

* Run the ```terraform init``` command which will download the Terraform AzureRM, Local and vSphere providers.

    ![A screenshot of the 'terraform init' command.](./img/vmware-terraform-winsrv/terraform-init.png)

* Run the ```terraform apply --auto-approve``` command and wait for the plan to finish.Once the Terraform deployment is completed, a new Windows Server VM will be up & running and will be projected as an Azure Arc server resource in a newly created Azure resource group.

    ![A screenshot of 'terraform apply' completed.](./img/vmware-terraform-winsrv/terraform-apply.png)

    ![A screenshot of a new VMware vSphere Windows Server virtual machine.](./img/vmware-terraform-winsrv/new-vm.png)

    ![A screenshot of an Azure-Arc-enabled server in an Azure resource group.](./img/vmware-terraform-winsrv/server-1.png)

    ![Another screenshot of an Azure-Arc-enabled server in an Azure resource group.](./img/vmware-terraform-winsrv/server-2.png)

## Delete the deployment

* The most straightforward way is to delete the Azure Arc resource via the Azure portal, just select the resource and delete it. In addition, delete the VMware vSphere VM.

    ![A screenshot of an Azure-Arc-enabled server being deleted.](./img/vmware-terraform-winsrv/delete-server.png)

* If you delete the instance manually, then you should also delete *install-arc-agent.ps1*  which is created by the Terraform plan.

* If you want to nuke the entire environment use the ```terraform destroy --auto-approve``` command as shown below.

    ![A screenshot of the 'terraform destroy' command.](./img/vmware-terraform-winsrv/terraform-destroy.png)
