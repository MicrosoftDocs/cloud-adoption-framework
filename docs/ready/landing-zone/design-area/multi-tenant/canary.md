---
title: Azure landing zones canary approach with multiple tenants
description: Learn about the considerations and recommendations for the canary approach to use when handling multiple Azure Active Directory tenants with Azure landing zones.
author: jtracey93
ms.author: jatracey
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Azure landing zones canary approach with multiple tenants

Handling Azure landing zones canary environments when you have multiple Azure Active Directory tenants isn't any different to handling them within a single Azure Active Directory tenant. If you're a multi-tenant ALZ consumer, follow the [canary guidance](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach) in each Azure Active Directory tenant separately.

## Deployment stamps approach

If you're a customer that's following a [deployment stamps pattern](/azure/architecture/patterns/deployment-stamp) for each of your Azure Active Directory tenants ALZ deployments (for example, each of the ALZ deployments is the same in structure, apart from a few naming changes), you might only need to have a single canary deployment because all your ALZ deployments are the same.

>[!NOTE]
> This approach is common in a Managed Service Provider (MSP) environment where the MSP is managing several Azure Active Directory tenants for different clients that are all similar, except for their naming.

>[!TIP]
> Customers that follow the deployment stamp style pattern might also benefit from following the [Automation approach 2 – Shared application registration (multi-tenant) with multiple service principals](automation.md#approach-2--shared-application-registration-multi-tenant-with-multiple-service-principals).

## Next steps

> [!div class="nextstepaction"]
> [Azure Lighthouse usage in Azure landing zones multi-tenant scenarios](lighthouse.md)