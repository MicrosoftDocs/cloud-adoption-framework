---
title: Use an Azure Resource Manager template to deploy and connect an Azure Virtual Machine to Azure Arc
description: Use an Azure Resource Manager template to deploy and connect an Azure Virtual Machine to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: think-tank, e2e-hybrid
---

# Use an Azure Resource Manager template to deploy and connect an Azure Virtual Machine to Azure Arc

The following README will guide you on how to use an [Azure Resource Manager template (ARM template)](https://docs.microsoft.com/azure/azure-resource-manager/templates/overview) to automatically onboard an Azure Windows Virtual Machine (Azure VM) to Azure Arc. The provided ARM template is responsible for creating the Azure resources and executing the Azure Arc onboard script on the VM.

Azure VMs are using the [Azure Instance Metadata Service (IMDS)](https://docs.microsoft.com/azure/virtual-machines/windows/instance-metadata-service) by default. By projecting an Azure VM as an Azure-Arc-enabled server, a "conflict" is created, which will not allow for the Azure Arc server resources to be represented as one when the IMDS is being used. Instead, the Azure Arc server will still "act" as a native Azure VM.

This guide will allow you to use and onboard Azure VMs to Azure Arc **for demo purposes only**. You will have the ability to simulate a server deployed outside of Azure, for example, "on-premises" or in other cloud platforms.

> **Note: It is not expected for an Azure VM to be projected as an Azure-Arc-enabled server. The below scenario is unsupported and should ONLY be used for demo and testing purposes.**

## Prerequisites

* Clone the Azure Arc Jumpstart repository

    ```console
    git clone https://github.com/microsoft/azure-arc.git
    ```

* [Install or update Azure CLI to version 2.7 and above](https://docs.microsoft.com/cli/azure/install-azure-cli). Use the below command to check your current installed version.

  ```console
  az --version
  ```

* Azure Subscription: If you don't have an Azure subscription, you can [Create a free Azure account](https://azure.microsoft.com/free/).

* Create an Azure service principal (SP)

    In order for you to deploy the Azure resources using the ARM template, an Azure service principal assigned with the "Contributor" role is required. To create it, login to your Azure account and run the below command (this step can also be done in [Azure Cloud Shell](https://shell.azure.com/)).

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

    > **Note: It is optional, but highly recommended, to scope the SP to a specific [Azure subscription and resource group](https://docs.microsoft.com/cli/azure/ad/sp).**

## Automation Flow

For you to get familiar with the automation and deployment flow, below is an explanation.

1. A user edits the ARM template parameters file (one time edit). These parameter values are being used throughout the deployment.

2. The ARM template includes an Azure VM custom script extension, which will deploy the [*install-arc-agent.ps1*](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/azure/windows/arm-template/scripts/install-arc-agent.ps1) PowerShell script.

3. In order to allow the Azure VM to successfully be projected as an Azure-Arc-enabled server, the script will:

    1. Set local OS environment variables.

    2. Generate a local OS logon script named *LogonScript.ps1*. This script will:

        * Create the *LogonScript.log* file.

        * Stop and disable the "Windows Azure Guest Agent" service.

        * Create a new Windows Firewall rule to block Azure IMDS outbound traffic to the *169.254.169.254* remote address.

        * Unregister the logon script Windows schedule task so it will not run after first login.

    3. Disable and prevent Windows Server Manager from running on startup.

4. A user will RDP to the Windows VM, which will start the *LogonScript* script execution and will onboard the VM to Azure Arc.

## Deployment

As mentioned, this deployment will use ARM templates. You will deploy a single template, responsible for creating all the Azure resources in a single resource group and onboarding the created VM to Azure Arc.

* Before deploying the ARM template, login to Azure using Azure CLI with the ```az login``` command.

* The deployment is using the ARM template parameters file. Before initiating the deployment, edit the [*azuredeploy.parameters.json*](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/azure/windows/arm-template/azuredeploy.parameters.json) file located in your local cloned repository folder. An example parameters file is located [here](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/azure/windows/arm-template/azuredeploy.parameters.example.json).

* To deploy the ARM template, navigate to the local cloned [deployment folder](https://github.com/microsoft/azure-arc/tree/main/azure-arc-servers-jumpstart/azure/windows/arm-template) and run the below command:

    ```console
    az group create --name <Name of the Azure resource group> --location <Azure Region> --tags "Project=jumpstart-azure-arc-servers"
    az deployment group create \
    --resource-group <Name of the Azure resource group> \
    --name <The name of this deployment> \
    --template-uri https://raw.githubusercontent.com/microsoft/azure-arc/main/azure-arc-servers-jumpstart/azure/windows/arm-template/azuredeploy.json \
    --parameters <The *azuredeploy.parameters.json* parameters file location>
    ```

    > **Note: Make sure that you are using the same Azure resource group name as the one you used in the *azuredeploy.parameters.json* file**

    For example:

    ```console
    az group create --name Arc-Servers-Win-Demo --location "East US" --tags "Project=jumpstart-azure-arc-servers"
    az deployment group create \
    --resource-group Arc-Servers-Win-Demo \
    --name arcwinsrvdemo \
    --template-uri https://raw.githubusercontent.com/microsoft/azure-arc/main/azure-arc-servers-jumpstart/azure/windows/arm-template/azuredeploy.json \
    --parameters azuredeploy.parameters.json
    ```

* Once the Azure resources have been provisioned, you will see them in Azure portal.

    ![A screenshot of an output from an ARM template.](./img/arm-template-win/template-win-output.png)

    ![A screenshot resources in the resource group.](./img/arm-template-win/template-win-resources.png)

## Windows Login & Post Deployment

* Now that the Windows Server VM is created, the next step is to connect to it. Using its public IP address, RDP to the VM.

    ![A screenshot of an Azure VM public IP address.](./img/arm-template-win/template-win-ip.png)

* Upon first login, as mentioned in the "Automation Flow" section, a logon script will get executed. This script was created as part of the automated deployment process.

* Let the script run and **do not close** the PowerShell session. The session will close for you automatically once completed.

    > **Note: The script run time is ~1-2 minutes long.**

    ![A screenshot of one type of script output.](./img/arm-template-win/template-win-script-1.png)

    ![A screenshot of a second type of script output.](./img/arm-template-win/template-win-script-2.png)

    ![A screenshot of a third type of script output.](./img/arm-template-win/template-win-script-3.png)

    ![A screenshot of a fourth type of script output.](./img/arm-template-win/template-win-script-4.png)

* Upon successful completion, a new Azure-Arc-enabled server will be added to the resource group.

![A screenshot of a resource group from an Azure-Arc-enabled server.](./img/arm-template-win/template-win-resource-gp.png)

![A screenshot of details from an Azure-Arc-enabled server.](./img/arm-template-win/template-win-server-details.png)

## Cleanup

To delete the entire deployment, delete the resource group from the Azure portal.

![A screenshot of how to delete the resource group.](./img/arm-template-win/template-win-delete.png)
