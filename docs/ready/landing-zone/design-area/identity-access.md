---
title: Azure identity and access management design area
description: Understand the identity and access management design area as part of the Azure landing zone design areas.
author: soderholmd
ms.author: dsoderholm 
ms.topic: conceptual
ms.date: 12/05/2023
---

# Identity and access management design area

This critical design area establishes a foundation for the management of identity and access based on best practices.

The technological landscape in the enterprise is becoming complex and heterogenous, and Identity is the primary security perimeter in a public cloud, so Identity and access management must be treated as the foundation of any secure and fully compliant public cloud architecture.

Robust identity and access management forms the basis of modern security. Authorization and access controls ensure that only authenticated users with verified devices can access and administer applications and resources. It ensures that the right individual can access the right resources at the right time, and for the right reason. It also provides reliable audit logging and nonrepudiation of user or workload identity actions.

Azure offers a comprehensive set of services, tools, and reference architectures to help organizations make highly secure and operationally efficient environments. Several options are available for managing identity in a cloud environment. These options vary in cost and complexity. A key factor in structuring your cloud-based identity services is the level of integration required with your existing on-premises identity infrastructure. See the [Identity decision guide](../../../decision-guides/identity/index.md) for more information.

## Identity and access management in Azure Landing Zones

Identity and access management is a core consideration in both platform and application landing zones. Under the design principle of subscription democratization, application owners should have autonomy to manage their own applications and resources with minimal intervention from the platform team. Security is the fundamental differentiator between landing zones in the same Azure organization, and by applying a robust identity and access management design, application landing zone isolation is naturally achieved.

The platform team is responsible for the identity and access management foundation, including deploying and managing centralized directory services such as Microsoft Entra ID, Microsoft Entra Domain Services, and Active Directory Domain Services. These services are consumed by administrators of application landing zones, and by users accessing applications.

The application team is responsible for the identity and access management of their applications. This includes securing user access to applications, and between application components, such as Azure SQL Database, Azure Cosmos DB, and Azure Storage. In a well-implemented Landing Zones architecture, the application team consumes services provided by the platform team with minimal effort.

Many of the fundamental concepts of identity and access management are the same in both platform and application landing zones, such as role-based access control (RBAC), and the principle of least privilege.

## Design area review

**Involved roles or functions:** Identity and access management require support from one or more of the following functions. These roles can help make decisions and implement those decisions:

- [Cloud platform](../../../organize/cloud-platform.md)
- [Cloud center of excellence](../../../organize/cloud-center-of-excellence.md)
- [Cloud security team](../../../organize/cloud-security.md)

**Scope:** The goal of this design area is to evaluate options for your identity and access foundation. At a minimum, make decisions about your approach for synchronizing identities with Microsoft Entra ID:

- Authenticating users and workload identities
- Assigning access to resources
- Core requirements for separation of duties
- Using hybrid identities with Active Directory Domain Services domains

**Out of scope:** Identity and access management forms a foundation for proper access control. It doesn't fully address more advanced topics like:

- Zero trust
- Operational management of elevated privileges
- Automated guardrails to prevent common identity and access mistakes

These topics are addressed in the compliance design areas related to [security](./security.md) and [governance](./governance.md). Additionally, the [Azure Identity Management and access control security best practices](/azure/security/fundamentals/identity-management-best-practices) guide provides a comprehensive set of recommendations for identity and access management.

## Design area overview

Identity provides the basis for a wide variety of security assurance. It grants access based on identity authentication and authorization controls in cloud services. Access control protects data and resources and helps decide which requests should be permitted.

Identity and access management is boundary security in the public cloud. It must be treated as the foundation of any secure and fully compliant public cloud architecture.

These articles examine design considerations and recommendations related to identity and access management in a cloud environment:

- [Hybrid identity with Active Directory and Microsoft Entra ID](identity-access-active-directory-hybrid-identity.md)
- [Landing zone identity and access management](identity-access-landing-zones.md)
- [Application identity and access management](identity-access-application-access.md)

> [!TIP]
> If you have multiple Microsoft Entra ID tenants, review [**Azure landing zones and multiple Microsoft Entra tenants**](multi-tenant/overview.md) and its associated content.

## Additional resources

- Refer to the [Azure Architecture Center](/azure/architecture/identity/identity-start-here) for guidance for designing solutions on Azure using established patterns and practices.

### Next steps

>
> [!div class="nextstepaction"]
> [Hybrid identity with Active Directory and Microsoft Entra ID](identity-access-active-directory-hybrid-identity.md)
