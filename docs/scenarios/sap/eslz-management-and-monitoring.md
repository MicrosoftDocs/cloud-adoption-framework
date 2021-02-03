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

This section explores how to operationally maintain an SAP on Azure enterprise estate with centralized management and monitoring at a platform level. It presents key recommendations for SAP Operation teams to maintain SAP systems within Azure platform. 

### Design Considerations

Monitor SAP systems and solutions

Consider centralized Azure Log Analytics workspace with Azure Monitor and Application Insights for establishing platform and application layer monitoring

Consider Inter-VM latency monitoring for latency-sensitive application

### Design Recommendations

Leverage SAP Solution Manager and [Azure Monitor for SAP Solutions](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/azure-monitor-overview) to monitor SAP HANA, HA SuSE Cluster and SQL Systems.

Deploy VM Extension for SAP,  VM Extension uses a Managed Identity assigned to the VM to access monitoring and configuration data of the VM. This check makes sure that all performance metrics that appear inside your SAP application are provided by the underlying [Azure Extension for SAP](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/deployment-guide). 

Protect your HANA Database with [Azure Backup Services](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/sap-hana-backup-guide). Use [azacsnap](https://docs.microsoft.com/en-us/azure/azure-netapp-files/azacsnap-introduction) to take application consistent snapshots if ANF is deployed for HANA database. Consider central VM for scheduling azacsnap as compare to scheduling it on individual VMs.

Create a monitoring platform using [Azure telemetry](https://github.com/microsoft/SAPTELEMETRY) tools to provide business processes insight.

Network Watcher [Connection monitor](https://docs.microsoft.com/en-us/azure/network-watcher/connection-monitor) for SAP database and application server latency monitoring  (Metric) or by leveraging [Azure Monitor](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/collecting-and-displaying-niping-network-latency-measurements/ba-p/1833979).

Use [Azure Site Recovery](https://docs.microsoft.com/en-us/azure/site-recovery/monitoring-common-questions) monitoring capabilities for maintaining the health of Disaster Recovery service for SAP application servers. 

Optimize and manage SAP Basis operations by leveraging [SAP Landscape Management](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/lama-installation) (LaMa) and use the SAP LaMa Azure Connector to relocate, copy, clone, and refresh SAP systems.

Perform [Quality Check for SAP HANA](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) on Azure on provisioned infrastructure to verify that provisioned VM comply with SAP HANA on Azure best practices. 

Perform [Azure Availability Zone Latency test](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/AvZone-Latency-Test) before zonal deployment for choosing low latency zones for SAP on Azure deployment for any given subscription. 

Threat Protection for SAP with Azure Sentinel
