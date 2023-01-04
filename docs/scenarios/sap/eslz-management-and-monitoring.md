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
---

# Operations baseline for SAP on Azure

This article builds on several considerations and recommendations defined in the Azure landing zone article [Azure landing zone design area for management and monitoring](../../ready/landing-zone/design-area/management.md). Following the guidance in this article will help explore how to operationally maintain an SAP platform on Azure enterprise estate, with centralized management and monitoring at the platform level. The article presents critical recommendations for SAP operations teams to maintain SAP systems within the Azure platform. Since SAP is a mission-critical platform, you should include guidance on the Azure landing zone design areas in your design.

Here are some key design recommendations for monitoring and managing SAP on Azure.

- Use [Azure Monitor for SAP Solutions](/azure/virtual-machines/workloads/sap/monitor-sap-on-azure) to monitor your SAP workloads on Azure. The solution architecture includes a centralized Azure Log Analytics workspace for establishing a platform and application-layer monitoring. Consider supplementing Azure Monitor for SAP Solutions with SAP Solution Manager. You can add Application Insights to extract all necessary telemetry data while generating alerts and support tickets when telemetry indicates a potential error.

- Implement threat protection with [Microsoft Sentinel Solution for SAP](/Azure/sentinel/sap/deployment-overview).

- Run a VM Extension for SAP check. VM Extension for SAP uses the assigned managed identity of a virtual machine to access VM monitoring and configuration data. The check ensures that all performance metrics inside your SAP application come from the underlying [Azure Extension for SAP](/azure/virtual-machines/workloads/sap/deployment-guide).

- Protect your HANA database with [Azure Backup](/azure/backup/sap-hana-db-about) service. If you deploy Azure NetApp Files (ANF) for your HANA database, use the [Azure Application Consistent Snapshot tool (AzAcSnap)](/azure/azure-netapp-files/azacsnap-introduction) to take application-consistent snapshots. Consider using AzAcSnap from a central VM rather than on individual VMs.

- Create a monitoring platform using [SAP telemetry tools](https://github.com/microsoft/saptelemetry) to provide business process insights.

- Use inter-virtual machine (VM) latency monitoring for latency-sensitive applications.

- Use Network Watcher [Connection Monitor](/azure/network-watcher/connection-monitor) to monitor SAP database and application server latency metrics or collect and display network latency measurements with [Azure Monitor](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/collecting-and-displaying-niping-network-latency-measurements/ba-p/1833979).

- Use [Azure Site Recovery](/azure/site-recovery/monitoring-common-questions) monitoring to maintain disaster recovery service health for SAP application servers.

- Optimize and manage SAP Basis operations by using [SAP Landscape Management (LaMa)](https://www.sap.com/products/landscape-management.html). Use the [SAP LaMa connector for Azure](/azure/virtual-machines/workloads/sap/lama-installation) to relocate, copy, clone, and refresh SAP systems.

- Perform a [quality check for SAP HANA](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) on the provisioned Azure infrastructure to verify that provisioned VMs comply with SAP HANA on Azure best practices.

- For each Azure subscription, run an [Azure Availability Zone latency test](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/AvZone-Latency-Test) before zonal deployment to choose low-latency zones for SAP on Azure deployment.

- If you partner with our customers by managing their SAP estate, consider [Azure Lighthouse](/azure/lighthouse/overview). Azure Lighthouse allows managed service providers to use Azure native identity services to authenticate to the customers' environment. It puts the control in the hands of the customer, as they can revoke access at any time, and audit service provider actions. It works with existing APIs, such as the Cloud Solution Provider program. The benefits for the provider include managing tenants without switching contexts and viewing cross-tenant information. Using Azure Lighthouse is an easy choice to maintain trust between customers and providers and streamline the management of their SAP environments.
