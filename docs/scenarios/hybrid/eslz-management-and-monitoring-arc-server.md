---
title: Management and monitoring for Azure Arc-enabled servers
description: Understand the design considerations and recommendations for management and monitoring of Azure Arc-enabled servers
author: sebassem
ms.author: sebassem
ms.date: 09/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank
---

# Management and monitoring for Azure Arc-enabled servers

Azure Arc-enabled servers allow you to manage your Windows and Linux servers and virtual machines that are hosted outside of Azure, on your corporate network, or on a third-party cloud provider.

This article will help you operate Azure Arc-enabled servers on Azure enterprise estate, with centralized management and monitoring at the [platform level](/azure/cloud-adoption-framework/ready/enterprise-scale/management-and-monitoring). You will be presented with key recommendations for your operations team, to maintain Azure Arc-enabled servers.

## Architecture

The following diagram shows conceptual reference architecture, that demonstrates how the Azure [connected machine agent](/azure/azure-arc/servers/agent-overview) communicates with the different management and monitoring capabilities in Azure.

![Azure connected machine agent architecture](./media/arc-connected-agent.svg)

## Design considerations

Here are some general design considerations for Azure Arc-enabled servers monitoring and management:

- **Azure Monitor requirements:** Azure Monitor can [collect data directly](/azure/azure-arc/servers/learn/tutorial-enable-vm-insights) from your Azure Arc-enabled servers into a Log Analytics workspace for detailed analysis and correlation. This will involve installing monitoring agents like the Log Analytics and dependency agents.
- **Azure Monitor agents deployment:** Review the [deployment options](/azure/azure-arc/servers/concept-log-analytics-extension-deployment) for the Azure Monitor agents.
- **Azure Monitor configuration:** Plan your Azure Arc-enabled servers [monitoring requirements](/azure/azure-monitor/agents/log-analytics-agent#data-collected), including metrics and log collection.
- **Azure connected machine agent management:** The Azure connected machine agent plays a critical role in your hybrid operations. It enables you to manage your Windows and Linux machines hosted outside of Azure, and enforce governance policies. It's important to implement solutions that keep track of unresponsive agents, monitor for new versions, and automate the deployment of upgrades.
- **Update Management for your hybrid resources:** Updates should be automated and installed in a timely manner, to make sure your Azure Arc-enabled servers have the latest operating system and security updates.

## Design recommendations

### Azure Monitor requirements

- Review and understand how the Log Analytics agent [operates and collects data](/azure/azure-monitor/agents/log-analytics-agent) before deployment.
- Review the [Network connectivity for Azure Arc-enabled servers](./eslz-arc-servers-connectivity.md) section of this guide, for network-specific design considerations and recommendations.
- Before onboarding any machine to Azure Monitor, it's important to review the [supported list of operating systems](/azure/azure-monitor/agents/agents-overview#supported-operating-systems) and the [network requirements](/azure/azure-monitor/agents/log-analytics-agent#network-requirements) of the monitoring agents.

### Azure Monitor agents deployment

- The Azure Monitor agents should be automatically deployed to Azure Arc-enabled Windows and Linux servers, through [Azure Policy](/azure/azure-monitor/deploy-scale), as part of the [enterprise-scale landing zone](/azure/cloud-adoption-framework/ready/enterprise-scale/management-and-monitoring).
- Logs should be stored centrally on the Log Analytics workspace, a dedicated platform, and control log access with Azure [role-based access control (RBAC)](/azure/azure-monitor/platform/design-logs-deployment#access-control-overview). If there's a requirement for a separate workspace due to management, data sovereignty, or compliance requirements, using a separate workspace can affect the ability to have a single pane of glass and event correlation, on your Azure Arc-enabled servers across the environment.

### Azure Monitor configuration

- Use [VM insights](/azure/azure-arc/servers/learn/tutorial-enable-vm-insights) to analyze the performance of your Azure Arc-enabled Windows and Linux servers. Monitor their processes and dependencies on other resources and external processes.
- Create [dashboards](/azure/azure-portal/azure-portal-dashboards) or [Azure Monitor workbooks](/azure/azure-monitor/visualize/workbooks-overview), to track the relevant metrics and events across your Azure Arc-enabled servers. Samples of Log Analytics queries and VM insights can be found in this [article](/azure/azure-monitor/vm/vminsights-log-search#performance-records).
- Configure the needed [performance counters](/azure/azure-monitor/agents/data-sources-performance-counters) for the Azure Arc-enabled Windows and Linux servers, on the dedicated Log Analytics workspace.
- Configure the needed [logs](/azure/azure-monitor/agents/log-analytics-agent#data-collected) for the Azure Arc-enabled Windows and Linux servers, on the dedicated Log Analytics workspace.

### Azure connected machine agent management

- Monitor the health of the Azure connected machine agent, by creating a [resource health alert](/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate), to keep track of Azure Arc-enabled servers not sending heartbeats.
- Create an [Azure Advisor alert](/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate), to identify Azure Arc-enabled servers that aren't using the latest version of the Azure connected machine agent.
- Review the Azure connected machine agent [upgrade methods](/azure/azure-arc/servers/manage-agent#upgrading-agent). Automate the upgrade process of the agent, to have the latest fixes and features.
- Understand how to upgrade [virtual machine extensions](/azure/azure-arc/servers/manage-vm-extensions), to keep other agents installed and managed by Azure Arc up to date.
- Monitor [this article](/azure/azure-arc/servers/agent-release-notes) for the latest releases, known issues, and bug fixes of the Azure connected machine agent.

### Update Management for your hybrid resources

- Use [Update Management](/azure/automation/update-management/overview) in Azure Automation, as a long-term patching mechanism for both Azure Arc-enabled Windows and Linux servers. This allows you to view and schedule operating system updates and patches for your Azure Arc-enabled servers at scale.
- Update Management will also allow you to automate the Azure connected machine agent upgrades, via Windows updates on Azure Arc-enabled Windows servers.

## Next steps

For more guidance for your hybrid cloud adoption journey,  review the following:

- Review [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/day2/) scenarios
- Review the [prerequisites](/azure/azure-arc/servers/agent-overview#prerequisites) for Azure Arc-enabled servers
- Plan an [at-scale deployment](/azure/azure-arc/servers/plan-at-scale-deployment) of Azure Arc-enable servers
- To learn more about Azure Arc, check out the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/)
