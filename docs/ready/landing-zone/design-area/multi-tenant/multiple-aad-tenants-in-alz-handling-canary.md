---
title: Handling ALZ across Multiple AAD Tenants - Canary Considerations & Recommendations
description: Review the canary considerations and recommendations when handling multiple Azure AD Tenants alongside Azure Landing Zones
author: jtracey93
ms.author: jatracey
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Handling ALZ across Multiple AAD Tenants - Canary Considerations & Recommendations

Handling Azure Landing Zones Canary environments when you have multiple Azure AD Tenants is not any different to handling them within a single Azure AD Tenant. So if you are a multi-tenant ALZ consumer then you should follow the [canary guidance](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach) in each Azure AD Tenant separately as it is documented and described.

However, if you are a customer that is following a [Deployment Stamps pattern](/azure/architecture/patterns/deployment-stamp) for each of your Azure AD Tenants ALZ deployments (e.g. each of the ALZ deployments are exactly the same in structure, apart from a few naming changes) you might decide that you only need to have a single canary deployment as all of your ALZ deployments are the same.

>[!NOTE]
> This would more commonly be seen in a Managed Service Provider (MSP) environment where the MSP is managing several Azure AD Tenants for different clients that are all similar apart from their naming.

>[!TIP]
> Customers following Deployment Stamp style pattern might also benefit from following the [Automation Approach 2 – Shared Application Registration (Multi-Tenant) with Multiple Service Principals](multiple-aad-tenants-in-alz-handling-automation.md#approach-2-–-shared-application-registration-multi-tenant-with-multiple-service-principals)

## Next steps

> [!div class="nextstepaction"]
> [Handling ALZ across Multiple AAD Tenants - Automation Considerations & Recommendations](multiple-aad-tenants-in-alz-handling-automation.md)
> [Handling ALZ across Multiple AAD Tenants -  Considerations & Recommendations](multiple-aad-tenants-in-alz-handling-c-r.md.md)
> [Handling ALZ across Multiple AAD Tenants - Azure Lighthouse usage in ALZ Multi-Tenant](multiple-aad-tenants-in-alz-handling-automation.md)