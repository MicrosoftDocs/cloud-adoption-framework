---
title: Enhanced management baseline in Azure
description: Common improvements to the management baseline
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: fasttrack-edit, AQC
ms.localizationpriority: high
---

# Enhanced management baseline in Azure

The first three cloud management disciplines describe a management baseline. The preceding articles in this guide outline a minimum viable product (MVP) for cloud management services, which is referred to as a management baseline. This article outlines a few common improvements to the baseline.

The purpose of a management baseline is to create a consistent offering that provides a minimum level of business commitment for *all* supported workloads. With this baseline of common, repeatable management offerings, the team can deliver highly optimized operational management with minimal deviation.

However, you might need a greater commitment to the business beyond the standard offering. The following image and list show three ways to go beyond the management baseline.

![Beyond the cloud management baseline](../../_images/manage/beyond-the-baseline.png)

- **Workload operations:**
  - Largest per-workload operations investment.
  - Highest degree of resiliency.
  - Suggested for the approximately 20% of workloads that drive business value.
  - Typically reserved for high-criticality or mission-critical workloads.
- **Platform operations:**
  - Operations investment is spread across many workloads.
  - Resiliency improvements affect all workloads that use the defined platform.
  - Suggested for the approximately 20% of platforms that have highest criticality.
  - Typically reserved for medium-criticality to high-criticality workloads.
- **Enhanced management baseline:**
  - Lowest relative operations investment.
  - Slightly improved business commitments using additional cloud-native operations tools and processes.

Both workload operations and platform operations require changes to design and architecture principles. Those changes can take time and might result in increased operating expenses. To reduce the number of workloads that require such investments, an enhanced management baseline can provide enough of an improvement to the business commitment.

This table outlines a few processes, tools, and potential effects common in customers' enhanced management baselines:

| Discipline  | Process  | Tool | Potential impact | Learn more |
|---|---|---|---|---|
|Inventory and visibility|Service change tracking|Azure Resource Graph|Greater visibility into changes to Azure services might help detect negative effects sooner or remediate faster.|[Overview of Azure Resource Graph](https://docs.microsoft.com/azure/governance/resource-graph/overview)|
|Inventory and visibility|IT service management (ITSM) integration|IT Service Management Connector|Automated ITSM connection creates awareness sooner.|[IT Service Management Connector (ITSMC)](https://docs.microsoft.com/azure/azure-monitor/platform/itsmc-overview)|
|Operational compliance|Operations automation|Azure Automation|Automate operational compliance for faster and more accurate response to change.|See the following sections|
|Operational compliance|Multicloud operations|Azure Automation Hybrid Runbook Worker|Automate operations across multiple clouds.|[Hybrid Runbook Worker overview](https://docs.microsoft.com/azure/automation/automation-hybrid-runbook-worker)|
|Operational compliance|Guest automation| Desired State Configuration (DSC)|Code-based configuration of guest operating systems to reduce errors and configuration drift.|[DSC Overview](https://docs.microsoft.com/powershell/scripting/dsc/overview/overview)|
|Protect and recover|Breach notification|Azure Security Center|Extend protection to include security-breach recovery triggers.|See the following sections|

::: zone target="docs"

## Azure Automation

::: zone-end
::: zone target="chromeless"

## [Azure Automation](#tab/AzureAutomation)

::: zone-end

Azure Automation provides a centralized system for the management of automated controls. In Azure Automation, you can run simple remediation, scale, and optimization processes in response to environmental metrics. These processes reduce the overhead associated with manual incident processing.

Most importantly, automated remediation can be delivered in near-real-time, significantly reducing interruptions to business processes. A study of the most common business interruptions identifies activities within your environment that could be automated.

### Runbooks

The basic unit of code for delivering automated remediation is a runbook. Runbooks contain the instructions for remediating or recovering from an incident.

To create or manage runbooks:

1. Go to [Azure Automation](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Automation%2FAutomationAccounts).
1. Select **Automation accounts** and choose one of the listed accounts.
1. Go to **Process automation**.
1. With the options presented, you can create or manage runbooks, schedules, and other automated remediation functionality.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Automation%2FAutomationAccounts]" submitText="Assign Policy" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end
::: zone target="docs"

## Azure Security Center

::: zone-end
::: zone target="chromeless"

## [Azure Security Center](#tab/AzureSecurityCenter)

::: zone-end

Azure Security Center also plays an important part in your protect-and-recover strategy. It can help you monitor the security of your machines, networks, storage, data services, and applications.

Azure Security Center provides advanced threat detection by using machine learning and behavioral analytics to help identify active threats targeting your Azure resources. It also provides threat protection that blocks malware and other unwanted code, and it reduces the surface area exposed to brute force and other network attacks.

When Azure Security Center identifies a threat, it triggers a security alert with steps you need for responding to an attack. It also provides a report with information about the detected threat.

Azure Security Center is offered in two tiers: Free and Standard. Features like security recommendations are available in the Free tier. The Standard tier provides additional protection like advanced threat detection and protection across hybrid cloud workloads.

::: zone target="chromeless"

### Action

#### Try Standard tier for free for your first 30 days

After you enable and configure security policies for a subscription's resources, you can view the security state of your resources and any issues on the **Prevention** pane. You can also view a list of those issues on the **Recommendations** tile.

::: form action="OpenBlade[#blade/Microsoft_Azure_Security/SecurityMenuBlade/SecurityMenuBlade/0]" submitText="Explore Azure Security Center" :::

::: zone-end

::: zone target="docs"

To explore Azure Security Center, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Security/SecurityMenuBlade/SecurityMenuBlade/0).

### Learn more

To learn more, see [Azure Security Center documentation](https://docs.microsoft.com/azure/security-center).

::: zone-end
