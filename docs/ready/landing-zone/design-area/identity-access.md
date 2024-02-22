---
title: Azure identity and access management design area
description: Understand the identity and access management design area as part of the Azure landing zone design areas.
author: soderholmd
ms.author: dsoderholm 
ms.topic: conceptual
ms.date: 02/23/2024
---

# Identity and access management design area

The identity and access management design area provides best practices that you can use to establish the foundation of your secure and fully compliant public cloud architecture.

Enterprises can have complex and heterogenous technological landscapes, so security is critical. Robust identity and access management forms the basis of modern protection by creating a security perimeter in a public cloud. Authorization and access controls ensure that only authenticated users with verified devices can access and administer applications and resources. It ensures that the right individual can access the right resources at the right time, and for the right reason. It also provides reliable audit logging and nonrepudiation of user or workload identity actions. You should provide consistent [enterprise access control](/security/privileged-access-workstations/privileged-access-access-model), including user access, control and management planes, external access, and privileged access, to improve productivity and mitigate the risk of unauthorized privilege escalation or data exfiltration.

Azure offers a comprehensive set of services, tools, and reference architectures to help your organization make highly secure and operationally efficient environments. There are several options for managing identity in a cloud environment. Each option varies in cost and complexity. Determine your cloud-based identity services based on how much you need to integrate them with your existing on-premises identity infrastructure. For more information, see [Identity decision guide](../../../decision-guides/identity/index.md).

## Identity and access management in Azure landing zones

Identity and access management is a core consideration in both platform and application landing zones. Under the design principle of [subscription democratization](../design-principles.md#subscription-democratization), application owners should have autonomy to manage their own applications and resources with minimal intervention from the platform team. Security is the fundamental difference between landing zones in the same Azure organization. Apply a robust identity and access management design to achieve application landing zone isolation.

The platform team is responsible for the foundation of identity and access management, including deploying and managing centralized directory services, such as Microsoft Entra ID, Microsoft Entra Domain Services, and Active Directory Domain Services (AD DS). Administrators and application landing zones consume these services, and users that access applications.

The application team is responsible for the identity and access management of their applications, including securing user access to applications and between application components, such as Azure SQL Database, Azure Cosmos DB, and Azure Storage. In a well-implemented landing zone architecture, the application team can effortlessly consume services that the platform team provides.

Many of the fundamental concepts of identity and access management are the same in both platform and application landing zones, such as role-based access control (RBAC) and the principle of least privilege.

## Design area review

**Roles and functions:** Identity and access management requires support from one or more of the following roles or functions. The users that have these roles can help make and implement decisions.

- [Cloud platform](../../../organize/cloud-platform.md)
- [Cloud center of excellence](../../../organize/cloud-center-of-excellence.md)
- [Cloud security team](../../../organize/cloud-security.md)

**Scope:** The goal of this design area is to help you evaluate options for your identity and access foundation. When you synchronize identities with Microsoft Entra ID, perform the following tasks:

- Authenticate users and workload identities.
- Assign access to resources.
- Determine core requirements for the separation of duties.
- Use hybrid identities with AD DS domains.

**Out of scope:** Identity and access management forms a foundation for proper access control. You don't need to address more advanced aspects like:

- The Zero Trust model.
- The operational management of elevated privileges.
- Automated guardrails to prevent common identity and access mistakes.

The compliance design areas for [security](./security.md) and [governance](./governance.md) address these aspects. For comprehensive recommendations for identity and access management, see [Azure identity management and access control security best practices](/azure/security/fundamentals/identity-management-best-practices).

## Design area overview

Identity provides the basis for a wide variety of security assurance. It grants access based on identity authentication and authorization controls in cloud services. Access control protects data and resources and helps determine which requests should be permitted.

Identity and access management is boundary security in the public cloud. It's the foundation of any secure and fully compliant public cloud architecture.

The following articles examine design considerations and recommendations for identity and access management in a cloud environment:

- [Hybrid identity with Active Directory and Microsoft Entra ID](identity-access-active-directory-hybrid-identity.md)
- [Landing zone identity and access management](identity-access-landing-zones.md)
- [Application identity and access management](identity-access-application-access.md)

For guidance about designing solutions on Azure by using established patterns and practices, see [Identity architecture design](/azure/architecture/identity/identity-start-here).

> [!TIP]
> If you have multiple Microsoft Entra ID tenants, see [Azure landing zones and multiple Microsoft Entra tenants](multi-tenant/overview.md).

## Next steps
>
> [!div class="nextstepaction"]
> [Hybrid identity with Active Directory and Microsoft Entra ID](identity-access-active-directory-hybrid-identity.md)
