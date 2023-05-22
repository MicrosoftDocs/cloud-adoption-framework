---
title: SAP Security with Azure-Sentinel for SAP
description: Learn recomendations for Microsoft Sentinel for SAP.
author: pankajmeshramCSA
ms.author: pameshra
ms.date: 05/22/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# SAP Security on Azure: Sentine for SAP
This article is Part 2 of the SAP extend and innovate security: Best practices series. For the first article in the series,
see [Database Security - SQL](./sap-lza-database-security.md)

## Microsoft Sentinel solution for SAP Applications
This article outlines key design considerations for deploying agents and the solution to protect SAP applications using Microsoft Sentinel.
•	To collect the data from SAP systems, it is required to deploy a connector. 
•	Each SAP SID/Client number combination requires deployment of a separate connector.


### Design considerations and Recommendations

- **Architecture** - SAP topology may include multiple SAP products, spread across multiple System IDs, Clients and instance numbers. Several “front-end” ABAP servers may be present, however a connection to only one of the ABAP servers is required. Consider connecting to Message server which routes the connector to the right ABAP server which will be used to gather data for a given SAP system.

-	The Connector is deployed as a docker container on a host VM or physical server. It is currently supported to deploy the connector container on an on-premises machine, as well as on Azure-based VM. Data connector does not support a high availability configuration out-of-the-box. If High Availability option is required, consider deploying the connector container into a Kubernetes cluster or on Azure Kubernetes Service [Introduction to Azure Kubernetes Service - Azure Kubernetes Service | Microsoft Learn](https://learn.microsoft.com/en-us/azure/aks/intro-kubernetes)

For step by step configuration of AKS, please see the doc here – 
[Deploying Microsoft Sentinel Threat Monitoring for SAP agent into an AKS/Kubernetes cluster](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/deploying-microsoft-sentinel-threat-monitoring-for-sap-agent/ba-p/3528040)

> [!NOTE]
>AKS/Kubernetes deployment is currently the only way to achieve high availability of the data connector. 


- When using Kubernetes cluster, It is only supported to have a single data connector fetching data from a SAP system into a single Azure Log Analytics workspace, i.e., running multiple pods in Kubernetes cluster connecting to same SAP system and sending data to same Azure Log Analytics workspace will result in multiple copies of the data being sent, which may cause increased charges for data retention. Consider the increased charges for this scenario.

- While using Docker containers, all the data from an SAP system can go into a single Azure Log analytics workspace. 

- The server hosting the connector agents must be able to connect to all ABAP servers from which data retrieval is required. For example, the connector must be able to route and connect to the target ABAP servers using ports outlined in the documentation [Prerequisites for deploying Microsoft Sentinel Solution for SAP](https://learn.microsoft.com/en-us/azure/sentinel/sap/prerequisites-for-deploying-sap-continuous-threat-monitoring#system-prerequisites)

- Consider the strategy for consumption of alerts from Sentinel. Example: Teams alert, email alerts, Mobile alerts, etc.

- Consider the following when multiple connectors are hosted on a single machine 

      - Container name uses the sapcon-<sid> naming pattern, so connecting to multiple systems with same SID is not possible.
      - If connecting to multiple systems (if different Client ID), use --multi-clients undocumented switch while running the kickstart script. 
        This will cause the container to be created with the following name sapcon-<sid>-<client>. 
      - Connecting to multiple systems with same SID and Client ID (and perhaps a different System Number, or just different systems (prod/dev/test)
        that use same SID/Client ID/System Nr requires deployment of the connector on different hosts. It must be remarked, that in Log Analytics data from such systems would be indistinguishable, so when working with systems that have identical SID/Client ID/System Number, it is recommended to use different Log Analytics workspaces to be able to distinguish the data. 

### Design Recommendations for SAP Application Servers 

- It is recommended to use an SAP Connector to connect ABAP servers to Sentinel.
- SAP Connector is recommended to be installed on a separate virtual machine.
- Each SAP system with a unique system ID (SID), will require a separate SAP Connector.
- Ensure that the credentials used are stored in the in Key Vault. 
- It is recommended, in each SAP system to assign correct Roles and authorizations specific to Sentinel integration to pull the data.
- It is important to enable SAP Table logging and ABAP logging in SAP systems being monitored. 
- We recommend fine tuning the SAP Connector to avoid short dumps, to pull the right amount of data. 
- We recommend implementing an iterative process to fine tune the alerts in Sentinel in order to eliminate false positives
     Example: Allowing select users to run sensitive queries to avoid false positives.


### Design considerations for SAP HANA Database Server
- Microsoft Sentinel relies on the logs pushed to its workspace by HANA through SYSLOG. No SAP connector is used in this scenario like we use in SAP Application server monitoring.
- To push HANA SYSLOG to Sentinel workspace, Azure Monitoring Agent (Azure Monitor Agent overview - Azure Monitor | Microsoft Learn) is installed in parallel to standard OMS(Operations Management Suite), which is pushing data to our telemetry workspace by default. These AMA logs can be directed to the Sentinel Workspace.
- By default, the HANA auditing trail is written to Database table called CSTABLE. There are various functionalities used by security team (e.g capture of Firefighter logins) which are consuming the audit logs from the databases, hence we cannot repoint the default logging to SYSLOG. However, we can redirect different audit trails to different targets. Thus, all the Sentinel related audit policies will point to Level “Alert”. All “Alert” level logs will be direct to SYSLOG with this change.

## Design considerations for Rules in Sentinel
- During the analysis and design phase,
     - Define scope and use cases 
     - Establish criteria for rule identification and prioritization
     - Identify and prioritize the rules for implementation (e.g. Critical action, SOX, etc.)
- Start with some generally applicable rules, such as:
     - User Creates and uses new user - Identifies a user creating and using other users.
     - Change in a Sensitive Privileged User - Identifies changes of sensitive privileged users.
     - Client Configuration Change - Identifies changes for client configuration such as: Client role, Changes recording mode.
     - Deactivation of Security Audit Log - Identifies deactivation of Security Audit Log
     - Sensitive User's Password Change and Log in - Identifies password changes for privileged users.
     - User Unlocks and uses other users - A user unlocked another, and then used the other's user credentials.
     - Function Module tested - Identifies testing of a function module.
     - Login from unexpected network - Identifies logons from an unexpected network.
     - Data has Changed during Debugging Activity - Identifies changes for runtime data during a debugging activity.
     - Execution of Sensitive Function Module - Identifies execution of a sensitive ABAP Function Module.
     - Dialog logon attempt from a privileged user - Identifies dialog logon attempts by privileged users on SAP system.
     - Execution of a Sensitive ABAP Program - Identifies direct execution of a sensitive ABAP program.
     - System Configuration Change - Identifies changes for system configuration.
     - Multiple Logons by User - Identifies logon of the same user from several subnets within scheduled time interval.
     - Sensitive Tables Direct Access By RFC Logon - Identifies generic table access by RFC logon
     - Transaction is unlocked - Identifies unlocking of a transaction.
     - Sensitive Tables Direct Access By Dialog Logon - Identifies generic table access by dialog logon
     - Security Audit Log Configuration Change - Identifies changes for configuration in Security Audit Log
     - Critical authorizations assignment - New User Assignment - Identifies assignment of a critical authorization object value to a new user.
     - Debugging Activities - Identifies all debugging related activities.
     - RFC Execution of a Sensitive Function Module- RFC Execution of a Sensitive Function Module
     - Sensitive privileged user makes a change in another user- Identifies changes  of sensitive privileged users in other users.
     - Execution of a Sensitive Transaction Code- Identifies execution of a sensitive Transaction Code
     - Sensitive Privileged User Logged in - Identifies Dialog logon of a sensitive privileged user.
     - Assignment of a sensitive role- Identifies new assignments for a sensitive role to a user.
     - Assignment of a sensitive profile - Identifies new assignments of a sensitive profile to a user.
     - Brute Force (RFC) - Identifies brute force attacks on the SAP system using RFC logons
     - Multiple Password Changes - Identifies multiple password changes at different levels. 
     - Sensitive Role Changes- Identifies changes in sensitive roles.
     - Multiple Logons by IP- Identifies logon of several users from same IP within scheduled time interval.


- Establish process for reviewing / validating alerts to identify false positives and adjust query logic and watchlist entries accordingly  
- Use Watchlists to correlate data from a data source you provide with the events in your Microsoft Sentinel environment
      - For example, you might create a watchlist with a list of high-value assets, terminated employees, or service accounts in your environment. 
      - Existing rules leverage static watchlists, that contain list of users, however rules can be authored to provide sentinel with a 
        refreshable dynamic data source of assets that should be evaluated by Sentinel. 
      - Analytic rules leverage use of the SAP_USER_CONFIG watchlist. If a particular user or entity generates an excessive amount of alerts, it can be added to the watchlist with tags, such as MassiveLogonsOK, or MassiveRFCOK, to prevent such users from generating noise. 

- Use Workbooks which can be used to identify gaps in data & monitor system health
- Use exfiltration rules to monitor data loss; for more information, refer here - [Microsoft Sentinel Solution for SAP® Applications - New data exfiltration detection rules](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/microsoft-sentinel-solution-for-sap-applications-new-data/ba-p/3716881)


## Next steps

- [ Security Operations ](./sap-lza-security-operations.md)