---
title: Enterprise-scale Arc Server Cost governance
description: Understand the design considerations and recommendations for cost management and governance of Arc-enabled servers
author: sebassem
ms.author: sebassem
ms.date: 10/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: e2e-arc
---

# Cost governance with Azure Arc-enabled servers
Cost governance is the continuous process of implementing policies to control costs of services you are using on Azure. This document will walk you through the various cost governance considerations and recommendations when using Azure Arc-enabled servers.


## How much does Azure Arc-enabled servers cost?
Azure Arc-enabled servers provides two types of services:
1. **Azure Arc control plane functionality**, which is provided at no extra cost including:
   - Resource organization through Azure management groups and tags.
   - Searching and indexing through Azure Resource Graph.
   - Access and security through Azure RBAC and subscriptions.
   - Environments and automation through templates and extensions.
   - Update management

2. **Azure services used on the Azure Arc-enabled servers**, which has some cost to it according to it's usage including:
   - Azure Monitor
   - Azure Security Center
   - Azure Sentinel
   - Azure Policy Guest Configuration (includes Azure Automation change tracking, inventory, state configuration)
   - Azure Key Vault
   - Azure Private Links
## Design considerations
### Azure Monitor
[Azure Monitor](/azure/azure-monitor/overview) includes functionality for the collection and analysis of log data of your Azure Arc-enabled servers (billed by data ingestion, retention, and export), collection of metrics, health monitoring, alerts, and notifications.

Features of Azure Monitor that are automatically enabled such as collection of standard metrics, activity logs and Insights are provided at no cost.

Decide on your monitoring requirements and review [Azure Monitor pricing](https://azure.microsoft.com/pricing/details/monitor/).

### Azure Security Center
Azure Security Center is offered in [two modes](/azure/security-center/security-center-pricing):
- **Azure Defender OFF (Free)** - [Security Center without Azure Defender](/azure/security-center/security-center-introduction) once enabled, provides security policy, continuous security assessment, and actionable security recommendations to help you protect your Azure Arc-enabled servers and Azure resources.

- **Azure Defender ON (Charged)** - Enabling [Azure Defender](/azure/security-center/azure-defender) extends the capabilities of the free mode to your Azure Arc-enabled servers and Azure resources, providing unified security management and threat protection.

Review [Azure Defender for Servers pricing](https://azure.microsoft.com/en-us/pricing/details/azure-defender/).

### Azure Sentinel
Azure Sentinel provides intelligent security analytics across your enterprise. The data for this analysis is stored in an Azure Monitor Log Analytics workspace. Azure Sentinel is billed based on the volume of data ingested for analysis in Azure Sentinel and stored in the Azure Monitor Log Analytics workspace for your Azure Arc-enabled servers.

Review [Azure Sentinel pricing](https://azure.microsoft.com/en-us/pricing/details/azure-sentinel/).


### Azure Policy Guest Configuration
 Azure Policy Guest Configuration can audit operating systems and machine configuration in Azure Arc-enabled servers, enabling capabilities like Azure Automation change tracking and inventory. Azure Policy guest configuration is billed per server per month.

 Review [Azure Policy Guest Configuration pricing]( https://azure.microsoft.com/en-us/pricing/details/azure-arc/
 ).

### Azure Key Vault

The Key Vault VM extension allows you to manage the certificate lifecycle on [Windows](/azure/virtual-machines/extensions/key-vault-windows) and [Linux](/azure/virtual-machines/extensions/key-vault-linux) Azure Arc-enabled servers. Azure Key Vault is billed by the operations performed on the certificates and secrets. 

Review [Azure Key Vault pricing](https://azure.microsoft.com/en-us/pricing/details/key-vault/).


### Azure Private Link
You can use [Azure Private Link](/azure/azure-arc/servers/private-link-security) to ensure data coming from your Azure Arc-enabled servers is only accessed through authorized private networks.Azure Private Link is billed by endpoint and inbound/outbound data processed.

Review [Azure Private Link pricing](https://azure.microsoft.com/en-us/pricing/details/private-link/).

## Design recommendations
Here are some general design recommendations for Azure Arc-enabled servers cost governance:

### Governance
- Ensure that all Azure Arc-enabled servers follow proper [naming and tagging conventions](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging).
- Use least privilege RBAC by assigning **Azure Connected Machine Onboarding role** to only administrators who will on-board Azure Arc-enabled servers to avoid un-needed costs.
### Azure Monitor 
-  Decide on the [required logs](https://docs.microsoft.com/en-us/azure/azure-monitor/agents/log-analytics-agent#data-collected) for the Azure Arc-enabled Windows and Linux servers to be collected in the Log Analytics workspace.
-  Use the [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/) to calculate an estimate of the Azure Arc-enabled servers monitoring costs.
  
![Azure Pricing Calculator](./media/pricing-calculator.png)

![Azure Pricing Calculator AZMon](./media/pricing-calculator-az-monitor.png)

- Use [Azure Cost Management and Billing](https://docs.microsoft.com/en-us/azure/azure-monitor/usage-estimated-costs#azure-cost-management--billing) to have visibility on Azure Monitor costs.

![Azure cost management and billing](./media/Azure-cost-management-billing.png)

- Use [Log Analytics workspaces Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-workspace-insights-overview) solution to understand and monitor the collected logs and their ingestion rate on the Log Analytics workspace.

![Log Analytics Insights](./media/Log-analytics-insights.png)

- Evaluate usage of [daily cap](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/manage-cost-storage#set-the-daily-cap) to limit the daily ingestion for your workspace.
- Evaluate possible data ingestion volume reducing, Refer to this [Tips for reducing data volume](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/manage-cost-storage#tips-for-reducing-data-volume) documentation to help configure data ingestion properly.
- Consider how long to retain data on Log Analytics. Data ingested into Log Analytics workspace can be retained at no additional charge up to first 31 days. Consider general aspects to configure the [Log Analytics workspace level default retention](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/manage-cost-storage#workspace-level-default-retention) and specific needs to configure data [retention by data type](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/manage-cost-storage#retention-by-data-type), that can be as low as 4 days. Example: Usually, performance data doens't need to be retained longer, instead, security logs may need to be retained longer.
### Azure Sentinel
- Use the Azure Pricing Calculator to estimate [Azure Sentinel costs](https://docs.microsoft.com/en-us/azure/sentinel/azure-sentinel-billing).

![Azure Sentinel costs](./media/azure-sentinel-costs.png)

### Azure Policy Guest Configuration
- Use Azure Cost Managemnet to understand the Azure Policy Guest Configuration costs by filtering by the **Microsoft.hybridcompute/machines** resource type.

![Azure policy costs](./media/Azure-cost-management-policy.png)

### Azure Key Vault
- Use [Azure Key Vault insights](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/key-vault-insights-overview) to monitor certificate renewal and secrets operations on your Azure Arc-enabled servers.

![Azure Key Vault insights](./media/key-vault-insights.png)
### Azure Private Link

- Use Use [Azure Cost Management and Billing](https://docs.microsoft.com/en-us/azure/cost-management-billing/cost-management-billing-overview) to monitor the usage of Private Links used with Azure Arc-enabled servers.

![Azure private link costs](./media/Private-endpoint-costs.png)
