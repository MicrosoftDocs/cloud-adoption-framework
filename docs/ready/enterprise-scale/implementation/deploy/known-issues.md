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

## Contoso reference implementation - known issues

The list below summarizes the known issues with Contoso reference implementation, when building and operationalizing their Azure platform using first-party platform and product capabilities.

### Subscription creation

Area: Microsoft.subscription resource provider

Issue: at present, it is not possible to provision new subscription via ARM templates. Subscription creation requires an enterprise enrollment account to be migrated to a new billing account API in the backend.

Status: we are working closely with engineering teams to enable this functionality for the Contoso tenant. As a workaround, subscriptions are created using GitHub Actions, having a service principal to call the post API

### Unable to tag subscriptions using Azure Policy

Area: Azure Policy

Issue: currently, a subscription cannot be tagged by Azure Policy, which makes it hard to navigate through subscriptions in policy evaluations to target the correct subscription(s).

Status: for Contoso to deterministically target the platform subscriptions with their specific policies, their workaround is to have a dedicated management group for each subscription, child to the platform management group

### Unable to use policy aliases on Microsoft.resources/subscriptions

Area: Microsoft.subscription resource provider

Issue: currently, the display name of a subscription cannot be used in the policy rule, which makes it hard to navigate through subscriptions in policy evaluations to target the correct subscription(s).

Status: for Contoso to deterministically target the platform subscriptions with their specific policies, their workaround is to have a dedicated management group for each subscription, child to the platform management group

### Move subscription to management group

Area: Microsoft.management resource provider

Issue: when doing put on Microsoft.management/managementgroups/subscriptions, the put and get response is 204 (no content), so the overall template deployment fails. Fix was deployed to resolve put request. Waiting for the fix to resolve get request.

Status: no fix as of yet.

### Reference() resources at management group scope when deploying ARM templates to subscription scope

Area: Azure Resource Manager template deployments

Issue: when deploying a subscription template and using template reference() function to reference a resource (policydefinitions/policyassignments) from management group, the function append the subscriptionid to the referenced resource, which will cause the deployment to fail.

Status: no fix as of yet, and for workaround the particular policyassignments must sit directly on the subscription for the template deployment to succeed.

### Management group scoped deployments can deploy to tenant root scope

Area: Azure Resource Manager template deployments

Issue: when doing nested deployment from management group scope without having the "scope" property specified on "Microsoft.resources/deployments", ARM defaults to tenant root and does a tenant scope deployment.

Status: no fix as of yet.

### Reference() function not respecting dependency graph [dependson]

Area: Azure Resource Manager template deployments

Issue: when doing nested deployments from tenant scope (e.g., policyassignment and subsequent roleassignment for the managed identity), the reference() function fails saying the policyassignment cannot be found, even though it exists. A re-deployment works fine.

Status: no fix as of yet.

### Reference() function runs even though the resource condition is false

Area: Azure Resource Manager template deployments

Issue: when using "conditions" on resources, and it evaluates to false, the reference() function within the resource properties is still executed which causes the deployment to fail.

Status: no fix as of yet. Workaround is to do n number of additional if() functions to logically navigate (e.g., if reference resource doesn't exist, throw json('null').)

### Unsupported number of tenants in context: X tenantid(s)

Issue: we currently do not support initialization across multiple tenants. <br>Clear your azcontext and run `connect-azaccount` with the service principal that was created earlier.

Status: no fix as of yet.

### Subscriptions or management group with duplicated names

Issue: the discovery process discussed on [this](./Configure-run-initialization.md) article will fail if there are subscriptions or management groups with duplicated names.

Status: workaround is to ensure subscription names and management groups are unique in your tenant regradless of the hierarchy prior to running the discovery process.
