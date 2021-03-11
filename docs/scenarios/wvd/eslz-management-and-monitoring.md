---
title: "Enterprise-Scale management and monitoring for Windows Virtual Desktop"
description: Describe how this enterprise-scale scenario can improve management and monitoring of Windows Virtual Desktop
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/22/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Management and monitoring for Windows Virtual Desktop Enterprise-Scale scenario

## Platform Management & Monitoring

### Design Considerations

-	Utilize Azure Monitor Log Analytics Workspaces as the administrative boundary of logs.
-	Telemetry from the platform services to be collected.
    - Workspaces
    - Application Groups
    - Hostpools
- Performance Counters
  | Object | name	| Counter name | Instance name | Interval |	id |
| --- | --- | --- | --- | --- | --- |
| LogicalDisk |	% Free Space | C: |	60 | LogicalDisk, % Free Space, C: |
| PhysicalDisk | Avg. Disk sec/Read | * | 30 | PhysicalDisk, Avg. Disk sec/Read, * |
|PhysicalDisk |	Avg. Disk sec/Transfer | * | 30 | PhysicalDisk, Avg. Disk sec/Transfer, * |
| PhysicalDisk | Avg. Disk sec/Write	* | 30 | PhysicalDisk, Avg. Disk sec/Write, * |
| Process | % User Time	* | 30 | Process, % User Time, * |
| Process | Thread Count | * | 30 | Process, Thread Count, * |
| Process | % Processor Time | * | 20 | Process, % Processor Time, * |
| Process | IO Write Operations/sec	* | 30 | Process, IO Write Operations/sec, * | 
| Process | IO Read Operations/sec	* | 30 | Process, IO Read Operations/sec, * | 
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
| Memory | Available Mbytes | * | 30 | Memory, Available Mbytes, * |
| Memory | Page Faults/sec | * | 30 |Memory, Page Faults/sec, * |
| Memory | Pages/sec | * | 30 | Memory, Pages/sec, * | 
| Memory | % Committed Bytes In Use | * |30 | Memory, % Committed Bytes In Use, * |
| PhysicalDisk | Avg. Disk Queue Length | * | 30 | PhysicalDisk, Avg. Disk Queue Length, * | 
-	Dashboarding created from the platform logs to centralize visuals for reporting operations.

### Design Recommendations

-	Centralize your Azure Monitor Log Analytics workspace in the region of your Windows Virtual Desktop deployment.
-	Diagnostic settings can be exported to a storage account should there be a need to go beyond the two-year retention period.
-	Application Groups should be assigned to user groups for ease of user administration overhead.
-	Application Groups can be segregated in a multitude of ways. We recommend that separating them based on which department/user type (power, engineering, general etc.) the user is part of. 
-	Utilize the Workbooks on the [WVD Community GitHub](https://github.com/wvdcommunity) for visualizations of log data.

## Infrastructure Management & Monitoring

### Design Considerations

-	Utilizing the same log analytics workspace that’s used for the WVD platform.
-	Session Host Performance counters are collected and logged.
-	Network Performance Monitoring for user experience management.
-	Alerting model to be set up around the collected logs and metrics.
-	Windows Update management for the session hosts between feature updates.

### Design Recommendations

-	Centralized Azure Monitor Log Analytics workspace in the region of your session hosts.
-	Setting up the Performance Counters in accordance with the [Tech Community post](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/proactively-monitor-arm-based-windows-virtual-desktop-with-azure/ba-p/1508735).
-	Network Performance Monitor to be set up in the same region as your Virtual Network and Session Host(s).
-	Azure Policy and Governance from Enterprise Scale to incorporated into WVD landing zone.
