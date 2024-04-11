---
title: Brownfield landing zone considerations
description: Learn about aligning the Azure landing zone target architecture and best practices to an existing environment.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/23/2023
ms.topic: conceptual
ms.custom: internal
---

# Brownfield landing zone considerations

A brownfield deployment is an existing environment that requires modification to align to the Azure landing zone target architecture and best practices. When you need to resolve a brownfield deployment scenario, consider your existing Microsoft Azure environment as the place to start. This article summarizes guidance found elsewhere in the Cloud Adoption Framework Ready documentation For more information, see [Introduction to the Cloud Adoption Framework Ready methodology](/shows/azure-enablement/an-introduction-to-the-cloud-adoption-framework-ready-methodology).

## Resource organization

In a brownfield environment, you've already established your Azure environment. But it's never too late to apply proven [resource organization principles](./design-area/resource-org.md) now and moving forward. Consider implementing any of the following suggestions:

- If your current environment doesn't use management groups, consider them. Management groups are key to managing policies, access, and compliance across subscriptions at scale. [Management groups](./design-area/resource-org-management-groups.md) help guide your implementation.
- If your current environment uses management groups, consider the guidance in [management groups](./design-area/resource-org-management-groups.md) when evaluating your implementation.
- If you have existing subscriptions in your current environment, consider the guidance in [subscriptions](./design-area/resource-org-subscriptions.md) to see if you're using them effectively. Subscriptions act as policy and management boundaries and are scale units.
- If you have existing resources in your current environment, consider using the guidance in [naming and tagging](../azure-best-practices/naming-and-tagging.md) to influence your tagging strategy and your naming conventions going forward.
- [Azure Policy](/azure/azure-resource-manager/management/tag-policies) is useful in establishing and enforcing consistency regarding taxonomic tags.

## Security

To refine your existing Azure environment's [security posture](./design-area/security.md) regarding authentication, authorization, and accounting is an ongoing, iterative process. Consider implementing the following recommendations:

- Make use of Microsoft's [top 10 Azure security best practices](../../secure/security-top-10.md). This guidance summarizes field-proven guidance from Microsoft cloud solution architects (CSAs) and Microsoft Partners.
- Deploy [Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/what-is-cloud-sync) to provide your local Active Directory Domain Services (AD DS) users with secure single sign-on (SSO) to your Microsoft Entra ID-backed applications. Another benefit to configuring hybrid identity is you can enforce [Microsoft Entra multifactor authentication (MFA)](/azure/active-directory/authentication/concept-mfa-howitworks) and [Microsoft Entra Password Protection](/azure/active-directory/authentication/concept-password-ban-bad-on-premises) to further protect these identities
- Consider [Microsoft Entra Conditional Access](/azure/active-directory/conditional-access/overview) to provided secure authentication to your cloud apps and Azure resources.
- Implement [Microsoft Entra Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) to ensure least-privilege access and deep reporting in your entire Azure environment. Teams should begin recurring access reviews to ensure the right people and service principles have current and correct authorization levels. Also, study the [Cloud Adoption Framework access control guidance](../../secure/access-control.md).
- Make use of the recommendations, alerting, and remediation capabilities of [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction). Your security team can also integrate Microsoft Defender for Cloud into [Microsoft Sentinel](/azure/sentinel/overview) if they need a more robust, centrally managed hybrid and multicloud Security Information Event Management (SIEM)/Security Orchestration and Response (SOAR) solution.

## Governance

Like Azure security, [Azure governance](./design-area/governance.md) isn't a "one and done" proposition. Rather, it's an ever-evolving process of standardization and compliance enforcement. Consider implementing the following controls:

- Review our guidance for establishing a [management baseline](./design-area/management.md) for your hybrid or multicloud environment
- Implement [Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview) features like billing scopes, budgets, and alerts to ensure your Azure spend stays within prescribed bounds
- Use [Azure Policy](/azure/governance/policy/overview) to enforce governance guardrails on Azure deployments, and trigger remediation tasks to bring existing Azure resources into a compliant state
- Consider [Microsoft Entra entitlement management](/azure/active-directory/governance/entitlement-management-overview) to automate Azure requests, access assignments, reviews, and expiration
- Apply [Azure Advisor](/azure/advisor/advisor-overview) recommendations to ensure cost optimization and operational excellence in Azure, both of which are core principles of the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/).

## Networking

It's true that refactoring an already established [Azure virtual network (VNet) infrastructure](./design-area/network-topology-and-connectivity.md) can be a heavy lift for many businesses. That said, consider incorporating the following guidance into your network design, implementation, and maintenance efforts:

- Review our best practices for planning, deploying, and maintaining [Azure VNet hub and spoke topologies](../azure-best-practices/hub-spoke-network-topology.md)
- Consider [Azure Virtual Network Manager (Preview)](/azure/virtual-network-manager/overview) to centralize network security group (NSG) security rules across multiple VNets
- [Azure Virtual WAN](/azure/virtual-wan/virtual-wan-about) unifies networking, security, and routing to help businesses build hybrid cloud architectures safer and quicker
- Access Azure data services privately with [Azure Private Link](/azure/private-link/private-link-overview). The Private Link service ensures your users and applications communicate with key Azure services by using the Azure backbone network and private IP addresses instead of over the public Internet

## Next steps

Now that you have an overview of Azure brownfield environment considerations, here are some related resources to review:

- [Azure Landing Zones Bicep - Deployment Flow](https://github.com/Azure/ALZ-Bicep/wiki/DeploymentFlow)
- [Microsoft Well-Architected Framework](/azure/architecture/framework/)
- [Cloud Adoption Framework tools and templates](../../resources/tools-templates.md)
