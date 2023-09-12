---
title: Azure landing zone frequently asked questions (FAQ)
description: The Azure landing zone frequently asked questions (FAQ) provide answers to common questions asked about the Azure landing zone architecture.
author: jtracey93
ms.author: tozimmergren
ms.date: 04/14/2023
ms.topic: conceptual
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

When you deploy Azure landing zone architecture by using the Azure landing zone accelerator portal-based experience, select an Azure region to deploy into. The first tab, **Deployment location**, determines where the deployment data is stored. For more information, see [Tenant deployments with ARM templates](/azure/azure-resource-manager/templates/deploy-to-tenant#deployment-location-and-name). Some parts of a landing zone are deployed globally but their deploymene metadata is tracked in a regional metadata store. The metadata regarding their deployment is stored in the region selected on the **Deployment location** tab.

The region selector on the **Deployment location** tab is also used to select which Azure region any region-specific resources should be stored, such as a Log Analytics workspace and an automation account, if required.

If you deploy a networking topology on the **Network topology and connectivity** tab, you need to select an Azure region to deploy the networking resources to. This region can be different from the region selected on the **Deployment location** tab.

For more information about the regions that landing zone resources use, see [Landing zone regions](../considerations/regions.md).

## How do we enable more Azure regions when we use Azure landing zone architecture?

To understand how to add new regions to a landing zone, or how to move landing zone resources to a different region, see [Landing zone regions](../considerations/regions.md).

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

## What is a Sovereign Landing Zone and how is it related to the Azure Landing Zone architecture?

The Sovereign Landing Zone is a component of Microsoft Could for Sovereignty, intended for public sector customers that need advanced sovereignty controls. The Sovereign Landing Zone is a tailored version of the Azure Landing Zone conceptual architecture, aligning Azure capabilities such as service residency, customer-managed keys, private links, and confidential computing to create a cloud architecture where data and workloads default to encryption and protection from threats.

For more information about the Sovereign Landing Zone, see [Sovereign Landing Zone](../landing-zone/sovereign-landing-zone.md).
