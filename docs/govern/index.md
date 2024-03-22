---
title: Govern overview
description: Learn to establish, maintain, and automate cloud governance in Azure. Mitigate risks and streamline cloud use.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/05/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Govern overview

The Govern methodology provides a structured approach for setting up and managing cloud governance in Azure. This guidance is applicable to all organizations in any sector. It addresses common categories of cloud governance, such as regulatory compliance, security, operations, cost, data, resource management, and AI.

Cloud governance refers to establishing guardrails to regulate the use of cloud services. Guardrails help ensure cloud use follows predefined rules known as cloud governance policies. Cloud governance policies define what is allowed and what isn't allowed in the cloud. Organizations create cloud governance policies to prevent and mitigate risks. The goal of cloud governance is to make sure that cloud use aligns with cloud governance policies.

:::image type="content" source="./_images/govern.svg" alt-text="Diagram showing the process to set up and maintain cloud governance. The diagram shows five sequential steps: build a cloud governance team, document cloud governance policies, enforce cloud governance policies, and monitor cloud governance. The first step you perform once. The last four steps you perform once to set up cloud governance and continuously to maintain cloud governance" lightbox="./_images/govern.svg" border="false":::

## Why govern the cloud?

Effective cloud governance mitigates risks and streamlines acceptable cloud use across the organization. Cloud governance aligns cloud use with defined standards and the broader cloud strategy. It helps organizations reach business goals with fewer setbacks. Without cloud governance, organizations might encounter risks that cloud governance could prevent.

## How to govern the cloud?

Cloud governance is a continuous process. It requires ongoing monitoring, evaluation, and adjustments to adapt to evolving technologies, risks, and compliance requirements. The Govern methodology divides cloud governance into five steps. Complete all five steps to establish cloud governance and regularly iterate through steps 2-5 to maintain cloud governance over time:

1. *Build a governance team*: Select a team of individuals responsible for cloud governance. The cloud governance team defines and maintains cloud governance policies while reporting on the overall progress of cloud governance.

2. *Assess cloud risks*: Evaluate and prioritize potential risks associated with the use of cloud. The risk assessment should identify risks unique to the organization. Consider all categories of risk, such as regulatory compliance, security, operations, cost, data, resource management, and AI risks. Use Azure tools to help [assess cloud risks](./assess-cloud-risks.md#azure-facilitation-identifying-cloud-risks).

3. *Document cloud governance policies*: Document cloud governance policies that govern the use of the cloud. These policies set out the rules and guidelines for cloud usage to minimize the identified risks.

4. *Enforce cloud governance policies*: Enforce adherence to the cloud governance policies using automated tools or manual procedures. The goal is to ensure that the use of cloud services is in line with the established governance policies. Use Azure tools to help [enforce cloud governance policies](./enforce-cloud-governance-policies.md#azure-facilitation-enforcing-cloud-governance-policies-automatically).

5. *Monitor cloud governance*: Evaluate to ensure that cloud services are used according to the governance policies and adjusting as necessary. Use Azure tools to help [monitor cloud governance](./monitor-cloud-governance.md#azure-facilitation-configuring-cloud-governance-monitoring) and [set up alerts for noncompliance](./monitor-cloud-governance.md#azure-facilitation-configuring-cloud-governance-alerts).

## Cloud governance checklist

Use the cloud governance checklist to see all cloud governance steps and tasks for each step. Quickly navigate to the guidance you need.

| &nbsp; | Cloud governance step | Cloud governance tasks |
|---|---|---|
|&#9744; | [**Build a cloud governance team**](build-cloud-governance-team.md) | &#9744; [Define the functions of the cloud governance team](build-cloud-governance-team.md#define-the-functions-of-the-cloud-governance-team) <br> &#9744; [Select the members of the cloud governance team](build-cloud-governance-team.md#select-the-members-of-the-cloud-governance-team) <br> &#9744; [Define the authority of the cloud governance team](build-cloud-governance-team.md#define-the-authority-of-the-cloud-governance-team) <br> &#9744; [Define the scope of the cloud governance team](build-cloud-governance-team.md#define-the-scope-of-the-cloud-governance-team) |
|&#9744; | [**Assess cloud risks**](./assess-cloud-risks.md) | &#9744; [Identify cloud risks](assess-cloud-risks.md#identify-cloud-risks) <br> &#9744; [Analyze cloud risks](assess-cloud-risks.md#analyze-cloud-risks) <br> &#9744; [Document cloud risks](assess-cloud-risks.md#document-cloud-risks) <br> &#9744; [Communicate cloud risks](assess-cloud-risks.md#communicate-cloud-risks) |
|&#9744; | [**Document cloud governance policies**](document-cloud-governance-policies.md) | &#9744; [Define an approach to documenting cloud governance policies](document-cloud-governance-policies.md#define-an-approach-to-documenting-cloud-governance-policies) <br> &#9744; [Define cloud governance policies](document-cloud-governance-policies.md#define-cloud-governance-policies) <br> &#9744; [Distribute cloud governance policies](document-cloud-governance-policies.md#distribute-cloud-governance-policies) <br> &#9744; [Review cloud governance policies](document-cloud-governance-policies.md#review-cloud-governance-policies) |
|&#9744; | [**Enforce cloud governance policies**](enforce-cloud-governance-policies.md) | &#9744; [Define an approach to enforcing cloud governance policies](enforce-cloud-governance-policies.md#define-an-approach-to-enforcing-cloud-governance-policies) <br> &#9744; [Enforce cloud governance policies automatically](enforce-cloud-governance-policies.md#enforce-cloud-governance-policies-automatically) <br> &#9744; [Enforce cloud governance policies manually](enforce-cloud-governance-policies.md#enforce-cloud-governance-policies-manually) <br> &#9744; [Review policy enforcement](enforce-cloud-governance-policies.md#review-policy-enforcement) |
|&#9744; | [**Monitor cloud governance**](monitor-cloud-governance.md) | &#9744; [Configure cloud governance monitoring](monitor-cloud-governance.md#configure-cloud-governance-monitoring) <br> &#9744; [Configure cloud governance alerts](monitor-cloud-governance.md#configure-cloud-governance-alerts) <br> &#9744; [Develop a remediation plan](monitor-cloud-governance.md#develop-a-remediation-plan) <br> &#9744; [Audit cloud governance regularly](monitor-cloud-governance.md#audit-cloud-governance-regularly) |

## Next step

> [!div class="nextstepaction"]
> [Build a cloud governance team](build-cloud-governance-team.md)
