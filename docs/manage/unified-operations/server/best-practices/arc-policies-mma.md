---
title: Manage Azure policies and deploy the Azure Monitoring agent extension to Azure Arc Linux and Windows servers 
description: Manage Azure policies and deploy the Azure Monitoring agent extension to Azure Arc Linux and Windows servers.
author: likamrat
ms.author: brblanch
ms.date: 01/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank
---

# Manage Azure policies and deploy the Azure Monitoring agent extension to Azure Arc Linux and Windows servers

The following README will guide you on how to use Azure-Arc-enabled servers to assign Azure Policies to VMs outside of Azure, whether they are on-premises or other clouds. With this feature you can now use Azure Policy to audit settings in the operating system of an Azure-Arc-enabled server, if a setting is not compliant you can also trigger a remediation task.

In this case, you will assign a policy to audit if the Azure Arc connected machine has the (Microsoft Monitoring Agent) MMA agent installed, if not, you will use the extensions feature to automatically deploy it to the VM, an enrollment experience that levels to Azure VMs. This approach can be used to make sure all your servers are onboard to services such as Azure Monitor, Azure Security Center, Azure Sentinel, etc.

You can use the Azure portal, an Azure Resource Manager template (ARM template) or PowerShell script to assign policies to Azure subscriptions or resource groups. In this guide, you will use an ARM template to assign built-in policies.

> **Note: This guide assumes you already deployed VMs or servers that are running on-premises or other clouds and you have connected them to Azure Arc but If you haven't, this repository offers you a way to do so in an automated fashion:**

* **[GCP Ubuntu instance](./gcp-terraform-ubuntu/)**
* **[GCP Windows instance](./gcp-terraform-windows/)**
* **[AWS Ubuntu EC2 instance](./aws-terraform-ubuntu/)**
* **[AWS Amazon Linux 2 EC2 instance](./aws-terraform-al2/)**
* **[VMware vSphere Ubuntu VM](./vmware-terraform-ubuntu/)**
* **[VMware vSphere Windows Server VM](./vmware-terraform-winsrv/)**
* **[Vagrant Ubuntu box](./local-vagrant-ubuntu/)**
* **[Vagrant Windows box](./local-vagrant-windows/)**

Please review the [Azure Monitor supported OS documentation](https://docs.microsoft.com/azure/azure-monitor/insights/vminsights-enable-overview#supported-operating-systems) and ensure that the VMs you will use for this guide are supported. For Linux VMs, check both the Linux distribution and kernel to ensure you are using a supported configuration.

## Prerequisites

* Clone the Azure Arc Jumpstart repository

    ```console
    git clone https://github.com/microsoft/azure-arc.git
    ```

* As mentioned, this guide starts at the point where you already deployed and connected VMs or servers to Azure Arc. In the screenshots below we can see a GCP server has been connected with Azure Arc and is visible as a resource in Azure.

    ![Screenshot of a resource group for an Azure-Arc-enabled server.](./img/arc-policies-mma/arc-policies-mma/resource-group.png)

    ![Screenshot of a connected status for an Azure-Arc-enabled server.](./img/arc-policies-mma/connected-status.png)

* [Install or update Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest). Azure CLI should be running version 2.7** or later. Use ```az --version``` to check your current installed version.

* Create Azure service principal (SP)

    To connect a VM or bare-metal server to Azure Arc, Azure service principal assigned with the "contributor" role is required. To create it, login to your Azure account run the below command (this can also be done in [Azure Cloud Shell](https://shell.azure.com/)).

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

  > **Note: It is optional but highly recommended to scope the SP to a specific [Azure subscription and resource group](https://docs.microsoft.com/cli/azure/ad/sp?view=azure-cli-latest).**

* You will also need to have a Log Analytics workspace deployed. You can automate the deployment by editing the ARM template [parameters file](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/policies/arm/log-analytics-template.parameters.json), provide a name and location for your workspace.

    ![Screenshot an ARM template parameters file.](./img/arc-policies-mma/parameter-file-1.png)

  To deploy the ARM template, navigate to the [deployment folder](https://github.com/microsoft/azure-arc/tree/main/azure-arc-servers-jumpstart/policies/arm) and run the below command:

  ```console
    az deployment group create --resource-group <Name of the Azure resource group> \
    --template-file <The *log-analytics-template.json* template file location> \
    --parameters <The *log-analytics-template.parameters.json* template file location>
  ```

## Azure Policies on Azure Arc connected machines

* Now that you have all the prerequisites set, you can assign policies to our Arc connected machines. Edit the [parameters file](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/policies/arm/policy.json) to provide your subscription ID as well as the Log Analytics workspace.

    ![Screenshot of another ARM template parameter file.](./img/arc-policies-mma/parameter-file-2.png)

  To start the deployment, use the below command:

  ```console
  az policy assignment create --name 'Enable Azure Monitor for VMs' \
  --scope '/subscriptions/<Your subscription ID>/resourceGroups/<Name of the Azure resource group>' \
  --policy-set-definition '55f3eceb-5573-4f18-9695-226972c6d74a' \
  -p <The *policy.json* template file location> \
  --assign-identity --location <Azure Region>
  ```

  The flag *policy-set-definition* points to the initiative "Enable Azure Monitor" definition ID.

* Once the initiative is assigned, it takes around 30 minutes for the assignment to be applied to the defined scope. After those 30 minutes, Azure Policy will start the evaluation cycle against the Azure Arc connected machine and recognize it as "Non-compliant" (since it still does not have the Log Analytics Agent configuration deployed). To check this, go to the Azure Arc connected Machine under the Policies section.

  ![Screenshot an non-compliant Azure Policy.](./img/arc-policies-mma/non-comp-policy.png)

* Now, you will assign a remediation task to the non-compliant resource to put into a compliant state.

  ![Screenshot of creating an Azure Policy remediation task.](./img/arc-policies-mma/create-remediation-task.png)

* Under 'Policy to remediate' choose '[Preview] Deploy Log Analytics Agent to Linux Azure Arc machines' and select 'Remediate'. This remediation task is instructing Azure Policy to run the deployIfNotExists effect and use the Azure Arc extension management capabilities to deploy the Log Analytics agent on the VM

  ![Screenshot of an Azure Policy remediation action within a remediation task.](./img/arc-policies-mma/remediation-action.png)

* Once you have assigned remediation task, the policy will be evaluated again and show that the server on GCP is compliant and that the Microsoft Monitoring Agent extension is installed on the Azure Arc machine.

  ![Screenshot of a remediation task configuration.](./img/arc-policies-mma/task-config.png)

  ![Screenshot of a compliant Azure Policy status.](/img/arc-policies-mma/compliant-status.png)

## Clean up environment

Complete the following steps to clean up your environment.

Remove the virtual machines from each environment by following the teardown instructions from each guide.

* **[GCP Ubuntu instance](./gcp-terraform-ubuntu/) / [GCP Windows instance](./gcp-terraform-windows/)**
* **[AWS Ubuntu EC2 instance](./aws-terraform-ubuntu/)**
* **[VMware vSphere Ubuntu VM](./vmware-terraform-ubuntu/) / [VMware vSphere Windows Server VM](./vmware-terraform-winsrv/)**
* **[Vagrant Ubuntu box](./local-vagrant-ubuntu/) / [Vagrant Windows box](./local-vagrant-windows/)**

Remove the Azure Policy assignment by executing the following script in Azure CLI.

  ```console
  az policy assignment delete --name 'Enable Azure Monitor for VMs' --resource-group <resource-group>
  ```

Remove the Log Analytics workspace by executing the following script in Azure CLI. Provide the workspace name you used when creating the Log Analytics workspace.

  ```console
  az monitor log-analytics workspace delete --resource-group <Name of the Azure resource group> --workspace-name <Log Analytics workspace Name> --yes
  ```
