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
