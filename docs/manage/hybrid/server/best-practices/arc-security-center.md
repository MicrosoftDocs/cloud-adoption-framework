---
title: Connect Azure Arc-enabled servers to Microsoft Defender for Cloud
description: Learn how to onboard an Azure Arc-enabled server to Microsoft Defender for Cloud.
author: likamrat
ms.author: martinek
ms.date: 01/15/2020
ms.topic: conceptual
ms.custom: think-tank, e2e-hybrid
---

# Connect Azure Arc-enabled servers to Microsoft Defender for Cloud

This article provides guidance on how to onboard an Azure Arc-enabled server to [Microsoft Defender for Cloud](/azure/security-center/). This helps you start collecting security-related configurations and event logs so you can recommend actions and improve your overall Azure security posture.

In the following procedures, you enable and configure Microsoft Defender for Cloud Standard tier on your Azure subscription. This provides advanced threat protection and detection capabilities. The process includes:

- Setup a Log Analytics workspace where logs and events are aggregated for analysis.
- Assign Defender for Cloud default security policies.
- Review Defender for Cloud recommendations.
- Apply recommended configurations on Azure Arc-enabled servers using the **Quick Fix** remediations.

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

2. As mentioned, this guide starts at the point where you already deployed and connected VMs or bare-metal servers to Azure Arc. For this scenario, we use a Google Cloud Platform (GCP) instance that has been already connected to Azure Arc and is visible as a resource in Azure. As shown in the following screenshots:

    ![A screenshot of an Azure Arc-enabled server in the Azure portal.](./media/arc-security-center/arc-overview.png)

    ![A screenshot of details from an Azure Arc-enabled server in the Azure portal.](./media/arc-security-center/arc-status.png)

3. [Install or update Azure CLI](/cli/azure/install-azure-cli). Azure CLI should be running version 2.7 or later. Use `az --version` to check your current installed version.

4. Create an Azure service principal.

    To connect a VM or bare-metal server to Azure Arc, Azure service principal assigned with the Contributor role is required. To create it, sign in to your Azure account and run the following command. You can also run this command in [Azure Cloud Shell](https://shell.azure.com/).

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

## Onboard Microsoft Defender for Cloud

1. Data collected by Microsoft Defender for Cloud is stored in a Log Analytics workspace. You can either use the default one created by Defender for Cloud or a custom one created by you. If you want to create a dedicated workspace, you can automate the deployment by editing the Azure Resource Manager template (ARM template) [parameters file](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/defender/arm/log_analytics-template.parameters.json), provide a name and location for your workspace:

   ![A screenshot of an ARM template.](./media/arc-security-center/arm-template.png)

2. To deploy the ARM template, navigate to the [deployment folder](https://github.com/microsoft/azure_arc/tree/main/azure_arc_servers_jumpstart/defender/arm) and run the following command:

   ```console
   az deployment group create --resource-group <Name of the Azure resource group> \
   --template-file <The `log_analytics-template.json` template file location> \
   --parameters <The `log_analytics-template.parameters.json` template file location>
   ```

3. If you are going for a user-defined workspace, you should instruct Defender for Cloud to use it instead of the default one via the following command:

   ```console
   az security workspace-setting create --name default \
   --target-workspace '/subscriptions/<Your subscription ID>/resourceGroups/<Name of the Azure resource group>/providers/Microsoft.OperationalInsights/workspaces/<Name of the Log Analytics Workspace>'
   ```

4. Select a Microsoft Defender for Cloud tier. The Free tier is enabled on all your Azure subscriptions by default and will provide continuous security assessment and actionable security recommendations. In this guide, you use the Standard tier for Azure Virtual Machines that extends these capabilities providing unified security management and threat protection across your hybrid cloud workloads. To enable the Standard tier of Microsoft Defender for Cloud for VMs, run the following command:

    ```console
    az security pricing create -n VirtualMachines --tier 'standard'
    ```

5. Assign the default Microsoft Defender for Cloud policy initiative. Defender for Cloud makes its security recommendations based on policies. There is a specific initiative that groups Defender for Cloud policies with the definition ID `1f3afdf9-d0c9-4c3d-847f-89da613e70a8`. The following command will assign the Defender for Cloud initiative to your subscription.

    ```console
    az policy assignment create --name 'Azure Security Center Default <Your subscription ID>' \
    --scope '/subscriptions/<Your subscription ID>' \
    --policy-set-definition '1f3afdf9-d0c9-4c3d-847f-89da613e70a8'
    ```

## Azure Arc and Microsoft Defender for Cloud integration

After you successfully onboard Microsoft Defender for Cloud, you'll get recommendations to help you protect your resources, including your Azure Arc-enabled servers. Defender for Cloud will periodically analyze the security state of your Azure resources to identify potential security vulnerabilities.

In the **Compute & Apps** section under **VM & Servers**, Microsoft Defender for Cloud provides an overview of all the discovered security recommendations for your VMs and computers, including Azure VMs, Azure classic VMs, servers, and Azure Arc machines.

![A screenshot of **Compute & Apps** in Microsoft Defender for Cloud.](./media/arc-security-center/compute-apps.png)

On the Azure Arc-enabled servers, Microsoft Defender for Cloud recommends installing the Log Analytics agent. Each recommendation also includes:

- A short description of the recommendation.
- A secure score impact, in this case, with a status of **High**.
- The remediation steps to carry out in order to implement the recommendation.

For specific recommendations, like in the following screenshot, you will also get a **Quick Fix** that enables you to quickly remediate a recommendation on multiple resources.

  ![A screenshot of a Microsoft Defender for Cloud recommendation for an Azure Arc-enabled server.](./media/arc-security-center/recommendation-quick-fix.png)

  ![A screenshot of a Microsoft Defender for Cloud recommendation to install Log Analytics.](./media/arc-security-center/recommendation-remediate.png)

The following remediation **Quick Fix** is using an ARM template to deploy the Log Analytics agent extension on the Azure Arc machine.

  ![A screenshot of a Microsoft Defender for Cloud **Quick Fix** ARM template.](./media/arc-security-center/quick-fix-template.png)

You can trigger the remediation with the ARM template from the workload protection dashboard, by selecting the Log Analytics workspace used for Microsoft Defender for Cloud and then choosing **Remediate 1 resource**.

  ![A screenshot of how to trigger a remediation step in Microsoft Defender for Cloud.](./media/arc-security-center/remediation-trigger.png)

After you apply the recommendation on the Azure Arc-enabled server, the resource will be marked as healthy.

  ![A screenshot of a healthy Azure Arc-enabled server.](./media/arc-security-center/healthy-server.png)

## Clean up your environment

Complete the following steps to clean up your environment.

1. Remove the virtual machines from each environment by following the teardown instructions from each guide.

    - [GCP Ubuntu instance](./gcp-terraform-ubuntu.md) and [GCP Windows instance](./gcp-terraform-windows.md)
    - [AWS Ubuntu EC2 instance](./aws-terraform-ubuntu.md)
    - [VMware vSphere Ubuntu VM](./vmware-terraform-ubuntu.md) / [VMware vSphere Windows Server VM](./vmware-terraform-windows.md)
    - [Vagrant Ubuntu box](./local-vagrant-ubuntu.md) / [Vagrant Windows box](./local-vagrant-windows.md)

2. Remove the Log Analytics workspace by executing the following script in Azure CLI. Provide the workspace name you used when creating the Log Analytics workspace.

  ```console
  az monitor log-analytics workspace delete --resource-group <Name of the Azure resource group> --workspace-name <Log Analytics Workspace Name> --yes
  ```
