---
title: 'Complex enterprise governance: Initial corporate policy'
description: Learn how to use the Cloud Adoption Framework for Azure to define initial complex governance position, risks, policy statements, and enforcement processes.
author: martinekuan
ms.author: martinek
ms.date: 09/05/2019
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Governance guide for complex enterprises: Initial corporate policy behind the governance strategy

The following corporate policy defines the initial governance position that's the starting point for this guide. This article defines early-stage risks, initial policy statements, and early processes to enforce policy statements.

> [!NOTE]
> The corporate policy isn't a technical document, but it drives many technical decisions. The governance MVP described in the [overview](./index.md) derives from this policy. Before you implement a governance MVP, your organization should develop a corporate policy based on your objectives and business risks.

## Cloud governance team

The CIO recently held a meeting with the IT governance team to understand the history of the personal data and mission-critical policies and to review the effect of changing those policies. The CIO discussed the overall potential of the cloud for IT and the company.

After the meeting, two members of the IT governance team requested permission to research and support the cloud planning efforts. The director of IT governance recognized an opportunity to limit shadow IT and the need for governance. They supported this idea. So, the cloud governance team was born. Over the next several months, they inherit the cleanup of many mistakes made during exploration in the cloud from a governance perspective. This duty earns them the moniker of *cloud custodians*. In later iterations, this guide shows how their roles change over time.

[!INCLUDE [business-risk](../../../../includes/business-risks.md)]

## Tolerance indicators

The current risk tolerance is high and the appetite for investing in cloud governance is low. So, the tolerance indicators act as an early warning system to trigger the investment of time and energy. If the following indicators are observed, it's wise to advance the governance strategy.

- **Cost Management discipline:** Scale of deployment exceeds 1,000 assets to the cloud, or monthly spending exceeds $10,000 USD per month.
- **Identity Baseline discipline:** Inclusion of applications with legacy or third-party multifactor authentication requirements.
- **Security Baseline discipline:** Inclusion of protected data in defined cloud adoption plans.
- **Resource Consistency discipline:** Inclusion of any mission-critical applications in defined cloud adoption plans.

[!INCLUDE [policy-statements](../../../../includes/policy-statements.md)]

## Next steps

This corporate policy prepares the cloud governance team to implement the governance MVP as the foundation for adoption. The next step is to implement this MVP.

[Best practices explained](./prescriptive-guidance.md)
