---
title: Azure Landing Zones Canary approach with multiple tenants
description: Review the canary considerations and recommendations when handling multiple Azure Active Directory tenants alongside Azure Landing Zones
author: jtracey93
ms.author: jatracey
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Azure Landing Zones Canary approach with multiple tenants

Handling Azure Landing Zones Canary environments when you have multiple Azure Active Directory tenants isn't any different to handling them within a single Azure Active Directory tenant. So if you're a multi-tenant ALZ consumer, then you should follow the [canary guidance](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach) in each Azure Active Directory tenant separately as it's documented and described.

## Deployment Stamps Approach

However, if you're a customer that is following a [Deployment Stamps pattern](/azure/architecture/patterns/deployment-stamp) for each of your Azure Active Directory tenants ALZ deployments (for example, each of the ALZ deployments are the same in structure, apart from a few naming changes) you might decide that you only need to have a single canary deployment as all of your ALZ deployments are the same.

>[!NOTE]
> This would more commonly be seen in a Managed Service Provider (MSP) environment where the MSP is managing several Azure Active Directory tenants for different clients that are all similar apart from their naming.

>[!TIP]
> Customers following Deployment Stamp style pattern might also benefit from following the [Automation Approach 2 – Shared Application Registration (multi-tenant) with Multiple Service Principals](automation.md#approach-2--shared-application-registration-multi-tenant-with-multiple-service-principals)

## Next steps

> [!div class="nextstepaction"]
> [Azure Lighthouse usage in Azure Landing Zones multi-tenant scenarios](lighthouse.md)