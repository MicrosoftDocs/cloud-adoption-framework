---
title: Strategy for Azure VMware Solution adoption
description: Learn about technical considerations of Azure VMware Solution that might affect your strategy.
author: mhenry
ms.author: jaalmond
ms.date: 09/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-azure-vmware, think-tank
---

# Strategy for Azure VMware Solution adoption

Cloud adoption best practices encourage customers to create a single, centralized cloud adoption strategy using the [Cloud Adoption Framework's Strategy methodology](../../strategy/index.md). If you haven't already, use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) to track the progress of your cloud adoption strategy. This article outlines technical considerations of Azure VMware Solution that might affect your strategy.

## Azure VMware Solution motivations

Common motivations for choosing Azure VMware Solution are:

- **Business needs:** To accelerate the migration of VMware-based workloads, support your [total cost of ownership (TCO) reduction](https://azure.microsoft.com/pricing/tco/calculator/), and rapidly expand capacity. This includes your need to reduce costs, complexity, and risk associated with larger-scale migration projects.
- **IT needs:** To create business continuity, deploy disaster recovery solutions, and scale traditional on-premises VMware environments, with little to no change to applications (including VDI environments where modernization of VDI is not needed).
- **Operational needs:** To make use of the skills and processes you've established across IT teams, while you give team members the ability to grow and adopt cloud competencies over time.
- **Strategic needs:** To incrementally modernize your VMware-based applications with other Azure services as business requirements evolve.

## Azure VMware Solution outcomes

### Accelerate migration and lower your TCO

Reduce the time and complexity of migrating your VMware workloads to Azure. Take advantage of existing VMware investments, maintain operational consistency, and avoid downtime with live bulk virtual machine (VM) migration.

- **Manage VMware environments with familiar VMware tools** without the need to retrain staff or replatform the hypervisor.
- **Maintain operational consistency** with direct administrative access to vSphere interfaces.
- **Reduce impacts of change management** and maintain operational consistency for the business. Develop cloud skills incrementally, as your administrators become familiar with Azure.
- **Accelerate migration and minimize downtime** using the latest HCX Enterprise functionality for large-scale, live migration from on-premises to Azure.
- **Achieve seamless workload mobility** without changing IP addresses, extending your on-premises Layer 2 network to Azure.
- **Migrate live VMs from on-premises to Azure** without any downtime using vMotion from vCenter.

### Gain reliability and scale

Gain continuity, scale, and automated provisioning for your VMware workloads on global Azure infrastructure.

- **Gain elasticity** with the ability to seamlessly add and remove capacity (compute and storage resources) on demand.
- **Ensure business continuity** with instant high availability, disaster recovery, and backup services.
- **Take advantage of high-speed, low-latency connectivity** to Azure and on-premises. The connectivity is delivered through networking Azure ExpressRoute connections.
- **Manage dedicated, isolated, private, domains in Azure**, residing on bare metal hyperconverged, all flash, infrastructure. Robust hardware infrastructure that can run the most demanding workloads.
- **Deploy fully automated self-service provisioning** of the environment and additions/removal of capacity.

### Optimize licensing costs

Take advantage of price benefits for Windows and SQL Server with:

- Free [**Extended Security Updates**](/lifecycle/faq/extended-security-updates) for Windows Server 2012, and SQL Server 2012 when transitioning to Azure, including Azure VMware Solution.
- **Azure Hybrid Benefit** for both [Windows](/azure/virtual-machines/windows/hybrid-use-benefit-licensing) and [SQL Server](/azure/azure-sql/azure-hybrid-benefit?tabs=azure-powershell). Azure Hybrid Benefit allows you to bring your existing licenses to Azure and reduce costs.
- **Azure Reservations** [discounts for reserved instances](/azure/azure-vmware/reserved-instance) (and no cancellation fees). Azure VMware Solution offers 1-year and 3-year reserved instances for dedicated hosts, saving around 30-50% of the total cost of a node.

### Modernize applications

Modernize applications running on VMware overtime through integration to [Azure native management, security, and services](..\azure-vmware\govern.md).

- **Deploy unified hybrid management and operational controls** using [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) across Azure, VMware, and other cloud infrastructures.
- **Modernize applications** with the ability to connect them to Azure services such as Azure AD, SQL Managed Instance, and analytics.
- **Deploy native Azure management controls** with Azure Monitor and Azure Security Center solutions to operate your VMware environments.
- **Deploy native Azure public cloud capabilities** and take advantage of built-in security controls and compliance enforcement with Azure Backup and Azure Site Recovery.
- **Achieve identity and access management consistency** with unified permissions and access control, using Azure Active Directory (Azure AD) as a single sign-on (SSO) identity source for VMware vCenter.

## Azure VMware Solution business justification

[Building a business justification for cloud migration](/azure/cloud-adoption-framework/strategy/cloud-migration-business-case) can dispel cloud rationalization myths that surface from your team's financial plan. Your finance team might need to develop a detailed financial model to account for components associated with the adoption of Azure VMware Solution.

Initial business justification is a directional estimate that can help drive your strategic alignment. Your organization can create transparency between the cloud strategy team and other stakeholders by affirming the business justification can change significantly throughout planning activities. Seek a cross-team consensus of sufficient value in order to [gather inventory and develop a plan](/azure/azure-vmware/plan-private-cloud-deployment). Once your digital estate is cataloged and assessed, you can refine your business case, and present clear plans for cloud value ROI.

## Next steps

When you adopt Azure VMware Solution, there are many business and technical considerations needed for scoping, architectural design, evaluation, and deployment. The plan for Azure VMware Solution guidance helps you build your Azure VMware Solution adoption plan.

> [!div class="nextstepaction"]
> [Plan for Azure VMware Solution](./plan.md)
