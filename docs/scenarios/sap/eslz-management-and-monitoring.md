---
title: Operations baseline for SAP on Azure
description: Learn about design considerations and recommendations for managing and monitoring SAP on Azure.
author: Zimmergren
ms.author: pnp
ms.date: 01/04/2023
ms.topic: conceptual
ms.custom: think-tank, e2e-sap, engagement-fy23
products: azure-monitor
---

# Operations baseline for SAP on Azure

This article builds on considerations and recommendations defined in the Azure landing zone article [Design area: Management for Azure environments](../../ready/landing-zone/design-area/management.md). The guidance in this article will help you explore how to operationally maintain an SAP platform on an Azure enterprise estate, with centralized management and monitoring at the platform level.

This article presents critical recommendations for SAP operations teams to maintain SAP systems within the Azure platform. Because SAP is a mission-critical platform, you should include guidance on the Azure landing zone design areas in your design. If you're looking to build standard operating procedures for managing an SAP workload, see [SAP workload operational procedures](/azure/well-architected/sap/design-areas/operational-procedures) in the Azure Well-Architected Framework.

## Key points

Here are some key design considerations and recommendations for monitoring and managing SAP on Azure:

- Use [Azure Monitor for SAP solutions](/azure/sap/monitor/about-azure-monitor-sap-solutions) to monitor your SAP workloads on Azure. Consider supplementing Azure Monitor for SAP solutions with SAP Solution Manager. You can add Application Insights to extract all necessary telemetry data while generating alerts and support tickets when telemetry indicates a potential error.
- Monitor the SAP environment using the [SAP on Azure Baseline Alerts](https://azure.github.io/azure-monitor-baseline-alerts/patterns/specialized/sap/)
- Implement threat protection by using the [Microsoft Sentinel solution for SAP](/azure/sentinel/sap/deployment-overview). Use this solution to monitor your SAP systems and detect sophisticated threats throughout the business logic and application layers.
- Run a VM Extension for SAP check. VM Extension for SAP uses the assigned managed identity of a virtual machine (VM) to access VM monitoring and configuration data. The check ensures that all performance metrics in your SAP application come from the underlying [Azure Extension for SAP](/azure/virtual-machines/workloads/sap/vm-extension-for-sap).

- Help protect your HANA database by using the [Azure Backup](/azure/backup/sap-hana-db-about) service. If you deploy Azure NetApp Files for your HANA, Oracle, or DB2 database, use the [Azure Application Consistent Snapshot tool (AzAcSnap)](/azure/azure-netapp-files/azacsnap-introduction) to take application-consistent snapshots. AzAcSnap also supports Oracle databases. Consider using AzAcSnap on a central VM rather than on individual VMs.

- Use inter-VM latency monitoring for latency-sensitive applications.

- Use [Connection Monitor](/azure/network-watcher/connection-monitor-overview) in Azure Network Watcher to monitor latency metrics for SAP databases and application servers. Or [collect and display network latency measurements by using Azure Monitor](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/collecting-and-displaying-niping-network-latency-measurements/ba-p/1833979).

- Use [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) monitoring to maintain the health of the disaster recovery service for SAP application servers.

- All production systems must use premium managed disks with a minimum of 128 GiB (P10) for OS disks to avoid performance problems.

- Exclude all the database file systems and executable programs from antivirus scans. Including them could lead to performance problems. Check with the database vendors for prescriptive details on the exclusion list. For example, Oracle recommends excluding */oracle/\<sid>/sapdata* from antivirus scans.

- Ensure time-zone matches between the operating system and the SAP system.

- Don't group different application services in the same cluster. For example, don't combine DRBD and central services clusters on the same cluster. However, you can use the same Pacemaker cluster to manage  approximately five different central services ([multi-SID cluster](/azure/sap/workloads/high-availability-guide-rhel-multi-sid)).
  
  While you're using IBM's Tivoli Workload Scheduler (TWS) cluster for job scheduling, consider running the TWS cluster on its own pair of VMs. We don't recommend that you run it on an SAP central services or database cluster.

- If you use a DB2 database for running SAP on Azure, in scenarios where you implement `LOG_METH2`, consider using an Azure Files share (NFSv4.1). It improves the speed of disaster recovery.

- Consider running dev/test systems in a snooze model to save and optimize Azure run costs.

- Consider creating a plan for nonfunctional requirements. Map those requirements with native Azure resources that can address them. For example, Azure Monitor for SAP can monitor central services clusters.

- Review and adopt SAP parameters, especially ABAP memory parameters, while you're performing an OS or database migration. For example, `em/initial_size_MB` is valid only for AIX environments and shouldn't be set for Azure VMs.

- Consider collecting full database statistics for non-HANA databases after migration. For example, implement [SAP note 1020260 - Delivery of Oracle statistics](https://service.sap.com/sap/support/notes/1020260).

- Consider using Oracle Automatic Storage Management (ASM) for all Oracle deployments that use SAP on Azure.

- Consider using automatic storage for DB2 deployments that use SAP on Azure.

- Optimize and manage SAP Basis operations by using [SAP Landscape Management (LaMa)](https://www.sap.com/products/technology-platform/landscape-management.html). Use the [SAP LaMa connector for Azure](/azure/virtual-machines/workloads/sap/lama-installation) to relocate, copy, clone, and refresh SAP systems.

- Perform a [quality check for SAP HANA](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) on the provisioned Azure infrastructure to verify that provisioned VMs comply with best practices for SAP HANA on Azure.

- For each Azure subscription, run a [latency test on Azure availability zones](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/AvZone-Latency-Test) before zonal deployment to choose low-latency zones for deployment of SAP on Azure.

- If you partner with customers by managing their SAP estates, consider [Azure Lighthouse](/azure/lighthouse/overview). Azure Lighthouse allows managed service providers to use Azure native identity services to authenticate to the customers' environment. It puts the control in the hands of customers, because they can revoke access at any time and audit service providers' actions.

  Azure Lighthouse works with existing APIs, such as the Cloud Solution Provider program. Benefits for providers include managing tenants without switching contexts and viewing cross-tenant information. Using Azure Lighthouse helps maintain trust between customers and providers and streamline the management of their SAP environments.

## Oracle performance efficiency

Performance efficiency can be difficult to diagnose in any enterprise system. For SAP on Azure running Oracle, a collection of SQL scripts can help you diagnose performance problems.

The first recommendation is to use Automatic Workload Repository (AWR) reports. AWR reports contain valuable information for diagnosing problems in the Oracle system. We recommend that you run an AWR report during several sessions and choose peak times for it, to ensure broad coverage for the analysis.

The AWR report shows SQL statistics, database information, system and I/O statistics, and other information that you can use to pinpoint problems. For more analysis tools and helpful SQL statements, see [this SAP blog post](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/announcement-sap-on-azure-oracle-performance-efficiency-scripts/ba-p/3725178).

For additional performance efficiency guidance on Oracle workloads, see [Oracle workload performance efficiency](/azure/well-architected/oracle-iaas/performance-efficiency) in the Azure Well-Architected Framework.

## Next steps

Build your [business continuity and disaster recovery for an SAP migration](./eslz-business-continuity-and-disaster-recovery.md).
