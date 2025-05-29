---
title: Govern overview
description: Learn to establish, maintain, and automate cloud governance in Azure. Mitigate risks and streamline cloud use.
author: larzstridh
ms.author: pnp
ms.date: 05/22/2025
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
ms.update-cycle: 1095-days
---

# Govern overview

The CAF Govern methodology provides a structured approach for establishing and optimizing cloud governance in Azure. The guidance is relevant for organizations across any industry. It covers essential categories of cloud governance, such as regulatory compliance, security, operations, cost, data, resource management, and artificial intelligence (AI).

Cloud governance is how you control cloud use across your organization. Cloud governance sets up guardrails that regulate cloud interactions. These guardrails are a framework of policies, procedures, and tools you use to establish control. Policies define acceptable and unacceptable cloud activity, and the procedures and tools you use ensure all cloud usage aligns with those policies. Successful cloud governance prevents all unauthorized or unmanaged cloud usage.

:::image type="content" source="./images/govern.svg" alt-text="Diagram showing the process to set up and maintain cloud governance. The diagram shows five sequential steps: build a cloud governance team, document cloud governance policies, enforce cloud governance policies, and monitor cloud governance. The first step you perform once. The last four steps you perform once to set up cloud governance and continuously to maintain cloud governance." lightbox="./images/govern.svg" border="false":::

## Why govern the cloud?

Cloud governance is foundational to defining and sustaining the productive use of the cloud. Effective cloud governance regulates all cloud use, mitigates risks, and streamlines cloud interactions across the organization. It aligns cloud use with the broader cloud strategy and helps you reach business goals with fewer setbacks. Without cloud governance, your organization might encounter risks that cloud governance could prevent.

## How to govern the cloud?

Cloud governance is a continuous process. It requires ongoing monitoring, evaluation, and adjustments to adapt to evolving technologies, risks, and compliance requirements. The CAF Govern methodology divides cloud governance into five steps. Complete all five steps to establish cloud governance and regularly iterate on steps 2-5 to maintain cloud governance over time:

1. *Build a governance team*: Select a team of individuals to be responsible for cloud governance. The cloud governance team defines and maintains cloud governance policies while reporting on the overall progress of cloud governance.

2. *Assess cloud risks*: Evaluate and prioritize potential risks associated with the use of the cloud. The risk assessment should identify risks unique to your organization. Consider all categories of risk, such as regulatory compliance, security, operations, cost, data, resource management, and AI risks. Use Azure tools to help [assess cloud risks](./assess-cloud-risks.md#azure-facilitation-identifying-cloud-risks).

3. *Document cloud governance policies*: Define the cloud governance policies that dictate the acceptable use of the cloud. These cloud governance policies set out the rules and guidelines for cloud usage to minimize the identified risks.

4. *Enforce cloud governance policies*: Enforce compliance with the cloud governance policies using automated tools or manual procedures. The goal is to ensure that the use of cloud services is in line with the established cloud governance policies. Use Azure tools to help [enforce cloud governance policies](./enforce-cloud-governance-policies.md#azure-facilitation-enforcing-cloud-governance-policies-automatically).

5. *Monitor cloud governance*: Monitor cloud use and teams responsible for governance to ensure they're compliant with the cloud governance policies. Use Azure tools to help [monitor cloud governance](./monitor-cloud-governance.md#azure-facilitation-configuring-cloud-governance-monitoring) and [set up alerts for noncompliance](./monitor-cloud-governance.md#azure-facilitation-configuring-cloud-governance-alerts).

## Cloud governance checklist

Use the cloud governance checklist to see all the tasks for each cloud governance step. Use the links to quickly navigate to the guidance you need.

| &nbsp; | Cloud governance step | Cloud governance tasks |
|---|---|---|
|&#9744; | [Build a cloud governance team](build-cloud-governance-team.md). | &#9744; [Define the functions of the cloud governance team](build-cloud-governance-team.md#define-the-functions-of-the-cloud-governance-team). <br> &#9744; [Select the members of the cloud governance team](build-cloud-governance-team.md#select-the-members-of-the-cloud-governance-team). <br> &#9744; [Define the authority of the cloud governance team](build-cloud-governance-team.md#define-the-authority-of-the-cloud-governance-team). <br> &#9744; [Define the scope of the cloud governance team](build-cloud-governance-team.md#define-the-scope-of-the-cloud-governance-team). |
|&#9744; | [Assess cloud risks](./assess-cloud-risks.md). | &#9744; [Identify cloud risks](assess-cloud-risks.md#identify-cloud-risks). <br> &#9744; [Analyze cloud risks](assess-cloud-risks.md#analyze-cloud-risks). <br> &#9744; [Document cloud risks](assess-cloud-risks.md#document-cloud-risks). <br> &#9744; [Communicate cloud risks](assess-cloud-risks.md#communicate-cloud-risks). <br> &#9744; [Review cloud risks](./assess-cloud-risks.md#review-cloud-risks). |
|&#9744; | [Document cloud governance policies](document-cloud-governance-policies.md). | &#9744; [Define an approach for documenting cloud governance policies](document-cloud-governance-policies.md#define-an-approach-for-documenting-cloud-governance-policies). <br> &#9744; [Define cloud governance policies](document-cloud-governance-policies.md#define-cloud-governance-policies). <br> &#9744; [Distribute cloud governance policies](document-cloud-governance-policies.md#distribute-cloud-governance-policies). <br> &#9744; [Review cloud governance policies](document-cloud-governance-policies.md#review-cloud-governance-policies). |
|&#9744; | [Enforce cloud governance policies](enforce-cloud-governance-policies.md). | &#9744; [Define an approach for enforcing cloud governance policies](enforce-cloud-governance-policies.md#define-an-approach-for-enforcing-cloud-governance-policies). <br> &#9744; [Enforce cloud governance policies automatically](enforce-cloud-governance-policies.md#enforce-cloud-governance-policies-automatically). <br> &#9744; [Enforce cloud governance policies manually](enforce-cloud-governance-policies.md#enforce-cloud-governance-policies-manually). <br> &#9744; [Review policy enforcement](enforce-cloud-governance-policies.md#review-policy-enforcement). |
|&#9744; | [Monitor cloud governance](monitor-cloud-governance.md). | &#9744; [Configure cloud governance monitoring](monitor-cloud-governance.md#configure-cloud-governance-monitoring). <br> &#9744; [Configure cloud governance alerts](monitor-cloud-governance.md#configure-cloud-governance-alerts). <br> &#9744; [Develop a remediation plan](monitor-cloud-governance.md#develop-a-remediation-plan). <br> &#9744; [Audit cloud governance regularly](monitor-cloud-governance.md#audit-cloud-governance-regularly). |

## Next step

> [!div class="nextstepaction"]
> [Build a cloud governance team](build-cloud-governance-team.md)
