---
title: Identity and access management considerations for Azure App Service
description: Learn about design considerations and recommendations for identity and access management in the Azure App Service landing zone accelerator.
author: martinekuan
ms.author: martinek
ms.date: 01/06/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Identity and access management for considerations for the Azure App Service landing zone accelerator

This article provides design considerations and recommendations for identity and access management when using the Azure App Service landing zone accelerator. Identity and access management covers multiple aspects including authentication and app configuration.

Learn more about the [identity and access management](../../../ready/landing-zone/design-area/identity-access.md) design area.

## Design considerations

When preparing for deployment on Azure App Service, there are several considerations to keep in mind when it comes to identity and access management (IAM) for the landing zone accelerator. Here are some key points to consider:

- Decide on the level of security and isolation required for the app and its data. Public access allows anyone with the app URL to access the app, while private access restricts access to only authorized users and networks.
- Decide on the type of authentication and authorization needed for your App Service: anonymous, internal corporate users, social accounts, other [identity provider](/azure/app-service/overview-managed-identity?tabs=dotnet), or a mixture of these.
- Decide on whether to use system-assigned or user-assigned [managed identities](/azure/app-service/overview-managed-identity?tabs=dotnet) for your App Service when connecting to AAD-protected backend resources.
- Consider creating [custom roles](/azure/active-directory/roles/custom-create) following the principle of least privilege when out-of-box roles require modifications on existing permissions. 
- Choosing secure store for keys, secrets, certificates and Application Configuration 
    - Utilize [App Configuration](/azure/architecture/solution-ideas/articles/appconfig-key-vault) to share common configuration values between applications, microservices, and serverless applications that are not passwords, secrets, or keys.
    - Utilize [Azure Key Vault](/azure/key-vault/general/overview). It provides secure storage of secrets, such as passwords, connection strings, keys, secrets and certificates. You can use Azure Key Vault to securely store your secrets and then access them from your Azure App Service application by App Service Managed identity. This way, you can keep your secrets safe and secure, while still being able to access them from your application when needed.


## Design recommendations

The following is a bulleted list of best practices that should be included in any deployment of App Service.

- If the App Service requires authentication:
  - If access to the entire app service needs to be restricted to authenticated users, disable anonymous access.
  - Use the [Easy Auth](/azure/app-service/overview-authentication-authorization) capabilities of App Services, instead of writing your own authentication and authorization code.
  - Use separate [application registrations](/azure/active-directory/develop/quickstart-register-app) for separate [slots](/azure/app-service/deploy-staging-slots) or environments.
  - If the App Service is intended for internal users only, use [client certificate authentication](/azure/app-service/deploy-staging-slots) for increased security.
  - If the App Service is intended for external users, utilize [Azure AD B2C](/azure/active-directory-b2c/overview) to authenticate to social accounts and Azure AD accounts.
- Use [Azure built-in roles](/azure/role-based-access-control/built-in-roles#web-plan-contributor) whenever possible. These roles are designed by Microsoft to provide a set of permissions that are commonly needed for specific scenarios, such as the "Reader" role for users who need read-only access, or the "Contributor" role for users who need to be able to create and manage resources.
    - If built-in roles don't meet your needs, you can create custom roles by combining the permissions from one or more built-in roles. This allows you to grant the exact set of permissions that your users need, while still following the principle of least privilege.
    - Monitor your App Service resources regularly to ensure that they are being used in accordance with your security policies. This will help to identify any unauthorized access or changes, and to take appropriate action.
- Use the principle of least privilege when assigning permissions to users, groups, and services. This means granting only the minimum permissions that are required to perform the task at hand, and no more. This will help to reduce the risk of accidental or malicious changes to your resources.
- Utilize system-assigned [managed identities](/azure/app-service/overview-managed-identity?tabs=dotnet) to securely access AAD-protected backend resources. This allows you to control which resources the app service has access to and what permissions it has for those resources.
- For automated deployment purposes, set up a [service principal](/azure/active-directory/develop/app-objects-and-service-principals) that has the minimum required permissions to deploy from the CI/CD pipeline.
- Enable diagnostic logging "AppServiceHTTPLogs" access logs for Azure App Service. This will provide detailed logs that can be used to diagnose issues with your app and monitor access request, in addition to Azure Monitor activity log that provides insight into subscription-level events.
- Review and follow the recommendations outlined in the [Identity and Access Control section](/security/benchmark/azure/baselines/app-service-security-baseline?toc=/azure/app-service/toc.json#identity-and-access-control) of the Azure security baseline for App Service.

Overall, the goal of identity and access management for the landing zone accelerator is to ensure that the deployed app and its associated resources are secure and can be accessed only by authorized users. This can help protect sensitive data and prevent unauthorized access or misuse of the app and its resources.
