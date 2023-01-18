---
title: Handling ALZ across Multiple AAD Tenants - Automation Considerations & Recommendations
description: Review the automation considerations and recommendations when handling multiple Azure AD Tenants alongside Azure Landing Zones
author: jtracey93
ms.author: jatracey
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Handling ALZ across Multiple AAD Tenants - Automation Considerations & Recommendations

This page details considerations and recommendations regarding automating your Azure landing zones deployments when handling multiple Azure AD Tenants.

## Approaches

There are two approaches that can be taken when automating the deployment of Azure landing zones across multiple Azure AD Tenants. Each of which are documented below.

### Approach 1 – Complete Isolation

In this approach the primary objective is to keep each Azure AD Tenant completely isolated from each other across all automation components, listed below:

- Git Repository
- GitHub Actions/Azure DevOps Pipelines
  - Including self-hosted runners, if being utilized
- Identities used for performing tasks from automation. This could be:
  - Managed Identities assigned to self-hosted runners
  - Service Principals (SPNs)

[![Diagram of multiple Azure AD Tenants with Azure Landing Zones deployed using the complete isolation automation approach](media/alz-multi-tenant-3.png)](media/alz-multi-tenant-3.png#lightbox)

This approach does mean there are more components to manage that are duplicated per Azure AD Tenant, however, this might be a requirement for some organizations that have regulatory compliance controls enforced upon them that mandate this type of segregation and isolation.

>[!NOTE]
> If your organization only allows the use of Managed Identities for platform automation, then you must use this approach; or one that logs into each tenant individually. This is due to the limitation that Managed Identities do not support cross-tenant scenarios today, as documented [here.](/azure/active-directory/managed-identities-azure-resources/managed-identities-faq#can-i-use-a-managed-identity-to-access-a-resource-in-a-different-directorytenant)

### Approach 2 – Shared Application Registration (Multi-Tenant) with Multiple Service Principals

In this approach an Application Registration is created in the “managing Azure AD Tenant” then in every Azure AD Tenant that you wish to manage a Service Principal (SPN) is created in that tenant based on the Application Registration. This then allows the workers running the pipeline tasks and steps to login to any of the Azure AD Tenants with a single set of credentials, simplifying operations.

The handling of multiple environments (for example Dev, Test, Prod) can also be controlled in the same way using the same, or separate Application Registrations and Enterprise Applications alongside pipelines.

You might decide to have separate pipelines for each Azure AD Tenant and pipelines or use a single pipeline, the choice is yours based upon your requirements.

>[!NOTE]
> When using a centralized pipeline, you might need to build a small mapping table that contains data correlating the Azure AD Tenants and other metadata, like the environment, associated subscriptions, organization name, identity object ID to use to AuthN/AuthZ etc.
>
> This data can then be called upon during the run of the pipeline in a step that uses some logic and conditions to control which Azure AD Tenant is deployed to and with which identities.
>
> This could be stored in services like Azure Cosmos DB or Azure Table Storage.

In the below example we show a single App Registration in the `contoso.onmicrosoft.com` Azure AD Tenant and then an Enterprise Application in each of the Azure AD Tenants that is linked to the App Registration. This allows a pipeline to authenticate and authorize to all the Azure AD Tenants using the single App Registration. This scenario is documented further here in [Making your application multi-tenant](/azure/active-directory/develop/howto-convert-app-to-be-multi-tenant)

[![Diagram of multiple Azure AD Tenants with Azure Landing Zones deployed using the Shared Application Registration (Multi-Tenant) with Multiple Service Principals automation approach](media/alz-multi-tenant-4.png)](media/alz-multi-tenant-4.png#lightbox)

>[!NOTE]
> Azure Lighthouse works in a similar way to as described in this approach. However, Azure Lighthouse does not allow the assignment of the RBAC Owner, User Access Administrator and roles with DataActions permissions, as documented in [Role support for Azure Lighthouse.](/azure/lighthouse/concepts/tenants-users-roles#role-support-for-azure-lighthouse)
> 
> The role of Owner and User Access Role are typically required in all Azure landing zone deployment scenarios which therefore rules Azure Lighthouse out as an option for the entire platform automation deployment aspect of Azure landing zones.
> 
> However, it can still be useful in some scenarios as documented in [Azure Lighthouse usage in ALZ Multi-Tenant](multiple-aad-tenants-in-alz-handling-lighthouse.md)

## Next steps

> [!div class="nextstepaction"]
> [Handling ALZ across Multiple AAD Tenants - Canary Considerations & Recommendations](multiple-aad-tenants-in-alz-handling-canary.md)
> [Handling ALZ across Multiple AAD Tenants - Azure Lighthouse usage in ALZ Multi-Tenant](multiple-aad-tenants-in-alz-handling-automation.md)
