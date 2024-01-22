---
title: Document cloud governance policies
description: Learn how to document governance policies for the cloud
author: stephen-sumner
ms.author: ssumenr
ms.date: 04/01/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Document cloud governance policies

Formally record governance policies, including what is permissible and what is not within the cloud environment. Clear documentation provides a definitive reference for all stakeholders, ensuring consistency and clarity in governance and compliance efforts.

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