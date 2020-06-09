---
title: Known issues
description: Known issues
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

<!-- docsTest:disable -->

<!-- cSpell:ignore azcontext -->

# Known issues with Contoso reference implementation

The list below summarizes the known issues with Contoso reference implementation while building and operationalizing their Microsoft Azure platform with first-party platform and product capabilities.

## Creating subscriptions

**Area:** `Microsoft.Subscription` resource provider

**Issue:** It's not currently possible to provision new subscriptions with Resource Manager templates. Creating a subscription requires an enterprise enrollment account to migrate to the back-end API under a new billing account.

**Status:** We're working closely with engineering teams to enable this functionality for the Contoso tenant. As a workaround, subscriptions are created using GitHub Actions and with a service principal to call the post API.

## Unable to tag subscriptions using Azure Policy

**Area:** Azure Policy

**Issue:** A subscription can't currently be tagged by Azure Policy, which makes it hard to navigate subscriptions during policy evaluations and to target the correct one(s).

**Status:** For Contoso to determine and target platform subscriptions with their specific policies, their workaround is to have a dedicated management group for each subscription, which is child to the platform management group.

## Unable to use policy aliases on `Microsoft.Resources/subscriptions`

**Area:** `Microsoft.Subscription` resource provider

**Issue:** A subscription's display name can't be currently used in the policy rule, which makes it hard to navigate subscriptions during policy evaluations and to target the correct one(s).

Status: for Contoso to determine and target platform subscriptions with their specific policies, their workaround is to have a dedicated management group for each subscription, which is child to the platform management group.

## Move subscription to management group

**Area:** `Microsoft.Management` resource provider

**Issue:** When doing a `put` on `Microsoft.Management/managementGroups/subscriptions`, the `put` and `get` response is `204 (no content)`, causing the overall template deployment to fail. A fix was deployed to resolve the `put` request. Contoso is waiting for the fix to resolve the `get` request.

**Status:** No fix at this time.

## Reference() resources at management group scope when deploying Resource Manager templates to subscription scope

Area: Resource Manager template deployments

**Issue:** When deploying a subscription template and using the template reference() function to reference a resource (policy definitions/policy assignments) from the management group, the function appends the subscription ID to the referenced resource, causing the deployment to fail.

**Status:** No fix at this time. A workaround for template deployment to succeed is for specific policy assignments to sit directly on the subscription.

## Management group scoped deployments can deploy to tenant root scope

Area: Resource Manager template deployments

Issue: when performing nested deployment from the management group scope without having the scope properly specified on `Microsoft.Resources/deployments`, Resource Manager defaults to the tenant root and does a tenant scope deployment.

**Status:** No fix at this time.

## Reference() function not respecting dependency graph [depends on]

**Area:** Resource Manager template deployments

Issue: when doing nested deployments from tenant scope (policy assignment and subsequent role assignment for the managed identity), the `reference()` function fails, saying the policy assignment can't be found even though it exists. Redeploying works fine.

**Status:** There isn't a fix at this time.

## The `reference()` function runs even though the resource condition is false

**Area:** Resource Manager template deployments

**Issue:** When using conditions on resources, they evaluate as false. The `reference()` function within resource properties is still executed, causing the deployment to fail.

**Status:** No fix at this time. A workaround is to perform a number of additional `if()` functions to navigate logically (for example, if a reference resource doesn't exist, `throw json('null')`.)

## Unsupported number of tenants in context: X tenantId(s)

**Issue:** We currently don't support initialization across multiple tenants. Clear `azcontext` and run `Connect-AzAccount` with the service principal created earlier.

**Status:** No fix at this time.

## Subscriptions or management group with duplicated names

**Issue:** The discovery process discussed in [Configure GitHub and run initialization](./configure-run-initialization.md) fails if there are subscriptions or management groups with duplicate names.

**Status:** No fix at this time. A workaround is to verify that the subscription names and management groups in your tenant are unique regardless of the hierarchy prior to running the discovery process.
