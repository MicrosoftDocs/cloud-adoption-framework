---
title: Known issues
description: Known issues
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

# Contoso reference implementation: known issues

## Subscription creation

It isn't currently possible to provision new subscriptions via Microsoft Azure Resource Manager templates. Subscription creation requires an enterprise enrollment account to migrate to a new system in the backend. We are working closely with engineering teams to enable this functionality for the Contoso tenant.

## Unsupported number of tenants in context: X tenantid(s)

We currently don't support initialization across multiple tenants. Clear your azcontext and run `connect-azaccount` with the Service Principal created earlier.
