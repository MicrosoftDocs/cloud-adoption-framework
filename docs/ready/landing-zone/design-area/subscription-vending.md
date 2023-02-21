---
title: Subscription vending
description: Subscription vending
author: stephen-sumner
ms.author: ssumner
ms.date: 02/20/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Subscription vending

Subscription vending provides a platform mechanism for programmatically issuing subscriptions to application teams that need to deploy workloads. The following diagram shows where subscription vending fits in the platform and workload lifecycles.

:::image type="content" source="./media/subscription-vending-high-res.png" alt-text="Diagram showing four steps. Step 1 is create platform subscriptions. Step 2 is create platform. Step 3 is to establish subscription vending. Step 4 is to deploy workloads. Steps 1 and 2 align with the platform. Step 3, subscription vending, overlaps with both the platform and application landing zone. Step 4 is an application focused step." lightbox="./media/subscription-vending-high-res.png" border="false":::

Subscription vending builds on the concept of subscription democratization and applies it to application landing zones. With subscription democratization, subscriptions, not resource groups, are the primary units of workload management and scale. For more information, see:

- [Democratized approach to subscriptions](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#subscription-democratization)  
- [How many subscriptions should I use in Azure (YouTube)?](https://www.youtube.com/watch?v=R-5oeguxFpo&t=13s)

## Why subscription vending?

Subscription vending offers several benefits to organizations that need to deploy workloads in Azure. It standardizes and automates the process for requesting, deploying, and governing subscriptions for workload landing zones. Subscription vending simplifies the subscription creation process and places it under the governance of the organization, so app teams can focus on deploying their workloads with greater confidence and efficiency.

- **Streamlined process:** Subscription vending provides an official front door for application teams to request subscriptions, eliminating the need for them to navigate the subscription process on their own.
- **Improved velocity:** Application teams can access application landing zones faster and onboard workloads quicker.
- **Efficient governance:** The platform team can enforce governance on workload landing zones with minimal overhead.

## How to implement subscription vending

Subscription vending involves three teams. The Cloud Center of Excellence (CCoE) establishes the business logic and approval process. When ready, the application teams make subscription requests. The platform team uses the request to create and configure the subscription before handing off the subscription to the application team. The application team sets the budget, deploys the workload, and maintains operations. The following guidance provides more details on each step.

:::image type="content" source="./media/subscription-vending-process.png" alt-text="Diagram showing the subscription vending process." lightbox="./media/subscription-vending-process.png" border="false":::

### Establish business logic and approval process

To implement the subscription vending model, you need to establish an approval process that collects essential subscription information. The Cloud Center of Excellence (CCoE) should program the approval process and establish business rules around the information to collect.

**Automate process.** You should automate the process of subscription request capture and approval for faster provisioning and improved compliance.

**Integrate with existing tooling.** You should integrate the subscription vending approval process into your existing ITSM tool. The integration can simplify the approval process, reduce manual effort, and improve efficiency while reducing errors. It also makes maintenance and updates easier over time.

**Connect to deployment pipeline.** It's a best practice to tie the business logic of the approval process into the subscription deployment pipeline managed by the platform team. Azure Pipelines or GitHub Actions workflows are common solutions for the subscription deployment pipeline.

**Gather requirements at intake.** The business logic should allow application teams to request a subscription and provide subscription requirements. These requirements should include anticipated budgets, subscription owners, networking expectations, and business criticality & confidentiality classification. Gathering this information at the beginning of the process informs your deployment parameters and stakeholder approval needs. The intake process should also give the platform team enough information to place the workload in the management group hierarchy.

With the approval process in place, application teams can start submitting subscription requests.

### Make subscription request

Subscription vending provides a standard process for application teams to request a subscription. It's important that you socialize the availability of subscription vending and ensure subscription requests are easy to make. After the application team submits a subscription request, the platform team assumes control of the process. The platform team maintains control until they create the subscription and deliver the subscription to the application team.

### Configure networking

The subscription automation needs set up the required networking components, and it needs to be flexible enough to meet the needs of each application team. As general guidance, never use overlapping IP addresses in a single routing domain. You can add or delete address space of a virtual network without downtime if your size requirements change. For more information, see:

- [IP address restrictions](/azure/virtual-network/virtual-networks-faq#are-there-any-restrictions-on-using-ip-addresses-within-these-subnets)
- [Update address space of a peered virtual network](/azure/virtual-network/update-virtual-network-peering-address-space)
- [Add or remove address range](/azure/virtual-network/manage-virtual-network#add-or-remove-an-address-range)

**Use IP address management (IPAM) tool.** You should use and integrate an IPAM system into the vending process to streamline IP address assignment.

**Grant app team autonomy.** You should grant application teams with the rights to create subnets and even some virtual networks in the subscription. The platform team should always create virtual networks that peer to a central hub.

**Enforce networking governance.** The platform team should enforce virtual network governance via (1) Azure policy assigned to the management group hierarchy or (2) Azure Virtual Network Manager and Security Admin Rules. For more information, see:

- [Policy-driven governance](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#policy-driven-governance)
- [How to block high risk ports](/azure/virtual-network-manager/how-to-block-high-risk-ports).

### Determine subscription placement

The platform team should use the networking and governance requirements to place the subscription in the management group hierarchy. They should also review the subscription quota limits before creating the subscription.

**Identify management group.** Management groups help you organize and govern subscriptions and workload deployments. Locate or create a management group that enforces the policies needed for the classification and need of each workload.

**Build flexible automation.** Your automation should be flexible enough (1) to deploy one workload to multiple subscriptions and (2) adapt to subscription service limits.

*One workload to many subscriptions:* Some workloads need to span several subscriptions. For example, multi-tenant architectures that use isolated storage accounts per tenant often use dozens of subscriptions.

*Subscription service limits:* An enterprise with several thousand subscriptions should have automation that can deploy to old subscription or co-locate workloads in a subscription to avoid the limits. The ideal use cases for subscription reuse are developer sandboxes, training environments, or software-as-a-service (SaaS) providers using one subscription per customer. MCA customers nearing 5,000 active subscriptions should consider subscription reuse. EA customers, should reuse subscription when nearing 5,000 active and canceled subscriptions.

You can request quote increases manually using the Azure portal after provisioning. It's easier if you automate this process by using the available APIs. However, the quota request can fail, so you should run a script to handle any errors. For more information, see [Microsoft.Capacity](/rest/api/reserved-vm-instances/quotaapi), [Microsoft.Quota](/rest/api/quota/), and [Microsoft.Support](/rest/api/support/quota-payload)

### Create and configure subscription

It's recommend that you create subscriptions programmatically. You need a customer agreement to create subscriptions programmatically. For customers with a customer agreement, use the following the guidance to create your subscriptions programmatically.

Without a commercial agreement, you can still automate a large portion of the subscription vending process. Create subscriptions in the Azure portal and then apply the automation against the empty new subscription.

**Know your commercial agreement.** To create a subscription, you need to assume a role with the right permissions. The permissions and scope of the role depend on the commercial agreement you have. Determine the type of commercial agreement you have, then use the following links to assume the right permissions for subscription creation:

- [EA required role](/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement#prerequisites)
- [MCA required role(s)](/azure/cost-management-billing/manage/programmatically-create-subscription-microsoft-customer-agreement#prerequisites)
- [MPA required role](/azure/cost-management-billing/manage/programmatically-create-subscription-microsoft-partner-agreement#prerequisites)

**Use infrastructure as code (IaC).** A common strategy for subscription vending is to create subscription programmatically by using IaC. You need a commercial agreement to create a subscription programmatically. There are example subscription vending [Bicep](https://github.com/Azure/bicep-lz-vending#bicep-landing-zone-vending-module-for-azure) and [Terraform](https://github.com/Azure/terraform-azurerm-lz-vending#terraform-landing-zone-vending-module-for-azure) modules to help you adopt a subscription vending model. You should use GitHub actions or Azure Pipelines to orchestrate the automation.

**Use tags for cost management.** You should automate the consistent assignment of tags to each subscription for cost management and reporting purposes in Azure Cost Management. Although you receive billing reports with your commercial agreements, Azure Cost Management provides greater functionality. For example, you can create reports for subscriptions with specific tags. For more information, see:

- [How to use tags in cost and usage data](/azure/cost-management-billing/costs/understand-cost-mgt-data#how-tags-are-used-in-cost-and-usage-data)
- [Group and allocate costs using tag inheritance](/azure/cost-management-billing/costs/enable-tag-inheritance)

**Use production and non-production subscriptions.** In the request for a new subscription, ou must specify whether the workload is for Production or DevTest. DevTest environments result in lower resource charges but has other [terms](/offers/ms-azr-0148p/). Note DevTest offer isn't available for MPA. For more information, see:

- [Azure billing offers and Active Directory tenants](/azure/cloud-adoption-framework/ready/landing-zone/design-area/azure-billing-ad-tenant)
- [Resource organization design area overview](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org)
- [Create Azure subscriptions programmatically](/azure/cost-management-billing/manage/programmatically-create-subscription)

**Set up identity and role-based access controls (RBACs).** Managing access to resources within an Azure subscription is critical for maintaining a secure and compliant environment. To control access, it's essential to set up identity and RBACs. This setup involves designating a subscription owner, creating Azure AD groups to manage access, and establishing automation accounts to deploy workloads.

*Designate subscription owner.* The subscription vending automation needs to designate a subscription owner at creation. The subscription request should capture this information at intake. Subscription owners only be users or service principals in the selected subscription directory. You can't select guest directory users. If you select a service principal, enter its App ID.

*Create Azure AD groups.* In addition to the subscription owner, you should ensure the vending process uses your Azure AD group structure to manage access to the subscription. For elevated (for example, write) access, we recommend using [PIM for groups](/azure/active-directory/privileged-identity-management/concept-pim-for-groups). Automating this creation process shouldn't violate best practices such as limiting the number of subscription owners and using the minimum required level of access.

*Establish automation accounts.* Automation accounts (non-human identities) used for workload deployment often have elevated permissions at the subscription scope. The subscription request process should gather automation account needs at intake. Your vending process should create these managed identities and assign appropriate subscription access. It's important to note that the accounts can't use PIM and receive standing access to resources.

 For more information, see [the identity design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access).

**Hand off to application team.** After the platform team creates the subscription, they should hand off the subscription to the application team to set their own budgets and deploy & operate their workloads.

### Set subscription budget

The platform and workload teams share responsibility for the financial health of the subscription. The application team creates budgets to control spending. Delegate budget creation to the application landing zone team and associated teams to empower them to control their costs. They're useful for auditing spending against current and forecast usage. Budgets aren't hard limits, so you should create budget alerts to notify the subscription owners if the workload is about to exceed the budget. For shared services, such as API Management, consider using [Azure Cost Allocation Rules (Preview)](/azure/cost-management-billing/costs/allocate-costs) to redistribute costs between consuming subscriptions.

## Next steps

With the subscription in place, the application team can create, deploy, and operate the workload with the placement and governance set forth by the vending process.

As the governance requirements of a workload changes, you should move subscriptions to the management group that best meets workload needs. You can automate the move by using Bicep or Terraform. For more information, see:

- [Management groups overview](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups)
- [Move subscription to new management group (Bicep)](/azure/templates/microsoft.management/managementgroups/subscriptions)
- [Move subscription to new management group (Terraform)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association)
- [Tailor Azure landing zone to meet your requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)
