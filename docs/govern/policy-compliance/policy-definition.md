---
title: Define corporate policy for cloud governance 
description: Use the Cloud Adoption Framework for Azure to learn to establish policy that addresses known risks and risk tolerances during your cloud transformation journey.
author: martinekuan
ms.author: martinek
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Define corporate policy for cloud governance

After you've analyzed the known risks and related risk tolerances for your organization's cloud transformation journey, set up policy to clearly address those risks. Your policy also defines the necessary steps to remediate the risks where possible.

## How can corporate IT policy become cloud-ready?

In traditional governance and incremental governance, corporate policy creates the working definition of governance. Most IT governance actions seek to implement technology that monitors, enforces, operates, and automates corporate policies. Cloud governance is built on similar concepts.

![Diagram that shows corporate governance and governance disciplines.](../../_images/operational-transformation-govern-large.png)
*Figure 1: Corporate governance and governance disciplines.*

The image illustrates the relationship between business risk, policy and compliance, and monitoring and enforcement mechanisms that need to interact as part of your governance strategy. The Five Disciplines of Cloud Governance let you manage the interactions and realize your strategy.

Cloud governance is the product of an ongoing adoption effort, because lasting transformation doesn't happen overnight. If you attempt to deliver complete cloud governance before addressing key corporate policy changes, it seldom produces the desired results. Instead, use an incremental approach.

What's different about a Cloud Adoption Framework is the purchasing cycle that enables authentic transformation. Since it doesn't take large capital to acquire, engineers can begin their experimentation and adoption sooner. In most corporate cultures, eliminating the capital expense barrier to adoption leads to tighter feedback loops, organic growth, and incremental development.

The shift to cloud adoption requires a shift in governance. In many organizations, corporate policy transformation supports:

- Improved governance and higher rates of adherence through incremental policy changes
- Automated enforcement of those changes

The newly defined capabilities that you configure with your cloud service provider power the policy changes.

## Review existing policies

As governance is an ongoing process, regularly review your policy with IT staff and stakeholders. You want to ensure that your resources hosted in the cloud maintain compliance with overall corporate goals and requirements. Your understanding of new risks and acceptable tolerance can fuel your [review of existing policies](./cloud-policy-review.md). Reviewing your existing policies helps determine the level of governance that's right for your organization.

> [!TIP]
> If your organization uses vendors or other trusted business partners, one of the biggest business risks to consider might be a lack of adherence to [regulatory compliance](./regulatory-compliance.md) by these external organizations. This risk often can't be remediated, and instead might require a strict adherence to requirements by all parties. Be sure to identify and understand any third-party compliance requirements before beginning a policy review.

## Create cloud policy statements

Cloud-based IT policies establish the requirements, standards, and goals that your IT staff and automated systems need to support. Policy decisions are a primary factor in your [cloud architecture design](./governance-alignment.md) and how you'll implement your [policy adherence processes](./processes.md).

Individual cloud policy statements are guidelines for addressing the specific risks you identify during your risk assessment process. While you can integrate these policies into your wider corporate policy documentation, cloud policy statements explored in the Cloud Adoption Framework guidance tend to be a more concise summary of the risks, and plans to deal with them. Include these pieces of information in each definition:

- **Business risk:** A summary of the risk this policy addresses.
- **Policy statement:** A concise explanation of the policy requirements and goals.
- **Design or technical guidance:** Actionable recommendations, specifications, or other guidance to support and enforce this policy that IT teams and developers use when designing and building their cloud deployments.

If you need help with defining your policies, consult the [governance disciplines](../governance-disciplines.md) introduced in the governance section overview. The articles for these disciplines includes examples of common business risks encountered when moving to the cloud and sample policies to address the risks. For example, see the Cost Management discipline's [sample policy definitions](../cost-management/policy-statements.md).

## Incremental governance and integrating with existing policy

Vet the planned additions to your cloud environment for compliance with existing policy. Update your policy to account for issues not already covered. You should also perform a regular [cloud policy review](./cloud-policy-review.md) to ensure your cloud policy is up-to-date and in sync with any new corporate policy.

The need to integrate cloud policy with your legacy IT policies depends largely on the maturity of your cloud governance processes and the size of your cloud estate. For more information and a broader discussion about policy integration during your cloud transformation, see [Prepare corporate IT policy for the cloud](./index.md).

## Next steps

After defining your policies, draft an architecture design guide to provide IT staff and developers with actionable guidance.

> [!div class="nextstepaction"]
> [Align your governance design guide with corporate policy](./governance-alignment.md)
