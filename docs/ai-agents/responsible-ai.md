---
title: Responsible AI policy for AI Agents
description: Learn Responsible AI policy for AI Agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
---

# Responsible AI policy for AI Agents

Responsible AI defines how your organization designs and operates AI systems in ways that uphold ethical standards, ensure transparency, and maintain accountability. This policy applies to every AI agent, regardless of its complexity or visibility. Microsoft offers a Responsible AI standard that serves as a starting point and can be adapted to meet your organization’s specific needs. For Azure AI Foundry, refer to /azure/ai-foundry/responsible-use-of-ai-overview. See [Trustworthy AI resources](/azure/ai-foundry/responsible-use-of-ai-overview).

:::image type="content" source="./images/responsible-ai.png" alt-text="Diagram that shows Microsoft's responsible AI pillars." lightbox="./images/responsible-ai.png" border="false":::

## Define a responsible AI standard

Establish a consistent standard that applies to all AI agents across the organization. This standard must reflect core principles such as fairness, privacy, transparency, and accountability. It must also comply with applicable laws and regulations.
Integrate the standard into existing review processes such as architecture evaluations, security assessments, and compliance checks. This integration ensures that teams apply consistent expectations and reduces the likelihood of ethical oversights. A well-defined standard also simplifies oversight and shortens deployment timelines.

## Assign ownership and oversight

Designate a responsible authority to manage and enforce the Responsible AI policy. This authority could be an AI ethics committee, a compliance office, or an AI Center of Excellence that collaborates with legal teams. This group must have the mandate to update policies, audit AI agents, and ensure compliance across departments.

Use automation to enforce standards where feasible. For example, require safety features such as sensitive data protection in agent templates and verify them during code reviews or deployment pipelines. Clear ownership reduces ambiguity and enables faster decision-making.

## Apply structured risk assessments

Direct teams to evaluate each AI workload using a structured risk assessment. This process identifies vulnerabilities and ethical concerns early in development. Require teams to complete an Impact Assessment before defining product requirements. This assessment must document:

- Intended uses and stakeholders
- Risks to individuals, groups, and society
- Validation methods to ensure the system works as intended
- Data governance practices
- Human oversight and control mechanisms

Review and update assessments annually or when new uses emerge. Require approvals before advancing to new release stages. Apply this structured approach to every AI workload to ensure consistent evaluation and documentation.
Use tools such as the Responsible AI dashboard to assess fairness, interpretability, and error rates. Require fallback options and remediation plans for predictable failures. Define monitoring procedures for unknown failures and reassess systems when new operational factors or use cases arise. Early risk detection reduces remediation costs and protects the organization from reputational harm. Refer to [Assess AI risks](../scenarios/ai/govern.md#assess-ai-organizational-risks).

## Track ethical performance

Define metrics that measure ethical performance across AI systems. Examples include refusal rates due to policy violations or user complaints about biased responses. Review these metrics regularly and direct teams to improve AI agents based on findings.
Update policies and systems when regulations change. Use audit tools to evaluate fairness, interpretability, and error analysis. Treat these metrics as part of operational dashboards and use them to guide investment and improvement decisions. Ongoing oversight ensures long-term compliance and keeps AI systems aligned with business values and legal requirements.

## Next step

Use these policies as the foundation for all AI agent implementations. Convert them into a governance framework that supports secure, ethical, and scalable AI adoption.

> [!div class="nextstepaction"]
> [Governance and security](./governance-security.md)