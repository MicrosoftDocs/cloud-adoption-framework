---
title: "Unified operations for hybrid, multicloud, and edge"
description: Implement effective controls for consistenty operations management across hybrid, multicloud, and edge deployments.
author: mpvenables
ms.author: brblanch
ms.date: 12/31/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Unified operations for hybrid, multicloud, and edge

Hybrid, multicloud, and edge deployment approaches can often lead to steep increases in operating costs. When mapping your cloud transformation journey to business outcomes, [having a fiscal conversation within your organization](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/fiscal-outcomes) is necessary to understand what might affect primary cost options, such as capital expenses and operating costs.

In any hybrid and multicloud strategy, the first increase in overhead costs can manifest in the form of duplicated cloud platform utilities: network, identity, governance, security, and operations tooling. In the longer term, more negative business impacts could emerge in the form of challenges like staffing core functions or teams with the skills needed to manage diverse environments.

When [setting up a skills readiness plan](https://docs.microsoft.com/azure/cloud-adoption-framework/plan/adapt-roles-skills-processes), organizations should move toward adapting and building existing roles and skills for the cloud. Support the skills readiness plan with cross-team organizational processes to align your organization with agile practices, and required cloud functions that support developing a long-term cloud operating model.

Develop and evolve a [mature team](https://docs.microsoft.com/azure/cloud-adoption-framework/organize/organization-structures#best-practice-minimum-viable-product-mvp), starting from a Minimum viable product (MVP) that balances innovation and risk, and move towards a cross-team [CCoE model](https://docs.microsoft.com/azure/cloud-adoption-framework/organize/cloud-center-of-excellence)—with central IT as collaborative  partner. Accelerate cloud innovation, while increasing business agility with agile, cloud-first hybrid and multicloud solutions. Delegate responsibilities, and execute on modern technical abilities.

Hybrid and multicloud strategies have lead many decisions makers to falsely conclude that the cloud is more expensive than on-premises technology options. A recent Forrester Consulting study commissioned by Microsoft found that a hybrid and multi-cloud strategy can provide very significant [three-year return on investment, and substantial avoided on-premises infrastructure and staff costs](https://azure.microsoft.com/en-us/resources/forrester-tei-microsoft-azure-iaas/) for organizations. A second study by Accenture and WSP Environment & Energy concluded that cloud solutions add [significantly increased energy efficiencies for large deployments](https://download.microsoft.com/download/7/3/9/739BC4AD-A855-436E-961D-9C95EB51DAF9/Microsoft_Cloud_Carbon_Study_2018.pdf), with organizations reducing energy use and carbon emissions by more than 30 percent against business applications installed on-premise. (For small deployments, energy use and emissions can be reduced by more than 90 percent with a shared cloud service).

Organizations can modernize and optimize overall operations using a simple approach to overcoming risks—overhead cost increases, or challenges related to staffing core functions. **"Unified Operations"** is the approach to hybrid, multi-cloud, and edge cloud strategy that reduces short-term duplication and long-term strain on your technology staff. This article describes the provider-neutral approach of using unified operations to extend a control plane over distributed resources across hybrid, multi-cloud, and edge environments.

Subsequent articles will outline the Azure-specific approach to delivering [governance](./govern.md) and [operations management](./manage.md) across distributed resources with a unified operations approach. The overall goal in an Azure-specific approach to unified operations is to inventory, organize, and govern IT resources anywhere, on any infrastructure, from one central control plane—using one consistent cloud management experience across on-premises, multi-cloud, and edge environments.

## Primary cloud platform

The most successful hybrid, multicloud, and edge strategies begin with a primary cloud platform.

![Primary cloud platform with facilities, services, and controls to support your processes.](../../_images/unified-operations/primary-cloud-provider.png)

Whether located in a public or private cloud, your primary cloud platform is where your operational processes are hosted. There is a set of defined cloud facilities in that primary platform. In Azure, those facilities are [Azure regions](https://azure.microsoft.com/global-infrastructure/), whereas on-premises, they could be datacenters. These facilities host cloud services that are required for core operations and to support other workloads hosted on the platform. Your primary cloud platform will also include a series of controls, designed to support operations within that cloud.

> [!NOTE]
> Your primary cloud platform may not host all, or even the majority, of your workloads. But it does host the services and controls required to complete the core processes for operations management, governance, compliance, security, etc. 
>
> [!CAUTION]
> You probably already have a primary cloud platform. However, many cloud platforms were designed and built before operations required hybrid, multicloud, or edge deployment options. This has often forced customers into replicating processes—using different cloud controls to manage cloud services across each cloud platform. If your cloud strategy calls for hybrid, multicloud, or edge deployment options ***and*** your primary cloud platform doesn't support them, you should consider a platform that can deploy the requisite functionalities for unified operations.
>

## Unified operations

The concept of executing unified operations is straightforward. Implement an extension (or gateway) to apply the controls in your primary cloud provider across your hybrid, multicloud, or edge deployments. Manage operations across all your assets—whether hosted in disparate on-premises, multi-cloud, and edge resource environments.

One cloud management experience that manages operations of distributed assets at scale (porting consistent management, app development, and cloud services to any infrastructure, anywhere) brings cloud innovation to resource environments across your entire IT estate. A gateway with cloud controls for consistent management and operations enables an integral hybrid and multi-cloud strategy that can advance your organization's future innovation, agility, and business growth, on-premises, multi-cloud, and edge.

![Unified operations extends cloud controls to hybrid, multicloud, and edge deployments](../../_images/unified-operations/primary-cloud-provider-extended.png)

> [!WARNING]
> Implementation of unified operations can be relatively straightforward. But, if your cloud platform isn't able to manage unified operations, it will require additional capital expenditures, with costly development to create extensions or gateways to other clouds. Existing primary cloud platforms with these limitations is the main reason why customers create duplicated or fractured operations and processes.
>
> **An inconsistent approach to implementing unified operations can multiply cost inefficiencies for your organization**—with increased operating costs (duplicated cloud platform utilities, operations tooling), and negative business impacts (staffing teams supported with necessary cloud skilling).
>

If your current primary cloud provider doesn't offer capabilities for unified operations, consider modernizing your operations and processes using a modern cloud provider.

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

To extend your primary cloud controls, you need to configure an extension or gateway. That extension will allow your controls to see and interact with resources that have been deployed outside of the cloud platform (**creating one control plane**). In Microsoft's cloud platforms, Azure Arc is that extension. Azure Arc extends the cloud controls used to govern Azure, so that you can apply the same control and processes to services running on-prem, in a competing public cloud, or on the edge.
**Add additional description of extending ARM (Azure Resource Manager), (as the operating system of Azure) and reaching outside Azure to project those resources inside Azure and represent them as first-class citizens.**

## Next Steps

Use the best practices in this article series to manage assets using Azure's unified operations tools.
To get started, [Inventory and Tag resources](./server/best-practices/arc_inventory_tagging.md) to get familiar with the most basic operations management functions. From there, use the best practices to add more operational capability &/or onboard additional resources.
