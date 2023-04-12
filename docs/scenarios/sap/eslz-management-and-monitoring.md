---
title: Operations baseline for SAP on Azure
description: Learn more about design considerations and recommendations for managing and monitoring SAP on Azure.
author: Zimmergren
ms.author: martinek
ms.date: 01/04/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap, engagement-fy23
products: azure-monitor
---

# Operations baseline for SAP on Azure

This article builds on several considerations and recommendations defined in the Azure landing zone article [Azure landing zone design area for management and monitoring](../../ready/landing-zone/design-area/management.md). Following the guidance in this article will help explore how to operationally maintain an SAP platform on Azure enterprise estate, with centralized management and monitoring at the platform level. The article presents critical recommendations for SAP operations teams to maintain SAP systems within the Azure platform. Since SAP is a mission-critical platform, you should include guidance on the Azure landing zone design areas in your design.

Here are some key design considerations and recommendations for monitoring and managing SAP on Azure.

- Use [Azure Monitor for SAP Solutions](/azure/virtual-machines/workloads/sap/monitor-sap-on-azure) to monitor your SAP workloads on Azure. Consider supplementing Azure Monitor for SAP Solutions with SAP Solution Manager. You can add Application Insights to extract all necessary telemetry data while generating alerts and support tickets when telemetry indicates a potential error.

- Implement threat protection with [Microsoft Sentinel Solution for SAP](/Azure/sentinel/sap/deployment-overview). Use Microsoft Sentinel Solution for SAP to monitor your SAP systems and detect sophisticated threats throughout the business logic and application layers.

- Run a VM Extension for SAP check. VM Extension for SAP uses the assigned managed identity of a virtual machine to access VM monitoring and configuration data. The check ensures that all performance metrics inside your SAP application come from the underlying [Azure Extension for SAP](/azure/virtual-machines/workloads/sap/vm-extension-for-sap).

- Protect your HANA database or with [Azure Backup](/azure/backup/sap-hana-db-about) service. If you deploy Azure NetApp Files (ANF) for your HANA, Oracle or DB2 database, use the [Azure Application Consistent Snapshot tool (AzAcSnap)](/azure/azure-netapp-files/azacsnap-introduction) to take application-consistent snapshots. AzAcSnap also supports Oracle databases. Consider using AzAcSnap from a central VM rather than on individual VMs.

- Create a monitoring platform using [SAP telemetry tools](https://github.com/microsoft/saptelemetry) to provide business process insights.

- Use inter-virtual machine (VM) latency monitoring for latency-sensitive applications.

- Use Network Watcher [Connection Monitor](/azure/network-watcher/connection-monitor-overview) to monitor SAP database and application server latency metrics or [collect and display network latency measurements with Azure Monitor](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/collecting-and-displaying-niping-network-latency-measurements/ba-p/1833979).

- Use [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) monitoring to maintain disaster recovery service health for SAP application servers.

- All production systems must use premium managed disk with minimum of 128GB (P10) for OS Disks to avoid any performance issues.

- Exclude all the database filesystems and executables from anti-virus scan. Otherwise it could lead to performance problems. Check with the database vendors for prescriptive details on the exclusion list. For example, Oracle recommends excluding /oracle/\<sid>/sapdata* from anti-virus scans.

- Always ensure time-zone matches between Operating system and SAP system.

- Do not group different application services in the same cluster.
  - Do not combine DRBD and Central Services clusters on the same cluster. However, you can use the same pacemaker cluster to manage  approximately five different central services ([multi-sid cluster](/azure/sap/workloads/high-availability-guide-rhel-multi-sid)).
  - Whilst using IBM’s TWS cluster for Job Scheduling consider running TWS cluster on its own pair of VMs, It is not recommended to run on SAP central services/database cluster.

- For DB2 database for running SAP on Azure, in scenarios where log_meth2 is implemented consider using Azure File share (NFS4.1), it improves the DR recovery speed.

- Consider  running Dev/Test systems in a snooze model to save and optimize Azure run costs.

- Consider creating a non-functional requirement plan and map them with native Azure resources that can address them. For example: Central Services cluster monitoring can be done by Azure Monitor for SAP. 

- Review and adopt SAP parameters specially ABAP memory parameters whilst performing a OS/DB migration. For example: EM/Initial_size_MB is only valid for AIX environment and should not be set for Azure VMs.

- Consider collecting full database statistics for non-HANA databases after migration. For example: Implement SAP Not 1020260 for oracle.

- Consider using Oracle Automatic Storage Management (ASM) for all SAP on Azure Oracle deployments.

- Consider  using DB2’s Automatic Storage(AS) for SAP on Azure DB2 deployments.

- Optimize and manage SAP Basis operations by using [SAP Landscape Management (LaMa)](https://www.sap.com/products/landscape-management.html). Use the [SAP LaMa connector for Azure](/azure/virtual-machines/workloads/sap/lama-installation) to relocate, copy, clone, and refresh SAP systems.

- Perform a [quality check for SAP HANA](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) on the provisioned Azure infrastructure to verify that provisioned VMs comply with SAP HANA on Azure best practices.

- For each Azure subscription, run an [Azure Availability Zone latency test](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/AvZone-Latency-Test) before zonal deployment to choose low-latency zones for SAP on Azure deployment.

- If you partner with our customers by managing their SAP estate, consider [Azure Lighthouse](/azure/lighthouse/overview). Azure Lighthouse allows managed service providers to use Azure native identity services to authenticate to the customers' environment. It puts the control in the hands of the customer, as they can revoke access at any time, and audit service provider actions. It works with existing APIs, such as the Cloud Solution Provider program. The benefits for the provider include managing tenants without switching contexts and viewing cross-tenant information. Using Azure Lighthouse is an easy choice to maintain trust between customers and providers and streamline the management of their SAP environments.

## SAP on Azure - Oracle Performance Efficiency

Performance efficiency can be difficult to diagnose in any enterprise system. For SAP on Azure running Oracle, we have a collection of SQL scripts for helping to diagnose any performance issues. The first recommendation is to use AWR reports. AWR reports contain valuable information in diagnosing issues in the Oracle system. It is recommended to run the AWR report during several sessions and to pick peak times for running the report. This will ensure broad coverage for the analysis. The AWR report will show SQL statistics, database information, system and IO statistics, and other information that can be used to pinpoint any issues that can be encountered. For more tools on analysis and SQL statements that can help with this, please see the SAP blog post [here](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/announcement-sap-on-azure-oracle-performance-efficiency-scripts/ba-p/3725178)
