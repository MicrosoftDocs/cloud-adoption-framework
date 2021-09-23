---
title: Enterprise-scale Arc Server Management and Monitoring
description: Understand the design considerations and recommendations for management and monitoring of Arc enabled servers
author: "Seif Bassem, Aruthur Clares, Islam Gomaa"
ms.author: "sebassem,arthur.clares,islam.gomaa"
ms.date: 09/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-arc
---

# Management and monitoring for Azure Arc enabled servers enterprise-scale scenario

Azure Arc-enabled servers enables you to manage your Windows and Linux physical servers and virtual machines hosted outside of Azure, on your corporate network, or other cloud provider.  This document is written to help you operationally maintain Azure Arc resources on Azure enterprise estate, with centralized management and monitoring at the platform level. The article presents key recommendations for operations teams to maintain Azure Arc systems.

## Design considerations

Here are some general design considerations for Azure Arc-enabled servers monitoring and management:

- Review the [supported list of operating systems](https://docs.microsoft.com/en-us/azure/azure-monitor/agents/agents-overview#supported-operating-systems) for the monitoring agents.
- Review the [network requirements](https://docs.microsoft.com/en-us/azure/azure-monitor/agents/log-analytics-agent#network-requirements) for the agents to communicate with Azure Monitor.
- The Azure monitor agents should be automatically deployed to arc-enabled servers through Azure Policy as part of the Enterprise scale landing zone.
- The Connected machine agent should be monitored for heartbeat connectivity to the platform.
- The Connected Machine agent is updated regularly to address bug fixes, stability enhancements, and new functionality. Updates should be monitored and deployed automatically.
- To move an arc-enabled server to another region, review [this guidance](https://docs.microsoft.com/en-us/azure/azure-arc/servers/manage-howto-migrate).

## Design recommendations

Here are some general design recommendations for Azure Arc monitoring and management:

- Logs should be stored centrally to the dedicated platform Log Analytics workspace and [control log access with Azure Role-based access control](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/design-logs-deployment#access-control-overview) . If there is a requirement for a separate workspace due to management/data sovereignty/compliance requirements , this can impact the ability to have a single pane of glass and event correlation of your arc-enabled servers across the envrionment.
- Use VM insights to analyze the performance of your Windows and Linux VMs and monitor their processes and dependencies on other resources and external processes.
- Configure the needed performance counters for the arc-enabled Windows and Linux VMs on the dedicated log analytics workspace.
- Configure the logs that need to be collected for the arc-enabled Windows and Linux VMs on the dedicated log analytics workspace.
- Create a [resource health alert](https://docs.microsoft.com/en-us/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate) to monitor servers not sending heartbeats.
- Create an [Azure Advisor alert](https://docs.microsoft.com/en-us/azure/azure-arc/servers/plan-at-scale-deployment#phase-3-manage-and-operate) to identify arc-enabled servers that are not using the latest version of the connected machine agent.
- Use Update management in Azure automation to automatically upgrade the agent on Windows arc-enabled servers via Windows updates.
- For Linux arc-enabled servers, review the connected machine agent [upgrade methods](https://docs.microsoft.com/en-us/azure/azure-arc/servers/manage-agent#upgrading-agent).

## Learn before you start

- Check for [Azure Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/) scenarios that may help you with proof of concept and basic understanding.
