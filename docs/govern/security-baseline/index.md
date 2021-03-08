---
title: Security Baseline discipline overview
description: Understand the approach to developing a Security Baseline discipline as part of a cloud governance strategy.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Security Baseline discipline overview

Security baseline is one of the [Five Disciplines of Cloud Governance](../governance-disciplines.md) within the [Cloud Adoption Framework governance model](../index.md). Security is a component of any IT deployment, and the cloud introduces unique security concerns. Many businesses are subject to regulatory requirements that make protecting sensitive data a major organizational priority when considering a cloud transformation. Identifying potential security threats to your cloud environment and establishing processes and procedures for addressing these threats should be a priority for any IT security or cybersecurity team. The Security Baseline discipline ensures technical requirements and security constraints are consistently applied to cloud environments, as those requirements mature.

> [!NOTE]
> Security Baseline discipline does not replace the existing IT teams, processes, and procedures that your organization uses to secure cloud-deployed resources. The primary purpose of this discipline is to identify security-related business risks and provide risk-mitigation guidance to the IT staff responsible for security infrastructure. As you develop governance policies and processes make sure to involve relevant IT teams in your planning and review processes.

This article outlines the approach to developing a Security Baseline discipline as part of your cloud governance strategy. The primary audience for this guidance is your organization's cloud architects and other members of your cloud governance team. The decisions, policies, and processes that emerge from this discipline should involve engagement and discussions with relevant members of your IT and security teams, especially those technical leaders responsible for implementing networking, encryption, and identity services.

Making the correct security decisions is critical to the success of your cloud deployments and wider business success. If your organization lacks in-house expertise in cybersecurity, consider engaging external security consultants as a component of this discipline. Also consider engaging [Microsoft Consulting Services](https://www.microsoft.com/industry/services/consulting), the [Microsoft FastTrack](https://azure.microsoft.com/programs/azure-fasttrack/) cloud adoption service, or other external cloud adoption experts to discuss concerns related to this discipline.

## Policy statements

Actionable policy statements and the resulting architecture requirements serve as the foundation of a Security Baseline discipline. Use [sample policy statements](./policy-statements.md) as a starting point for defining your Security Baseline policies.

> [!CAUTION]
> The sample policies come from common customer experiences. To better align these policies to specific cloud governance needs, execute the following steps to create policy statements that meet your unique business needs.

## Develop governance policy statements

The following steps offer examples and potential options to consider when developing your Security Baseline discipline. Use each step as a starting point for discussions within your cloud governance team and with affected business, IT, and security teams across your organization to establish the policies and processes needed to manage security-related risks.

| <span title="Icon">&nbsp;</span> | <span title="Description">&nbsp;</span> |
|--|--|
| <br> ![Template icon](../../_images/govern/process-template.png) | <br> [Security Baseline discipline template](./template.md): Download the template for documenting a Security Baseline discipline. |
| <br> ![Risks icon](../../_images/govern/process-risks.png) | <br> [Business risks](./business-risks.md): Understand the motives and risks commonly associated with the Security Baseline discipline. |
| <br> ![Metrics icon](../../_images/govern/process-metrics.png) | <br> [Indicators and metrics](./metrics-tolerance.md): Indicators to understand whether it's the right time to invest in the Security Baseline discipline. |
| <br> ![Adherence icon](../../_images/govern/process-enforce.png) | <br> [Policy adherence processes](./compliance-processes.md): Suggested processes for supporting policy compliance in the Security Baseline discipline. |
| <br> ![Maturity icon](../../_images/govern/process-maturity.png) | <br> [Maturity](./discipline-improvement.md): Align cloud management maturity with phases of cloud adoption. |
| <br> ![Toolchain icon](../../_images/govern/process-toolchain.png) | <br> [Toolchain](./toolchain.md): Azure services that can be implemented to support the Security Baseline discipline. |

## Next steps

Get started by evaluating business risks in a specific environment.

> [!div class="nextstepaction"]
> [Understand business risks](./business-risks.md)
