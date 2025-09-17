---
title: Set up governance in Azure
description: Use the Cloud Adoption Framework for Azure to learn how to govern your Azure environment.
author: stephen-sumner
ms.author: pnp
ms.date: 09/17/2025
ms.topic: conceptual
---

# Set up governance in Azure

This article explains how to define and enforce governance rules in Azure using built-in tools like Azure Policy and Microsoft Defender for Cloud. Governance in Azure means setting up rules and controls that help you manage your cloud resources securely, efficiently, and in line with your goals. Whether you're working solo or running a small startup, these steps help you stay organized, avoid surprises, and build responsibly in the cloud.

## Establish governance policies

Setting clear rules helps you stay consistent and avoiding mistakes as you build in the cloud. These rules guide how you use Azure and help you manage risks like overspending, misconfigurations, or security gaps.

1. **Start by identifying risks that could affect your cloud setup.** Think about what could go wrong, like deploying resources in the wrong region, using expensive services by accident, or missing security settings. Use the [Assess cloud risks](/azure/cloud-adoption-framework/govern/assess-cloud-risks) guide to explore common risks and decide which ones matter most to you.

2. **Write down the rules you want to follow.** Document your decisions so you can stick to them and share them with others if needed. This document might include things like which regions you should use, which services you want to avoid, or how you should tag resources. Use the [Document governance policies](/azure/cloud-adoption-framework/govern/document-cloud-governance-policies) guide to help structure your notes.

## Enforce cloud governance

Once you defined your governance rules, use Azure tools to apply them automatically. These tools help you stay consistent and catch issues early.

1. **Use Azure Policy to enforce rules.** Azure Policy is a free service that lets you define and apply rules across your Azure environment. These rules, called policies, can block certain actions or track them for review. Azure Policy supports four levels of scope:

    | Policy scope | When to apply policies at this scope |
    | --- | --- |
    | Management group | Use this scope to apply policies across multiple subscriptions. |
    | Subscription | Apply policies to all resources within a single subscription. |
    | Resource group | Target a specific set of resources grouped together for a project or workload. |
    | Resource | Apply policies to individual resources like a web app or storage account. |

2. **Start with general policies.** Use [General](/azure/governance/policy/samples/built-in-policies?context=%2Fazure%2Fgovernance%2Fpolicy%2Fcontext%2Fpolicy-context#general) built-in policies to:

    - Require tags on resources and resource groups to help with tracking and organization.
    - Limit which regions you deploy to so you can manage costs and performance.
    - Block expensive service tiers (SKUs) to avoid unexpected charges.

3. **Apply policies.** To apply a policy, follow the [Assign a policy](/azure/governance/policy/assign-policy-portal) guide.

3. **Use Microsoft Defender for Cloud to improve security.** Microsoft Defender for Cloud helps you spot and fix security issues in your Azure setup. It includes free tools that show you what actions to take to protect your environment. You can also connect it to Microsoft Defender XDR for more advanced protection. To get started, follow the [Connect Defender to your Azure subscription](/azure/defender-for-cloud/connect-azure-subscription).

For more information, see [Enforce cloud governance](/azure/cloud-adoption-framework/govern/enforce-cloud-governance-policies).

## Next step

After setting up your rules and tools, make sure only the right people can access your resources. This access management helps you stay secure and avoid accidental changes.

> [!div class="nextstepaction"]
> [Manage access](./manage-access.md)
