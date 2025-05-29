---
title: Subscription vending
description: Subscription vending
author: stephen-sumner
ms.author: pnp
ms.date: 02/20/2025
ms.topic: conceptual
ms.custom: internal, UpdateFrequency.5
---

# Subscription vending

Subscription vending provides a platform mechanism for programmatically issuing subscriptions to application teams that need to deploy workloads. The following diagram shows where subscription vending fits in the platform and workload lifecycles.

:::image type="complex" source="./media/subscription-vending-high-res.png" alt-text="Diagram showing four steps." lightbox="./media/subscription-vending-high-res.png" border="false":::
Step 1 is to create the platform subscriptions. Step 2 is to create the platform. Step 3 is to establish subscription vending. Step 4 is to deploy workloads. Steps 1 and 2 align with the platform. Step 3, subscription vending, overlaps with both the platform and application landing zone. Step 4 is an application focused step.
:::image-end:::

Subscription vending builds on the concept of subscription democratization and applies it to application landing zones. With subscription democratization, subscriptions, not resource groups, are the primary units of workload management and scale. For more information, see:

- [Platform landing zones vs. application landing zones](../index.md#platform-landing-zones-vs-application-landing-zones)
- [Democratized approach to subscriptions](../design-principles.md#subscription-democratization)
- [How many subscriptions should I use in Azure (YouTube)?](https://www.youtube.com/watch?v=R-5oeguxFpo&t=13s)

## Why subscription vending?

> [!VIDEO https://www.youtube.com/embed/OoC_0afxACg]

Subscription vending offers several benefits to organizations that need to deploy workloads in Azure. It standardizes and automates the process for requesting, deploying, and governing subscriptions for application landing zones. Subscription vending simplifies the subscription creation process and places it under the governance of the organization, so app teams can focus on deploying their workloads with greater confidence and efficiency.

- **Streamlined process:** Subscription vending provides an official front door for application teams to request subscriptions, eliminating the need for them to navigate the subscription process on their own.
- **Improved velocity:** Application teams can access application landing zones faster and onboard workloads quicker.
- **Efficient governance:** The platform team can enforce governance on application landing zones with minimal overhead.

## How to implement subscription vending

Subscription vending involves three teams. The Cloud Center of Excellence (CCoE) establishes business logic and the approval process. When ready, the application teams make subscription requests. The platform team uses the request to create and configure the subscription before handing off the subscription to the application team. The application team updates the budget, deploys the workload, and establishes operations. The following guidance provides more details on each step of the subscription vending process. For more information, see [Subscription vending implementation guidance](/azure/architecture/landing-zones/subscription-vending).

:::image type="content" source="./media/subscription-vending-process.png" alt-text="Diagram showing the subscription vending process." lightbox="./media/subscription-vending-process.png" border="false":::

Platform teams can vend many options and subscription types to application teams. These types are referred to as *product lines* because they relate to platform-engineering principles and practices. For more information about choosing the option that best suits your needs, see [Common subscription vending product lines](./subscription-vending-product-lines.md).

### Establish business logic and approval process

To implement the subscription vending model, you need to establish an approval process that collects essential subscription information. The Cloud Center of Excellence (CCoE) should program the approval process and establish business rules around the information to collect.

**Automate process.** You should automate the process of subscription request capture and approval for faster provisioning and improved compliance.

**Integrate with existing tooling.** You should integrate the subscription vending approval process into your existing IT service management (ITSM) tool. The integration can simplify the approval process, reduce manual effort, and improve efficiency while reducing errors. It also makes maintenance easier over time and helps with compliance reporting for audits.

**Connect to deployment pipeline.** It's a best practice to tie the business logic of the approval process into the subscription deployment pipeline that the platform team manages. Azure Pipelines or GitHub Actions workflows are common solutions for the subscription deployment pipeline.

**Gather requirements at intake.** The business logic should allow application teams to request a subscription and provide subscription requirements. These requirements should include anticipated budgets, subscription owners, networking expectations, and business criticality & confidentiality classification. Gathering this information at the beginning of the process informs your deployment parameters and stakeholder approval needs. The intake process should also give the platform team enough information to place the workload in the management group hierarchy.

With the approval process in place, application teams can start making subscription requests.

### Make a subscription request

Subscription vending provides a standard process for application teams to request a subscription. It's important that you socialize the availability of subscription vending and ensure subscription requests are easy to make. After the application team submits a subscription request, the platform team assumes control of the process. The platform team maintains control until they create the subscription and deliver the subscription to the application team.

### Configure networking

The subscription automation needs to set up the required networking components, and it needs to be flexible enough to meet the needs of each application team. As general guidance, never use overlapping IP addresses in a single routing domain. You can add or delete the address space of a virtual network without downtime if your size requirements change. For more information, see:

- [IP address restrictions](/azure/virtual-network/virtual-networks-faq#are-there-any-restrictions-on-using-ip-addresses-within-these-subnets)
- [Update address space of a peered virtual network](/azure/virtual-network/update-virtual-network-peering-address-space)
- [Add or remove address range](/azure/virtual-network/manage-virtual-network#add-or-remove-an-address-range)

**Use IP address management (IPAM) tool.** You should use and integrate an IPAM system into the vending process to streamline IP address assignment. For more information and IPAM guidance, see [IP Address Management (IPAM) tools](../../azure-best-practices/plan-for-ip-addressing.md#ip-address-management-ipam-tools).

**Grant the app team autonomy.** You should grant application teams with the rights to create subnets and even some virtual networks in the subscription. The platform team should always create virtual networks that peer to a central hub.

**Enforce networking governance.** The platform team should enforce virtual network governance via (1) Azure policy assigned to the management group hierarchy or (2) Azure Virtual Network Manager and Security Admin Rules. For more information, see [Policy-driven governance](../design-principles.md#policy-driven-governance) and [How to block high risk ports](/azure/virtual-network-manager/how-to-block-high-risk-ports).

### Determine subscription placement

The platform team should use the networking and governance requirements to place the subscription in the management group hierarchy. They should also review the subscription quota limits before creating the subscription. For more information, see [Tailor the Azure landing zone architecture to meet requirements](../tailoring-alz.md).

**Identify the right management group.** Management groups help you organize and govern subscriptions and workload deployments. Locate or create a management group that enforces the policies needed for the classification and needs of each workload.

**Build flexible automation.** Your automation should be flexible enough (1) to deploy multiple subscriptions and (2) adapt to subscription service limits.

- *Multiple subscriptions:* Some workloads need several subscriptions. For example, some workloads have several instances separated by subscription. Alternatively, SaaS architectures that use dedicated resources per customer often use dozens of subscriptions.

- *Subscription service limits:* An enterprise with several thousand subscriptions should have automation that can deploy to an old subscription or colocate workloads in a subscription to avoid the limits. For more information, see [Azure landing zones FAQ](../../enterprise-scale/faq.md#should-we-create-a-new-azure-subscription-every-time-or-should-we-reuse-azure-subscriptions).

    You can request quota increases manually using the Azure portal after provisioning. It's easier if you automate this process by using the available APIs. However, the quota request can fail, so you should run a script to handle any errors. For more information, see [Microsoft.Capacity](/rest/api/reserved-vm-instances/quotaapi), [Microsoft.Quota](/rest/api/quota/), and [Microsoft.Support](/rest/api/support/quota-payload)

### Create and configure subscription

You can now create and configure the requested subscription. The goal is to create a repeatable, consistent process. Automate as much of the subscription creation and configuration process as you can.

**Use infrastructure as code (IaC).** A common strategy for subscription vending is to create and configure the subscription programmatically by using IaC. You need a commercial agreement to create an Azure Subscription programmatically, but you can automate all aspects of subscription configuration without a commercial agreement. For more information, see:

- [EA required role](/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement#prerequisites)
- [MCA required role(s)](/azure/cost-management-billing/manage/programmatically-create-subscription-microsoft-customer-agreement#prerequisites)
- [MPA required role](/azure/cost-management-billing/manage/programmatically-create-subscription-microsoft-partner-agreement#prerequisites)

There are example subscription vending [Bicep](https://github.com/Azure/bicep-registry-modules/tree/main/avm/ptn/lz/sub-vending) and [Terraform](https://github.com/Azure/terraform-azurerm-lz-vending#terraform-landing-zone-vending-module-for-azure) modules to help you adopt a subscription vending model regardless of your enrollment in a commercial agreement. You should use GitHub actions or Azure Pipelines to orchestrate the automation.

**Use tags for cost management.** You should automate the consistent assignment of tags to each subscription for cost management and reporting purposes in Microsoft Cost Management. Although you receive billing reports with your commercial agreements, Cost Management provides greater functionality. For example, you can create reports for subscriptions with specific tags. For more information, see [How to use tags in cost and usage data](/azure/cost-management-billing/costs/understand-cost-mgt-data#how-tags-are-used-in-cost-and-usage-data) and [Group and allocate costs using tag inheritance](/azure/cost-management-billing/costs/enable-tag-inheritance)

**Use production and non-production subscriptions.** In the request for a new subscription, you must specify whether the workload is for Production or DevTest. DevTest environments result in lower resource charges but have other [terms](https://azure.microsoft.com/offers/ms-azr-0148p/). Note DevTest offer isn't available for MPA. For more information, see:

- [Azure billing offers and Microsoft Entra tenants](./azure-billing-microsoft-entra-tenant.md)
- [Resource organization design area overview](./resource-org.md)
- [Create Azure subscriptions programmatically](/azure/cost-management-billing/manage/programmatically-create-subscription)

**Set up identity and role-based access controls (RBACs).** Managing access to resources within an Azure subscription is critical for maintaining a secure and compliant environment. To control access, it's essential to set up identity and RBACs. This setup involves designating a subscription owner, creating Microsoft Entra groups to manage access, and establishing automation identities to deploy workloads.

- *Designate a subscription owner.* The subscription vending automation needs to designate a subscription owner at creation. The subscription request should capture this information at intake. Subscription owners can only be users or service principals in the selected subscription directory. You can't select guest directory users. If you select a service principal, enter its App ID.

- *Create Microsoft Entra groups.* In addition to the subscription owner, you should ensure the vending process uses your Microsoft Entra group structure to manage access to the subscription. For elevated (for example, write) access, we recommend using [PIM for groups](/entra/id-governance/privileged-identity-management/concept-pim-for-groups). Automating this creation process shouldn't violate best practices such as limiting the number of subscription owners and using the minimum required level of access.

- *Establish workload identities.* Workload identities (service principals) used for workload deployment often have elevated permissions at the subscription scope. The subscription request process should gather workload identity needs at intake. Your vending process should create these identities and assign appropriate subscription access. It's important to note that the workload identity can't use PIM and receives standing access to resources. We recommend you use managed identities to avoid the need to manage secrets. For more information, see [the identity design area](./identity-access.md).

**Hand off to application team.** After the platform team creates the subscription, they should hand off the subscription to the application team.

### Update subscription budget

The platform and workload teams share responsibility for the financial health of the subscription. The deployment should create a subscription budget based on the information in the subscription request. The application should update the budget to meet their needs when they receive the subscription. Budgets are useful for auditing spending against current and forecast usage, but they aren't hard limits. You should create budget alerts to notify the subscription owners if the workload is about to exceed the budget threshold. For shared services, such as API Management, consider using [Azure cost allocation rules](/azure/cost-management-billing/costs/allocate-costs) to redistribute costs between consuming subscriptions.

### Deploy workload and operate

The application team should have autonomy to create the resources they need for their workload and manage operations. The platform team remains responsible for subscription governance. As the governance requirements of a workload change, the platform team should move subscriptions to the management group that best meets workload needs. You can automate the move by using Bicep or Terraform. For more information, see:

- [Management groups overview](./resource-org-management-groups.md)
- [Move subscription to new management group (Bicep)](/azure/templates/microsoft.management/managementgroups/subscriptions)
- [Move subscription to new management group (Terraform)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association)
- [Tailor Azure landing zone to meet your requirements](../tailoring-alz.md)

## Next steps

Review the subscriptions, or product lines, that you can vend to application teams. Establish a great starting point so you can cater to a number of different scenarios.

> [!div class="nextstepaction"]
> [Establish common subscription vending product lines](./subscription-vending-product-lines.md)
