---
title: Identity Baseline discipline overview
description: Understand the approach to developing an Identity Baseline discipline as part of a cloud governance strategy.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Identity Baseline discipline overview

Identity baseline is one of the [Five Disciplines of Cloud Governance](../governance-disciplines.md) within the [Cloud Adoption Framework governance model](../index.md). Identity is increasingly considered the primary security perimeter in the cloud, which is a shift from the traditional focus on network security. Identity services provide the core mechanisms supporting access control and organization within IT environments, and the Identity Baseline discipline complements the [Security Baseline discipline](../security-baseline/index.md) by consistently applying authentication and authorization requirements across cloud adoption efforts.

> [!NOTE]
> Identity Baseline discipline does not replace the existing IT teams, processes, and procedures that allow your organization to manage and secure identity services. The primary purpose of this discipline is to identify potential identity-related business risks and provide risk-mitigation guidance to IT staff that are responsible for implementing, maintaining, and operating your identity management infrastructure. As you develop governance policies and processes make sure to involve relevant IT teams in your planning and review processes.

This section of the Cloud Adoption Framework outlines the approach to developing an Identity Baseline discipline as part of your cloud governance strategy. The primary audience for this guidance is your organization's cloud architects and other members of your cloud governance team. The decisions, policies, and processes that emerge from this discipline should involve engagement and discussions with relevant members of the IT teams responsible for implementing and managing your organization's identity management solutions.

If your organization lacks in-house expertise in identity and security, consider engaging external consultants as a part of this discipline. Also consider engaging [Microsoft Consulting Services](https://www.microsoft.com/industry/services/consulting), the [Microsoft FastTrack](https://azure.microsoft.com/programs/azure-fasttrack/) cloud adoption service, or other external cloud adoption partners to discuss concerns related to this discipline.

## Policy statements

Actionable policy statements and the resulting architecture requirements serve as the foundation of an Identity Baseline discipline. Use [sample policy statements](./policy-statements.md) as a starting point for defining your Identity Baseline policies.

> [!CAUTION]
> The sample policies come from common customer experiences. To better align these policies to specific cloud governance needs, execute the following steps to create policy statements that meet your unique business needs.

## Develop governance policy statements

The following steps offer examples and potential options to consider when developing your Identity Baseline discipline. Use each step as a starting point for discussions within your cloud governance team and with affected business, and IT teams across your organization to establish the policies and processes needed to manage identity-related risks.

| <span title="Icon">&nbsp;</span> | <span title="Description">&nbsp;</span> |
|--|--|
| <br> ![Template icon](../../_images/govern/process-template.png)   | <br> [Identity Baseline discipline template](./template.md): Download the template for documenting an Identity Baseline discipline. |
| <br> ![Risks icon](../../_images/govern/process-risks.png)         | <br> [Business risks](./business-risks.md): Understand the motives and risks commonly associated with the Identity Baseline discipline. |
| <br> ![Metrics icon](../../_images/govern/process-metrics.png)     | <br> [Indicators and metrics](./metrics-tolerance.md): Indicators to understand whether it's the right time to invest in the Identity Baseline discipline. |
| <br> ![Adherence icon](../../_images/govern/process-enforce.png)   | <br> [Policy adherence processes](./compliance-processes.md): Suggested processes for supporting policy compliance in the Identity Baseline discipline. |
| <br> ![Maturity icon](../../_images/govern/process-maturity.png)   | <br> [Maturity](./discipline-improvement.md): Align cloud management maturity with phases of cloud adoption. |
| <br> ![Toolchain icon](../../_images/govern/process-toolchain.png) | <br> [Toolchain](./toolchain.md): Azure services that can be implemented to support the Identity Baseline discipline. |

## Next steps

Get started by evaluating [business risks](./business-risks.md) in a specific environment.

> [!div class="nextstepaction"]
> [Understand business risks](./business-risks.md)
