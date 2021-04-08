---
title: Resource Consistency discipline overview
description: Understand the approach to developing a Resource Consistency discipline as part of a cloud governance strategy.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Resource Consistency discipline overview

Resource consistency is one of the [Five Disciplines of Cloud Governance](../governance-disciplines.md) within the [Cloud Adoption Framework governance model](../index.md). This discipline focuses on ways of establishing policies related to the operational management of an environment, application, or workload. IT operations teams often provide monitoring of applications, workload, and asset performance. They also commonly execute the tasks required to meet scale demands, remediate performance service-level agreement (SLA) violations, and proactively avoid performance SLA violations through automated remediation. Within the Five Disciplines of Cloud Governance, the Resource Consistency discipline ensures resources are consistently configured in such a way that they can be discoverable by IT operations, are included in recovery solutions, and can be onboarded into repeatable operations processes.

> [!NOTE]
> Resource Consistency discipline does not replace the existing IT teams, processes, and procedures that allow your organization to effectively manage cloud-based resources. The primary purpose of this discipline is to identify potential business risks and provide risk-mitigation guidance to the IT staff that are responsible for managing your resources in the cloud. As you develop governance policies and processes make sure to involve relevant IT teams in your planning and review processes.

This section of the Cloud Adoption Framework outlines how to develop a Resource Consistency discipline as part of your cloud governance strategy. The primary audience for this guidance is your organization's cloud architects and other members of your cloud governance team. The decisions, policies, and processes that emerge from this discipline should involve engagement and discussions with relevant members of the IT teams responsible for implementing and managing your organization's resource consistency solutions.

If your organization lacks in-house expertise in resource consistency strategies, consider engaging external consultants as a part of this discipline. Also consider engaging [Microsoft Consulting Services](https://www.microsoft.com/industry/services/consulting), the [Microsoft FastTrack](https://azure.microsoft.com/programs/azure-fasttrack/) cloud adoption service, or other external cloud adoption experts for discussing how best to organize, track, and optimize your cloud-based assets.

## Policy statements

Actionable policy statements and the resulting architecture requirements serve as the foundation of a Resource Consistency discipline. Use [sample policy statements](./policy-statements.md). These samples can serve as a starting point for defining your Resource Consistency policies.

> [!CAUTION]
> The sample policies come from common customer experiences. To better align these policies to specific cloud governance needs, execute the following steps to create policy statements that meet your unique business needs.

## Develop governance policy statements

The following steps offer examples and potential options to consider when developing your Resource Consistency discipline. Use each step as a starting point for discussions within your cloud governance team and with affected business, and IT teams across your organization to establish the policies and processes needed to manage Resource Consistency discipline risks.

| <span title="Icon">&nbsp;</span> | <span title="Description">&nbsp;</span> |
|--|--|
| <br> ![Template icon](../../_images/govern/process-template.png) | <br> [Resource Consistency discipline template](./template.md): Download the template for documenting a Resource Consistency discipline. |
| <br> ![Risks icon](../../_images/govern/process-risks.png) | <br> [Business risks](./business-risks.md): Understand the motives and risks commonly associated with the Resource Consistency discipline. |
| <br> ![Metrics icon](../../_images/govern/process-metrics.png) | <br> [Indicators and metrics](./metrics-tolerance.md): Indicators to understand whether it's the right time to invest in the Resource Consistency discipline. |
| <br> ![Adherence icon](../../_images/govern/process-enforce.png) | <br> [Policy adherence processes](./compliance-processes.md): Suggested processes for supporting policy compliance in the Resource Consistency discipline. |
| <br> ![Maturity icon](../../_images/govern/process-maturity.png) | <br> [Maturity](./discipline-improvement.md): Align cloud management maturity with phases of cloud adoption. |
| <br> ![Toolchain icon](../../_images/govern/process-toolchain.png) | <br> [Toolchain](./toolchain.md): Azure services that can be implemented to support the Resource Consistency discipline. |

## Next steps

Get started by evaluating [business risks](./business-risks.md) in a specific environment.

> [!div class="nextstepaction"]
> [Understand business risks](./business-risks.md)
