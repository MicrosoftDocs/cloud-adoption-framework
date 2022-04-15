---
title: Tailor the Azure landing zone architecture
description: Understand how to tailor the Azure landing zone architecture to meet your business requirements.
author: jtracey93
ms.author: jatracey
ms.date: 3/11/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Tailor the Azure landing zone architecture to meet requirements

As part of the Azure landing zone guidance, several reference [implementation options](/azure/cloud-adoption-framework/ready/enterprise-scale/implementation) are available:

- Azure landing zone with Azure Virtual WAN
- Azure landing zone with traditional hub and spoke
- Azure landing zone foundation
- Azure landing zone for small enterprises

These options help organizations get started quickly by using configurations that deliver the Azure landing zone conceptual architecture and the best practices in the design areas.

The reference implementations are based on the best practices and learnings of Microsoft teams from engagements with customers and partners. This knowledge represents the "80" side of the 80/20 rule. The various implementations take opinionated positions of technical decisions that are part of the architecture design process.

Because not all use cases are the same, not all organizations can use an implementation approach in the exact way it was intended. Organizations need to understand the considerations when a requirement for tailoring is identified.

## What is a landing zone archetype in Azure landing zones?

A *landing zone archetype* describes what needs to be true to ensure a landing zone (Azure subscription) meets the expected environment and compliance requirements at a specific scope. This can include the following:

- Azure Policy assignments
- Role-based access control (RBAC) assignments
- Centrally managed resources such as networking

Consider each management group in the resource hierarchy as contributing to the final landing zone archetype output because of the way policy inheritance works in Azure. Think about what's applied at the upper levels in the resource hierarchy when you design the lower levels.

There's a close relationship between management groups and landing zone archetypes, but a management group alone isn't a landing zone archetype. Instead, it forms part of the framework that's used to implement each of the landing zone archetypes in your environment.

You can see this in the Azure landing zone conceptual architecture where policy assignments are created at the intermediate root management group, Contoso, for settings that must apply to all workloads, with more policy assignments created at lower levels of the hierarchy for more specific requirements.

Subscription placement within the management group hierarchy determines the resultant set of Azure Policy and access control (IAM) assignments that are inherited, applied, and enforced to that particular landing zone (Azure subscription).

More processes and tooling might be required to ensure a landing zone has the required centrally managed resources. Some examples include:

- Diagnostic settings to send activity log data to a Log Analytics workspace.
- Continuous export settings for Microsoft Defender for Cloud.
- Virtual network with managed IP address spaces for application workloads.
- Linking of virtual networks to a distributed denial of service standard plan.

> [!NOTE]
> In the Azure landing zone reference implementations, Azure policies with the `DeployIfNotExists` and `Modify` [effects](/azure/governance/policy/concepts/effects) are used to achieve the deployment of some of the preceding resources. They follow the [policy-driven governance](/azure/cloud-adoption-framework/ready/enterprise-scale/design-principles#policy-driven-governance) design principle.
>
> For more information, see [Adopt policy-driven guardrails](/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance).

## Azure landing zones conceptual architectures "built-in" archetypes

The conceptual architecture includes example landing zone archetypes for application workloads such as *corp* and *online*. These archetypes might apply to you and meet the requirements you have. You might want to make changes to these archetypes or create new ones. Your decision depends on your organization's needs and requirements.

> [!TIP]
> To review the landing zone archetypes in the Azure landing zone accelerator, see [Management groups in the Azure landing zone accelerator](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups#management-groups-in-the-azure-landing-zone-accelerator).

You might also want to create changes elsewhere in the resource hierarchy. When you plan the hierarchy for your implementation of Azure landing zones for your organization, follow the guidelines in the [design areas](/azure/cloud-adoption-framework/ready/landing-zone/design-areas).

The following landing zone archetype examples from the conceptual architecture help you to understand their purpose and intended use:

| Landing zone archetype (management group) | Purpose/usage                                                                                                                                                                                                                                                          |
| ----------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Corp                                      | Workloads such as internal systems used to run the business that shouldn't be publicly facing on the internet directly, but can be via a firewall or network virtual appliance in the central hub virtual networks in the connectivity subscriptions. Can be thought of as "private" workloads. |
| Online                                    | Workloads, such as directly publicly facing, internet, web apps. These might also have hybrid connectivity and peering to other virtual networks, including on-premises.                                                                                                          |
| Sandbox | Workloads in the early stages of development, testing, or ideation that require a less restrictive resultant set of policies applied to allow innovation. For example, you might allow access to services that are otherwise restricted in the rest of your hierarchy within the sandbox management group.

## Scenarios where tailoring might be required

As mentioned, we provide some common landing zone archetypes in [Azure landing zone conceptual architecture](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-conceptual-architecture) of *corp*, *online*. These archetypes aren't fixed and aren't the only permitted landing zone archetypes for application workloads. Some customers and partners will need to tailor landing zone archetypes to suit their needs and requirements.

Before a customer or partner tailors landing zone archetypes, it's important to understand the concepts and also visualize the area of the hierarchy that we suggest you customize, as shown here:

![Diagram that shows Azure landing zone default hierarchy with tailoring areas highlighted.](media/alz-tailor-hierarchy-default.png)
*Azure landing zone conceptual architecture default hierarchy*

The Azure landing zone conceptual architecture default hierarchy is shown in the preceding diagram. Two areas of the hierarchy are highlighted. One is underneath *Landing Zones* and the other is underneath *Platform*.

### Tailor application landing zone archetypes

The area highlighted in blue, underneath the *landing zones* management group, is the *most common and safest* place in the hierarchy to add more archetypes to meet new or more requirements that can't be added as more policy assignments to an existing archetype by using the existing hierarchy.

For example, a customer might have a new requirement to host a set of application workloads that need to meet PCI compliance requirements. But it doesn't need to apply to all workloads for the customer across their entire estate. The simplest and safest way for the customer to meet this new requirement is to create a new management group called *PCI* underneath the *landing zones* management group in the hierarchy and assign more policies like the [Microsoft Defender for Cloud regulatory compliance](/azure/defender-for-cloud/update-regulatory-compliance-packages) policy initiative for [PCI v3.2.1:2018](/azure/governance/policy/samples/built-in-initiatives#regulatory-compliance) to the new *PCI* management group; this forms a new archetype.

The customer can then place new or move existing Azure subscriptions into the new *PCI* management group to make it inherit the required more policies and form the new archetype.

> [!TIP]
> For information on what to consider and what happens when you move Azure subscriptions between management groups in relation to RBAC and Azure Policy, see [Transition existing Azure environments to the Azure landing zone conceptual architecture](/azure/cloud-adoption-framework/ready/enterprise-scale/transition#subscription-move).

### Tailor platform landing zone archetypes

Some customers might also want to tailor the area highlighted in orange underneath the platform management group. These zones are referred to as platform landing zones.

For example, a customer might have a dedicated SOC team that requires their own archetype to host their workloads that need to meet a different set of Azure Policy and RBAC assignment requirements than what the *management* management group does. Therefore the customer can create a new security management group beneath the platform management group and make the required Azure Policy and RBAC assignments to it and then place new or move existing Azure subscriptions into the new *security* management group to make it inherit the required additional policies; forming the new archetype.

### Example of a tailored Azure landing zone hierarchy

This diagram shows a tailored Azure landing zone hierarchy. It uses examples from the preceding:

![Diagram that shows Tailored Azure landing zone hierarchy.](media/alz-tailor-hierarchy-2-additional.png)
*Tailored Azure landing zone hierarchy*

## Points to consider

Here are some points to consider when you think about tailoring your implementation of Azure landing zone archetypes in the hierarchy:

- Tailoring the hierarchy isn't mandatory. The default archetypes and hierarchy we provide are suitable for most scenarios.
- Don't re-create your organizational hierarchy, teams, or departments in archetypes.
- Always try to build on the existing archetypes and hierarchy to meet new requirements.
- Only create new archetypes when they're truly needed:
  - For example, a new compliance requirement (PCI) is required for only a subset of application workloads and doesn't need to apply to all workloads.
- Only create new archetypes in the highlighted areas shown in the preceding diagrams.
- Avoid going beyond a hierarchy depth of four layers to avoid complexity and unnecessary exclusions:
  - Expand archetypes horizontally instead of vertically in the hierarchy.
- Don't create archetypes for environments like development, test, and production.
  - For more information, see [How do we handle dev/test/production workload landing zones in the Azure landing zones conceptual architecture?](/azure/cloud-adoption-framework/ready/enterprise-scale/faq#how-do-we-handle-devtestproduction-workload-landing-zones-in-enterprise-scale-architecture)
