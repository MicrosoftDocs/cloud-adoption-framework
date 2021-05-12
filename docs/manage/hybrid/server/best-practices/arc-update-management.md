---
title: Use Update Management in Azure Automation to manage operating system updates for Azure Arc enabled servers
description: Learn how to onboard Azure Arc enabled servers to Update Management in Azure Automation.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

# Use Update Management in Azure Automation to manage operating system updates for Azure Arc enabled servers

This article provides guidance on how to onboard Azure Arc enabled servers to [Update Management in Azure Automation](/azure/automation/update-management/overview), so that you can manage operating system updates for your Azure Arc enabled servers running Windows or Linux.

In the following procedures you create and configure an Azure Automation account and Log Analytics workspace to support Update Management for Azure Arc enabled servers by doing the following:

- Setting up a new Log Analytics workspace and Azure Automation account.
- Enabling Update Management on Azure Arc enabled servers.

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
    git clone https://github.com/microsoft/azure_arc
    ```

2. As mentioned, this guide starts at the point where you already deployed and connected VMs or bare-metal servers to Azure Arc. For this scenario, we use an Amazon Web Services (AWS) EC2 instance that is already connected to Azure Arc and is visible as a resource in Azure.

    ![A screenshot of an EC2 in an Amazon Web Services cloud console.](./media/arc-update-management/aws-ec2-instance.png)

    ![A screenshot of an Azure Arc enabled server in the Azure portal.](./media/arc-update-management/arc-enabled-server.png)

3. [Install or update Azure CLI](/cli/azure/install-azure-cli). Azure CLI should be running version 2.14 or later. Use `az --version` to check your current installed version.

## Configure Update Management

Update Management uses the Log Analytics agent to collect Windows and Linux server log files and the data collected is stored in a Log Analytics workspace.

1. Create a Log Analytics workspace using this [Azure Resource Manager template (ARM template)](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/updateManagement/law-template.json). This creates a new Log Analytics workspace, defines the Update Management solution, and enables it for the workspace.

2. Create a new resource group for the Log Analytics workspace by running the following command, replacing the values in brackets with your own.

    ```console
    az group create --name <Name for your resource group> \
    --location <Location for your resources> \
    --tags "Project=jumpstart_azure_arc_servers"
    ```

    ![A screenshot of the `az group create` command.](./media/arc-update-management/az-group-create.png)

3. Edit the ARM template [parameters file](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/updateManagement/law-template.parameters.json), providing a name for your Log Analytics workspace, a location, and a name for your Azure Automation account. You also need to supply the name of your Azure Arc enabled server, and the name of the resource group that contains the Azure Arc enabled server as shown in the following example:

    ![A screenshot of an ARM template.](./media/arc-update-management/arm-template.png)

4. Deploy the ARM template. Go to the [deployment folder](https://github.com/microsoft/azure_arc/tree/main/azure_arc_servers_jumpstart/updateManagement) and run the following command:

    ```console
    az deployment group create --resource-group <Name of the Azure resource group you created> \
        --template-file law-template.json \
        --parameters law-template.parameters.json
    ```

   ![A screenshot of the `az deployment group` command.](./media/arc-update-management/az-deployment-group.png)

5. When the deployment is complete, you should see the resource group with your Log Analytics workspace, Automation account and Update Management solution from the Azure portal. If you drill in to the Log Analytics workspace **Solutions** tab, you should see the **Update Management** solution.

    ![A screenshot of a Log Analytics workspace in the Azure portal.](./media/arc-update-management/log-analytics-workspace.png)

## Confirm that the Update Management solution is deployed on your Azure Arc enabled server

1. Click on **Solutions** in the Log Analytics workspace, and then select the **Updates** solution from the list to check the progress of the Update Management assessment.

    ![A screenshot of Solutions tab of a Log Analytics workspace.](./media/arc-update-management/solutions-tab.png)

   It may take several hours for Update Management to collect enough data to show an assessment for your VM. On the next page, you can see that the assessment is being performed.

   ![A screenshot of the Overview tab and Updates view within a Log Analytics workspace.](./media/arc-update-management/overview-tab.png)

   When the assessment is complete, you'll see a **View Summary** option on the Update Management tab.

   ![A screenshot of an Updates view summary within a Log Analytics workspace.](./media/arc-update-management/updates-summary.png)

2. Select **View Summary**, and then select again to drill into the Update Management assessment. In the following example we can see there are updates missing on our Azure Arc enabled server.

    ![A screenshot of updates missing from an Azure Arc enabled server.](./media/arc-update-management/updates-missing.png)

## Schedule an update

Now that we have configured the Update Management solution, you can deploy updates on a set schedule for our Azure Arc enabled server.

1. Navigate to the Automation account we created previously, and select the Update Management tab as shown in the following screenshot. You should see your Azure Arc enabled server listed.

    ![A screenshot of an Azure Automation account.](./media/arc-update-management/azure-automation-account.png)

1. Select **Schedule update deployment**. On the next page, select the operating system that your Azure Arc enabled server is using, and then select **Machines to update** as shown in the following screenshot.

    ![A screenshot of scheduling an update with Update Deployment.](./media/arc-update-management/schedule-an-update.png)

1. From the **Type** dropdown, select **Machines**, and then select your server and select **OK**.

    ![A screenshot of the type and server selected for a scheduled update with Update Deployment.](./media/arc-update-management/type-update.png)

1. Click **Schedule Settings** and then provide a desired schedule.

    ![A screenshot of the field to configure Schedule settings within Update Deployment.](./media/arc-update-management/config-schedule-settings.png)

    ![A screenshot of the fields for Schedule settings within Update Deployment.](./media/arc-update-management/schedule-settings.png)

1. Finally, provide a name for your deployment, and then select **Create**.

    ![A screenshot of naming an update within Update Deployment.](./media/arc-update-management/naming-update.png)

1. From the Automation account Update Management tab, you should be able to see your scheduled update deployment from the **Deployment Schedules** tab.

    ![A screenshot of a scheduled update within Update management.](./media/arc-update-management/scheduled-update.png)

This Update Management solution will update your Azure Arc enabled servers in the deployment window based on the schedule you defined. There's a lot more you can do with [Update Management](/azure/automation/update-management/overview) that is outside the scope of this scenario. Review the [documentation](/azure/automation/update-management/overview) for more information.

## Clean up your environment

Complete the following steps to clean up your environment.

1. Remove the virtual machines from each environment by following the teardown instructions from each guide.

    - [GCP Ubuntu instance](./gcp-terraform-ubuntu.md) and [GCP Windows instance](./gcp-terraform-windows.md)
    - [AWS Ubuntu EC2 instance](./aws-terraform-ubuntu.md)
    - [VMware vSphere Ubuntu VM](./vmware-terraform-ubuntu.md) and [VMware vSphere Windows Server VM](./vmware-terraform-windows.md)
    - [Vagrant Ubuntu box](./local-vagrant-ubuntu.md) and [Vagrant Windows box](./local-vagrant-windows.md)

1. Delete the resource group.

    ```console
    az group delete --name <Name of your resource group>
    ```

    ![A screenshot of the `az group delete` command.](./media/arc-update-management/az-group-delete.png)
