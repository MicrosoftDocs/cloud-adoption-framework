---
title: Responsible AI policy for AI Agents
description: Learn Responsible AI policy for AI Agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
---

# Responsible AI policy for AI agents

Responsible AI defines how your organization designs and operates AI systems in ways that uphold ethical standards, ensure transparency, and maintain accountability. This policy applies to every AI agent, regardless of its complexity or visibility. Microsoft offers a Responsible AI standard that serves as a starting point and can be adapted to meet your organization’s specific needs. See [Responsible AI resources](/azure/ai-foundry/responsible-use-of-ai-overview).

:::image type="content" source="./images/responsible-ai.png" alt-text="Diagram that shows Microsoft's responsible AI pillars." lightbox="./images/responsible-ai.png" border="false":::

## Define a responsible AI standard

Establish a consistent standard that applies to all AI agents across the organization. This standard must reflect core principles such as fairness, privacy, transparency, and accountability. It must also comply with applicable laws and regulations.

Integrate the standard into existing review processes such as architecture evaluations, security assessments, and compliance checks. This integration ensures that teams apply consistent expectations and reduces the likelihood of ethical oversights. A well-defined standard also simplifies oversight and shortens deployment timelines.

As your organization uses more platform-as-a-service (PaaS) and software-as-a-service (SaaS) offerings from Microsoft, you inherit many of the engineering controls and safeguards built into those services. These include preconfigured privacy protections, model interpretability tools, and fairness assessments that align with Microsoft’s Responsible AI principles. This inheritance reduces the effort required to implement responsible AI practices and helps your teams focus on higher-value decisions rather than foundational compliance.

## Assign ownership and oversight

Designate a central authority to manage and enforce the Responsible AI policy. This authority could be an AI ethics committee, a compliance office, or an AI Center of Excellence that collaborates with legal and security teams. This group must have the mandate to update policies, audit AI agents, and ensure compliance across departments.

Use automation to enforce standards where feasible. For example, require safety features such as sensitive data protection in agent templates and verify them during code reviews or deployment pipelines. Clear ownership reduces ambiguity and enables faster decision-making when ethical concerns arise.

As a technical decision maker, ensure this oversight body has the resources and authority to act across business units. This structure supports consistent enforcement and helps avoid fragmented governance that slows down innovation or increases risk.

## Apply structured risk assessments

You need to evaluate each AI agent using a structured risk assessment. This process identifies vulnerabilities and ethical concerns early in development. Require teams to complete an Impact Assessment before defining product requirements. This assessment must document:

- Intended uses and stakeholders
- Risks to individuals, groups, and society
- Validation methods to ensure the system works as intended
- Data governance practices
- Human oversight and control mechanisms

Conduct impact assessments before each development stage and whenever you introduce new use cases. Document assessments in a central repository for audit trails and compliance verification. Require explicit approval before teams advance AI agents to production, new user groups, or expanded capabilities. This structured approach ensures consistent evaluation and documentation across all AI workloads.

Use tools such as the [Responsible AI toolbox](https://github.com/microsoft/responsible-ai-toolbox?tab=readme-ov-file#responsible-ai-toolbox) to assess fairness, interpretability, and error rates. Require fallback options and remediation plans for predictable failures. Define monitoring procedures for unknown failures and reassess systems when new operational factors or use cases arise. Early risk detection reduces remediation costs and protects the organization from reputational harm. Refer to [Assess AI risks](../scenarios/ai/govern.md#assess-ai-organizational-risks).

## Track ethical performance

Define metrics that measure ethical performance across AI systems. Examples include refusal rates due to policy violations or user complaints about biased responses. Review these metrics regularly and direct teams to improve AI agents based on findings.

Update policies and systems when regulations change. Use audit tools to evaluate fairness, interpretability, and error analysis. Treat these metrics as part of operational dashboards and use them to guide investment and improvement decisions. Ongoing oversight ensures long-term compliance and keeps AI systems aligned with business values and legal requirements.

## Next step

Use these policies as the foundation for all AI agent implementations. Convert them into a governance framework that supports secure, ethical, and scalable AI adoption.

> [!div class="nextstepaction"]
> [Governance and security](./governance-security.md)