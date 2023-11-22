---
title: Tailor an Azure landing zone architecture to meet regulatory requirements across multiple geographies
description: Learn about regulatory requirements.
author: mioteg
ms.author: mioteg
ms.date: 11/21/2023
ms.topic: conceptual
---

# Modify an Azure landing zone architecture to meet regulatory requirements across multiple geographies

Organizations in many industries are subject to regulatory requirements that can include data residency, data security, and data sovereignty requirements. Organizations that need to comply with conflicting regulations across multiple geographic boundaries (e.g. EU, UAE, and UK) might need to tailor their Azure landing zone architecture in accordance with all the applicable regulations.

For example, there might be two conflicting regulations, regulation A and regulation B. Regulation A might require data residency in country or region A, and regulation B might require data residency in country or region B.

Such regulatory conflicts can apply to:

- Multinational organizations, such as multinational corporations or non-governmental organizations (NGOs), that must comply with local regulations in the countries or regions that they operate in.

- Independent software vendors (ISVs) that provide solutions to organizations in multiple geographies, and the solution must comply with the local regulations in each geographic location.

- ISVs that provide solutions to multinational organizations that need to comply with the local regulations of each country or region that they operate in.

If you only need to meet a single set of regulatory requirements, see [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz).

## Regulatory considerations

Regulatory requirements are typically related to data protection, data residency, data transfers, isolation, or personnel clearance. These requirements can conflict for various geographies. For example, an EU regulation might require data residency in an EU country, while a UK regulation might require data residency in the UK. If regulations lead to conflicting policy controls, you must adjust the Azure landing zone architecture and policy assignments accordingly. How the Azure landing zone architecture can be tailored in such a scenario is further discussed below under Scenarios where tailoring might be required.  

When multiple regulations apply, you don't need to tailor the Azure landing zone architecture if:

- Different regulations require identical Azure Policy assignments.  

- The controls in one regulation are a superset of another regulation. The superset controls automatically apply to both regulations.

- The controls in different regulations don't overlap. When you implement both control sets, a single implementation covers both regulations. Azure Policy assignments are complementary.

- Various regulations might have different types of implementation. From a regulatory perspective, it doesn't matter which implementation you choose. For example, there might be two regulations that each have a different authorization model, but both authorization models are acceptable. You can choose the implementation that best fits your organization.

>[!TIP]
>You should strive to have as few policy assignments and exceptions/exemptions as possible.

## Tailoring considerations for ISVs

The [ISV considerations for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/isv-landing-zone) distinguishes three [deployment models](/azure/cloud-adoption-framework/ready/landing-zone/isv-landing-zone) for ISVs:

- **Customer-deployed**: The customer deploys the solution in their own environment.

- **Pure software as a service (SaaS)**: The ISV provides the solution as a service.

- **Dual-deployment SaaS**: This model combines the customer-deployed model and the pure SaaS model.

In a _customer-deployed model_, the customer is responsible for managing compliance. In this scenario, the ISV doesn't need to tailor the landing zones. However, the solution is deployed in a landing zone that the customer deploys, including any policy controls and custom policies.

>[!TIP]
>ISVs can test their solution with policy initiatives targeted at particular compliance requirements to minimize the chance of problems with policies that customers use to meet their compliance requirements.

In a _pure SaaS model_, the ISV is responsible for managing compliance on behalf of the customer and must demonstrate compliance to the customer and potentially to auditors or regulators. If you use the SaaS solution, you might be subject to different and even conflicting regulations. The ISV must manage compliance across these various regulations. In this scenario, the ISV might have to tailor the landing zones as discussed under Scenarios where tailoring might be required.

In a _dual-deployment SaaS model_, all the considerations for the customer-deployed and pure SaaS model apply.

## Tailoring considerations for multinational organizations

There are various structures that multinational organizations use to organize their IT governance.

- **Decentralized structure**: IT functions are governed locally in each geographic location.

- **Centralized structure**: IT functions are governed from a centralized place, typically the organization's headquarters.

- **Hybrid structure**: Global IT functions are provided centrally, while IT functions required only locally are governed in each geographic location.

In a _decentralized_ scenario, the local IT function is responsible for managing compliance and can tailor their landing zone accordingly.

In a _centralized_ scenario, the central IT function is responsible for managing compliance and must ensure that solutions meet the (local) compliance requirements of all the geographic locations where the multinational organization operates. The compliance requirements of various geographic locations can conflict, and it might be necessary to tailor landing zones.

In a _hybrid_ scenario, the considerations for both the decentralized and centralized scenarios apply. The centralized organization provides solutions that the local organization needs to deploy in their environment. The centralized organization also needs to test that those solution deploy in all landing zones of the local organizations.

## Scenarios where tailoring might be required

You might need to tailor landing zones if there are potentially conflicting policy sets that are assigned to different deployments.
In this scenario, there might be different solutions or a single solution that need to be made available to various geographic locations or data classifications.

The amount of tailoring that's required depends on the level of isolation that the regulation calls for. The more conditions that a regulation has, the more the landing zone needs to be tailored. For example, if regulations require conditions like cleared personnel, various identity providers or directories, separate management infrastructure, or separate connectivity infrastructure, the landing zone requires a high level of tailoring. If regulations only require that the application and connectivity infrastructure be isolated, the landing zone needs a low level of tailoring.

### Microsoft Entra tenants

We recommend [using a single Microsoft Entra tenant](/cloud-adoption-framework/ready/landing-zone/design-area/multi-tenant/overview) for most scenarios, including multinational scenarios. However, there are scenarios where you might prefer or require multiple Microsoft Entra tenants, such as:

- If you need to [separate the corporate Microsoft Entra tenant from the SaaS Microsoft Entra tenant](/azure/cloud-adoption-framework/ready/landing-zone/isv-landing-zone) to improve security and create clear boundaries between the product and business operations.

- If conflicting regulations apply, and you need separate Microsoft Entra tenants for different regulatory regimes. For example, regulations might have clearance and nationality requirements that require complete isolation between [Microsoft Entra tenants or data residency requirements that require separate tenants](/azure/active-directory/fundamentals/data-residency). ISVs might need to use this method to deploy isolated instances of a SaaS solution. And multinational organizations might need to use this method to deploy isolated instances of the same solution.

When you collaborate across multiple Microsoft Entra tenants, you need to carefully plan for significant challenges and needs. Create only the minimum number of Microsoft Entra tenants that you need to meet operational or regulatory requirements. You can use management groups and Azure role-based access control (RBAC) to govern the access to subscriptions and resources under this single tenant, as described in the next section.

>[!TIP]
>The Microsoft Entra tenant that you select for your landing zone doesn't affect your application-level authentication. You can still use other identity providers regardless of which tenant you choose. For public sector customers and customers in regulated industries, end-user identities are typically provided through integration with an approved identity provider, such as a government-owned or certified identity provider.

The following diagrams show options that you can use to organize Microsoft Entra tenants.

![A screenshot of a computer program  Description automatically generated](media/image1.png)

>[!TIP]
>If you have multiple Microsoft Entra tenants in order to meet regulatory requirements, name the tenants based on the geographic location rather than specific regulations, for example _contoso-ops-us.com_ in the example diagram.

For more information, see [Azure landing zones and multiple Microsoft Entra tenants](/azure/cloud-adoption-framework/ready/landing-zone/design-area/multi-tenant/overview) and [ISV considerations for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/isv-landing-zone#microsoft-entra-tenants).

### Management groups

If you don't need separate Microsoft Entra tenants in order to provide strict isolation, you should deploy multiple Azure landing zones in a single Microsoft Entra tenant. You can adjust the management group hierarchy to address the requirements of conflicting regulations.

You can deploy a full landing zone architecture for each set of regulations that you want to separate. This model requires the least amount of customization and enables you to take advantage of existing automation for deployment.

![A diagram of a software company  Description automatically generated](media/image2.png)

>[!NOTE]
>The previous diagram doesn't show all management groups.

#### Share the platform management group

If regulation allows, the platform management group can be shared. In that case, you can create separate management groups under the landing zone management group for each set of regulations that needs to be separated. You can assign the appropriate policies to each of the application management groups. The management groups under the platform management group are shared for all application landing zones. The resources in the application management groups can also be separated by subscription or resource group.

This management group hierarchy is a simple and cost-effective design for isolating applications with conflicting regulations. However, in this design, the platform management groups for connectivity, identity/security, and management must share the same policy set. You might need different policy sets for each platform management group if regulation imposes restrictions on sharing connectivity infrastructure, identity services, key management services, and the infrastructure from which the whole environment is managed.

![A diagram of a company  Description automatically generated](media/image3.png)

##### Isolate identity and security

If regulations prevent you from sharing the identity and key management infrastructure, you can divide the platform management group. Keep the management groups for connectivity and management in the shared platform management group and have an identity and security management group that's associated with each set of regulations.

This management group hierarchy is significantly more complex than a fully shared platform management group because you have to partially replicate the platform management group. To limit the complexity, you can deploy the full hierarchy for each of the regulation sets and the shared environment and ignore or delete the superfluous management groups.

![A diagram of a company  Description automatically generated](media/image4.png)

##### Isolate connectivity

Many regulations have requirements related to processing and storing data in a certain geographic location, with few requirements around how users connect to applications. For those regulations, sharing the connectivity management as in the previous architecture is acceptable. There might not be any regulations that require you to duplicate infrastructure in different regions, but you might need this structure for latency purposes. The assigned policies need to support duplicating infrastructure in different regions.

When regulations have conflicting connectivity requirements, you can create a connectivity management group that's associated with each set of regulations. This structure is similar to the previous architecture that associates identity and security management groups with each set of regulations.

If regulations conflict for connectivity and also identity and security, you can combine this design with the previous design as shown in the following diagram.

![A diagram of a company  Description automatically generated](media/image5.png)

## Next steps

- [Azure landing zones and multiple Microsoft Entra tenants](/azure/cloud-adoption-framework/ready/landing-zone/design-area/multi-tenant/overview)
- [Identity and access management checklist](/azure/well-architected/security/design-identity)
- [ISV considerations for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/isv-landing-zone)
- [Microsoft Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework)
- [Microsoft Entra ID and data residency](/azure/active-directory/fundamentals/data-residency)
- [Overview of the security pillar](/industry/well-architected/security)
- [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)
