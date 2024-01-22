---
title: Cloud governance
description: Learn how to establish governance in the cloud
author: martinekuan
ms.author: martinek
ms.date: 04/01/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Overview

Governance refers to the establishment of policies within an organization to minimize risk.

## Why govern?

Governance acts as a system of protective barriers, ensuring risk management across all operations. Its primary function is to create a balanced framework that allows for autonomous decision-making within safe limits. It safeguards the organization against both accidental and deliberate internal or external threats.

## How to govern

This is a high-level process for review. For more information on each step in the process, see the content below.

![Cloud governance process](./_images/governance-process.png)

**!!!!!!!!!!!!!!!!!!!!!!!!!!!<BR>ANY COMMITS BELOW THIS GRAPHIC MIGHT NOT BE PRESERVED. <BR>!!!!!!!!!!!!!!!!!!!!!!!!!**

### Build a governance team

Establishing a specialized team within IT to develop and manage governance policies. This team ensures that governance policies are effectively aligned with both business objectives and technological capabilities, fostering a balanced approach to risk and compliance.

- **Role**: Define and continually refine governance policies.

- **Composition**: Select a smaller, dedicated group from IT with strong business connections.

- **Scope**: Responsibilities extend across various areas like finance, security, identity, DevOps, compliance. Utilize a RACI matrix to clearly define roles and responsibilities within the governance team.

- **Functions**: Drive risk assessment, produce governance policies, publish, and train personnel. Help align cloud environment with IT strategy.

- **Authority**: Empowered to speak and act within their scope; non-compliance should have consequences.

- **Relationships**: Maintain good standing with both business and workload teams, including platform and individual workload teams, to ensure a balanced governance perspective.

### Quantify Risk

Assessing and quantifying the potential risks in the cloud environment at different organizational levels. Understanding the scope and magnitude of risks is crucial for developing governance policies that adequately protect the organization without hindering its operational efficiency.

- **Governance Vision**: Base it on risk tolerance and compliance requirements.

- **Risk Assessment**: Conduct comprehensive risk assessments at various scopes (workload, platform, organizational).

- **Responsibility**: Assign individuals or teams for governance at different levels, including cloud enrollment.

- **Understanding Risks**: Evaluate the cost of risks and value of mitigations; understand the likelihood and impact of risks.

- **Interviews**: Engage with different units outside IT to build a shared vision of risk.

- **Goal Setting**: Define realistic targets and understand the trade-offs between agility and control.

### Document Governance Policies

Formally recording the governance policies, including what is permissible and what is not within the cloud environment. Clear documentation provides a definitive reference for all stakeholders, ensuring consistency and clarity in governance and compliance efforts.

- **Nature of Governance**: Balance between being too restrictive and too lenient.

- **Policy Documentation**:

  1. Clearly document what is allowed and what is not (must, must not, should, may, may not). Use thorough and clear documentation for effective governance.

  1. Governance policies can help determine which functions should be centralized. If a certain principle is applicable to most or all teams, it might be beneficial to align that principle with a centralized function.

      1. For instance, when communicating with on-premises systems, the governance policy states that the use of an ExpressRoute is mandatory. This task is beyond the scope of the workload team and should be managed by a dedicated central networking team.

      1. Another example, if several workloads are independently tasked with implementing a firewall, this repetitive requirement becomes a prime candidate for centralization. Recognizing such patterns, governance should evolve to advocate for unified, organization-wide solutions. In this case, updating the policy from a generic 'each workload must have a firewall' to a more centralized 'all workloads must utilize the corporate-approved firewall' not only ensures consistency in security measures but also streamlines operations and potentially reduces costs

- **Key Areas**: Focus on identity, security, compliance, and cost.

- **Responsibility and Enforcement**: Define responsibilities for adherence and reporting violations.

- **Practical Approach**: Aim for evergreen policies that are feasible and value-focused. You need policies to be flexible enough to accommodate both automation and manual control.

- **Influence on Architecture and Development**: Documented policies should shape system/workload architecture and development practices, including software hosting and library usage.

- **Audit and Control**: Start with audit governance and escalate to blocking only for non-negotiable issues.

### Measure and Report on Governance

Immediately after documenting governance policies, you need to implement mechanisms to monitor compliance with governance policies and report on their effectiveness. This involves ensuring that you are governing what you are looking at, reporting on the progress of policy adherence, and building reports to track the delta between where you want to be and where you are.

- **Focus of Reporting**: Report only on areas that are being monitored and governed.

- **Implementation and Measurement**: Develop reporting mechanisms to track policy adherence and progress. Incorporate Key Performance Indicators (KPIs) that are agreed upon by both business and IT. Ensure that the right aspects are being monitored, such as cost reduction or development speed.

- **Communication**: Share policies widely and ensure educational components are included for better compliance.

- **Tracking Over Time**: Monitor and track governance effectiveness and progress over time.

### Implement governance

Apply the established governance policies in the cloud environment through practical implementation strategies. This step is where you start making progress toward where you want to be. With governance monitoring in place, you can track your progress. Effective implementation ensures that governance policies are not just theoretical but actively guide and control the organization's cloud activities, enhancing security, compliance, and operational integrity.

- **Tools and Features**: Utilize platform features (e.g., Azure policies) for enforcement and scaling. Implement templates and policies for automation to ensure continuity and control in governance.

- **Cost-Effective Implementation**: Find efficient ways to introduce governance.

- **Negotiation and Goals**: Determine implementation areas through negotiation; aim to reduce open issues.

- **Feedback Mechanism**: Establish channels for receiving feedback and maintaining dialogue with the organization..

- **Incremental Rollout**: Introduce governance gradually, starting with audit measures before moving to more restrictive controls.
