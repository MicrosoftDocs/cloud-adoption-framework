---
title: Deploy
description: Deploy
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Contents

This article describes how to deploy landing zones under the management group scope. This is the last of the three steps to set up your environment. Please complete [step 1](./Configure-run-initialization.md) and [step 2](./Deploy-lz.md) before you continue.

![Deploy your own environment process - step 3](./media/deploy-environment-step-3.png)

# Create landing zones

In a CAF enterprise-scale implementation, all platform resources in the `connectivity` and `management` subscriptions are deployed via Microsoft Azure Policy. CAF enterprise includes policy definitions and assignments required to deploy the necessary resources. While it's possible to follow the GitHub steps described in this to deploy Azure Policy definitions and assignments within the CAF enterprise deployment process, CAF enterprise provides flexibility for how the assignments can be done within platform subscriptions.

All Azure platform resources in a landing zone follow CAF enterprise guidance and are fully controlled and provisioned through Azure Policy on the landing zone management group scope. More information on the [policy-driven approach](./../Design-Principles.md) can be found in the CAF enterprise design principals section of this document.

Before continuing, please ensure that you have completed all prerequisites in the previous sections with special attention to the following steps:

1. Ensure that the default management structure described in [Configure GitHub and run initialization](./Configure-run-initialization.md) section exists.
2. Ensure that you have [initialized azops repository](./Configure-run-initialization.md) and that pushed changes are in your **master** branch.
3. Ensure that all platform infrastructure has been deployed following [these instructions](./Deploy-platform-infra.md).

---

## Create a landing zone

There is only one more step required to move forward with creating a landing zone—create or move a subscription under the landing zone management group. Once the required definitions (roles, policies, and policy set) and assignment (roles and policies) are deployed, subscriptions can be created or moved to the landing zone's management group or any other scope below.

> Important: existing subscription and Azure resources in it will be moved into a compliant state when moved under the landing zone scope.
