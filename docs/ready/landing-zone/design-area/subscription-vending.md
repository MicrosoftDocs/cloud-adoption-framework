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

Subscription vending provides a mechanism for programmatically issuing subscriptions to teams that need to deploy workloads.  

:::image type="content" source="./media/subscription-vending-high-res.png" alt-text="Diagram showing the place of subscription vending in the workload lifecycle." lightbox="./media/subscription-vending-high-res.png" border="false":::

Subscription vending builds on the concept of subscription democratization. It's a means to achieve subscription democratization for application landing zone. With subscription democratization, subscriptions, not resource groups, are the primary units of workload management and scale. For more information, see:

- [Democratized approach to subscriptions](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#subscription-democratization)  
- [How many subscriptions should I use in Azure (YouTube)?](https://www.youtube.com/watch?v=R-5oeguxFpo&t=13s)

## Why subscription vending?

Subscription vending standardizes workload deployments. The consistency helps onboard apps to Azure faster.

## How to implement subscription vending

Subscription vending process has seven components and typically involves three teams. The Cloud Center of Excellence (CCoE) team handles the business logic and approval. The platform team receives the subscription request, creates a subscription, and performs a handoff with the application team. The application teams sets the budget, deploys workloads, and manages workload operations.

:::image type="content" source="./media/subscription-vending-steps.png" alt-text="Diagram showing the subscription vending process." lightbox="./media/subscription-vending-steps.png" border="false":::

### Establish the approval process

Subscription vending should be available to anyone in your organization can request a subscription. You need need to establish an approval process for workload subscription creation before you can offer subscription vending. Setup is a one-time step that you update as needed. A CCoE or similar entity typically establishes the approval mechanisms to standardize the onboarding process for the application team.

**Automate if possible.** An automated approval process for subscriptions is ideal. An IT service management (ITSM) tool is a common approach for automating subscription approval.

**Gather subscription information at intake.** The business logic should allow someone to request a subscription and provide subscription details, such as anticipated budgets and subscription owners. The information you gather should feed your deployment parameters and stakeholder approval needs.

### Receive a subscription request

With the approval process in place, you can start receiving subscription requests. Each request needs approval per the approval process. The platform team should assume responsibility of subscription creation process after approval. They maintain control until they handoff the subscription to the application team.

**Connect approval to deployment pipeline.** It's a best practice to tie the business logic of the approval process into the subscription deployment pipeline managed by the platform team. Azure DevOps pipelines or GitHub Actions workflows are common solutions for the subscription deployment pipeline.

**Consider deployment parameters.** Before deployment, the platform team should consider the placement of the subscription and its networking requirements. You can configure these values for each deployment by updating the parameters.

### Subscription placement

The platform team should review the governance requirements for the subscription and quota limits of your enterprise agreement before creating the subscription.

#### Management groups

Management groups help you organize and govern subscriptions. For more information, see [Management groups overview](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups).

**Use management groups for subscription governance:** Deploy the workload subscription in the management group that enforces the policies needed for that workload.
 Apply Azure policies to the management group so each subscription inherits the controls.

**Move subscriptions to new management groups as needed.** The governance requirements of workloads and subscriptions change of time. You should move subscriptions to the management group that best meets workload needs. You can automate the move by using Bicep or Terraform. For more information, see:

- [Move subscription to new management group (Bicep)](/azure/templates/microsoft.management/managementgroups/subscriptions)
- [Move subscription to new management group (Terraform)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association)
- [Tailor Azure landing zone to meet your requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)

#### Subscription reuse

Each subscription offer type defines has a service limit. As you approach that limit, you should start reusing subscriptions.

**Reuse subscriptions.** You can repurpose a subscription instead of creating a new one. Subscription reuse is best suited for developer sandboxes, training environments, or SaaS providers using a subscription per customer. Consider subscription reuse if:

1. You're an EA customer using more than 5,000 total subscriptions, including canceled subscriptions
2. You're an MCA customer and plan to have more than 5,000 active subscriptions

**Request additional quota if needed.** You can request quote increases manually using the Azure portal after provisioning. It's easier if you automate this process by using the available APIs. However, the quota request can fail, so you should run a script to handle any errors. For more information, see:

- [Microsoft.Capacity](/rest/api/reserved-vm-instances/quotaapi)
- [Microsoft.Quota](/rest/api/quota/)
- [Microsoft.Support](/rest/api/support/quota-payload)

### Networking requirements

Many organizations have a common network infrastructure to enable private communication between services.

**Understand the workload.** Subscription vending supports workload deployment, and the workload determines the networking requirements. The subscription request should gather the workload networking requirements. You should know whether the workload needs hybrid connectivity, internet access, and private communication with other workloads.

<!--The When vending new Azure Subscriptions, you'll have captured the networking requirements for the workloads to be provisioned into the new subscription at the time of the request. Based on this it's common for customers to have different networking patterns to support the differing needs of different application architectures. For example, some applications may require private and hybrid connectivity to on-premises, and other applications also on the same routing domain/segment; these applications would be placed into subscriptions that are placed within the 'corp' management group as this would be compliant with the policy controls that are inherited by subscriptions within this part of the management group hierarchy. This would then allow the subscriptions to create virtual networks and peer back to central hub networks, normally in the platform connectivity subscriptions.

Other applications may not require this same type of connectivity and may only require isolated Virtual Networks that contain services and resources that interact directly with the internet, protected by the various Azure Networking security services, or with other applications via services link Private Link.-->

For more information:

- [Tailor Azure landing zone to meet your requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)
- [Subscription considerations and recommendations](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions)
- [Private Link and DNS integration at scale](/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale)
- [DNS for on-premises and Azure](/azure/cloud-adoption-framework/ready/azure-best-practices/dns-for-on-premises-and-azure-resources)

**Determine network topology.** It's common to want to establish a connection to a vWAN hub or peering hub network. We recommend that you follow the [design area guidance](/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity) to help you decide which, if any, are right for your organization based on your requirements for this topic. For more information, see [Define an Azure network topology](/azure/cloud-adoption-framework/ready/azure-best-practices/define-an-azure-network-topology).

#### Virtual network and subnets

A key consideration is the ownership and management of the Virtual Networks and the Subnets they contain. Depending on the [type of landing zone](/azure/cloud-adoption-framework/ready/landing-zone/#platform-vs-application-landing-zones), these resources may be centrally managed by a platform/network team, or they may be split between a platform/network team and the application team managing the resources and services within the subscription.

Due to the number of available configuration parameters for a subnet, it can become cumbersome for platform/network teams to manage these centrally for application team's subscriptions. However, if subnet creation is delegated to an application team, assurances on Network Security Groups (NSGs) and any User Defined Routing (UDRs) configuration must be put in place.

We recommend the use of Azure Policy to audit or enforce compliance on Virtual Networks at scale, following the [design principle of policy-driven governance](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#policy-driven-governance) or use Azure Virtual Network Manager Security Admin rules to achieve similar outcomes for NSGs.

We also recommend that the platform/network teams should only create a Virtual Network in the application team's subscription if it requires peering back to a hub Virtual Network or Virtual WAN Hub. Furthermore, if it does require peering we still suggest creating a blank Virtual Network with no Subnets and then allow the application teams to create subnets as they require for their application/service. The platform/network team remains in control of the Virtual Networks governance/security posture via Azure Policies assigned to the Management Group hierarchy that the Subscription is placed in and/or via Azure Virtual Network Manager security admin rules.

#### IP address management

When connecting to a common network topology that is in a single routing domain, it's critical that unique and non-overlapping IP addressing is used for each virtual network within the routing domain. These are the Virtual Networks that require peering to a central hub Virtual Network or Virtual WAN Hub.

Commonly customers have an IP Address Management (IPAM) system in place, and some may have this accessible behind an API so IP Address blocks can be assigned programmatically also. This can also be built into your Subscription vending process by making a call to the IPAM API as a step before creating the subscription and associated Virtual Networks to request an IP address space to pass into the subscription and Virtual Networks creation input parameters.

IP address exhaustion is a common concern for some customers and therefore a key point to keep in mind is that Azure Virtual Networks can have their Address Spaces expanded or added to, with non-contiguous IP Address blocks, at any time. For more information, see the [Manage a Virtual Network](/azure/virtual-network/manage-virtual-network#add-or-remove-an-address-range).

With this in mind it's therefore recommended that you appropriately size your Virtual Networks at the time of creation to conserve IP addresses. The following table shows how many usable IP addresses you can have in Azure Virtual Networks for common subnet sizes to help you plan appropriately.

|Usable Azure IP Addresses Required|Subnet Size|
|---|---|
|1 – 3|/29|
|4 – 11|/28|
|12 – 27|/27|
|28 – 59|/26|
|60 – 123|/25|
|124 – 251|/24|
|125 – 498|/23|
|499 – 1020|/22|

Azure reserves the first four and last IP address in a subnet. For more information, see [IP addresses](/azure/virtual-network/virtual-networks-faq#are-there-any-restrictions-on-using-ip-addresses-within-these-subnets).

### Create subscription programmatically

The pipeline should consume the request information in the form of a JSON document (commonly referred to as a parameters file). These pipelines or workflows then trigger the creation of a new Azure Subscription as per the request details. This deployment is likely to trigger multiple other deployments depending on the input parameter values provided. For example, whether to deploy a Virtual Network in the newly provisioned Subscription and whether to peer it back to a hub Virtual Network.

**1. Know the commercial agreement you have.** You need a commercial agreement to create a subscription programmatically. To create a subscription, you need to assume a role with the permissions to do so. The permissions and scope of the role depend on the commercial agreement you have. Determine the type of commercial agreement you have, then use the following links to assume the right permissions for subscription creation. For more information, see:

- [EA required role](/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement#prerequisites)
- [MCA required role(s)](/azure/cost-management-billing/manage/programmatically-create-subscription-microsoft-customer-agreement#prerequisites)
- [MPA required role](/azure/cost-management-billing/manage/programmatically-create-subscription-microsoft-partner-agreement#prerequisites)

Without a commercial agreement, you can still use the modules. Create subscriptions in the Azure portal and deploy the modules programmatically.

**2. Create the subscription programmatically.** Follow the guidance in the Azure Architecture Center to programmatically create subscriptions. A common strategy for this is to use infrastructure as code (IaC). There are subscription vending Bicep and Terraform modules to help you adopt a subscription vending model. Consider using semi-structured data (JSON/YAML) in your source control repository to provide the inputs to the above modules. You should use GitHub actions or Azure Pipelines to orchestrate the automation.

**3. Use tags for cost management.** You should assign tags to each subscription for cost management and reporting purposes in Azure Cost Management. Although you receive billing reports with your commercial agreements. Azure Cost Management provides greater functionality, for example, you can create reports for subscriptions with specific tags. For more information, see:

- [How tags are used in cost and usage data](/azure/cost-management-billing/costs/understand-cost-mgt-data#how-tags-are-used-in-cost-and-usage-data)
- [Group and allocate costs using tag inheritance](/azure/cost-management-billing/costs/enable-tag-inheritance)

**4. Use production and non-production subscriptions.** Finally, the workload type must be specified in the API request for a new subscription. This can either be Production or DevTest. DevTest results in lower resource charges but has other [terms](/offers/ms-azr-0148p/). Note DevTest offer isn't available for MPA. For more information, see:

- [Azure billing offers and Active Directory tenants](/azure/cloud-adoption-framework/ready/landing-zone/design-area/azure-billing-ad-tenant)
- [Resource organization design area overview](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org)
- [Create Azure subscriptions programmatically](/azure/cost-management-billing/manage/programmatically-create-subscription)

**5. Grant subscription owner role.** For every new subscription, you need to designate a subscription owner. You should grant the Owner role to one Azure Active Directory principal.

**6. Create Azure AD groups.** In addition to the subscription owner, you should use Azure AD groups to manage access to the subscription. For elevated (for example, write) access we recommend using [PIM for groups](/azure/active-directory/privileged-identity-management/concept-pim-for-groups). Wherever possible, limit the number of subscription owners and use the minimum required level of access.

Rather than create service principals for each subscription, use managed identity wherever possible. With managed identities, you don't have to manage secrets or keys. Service principals usually are granted standing access to resources and aren't subject to PIM. For more information, see [IAM design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access).
<!--Can’t add constrained delegation as no public docs yet-->

### Set budget

Cloud financial management should be a shared responsibility between the platform and workload team. Organizations should use budgets to control spending. They're useful for auditing spending against current and forecast usage. Delegate budget creation to the application landing zone team and associated teams to empower them to control their costs.

We recommend you create budget alerts to notify the subscription owners if the budget is about to be exceeded. Budgets aren't hard limits. For shared services, such as API Management, consider using [Azure Cost Allocation Rules (Preview)](/azure/cost-management-billing/costs/allocate-costs) to redistribute costs between consuming subscriptions.

### Deploy & operate



## Next steps

Azure Architecture Center

- [Bicep subscription vending implementation](/azure/architecture/landing-zones/bicep/subscription-terraform-bicep)

- [Terraform subscription vending implementation](/azure/architecture/landing-zones/terraform/subscription-vending-terraform)
