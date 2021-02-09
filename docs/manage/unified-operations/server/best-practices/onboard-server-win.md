---
title: Connect an existing Windows Server instance to Azure Arc
description: Connect an existing Windows Server instance to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: think-tank, e2e-hybrid
---

# Connect an existing Windows Server instance to Azure Arc

The following README will guide you through how to connect a Windows machine to Azure Arc using a simple PowerShell script.

## Prerequisites

- [Install or update Azure CLI to version 2.7 and above](/cli/azure/install-azure-cli). Use the following command to check your current installed version.

  ```console
  az --version
  ```

- Create an Azure service principal.

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

- Create a new Azure resource group for your machines.

    ![A screenshot of an empty resource group in the Azure portal.](./img/onboard-server-win/win-resource-group.png)

- Download the [`az-connect-win`](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/scripts/az-connect-win.ps1) PowerShell script.

- Change the environment variables according to your environment and copy the script to the designated machine.

    ![A screenshot of the environment variables to be changed.](./img/onboard-server-win/win-variables.png)

## Deployment

On the designated machine, open PowerShell ISE **as Administrator** and run the script. Note the script is using `$env:ProgramFiles` as the agent installation path, so **ensure you are not using PowerShell ISE (x86)**.

![A screenshot of the `azcmagent connect` command.](./img/onboard-server-win/azcmagent.png)

![A screenshot of the `az-connect` Windows script.](./img/onboard-server-win/az-connect-win-2.png)

Upon completion, you will have your Windows Server instance, connected as a new Azure Arc resource inside your resource group.

![A screenshot of the 'az_connect' Windows script running.](./img/onboard-server-win/az-connect-win.png)

![[A screenshot of an Azure Arc enabled resource in the Azure portal.](./img/onboard-server-win/win-resource.png)

![A screenshot of details from an Azure Arc enabled resource in the Azure portal.](./img/onboard-server-win/win-resource-detail.png)

## Delete the deployment

T0 delete the server, select the server and delete it from the Azure portal.

![A screenshot of Delete option to delete a resource in the Azure portal.](./img/onboard-server-win/win-delete-resource.png)

To delete the entire deployment, delete the Azure resource group from the Azure portal.

![A screenshot of the option to delete a resource group via the Azure portal.](./img/onboard-server-win/win-delete-resource-group.png)
