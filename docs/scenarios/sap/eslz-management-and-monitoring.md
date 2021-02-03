---
title: "Enterprise-Scale management and monitoring for <Insert narrative Name>"
description: Describe how this enterprise-scale scenario can improve management and monitoring of SAP
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Management and monitoring for SAP Enterprise-Scale scenario

## Title

### Design Considerations

Monitor SAP systems and solutions

Consider centralized Azure Log Analytics workspace with Azure Monitor and Application Insights for establishing platform and application layer monitoring

Consider Inter-VM latency monitoring for latency sensitive application

### Design Recommendations

Leverage SAP Solution Manager and [Azure Monitor for SAP Solutions](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/azure-monitor-overview) to monitor SAP HANA, HA SuSE Cluster and SQL Systems.

Deploy [Azure Monitoring Extension](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/deployment-guide) for SAP.

Leverage [Azure Backup Services](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/sap-hana-backup-guide) to protect data.  

Create monitoring platform using [Azure telemetry](https://github.com/microsoft/SAPTELEMETRY) tools to provide business processes insight.

Network Watcher [Connection monitor](https://docs.microsoft.com/azure/network-watcher/connection-monitor) for SAP database and application server latency monitoring  (Metric) or by leveraging [Azure Monitor](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/collecting-and-displaying-niping-network-latency-measurements/ba-p/1833979).
