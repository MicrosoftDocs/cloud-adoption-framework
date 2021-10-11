---
title: Enhanced management baseline in Azure
description: Use the Cloud Adoption Framework for Azure to understand common improvements to the management baseline.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.localizationpriority: high
ms.custom: internal, fasttrack-edit, AQC
---

# Enhanced management baseline in Azure

The first three cloud management disciplines describe a management baseline. The preceding articles in this guide outline a minimum viable product (MVP) for cloud management services, which is referred to as a management baseline. This article outlines a few common improvements to the baseline.

The purpose of a management baseline is to create a consistent offering that provides a minimum level of business commitment for **all** supported workloads. With this baseline of common, repeatable management offerings, the team can deliver highly optimized operational management with minimal deviation.

However, you might need a greater commitment to the business beyond the standard offering. The following image and list show three ways to go beyond the management baseline.

![Beyond the cloud management baseline](../../_images/manage/beyond-the-baseline.png)

- **Enhanced management baseline:**
  - Add enhancements to the management baseline, when the majority of workloads in the portfolio have a shared requirement.
  - Improved business commitments using additional cloud-native operations tools and processes.
  - Baseline enhancements should have no impact on the architecture of specific workloads.
- **Workload operations:**
  - Largest per-workload operations investment.
  - Highest degree of resiliency.
  - Suggested for the approximately 20 percent of workloads that drive business value.
  - Typically reserved for high-criticality or mission-critical workloads.
- **Platform operations:**
  - Operations investment is spread across many workloads.
  - Resiliency improvements affect all workloads that use the defined platform.
  - Suggested for the approximately 20 percent of platforms that have highest criticality.
  - Typically reserved for medium-criticality to high-criticality workloads.

Both workload operations and platform operations require changes to design and architecture principles. Those changes can take time and might result in increased operating expenses. To reduce the number of workloads that require such investments, an enhanced management baseline can provide enough of an improvement to the business commitment.

<!-- cspell:ignore ITSMC -->
<!-- docutune:casing "IT Service Management" "IT Service Management Connector" "Free and Standard" -->

This table outlines a few processes, tools, and potential effects common in customers' enhanced management baselines:

| Discipline | Process | Tool | Potential impact | Learn more |
|---|---|---|---|---|
| Inventory and visibility | Service change tracking | Azure Resource Graph | Greater visibility into changes to Azure services might help detect negative effects sooner or remediate faster. | [Overview of Azure Resource Graph](/azure/governance/resource-graph/overview) |
| Inventory and visibility | Visualize Data | Azure Sentinel | Instant visualization and analysis of data | [Sentinel visualize collected data](/azure/sentinel/get-visibility) |
| Inventory and visibility | IT Service Management (ITSM) integration | IT Service Management Connector | Automated ITSM connection creates awareness sooner. | [IT Service Management Connector (ITSMC)](/azure/azure-monitor/alerts/itsmc-overview) |
| Operational compliance | Operations automation | Azure Automation | Automate operational compliance for faster and more accurate response to change. | See the following sections |
| Operational compliance | Zero trust | Azure Sentinel | Zero Trust workbook uses the full breadth of Microsoft security offerings |[Sentinel Zero trust Workbook](/azure/sentinel/whats-new#zero-trust-tic30-workbook) |
| Operational compliance | Performance automation | Azure Automation | Automate operational compliance with performance expectations to resolve common resource specific scaling or sizing issues. | See the following sections |
| Operational compliance | Multicloud operations | Azure Automation Hybrid Runbook Worker | Automate operations across multiple clouds. | [Hybrid Runbook Worker overview](/azure/automation/automation-hybrid-runbook-worker) |
| Operational compliance | Guest automation | Desired State Configuration (DSC) | Code-based configuration of guest operating systems to reduce errors and configuration drift. | [DSC overview](/powershell/scripting/dsc/overview/overview) |
| Protect and recover | Breach notification | Azure Security Center | Extend protection to include security-breach recovery triggers. | See the following sections |
| Protect and recover | Threat Hunting | Azure Sentinel | Built in hunting queries that help you detect and protect against malicious activity  | [Sentinel Threat Hunting](/azure/sentinel/hunting) |

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

1. Go to **Azure Automation**.
1. Select **Automation accounts** and choose one of the listed accounts.
1. Go to **Process automation**.
1. With the options presented, you can create or manage runbooks, schedules, and other automated remediation functionality.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Automation%2FAutomationAccounts]" submitText="Go to Azure Automation" :::

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

To learn more, see [Azure Security Center documentation](/azure/security-center/).

::: zone-end

## Azure Sentinel

Azure Sentinel is a cloud-native security information event management (SIEM) and security orchestration automated response (SOAR) solution that plays a role, not only in your Enhanced management baseline in Azure but also in the Enhanced Baseline, Platform Operations and Workload Operations. 

Azure Sentinel allows you to Collect Data, Detect Threats, Investigate Incidents and Respond using Automation. Upon enabling the solution the ability to connect and collect data from Azure, On-premises or any other cloud provider becomes available. There are over a hundred Data Connectors available including Office 365 Audit Logs, Azure Activity Logs, Cisco Umbrella, Trend Micro TippingPoint, Sophos Cloud Optix, VMWare ESXi and many others that simplify your integration into Sentinel from existing investments. 

Azure Sentinel can be enabled at no additional cost on an Azure Monitor Log Analytics workspace for the first 31-days. See more [Azure Sentinel Pricing](https://azure.microsoft.com/pricing/details/azure-sentinel/).

### Learn more about Azure Sentinel

To explore Azure Sentinel, go to the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/microsoft.securityinsightsarg%2Fsentinel)

To learn more, see [Azure Sentinel documentation](/azure/sentinel/).

Want to become an Azure Sentinel Ninja, see [Azure Sentinel Ninja Training](https://techcommunity.microsoft.com/t5/azure-sentinel/become-an-azure-sentinel-ninja-the-complete-level-400-training/ba-p/1246310)
