---
title: Prepare Azure Landing Zones for SAP Migration
description: Prepare your Azure environment for an SAP enterprise-scale migration. Learn how Azure landing zones support scalability, security, and governance.
author: stephen-sumner
ms.author: pnp
ms.reviewer: ssumner
ms.date: 01/23/2026
ms.topic: concept-article
---

# Azure landing zone for SAP on Azure

With Azure landing zones, you can start with a small implementation and expand over time. For more sophisticated environments, you can start with enterprise-scale implementation options, which will include operations, security, and governance services in the initial environment.

## Azure landing zone reference architecture

When preparing any environment for sustained cloud adoption, we use the Azure landing zones conceptual architecture to represent what a target end state should look like in Azure, as pictured below.

[![Diagram of a conceptual architecture for an Azure landing zone.](../../_images/ready/azure-landing-zone-architecture-diagram-hub-spoke.svg)](../../_images/ready/azure-landing-zone-architecture-diagram-hub-spoke.svg#lightbox)

When developing a long-term vision for landing zones, consider the design above. Working within this scenario, we focus on the most appropriate starting point to meet your strategic and planning requirements for SAP on Azure. This article is about the starting point, not necessarily all of the details required to reach the longer term target.

## Implementation options

Selecting the best Azure landing zone implementation option will have a direct impact on how well the landing zone(s) can support the implementation options above. For more information on Azure landing zone implementation options, review the [Azure landing zones](../../ready/landing-zone/index.md) article series. Which of the Azure landing zone implementation options best addresses the strategy & planning considerations governing your SAP adoption scenario?

- **Existing Azure landing zone strategy:** If your organization has already implemented an Azure landing zone strategy, it is likely that your SAP adoption scenario will need to adhere to the existing strategy. Otherwise, choose one of the following options as your first step towards repeatable landing zone environments.

- **Start-small and expand with SAP HANA Scale-up on Linux:** The [reference architecture for SAP HANA Scale-up on Linux](/azure/architecture/reference-architectures/sap/run-sap-hana-for-linux-virtual-machines?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/scenarios/sap/toc.json) provides a proven approach to deploying a small SAP HANA platform. Before promoting this smaller environment to production, organizations should complete the Govern and Manage methodologies of CAF to ensure that the environment is ready for mission-critical workload support.

- **Enterprise-scale landing zones:** [Enterprise-scale for SAP](./enterprise-scale-landing-zone.md) deploys a more comprehensive reference architecture, but within the specific environmental configuration required by the broader enterprise-scale landing zone solutions. This is the fastest path to reach a production ready environment, which includes tooling for operations, security, and governance.

The primary difference between the two options above resides in how separation of duties is expressed and implemented in terms of Azure resources, subscription topology, and usage of Azure Policy for governance. Understand your organization's plan around centralized versus decentralized operations and which work best for your organization's workloads. Both models can be flexed to provide the exact experience your organization and workloads require, but you'll want to start with the one most closely aligned with your defined strategy. Ensure all workload teams understand the operating model and duties required of all IT groups and members.