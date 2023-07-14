---
title: Microsoft Sentinel for SAP on Azure
description: Learn recommendations for deploying agents by using Microsoft Sentinel solution for SAP applications, SAP application servers, and SAP HANA database servers.
author: pankajmeshramCSA
ms.author: pameshra
ms.reviewer: tozimmergren
ms.date: 07/17/2023
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

Prerequisites for this scenario:

- To collect the data from SAP systems, you must deploy a Microsoft Sentinel SAP connector.
- You must deploy a separate connector for each SAP security identifier (SID) and client number combination.

## Design considerations

This article outlines key design considerations for deploying agents by using [Microsoft Sentinel solution for SAP applications](/azure/sentinel/sap/deployment-overview), SAP application servers, SAP HANA database servers, and Microsoft Sentinel rules.

### Microsoft Sentinel solution for SAP applications

- The topology of the SAP architecture can have multiple SAP products spread across multiple system IDs, clients, and instance numbers. The architecture might have several front-end ABAP servers, but it requires only one ABAP server connection. Consider connecting to the SAP message server, which routes the connector to the correct ABAP server and gathers data for an SAP system.

- The connector deploys as a Docker container on a host virtual machine (VM) or physical server. The connector container supports deployment on an on-premises machine and an Azure-based VM. The data connector doesn't support an out-of-the-box high-availability configuration. If your scenario requires a high availability option, consider deploying the connector container into a Kubernetes cluster or on [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes).

For the step-by-step configuration of AKS, see [Deploy Microsoft Sentinel Threat Monitoring for an SAP agent into an AKS/Kubernetes cluster](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/deploying-microsoft-sentinel-threat-monitoring-for-sap-agent/ba-p/3528040).

> [!NOTE]
>You can only achieve high availability for the data connector by using a AKS/Kubernetes deployment.

- A Kubernetes cluster only supports a single data connector that fetches data from an SAP system and sends the data to a single Log Analytics workspace. If you run multiple pods in a Kubernetes cluster that connect to same SAP system and send data to the same Log Analytics workspace, multiple copies of the data are sent, which might result in increased charges for data retention.

- When you use Docker containers, all data from an SAP system goes into a single Log Analytics workspace.

- The server that hosts the connector agents must connect to all ABAP servers that require data retrieval. For example, the connector must route and connect to the target ABAP servers by using ports. For more information, see [Deployment prerequisites for Microsoft Sentinel solutions for SAP](/azure/sentinel/sap/prerequisites-for-deploying-sap-continuous-threat-monitoring#system-prerequisites).

- Use Microsoft Sentinel alerts, like Microsoft Teams, email, or mobile alerts.

- When multiple connectors are hosted on a single machine:
  - The container's naming pattern is `sapcon-<sid>`, so you can't connect to multiple systems with the same SID.
  - If you connect to multiple systems that have different client IDs, use the `--multi-clients` undocumented switch when you run the kickstart script. The created container has the naming pattern `sapcon-<sid>-<client>`.
  - When you connect to multiple systems that have the same SID and the same client ID, the connector must be deployed on different hosts. The systems might have different system numbers.  The connector must also be deployed on different hosts for multiple system environments, like production, development, or test, that use same SID, client ID, or system number. Log Analytics data from these systems are indistinguishable. When you work with systems that have identical SIDs, client IDs, or system numbers, use different Log Analytics workspaces to distinguish the data.

## SAP application servers

- Use an SAP connector to connect ABAP servers to Microsoft Sentinel.
- Install the SAP connector on a separate virtual machine.
- Each SAP system with a unique system ID (SID) requires a separate SAP connector.
- Store the credentials in Azure Key Vault.
- To pull the data in each SAP system, assign the proper roles and authorizations that are specific to the Microsoft Sentinel integration.
- In monitored SAP systems, enable SAP table change logging and ABAP logging.
- Fine tune the SAP connector to avoid short dumps and to pull the proper data amount.
- To eliminate false positives, implement an iterative process to fine tune the alerts in Microsoft Sentinel. For example, allow select users to run sensitive queries.

## SAP HANA database server

- Microsoft Sentinel relies on the logs pushed to its workspace by HANA through system logging protocol (syslog). No SAP connector is used in this scenario as we use in SAP application server monitoring.

- To push the SAP HANA syslog to a Microsoft Sentinel workspace, install [Azure Monitor Agent](/azure/azure-monitor/agents/agents-overview) parallel to the standard version of Microsoft Operations Management Suite. By default, Operations Management Suite pushes data to the telemetry workspace. You can redirect the Azure Monitor Agent logs to the Microsoft Sentinel workspace.

- By default, the HANA auditing trail is written to a database table called CSTABLE. The security team uses functionalities, like capturing firefighter logins, to consume the audit logs from the databases. Hence we can't repoint the default logging to syslog. However, we can redirect different audit trails to different targets. Thus, all the Microsoft Sentinel-related audit policies point to Level *Alert*. All *Alert* level logs are directed to SYSLOG with this change.

## Microsoft Sentinel rules

Microsoft Sentinel rules help discover threats and anomalous behaviors in your environment. During the analysis and design phase:
  
- **Review existing rules.** Determine which [built-in analytics rules](/azure/sentinel/sap/sap-solution-security-content#built-in-analytics-rules) exist for SAP and Microsoft Sentinel.
- **Establish scope.** Define the scope and use cases for your situation.
- **Establish rule criteria.** Establish criteria for rule identification and prioritization.
- **Prioritize rules.** Identify and prioritize the rules for implementation.

The following design considerations also apply:

- To identify false positives and adjust query logic and watchlist entries accordingly, establish a process for reviewing and validating alerts.

- Use watchlists to correlate data from a data source with the events in your Microsoft Sentinel environment.
  - For example, you might create a watchlist with a list of high-value assets, terminated employees, or service accounts in your environment.
  - Existing rules use static watchlists that contain a list of users. But you can configure rules to provide Microsoft Sentinel with a refreshable dynamic data source of assets that Microsoft Sentinel evaluates.
  - Analytic rules take advantage of the SAP_User_Config watchlist. For example, if a user generates an excessive number of alerts, the user is added to the watchlist with tags, such as `MassiveLogonsOK` or `MassiveRFCOK`, to prevent a disturbance.

- Use the [built-in workbooks](/azure/sentinel/sap/sap-solution-security-content#built-in-workbooks) to identify gaps in the data and monitor system health.

- Use exfiltration rules to monitor data loss:
  - [Microsoft Sentinel solution for SAP applications - Data exfiltration rules](/azure/sentinel/sap/sap-solution-security-content#data-exfiltration)
  - [Microsoft Sentinel solution for SAP applications - New data exfiltration detection rules](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/microsoft-sentinel-solution-for-sap-applications-new-data/ba-p/3716881)

## Next steps

- [SAP security on Azure: Security operations](./sap-lza-security-operations.md)
