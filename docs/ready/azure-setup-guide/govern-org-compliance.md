---
title: Governance, security, and compliance in Azure
description: Use the Cloud Adoption Framework for Azure to learn how to set up governance, security, and compliance for your Azure environment.
author: tvuylsteke
ms.author: martinek
ms.date: 01/17/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, fasttrack-edit, AQC, setup
---

<!-- docutune:casing "Blueprints: Blueprint definitions" "Blueprints: Get started" -->

# Governance, security, and compliance in Azure

As you establish corporate policy and plan your governance strategies, you have options. You can use tools and services like Azure Policy, Azure Blueprints, and Microsoft Defender for Cloud. These tools enforce and automate your organization's governance decisions. Before you start your governance planning, use the [governance benchmark tool](/assessments/b1891add-7646-4d60-a875-32a4ab26327e) to identify potential gaps in your organization's cloud governance approach. For more information about developing governance processes, see the [Govern methodology](../../govern/index.md).

## [Azure Blueprints](#tab/AzureBlueprints)

Azure Blueprints enables cloud architects and central information technology groups to define a repeatable set of Azure resources. The Azure resources help you set up and adhere to your organization's standards, patterns, and requirements. Azure Blueprints makes it possible for development teams to rapidly build and create new environments. The development team trusts that they're building within organizational compliance because they're using a set of built-in components, like networking, to speed up development and delivery.

Blueprints are a declarative way to handle deploying various resource templates and other artifacts, such as:

- Role assignments
- Policy assignments
- Azure Resource Manager templates
- Resource groups

### Create a blueprint

To create a blueprint:

::: zone target="chromeless"

1. Go to **Blueprints: Getting started**.
1. In the **Create a Blueprint** section, select **Create**.
1. Filter the list of blueprints to select the appropriate blueprint.
1. Enter the **Blueprint name**, then select the appropriate **Definition location**.
1. Select **Next : Artifacts**, then review the artifacts included in the blueprint.
1. Select **Save Draft**.


::: zone-end

::: zone target="docs"

1. In the Azure portal, go to [Blueprints: Get started](https://portal.azure.com/#blade/Microsoft_Azure_Policy/BlueprintsMenuBlade/GetStarted).
1. In the **Create a Blueprint** section, select **Create**.
1. Filter the list of blueprints to select the appropriate blueprint.
1. Enter the **Blueprint name**, then select the appropriate **Definition location**.
1. Select **Next : Artifacts**, then review the artifacts included in the blueprint.
1. Select **Save Draft**.

::: zone-end

### Publish a blueprint

To publish blueprint artifacts to your subscription:

::: zone target="chromeless"

1. Go to **Blueprints: Blueprint definitions**.
1. Select the blueprint you created in the previous steps.
1. Review the blueprint definition, then select **Publish blueprint**.
1. Provide a **Version** (such as `1.0`) and any **Change notes**, then select **Publish**.


::: zone-end

::: zone target="docs"

1. In the Azure portal, go to [Blueprints: Blueprint definitions](https://portal.azure.com/#blade/Microsoft_Azure_Policy/BlueprintsMenuBlade/Blueprints).
1. Select the blueprint definition you created in the previous steps.
1. Review the blueprint definition, then select **Publish blueprint**.
1. Provide a **Version** (such as `1.0`) and any **Change notes**, then select **Publish**.

::: zone-end

::: zone target="docs"

### Learn more

To learn more, see:

- [Azure Blueprints](/azure/governance/blueprints/)
- [Cloud Adoption Framework: Resource consistency decision guide](../../decision-guides/resource-consistency/index.md)
- [Standards-based blueprints samples](/azure/governance/blueprints/samples/#standards-based-blueprint-samples)

::: zone-end

## [Azure Policy](#tab/AzurePolicy)

Azure Policy helps you create, assign, and manage policies. These policies enforce rules on your resources so those resources stay compliant with your corporate standards and service-level agreements. Azure Policy scans your resources to identify resources that aren't compliant with corporate policies. For example, you can have a policy that lets only a specific virtual machine (VM) size to run in your environment. When you implement this policy, Azure Policy evaluates existing VMs in your environment and any new VMs that are deployed. The policy evaluation generates compliance events to use for monitoring and reporting.

Use common policies to:

- Enforce tagging for resources and resource groups.
- Restrict regions for deployed resources.
- Restrict expensive SKUs for specific resources.
- Audit the use of important optional features like Azure-managed disks.

::: zone target="chromeless"

### Action

Assign a built-in policy to a management group, subscription, or resource group.


::: zone-end

::: zone target="docs"

### Apply a policy

To apply a policy to a resource group:

1. Go to [Azure Policy](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/GettingStarted).
1. Select **Assign a policy**.

### Learn more

To learn more, see:

- [Azure Policy](/azure/governance/policy/)
- [Cloud Adoption Framework: Define corporate policy ](../../govern/policy-compliance/policy-definition.md)

::: zone-end

## [Microsoft Defender for Cloud](#tab/AzureSecurityCenter)

Microsoft Defender for Cloud plays an important part in your governance strategy. It helps you stay on top of security, because it:

- Provides a unified view of security across your workloads
- Collects, searches, and analyzes security data from various sources, which includes firewalls and other partner solutions
- Provides actionable security recommendations to fix issues before they can be exploited
- Applies security policies across your hybrid cloud workloads to ensure compliance with security standards

Many security features, like security policy and recommendations, are available for free. Some of the more advanced features, like just-in-time VM access and hybrid workload support, are available under the Defender for Cloud Standard tier. Just-in-time VM access can help reduce the network attack surface by controlling access to management ports on Azure VMs.

> [!TIP]
> Defender for Cloud is enabled by default in each subscription. We recommend that you enable data collection from virtual machines to allow Defender for Cloud to install its agent and begin gathering data.

::: zone target="docs"

To explore Defender for Cloud, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Security/SecurityMenuBlade/SecurityMenuBlade/0).

### Learn more

For more information, see the following resources:

- [Microsoft Defender for Cloud](/azure/security-center/)
- [Just-in-time VM access](/azure/security-center/security-center-just-in-time#how-does-just-in-time-access-work)
- [Defender for Cloud pricing tiers](https://azure.microsoft.com/pricing/details/azure-defender/)
- [Cloud Adoption Framework: Security Baseline discipline](../../govern/security-baseline/index.md)

::: zone-end

::: zone target="chromeless"


::: zone-end
