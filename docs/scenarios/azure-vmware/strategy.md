---
title: Strategy for Azure VMware Solution adoption
description: <<Describe the scenario's impact on strategy.>>
author: mhenry
ms.author: jaalmond
ms.date: 08/30/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic impact of Azure VMware Solution

Best practice encourages customers to create a single centralized cloud adoption strategy, using the [Cloud Adoption Framework's Strategy methodology](../../strategy/index.md). If you haven't already, use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) to record your cloud adoption strategy. This article will help expose a number of technical considerations regarding Azure VMware Solution that may have an impact on your strategy.

## Azure VMware Solution motivations
Common motivations for choosing Azure VMware Solution are:
- **Business needs** to accelerate cloud migration of VMware-based workloads and support TCO reduction and/or expand capacity rapidly. This includes the need to reduce costs, complexity and risk associated with larger scale migration projects
- **IT needs** for business continuity, disaster recovery and/or scale of traditional on-premises VMware environments, with little to no change to application (including VDI environments where modernization of VDI is not needed).
- **Operational needs** to leverage skills and processes already established across IT teams. While also giving them the ability to grow and adopt cloud competencies overtime.
- **Strategic needs** as business requirements arise, incrementally modernizing VMware-based applications with other Azure services.

## Azure VMware Solution outcomes

**Accelerate migration and lower TCO**
Reduce time and complexity of migrating VMware workloads to Azure. Leverage existing VMware investments, maintain operational consistency, and avoid downtime with live bulk VM migration.
- Manage VMware environments use familiar VMware tools without the need to retrain staff or replatform the hypervisor.
- Consistency in operations with direct administrative access to VMware vSphere interfaces.
- Reduce impact of change management and maintain operational and consistency for the business. Develop cloud skills overtime as administrators become familiar with Azure.
- Accelerate migration and minimize downtime using the latest HCX Enterprise functionality for large scale, live migration from on-premises to Azure.
- Extend on-premises layer 2 network to Azure for seamless workload mobility without changing IP addresses.
- Use VMware vMotion from vCenter to migrate live VMs from on-premises to Azure without any downtime.

**Gain reliability and scale**
Gain continuity, scale and fast provisioning for your VMware workloads on global Azure infrastructure.
- Gain elasticity with the ability to seamlessly add and remove capacity (compute and storage resources) on demand.
- Ensure business continuity with instant high availability, disaster recovery and backup services.
- High-speed, low-latency connectivity to Azure and on-premises. The connectivity is delivered through networking Azure ExpressRoute connections.
- Dedicated, isolated, private, domains in Azure on bare metal hyperconverged, all flash, infrastructure. Robust hardware infrastructure that can run the most demanding workloads.
- Fully automated self-service provisioning of the environment and capacity additions/removal

**Optimize licensing costs**
Leverage unmatched price benefits for Windows Server and SQL Server with:
- Free Extended Security Updates for Windows Server 2012, and SQL Server 2012, when transitioning to Azure including Azure VMware Solution (Link to ESU docs).
- Leverage Azure Hybrid Benefit for both Windows Server and SQL Server. Azure Hybrid Benefit allows you to bring your existing licenses to Azure and greatly reduce costs (Link to AHB).
- Azure Reservations discounts for reserved instances (and no cancellation fees). Azure VMware Solution offers 1-year and 3-year Reserved Instances for dedicated hosts. Save approximately 30-50% of the cost of a node (see pricing page for more details).  

**Modernize apps**
Modernize applications running on VMware overtime through integration to Azure native management, security, and services.
  - Unified hybrid management capabilities across Azure, VMware, and other cloud infrastructures (availability coming soon).
  - Modernize applications with the ability to connect them to Azure services such as Azure AD, SQL managed instances, and analytics.
  - Use Azure built-in Azure management, Azure Monitoring, and Azure Security Center solutions to operate your VMware environments.
  - Leverage Azure native public cloud capabilities for Disaster Recovery, Backup and more.
  - Unified permissions and access control using Azure Active Directory as a single sign on (SSO) identity source for VMware vCenter.

## Azure VMware Solution business justification

[Building a business justification for cloud migration](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/cloud-migration-business-case) can dispel many common myths for your team's financial plan. However, your finance team might need to develop a detailed financial model to account for all parts associated with Azure VMware Solution adoption.

Understand that your initial business justification is a directional estimate that can help to drive strategic alignment. Your organization can create transparency between the cloud strategy team and other stakeholders by affirming that this justification can change significantly throughout planning activities. Look for consensus that there's enough value to [gather inventory and develop a plan](https://docs.microsoft.com/azure/azure-vmware/plan-private-cloud-deployment). Once your digital estate is cataloged and assessed, you can refine your business case and present clear plans for financial returns.


## Next step: Plan for Azure VMware Solution

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for Azure VMware Solution](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate Azure VMware Solution](./migrate.md)
- [Innovate with Azure VMware Solution](./innovate.md)
- [Govern Azure VMware Solution](./govern.md)
- [Manage Azure VMware Solution](./manage.md)

