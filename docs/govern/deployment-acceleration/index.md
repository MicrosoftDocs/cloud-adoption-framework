---
title: Deployment Acceleration discipline overview
description: Use the Cloud Adoption Framework for Azure to understand a Deployment Acceleration discipline in relation to cloud governance.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Deployment Acceleration discipline overview

Deployment acceleration is one of the [Five Disciplines of Cloud Governance](../governance-disciplines.md) within the [Cloud Adoption Framework governance model](../index.md). This discipline focuses on ways of establishing policies to govern asset configuration or deployment. Within the Five Disciplines of Cloud Governance, the Deployment Acceleration discipline includes deployment, configuration alignment, and script reusability. This could be through manual activities or fully automated DevOps activities. In either case, the policies would remain largely the same. As this discipline matures, the cloud governance team can serve as a partner in DevOps and deployment strategies by accelerating deployments and removing barriers to cloud adoption, through the application of reusable assets.

This article outlines the deployment acceleration process that a company experiences during the planning, building, adopting, and operating phases of implementing a cloud solution. It's impossible for any one document to account for all of the requirements of any business. As such, each section of this article outlines suggested minimum and potential activities. The objective of these activities is to help you build a [policy MVP](../policy-compliance/index.md#minimum-viable-product-mvp-for-policy), but establish a framework for [incremental policy](../policy-compliance/index.md#incremental-policy-growth) improvement. The cloud governance team should decide how much to invest in these activities to improve the deployment acceleration position.

> [!NOTE]
> The Deployment Acceleration discipline does not replace the existing IT teams, processes, and procedures that allow your organization to effectively deploy and configure cloud-based resources. The primary purpose of this discipline is to identify potential business risks and provide risk-mitigation guidance to the IT staff that are responsible for managing your resources in the cloud. As you develop governance policies and processes make sure to involve relevant IT teams in your planning and review processes.

The primary audience for this guidance is your organization's cloud architects and other members of your cloud governance team. The decisions, policies, and processes that emerge from this discipline should involve engagement and discussions with relevant members of your business and IT teams, especially those leaders responsible for deploying and configuring cloud-based workloads.

## Policy statements

Actionable policy statements and the resulting architecture requirements serve as the foundation of a Deployment Acceleration discipline. Use [sample policy statements](./policy-statements.md) as a starting point for defining your Deployment Acceleration policies.

> [!CAUTION]
> The sample policies come from common customer experiences. To better align these policies to specific cloud governance needs, execute the following steps to create policy statements that meet your unique business needs.

## Develop governance policy statements

The following steps help you define governance policies to control deployment and configuration of resources in your cloud environment.

| <span title="Icon">&nbsp;</span> | <span title="Description">&nbsp;</span> |
|--|--|
| <br> ![Template icon](../../_images/govern/process-template.png) | <br> [Deployment Acceleration discipline template](./template.md): Download the template for documenting a Deployment Acceleration discipline. |
| <br> ![Risks icon](../../_images/govern/process-risks.png) | <br> [Business risks](./business-risks.md): Understand the motives and risks commonly associated with the Deployment Acceleration discipline.|
| <br> ![Metrics icon](../../_images/govern/process-metrics.png) | <br> [Indicators and metrics](./metrics-tolerance.md): Indicators to understand whether it's the right time to invest in the Deployment Acceleration discipline. |
| <br> ![Adherence icon](../../_images/govern/process-enforce.png) | <br> [Policy adherence processes](./compliance-processes.md): Suggested processes for supporting policy compliance in the Deployment Acceleration discipline. |
| <br> ![Maturity icon](../../_images/govern/process-maturity.png) | <br> [Maturity](./discipline-improvement.md): Align cloud management maturity with phases of cloud adoption.|
| <br> ![Toolchain icon](../../_images/govern/process-toolchain.png) | <br> [Toolchain](./toolchain.md): Azure services that can be implemented to support the Deployment Acceleration discipline. |

## Next steps

Get started by evaluating [business risks](./business-risks.md) in a specific environment.

> [!div class="nextstepaction"]
> [Understand business risks](./business-risks.md)
