---
title: Use Update Management in Azure Automation to manage operating system updates for Azure-Arc-enabled servers
description: Use Update Management in Azure Automation to manage operating system updates for Azure-Arc-enabled servers.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: think-tank
---

# Use Update Management in Azure Automation to manage operating system updates for Azure-Arc-enabled servers

The scenario will show you how to onboard Azure-Arc-enabled servers to [Update Management in Azure Automation](https://docs.microsoft.com/azure/automation/update-management/overview), so that you can manage operating system updates for your Azure-Arc-enabled servers running Windows or Linux.

In this guide, you will create and configure an Azure Automation account and Log Analytics workspace to support Update Management for Azure-Arc-enabled servers by doing the following:

* Setup a new Log Analytics Workspace and Azure Automation account.

* Enable Update Management on Azure-Arc-enabled servers.

> **Note: This guide assumes you already deployed VMs or servers that are running on-premises or other clouds and you have connected them to Azure Arc but If you haven't, this repository offers you a way to do so in an automated fashion:**

- [GCP Ubuntu instance](./gcp-terraform-ubuntu.md)
- [GCP Windows instance](./gcp-terraform-windows.md)
- [AWS Ubuntu EC2 instance](./aws-terraform-ubuntu.md)
- [AWS Amazon Linux 2 EC2 instance](./aws-terraform-al2.md)
- [VMware vSphere Ubuntu VM](./vmware-terraform-ubuntu.md)
- [VMware vSphere Windows Server VM](./vmware-terraform-winsrv.md)
- [Vagrant Ubuntu box](./local-vagrant-ubuntu.md)
- [Vagrant Windows box](./local-vagrant-windows.md)

## Prerequisites

* Clone the Azure Arc Jumpstart repository

    ```console
    git clone https://github.com/microsoft/azure-arc.git
    ```

* As mentioned, this guide starts at the point where you already deployed and connected VMs or bare-metal servers to Azure Arc. For this scenario, as can be seen in the screenshots below, we will be using an Amazon Web Services (AWS) EC2 instance that has been already connected to Azure Arc and is visible as a resource in Azure.

    ![A screenshot of an EC2 in an Amazon Web Services cloud console.](./img/arc-update-management/aws-ec2-instance.png)

    ![A screenshot of an Azure-Arc-enabled server in the Azure portal.](./img/arc-update-management/arc-enabled-server.png)

* [Install or update Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest). Azure CLI should be running version 2.14 or later. Use ```az --version``` to check your current installed version.

## Configuring Update Management

Update Management uses the Log Analytics agent to collect Windows and Linux server log files and the data collected is stored in a Log Analytics workspace.

* You will need to create a Log Analytics workspace. For that you can use this [Azure Resource Manage template (ARM template)](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/updateManagement/law-template.json) that will create a new Log Analytics Workspace and define the Update Management solution and enable it for the workspace.

* First, create a new resource group for the Log Analytics workspace by running the below command, replacing the values in brackets with your own.

    ```console
    az group create --name <Name for your resource group> \
    --location <Location for your resources> \
    --tags "Project=jumpstart-azure-arc-servers"
    ```

    ![A screenshot of the 'az group create' command.](./img/arc-update-management/az-group-create.png)

* Next, edit the ARM template [parameters file](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/updateManagement/law-template.parameters.json), providing a name for your Log Analytics workspace, a location, and a name for your Azure Automation account. You also need to supply the name of your Azure-Arc-enabled server, and the name of the resource group that contains the Arc enabled server as shown in the example below:

    ![A screenshot of an ARM template.](./img/arc-update-management/arm-template.png)

* To deploy the ARM template, navigate to the [deployment folder](https://github.com/microsoft/azure-arc/tree/main/azure-arc-servers-jumpstart/updateManagement) and run the below command:

    ```console
    az deployment group create --resource-group <Name of the Azure resource group you created> \
        --template-file law-template.json \
        --parameters law-template.parameters.json
    ```

   ![A screenshot of the 'az deployment group' command.](./img/arc-update-management/az-deployment-group.png)

* When the deployment is complete, you should be able to see the resource group with your Log Analytics workspace, automation account and Update Management solution from the Azure portal. Drilling into the Log Analytics workspace Solutions tab should show the Update Management solution.

    ![A screenshot of a Log Analytics workspace in the Azure portal.](./img/arc-update-management/log-analytics-workspace.png)

## Confirm that the Update Management solution is deployed on your Azure-Arc-enabled server

* Click on the Solutions tab of the Log Analytics workspace and then click the Updates solution from the list to check the progress of the Update Management assessment.

    ![A screenshot of Solutions tab of a Log Analytics workspace.](./img/arc-update-management/solutions-tab.png)

* It may take several hours for Update Management to collect enough data to show an assessment for your VM. In the screen below we can see the assessment is being performed.

    ![A screenshot of the Overview tab and Updates view within a Log Analytics workspace.](./img/arc-update-management/overview-tab.png)

* When the assessment is complete, you will see an option to "View summary" on the Update Management tab.

    ![A screenshot of an Updates view summary within a Log Analytics workspace.](./img/arc-update-management/updates-summary.png)

* Click View Summary and then click again to drill into the Update Management assessment. In the below example we can see there are updates missing on our Azure-Arc-enabled server.

    ![A screenshot of updates missing from an Azure-Arc-enabled server.](./img/arc-update-management/updates-missing.png)

## Schedule an update

Now that we have configured the Update Management solution, we can deploy updates on a set schedule for our Azure-Arc-enabled server.

* Navigate to the Automation Account we created previously and click on the Update Management tab as shown in the screenshot below. You should see your Azure-Arc-enabled server listed.

    ![A screenshot of an Azure Automation account.](./img/arc-update-management/azure-automation-account.png)

* From the above screen, click "Schedule update deployment". On the next screen, select the Operating System that your Azure-Arc-enabled server is using, and then select "Machines to update" as shown below.

    ![A screenshot of scheduling an update with Update Deployment.](./img/arc-update-management/schedule-an-update.png)

* From the "Type" dropdown, select "Machines" and then select your server and click Ok.

    ![A screenshot of the type and server selected for a scheduled update with Update Deployment.](./img/arc-update-management/type-update.png)

* Click Schedule Settings and then provide a desired schedule.

    ![A screenshot of the field to configure Schedule settings within Update Deployment.](./img/arc-update-management/config-schedule-settings.png)

    ![A screenshot of the fields for Schedule settings within Update Deployment.](./img/arc-update-management/schedule-settings.png)

* Finally, provide a name for your Update deployment and then click Create.

    ![A screenshot of naming an update within Update Deployment.](./img/arc-update-management/naming-update.png)

* From the Automation Account Update Management tab, you should be able to see your scheduled Update deployment from the Deployment Schedules tab.
    ![A screenshot of a scheduled update within Update management.](./img/arc-update-management/scheduled-update.png)

The Update Management solution will now update your Azure-Arc-enabled servers in the deployment window based on the schedule you defined. There is a lot more you can do with [Update Management](https://docs.microsoft.com/azure/automation/update-management/overview) that is outside the scope of this scenario. Review the [documentation](https://docs.microsoft.com/azure/automation/update-management/overview) for more information.

## Clean up environment

Complete the following steps to clean up your environment.

* Remove the virtual machines from each environment by following the teardown instructions from each guide.

- [GCP Ubuntu instance](./gcp-terraform-ubuntu.md) and [GCP Windows instance](./gcp-terraform-windows.md)
- [AWS Ubuntu EC2 instance](./aws-terraform-ubuntu.md)
- [VMware vSphere Ubuntu VM](./vmware-terraform-ubuntu.md) and [VMware vSphere Windows Server VM](./vmware-terraform-winsrv.md)
- [Vagrant Ubuntu box](./local-vagrant-ubuntu.md) and [Vagrant Windows box](./local-vagrant-windows.md)

* Delete the resource group.

    ```console
    az group delete --name <Name of your resource group>
    ```

    ![A screenshot of the 'az group delete' command.](./img/arc-update-management/az-group-delete.png)
