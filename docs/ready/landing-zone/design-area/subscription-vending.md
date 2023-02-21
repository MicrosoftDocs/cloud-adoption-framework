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

Subscription vending provides a mechanism for programmatically issuing subscriptions to application teams that need to deploy workloads.  

:::image type="content" source="./media/subscription-vending-high-res.png" alt-text="Diagram showing the place of subscription vending in the workload lifecycle." lightbox="./media/subscription-vending-high-res.png" border="false":::

Subscription vending builds on the concept of subscription democratization. It's a means to achieve subscription democratization for application landing zones. With subscription democratization, subscriptions, not resource groups, are the primary units of workload management and scale. For more information, see:

- [Democratized approach to subscriptions](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#subscription-democratization)  
- [How many subscriptions should I use in Azure (YouTube)?](https://www.youtube.com/watch?v=R-5oeguxFpo&t=13s)

## Why subscription vending?

Subscription vending offers several benefits to organizations that need to deploy workloads in Azure. It standardizes and automates the process for requesting, deploying, and governing subscriptions for workload landing zones. By simplifying the subscription process and putting it under the governance of the organization, app teams can focus on deploying their workloads with greater confidence and efficiency.

- **Streamlined process:** Subscription vending provides an official front door for application teams to request subscriptions, eliminating the need for them to navigate the subscription process on their own.
- **Improved velocity:** Application teams can access application landing zones faster and onboard workloads quicker.
- **Efficient governance:** The platform team can enforce governance on workload landing zones with minimal overhead.

## How to implement subscription vending

:::image type="content" source="./media/subscription-vending-process.png" alt-text="Diagram showing the subscription vending process." lightbox="./media/subscription-vending-process.png" border="false":::

### Establish business logic and approval process

To implement the subscription vending model, you need to establish an approval process that collects essential subscription information. The Cloud Center of Excellence should program the approval process and establish business rules around the information to collect.

**Automate process.** You should automate the process of subscription request capture and approval for faster provisioning and improved compliance.

**Integrate with existing tooling.** It's recommended to integrate the subscription vending approval process into your existing ITSM tool. The integration can simplify the approval process, reduce manual effort, and improve efficiency while reducing errors. It also makes maintenance and updates easier over time.

**Connect to deployment pipeline.** It's a best practice to tie the business logic of the approval process into the subscription deployment pipeline managed by the platform team. Azure DevOps pipelines or GitHub Actions workflows are common solutions for the subscription deployment pipeline.

**Gather requirements at intake.** The business logic should allow application teams to request a subscription and provide subscription requirements, such as anticipated budgets, subscription owners, networking expectations, and business criticality & confidentiality classification. Gathering this information at the beginning of the process will inform your deployment parameters and stakeholder approval needs. The intake process should also give the platform team enough information to place the workload in the management group hierarchy.

With the approval process in place, application teams can start submitting subscription requests.

### Receive subscription requests

Subscription vending provides a standard process for application teams to request a subscription. It's important that you socialize the availability of subscription vending and ensure subscription requests are easy to make. After the application team submits a subscription request, the platform team assumes control of the process. The platform teams maintains control until they create the subscription and deliver the subscription to the application team.

<!-- Stephen's version

**Determine place in network topology** The needs of the workload should determine its location in the Management Group hierarchy. If you don't have a defined network typology, follow the [design area guidance](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity). For more information, see:

- [Tailor Azure landing zone to meet your requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)
- [Define an Azure network topology](/azure/cloud-adoption-framework/ready/azure-best-practices/define-an-azure-network-topology)
- [Subscription considerations and recommendations](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions)
- [Private Link and DNS integration at scale](/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale)
- [DNS for on-premises and Azure](/azure/cloud-adoption-framework/ready/azure-best-practices/dns-for-on-premises-and-azure-resources)

-->

### Automate networking

The subscription automation needs set up the required networking components. It needs to be flexible enough to meet the needs of each application teams. As general guidance, never use overlapping IP addresses in a single routing domain. You can add or delete address space of a virtual network without downtime if your size requirements change. For more information, see:

- [IP address restrictions](/azure/virtual-network/virtual-networks-faq#are-there-any-restrictions-on-using-ip-addresses-within-these-subnets)
- [Update address space of a peered virtual network](/azure/virtual-network/update-virtual-network-peering-address-space)
- [Add or remove address range](/azure/virtual-network/manage-virtual-network#add-or-remove-an-address-range)

**Use IP address management (IPAM) tool.** You should use an IPAM system to streamline IP address assignment.

**Grant app team autonomy.** Application teams should create subnets and even some virtual networks in the subscription. The platform team should always create virtual networks that peer to a central hub.

**Enforce networking governance.** The platform team should enforce virtual network governance via (1) Azure policy assigned to the management group hierarchy or (2) Azure Virtual Network Manager and Security Admin Rules. For more information, see:

- [Policy-driven governance](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#policy-driven-governance)
- [How to block high risk ports](/azure/virtual-network-manager/how-to-block-high-risk-ports).

### Determine subscription placement

The platform team should use the networking and governance requirements to place the subscription in the management group hierarchy. They should also review the subscription quota limits before creating the subscription.

**Identify management group.** Management groups help you organize and govern subscriptions and workload deployments. Locate or create a management group that enforces the policies needed for that workload's classification and needs.

**Build flexible automation.** Your automation should be flexible enough (1) to deploy one workload to multiple subscriptions and (2) adapt to subscription service limits.

*Multi-tenant workloads:* Some workloads need to span several subscriptions. For example, workloads that use a storage account per Azure Active Directory tenant often use dozens of subscriptions.

*Subscription service limits:* An enterprise with several thousand subscriptions should have automation that can deploy to old subscription or co-locate workloads in a subscription to avoid the limits. The ideal use cases for subscription reuse are developer sandboxes, training environments, or software-as-a-service (SaaS) providers using one subscription per customer. MCA customers nearing 5,000 active subscriptions should consider subscription reuse. EA customers, should reuse subscription when nearing 5,000 active and cancelled subscriptions.

You can request quote increases manually using the Azure portal after provisioning. It's easier if you automate this process by using the available APIs. However, the quota request can fail, so you should run a script to handle any errors. For more information, see [Microsoft.Capacity](/rest/api/reserved-vm-instances/quotaapi), [Microsoft.Quota](/rest/api/quota/), and [Microsoft.Support](/rest/api/support/quota-payload)

### Create subscription programmatically

You need a commercial agreement to create a subscription programmatically. Without a commercial agreement, you can still automate a large portion of the process. Create subscriptions in the Azure portal, and then apply the automation against the new, empty subscription.

#### Know your commercial agreement

 To create a subscription, you need to assume a role with the right permissions. The permissions and scope of the role depend on the commercial agreement you have. Determine the type of commercial agreement you have, then use the following links to assume the right permissions for subscription creation:

- [EA required role](/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement#prerequisites)
- [MCA required role(s)](/azure/cost-management-billing/manage/programmatically-create-subscription-microsoft-customer-agreement#prerequisites)
- [MPA required role](/azure/cost-management-billing/manage/programmatically-create-subscription-microsoft-partner-agreement#prerequisites)

#### Use infrastructure as code (IaC)

A common strategy for this is to use IaC. There are example subscription vending [Bicep](LINK) and [Terraform](LINK) modules to help you adopt a subscription vending model. You should use GitHub actions or Azure Pipelines to orchestrate the automation.

#### Use tags for cost management

You should assign tags to each subscription for cost management and reporting purposes in Azure Cost Management. Although you receive billing reports with your commercial agreements. Azure Cost Management provides greater functionality, for example, you can create reports for subscriptions with specific tags. For more information, see:

- [How tags are used in cost and usage data](/azure/cost-management-billing/costs/understand-cost-mgt-data#how-tags-are-used-in-cost-and-usage-data)
- [Group and allocate costs using tag inheritance](/azure/cost-management-billing/costs/enable-tag-inheritance)

#### Use production and non-production subscriptions

Finally, the workload type must be specified in the request for a new subscription. This can either be Production or DevTest. DevTest results in lower resource charges but has other [terms](/offers/ms-azr-0148p/). Note DevTest offer isn't available for MPA. For more information, see:

- [Azure billing offers and Active Directory tenants](/azure/cloud-adoption-framework/ready/landing-zone/design-area/azure-billing-ad-tenant)
- [Resource organization design area overview](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org)
- [Create Azure subscriptions programmatically](/azure/cost-management-billing/manage/programmatically-create-subscription)

#### Designate subscription owner

The subscription vending automation needs to designate a subscription owner at creation. The subscription request should capture this information at intake. Subscription owners only be users or service principals in the selected subscription directory. You can't select guest directory users. If you select a service principal, enter its App ID.

#### Create Azure AD groups

In addition to the subscription owner, you should ensure the vending process uses your Azure AD group structure to manage access to the subscription. For elevated (for example, write) access, we recommend using [PIM for groups](/azure/active-directory/privileged-identity-management/concept-pim-for-groups). Automating this creation process shouldn't violate best practices such as limiting the number of subscription owners and using the minimum required level of access.

Rather than create service principals for each subscription, use managed identity wherever possible. With managed identities, you don't have to manage secrets or keys. Service principals usually are granted standing access to resources and aren't subject to PIM. For more information, see [IAM design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access).

#### Hand off to application team

After the platform team creates the subscription, they should hand off the subscription to the application team to set their own budgets and deploy & operate their workloads.

### Set budget

The the platform and workload teams share responsibility for the financial health of the subscription. The application create budgets to control spending. Delegate budget creation to the application landing zone team and associated teams to empower them to control their costs. They're useful for auditing spending against current and forecast usage. Budgets aren't hard limits, so you should create budget alerts to notify the subscription owners if the budget is about to be exceeded. For shared services, such as API Management, consider using [Azure Cost Allocation Rules (Preview)](/azure/cost-management-billing/costs/allocate-costs) to redistribute costs between consuming subscriptions.

## Next steps

With the subscription in place, the application team can create, deploy, and operate the workload, with the placement and governance set forth by the vending process.

As the governance requirements of a workload changes, you should move subscriptions to the management group that best meets workload needs. You can automate the move by using Bicep or Terraform. For more information, see:

- [Management groups overview](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups)
- [Move subscription to new management group (Bicep)](/azure/templates/microsoft.management/managementgroups/subscriptions)
- [Move subscription to new management group (Terraform)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association)
- [Tailor Azure landing zone to meet your requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)

