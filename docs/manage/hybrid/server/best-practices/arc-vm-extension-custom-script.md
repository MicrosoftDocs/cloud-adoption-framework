---
title: Use virtual machine extensions and an Azure Resource Manager template to deploy custom scripts to Azure Arc Linux and Windows servers
description: Learn how to execute custom scripts to Azure Arc enabled servers by using virtual machine extensions that provide post-deployment configuration and automation tasks.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

# Use virtual machine extensions and an Azure Resource Manager template to deploy custom scripts to Azure Arc Linux and Windows servers

This article provides guidance on how to execute custom scripts to Azure Arc enabled servers by using virtual machine extensions. Virtual machine extensions are small applications that provide post-deployment configuration and automation tasks such as software installation, anti-virus protection, or a mechanism to run a custom script.

You can use the Azure portal, Azure CLI, an Azure Resource Manager template (ARM template), PowerShell or Linux shell script, or Azure policies to manage the extension deployment to Azure Arc enabled servers. In the following procedures, you'll use an ARM template to deploy the custom script extension. This extension downloads and executes scripts on virtual machines. It's useful for post deployment configuration, software installation, or any other configuration or management tasks.

> [!IMPORTANT]
> The procedures in this article assumes you've already deployed VMs, or servers that are running on-premises or on other clouds, and you have connected them to Azure Arc. If you haven't, the following information can help you automate this.

- [GCP Ubuntu instance](./gcp-terraform-ubuntu.md)
- [GCP Windows instance](./gcp-terraform-windows.md)
- [AWS Ubuntu EC2 instance](./aws-terraform-ubuntu.md)
- [AWS Amazon Linux 2 EC2 instance](./aws-terraform-al2.md)
- [VMware vSphere Ubuntu VM](./vmware-terraform-ubuntu.md)
- [VMware vSphere Windows Server VM](./vmware-terraform-windows.md)
- [Vagrant Ubuntu box](./local-vagrant-ubuntu.md)
- [Vagrant Windows box](./local-vagrant-windows.md)

## Prerequisites

1. Clone the Azure Arc Jumpstart repository.

    ```console
    git clone https://github.com/microsoft/azure_arc.git
    ```

2. As mentioned previously, this guide starts at the point where you already deployed and connected VMs or servers to Azure Arc. The following screenshots show a GCP server that's been connected with Azure Arc and is visible as a resource in Azure.

    ![A screenshot of a resource group from an Azure Arc enabled server.](./media/arc-vm-extension-custom-script/resource-group.png)

    ![A screenshot of a connected status from an Azure Arc enabled server.](./media/arc-vm-extension-custom-script/connected-status.png)

3. [Install or update Azure CLI](/cli/azure/install-azure-cli). Azure CLI should be running version 2.7 or later. Use `az --version` to check your current installed version.

4. Create an Azure service principal.

    To connect a VM or bare-metal server to Azure Arc, an Azure service principal assigned with the Contributor role is required. To create it, sign in to your Azure account and run the following command. You can also run this command in [Azure Cloud Shell](https://shell.azure.com/).

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

To demonstrate the custom script extension, use the below Linux and Windows scripts.

- [Linux](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/scripts/custom_script_linux.sh): The script will modify the message of the day on the operating system.
- [Windows](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/scripts/custom_script_windows.ps1): The script will install Windows Terminal, Microsoft Edge, 7-Zip, and Visual Studio Code [Chocolatey](https://chocolatey.org/) packages on the VM.

## Azure Arc enabled servers custom script extension deployment

1. Edit the extensions parameters file for [Windows](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/extensions/arm/customscript-templatewindows.parameters.json) or [Linux](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/extensions/arm/customscript-templatelinux.parameters.json)

   ![A screenshot of an ARM template parameters file.](./media/arc-vm-extension-custom-script/parameters-file.png)

2. Provide the following information to match your environment configuration:

    - The VM name as registered in Azure Arc.

    ![A screenshot of a machine name from an Azure Arc enabled server.](./media/arc-vm-extension-custom-script/machine-name.png)

    - The location of the resource group where you registered the Azure Arc enabled server.

    ![A screenshot of an Azure region.](./media/arc-vm-extension-custom-script/azure-region.png)

    - A public URI for the script that you would like to run on the servers, in this case use the URL for the script in raw format.
      - For Windows: [public URI](https://raw.githubusercontent.com/microsoft/azure_arc/main/azure_arc_servers_jumpstart/scripts/custom_script_windows.ps1)
      - For Linux: [public URI](https://raw.githubusercontent.com/microsoft/azure_arc/main/azure_arc_servers_jumpstart/scripts/custom_script_linux.sh)

3. To run either script, use the following commands:

    - Windows:

         ```powershell
         powershell -ExecutionPolicy Unrestricted -File custom_script_windows.ps1
         ```

    - Linux:

         ```bash
         ./custom_script_linux.sh
         ```

4. To deploy the ARM template for Linux or Windows, navigate to the [deployment folder](https://github.com/microsoft/azure_arc/tree/main/azure_arc_servers_jumpstart/extensions/arm) and run the following command with the templates that match your operating system:

    ```azurecli
    az deployment group create --resource-group <Name of the Azure resource group> \
    --template-file <The `customscript-template.json` template file location for Linux or Windows> \
    --parameters <The `customscript-template.parameters.json` template file location>
    ```

5. After the template deployment has completed it's run, you should see an output as follows:

    ![A screenshot of an output from an ARM template.](./media/arc-vm-extension-custom-script/output.png)

6. Verify a successful deployment on the Azure Arc enabled server, in the Azure portal, by selecting **Extensions** settings. You should see the custom script extension installed.

    ![A screenshot of a custom script extension.](./media/arc-vm-extension-custom-script/custom-script-extension.png)

Another way to verify successful custom script execution is by connecting to the VMs and verifying that the operating system has been configured.

- For the Linux VM, use SSH to connect the VM and check out the message of the day which was customized by the script:

  ![A screenshot of an updated daily message.](./media/arc-vm-extension-custom-script/daily-message.png)

- Connect to the Windows VM via RDP and verify that the additional software has been installed: Microsoft Edge, 7-zip, and Visual Studio Code.

  ![A screenshot of additional software installed.](./media/arc-vm-extension-custom-script/additional-software.png)

## Clean up your environment

Complete the following steps to clean up your environment.

Remove the virtual machines from each environment by following the teardown instructions from each guide.

- [GCP Ubuntu instance](./gcp-terraform-ubuntu.md) and [GCP Windows instance](./gcp-terraform-windows.md)
- [AWS Ubuntu EC2 instance](./aws-terraform-ubuntu.md)
- [VMware vSphere Ubuntu VM](./vmware-terraform-ubuntu.md) and [VMware vSphere Windows Server VM](./vmware-terraform-windows.md)
- [Vagrant Ubuntu box](./local-vagrant-ubuntu.md) and [Vagrant Windows box](./local-vagrant-windows.md)
