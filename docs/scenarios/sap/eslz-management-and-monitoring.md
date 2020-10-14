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

Leverage SAP Solution Manager and "Azure Monitor for SAP Solutions (AMS)" to monitor SAP HANA, HA SuSE Cluster and SQL Systems.	 

Deploy  Azure Monitoring Extension for SAP. 

Leverage Azure Backup Services to protect data.  

Create monitoring platform using Azure telemetry tools to provide business processes insight. 

Network Watcher Connection monitor for SAP database and application server latency monitoring  (Metric). 

Threat Protection for SAP with Azure Sentinel 

Azure Security Center - Ranking based approach for SAP workload (scorecard-based approach) 