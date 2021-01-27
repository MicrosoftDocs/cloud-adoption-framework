---
title: Connect an existing Linux server to Azure Arc
description: Connect an existing Linux server to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: think-tank
---

# Connect an existing Linux server to Azure Arc

The following README will guide you on how to connect an Linux server to Azure Arc using a simple shell script.

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

* Create a new Azure resource group where you want your server(s) to show up.

    ![A screenshot of the Azure portal with an empty resource group.](./img/onboard-server-linux/linux-resource-group.png)

* Download the [az-connect-linux](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/scripts/az-connect-linux.sh) shell script.

* Change the environment variables according to your environment.

    ![A screenshot of the environment variables to be changed.](./img/onboard-server-linux/linux-variables.png)

* Copy the script to the designated server using your preferred tool of choice (or copy/paste the script to a new file inside the server). Below example shows copy the script from MacOS to the server using SCP.

    ![A screenshot of the 'scp' script.](./img/onboard-server-linux/linux-scp.png)

## Deployment

Run the script using the ```. ./az-connect-linux.sh``` command.

> **Note: The extra dot is due to the script has an *export* function and needs to have the vars exported in the same shell session as the rest of the commands.**

Upon completion, you will have your Linux server, connected as a new Azure Arc resource inside your resource group.

![A screenshot of the 'az_connect' Linux script running.](./img/onboard-server-linux/az-connect-linux.png)

![A screenshot of an Azure-arc-enabled resource in the Azure portal.](./img/onboard-server-linux/linux-resource.png)

![A screenshot of details from an Azure-arc-enabled resource in the Azure portal.](./img/onboard-server-linux/linux-resource-detail.png)

## Delete the deployment

The most straightforward way is to delete the server via the Azure portal, just select server and delete it.

![A screenshot of Delete option to delete a resource in the Azure portal.](./img/onboard-server-linux/linux-delete-resource.png)

If you want to nuke the entire environment, just delete the Azure resource group.

![[A screenshot of the Delete option to delete a resource group in the Azure portal.](./img/onboard-server-linux/linux-delete-resource-group.png)
