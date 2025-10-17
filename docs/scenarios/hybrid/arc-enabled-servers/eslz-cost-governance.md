---
title: Cost governance for Azure Arc-enabled servers
description: Understand the design considerations and recommendations for cost management and governance of Azure Arc-enabled servers
author: sebassem
ms.author: sebassem
ms.date: 10/18/2021
ms.topic: conceptual
ms.custom: e2e-hybrid, think-tank
---

# Cost governance for Azure Arc-enabled servers

Cost governance involves continuously implementing policies to control the costs of Azure services. This document explains key cost governance considerations and recommendations for Azure Arc-enabled servers.

## How much does Azure Arc-enabled servers cost?

Azure Arc-enabled servers provide two types of services:

- **Azure Arc control plane functionality**, provided at no additional cost, includes:
  - Resource organization through Azure management groups and tags.
  - Searching and indexing through Azure Resource Graph.
  - Access control via Azure role-based access control (RBAC) at subscription or resource group level.
  - Environments and automation through templates and extensions.

- **Windows Server Pay-as-you-go licensing** is available for Azure Arc-enabled servers, billed per core per hour. See [Windows Server Pay-as-you-go licensing](/windows-server/get-started/windows-server-pay-as-you-go) for details.

- **Azure services used with Azure Arc-enabled servers**, which incur costs based on usage, include:
  - **Monitoring and security**: Azure Monitor, Microsoft Defender for servers, Microsoft Sentinel
  - **Management**: Azure Update Manager, Azure Policy machine configuration, Azure Automation
  - **Security and connectivity**: Azure Key Vault, Azure Private Link

## Design considerations

- **Governance:** Define a governance model for your hybrid servers that translates into Azure policies, tags, naming standards, and least-privilege access controls.
- **Azure Monitor:** [Azure Monitor](/azure/azure-monitor/overview) collects and analyzes log data from Azure Arc-enabled servers. Billing is based on data ingestion, retention, and export. Features such as standard metrics, activity logs, and insights are provided at no cost.
- **Microsoft Defender for Cloud**: Microsoft Defender for Cloud offers two modes:
  - **Free mode**: Provides secure score, security policy, continuous assessment, and recommendations. Enabled automatically or via API.
  - **Paid mode**: Adds enhanced security features for hybrid workloads, including Windows Server 2025 support and advanced threat protection. See [Defender for Cloud introduction](/azure/security-center/defender-for-cloud-introduction) and [pricing](/azure/security-center/security-center-pricing).
- **Microsoft Sentinel:** Microsoft Sentinel provides intelligent security analytics across your enterprise. It stores data in an Azure Monitor Log Analytics workspace. Billing is based on data volume ingested and stored. Commitment tier pricing offers cost savings for high-volume environments. See [Microsoft Sentinel billing](/azure/sentinel/azure-sentinel-billing).
- **Azure Update Manager:** Azure Update Manager helps manage and govern updates for all your machines. It monitors Windows and Linux update compliance across Azure, on-premises, and other clouds from a single dashboard. The service is billed at approximately $5 per server per month and includes enhanced compliance reporting for supported Windows Server versions. See [Azure Update Manager FAQ](/azure/update-manager/overview).
- **Azure Policy machine configuration:** Azure Policy machine configuration audits and enforces operating system and application settings across your servers. It is billed per server per month and includes usage rights for Azure Automation State Configuration, change tracking, and inventory. See [Cost governance for Azure Arc-enabled servers](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-cost-governance).
- **Azure Automation configuration management:** Azure Automation configuration management provides software change tracking, inventory, and state configuration using PowerShell Desired State Configuration. It is billed per server per month and includes usage rights for Azure Policy machine configuration. See [Cost governance for Azure Arc-enabled servers](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-cost-governance).
- **Azure Key Vault:** The Azure Key Vault VM extension manages certificate lifecycle on Windows and Linux Azure Arc-enabled servers. Billing is based on operations performed on certificates, keys, and secrets. Azure Key Vault supports the Azure Key Vault Provider for Secrets Store CSI Driver for Kubernetes clusters. See [Secrets Store CSI Driver](/azure/key-vault/secrets-store-csi-driver).
- **Azure Private Link:** Azure Private Link ensures data from Azure Arc-enabled servers is accessed only through authorized private networks. Billing is based on endpoints and inbound/outbound data processed. It supports enhanced diagnostics for Azure Arc-enabled servers. See [Cost governance for Azure Arc-enabled servers](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-cost-governance).

## Design recommendations

### Governance

- Assign least privilege Azure RBAC roles:
  - Use the **Azure Connected Machine Onboarding role** for administrators onboarding servers.
  - Use the **Azure Connected Machine Resource Administrator role** for those managing connected machines.
- Ensure all Azure Arc-enabled servers follow proper [naming and tagging conventions](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming).

### Azure Monitor

1. Review monitoring requirements and [Azure Monitor pricing](https://azure.microsoft.com/pricing/details/monitor/).
2. Select required logs and events for collection. See [data collected](/azure/azure-monitor/agents/log-analytics-agent#data-collected).
3. Use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/) to estimate costs.
4. Monitor costs with [Microsoft Cost Management](/azure/azure-monitor/usage-estimated-costs#azure-cost-management--billing).
5. Analyze log ingestion with [Log Analytics workspace insights](/azure/azure-monitor/logs/log-analytics-workspace-insights-overview).
6. Reduce data ingestion volume using [recommended tips](/azure/azure-monitor/logs/manage-cost-storage#tips-for-reducing-data-volume).
7. Configure data retention policies appropriately. See [workspace-level default retention](/azure/azure-monitor/logs/manage-cost-storage#workspace-level-default-retention).
8. Consider commitment tier pricing for large volumes.

### Microsoft Sentinel

- Review pricing and use the [Azure pricing calculator](https://azure.microsoft.com/pricing/details/azure-sentinel/).
- Monitor costs with [Cost Management tools](/azure/sentinel/azure-sentinel-billing#manage-and-monitor-azure-sentinel-costs).
- Understand [data retention costs](/azure/sentinel/azure-sentinel-billing#data-retention-costs).
- Filter logs to collect only necessary data. See [data collected](/azure/azure-monitor/agents/log-analytics-agent#data-collected).
- Use queries and workbooks to analyze data ingestion. See [workspace usage report workbook](/azure/sentinel/azure-sentinel-billing#deploy-a-workbook-to-visualize-data-ingestion).
- Create cost management playbooks for budget alerts. See [cost management playbook](/azure/sentinel/azure-sentinel-billing#use-a-playbook-for-cost-management-alerts).
- Consider commitment tier pricing. See [pricing tier](/azure/sentinel/azure-sentinel-billing#set-or-change-pricing-tier).
- Separate non-security data into different workspaces. See [separate non-security data](/azure/sentinel/azure-sentinel-billing#separate-non-security-data-in-a-different-workspace).

### Azure Policy machine configuration

- Review policy assignments and set the parameter to "false" for policies not needed on hybrid servers. See [policy assignments](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-cost-governance#design-considerations).

### Azure Key Vault

- Monitor certificate renewal and secrets operations with [Azure Key Vault insights](/azure/azure-monitor/insights/key-vault-insights-overview).

### Azure Private Link

- Monitor usage with [Cost Management](/azure/cost-management-billing/cost-management-billing-overview).

## Next steps

For more guidance for your hybrid cloud adoption journey, review the following resources:

- Review [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/day2/) scenarios.
- Review the [prerequisites](/azure/azure-arc/servers/agent-overview#prerequisites) for Azure Arc-enabled servers.
- Plan an [at-scale deployment](/azure/azure-arc/servers/plan-at-scale-deployment) of Azure Arc-enabled servers.
- Learn more about Azure Arc via the [Azure Arc learning path](/training/paths/manage-hybrid-infrastructure-with-azure-arc/).