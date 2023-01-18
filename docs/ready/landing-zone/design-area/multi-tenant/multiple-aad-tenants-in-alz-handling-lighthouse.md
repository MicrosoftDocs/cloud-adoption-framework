---
title: Handling ALZ across Multiple AAD Tenants - Azure Lighthouse usage in ALZ Multi-Tenant
description: Understand how Azure Lighthouse can be used in environments with Multiple Azure AD Tenants with Azure Landing Zones
author: jtracey93
ms.author: jatracey
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Handling ALZ across Multiple AAD Tenants - Azure Lighthouse usage in ALZ Multi-Tenant

[Azure Lighthouse](/azure/lighthouse/overview) enables multi-tenant management with scalability, higher automation, and enhanced governance across resources.

Azure Lighthouse can be adopted in ALZ scenarios whether in single or multi-tenant architectures.

Review the below considerations, recommendations and common scenarios relating to Azure Lighthouse in ALZ deployments.

## Considerations

- Azure Lighthouse across Azure Clouds, for example Azure Public Cloud to Azure US Gov Cloud, isn't supported as documented [here](/azure/lighthouse/overview#cross-region-and-cloud-considerations)
- Azure Lighthouse only supports delegations of Subscriptions or Resource Groups, not Management Groups or Tenants
  - However, there's a solution to onboarding multiple subscriptions within a Management Group as documented [here](/azure/lighthouse/how-to/onboard-management-group)
    - This policy follows the Azure landing zones design principle of [Policy-driven governance](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#policy-driven-governance)
- Review the limitations on RBAC roles support with Azure Lighthouse in Role support for Azure Lighthouse.

## Recommendations

- Review [Azure Lighthouse in enterprise scenarios](/azure/lighthouse/concepts/enterprise)
- If you're an ISV review [Azure Lighthouse in ISV scenarios](/azure/lighthouse/concepts/isv-scenarios)
- Use Azure Lighthouse in both directions between Azure AD Tenants to simplify management activities and reduce complex AuthN/AuthZ scenarios
  - Removes reliance on Azure AD B2B (Guest) accounts for user and workload identities or having separate accounts for some activities
- Utilize Azure AD Privileged Identity Management (PIM) as part of your Azure Lighthouse delegations as documented [here](/azure/lighthouse/how-to/create-eligible-authorizations)
  - This feature requires Azure AD Premium P2 licensing but only from the source/managing Azure AD Tenant

## Azure Landing Zones Specific Scenarios

Below is a list of ALZ specific scenarios where we've seen the usage of Azure Lighthouse in with ALZ when operating multiple Azure AD Tenants.

### 1 - Azure Lighthouse + Private DNS at Scale

Using Azure Lighthouse to allow Azure Policy for Private Endpoints Private DNS Zone automatic linking, as per [Private Link and DNS integration at scale](/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale), in "spoke" Azure AD Tenants to the centralized Private DNS Zones in the "Hub" Azure AD Tenant.

[![Diagram of multiple Azure AD Tenants with Azure Landing Zones deployed using Azure Lighthouse in the Private DNS at Scale scenario](media/alz-multi-tenant-5.png)](media/alz-multi-tenant-5.png#lightbox)

This architecture also allows application landing zone owners to be granted access to make changes to Private DNS Zone via Azure Lighthouse delegation authorizations, if a different approach is being used to manage the Private Endpoints DNS configuration.

## Next steps

> [!div class="nextstepaction"]
> [Handling ALZ across Multiple AAD Tenants - Automation Considerations & Recommendations](multiple-aad-tenants-in-alz-handling-automation.md)

> [!div class="nextstepaction"]
> [Handling ALZ across Multiple AAD Tenants - Considerations & Recommendations](multiple-aad-tenants-in-alz-handling-c-r.md)

> [!div class="nextstepaction"]
> [Handling ALZ across Multiple AAD Tenants - Canary Considerations & Recommendations](multiple-aad-tenants-in-alz-handling-canary.md)