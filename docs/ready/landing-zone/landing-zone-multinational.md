---
title: Modify an Azure landing zone architecture to meet requirements across multiple locations
description: Learn how to modify an Azure landing zone so it complies with the regulatory requirements of various geographic locations.
author: mioteg
ms.author: mioteg
ms.date: 02/27/2025
ms.topic: conceptual
---

# Modify an Azure landing zone architecture to meet requirements across multiple locations

Organizations in many industries are subject to regulatory requirements, including data residency, data security, and data sovereignty requirements. Some organizations need to comply with conflicting regulations across multiple geographic locations. In this case, they need to modify their Azure landing zone architecture in accordance with all the applicable regulations.

For example, there might be two conflicting regulations, regulation A and regulation B. Regulation A might require data residency in country or region A, and regulation B might require data residency in country or region B.

Such regulatory conflicts can apply to:

- Multinational organizations, such as multinational corporations or non-governmental organizations (NGOs), that must comply with local regulations in the countries or regions that they operate in.

- Independent software vendors (ISVs) that provide solutions to organizations in multiple locations, and the solution must comply with the local regulations in each location.

- ISVs that provide solutions to multinational organizations that need to comply with the local regulations of each country or region that they operate in.

If you only need to meet a single set of regulatory requirements, see [Tailor the Azure landing zone architecture to meet requirements](tailoring-alz.md).

## Regulatory considerations

Regulatory requirements are typically related to data protection, data residency, data transfers, isolation, or personnel clearance. These requirements can conflict among multiple geographic locations. For example, a European Union (EU) regulation might require data residency in an EU country, while a United Kingdom regulation might require data residency in the United Kingdom.

If regulations lead to conflicting policy controls, you must adjust the Azure landing zone architecture and policy assignments accordingly. For more information, see [the section in this article, Scenarios that require modification](#scenarios-that-require-modification).

When multiple regulations apply, you don't need to modify the Azure landing zone architecture if:

- Multiple regulations require identical Azure Policy assignments.  

- The controls in one regulation are a superset of another regulation. The superset controls automatically apply to both regulations.

- The controls in multiple regulations don't overlap. When you implement multiple control sets, a single implementation covers all regulations. Azure Policy assignments are complementary.

- Various regulations have different types of implementation. From a regulatory perspective, it doesn't matter which implementation you choose. For example, there might be two regulations that each have a different authorization model, but both authorization models are acceptable. You can choose the implementation that best fits your organization.

>[!TIP]
>You should strive to have as few policy assignments and exceptions or exemptions as possible.

## Considerations for ISVs

There are three [deployment models for ISVs](isv-landing-zone.md#isv-deployment-models).

- **Pure software as a service (SaaS)**: The ISV provides the solution as a service.

- **Customer deployed**: The customer deploys the solution in their own environment.

- **Dual-deployment SaaS**: This model combines the customer-deployed model and the pure SaaS model.

In a *pure SaaS model*, the ISV is responsible for managing compliance on behalf of the customer. The ISV must demonstrate compliance to the customer and potentially to auditors or regulators. If you use the SaaS model, your architecture might be subject to multiple regulations that can conflict. The ISV must manage compliance for these various regulations. For more information, see [the section in this article, Scenarios that require modification](#scenarios-that-require-modification).

In a *customer-deployed model*, the customer is responsible for managing compliance. For this model, the ISV doesn't need to modify the landing zones. However, the solution is deployed in a landing zone that the customer deploys, including any policy controls and custom policies.

>[!TIP]
>ISVs can target policy initiatives at particular compliance requirements to test a solution. This practice can help minimize the chance of conflicts with policies that customers use to meet their compliance requirements.

In a *dual-deployment SaaS model*, all the considerations for the customer-deployed and pure SaaS model apply.

## Considerations for multinational organizations

Multinational organizations use various structures to organize their IT governance.

- **Decentralized structure**: IT functions are governed locally in each geographic location.

- **Centralized structure**: IT functions are governed from a centralized place, typically the organization's headquarters.

- **Hybrid structure**: Global IT functions are provided centrally, while IT functions required only locally are governed in each geographic location.

In a *decentralized* scenario, the local IT team is responsible for managing compliance and can tailor their landing zone accordingly.

In a *centralized* scenario, the central IT team is responsible for managing compliance and must ensure that solutions meet the local compliance requirements of all the geographic locations where the multinational organization operates. The compliance requirements of various geographic locations can conflict, and it might be necessary to modify landing zones.

In a *hybrid* scenario, the considerations for both the decentralized and centralized scenarios apply. The centralized organization provides solutions that the local organizations need to deploy in their environment. The centralized organization also tests that those solutions deploy in all landing zones of the local organizations.

## Scenarios that require modification

You might need to modify landing zones if there are conflicting policy sets that are assigned to various deployments. There might be multiple solutions or a single solution that need to be made available to various geographic locations or data classifications.

The amount of modification that's required depends on the level of isolation that the regulation calls for. The more conditions that a regulation has, the more the landing zone needs to be modified. For example, if regulations require conditions like cleared personnel, various identity providers or directories, separate management infrastructure, or separate connectivity infrastructure, the landing zone requires extensive modification. If regulations only require that the application and connectivity infrastructure be isolated, the landing zone needs minimal modification.

### Microsoft Entra tenants

We recommend [using a single Microsoft Entra tenant](./design-area/multi-tenant/overview.md) for most scenarios, including multinational scenarios. However, there are scenarios where you might prefer or require multiple Microsoft Entra tenants, such as:

- If you need to [separate the corporate Microsoft Entra tenant from the SaaS Microsoft Entra tenant](isv-landing-zone.md) to improve security and create clear boundaries between the product and business operations.

- If conflicting regulations apply, and you need separate Microsoft Entra tenants for different regulatory regimes. For example, regulations might have clearance and nationality requirements that need complete isolation between [Microsoft Entra tenants or data residency requirements that require separate tenants](/entra/fundamentals/data-residency). Common scenarios include an ISV that needs to deploy isolated instances of a SaaS solution or a multinational organization that needs to deploy isolated instances of the same solution.

When you collaborate across multiple Microsoft Entra tenants, you need to carefully plan for significant challenges and needs. Create only the minimum number of Microsoft Entra tenants that you need to meet operational or regulatory requirements. You can use management groups and Azure role-based access control (RBAC) to govern the access to subscriptions and resources under a single tenant, as described in the next section.

>[!TIP]
>The Microsoft Entra tenant that you select for your landing zone doesn't affect your application-level authentication. You can still use other identity providers regardless of which tenant you choose. For public sector customers and customers in regulated industries, end-user identities are typically provided when you integrate with an approved identity provider, such as a government-owned or certified identity provider.

The following diagrams show options that you can use to organize Microsoft Entra tenants.

:::image type="content" source="./media/tenant-organization.png" alt-text="A diagram that shows three ways to organize Microsoft Entra tenants." lightbox="./media/tenant-organization.png":::

>[!TIP]
>If you have multiple Microsoft Entra tenants to meet regulatory requirements, name the tenants based on the geographic location rather than specific regulations, for example *contoso-ops-us.com* in the example diagram.

For more information, see [Azure landing zones and multiple Microsoft Entra tenants](./design-area/multi-tenant/overview.md) and [ISV considerations for Azure landing zones](isv-landing-zone.md#microsoft-entra-tenants).

### Management groups

If you don't need separate Microsoft Entra tenants in order to provide strict isolation, you should deploy multiple Azure landing zones in a single Microsoft Entra tenant. You can adjust the management group hierarchy to address the requirements of conflicting regulations.

You can deploy a full landing zone architecture for each set of regulations that you want to separate. This model requires the least amount of customization and enables you to take advantage of existing automation for deployment.

:::image type="content" source="./media/landing-zone-model.png" alt-text="A diagram that shows separate landing zones for each regulation." lightbox="./media/landing-zone-model.png":::

>[!NOTE]
>This diagram doesn't show all management groups.

#### Share the platform management group

If regulation allows, the platform management group can be shared. You can create separate management groups under the landing zone management group for each set of regulations that needs to be separated. You can assign the appropriate policies to each of the application management groups. The application landing zones share the management groups that are under the platform management group. The resources in the application management groups can also be separated by subscription or resource group.

This management group hierarchy is a simple and cost-effective design for isolating applications with conflicting regulations. However, in this design, the platform management groups for connectivity, identity/security, and management must share the same policy set. You might need different policy sets for each platform management group if regulation imposes restrictions on sharing connectivity infrastructure, identity services, key management services, or the infrastructure from which the whole environment is managed.

:::image type="content" source="./media/platform-management-group.png" alt-text="A diagram that shows an architecture that shares the platform management group." lightbox="./media/platform-management-group.png":::

#### Isolate identity and security

If regulations prevent you from sharing the identity and key management infrastructure, you can divide the platform management group. Keep the management groups for connectivity and management in the shared platform management group and have an identity and security management group that's associated with each set of regulations.

This management group hierarchy is significantly more complex than a fully shared platform management group because you have to partially replicate the platform management group. To limit the complexity, you can deploy the full hierarchy for each of the regulation sets and the shared environment, and ignore or delete the superfluous management groups.

:::image type="content" source="./media/isolation-model.png" alt-text="A diagram that shows an architecture that isolates identity and security." lightbox="./media/isolation-model.png":::

#### Isolate connectivity

Many regulations have requirements related to processing and storing data in a certain geographic location, with few requirements around how users connect to applications. For those regulations, you can share the connectivity management as shown in the previous architecture. There might not be any regulations that require you to duplicate infrastructure in multiple regions, but you might need to for latency purposes. The assigned policies need to support duplicating infrastructure in multiple regions.

When regulations have conflicting connectivity requirements, you can create a connectivity management group that's associated with each set of regulations. This structure is similar to the previous architecture that associates identity and security management groups with each set of regulations.

If regulations conflict for connectivity and also identity and security, you can use the following design.

:::image type="content" source="./media/isolate-connectivity-model.png" alt-text="A diagram that shows an architecture that isolates connectivity." lightbox="./media/isolate-connectivity-model.png":::

## Next steps

- [Azure landing zones and multiple Microsoft Entra tenants](./design-area/multi-tenant/overview.md)
- [ISV considerations for Azure landing zones](isv-landing-zone.md)
- [Microsoft Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework)
- [Microsoft Entra ID and data residency](/entra/fundamentals/data-residency)
- [Overview of the security pillar](/industry/well-architected/security)
- [Recommendations for identity and access management](/azure/well-architected/security/design-identity)
- [Tailor the Azure landing zone architecture to meet requirements](tailoring-alz.md)
