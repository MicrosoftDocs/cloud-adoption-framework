---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Contents

This article describes how to deploy landing zones under the respective management group scope. This is the last of the three steps to setup your environment. Please complete first [step 1](./Configure-run-initialization.md) and [step 2](./Deploy-lz.md) before you continue.

![Deploy your own environment process - step 3](./media/deploy-environment-step-3.png)

# Create landing zones

In a enterprise-scale implementation, all platform resources in the __connectivity__ and __management__ subscriptions are deployed via Azure Policy. Enterprise-scale includes both, policy definitions and assignments required to deploy the neccesary resources. While it is possible to deploy both, Azure Policy definition and assignments using enterprise-scale deployment process via GitHub Actions as described in this article, enterprise-scale provides flexiblity for how the assignments can be done in the platform subscriptions.

All platform Azure resources in a landing zones following the enterprise-scale guidance are fully controlled and provisioned through Azure Policy on the landing zone management group scope. More information on the [policy-driven approach](./../Design-Principles.md) can be found in the enterprise-scale design principals section of this document.

Before continuing, please ensure that you have completed all prerequisites in the previous sections. Specially the below steps:

1. Ensure the default management structure exist as described in the the [configure GitHub and run initialization](./Configure-run-initialization.md) section.
2. Ensure you have [initialized azops repository](./Configure-run-initialization.md) and pushed changes are in your **master** branch.
3. All the platform infrastructure has been deployed following [these instructions](./Deploy-platform-infra.md).

---

## Create a landing zone

It is now time to turn the lights on, there is only one step required!

1. Create or move a subscription under the landing zone management group.
   Once all the required definitions (roles, policies and policyset) and the assignment (roles and policies) are deployed, subscriptions can be created or moved to the landing zones managment group or any other scope below.

> Important: existing subscription and Azure resource in it, will be moved into a compliant state when moved under the landing zone scope.
