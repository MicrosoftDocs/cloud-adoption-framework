---
title: Management baseline for Azure Virtual Desktop
description: Learn how the management baseline can improve the management and monitoring of Azure Virtual Desktop.
author: Zimmergren
ms.author: martinekuan
ms.reviewer: tozimmergren
ms.date: 01/04/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd, engagement-fy23
---

# Management baseline considerations for an Azure Virtual Desktop

Achieve operational excellence and customer success by correctly designing your Azure Virtual Desktop environment with management and monitoring in mind.

## Platform management and monitoring

Review the following considerations and recommendations for platform management and monitoring of Azure Virtual Desktop.

- Explore how to [Use Azure Virtual Desktop Insights](/azure/virtual-desktop/insights) to monitor your Azure Virtual Desktop deployment.
- Configure [session host data settings](/azure/virtual-desktop/insights#session-host-data-settings) to collect information on your Azure Virtual Desktop session hosts.
- Review the guidance for [designing a Log Analytics workspace architecture](/azure/azure-monitor/logs/workspace-design) to make informed decisions on how you set up your Log Analytics workspaces. Plan for Log Analytics workspaces to be used across Azure Virtual Desktop deployments and make special note of any regional data requirements that applies to your organization.
- Configure diagnostic settings to [send monitoring data to a storage account](/azure/azure-monitor/essentials/resource-logs#send-to-azure-storage) if there's a need to go beyond the two-year retention period.
- Determine performance objects of interest and plan for appropriate retention intervals for session host data. Learn how to set up the correct [workspace performance counters](/azure/virtual-desktop/insights#workspace-performance-counters).
- Enable monitoring of connection quality to maintain a good user experience management. Read [Monitor connection quality with Azure Log Analytics](/azure/virtual-desktop/connection-latency#monitor-connection-quality-with-azure-log-analytics).
- Learn how to configure [data retention and archive policies in Azure Monitor](/azure/azure-monitor/logs/data-retention-archive) to help you configure retention intervals for session host data.
- Consider estimating the usage of Azure Virtual Desktop, allowing you to be prepared for any cost implications. Explore how to [estimate Azure Virtual Desktop monitoring costs](/azure/virtual-desktop/insights-costs).
- It's recommended to [set up the Azure Virtual Desktop Insights configuration workbook](/azure/virtual-desktop/insights#set-up-using-the-configuration-workbook) to ensure your configuration is correct, and to stay updated when there are new product updates that require new settings.

- For more troubleshooting insights, collect the following Windows event logs into the Azure Monitor Log Analytics workspace.

   **Windows Event Log name**

  - `System`
    - `Application`
    - `Microsoft-Windows-TerminalServices-LocalSessionManager/Operational`
    - `Microsoft-FSLogix-Apps/Operational`
    - `Microsoft-Windows-TerminalServices-RemoteConnectionManager/Admin`
    - `Microsoft-FSLogix-Apps/Admin`

Read more about [creating data collection rules](/azure/azure-monitor/agents/data-collection-rule-azure-monitor-agent#create-a-data-collection-rule) in Azure Monitor.

- Use [Azure Virtual Desktop Insights](/azure/virtual-desktop/insights) for ease of configuration.

- Assign application groups to user groups to ease your administration overhead.

- Application groups can be segregated in many ways. We recommend separating them based on which department or user type (for example, power, engineering, or general) the user is a part of.

For a glossary, data storage cost estimations, and more troubleshooting guidance, see [Azure Monitor next steps](/azure/virtual-desktop/azure-monitor#next-steps).

## Infrastructure management and monitoring

Review the following considerations and recommendations for infrastructure management and monitoring of Azure Virtual Desktop.

- Use the same Log Analytics workspace that's used for the Azure Virtual Desktop platform.

- Use Windows Update Management for the session hosts between feature updates.

- Design an alerting strategy to maintain a good user experience. Read [configure alerts](/azure/virtual-desktop/insights#optional-configure-alerts) to be more proactive in troubleshooting issues and act on performance signals that might require attention.

- Use a centralized Azure Monitor Log Analytics workspace in the region of your session hosts.

- Consider the governance and security monitoring needs of your infrastructure. Incorporate Azure policies and governance for enterprise-scale into the Azure Virtual Desktop landing zone.

- The [security baseline for Azure Virtual Desktop](/security/benchmark/azure/baselines/virtual-desktop-security-baseline#data-protection) has relevant Azure Policy Definitions listed, helping you measure compliance to the Azure Security Benchmark. Using the security baseline helps establishing a good security monitoring and governance of your Azure Virtual Desktop infrastructure.

- Use the [Log Analytics for the diagnostics feature](/azure/virtual-desktop/diagnostics-log-analytics)) to let admins identify issues through a single interface. With this capability, the service creates activity logs for both user and administrative actions.
