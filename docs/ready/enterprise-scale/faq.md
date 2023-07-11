---
title: Azure landing zone frequently asked questions (FAQ)
description: The Azure landing zone frequently asked questions (FAQ) provide answers to common questions asked about the Azure landing zone architecture.
author: jtracey93
ms.author: tozimmergren
ms.date: 04/14/2023
ms.topic: conceptual
ms.subservice: ready
ms.custom: think-tank, UpdateFrequency2, devx-track-terraform
---

# Azure landing zone frequently asked questions (FAQ)

This article answers frequently asked questions about Azure landing zone architecture.

For FAQs about **implementing Azure landing zone architecture**, see [Enterprise-scale implementation FAQ](https://github.com/Azure/Enterprise-Scale/wiki/FAQ).

<!-- GENERAL -->

## What is the Azure landing zone accelerator?

The Azure landing zone accelerator is an Azure portal-based deployment experience. It deploys an opinionated implementation based on the [Azure landing zone conceptual architecture](../landing-zone/index.md#azure-landing-zone-architecture).

## Which are the recommended accelerators and implementations for Azure landing zones?

Microsoft actively develops and maintains the platform and application accelerators and implementations in alignment with the Azure landing zone [design principles](/azure/cloud-adoption-framework/ready/landing-zone/design-principles) and [design area](/azure/cloud-adoption-framework/ready/landing-zone/design-areas) guidance.

Review the [Deploy Azure landing zones](/azure/architecture/landing-zones/landing-zone-deploy) guidance to learn more about the recommended platform and application landing zones.

To learn how to tailor your Azure landing zones deployment to meet your needs, see [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)

>[!TIP]
> To request an addition to the accelerator and implementation list, raise a GitHub issue on the [ALZ repository](https://github.com/Azure/Enterprise-Scale/issues/new/choose).

## What is the Azure landing zone conceptual architecture?

The Azure landing zone conceptual architecture represents scale and maturity decisions. It's based on lessons learned and feedback from customers who have adopted Azure as part of their digital estate. This conceptual architecture can help your organization set a direction for designing and implementing a landing zone.

## What does a landing zone map to in Azure in the context of Azure landing zone architecture?

From an Azure landing zone point of view, landing zones are individual Azure subscriptions.

## What does policy-driven governance mean, and how does it work?

[Policy-driven governance](../landing-zone/design-principles.md#policy-driven-governance) is one of the key design principles of enterprise-scale architecture.

Policy-driven governance means using Azure Policy to reduce the time you need for common and repeated operational tasks across your Azure tenant. Use many of the [Azure Policy effects](/azure/governance/policy/concepts/effects), such as `Append`, `Deny`, `DeployIfNotExists`, and `Modify`, to prevent non-compliance by either restricting non-compliant resources (as defined by the policy definition) from being created or updated or by deploying resources or modifying settings of a resource creation or update request to make them compliant. Some effects, such as `Audit`, `Disabled`, and `AuditIfNotExists`, don't prevent or take action; they only audit and report on non-compliance.

Some examples of policy-driven governance are:

- `Deny` effect: Prevents subnets from being created or updated to have no Network Security Groups associated with them.

- `DeployIfNotExists` effect: A new subscription (landing zone) is created and placed into a management group within your Azure landing zone deployment. Azure Policy ensures that Microsoft Defender for Cloud (formerly known as Azure Security Center) is enabled on the subscription. It also configures the diagnostic settings for Activity Log to send logs to the Log Analytics workspace in the Management subscription.

  Instead of repeating code or manual activities when a new subscription is created, the `DeployIfNotExists` policy definition automatically deploys and configures them for you.

## What if we can't or aren't yet ready to utilize DeployIfNotExists (DINE) policies?

We have a dedicated page that walks through the various phases and options you have to either "disable" DINE policies or use our three phase approach to adopt them over time within your environment.

See the guidance [Adopting policy driven guardrails](./dine-guidance.md)

## Should we use Azure Policy to deploy workloads?

In short, **no**. Use Azure Policy to control, govern, and keep your workloads and landing zones compliant. It isn't designed to deploy entire workloads and other tooling. Use the Azure portal or infrastructure-as-code offerings (ARM Templates, Bicep, Terraform) to deploy and manage your workload and get the autonomy you need.

## What is Cloud Adoption Framework Landing zones for Terraform (aztfmod)?

The Cloud Adoption Framework landing zones [open source project (OSS)](https://aztfmod.github.io/documentation/docs/intro/) (also known as _aztfmod_) is a community driven project owned and maintained outside of the Azure landing zone core team and the Azure GitHub organization. If your organization chooses to use this OSS project, consideration should be given to the support available as this is driven by the community effort through GitHub.

## What if we already have resources in our landing zones and later assign an Azure Policy definition that includes them in its scope?

Review the following documentation sections:

- [Transition existing Azure environments to the Azure landing zone conceptual architecture - "Policy" section](./transition.md#policy)
- [Quickstart: Create a policy assignment to identify non-compliant resources - "Identify non-compliant resources"
 section](/azure/governance/policy/assign-policy-portal#identify-non-compliant-resources)

<!-- IMPLEMENTATION -->

## How do we handle "dev/test/production" workload landing zones in Azure landing zone architecture?

> [!NOTE]
> This is for workload landing zones only. For testing and environment segregation for the Azure landing zone platform itself, review the [testing approach for enterprise-scale](./testing-approach.md).

If an application or service workload requires segregation of "dev/test/production" landing zones, use a separate subscription for each landing zone in the workload. It's important to work with the application or service workload owners to determine if separate subscriptions is the best way for them to build, manage, operate, and deliver their workload. It shouldn't be mandatory for all workloads.

A good example is a workload that uses [Azure App Service](/azure/app-service/overview). When you use Azure App Service, a [best practice](/azure/app-service/deploy-best-practices#use-deployment-slots) is to use [deployment slots](/azure/app-service/deploy-staging-slots) to help you manage changes and updates to the web app. However, this feature can only be used on the same app on an App Service Plan, which can only live within a single subscription. By mandating that your application or service workload owners use separate subscriptions for "dev/test/production", you might make their deployment lifecycle harder to manage. In this example, a single subscription for the application or service workload might be the best fit by using Azure role-based access control (RBAC) with [Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) at the Resource Group scope for increased security.

We suggest working with each application or service workload team (landing zone owners) to understand their requirements. Then you can provide subscriptions based on their requirements and plans. You might also decide to designate "product lines" for different types of workloads so that you can build subscription creation processes and tooling based on common requirements from application or service workload teams.

### What about our management group hierarchy?

With Azure landing zone architecture, you want to avoid complicated and volatile management group hierarchies that require constant amendment, don't scale efficiently, and don't add value. That's why in Azure landing zone architecture, management groups are workload archetype-aligned. For more information, see [Management group and subscription organization](../landing-zone/design-area/resource-org.md).

_Archetype-aligned_ means that management groups are only created for differing workload archetypes. For example, in the conceptual architecture, the "landing zones" management group has "corp" and "online" child management groups. These child management groups align with distinct archetype patterns for the workloads they hold, focused around hybrid connectivity (VPN/ExpressRoute) requirements (internal only vs. public-facing applications/services). However, all environments ("dev/test/production"), whether split across separate subscriptions or in a single subscription, are held within the same single management group ("Corp" or "Online") depending on its archetype and requirements.

The following equation helps to highlight why management groups per environment and/or per workload doesn't scale well: _N workloads x Z management groups  = total management groups_.

So, if you have 30 different workloads that each require a management group and a child management group for "dev/test/production", you're left with:

> N = number of workloads/apps = 30
>
> Z = number of management groups for workload and environments (1 per workload + 3 for envs) = 4

> N (30) x Z (4) = 120 total management groups

#### Example of a suboptimal management group hierarchy

[![Diagram of an example of a sub-optimal management group hierarchy for Azure landing zone architecture when handling dev/test/production landing zones.](./media/eslz-dev-test-prod-bad.png)](./media/eslz-dev-test-prod-bad.png#lightbox)

Landing Zone MG should have universal polices that enforce guardrails for both Corp and Online. Corp and Online have unique polices to enforce company guidelines around public and private facing workloads. If it needs to be implemented at a higher Management Group level, then it should be talked about with Cloud Platform Team or another team. There's little value in changing the configuration of a workload as it's promoted through the different environments. Constant change results in a poor development experience for landing zone users and owners. You might also consider using [sandbox subscriptions](../considerations/sandbox-environments.md) for true development purposes where a less restricted environment is required, such as when an application or service workload team is trying out different Azure services to see what works best for their requirements. Once the services are known, a landing zone (in the correct workload archetype aligned management group in the "landing zones" management group hierarchy) can be provisioned for the team.

A common challenge to this approach is that you might need some policies to apply differently, depending on the environment. You have a few options:

- Use tags in your policy definitions to help filter and apply them to the correct environment.

  > [!IMPORTANT]
  > Tags can be changed by users with appropriate Azure RBAC permissions, so for security focused policies, we don't advise using tags in policies. Users might change the tags on a resource and potentially bypass or apply another policy definition to the resources.

- Apply policies at a subscription level as required, ideally during the subscription creation process (as mentioned earlier).
- For policies that are implemented to help control costs (for example, to restrict certain VM SKUs from being used), apply the policy definition at a subscription level where required or make costs the responsibility of the landing zone owners, enabling true autonomy. (See [Platform automation and DevOps](../landing-zone/design-area/platform-automation-devops.md).)
- Use sandbox subscriptions for development activities. Sandboxes have a less restrictive policy set.

#### Example of an optimal management group hierarchy aligned to Azure landing zone architecture

[![Diagram of an example of an optimal management group hierarchy for Azure landing zone architecture when handling development, test, and production landing zones.](./media/eslz-dev-test-prod-good.png)](./media/eslz-dev-test-prod-good.png#lightbox)

_Some management groups have been removed for illustration clarity purposes._

> [!TIP]
> We discussed this topic in a recent YouTube video: [Azure Landing Zones - Handling Dev/Test/Prod for Application Workloads](https://youtu.be/8ECcvTxkrJA)

## Why are we asked to specify Azure regions during the Azure landing zone accelerator deployment and what are they used for?

When you deploy Azure landing zone architecture by using the Azure landing zone accelerator portal-based experience, select an Azure region to deploy into. The first tab, **Deployment location**, determines where the deployment data is stored. For more information, see [Tenant deployments with ARM templates](/azure/azure-resource-manager/templates/deploy-to-tenant#deployment-location-and-name).

Management groups, Azure Policies, and Azure RBAC are all stored at either a tenant or management group level within Azure landing zone architecture, so these resources aren't "deployed" to a particular region. The metadata regarding their deployment is stored in the region selected on the **Deployment location** tab.

The region selector on the **Deployment location** tab is also used to select which Azure region the following resources are deployed to (if enabled):

- Log Analytics workspace (including selected solutions)
- Automation account
- Resource groups (for the other resources)

If you deploy a networking topology on the **Network topology and connectivity** tab, you need to select an Azure region to deploy the networking resources to. This region can be different from the region selected on the **Deployment location** tab. Depending on the topology you select, the networking resources that you deploy might include:

- Azure Virtual WAN (including Virtual WAN Hub)
- Azure Virtual Network
- VPN gateway
- ExpressRoute gateway
- Azure Firewall
- Azure DDoS Standard protection plan
- Azure Private DNS zones for Azure Private Link
- Resource groups (for these resources)

## How do we enable more Azure regions when we use Azure landing zone architecture?

Azure landing zone architecture itself is region-agnostic. However, you're asked to specify Azure regions to deploy Azure landing zone architecture. For more information, see [Why are we asked to specify Azure regions during the Azure landing zone accelerator deployment and what are they used for](#why-are-we-asked-to-specify-azure-regions-during-the-azure-landing-zone-accelerator-deployment-and-what-are-they-used-for).

You might want to expand into or use more Azure regions once you've completed the initial deployment of Azure landing zone architecture. For example, if you enable disaster recovery for your virtual machines by using Azure Site Recovery, you might want to replicate them to a different Azure region. To add Azure regions within Azure landing zone architecture, consider the following areas and recommendations:

| Area | Recommendation |
| ---- | -------------- |
| Management groups | No action necessary. Management groups aren't tied to a region. |
| Azure Policy | Make changes here if you assigned policies to deny resource deployment to all regions by specifying a list of "allowed" Azure regions. These assignments must be updated to allow resource deployments to the new region you want to enable. |
| Role-based access control | No action necessary. Azure RBAC isn't tied to a region. |
| Logging | No action necessary. Keep sending and storing logs in the central Log Analytics Workspace in the Management subscription. See the recommendations in the Azure landing zone critical design area for [Management and monitoring](../landing-zone/design-area/management.md). |
| Networking | If you deployed a networking topology, [Virtual WAN](../azure-best-practices/virtual-wan-network-topology.md), or [traditional hub and spoke](../azure-best-practices/traditional-azure-networking-topology.md), expand the networking to the new Azure region. Create another networking hub by deploying the required networking resources into the existing Connectivity subscription in the new Azure region. From a DNS perspective, you might also want to deploy forwarders, if used, into the new Azure region. Use forwarders for spoke VNETs in the new region for resolution. Remember that Azure DNS Zones are global resources and not tied to a single Azure region, so nothing needs to be done to them. |
| Identity | If you deployed Active Directory Domain Services or Azure Active Directory Domain Services into your Identity subscription/spoke, expand the service into the new Azure region. |

> [!NOTE]
> You might be able to use [Availability Zones](/azure/availability-zones/az-overview#availability-zones) instead of deploying into an additional Azure region. Review and assess whether this is possible based on your requirements and whether [Availability Zones are supported](/azure/availability-zones/az-region) in your region and for the services you want to use.

### High-level approach

The below high-level steps can be used as a set of steps to follow to expand into a new region in the context of Azure landing zone for Networking & Identity. First, decide on new Azure Region to expand into.

#### Networking

##### Traditional Hub & Spoke Architecture

> [!TIP]
> Review the Azure landing zone design area for [traditional hub and spoke architecture](../azure-best-practices/traditional-azure-networking-topology.md)

1. Decide on whether a new platform landing zone subscription is needed or not
   - The same existing subscription is recommended to use for most customers across multiple regions for connectivity
2. Create new Resource Group in subscription in the new target region
3. Create new hub Virtual Network in the new target region
4. (optional) Deploy Azure Firewall or Network Virtual Appliances (NVA) into your new hub Virtual Network
5. (optional) Deploy Virtual Network Gateways for VPN and/or ExpressRoute connectivity and establish connections
6. Establish Virtual Network Peering between the new hub Virtual Network and the other hub Virtual Networks
7. Create and configure any required routing: Azure Route Server, User-Defined Routes, and more.
8. (optional) Deploy DNS Forwarders for new target region and link to any Azure Private DNS Zones to enable resolution
   - Some customers might do this on their Active Directory Domain Controllers that might be part of the Identity platform landing zone subscription

You can now connect application landing zone spokes via Virtual Network Peering to the new hub Virtual Network in the new region, to host your workloads.

##### Virtual WAN Architecture

> [!TIP]
> Review the Azure landing zone design area for [Virtual WAN architecture](../azure-best-practices/virtual-wan-network-topology.md)

1. Create new Virtual Hub in the existing Virtual WAN in the new target region
2. (optional) Deploy Azure Firewall or supported Network Virtual Appliances (NVA) into your new Virtual Hub
3. (optional) Deploy Virtual Network Gateways for VPN and/or ExpressRoute connectivity in the new Virtual Hub and establish connections
4. (optional) Create and configure any additionally required routing: Virtual Hub Static Routes, and more.
5. (optional) Deploy DNS Forwarders for new target region and link to any Azure Private DNS Zones to enable resolution
   - Some customers might do this on their Active Directory Domain Controllers, which might be part of the Identity platform landing zone subscription
   - In Virtual WAN deployments, today, this must be in a spoke Virtual Network that is connected to the Virtual Hub via a Virtual Network Connection

You can now connect application landing zone spokes via Virtual Network Connections to the new Virtual Hub in Virtual WAN in the new region, to host your workloads.

#### Identity

> [!TIP]
> Review the Azure landing zone design area for [identity and access management](../landing-zone/design-area/identity-access.md)

1. Decide on whether a new platform landing zone subscription is needed or not
   - The same existing subscription is recommended to use for most customers across multiple regions for identity
2. Create new Resource Group in subscription in the new target region
3. Create new Virtual Network in the new target region
4. Establish Virtual Network Peering back to the newly created regional hub Virtual Network in the connectivity subscription
5. Deploy identity workloads, like Active Directory Domain Controller Virtual Machines into new Virtual Network
    - You might need to perform more setup and configuration of the workloads once provisioned, like:
      - Promoting the Active Directory Domain Controller Virtual Machines to the existing Active Directory Domain
      - Create new Active Directory sites & subnets
      - Configuring DNS Server settings like Conditional Forwarders

## Should we create a new Azure Subscription every time or should we reuse Azure Subscriptions?

### What is subscription reuse?

Subscription reuse is the process of reissuing an existing subscription to a new owner. There should be a process to reset the subscription to a known clean state and then reassigned to a new owner.

### Why should I consider reusing subscriptions?

In general, we recommend that customers adopt the [Subscription Democratization design principle](../landing-zone/design-principles.md#subscription-democratization). However, there are specific circumstances where subscription reuse isn't  possible or recommended.

> [!TIP]
> Watch the YouTube video on the Subscription Democratization design principle here: [Azure Landing Zones - How many subscriptions should I use in Azure?](https://youtu.be/R-5oeguxFpo)

You should consider subscription reuse if you meet one of the following circumstances:

- You have an Enterprise Agreement (EA) and plan to create more than 5,000 subscriptions on a single EA Account Owner Account (billing account), including deleted subscriptions.
- You have a Microsoft Customer Agreement (MCA) or Microsoft Partner Agreement MPA and plan to have more than 5,000 active subscriptions
- You're a pay-as-you-go customer
- You use a Microsoft Azure Sponsorship
- You commonly create:
    1. Ephemeral lab or sandbox environments
    1. Demo environments for proofs-of-concept (POCs) or minimum viable products (MVP), including independent software vendors (ISV) for customer demo/trial access
    1. Training environments, such as MSPs/Trainer's learner environments

### How do I reuse subscriptions?

If you match one of the above scenarios or considerations, then you might need to consider reusing existing decommissioned or unused subscriptions and reassigning them to a new owner and purpose.

#### Clean up old subscription

You first need to clean up the old subscription for reuse. You need to perform the following actions on a subscription before it's ready for reuse:

- Remove Resource Groups and contained resources.
- Remove Role Assignments, including Privileged Identity Management (PIM) Role Assignments, at the subscription scope.
- Remove Custom Role-based Access Control (RBAC) Definitions, at the subscription scope.
- Remove Policy Definitions, Initiatives, Assignments and Exemptions at the subscription scope.
- Remove deployments at the subscription scope.
- Remove tags at the subscription scope.
- Remove any Resource Locks at the subscription scope.
- Remove any Azure Cost Management Budgets at the subscription scope.
- Reset Microsoft Defender for Cloud plans to Free Tiers unless organizational requirements mandate these logs are set to the paid tiers. You normally enforce these requirements via Azure Policy.
- Remove subscription activity logs (diagnostic settings) forwarding to Log Analytics Workspaces, Event Hubs, Storage Account or other supported destinations unless organizational requirements mandate forwarding these logs while a subscription is active.
- Remove any Azure Lighthouse Delegations at the subscription scope.
- Remove any hidden resources from the subscription.

>[!TIP]
> Using `Get-AzResource` or `az resource list -o table` targeted at the subscription scope will help you find any hidden or remaining resources to remove before re-assigning.

#### Reassign the subscription

You can reassign the subscription after you clean up the subscription. Here are some common activities that you might want to perform as part of the reassignment process:

- Add new tags and set values for them on the subscription.
- Add new Role Assignments, or Privileged Identity Management (PIM) Role Assignments, at the subscription scope for the new owners. Typically these assignments would be to Azure Active Directory Groups instead of individuals.
- Place the subscription into the desired Management Group based on its governance requirements.
- Create new Azure Cost Management Budgets and set alerts to new owners when thresholds met.
- Set Microsoft Defender for Cloud plans to desired Tiers. You should enforce this setting via Azure Policy once placed into the correct Management Group.
- Configure subscription activity logs (diagnostic settings) forwarding to Log Analytics Workspaces, Event Hubs, Storage Account or other supported destinations. You should enforce this setting via Azure Policy once placed into the correct Management Group.
