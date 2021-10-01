---
title: Cloud Adoption Framework enterprise-scale landing zone architecture
description: Learn about enterprise-scale landing zone architecture in the Cloud Adoption Framework for Azure. Explore high-level architecture diagrams and component lists.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/30/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, csu
---

# Cloud Adoption Framework enterprise-scale landing zone architecture

Enterprise-scale is an architectural approach and a reference implementation. It enables effective construction and operationalization of landing zones on Azure, at scale. This approach aligns with the Azure roadmap and the Cloud Adoption Framework for Azure.

## Architecture overview

The Cloud Adoption Framework enterprise-scale landing zone architecture represents the strategic design path and target technical state for an organization's Azure environment. It continues to evolve alongside the Azure platform. Various design decisions define the architecture that your organization must make to map your Azure journey.

Not all enterprises adopt Azure the same way. The Cloud Adoption Framework enterprise-scale landing zone architecture varies between customers. Based on your organization's scenario, the technical considerations and design recommendations in this guide might yield different tradeoffs. Expect some variation, but if you follow the core recommendations, the resulting target architecture will set your organization on a path to sustainable scale.

## Landing zone in enterprise-scale

Azure landing zones are the output of a multisubscription Azure environment that accounts for:

- Scale
- Security
- Governance
- Networking
- Identity

Azure landing zones enable application migrations and greenfield development at enterprise-scale in Azure. These zones consider all platform resources that are necessary to support the customer's application portfolio. The zones don't differentiate between infrastructure as a service (IaaS) or platform as a service (PaaS).

To help streamline the application migration process before it begins, the following services must be readily available:

- Network
- Identity and access management
- Policies
- Management
- Monitoring

:::image type="content" source="./media/lz-design.png" alt-text="Diagram that shows a landing zone design. The needed services are for network, identity and access management, policies, management, and monitoring.":::  
*Figure 1: Landing zone design.*

## High-level architecture

An enterprise-scale architecture includes a set of design considerations and recommendations across eight [critical design areas](./design-guidelines.md). It has two recommended network topologies: an enterprise-scale architecture based on an Azure Virtual WAN network topology (Figure 2) or based on a traditional Azure network topology that's on the hub-and-spoke architecture (Figure 3).

:::image type="content" source="./media/ns-arch-inline.png" alt-text="Diagram that shows Cloud Adoption Framework enterprise-scale landing zone architecture based on an Azure Virtual WAN network topology." lightbox="./media/ns-arch-expanded.png":::  
*Figure 2: Cloud Adoption Framework enterprise-scale landing zone architecture based on an Azure Virtual WAN network topology. The connectivity subscription uses a Virtual WAN hub.*

:::image type="content" source="./media/ns-arch-cust-inline.png" alt-text="Diagram that shows Cloud Adoption Framework enterprise-scale landing zone architecture based on a traditional Azure networking topology." lightbox="./media/ns-arch-cust-expanded.png":::  
*Figure 3: Cloud Adoption Framework enterprise-scale landing zone architecture based on a traditional Azure networking topology. The connectivity subscription uses a hub VNet.*

Download one or both of the enterprise-scale architecture diagrams using these options:

- The [Virtual WAN (PDF)](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/enterprise-scale-architecture.pdf) network topology
- A traditional Azure network topology that's based on the [hub-and-spoke (PDF)](https://github.com/microsoft/CloudAdoptionFramework/raw/master/ready/enterprise-scale-architecture-cust.pdf) architecture
- Both the Virtual WAN and the hub-and-spoke architecture, as a [Visio diagram (VSDX)](https://github.com/microsoft/CloudAdoptionFramework/raw/master/ready/enterprise-scale-architecture.vsdx)

> [!IMPORTANT]
> If the team that manages the platform resources isn't concerned with separating duties, you can implement an enterprise-scale landing zone architecture with a single subscription for **platform resources**. With scalability and security in mind, it's strongly recommended to have dedicated subscriptions for platform resources (Figures 2 and 3).

Figures 2 and 3 reference the enterprise-scale critical design areas, which are outlined by the letters A through I:

![The letter A](./media/a.png) [Enterprise Agreement enrollment and Azure Active Directory (Azure AD) tenants](./enterprise-enrollment-and-azure-ad-tenants.md). An Enterprise Agreement enrollment represents the commercial relationship between Microsoft and how your organization uses Azure. It provides the basis for billing across all your subscriptions, and it affects administration of your digital estate. Manage your Enterprise Agreement enrollment through the Azure enterprise portal. An enrollment often represents an organization's hierarchy, which includes departments, accounts, and subscriptions. An Azure AD tenant provides identity and access management, which is an important part of your security posture. In an Azure AD tenant, authenticated and authorized users have access only to the resources for which they have access permissions.

![The letter B](./media/b.png) [Identity and access management](./identity-and-access-management.md). Build Azure AD design and integration to ensure both server and user authentication. Model and deploy Azure role-based access control (Azure RBAC). This practice enforces the separation of duties. It also enforces the required entitlements for platform operation and management. Design and deploy key management to ensure secure access to resources and support operations, such as rotation and recovery. To create and manage resources autonomously, access roles ultimately are assigned to application owners at the control and data planes.

![The letter C](./media/c.png) [Management group and subscription organization](./management-group-and-subscription-organization.md). Management group structures within an Azure AD tenant support organizational mapping. Consider these structures thoroughly when an organization plans Azure adoption at scale. Subscriptions are a unit of management, billing, and scale within Azure. When you design for large-scale Azure adoption, subscriptions play a critical role. This design area helps you capture subscription requirements and design target subscriptions based on critical factors. These factors are environment type, ownership and governance model, organizational structure, and application portfolios.

![The letter D](./media/d.png) [Management and monitoring](./management-and-monitoring.md). Design, deploy, and integrate platform-level holistic (horizontal) resource monitoring and alerting. Define and streamline operational tasks, such as patching and backup. Design and integrate the security operations, monitoring, and logging with Azure resources and existing on-premises systems. Stream into Log Analytics all subscription activity logs that capture control plane operations across resources. This practice makes the logs available for query and analysis, subject to Azure RBAC permissions.

![The letter E](./media/e.png) [Network topology and connectivity](./network-topology-and-connectivity.md). To ensure north-south and east-west connectivity between platform deployments, build and deploy the end-to-end network topology across Azure regions and on-premises environments. To fully meet the security requirements, you must identify, deploy, and configure the required services and resources throughout the network security design. These services and resources include firewalls and network virtual appliances.

![The letter F](./media/f.png), ![The letter G](./media/g.png), ![The letter H](./media/h.png) [Business continuity and disaster recovery](./business-continuity-and-disaster-recovery.md), and [security governance and compliance](./security-governance-and-compliance.md). Make sure corporate, regulatory, and line-of-business controls are in place. Identify, describe, build, and deploy holistic and landing-zone-specific policies to place those controls. Use these policies to guarantee the compliance of applications and underlying resources without any abstraction provisioning or administration capability.

![The letter I](./media/i.png) [Platform automation and DevOps](./platform-automation-and-devops.md). Ensure a safe, repeatable, and consistent delivery of infrastructure-as-code artifacts. Design, build, and deploy an end-to-end DevOps experience with robust software development lifecycle practices to ensure artifact delivery. Develop, test, and deploy such artifacts. Use dedicated integration, release, and deployment pipelines with strong source control and traceability.

## Next steps

Customize implementation of this architecture by using the Cloud Adoption Framework enterprise-scale design guidelines.

> [!div class="nextstepaction"]
> [Design guidelines](./design-guidelines.md)
