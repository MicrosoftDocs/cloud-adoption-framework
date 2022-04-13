---
title: Tailoring the Azure landing zones architecture
description: Understand how to tailor the Azure landing zones architecture to meet your business requirements
author: jtracey93
ms.author: jatracey
ms.date: 3/11/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Tailoring the Azure landing zones architecture to meet requirements

As part of the Azure landing zone (alz) guidance, there are several reference [implementation options](/azure/cloud-adoption-framework/ready/enterprise-scale/implementation) available; ALZ with Virtual WAN, ALZ with traditional hub and spoke, ALZ foundation, ALZ for small enterprises. These are provided to help organizations get started quickly, using configurations that deliver the Azure landing zone conceptual architecture and the best practices in the design areas.

The reference implementations are based on a wealth of best practice and learnings from teams across Microsoft from engagements with customers and our partners and represent the '80' side of the 80/20 rule. The various implementations take opinionated positions of technical decisions that are part of the architecture design process.

At the same time, it should be acknowledged that not all use cases are the same, not all organizations can use an implementation approach in the exact way it was intended. For those situations, organizations should explore this guidance and understand the considerations needed when a requirement for tailoring is identified.

## What is a "landing zone archetype" in Azure landing zones?

A landing zone archetype describes what needs to be true to ensure a landing zone (Azure subscription) will meet the expected environment and compliance requirements at a given scope. This can include the following:

- Azure Policy assignments
- Role-based access control (RBAC) assignments
- Centrally managed resources (networking and so on.)

You can consider each management group in the resource hierarchy as contributing to the final landing zone archetype output due to the way policy inheritance works in Azure. As such, it's important to think about what is already being applied at the levels above in the resource hierarchy when designing lower levels.

Although there's a close relationship between management groups and landing zone archetypes, a management group alone is not a landing zone archetype. Instead, it forms part of the framework used to implement each of the landing zone archetypes in your environment.

This can be seen in the Azure landing zone conceptual architecture where policy assignments are created at the intermediate root management group, 'Contoso', for settings which must apply to all workloads, with additional policy assignments created at lower levels of the hierarchy for more specific requirements.

Subscription placement within the management group hierarchy determines the resultant set of Azure Policy and access control (IAM) assignments that are inherited, applied and enforced to that particular landing zone (Azure subscription).

Additional processes and tooling might be required to ensure a landing zone has the required centrally managed resources. This might include, but is not limited to:

- Diagnostic settings to send activity log data to a Log Analytics workspace
- Continuous export settings for Microsoft Defender for Cloud
- Virtual network (VNet) with managed IP address spaces for application workloads
- Linking of virtual networks to a DDoS standard plan

> [!NOTE]
> In the Azure landing zone reference implementations, Azure policies with the `DeployIfNotExists` and `Modify` [effects](/azure/governance/policy/concepts/effects) are used to achieve the deployment of some of the above resources; following the [policy-driven governance](/azure/cloud-adoption-framework/ready/enterprise-scale/design-principles#policy-driven-governance) design principle.
>
> See [Adopt policy-driven guardrails](/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance) for more information

## Azure landing zones conceptual architectures "built-in" archetypes

Although the conceptual architecture includes example landing zone archetypes for application workloads such as 'corp', and 'online', which might be applicable to you and meet the requirements you have. You might want to make changes to these or create new ones entirely, depending on your organizations needs and requirements.

> [!TIP]
> Review the landing zone archetypes in the Azure landing zone accelerator here: [management groups in the Azure landing zone accelerator](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups#management-groups-in-the-azure-landing-zone-accelerator)

You might also want to create changes elsewhere in the resource hierarchy. When planning the hierarchy for your implementation of Azure landing zones for your organization, follow the guidelines in the [design areas](/azure/cloud-adoption-framework/ready/landing-zone/design-areas).

Taking some of the examples landing zone archetypes from the conceptual architecture, the following will help you understand their purpose and intended usage:

| Landing zone archetype (management group) | Purpose/usage                                                                                                                                                                                                                                                          |
| ----------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Corp                                      | Workloads, such as internal systems used to run the business which shouldn't be publicly facing on the internet directly, but can be via a firewall or NVA in the central hub VNet/s in the connectivity subscription/s. Can be thought of more as "private" workloads. |
| Online                                    | Workloads, such as directly publicly facing, internet, web apps. These might also have hybrid connectivity and peering to other VNets, including on-premises.                                                                                                          |
| Sandbox | Workloads, that are in the early stages of development, testing or ideation that require a less restrictive resultant set of policies applied to allow innovation. For example, you might allow access to services that are otherwise restricted in the rest of your hierarchy, within the sandbox management group.

## Scenarios where tailoring might be required

As mentioned above we provide some common landing zone archetypes in [Azure landing zone conceptual architecture](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-conceptual-architecture) of 'corp', 'online'. However, these are not fixed and the only permitted landing zone archetypes for application workloads. It's anticipated that some customers and partners will need to tailor the landing zone archetypes to suit their needs and requirements.

Before a customer or partner tailors the landing zone archetypes it's important to understand the concepts (detailed above on this page) and also visualize the area of the hierarchy that we suggest you customize, as shown below:

![Azure landing zones default hierarchy with tailoring areas highlighted.](media/alz-tailor-hierarchy-default.png)
***Azure Landing Zone Conceptual Architecture Default Hierarchy***

The Azure landing zone conceptual architecture default hierarchy is show above with two areas of the hierarchy highlighted, one beneath 'landing zones' and the other beneath 'platform'.

### Tailoring application landing zone archetypes

The area highlighted in blue, beneath the 'landing zones' management group is the **most common and safest** place in the hierarchy to add additional archetypes to meet new or additional requirements that cannot be added as additional policy assignments to an existing archetype using the existing hierarchy.

For example, a customer with a new requirement to host a set of application workloads that need to meet PCI compliance requirements but it doesn't need to apply to all workloads for the customer across their entire estate. The simplest and safest way for the customer to meet this new requirement is to create a new management group called 'PCI' beneath the 'landing zones' management group in the hierarchy and assign additional policies like the [Microsoft Defender for Cloud regulatory compliance](/azure/defender-for-cloud/update-regulatory-compliance-packages) policy initiative for [PCI v3.2.1:2018](/azure/governance/policy/samples/built-in-initiatives#regulatory-compliance) to the new 'PCI' management group; this forms a new archetype.

The customer can then place new or move existing Azure subscriptions into the new 'PCI' management group to make it inherit the required additional policies; forming the new archetype.

> [!TIP]
> Guidance on what to consider and what happens when moving Azure subscriptions between management groups in relation to RBAC and Azure Policy can be found in [Transition existing Azure environments to the Azure landing zone conceptual architecture](/azure/cloud-adoption-framework/ready/enterprise-scale/transition#subscription-move).

### Tailoring platform landing zone archetypes

Some customers might also wish to tailor the area highlighted in orange, beneath the 'platform' management group. These are referred to as platform landing zones.

For example, a customer might have a dedicated SOC team that require their own archetype to host their workloads that need to meet a different set of Azure Policy and RBAC assignment requirements than what the 'management' management group does. Therefore the customer can create a new 'security' management group beneath the 'platform' management group and make the required Azure Policy and RBAC assignments to it and then place new or move existing Azure subscriptions into the new 'security' management group to make it inherit the required additional policies; forming the new archetype.

### Example of a tailored Azure landing zone hierarchy

The following diagram shows a tailored Azure landing zone hierarchy, using the examples from above:

![Tailored Azure landing zone hierarchy](media/alz-tailor-hierarchy-2-additional.png)
***Tailored Azure Landing Zone Hierarchy***

## Important points to consider and follow when tailoring

Below are some important points to consider and follow when considering to tailoring your implementation of the Azure landing zones archetypes in the hierarchy.

- Tailoring the hierarchy is not mandatory, the default archetypes and hierarchy we provide is suitable for majority of scenarios
- Do not re-create your organizational hierarchy, teams or departments in archetypes
- Always try to build upon the existing archetypes and hierarchy to meet new requirements
- Only create new archetypes when truly needed
  - For example, a new compliance requirement (PCI) is required for only a subset of application workloads and doesn't need to apply to all workloads
- Only create new archetypes in the highlighted areas in the above diagrams
- Avoid going beyond 4 layers of hierarchy depth to avoid complexity and unnecessary exclusions and so on.
  - Instead, expand archetypes horizontally instead of vertically in the hierarchy
- Do not create archetypes for environments (development, test, production)
  - See [How do we handle "dev/test/production" workload landing zones in the Azure landing zones conceptual architecture?](/azure/cloud-adoption-framework/ready/enterprise-scale/faq#how-do-we-handle-devtestproduction-workload-landing-zones-in-enterprise-scale-architecture)
