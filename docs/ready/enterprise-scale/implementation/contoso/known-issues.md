---
title: "CAF enterprise-scale landing zone - Contoso reference implementation - known issues"
description: CAF enterprise-scale landing zone - Contoso reference implementation - known issues
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

# Contoso reference implementation - known issues

### Subscription creation

At present, it is not possible to provision new subscription via ARM templates. Subscription creation requires an enterprise enrollment account to be migrated to a new system in the backend. We are working closely with engineering teams to enable this functionality for the Contoso tenant.

### Unsupported number of tenants in context: X tenantid(s)

We currently do not support initialization across multiple tenants. <br>Clear your azcontext and run `connect-azaccount` with the service principal that was created earlier.
