---
title: Function of cloud security policy and standards
description: Understand the function of cloud security policy and standards.
author: JanetCThomas
ms.author: janet
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
ms.custom: internal
---

# Function of cloud security policy and standards

Security policy and standards teams author, approve, and publish security policy and standards to guide security decisions within the organization.

The policies and standards should:

- Reflect the organizations security strategy at a detailed enough way to guide decisions in the organization by various teams
- Enable productivity throughout the organization while reducing risk to the organizations business and mission

**Security policy** should reflect long term sustainable objectives that align to the organizations security strategy and risk tolerance. Policy should always address:

- Regulatory compliance requirements and current compliance status (requirements met, risks accepted, and so on.)
- Architectural assessment of current state and what is technically possible to design, implement, and enforce
- Organizational culture and preferences
- Industry best practices
- Accountability of security risk assigned to appropriate business stakeholders who are accountable for other risks and business outcomes.

**Security standards** define the processes and rules to support execution of the security policy.

## Modernization

While policy should remain static, standards should be dynamic and continuously revisited to keep up with pace of change in cloud technology, threat environment, and business competitive landscape.

Because of this high rate of change, you should keep a close eye on how many exceptions are being made as this may indicate a need to adjust standards (or policy).

Security standards should include guidance specific to the adoption of cloud such as:

- Secure use of cloud platforms for hosting workloads
- Secure use of DevOps model and inclusion of cloud applications, APIs, and services in development
- Use of identity perimeter controls to supplement or replace network perimeter controls
- Define your segmentation strategy prior to moving your workloads to IaaS platform
- Tagging and classifying the sensitivity of assets
- Define process for assessing and ensuring your assets are configured and secured properly

## Team composition and key relationships

Cloud security policy and standards are commonly provided by the following types of roles. The organizational policy should inform (and be informed by):

- Security architectures
- Compliance and risk management teams
- Business unit's leadership and representatives
- Information technology
- Audit and legal teams

The policy should be refined based on many inputs/requirements from across the organization, including but not restricted to those depicted in the [security overview diagram](./cloud-security.md).

## Next steps

Review the function of a [cloud security operations center](./cloud-security-operations-center.md) (SOC).
