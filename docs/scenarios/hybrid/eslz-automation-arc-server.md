---
title: Automation for Azure Arc-enabled servers
description: Understand the design considerations and recommendations for automation of Arc-enabled servers
author: DCMattyG
ms.author: magarret
ms.date: 10/07/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: e2e-arc
---

# Automation for Azure Arc-enabled servers

Azure Arc-enabled servers enable you to manage your Windows and Linux servers and virtual machines hosted outside of Azure, on your corporate network, or another cloud provider. This document is written to help plan for the automation of onboarding, update management, and expansion of the capabilities of Azure Arc-enabled servers through VM extensions. The article presents key recommendations for operations teams to onboard and automate Azure Arc-enabled servers throughout their lifecycle.

## Architecture

The following image shows a conceptual reference architecture that highlights the onboarding and automation design areas for Azure Arc-enabled servers:

![Azure Arc-enabled data services | Onboarding and VM extension integration](./media/arc-servers-onboarding.svg)

## Design considerations

The following are some design considerations before onboarding Azure Arc-enabled servers to Azure:

- **Review Requirements:** Your machines run a [supported operating system](/azure/azure-arc/servers/agent-overview#supported-operating-systems) for the Azure Connected Machine agent.
- **Review Requirements:** Your machines have the [required software](/azure/azure-arc/servers/agent-overview#software-requirements) installed before deploying the Azure Connected Machine agent.
- **Review Requirements:** You've reviewed the [Azure subscription and service limits](/azure/azure-arc/servers/agent-overview#azure-subscription-and-service-limits) for Azure Arc-enabled servers.
- **Network Connectivity** Your machines have [connectivity](/azure/azure-arc/servers/agent-overview#networking-configuration) from your on-premises network or other cloud providers to Azure, directly connected or via a proxy server or private endpoint. See the [Network connectivity for Azure Arc-enabled servers](./eslz-arc-servers-connectivity.md) section of this guide for design considerations and recommendations.
- **Environment Preparation:** To deploy and configure the Azure Arc-enabled servers Connected Machine agent, an account with administrator or as root privileges are required on the machines.
- **Environment Preparation:** To onboard machines, you have the [required Azure permissions](/azure/azure-arc/servers/agent-overview#required-permissions). See the [Identity and access management for Azure Arc-enabled servers](./eslz-identity-and-access-management.md) section of this guide for more identity and access related content.
- **Onboard Azure Arc-enabled servers:** Before onboarding machines, you've [registered the Azure resource providers](/azure/azure-arc/servers/agent-overview#register-azure-resource-providers) for Azure Arc-enabled servers.
- **Onboard Azure Arc-enabled servers:** Decide how you'll install and configure the Azure Connected Machine Agent across your fleet of servers. Typically, you'll deploy the agent using your organization’s standard automation tool(s).
- **Virtual Machine Extensions:** Determine which Azure capabilities you want to enable on your Azure Arc-enabled servers. Some capabilities require a VM extension to be installed on your server, which can be automated with Azure Policy.
- **Lifecycle Automation:** Create an operating system patch management strategy for Azure Arc-enable servers

## Design recommendations

The following are some general design recommendations for Azure Arc-enabled servers:

### Environment Preparation

- Create a [dedicated resource group](/azure/azure-resource-manager/management/manage-resource-groups-portal#create-resource-groups) to include only Azure Arc-enabled servers and centralize management and monitoring of these resources.
- Evaluate and develop an IT-aligned [tagging strategy](/azure/cloud-adoption-framework/decision-guides/resource-tagging/) that can help reduce the complexity of managing your Azure Arc-enabled servers and simplify making management decisions.
- Create a [service principal](/azure/azure-arc/servers/onboard-service-principal#create-a-service-principal-for-onboarding-at-scale) to connect machines non-interactively using Azure PowerShell or from the portal.

### Onboard Azure Arc-enabled servers

One of your first tasks will be to onboard your fleet of servers and virtual machines to Azure. After [generating an installation script](/azure/azure-arc/servers/onboard-portal#generate-the-installation-script-from-the-azure-portal), if you only have a few servers, you may opt to run the script directly from your [Windows](/azure/azure-arc/servers/onboard-portal#install-and-validate-the-agent-on-windows) or [Linux](/azure/azure-arc/servers/onboard-portal#install-and-validate-the-agent-on-linux) machines. For larger fleets of servers, there are several options available in Azure to automate the onboarding process. We recommended creating a [Service Principal](/azure/azure-arc/servers/onboard-service-principal#create-a-service-principal-for-onboarding-at-scale) and apply one of the following methods:

- Review and customize the [predefined installation script](/azure/azure-arc/servers/onboard-service-principal) for at-scale deployment of the Connected Machine agent to support your automated deployment requirements.
- Generate a [PowerShell script](/azure/azure-arc/servers/onboard-service-principal) using a Service Principal, and deploy via your organizations existing automation platform
  - Connect machines using [Automation Update Management](/azure/azure-arc/servers/onboard-update-management-machines)
  - Connect machines using [PowerShell Remoting](/azure/azure-arc/servers/onboard-powershell#install-and-connect-by-using-powershell-remoting) or [PowerShell DSC](/azure/azure-arc/servers/onboard-dsc)
  - Connect machines from [Windows Admin Center](/azure/azure-arc/servers/onboard-windows-admin-center)

Afterwards, be sure to [verify your connection](/azure/azure-arc/servers/onboard-portal#verify-the-connection-with-azure-arc) to Azure Arc.

### Virtual Machine Extensions

To simplify the management of hybrid servers throughout their lifecycle, [VM extensions](/azure/azure-arc/servers/manage-vm-extensions) can be deployed to Azure Arc-enabled servers from the Azure portal. Virtual Machine (VM) extensions are small applications that provide post-deployment configuration and automation tasks on Azure VMs. For example, if a virtual machine requires software installation, anti-virus protection, or to run a script in it, a VM extension can be used. Many VM extensions are supported for both [Windows](/azure/azure-arc/servers/manage-vm-extensions#windows-extensions) and [Linux](/azure/azure-arc/servers/manage-vm-extensions#linux-extensions) Azure Arc-enabled servers.

We recommended automating the deployment of VM extensions at scale via [Azure Policy](/azure/governance/policy/overview) to automatically deploy extensions to your Azure Arc-enabled servers and regularly check the policy compliance data to identify and remediate servers that don't have the agent installed.

Overview of steps:
- Create an [initiative](/azure/security-center/security-policy-concept#what-is-a-security-initiative) to deploy VM extensions at scale
- Use a “[DeployIfNotExists](/azure/governance/policy/concepts/effects#deployifnotexists)” policy effect to ensure the VM extensions get deployed automatically as more servers are onboarded, and remediate any servers where the VM extensions have been removed
- More details on using policy with Azure Arc-enabled servers can be found in the [Security, Governance and Compliance for Azure Arc-enabled servers](./eslz-security-governance-and-compliance.md) enterprise-scale scenario

### Lifecycle Automation

Once your servers are onboarded to Azure, it's recommended to [enable patch and update management](/azure/cloud-adoption-framework/manage/hybrid/server/best-practices/arc-update-management) to ease OS lifecycle management on your Azure Arc-enabled servers. Update Management in Azure Automation allows you to view and schedule operating system updates and patches for your Arc-enabled servers at scale. More information about Update Management for Azure Automation can be found [here](/azure/automation/update-management/overview).

- Enable OS lifecycle automation by configuring [Update Management](/azure/automation/update-management/enable-from-automation-account) in Azure Automation to manage operating system updates for your Windows and Linux virtual machines registered with Azure Arc-enabled servers.

## Next Steps

For more guidance for your hybrid cloud adoption journey, please review the following:

- Review [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/day2/) scenarios
- Review the [prerequisites](/azure/azure-arc/servers/agent-overview#prerequisites) for Azure Arc-enabled servers
- Plan an [at-scale deployment](/azure/azure-arc/servers/plan-at-scale-deployment) of Azure Arc-enable servers
