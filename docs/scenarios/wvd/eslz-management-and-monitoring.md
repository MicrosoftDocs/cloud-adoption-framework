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
    - Hostpools
- Performance Counters should be collected.
- Windows Event Logs should be collected.
- Dashboarding created from the platform logs to centralize visuals for reporting operations.
- [Windows Virtual Desktop Monitoring documentation](https://docs.microsoft.com/azure/virtual-desktop/azure-monitor) should be used as additional guidelines.

### Design Recommendations

- A separate dedicated Azure Monitor Log Analytics Workspace should be used for Windows Virtual Desktop.
- Centralize your Azure Monitor Log Analytics workspace in the region of your Windows Virtual Desktop deployment.
- Diagnostic settings can be exported to a storage account should there be a need to go beyond the two-year retention period.
- Platform service diagnostic telemetry stated in the considerations should be enabled to go to the Azure Monitor Log Analytics Workspace.
- The following Windows Performance Counters should be collected by Log Analytics for WVD Monitoring.

| Object name | Counter name | Instance name | Interval | id |
| --- | --- | --- | --- | --- |
| LogicalDisk |	% Free Space | C: |	60 | LogicalDisk, % Free Space, C: |
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
| Memory | Available Mbytes | * | 30 | Memory, Available Mbytes, * |
| Memory | Page Faults/sec | * | 30 |Memory, Page Faults/sec, * |
| Memory | Pages/sec | * | 30 | Memory, Pages/sec, * | 
| Memory | % Committed Bytes In Use | * |30 | Memory, % Committed Bytes In Use, * |
| PhysicalDisk | Avg. Disk Queue Length | * | 30 | PhysicalDisk, Avg. Disk Queue Length, * | 

- The following Windows Event Logs should be collected into the Azure Monitor Log Analytics Workspace.

| Windows Event Log Name |
| --- |
| System |
| Application |
| Microsoft-Windows-TerminalServices-LocalSessionManager/Operational |
| Microsoft-FSLogix-Apps/Operational |
| Microsoft-Windows-TerminalServices-RemoteConnectionManager/Admin |
| Microsoft-FSLogix-Apps/Admin |

- [Monitoring for Windows Virtual Desktop](https://docs.microsoft.com/azure/virtual-desktop/azure-monitor) should be utilized for ease of configuration.
- Application Groups should be assigned to user groups for ease of user administration overhead.
- Application Groups can be segregated in a multitude of ways. We recommend that separating them based on which department/user type (power, engineering, general etc.) the user is part of. 
- For glossary, data storage cost estimations, and further troubleshooting, see the [Next Steps](https://docs.microsoft.com/azure/virtual-desktop/azure-monitor#next-steps) part of the documentation

## Infrastructure Management & Monitoring

### Design Considerations

-	Utilizing the same log analytics workspace that’s used for the WVD platform.
-	Session Host Performance counters are collected and logged.
-	Network Performance Monitoring for user experience management.
-	Alerting model to be set up around the collected logs and metrics.
-	Windows Update management for the session hosts between feature updates.

### Design Recommendations

-	Centralized Azure Monitor Log Analytics workspace in the region of your session hosts.
-	Setting up the Performance Counters in accordance with the [documentation](https://docs.microsoft.com/azure/virtual-desktop/azure-monitor#set-up-performance-counters).
-	Network Performance Monitor to be set up in the same region as your Virtual Network and Session Host(s).
-	Azure Policy and Governance from Enterprise Scale to incorporated into WVD landing zone.
