---
title: Deploy landing zones
description: Deploy landing zones
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Contents

This article describes how to deploy landing zones under the respective management group scope. This is the last of the three steps to set up your environment. Please complete [step 1](./Configure-run-initialization.md) and [step 2](./deploy-landing-zone.md) before you continue.

![Deploy your own environment process: step 3](../media/deploy-environment-step-3.png)
_Figure 1: Deploy your own environment_

# An overview of landing zones

In an enterprise-scale implementation, all platform resources in the `connectivity` and `management` subscriptions are deployed via Azure Policy. Enterprise-scale includes both the policy definitions and assignments required to deploy necessary resources. While it's possible to deploy Azure Policy definitions and assignments using the enterprise-scale GitHub Actions deployment process described in this article, enterprise-scale provides flexibility for how the assignments can be done in platform subscriptions.

All platform Azure resources in a landing zone following enterprise-scale guidance are fully controlled and provisioned through Azure Policy on the landing zone management group scope. More information on the [policy-driven approach](./../Design-Principles.md) can be found in the enterprise-scale design principals section of this document.

<!-- docsTest:ignore AzOps -->

Before continuing, ensure that you've completed all prerequisites in the previous sections, with special attention to the following steps:

1. Ensure the default management structure exists as described in the [configure GitHub and run initialization](./Configure-run-initialization.md) section.
2. Ensure you have [initialized AzOps repository](./Configure-run-initialization.md) and pushed changes are in your master branch.
3. All the platform infrastructure has been deployed following [these instructions](./deploy-platform-infrastructure.md).

---

## Create a landing zone

There is only one step required to move forward. Create or move a subscription under the landing zone management group. Once all the required definitions (roles, policies, and policy set) and the assignment (roles and policies) are deployed, subscriptions can be created or moved to the landing zones management group or any other scope below.

> Important: an existing subscription and Azure resource in it will be moved into a compliant state when moved under the landing zone scope.
