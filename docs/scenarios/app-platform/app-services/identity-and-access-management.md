---
title: Identity and access management considerations for the App Service landing zone accelerator
description: Learn about design considerations and recommendations for identity and access management in the Azure App Service landing zone accelerator.
author: motasem13
ms.author: mohamad
ms.date: 01/06/2023
ms.topic: conceptual
ms.custom: internal
---

# Identity and access management considerations for the App Service landing zone accelerator

This article provides design considerations and recommendations for identity and access management that you can apply when you use the Azure App Service landing zone accelerator. Authentication and app configuration are some of the considerations that this article discusses.

Learn more about the [identity and access management](../../../ready/landing-zone/design-area/identity-access.md) design area.

## Design considerations

When you use the landing zone accelerator to deploy an App Service solution, there are some key considerations for key identity and access management:

- Determine the level of security and isolation required for the app and its data. Public access allows anyone with the app URL to access the app, while private access restricts access to only authorized users and networks.
- Determine the type of authentication and authorization needed for your App Service solution: anonymous, internal corporate users, social accounts, other [identity provider](/azure/app-service/overview-managed-identity), or a combination of these types.
- Determine whether to use system-assigned or user-assigned [managed identities](/azure/app-service/overview-managed-identity) when your App Service solution connects to back-end resources that are protected by Microsoft Entra ID.
- Consider creating [custom roles](/entra/identity/role-based-access-control/custom-create), following the principle of least privilege when out-of-box roles require modifications to existing permissions.
- Choose enhanced-security storage for keys, secrets, certificates, and application configuration.
    - Use [app configuration](/azure/architecture/solution-ideas/articles/appconfig-key-vault) to share common configuration values that aren't passwords, secrets, or keys between applications, microservices, and serverless applications.
    - Use [Azure Key Vault](/azure/key-vault/general/overview). It provides enhanced-security storage of passwords, connection strings, keys, secrets, and certificates. You can use Key Vault to store your secrets and then access them from your App Service application via App Service managed identity. By doing so, you can help keep your secrets secure while still providing access to them from your application as needed.

## Design recommendations

You should incorporate the following best practices into your App Service deployments:

- If the App Service solution requires authentication:
  - If access to the entire App Service solution needs to be restricted to authenticated users, disable anonymous access.
  - Use the [built-in authentication and authorization](/azure/app-service/overview-authentication-authorization) capabilities of App Service instead of writing your own authentication and authorization code.
  - Use separate [application registrations](/entra/identity-platform/quickstart-register-app) for separate [slots](/azure/app-service/deploy-staging-slots) or environments.
  - If the App Service solution is intended for internal users only, use [client certificate authentication](/azure/app-service/deploy-staging-slots) for increased security.
  - If the App Service solution is intended for external users, use [Azure AD B2C](/azure/active-directory-b2c/overview) to authenticate to social accounts and Microsoft Entra accounts.
- Use [Azure built-in roles](/azure/role-based-access-control/built-in-roles#web-plan-contributor) whenever possible. These roles are designed to provide a set of permissions that are commonly needed for specific scenarios, like the Reader role for users who need read-only access and the Contributor role for users who need to be able to create and manage resources.
    - If built-in roles don't meet your needs, you can create custom roles by combining the permissions from one or more built-in roles. By doing so, you can grant the exact set of permissions that your users need while still following the principle of least privilege.
    - Monitor your App Service resources regularly to ensure that they're being used in accordance with your security policies. Doing so can help you identify any unauthorized access or changes and take appropriate actions.
- Use the principle of least privilege when you assign permissions to users, groups, and services. This principle states that you should grant only the minimum permissions that are required to perform the specific task, and no more. Following this guidance can help you reduce the risk of accidental or malicious changes to your resources.
- Use system-assigned [managed identities](/azure/app-service/overview-managed-identity) to access, with enhanced security, back-end resources that are protected by Microsoft Entra ID. Doing so allows you to control which resources the App Service solution has access to and what permissions it has for those resources.
- For automated deployment, set up a [service principal](/entra/identity-platform/app-objects-and-service-principals) that has the minimum required permissions to deploy from the CI/CD pipeline.
- Enable diagnostic logging AppServiceHTTPLogs access logs for App Service. You can use these detailed logs to diagnose problems with your app and monitor access requests. Enabling these logs also provides an Azure Monitor activity log that gives you insight into subscription-level events.
- Follow the recommendations outlined in the [Identity management](/security/benchmark/azure/baselines/app-service-security-baseline?toc=/azure/app-service/toc.json#identity-management) and [Privileged access](/security/benchmark/azure/baselines/app-service-security-baseline?toc=/azure/app-service/toc.json#privileged-access) sections of the Azure security baseline for App Service.

The goal of identity and access management for the landing zone accelerator is to help ensure that the deployed app and its associated resources are secure and can be accessed only by authorized users. Doing so can help you protect sensitive data and prevent misuse of the app and its resources.
