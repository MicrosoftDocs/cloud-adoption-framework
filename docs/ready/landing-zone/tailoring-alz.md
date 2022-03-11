---
title: Tailoring the Azure Landing Zones Architecture
description: Understand how to tailor the Azure Landing Zones Architecture to meet your business requirements
author: jtracey93
ms.author: jatracey
ms.date: 3/11/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Tailoring the Azure Landing Zones Architecture to meet requirements

As part of the Azure landing zone (ALZ) guidance, there are several reference [implementation options](/azure/cloud-adoption-framework/ready/enterprise-scale/implementation) available; ALZ with Virtual WAN, ALZ with traditional Hub & Spoke, ALZ foundation, ALZ for small enterprises. These are provided to help organizations get started quickly, using configurations that deliver the Azure landing zone conceptual architecture and the best practices in the design areas.

The reference implementations are based on a wealth of best practice and learnings from teams across Microsoft from engagements with customers and our partners and represent the '80' side of the 80/20 rule. The various implementations take opinionated positions of technical decisions that are part of the architecture design process.

At the same time, it should be acknowledged that not all use cases are the same, not all organizations can use an implementation approach in the exact way it was intended. For those situations, organizations should explore this guidance and understand the considerations needed when a requirement for tailoring is identified.

## What is a "landing zone archetype" in Azure Landing Zones?

A landing zone archetype describes what needs to be true to ensure a landing zone (Azure Subscription) will meet the expected environment and compliance requirements at a given scope. This can include the following:

- Azure Policy Assignments
- Role-Based Access Control (RBAC) Assignments
- Centrally managed Resources (networking etc.)

You can consider each Management Group in the resource hierarchy as contributing to the final landing zone archetype output due to the way policy inheritance works in Azure. As such, it's important to think about what is already being applied at the levels above in the resource hierarchy when designing lower levels.

Although there's a close relationship between Management Groups and landing zone archetypes, a Management Group alone is not a landing zone archetype. Instead, it forms part of the framework used to implement each of the landing zone archetypes in your environment.

This can be seen in the Azure landing zone conceptual architecture where Policy Assignments are created at the intermediate root Management Group, ‘Contoso', for settings which must apply to all workloads, with additional Policy Assignments created at lower levels of the hierarchy for more specific requirements.

Subscription placement within the Management Group hierarchy determines the resultant set of Azure Policy and Access control (IAM) assignments that are inherited, applied and enforced to that particular landing zone (Azure Subscription).

Additional processes and tooling might be required to ensure a landing zone has the required centrally managed Resources. This might include, but is not limited to:

- Diagnostic settings to send activity log data to a Log Analytics workspace
- Continuous export settings for Microsoft Defender for Cloud
- Virtual Network (VNet) with managed IP address spaces for application workloads
- Linking of Virtual Networks to a DDoS Standard Plan

>[!NOTE]
> In the Azure Landing Zone reference implementations, Azure Policies with the `DeployIfNotExists` and `Modify` [effects](/azure/governance/policy/concepts/effects) are used to achieve the deployment of some of the above resources; following the [Policy-driven governance](/azure/cloud-adoption-framework/ready/enterprise-scale/design-principles#policy-driven-governance) design principle.
> 
> See [Adopt policy-driven guardrails](/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance) for more information

## Azure Landing Zones Conceptual Architectures "built-in" Archetypes

Although the conceptual architecture includes example landing zone archetypes for application workloads such as 'Corp', and 'Online', which might be applicable to you and meet the requirements you have. You might want to make changes to these or create new ones entirely, depending on your organizations needs and requirements.

>[!TIP]
> Review the landing zone archetypes in the Azure Landing Zone accelerator here: [Management groups in the Azure landing zone accelerator](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups#management-groups-in-the-azure-landing-zone-accelerator)

You might also want to create changes elsewhere in the resource hierarchy. When planning the hierarchy for your implementation of Azure landing zones for your organization, follow the guidelines in the [design areas.](/azure/cloud-adoption-framework/ready/landing-zone/design-areas)

Taking some of the examples landing zone archetypes from the conceptual architecture, the below will help you understand their purpose and intended usage:

| Landing Zone Archetype (Management Group) | Purpose/Usage                                                                                                                                                                                                                                                          |
| ----------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Corp                                      | Workloads, such as internal systems used to run the business which shouldn't be publicly facing on the internet directly, but can be via a firewall or NVA in the central hub VNet/s in the connectivity subscription/s. Can be thought of more as "private" workloads. |
| Online                                    | Workloads, such as directly publicly facing, internet, web apps. These might also have hybrid connectivity and peering to other VNets, including on-premises.                                                                                                          |
| Sandbox | Workloads, that are in the early stages of development, testing or ideation that require a less restrictive resultant set of policies applied to allow innovation. For example, you might allow access to services that are otherwise restricted in the rest of your hierarchy, within the sandbox management group.

## Scenarios where tailoring may be required



## Trade-offs to consider when approaching tailoring

TBC