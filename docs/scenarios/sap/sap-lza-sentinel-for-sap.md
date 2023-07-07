---
title: Microsoft Sentinel for SAP on Azure
description: Learn recommendations for Microsoft Sentinel for SAP.
author: pankajmeshramCSA
ms.author: pameshra
ms.reviewer: tozimmergren
ms.date: 07/04/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# Microsoft Sentinel for SAP on Azure

This article is part of the "SAP extend and innovate security: Best practices" article series.

- [SQL Server database security for SAP on Azure](./sap-lza-database-security.md)
- [Microsoft Sentinel for SAP on Azure](./sap-lza-sentinel-for-sap.md)
- [Security operations for SAP on Azure](./sap-lza-security-operations.md)

The sections below outline key design considerations for deploying agents and the solution to protect SAP applications using Microsoft Sentinel. Specifically, the [Microsoft Sentinel Solution for SAP Applications](/azure/sentinel/sap/deployment-overview).

Consider these prerequisites:

- To collect the data from SAP systems, it's required to deploy a Microsoft Sentinel SAP connector.
- Each SAP SID/Client number combination requires the deployment of a separate connector.

## Microsoft Sentinel Solution for SAP Applications design considerations

- **Architecture** - SAP topology might include multiple SAP products spread across multiple System IDs, Clients, and instance numbers. Several "front-end" ABAP servers might be present. However, a connection to only one of the ABAP servers is required. Consider connecting to the Message server, which routes the connector to the correct ABAP server to gather data for a given SAP system.

- The Connector is deployed as a docker container on a host VM or physical server. It's currently supported to deploy the connector container on an on-premises machine and on an Azure-based VM. The data connector doesn't support a high availability configuration out-of-the-box. If a High Availability option is required, consider deploying the connector container into a Kubernetes cluster or on Azure Kubernetes Service [Introduction to Azure Kubernetes Service - Azure Kubernetes Service | Microsoft Learn](/azure/aks/intro-kubernetes)

For step-by-step configuration of AKS, see [Deploying Microsoft Sentinel Threat Monitoring for SAP agent into an AKS/Kubernetes cluster](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/deploying-microsoft-sentinel-threat-monitoring-for-sap-agent/ba-p/3528040)

> [!NOTE]
>AKS/Kubernetes deployment is currently the only way to achieve high availability of the data connector.

- When using Kubernetes cluster, It's only supported to have a single data connector fetching data from an SAP system into a single Azure Log Analytics workspace, that is, running multiple pods in Kubernetes cluster connecting to same SAP system and sending data to the same Azure Log Analytics workspace will result in multiple copies of the data being sent, which might cause increased charges for data retention. Consider the increased costs for this scenario.

- While using Docker containers, all the data from an SAP system can go into a single Azure Log analytics workspace.

- The server hosting the connector agents must be able to connect to all ABAP servers from which data retrieval is required. For example, the connector must be able to route and connect to the target ABAP servers using ports outlined in the documentation [Prerequisites for deploying Microsoft Sentinel Solution for SAP](/azure/sentinel/sap/prerequisites-for-deploying-sap-continuous-threat-monitoring#system-prerequisites)

Consider the strategy for alert consumption from Microsoft Sentinel—for example, Teams, email, or Mobile alerts.

- Consider the following when multiple connectors are hosted on a single machine:
  - Container name uses the `sapcon-<sid>` naming pattern, so connecting to multiple systems with the same SID is not possible.
  - If connecting to multiple systems (if different Client ID), use --multi-clients undocumented switch while running the kickstart script.
This causes the container to be created with the following name `sapcon-<sid>-<client>`.
  - Connecting to multiple systems with the same SID and Client ID (and perhaps a different System Number, or different systems (prod/dev/test)
that use same SID/Client ID/System Nr requires the deployment of the connector on different hosts. Note that Log Analytics data from such systems would be indistinguishable, so when working with systems that have identical SID/Client ID/System Number, it's recommended to use different Log Analytics workspaces to distinguish the data.

## SAP Application Servers design recommendations

- Using an SAP Connector to connect ABAP servers to Sentinel is recommended.
- SAP Connector is recommended to be installed on a separate virtual machine.
- Each SAP system with a unique system ID (SID) will require a separate SAP Connector.
- Ensure that the credentials used are stored in the Key Vault.
- In each SAP system, it's recommended to assign correct Roles and authorizations specific to Sentinel integration to pull the data.
- It's essential to enable SAP Table logging and ABAP logging in SAP systems being monitored.
- We recommend fine-tuning the SAP Connector to avoid short dumps and to pull the right amount of data.
- We recommend implementing an iterative process to fine-tune the alerts in Sentinel to eliminate false positives
  - Example: Allowing select users to run sensitive queries to avoid false positives.

## SAP HANA Database Server design considerations

- Microsoft Sentinel relies on the logs pushed to its workspace by HANA through SYSLOG. No SAP connector is used in this scenario as we use in SAP Application server monitoring.

- To push HANA SYSLOG to Sentinel workspace, Azure Monitoring Agent (Azure Monitor Agent overview - Azure Monitor | Microsoft Learn) is installed in parallel to standard OMS(Operations Management Suite), which pushes data to our telemetry workspace by default. These AMA logs can be directed to the Sentinel Workspace.

- By default, the HANA auditing trail is written to a Database table called CSTABLE. Various functionalities used by the security team (e.g., capture of Firefighter logins) consume the audit logs from the databases. Hence we can't repoint the default logging to SYSLOG. However, we can redirect different audit trails to different targets. Thus, all the Sentinel-related audit policies point to Level "Alert". All "Alert" level logs are directed to SYSLOG with this change.

## Design considerations for Rules in Microsoft Sentinel

During the analysis and design phase, ensure you do the following:
  
- **Review existing rules**: Determine what [build-in analytics rules](/azure/sentinel/sap/sap-solution-security-content#built-in-analytics-rules) exist for SAP and Sentinel.
- **Establish scope:** Define the scope and use cases for your situation.
- **Rule criteria:** Establish criteria for rule identification and prioritization.
- **Rule prioritization:** Identify and prioritize the rules for implementation.

Establish a process for reviewing/validating alerts to identify false positives and adjust query logic and watchlist entries accordingly.

- Use Watchlists to correlate data from a data source you provide with the events in your Microsoft Sentinel environment
  - For example, you might create a watchlist with a list of high-value assets, terminated employees, or service accounts in your environment.
  - Existing rules use static watchlists that contain a list of users; however, rules can be authored to provide Sentinel with a refreshable dynamic data source of assets that Sentinel should evaluate.
  - Analytic rules leverage the use of the SAP_USER_CONFIG watchlist. Suppose a particular user or entity generates an excessive number of alerts. In that case, it can be added to the watchlist with tags, such as MassiveLogonsOK, or MassiveRFCOK, to prevent such users from generating noise.

- Use the [built-in workbooks](/azure/sentinel/sap/sap-solution-security-content#built-in-workbooks) that can be used to identify gaps in data & monitor system health

- Use exfiltration rules to monitor data loss:
  - [Microsoft Sentinel solution for SAP® applications - data exfiltration rules](/azure/sentinel/sap/sap-solution-security-content#data-exfiltration)
  - [Microsoft Sentinel Solution for SAP® Applications - New data exfiltration detection rules](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/microsoft-sentinel-solution-for-sap-applications-new-data/ba-p/3716881)

## Next steps

- [SAP Security on Azure: Security Operations](./sap-lza-security-operations.md)
