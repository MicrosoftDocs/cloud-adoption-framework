---
title: Azure landing zones canary approach with multiple tenants
description: Learn about the considerations and recommendations for the canary approach to use when handling multiple Microsoft Entra tenants with Azure landing zones.
author: jtracey93
ms.author: jatracey
ms.date: 11/28/2024
ms.topic: conceptual
ms.custom: think-tank
---

# Azure landing zones canary approach with multiple tenants

When you have multiple Microsoft Entra tenants, you can handle Azure landing zones canary environments the same way you handle them within a single Microsoft Entra tenant. If you're a multitenant ALZ consumer, follow the [canary guidance](../../../enterprise-scale/testing-approach.md) in each Microsoft Entra tenant separately.  
Canary Azure landing zones environment can be independently used to author and test ALZ deployments before you deploy them into the production environment. The term canary is used to avoid confusion with application development environments or test environments. This name is used for illustration purposes only.

## Deployment stamps approach

If you're a customer that's following a [deployment stamps pattern](/azure/architecture/patterns/deployment-stamp) for each of your Microsoft Entra tenants ALZ deployments (for example, each of the ALZ deployments is the same in structure, apart from a few naming changes), you might only need to have a single canary deployment because all your ALZ deployments are the same.

>[!NOTE]
> This approach is common in a Managed Service Provider (MSP) environment where the MSP manages several Microsoft Entra tenants for different clients that are all similar, except for their naming.

>[!TIP]
> Customers that follow the deployment stamp style pattern might also benefit from following the [Automation approach 2 – Shared application registration (multitenant) with multiple service principals](automation.md#approach-2--shared-application-registration-multitenant-with-multiple-service-principals).

## Next steps

> [!div class="nextstepaction"]
> [Azure Lighthouse usage in Azure landing zones multitenant scenarios](lighthouse.md)
