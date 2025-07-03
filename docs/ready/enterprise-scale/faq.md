---
title: Azure landing zone frequently asked questions (FAQ)
description: The Azure landing zone frequently asked questions (FAQ) provide answers to common questions asked about the Azure landing zone architecture.
author: jtracey93
ms.author: jatracey
ms.date: 07/01/2025
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

The Azure landing zone conceptual architecture represents scale and maturity decisions. It's based on lessons learned and feedback from customers who adopted Azure as part of their digital estate. This conceptual architecture can help your organization set a direction for designing and implementing a landing zone.

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

The Cloud Adoption Framework landing zones [open source project (OSS)](https://aztfmod.github.io/documentation/docs/intro/) (also known as *aztfmod*) is a community driven project owned and maintained outside of the Azure landing zone core team and the Azure GitHub organization. If your organization chooses to use this OSS project, consideration should be given to the support available as this is driven by the community effort through GitHub.

## What if we already have resources in our landing zones and later assign an Azure Policy definition that includes them in its scope?

Review the following documentation sections:

- [Transition existing Azure environments to the Azure landing zone conceptual architecture - "Policy" section](./transition.md#policies)
- [Quickstart: Create a policy assignment to identify non-compliant resources - "Identify non-compliant resources" section](/azure/governance/policy/assign-policy-portal#identify-non-compliant-resources)

## Do I need a dedicated or separate AI landing zone?

No, you do not need a separate AI landing zone. Instead, you can use the existing Azure landing zone architecture to deploy AI workloads into. See the guidance and explanation in [AI in Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/#ai-in-azure-landing-zones).

<!-- IMPLEMENTATION -->

## How do we handle "dev/test/production" workload landing zones in Azure landing zone architecture?

For more information, see [Manage application development environments in Azure landing zones](../landing-zone/design-area/management-application-environments.md).

## Why are we asked to specify Azure regions during the Azure landing zone accelerator deployment and what are they used for?

When you deploy Azure landing zone architecture by using the Azure landing zone accelerator portal-based experience, select an Azure region to deploy into. The first tab, **Deployment location**, determines where the deployment data is stored. For more information, see [Tenant deployments with ARM templates](/azure/azure-resource-manager/templates/deploy-to-tenant#deployment-location-and-name). Some parts of a landing zone are deployed globally but their deployment metadata is tracked in a regional metadata store. The metadata regarding their deployment is stored in the region selected on the **Deployment location** tab.

The region selector on the **Deployment location** tab is also used to select which Azure region any region-specific resources should be stored, such as a Log Analytics workspace, if required.

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
- You have a Microsoft Customer Agreement (MCA) or Microsoft Partner Agreement MPA and plan to have more than 5,000 active subscriptions. To learn more about subscription limits, see [Billing accounts and scopes in the Azure portal](/azure/cost-management-billing/manage/view-all-accounts).
- You're a pay-as-you-go customer.
- You use a Microsoft Azure Sponsorship.
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
- Remove Policy Definitions, Initiatives, Assignments, and Exemptions at the subscription scope.
- Remove deployments at the subscription scope.
- Remove tags at the subscription scope.
- Remove any Resource Locks at the subscription scope.
- Remove any Microsoft Cost Management budgets at the subscription scope.
- Reset Microsoft Defender for Cloud plans to Free Tiers unless organizational requirements mandate these logs are set to the paid tiers. You normally enforce these requirements via Azure Policy.
- Remove subscription activity logs (diagnostic settings) forwarding to Log Analytics Workspaces, Event Hubs, Storage Account or other supported destinations unless organizational requirements mandate forwarding these logs while a subscription is active.
- Remove any Azure Lighthouse Delegations at the subscription scope.
- Remove any hidden resources from the subscription.

>[!TIP]
> Using `Get-AzResource` or `az resource list -o table` targeted at the subscription scope will help you find any hidden or remaining resources to remove before re-assigning.

#### Reassign the subscription

You can reassign the subscription after you clean up the subscription. Here are some common activities that you might want to perform as part of the reassignment process:

- Add new tags and set values for them on the subscription.
- Add new Role Assignments, or Privileged Identity Management (PIM) Role Assignments, at the subscription scope for the new owners. Typically these assignments would be to Microsoft Entra groups instead of individuals.
- Place the subscription into the desired Management Group based on its governance requirements.
- Create new Microsoft Cost Management budgets and set alerts to new owners when thresholds met.
- Set Microsoft Defender for Cloud plans to desired Tiers. You should enforce this setting via Azure Policy once placed into the correct Management Group.
- Configure subscription activity logs (diagnostic settings) forwarding to Log Analytics Workspaces, Event Hubs, Storage Account or other supported destinations. You should enforce this setting via Azure Policy once placed into the correct Management Group.

## What is a sovereign landing zone and how is it related to the Azure landing zone architecture?

The sovereign landing zone is a component of Microsoft Cloud for Sovereignty that's intended for public sector customers who need advanced sovereignty controls. As a tailored version of the Azure landing zone conceptual architecture, the sovereign landing zone aligns Azure capabilities such as service residency, customer-managed keys, Azure Private Link, and confidential computing. Through this alignment, the sovereign landing zone creates a cloud architecture where data and workloads offer encryption and protection from threats by default.

> [!NOTE]
> Microsoft Cloud for Sovereignty is oriented toward government organizations with sovereignty needs. You should carefully consider whether you need the Microsoft Cloud for Sovereignty capabilities, and only then consider adopting the sovereign landing zone architecture.

For more information about the sovereign landing zone, see [Sovereignty considerations for Azure landing zones](../landing-zone/sovereign-landing-zone.md).
