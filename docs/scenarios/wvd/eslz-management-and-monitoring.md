---
title: Management baseline for Azure Virtual Desktop
description: Learn how the management baseline can improve the management and monitoring of Azure Virtual Desktop.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Management baseline considerations for an Azure Virtual Desktop

Achieve operational excellence and customer success by properly designing your Azure Virtual Desktop environment with management and monitoring in mind.

## Platform management and monitoring

Review the following considerations and recommendation for platform management and monitoring of Azure Virtual Desktop.

### Design considerations

- Use Azure Monitor Log Analytics workspaces as the administrative boundary of logs.
- Collect telemetry from the following platform services:
  - Workspaces
  - Host pools
- Performance counters should be collected.
- Azure event logs should be collected.
- Create a dashboard from the platform logs to centralize visuals for reporting operations.
- Learn to [use Azure Monitor for Azure Virtual Desktop to monitor your deployment](/azure/virtual-desktop/azure-monitor).

### Design recommendations

- Use a separate dedicated Azure Monitor Log Analytics workspace for Azure Virtual Desktop.
- Centralize your Azure Monitor Log Analytics workspace in the region of your Azure Virtual Desktop deployment.
- Export diagnostic settings to a storage account if there's a need to go beyond the two-year retention period.
- Enable the platform service diagnostic telemetry stated in the considerations to go to the Azure Monitor Log Analytics workspace.
- The following Windows performance counters should be collected by Log Analytics for Azure Virtual Desktop monitoring:

  <!-- docutune:disable -->

  | Object name | Counter name | Instance name | Interval | ID |
  | --- | --- | --- | --- | --- |
  | LogicalDisk | % Free Space | C: | 60 | LogicalDisk, % Free Space, C: |
  | PhysicalDisk | Avg. Disk sec/Read | * | 30 | PhysicalDisk, Avg. Disk sec/Read, * |
  | PhysicalDisk | Avg. Disk sec/Transfer | * | 30 | PhysicalDisk, Avg. Disk sec/Transfer, * |
  | PhysicalDisk | Avg. Disk sec/Write | * | 30 | PhysicalDisk, Avg. Disk sec/Write, * |
  | Processor Information | % Processor Time | _Total | 30 | Processor Information, % Processor Time, _Total |
  | Terminal Services | Active Sessions | * | 60 | Terminal Services, Active Sessions, * |
  | LogicalDisk | Avg. Disk Queue Length | C: | 30 | LogicalDisk, Avg. Disk Queue Length, C: |
  | Terminal Services | Inactive Sessions | * | 60 | Terminal Services, Inactive Sessions, * |
  | Terminal Services | Total Sessions | * | 60 | Terminal Services, Total Sessions, * |
  | User Input Delay per Process | Max Input Delay | * | 30 | User Input Delay per Process, Max Input Delay, * |
  | User Input Delay per Session | Max Input Delay | * | 30 | User Input Delay per Session, Max Input Delay, * |
  | RemoteFX Network | Current TCP RTT | * | 30 | RemoteFX Network, Current TCP RTT, * |
  | RemoteFX Network | Current UDP Bandwidth | * | 30 | RemoteFX Network, Current UDP Bandwidth, * |
  | LogicalDisk | Avg. Disk sec/Transfer | C: | 60 | LogicalDisk, Avg. Disk sec/Transfer, C: |
  | LogicalDisk | Current Disk Queue Length | C: | 30 | LogicalDisk, Current Disk Queue Length, C: |
  | Memory | Available MB | * | 30 | Memory, Available MB, * |
  | Memory | Page Faults/sec | * | 30 |Memory, Page Faults/sec, * |
  | Memory | Pages/sec | * | 30 | Memory, Pages/sec, * |
  | Memory | % Committed Bytes In Use | * |30 | Memory, % Committed Bytes In Use, * |
  | PhysicalDisk | Avg. Disk Queue Length | * | 30 | PhysicalDisk, Avg. Disk Queue Length, * |

  <!-- docutune:enable -->

- Collect the following Windows event logs into the Azure Monitor Log Analytics workspace.

   **Windows Event Log name**

  - `System`
    - `Application`
    - `Microsoft-Windows-TerminalServices-LocalSessionManager/Operational`
    - `Microsoft-FSLogix-Apps/Operational`
    - `Microsoft-Windows-TerminalServices-RemoteConnectionManager/Admin`
    - `Microsoft-FSLogix-Apps/Admin`

- Use [Azure Monitor for Azure Virtual Desktop](/azure/virtual-desktop/azure-monitor) for ease of configuration.

- Assign application groups to user groups to ease your administration overhead.

- Application groups can be segregated in many ways. We recommend separating them based on which department or user type (for example, power, engineering, or general) the user is a part of.

For a glossary, data storage cost estimations, and additional troubleshooting guidance, see [Azure Monitor next steps](/azure/virtual-desktop/azure-monitor#next-steps).

## Infrastructure management and monitoring

Review the following considerations and recommendation for infrastructure management and monitoring of Azure Virtual Desktop.

### Design considerations: Infrastructure

- Use the same Log Analytics workspace that's used for the Azure Virtual Desktop platform.
- The session host performance counters are collected and logged.
- Use network performance monitoring for user experience management.
- Set up an alerting model around the collected logs and metrics.
- Use Windows Update Management for the session hosts between feature updates.

### Design recommendations: Infrastructure

- Use a centralized Azure Monitor Log Analytics workspace in the region of your session hosts.
- Set up the performance counters according to the [documentation](/azure/virtual-desktop/azure-monitor#set-up-performance-counters).
- Set up the Network Performance Monitor in the same region as your Azure Virtual Network and session hosts.
- Incorporate Azure policies and governance for enterprise-scale into the Azure Virtual Desktop landing zone.
