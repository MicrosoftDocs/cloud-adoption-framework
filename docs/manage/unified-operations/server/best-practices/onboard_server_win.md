---
title: Connect an existing Windows server to Azure Arc
description: Learn to configure unified operations for XYZ.
author: likamrat
ms.author: brblanch
ms.date: 01/18/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Connect an existing Windows server to Azure Arc

The following README will guide you on how to connect an Windows machine to Azure Arc using a simple PowerShell script.

## Prerequisites

* [Install or update Azure CLI to version 2.7 and above](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest). Use the below command to check your current installed version.

  ```console
  az --version
  ```

* Create Azure service principal (SP)

    To connect a server to Azure Arc, an Azure service principal assigned with the "Contributor" role is required. To create it, login to your Azure account run the below command (this can also be done in [Azure Cloud Shell](https://shell.azure.com/)).

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

    > **Note: It is optional but highly recommended to scope the SP to a specific [Azure subscription and resource group](https://docs.microsoft.com/cli/azure/ad/sp?view=azure-cli-latest)**

* Create a new Azure resource group where you want your machine(s) to show up.

    ![Screenshot showing the Azure portal with an empty resource group.](./img/onboard-server-win/onboard-server-win/win-resource-group.png)

* Download the [az_connect_win](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/scripts/az_connect_win.ps1) PowerShell script.

* Change the environment variables according to your environment and copy the script to the designated machine.

    ![A screenshot of the the environment variables to be changed.](./img/onboard-server-win/win-variables.png)

## Deployment

On the designated machine, Open PowerShell ISE **as Administrator** and run the script. Note the script is using *$env:ProgramFiles* as the agent installation path so make sure **you are not using PowerShell ISE (x86)**.

![A screenshot of the 'azcmagent' connect command.](./img/onboard-server-win/azcmagent.png)

![A screenshot of the 'az_connect' Windows script.](./img/onboard-server-win/az-connect-win-2.png)

Upon completion, you will have your Windows server, connected as a new Azure Arc resource inside your resource group.

![A screenshot of the the 'az_connect' Windows script running.](./img/onboard-server-win/az-connect-win.png)

![[A screenshot of an Azure-arc-enabled resource in the Azure portal.](./img/onboard-server-win/win-resource.png)

![A screenshot of details from an Azure-arc-enabled resource in the Azure portal.](./img/onboard-server-win/win-resource-detail.png)

## Delete the deployment

The most straightforward way is to delete the server via the Azure portal, just select server and delete it.

![A screenshot of Delete option to delete a resource in the Azure portal.](./img/onboard-server-win/windows-delete-resource.png)

If you want to delete the entire environment, just delete the Azure resource group.

![A screenshot of Delete option to delete a resource group in the Azure portal.](./img/onboard-server-win/windows-delete-resource-group.png)
