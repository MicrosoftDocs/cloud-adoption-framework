---
title: Deploy
description: Deploy
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

<!-- docsTest:disable -->

# Deploy

This article describes how to deploy landing zones under the management group scope. This is the last of the three steps to set up your environment. Please complete [step 1](./configure-run-initialization.md) and [step 2](./deploy-landing-zone.md) before you continue.

![Step 3: the process to deploy your own environment](../media/deploy-environment-step-3.png)

## Create landing zones

In a Cloud Adoption Framework (CAF) enterprise-scale implementation, all platform resources in the connectivity and management subscriptions are deployed via Microsoft Azure Policy. CAF enterprise includes the policy definitions and assignments required for deploying necessary resources. While it's possible to follow the GitHub steps described in this article to deploy Azure Policy definitions and assignments within the the CAF enterprise deployment process, CAF enterprise provides flexibility for how the assignments can be done within platform subscriptions.

All Azure platform resources in a landing zone follow CAF enterprise guidance and are fully controlled and provisioned through Azure Policy on the landing zone management group scope. More information on the [policy-driven approach](./../Design-Principles.md) can be found in the CAF enterprise design principals section of this article.

Before continuing, please verify that you've completed all prerequisites in the previous sections with special attention to the following steps:

1. Ensure that the default management structure described in the [configure GitHub and run initialization](./Configure-run-initialization.md) section exists.
2. Ensure that you have [initialized the AzOps repo](./configure-run-initialization.md) and that pushed changes are in your `master` branch.
3. Ensure that all platform infrastructure has been deployed following [these instructions](./deploy-platform-infrastructure.md).

## Create a landing zone

There is only one more step required to move forward with creating a landing zone&mdash;create or move a subscription under the landing zone management group. Once the required definitions (roles, policies, and policy set) and assignment (roles and policies) are deployed, subscriptions can be created or moved to the landing zone's management group or any other scope below.

> [!IMPORTANT]
> When moved under the landing zone scope, existing subscription and Azure resources within it will be moved into a compliant state.
