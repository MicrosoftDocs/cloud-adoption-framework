---
title: Enterprise-scale management and monitoring for SAP on Azure
description: Learn about design considerations and recommendations for managing and monitoring SAP on Azure.
author: JefferyMitchell
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-sap
---

# Enterprise-scale management and monitoring for SAP on Azure

This article explores how to operationally maintain an SAP on Azure enterprise estate, with centralized management and monitoring at the platform level. The article presents key recommendations for SAP operations teams to maintain SAP systems within the Azure platform.

**Design considerations:**

Here are some design considerations for SAP on Azure monitoring and management:

- Consider a centralized Azure Log Analytics workspace with Azure Monitor and Application Insights for establishing platform and application-layer monitoring.

- Consider inter-virtual machine (VM) latency monitoring for latency-sensitive applications.

- Consider scheduling [AzAcSnap](/azure/azure-netapp-files/azacsnap-introduction) from a central VM rather than on individual VMs.

**Design recommendations:**

Here are some design recommendations for SAP on Azure monitoring and management:

- Monitor SAP systems and solutions.

- Use SAP Solution Manager and [Azure Monitor for SAP Solutions](/azure/virtual-machines/workloads/sap/azure-monitor-overview) to monitor SAP HANA, high-availability SUSE clusters, and SQL systems.

- Run a VM Extension for SAP check. VM Extension for SAP uses a VM's assigned managed identity to access VM monitoring and configuration data. The check ensures that all performance metrics that appear inside your SAP application come from the underlying [Azure Extension for SAP](/azure/virtual-machines/workloads/sap/deployment-guide).

- Protect your HANA database with [Azure Backup](/azure/virtual-machines/workloads/sap/sap-hana-backup-guide) service. If you deploy Azure NetApp Files (ANF) for your HANA database, use the [Azure Application Consistent Snapshot tool (AzAcSnap)](/azure/azure-netapp-files/azacsnap-introduction) to take application-consistent snapshots.

- Create a monitoring platform using [SAP telemetry tools](https://github.com/microsoft/saptelemetry) tools to provide business process insights.

- Use Network Watcher [Connection Monitor](/azure/network-watcher/connection-monitor) to monitor SAP database and application server latency metrics, or collect and display network latency measurements with [Azure Monitor](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/collecting-and-displaying-niping-network-latency-measurements/ba-p/1833979).

- Use [Azure Site Recovery](/azure/site-recovery/monitoring-common-questions) monitoring to maintain disaster recovery service health for SAP application servers.

- Optimize and manage SAP Basis operations by using [SAP Landscape Management (LaMa)](https://www.sap.com/products/landscape-management.html). Use the [SAP LaMa connector for Azure](/azure/virtual-machines/workloads/sap/lama-installation) to relocate, copy, clone, and refresh SAP systems.

- Perform a [quality check for SAP HANA](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) on the provisioned Azure infrastructure to verify that provisioned VMs comply with SAP HANA on Azure best practices.

- For each Azure subscription, run an [Azure Availability Zone latency test](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/AvZone-Latency-Test) before zonal deployment to choose low-latency zones for SAP on Azure deployment.

- Implement threat protection for SAP with [Azure Sentinel](/azure/sentinel/overview).
