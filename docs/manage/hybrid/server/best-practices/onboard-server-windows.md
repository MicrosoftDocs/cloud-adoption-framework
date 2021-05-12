---
title: Connect an existing Windows Server instance to Azure Arc
description: Connect an existing Windows Server instance to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

# Connect an existing Windows Server instance to Azure Arc

This article provides guidance for connecting a Windows machine to Azure Arc using a simple PowerShell script.

## Prerequisites

1. [Install or update Azure CLI to version 2.7 and above](/cli/azure/install-azure-cli). Use the following command to check your current installed version.

    ```console
    az --version
    ```

2. Create an Azure service principal.

    To connect a server to Azure Arc, an Azure service principal assigned with the Contributor role is required. To create it, sign in to your Azure account and run the following command. You can also run this command in [Azure Cloud Shell](https://shell.azure.com/).

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

3. Create a new Azure resource group for your machines.

    ![A screenshot of an empty resource group in the Azure portal.](./media/onboard-server/windows-resource-group.png)

4. Download the [`az_connect_win.ps1`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/scripts/az_connect_win.ps1) PowerShell script.

5. Change the environment variables according to your environment and copy the script to the designated machine.

    ![A screenshot of the environment variables to be changed.](./media/onboard-server/windows-variables.png)

## Deployment

On the designated machine, open PowerShell ISE **as Administrator** and run the script. Note the script is using `$env:ProgramFiles` as the agent installation path, so **ensure you are not using PowerShell ISE (x86)**.

![A screenshot of the `azcmagent connect` command.](./media/onboard-server/azcmagent.png)

![A screenshot of the `az_connect_win.ps1` Windows script.](./media/onboard-server/az-connect-windows-2.png)

Upon completion, you will have your Windows Server instance, connected as a new Azure Arc resource inside your resource group.

![A screenshot of the `az_connect_win.ps1` Windows script running.](./media/onboard-server/az-connect-windows.png)

![A screenshot of an Azure Arc enabled resource in the Azure portal.](./media/onboard-server/windows-resource.png)

![A screenshot of details from an Azure Arc enabled resource in the Azure portal.](./media/onboard-server/windows-resource-detail.png)

## Delete the deployment

To delete the server, select the server and delete it from the Azure portal.

![A screenshot of the option to delete a resource in the Azure portal.](./media/onboard-server/windows-delete-resource.png)

To delete the entire deployment, delete the Azure resource group from the Azure portal.

![A screenshot of the option to delete a resource group via the Azure portal.](./media/onboard-server/windows-delete-resource-group.png)
