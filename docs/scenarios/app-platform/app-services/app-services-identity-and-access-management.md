---
title: Identity and access management considerations for <<Token-LongName>>
description: <<Describe how this landing zone accelerator can improve identity and access management of <<Token-Name>>.>>
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Identity and access management for considerations for <<Token-LongName>> landing zone accelerator

Intro paragraph. Disclose any required dependency on ESLZ design area or other ALZ design areas, with links to those supporting materials.

## Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of <<Token-LongName>>.

- Decide on the type of access for your application: public, private, or both.
- Decide on how to authenticate users that need to access your App Service: anonymous, internal corporate users, social accounts, other [identity provider](https://docs.microsoft.com/en-us/azure/app-service/overview-managed-identity?tabs=dotnet), or a mixture of these.
- Decide on whether to use system-assigned or user-assigned [managed identities](https://docs.microsoft.com/en-us/azure/app-service/overview-managed-identity?tabs=dotnet) for your App Service when connecting to AAD-protected backend resources.
- Consider creating [custom roles](https://docs.microsoft.com/en-us/azure/active-directory/roles/custom-create) following the principle of least privilege when out-of-box roles require modifications on existing permissions. Utilize [App Configuration](https://docs.microsoft.com/en-us/azure/architecture/solution-ideas/articles/appconfig-key-vault) to share common configuration values between applications, microservices, and serverless applications that are not passwords, secrets, or keys.

## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of <<Token-LongName>>.

- If the App Service requires authentication:
    - If access to the entire app service needs to be restricted to authenticated users, disable anonymous access.
    - Use the [Easy Auth](https://docs.microsoft.com/en-us/azure/app-service/overview-authentication-authorization) capabilities of App Services, instead of writing your own authentication and authorization code.
    - Use separate [application registrations](https://docs.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app) for separate [slots](https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots) or environments.
    - If the App Service is intended for internal users only, use [client certificate authentication](https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots) for increased security.
    - If the App Service is intended for external users, utilize [Azure AD B2C](https://docs.microsoft.com/en-us/azure/active-directory-b2c/overview) to authenticate to social accounts and Azure AD accounts. 
- Use [Azure built-in roles](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#web-plan-contributor) to provide least privilege permissions to manage App Service Plans and Websites
- Utilize system-assigned [managed identities](https://docs.microsoft.com/en-us/azure/app-service/overview-managed-identity?tabs=dotnet) to securely access AAD-protected backend resources.
- Ensure that users with access to Production resources in Azure are controlled and limited.
- For automated deployment purposes, setup a [service principal](https://docs.microsoft.com/en-us/azure/active-directory/develop/app-objects-and-service-principals) that has the minimum required permissions to deploy from the pipeline
- Review and follow the recommendations outlined in the [Identity and Access Control section](https://docs.microsoft.com/en-us/security/benchmark/azure/baselines/app-service-security-baseline?toc=/azure/app-service/toc.json#identity-and-access-control) of the Azure security baseline for App Service.

## Enterprise-scale assumptions

The following are assumptions that went into the development of the deployable asset: Enterprise-scale for <<Token-LongName>>.

## Additional considerations

Create as many H2 "##" headers as is required to educate the customer on this topic.