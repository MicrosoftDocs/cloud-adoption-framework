---
title: "Unified operations for hybrid, multicloud, and edge"
description: Implement effective controls for consistenty operations management across hybrid, multicloud, and edge deployments.
author: mpvenables
ms.author: brblanch
ms.date: 12/24/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Unified operations for hybrid, multicloud, and edge

Hybrid, multicloud, and edge deployment approaches can often lead to steep increases in operating costs. When mapping your cloud transformation journey to business outcomes, [having a fiscal conversation within your organization](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/fiscal-outcomes) is necessary to understand what might affect primary cost options, such as capital expenses and operating costs.

In any hybrid and multicloud strategy, the first increase in overhead costs can manifest in the form of duplicated cloud platform utilities: network, identity, governance, security, and operations tooling. In the longer term, more negative business impacts could emerge in the form of challenges like staffing core functions or teams with the skills needed to manage these diverse environments.

When [setting up a skills readiness plan](https://docs.microsoft.com/azure/cloud-adoption-framework/plan/adapt-roles-skills-processes), organizations should move toward adapting and building existing roles and skills for the cloud. Support the skills readiness plan with cross-team organizational processes to align your organization with agile practices, and required cloud functions that support developing a long-term cloud operating model.

Develop and evolve a [mature team](https://docs.microsoft.com/azure/cloud-adoption-framework/organize/organization-structures#best-practice-minimum-viable-product-mvp), starting from a Minimum viable product (MVP) that balances innovation and risk, towards a cross-team, collaborative [CCoE model](https://docs.microsoft.com/azure/cloud-adoption-framework/organize/cloud-center-of-excellence) and IT partner--accelerating cloud innovation while increasing business agility with agile, cloud-first, hybrid, and multicloud solutions, delegating responsibilities, and executing on modern technical abilities.

Hybrid and multicloud strategies have lead many decisions makers to falsely conclude that the cloud is more expensive than on-premises technology options. Recent studies per Forrester suggest that a hybrid and multi-cloud strategy can provide very significant three-year ROI, avoided on-premises costs, and high energy efficiencies.

Fortunately, there is a surprisingly simple approach to overcoming these risks, while modernizing and optimizing overall operations. **"Unified Operations"** is the concept or approach which reduces short-term duplication and the long-term strain on your technology staff. This article describes the provider-neutral approach of using unified operations to extend your control plane. Subsequent articles will outline the Azure-specific approach to delivering [governance](./govern.md) and [operations management](./manage.md) across your portfolio through unified operations.

## Primary cloud platform

The most successful hybrid, multicloud, and edge strategies begin with a primary cloud platform.

![Primary cloud platform with facilities, services, and controls to support your processes.](../../_images/unified-operations/primary-cloud-provider.png)

Your primary cloud platform, be it public or private cloud, is where your operational processes live. In that primary platform, you will find a set of defined cloud facilities. In Azure those facilities are regions, on-prem they may be datacenters. Those facilities host cloud services that are required for core operations and to support any other workloads hosted on that platform. Your primary cloud platform will also include a series of controls designed to support operations within that cloud.

> [!NOTE]
> Your primary cloud platform may not host all, or even the majority, of your workloads. But it does host the services and controls require to complete core processes for operations management, governance, compliance, security, etc...
>
> [!CAUTION]
> You likely already have a primary cloud platform. Unfortunately, most cloud platforms were designed and built long before operations required hybrid, multicloud, or edge deployment options. This often leads to customers replicating processes using different cloud controls to manage cloud services across each cloud platform. If your strategy calls for hybrid, multicloud, or edge AND your primary cloud platform doesn't support those, then you may need to consider a platform that offers unified operations capabilities.
>

## Unified operations

Conceptually, unified operations is a very simple concept. Implement an extension or gateway to apply the controls in your primary cloud provider to hybrid, multicloud, or edge deployments.

![Unified operations extends cloud controls to hybrid, multicloud, and edge deployments](../../_images/unified-operations/primary-cloud-provider-extended.png)

> [!WARNING]
> Implementation of unified operations can be relatively straightforward. But, if your cloud platform isn't able to manage unified operations, that platform will require costly development to create extensions or gateways to other clouds. Limitations of an existing primary cloud platform is the primary reason why customer's create duplicated or fractured operations and processes.

If your current primary cloud provider can't offer unified operations, you may want to consider modernizing your operations and processes using a modern cloud provider.

## Unified operations decomposed

The following image illustrates the individual components of unified operations and how they interact with each other. Each section that follows will provide a detailed narrative for each component.

![Infographic showing the components required to deliver unified operations (outlined in the remainder of this article)](../../_images/unified-operations/unified-operations.png)

## Customer processes

The primary objective of unified operations is to create as much process consistency as possible. No provider will be able to achieve 100% feature parity across all hybrid, multicloud, and edge deployments. But the provider should be able to deliver common enough feature sets that your processes can remain consistent.

![Customer Processes that unified operations can support](../../_images/unified-operations/unified-operations-customer-processes.png)

Customers most commonly require the ability to deliver consistency in their governance and operations management processes. To meet long term requirements, your unified operations solution will need to be able to scale to meet the following common processes:

- Common governance processes or tasks:
    - Cost Management: View, optimize, or manage costs
    - Security Baseline: Audit, apply, or automate requirements from security
    - Resource Consistency: On-board, organize, and configure resources and services
    - Identity Baseline: Authentication and authorization of users
    - Deployment Acceleration: Templates, automation, and pipelines that drive consistency
- Common operations management processes or tasks:
    - Inventory & Visibility: Account for all assets and ensure reporting for each
    - Optimized Operations: Track, patch, and optimize supported resources
    - Protection & Recovery: Backup, business continuity and disaster recovery practices
    - Platform Operations: Specialized operations for common technology platforms like SQL, WVD, SAP, etc...
    - Workload Operations: Specialized operations for high priority workloads with greater operations requirements

Your primary cloud platform should be able to provide appropriate tooling to facilitate or automate processes to accomplish these goals. Your unified operations solution should then allow you to extend these processes into hybrid, multicloud, and edge deployments.

## Primary Cloud Controls

To facilitate or automate the customer processes typically required in the cloud, your primary cloud platform should include a number of important features:

![Common cloud controls - outlined in the bullets below](../../_images/unified-operations/unified-operations-cloud-controls.png)

- Basic features: You will need each of these basic features to deliver a cloud adoption plan at scale.
    - Search, Index, Group, and Tag all deployed assets for basic visibility
    - Template, Automate, and Extend tooling for consistent deployment
    - Create Access and Security boundaries to protect deployed assets
- Enhanced features: You will likely need most, if not all, of the following enhanced features.
    - Performance & Inventory reporting
    - Security & Compliance auditing and automation
    - Tracking and reporting on Applications & Dependencies
- Automated controls: Additional tools that can automate your environment to modernize operations and optimize operational costs
    - Environment & In-Guest Policy
    - Configuration & Updates
    - Protection and recovery

These features are likely already included in the control sets you use to operate your primary cloud provider today. There are likely a host additional features and automated processes available in that set of controls. But the features above are the ones that we see lead to fractured or duplicated operations. These are the features that should be available across hybrid, multicloud, and edge in your unified operations solution.

### Hybrid, multicloud, and edge extension/gateway

To extend your primary cloud controls, you need to configure an extension or gateway. That extension will allow your controls to see and interact with resources that have been deployed outside of the cloud platform. In Microsoft's cloud platforms, Azure Arc is that extension. Azure Arc extends the cloud controls used to govern Azure, so that you can apply the same control and processes to services running on-prem, in a competing public cloud, or on the edge.

## Next Steps

Use the best practices in this article series to manage assets using Azure's unified operations tools.
To get started, [Inventory and Tag resources](./server/best-practices/arc_inventory_tagging.md) to get familiar with the most basic operations management functions. From there, use the best practices to add more operational capability &/or onboard additional resources.
