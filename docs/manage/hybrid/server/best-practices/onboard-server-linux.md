---
title: Connect an existing Linux server to Azure Arc
description: Connect an existing Linux server to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

# Connect an existing Linux server to Azure Arc

This article provides guidance for connecting a Linux server to Azure Arc using a simple shell script.

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

3. Create a new Azure resource group for your servers.

    ![A screenshot of the Azure portal with an empty resource group.](./media/onboard-server/linux-resource-group.png)

4. Download the [`az_connect_linux`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/scripts/az_connect_linux.sh) shell script.

5. Change the environment variables according to your environment.

    ![A screenshot of the environment variables to be changed.](./media/onboard-server/linux-variables.png)

6. Copy the script to the designated server using your preferred tool of choice (or copy/paste the script to a new file inside the server). The following example shows how to copy the script from macOS to the server using `scp`.

    ![A screenshot of the `scp` script.](./media/onboard-server/linux-scp.png)

## Deployment

Run the script using the `. ./az_connect_linux.sh` command.

> [!NOTE]
> The extra dot is because the script has an *export* function and needs to have the vars exported in the same shell session as the rest of the commands.

Upon successful completion, you will have your Linux server, connected as a new Azure Arc resource inside your resource group.

![A screenshot of the `az_connect_linux.sh` Linux script running.](./media/onboard-server/az-connect-linux.png)

![A screenshot of an Azure Arc enabled resource in the Azure portal.](./media/onboard-server/linux-resource.png)

![A screenshot of details from an Azure Arc enabled resource in the Azure portal.](./media/onboard-server/linux-resource-detail.png)

## Delete the deployment

To delete the server, select the server and delete it from the Azure portal.

![A screenshot of the option to delete a resource in the Azure portal.](./media/onboard-server/linux-delete-resource.png)

To delete the entire deployment, delete the Azure resource group from the Azure portal.

![A screenshot of the option to delete a resource group via the Azure portal.](./media/onboard-server/linux-delete-resource-group.png)
