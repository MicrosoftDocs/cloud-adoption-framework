---
title: Cloud governance
description: Learn what cloud governance is, why cloud governance is important, and how to establish governance in the cloud.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/01/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Govern overview

The Govern methodology provides a structured approach for setting up and managing cloud governance in Azure. Cloud governance refers to methods enforce and monitor compliance with rules you define. These rules are known as cloud governance policies. Cloud governance policies specify what should or shouldn't take place in the cloud. You create cloud governance policies to address identified risks to your organization. The goal of cloud governance is to ensure cloud use aligns (complies) with your cloud governance policies.

:::image type="content" source="./_images/govern.svg" alt-text="Diagram showing the process to set up and maintain cloud governance. The diagram shows five sequential steps: build a cloud governance team, document cloud governance policies, enforce cloud governance policies, and monitor cloud governance. The first step you perform once. The last four steps you perform once to set up cloud governance and continuously to maintain cloud governance." lightbox="./_images/govern.svg" border="false":::

## Why govern the cloud?

Cloud governance benefits all organization using the cloud. Effective cloud governance minimizes avoidable risks. It defines and streamlines acceptable cloud usage across the organization. Cloud governance ensures your cloud environment is compliant with external regulations and aligned to your broader cloud strategy. Without cloud governance, your organization might encounter risks that cloud governance could help you avoid.

## How to govern the cloud?

Cloud governance is a continuous process. The Govern methodology divides cloud governance into five steps:

1. *Build a governance team*: Select a team of individuals responsible for cloud governance. The cloud governance team defines and maintains cloud governance policies while reporting on the overall progress of cloud governance.

2. *Assess cloud risks*: Evaluate and prioritize potential risks associated with the use of cloud. The risk assessment should identify risks unique to the organization. Consider all categories of risk, such as regulatory compliance, security, operations, cost, data, resource management, and AI risks. Use Azure tools to help [assess cloud risks](./assess-cloud-risks.md#azure-facilitation-identifying-cloud-risks).

3. *Document cloud governance policies*: Document cloud governance policies that govern the use of the cloud. These policies set out the rules and guidelines for cloud usage to minimize the identified risks.

4. *Enforce cloud governance policies*: Enforce adherence to the cloud governance policies using automated tools or manual procedures. The goal is to ensure that the use of cloud services is in line with the established governance policies. Use Azure tools to help [enforce cloud governance policies](./enforce-cloud-governance-policies.md#azure-facilitation-enforcing-cloud-governance-policies-automatically).

5. *Monitor cloud governance*: Evaluate to ensure that cloud services are used according to the governance policies and adjusting as necessary. Use Azure tools to help [monitor cloud governance](./monitor-cloud-governance.md#azure-facilitation-configuring-cloud-governance-monitoring) and [set up alerts for noncompliance](./monitor-cloud-governance.md#azure-facilitation-configuring-cloud-governance-alerts).

Work through these five steps to establish cloud governance. Repeat steps 1-4 to maintain cloud governance over time. Use the [cloud governance checklist](./cloud-governance-checklist.md) to track progress.

## Cloud governance checklist

| &nbsp; | Governance task |
|---|---|
|&#9744; | [**Build a cloud governance team**](build-cloud-governance-team.md) |
| &nbsp;| &#9744; [Define the functions of the cloud governance team](build-cloud-governance-team.md#define-the-functions-of-the-cloud-governance-team) |
| &nbsp; | &#9744; [Select the members of the cloud governance team](build-cloud-governance-team.md#select-the-members-of-the-cloud-governance-team) |
| &nbsp; | &#9744; [Define the authority of the cloud governance team](build-cloud-governance-team.md#define-the-authority-of-the-cloud-governance-team) |
| &nbsp; | &#9744; [Define the scope of the cloud governance team](build-cloud-governance-team.md#define-the-scope-of-the-cloud-governance-team) |
| &#9744; | [**Assess cloud risks**](./assess-cloud-risks.md) |
| &nbsp;| &#9744; [Identify cloud risks](assess-cloud-risks.md#identify-cloud-risks) |
| &nbsp; | &#9744; [Analyze cloud risks](assess-cloud-risks.md#analyze-cloud-risks) |
| &nbsp;| &#9744; [Document cloud risks](assess-cloud-risks.md#document-cloud-risks) |
| &nbsp; | &#9744; [Communicate cloud risks](assess-cloud-risks.md#communicate-cloud-risks) |
|&#9744; | [**Document cloud governance policies**](document-cloud-governance-policies.md)|
| &nbsp;| &#9744; [Define an approach to documenting cloud governance policies](document-cloud-governance-policies.md#define-an-approach-to-documenting-cloud-governance-policies) |
| &nbsp; | &#9744; [Define cloud governance policies](document-cloud-governance-policies.md#define-cloud-governance-policies) |
| &nbsp;| &#9744; [Distribute cloud governance policies](document-cloud-governance-policies.md#distribute-cloud-governance-policies) |
| &nbsp; | &#9744; [Review cloud governance policies](document-cloud-governance-policies.md#review-cloud-governance-policies) |
| &#9744; | [**Enforce cloud governance policies**](enforce-cloud-governance-policies.md) |
| &nbsp;| &#9744; [Define an approach to enforcing cloud governance policies](enforce-cloud-governance-policies.md#define-an-approach-to-enforcing-cloud-governance-policies) |
| &nbsp; | &#9744; [Enforce cloud governance policies automatically](enforce-cloud-governance-policies.md#enforce-cloud-governance-policies-automatically) |
| &nbsp;| &#9744; [Enforce cloud governance policies manually](enforce-cloud-governance-policies.md#enforce-cloud-governance-policies-manually) |
| &nbsp; | &#9744; [Review policy enforcement](enforce-cloud-governance-policies.md#review-policy-enforcement) |
|&#9744; | [**Monitor cloud governance**](monitor-cloud-governance.md) |
| &nbsp;| &#9744; [Configure cloud governance monitoring](monitor-cloud-governance.md#configure-cloud-governance-monitoring) |
| &nbsp;| &#9744; [Configure cloud governance alerts](monitor-cloud-governance.md#configure-cloud-governance-alerts) |
| &nbsp;| &#9744; [Develop a remediation plan](monitor-cloud-governance.md#develop-a-remediation-plan) |
| &nbsp; | &#9744; [Audit cloud governance regularly](monitor-cloud-governance.md#audit-cloud-governance-regularly) |

## Next step

> [!div class="nextstepaction"]
> [Build a cloud governance team](build-cloud-governance-team.md)
