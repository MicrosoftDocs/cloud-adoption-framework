---
title: Application access governance guidance
description: This article provides guidance on managing application access management and auditing guidance.
author: brsteph
ms.author: bstephenson
ms.date: 10/26/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Application access governance

Application identities are a critical part of workloads operating in Azure. This document provides guidance on implementing governance for application entities to ensure these identities are provisioned in a secure and scalable fashion.

## Guidance

- While migrated workloads might continue to use Active Directory identities, or existing identity platforms such as custom LDAP directories, modernization of these workloads should use Azure AD. Centralizing application identity management with Azure AD provides a unified solution that improves security, reduces cost, and helps ensure compliance. Follow the guidance in [Five steps to integrate your applications with Azure AD](/azure/active-directory/fundamentals/five-steps-to-full-application-integration-with-azure-ad) for establishing processes that modernize applications to use Azure AD.
- Applications made up of Azure services should use [managed identities](/azure/active-directory/managed-identities-azure-resources/overview) instead of service accounts or other identity records. Managed identities provide a way for Azure to manage secrets without having to manage credentials for Azure services. By using managed identities, you can enable services to have an identity object distinct from users, and receive Azure AD tokens without needing to manage credentials. See the [managed identity how-to guides](/azure/active-directory/managed-identities-azure-resources/qs-configure-portal-windows-vm) for instructions on how to deploy and managed identities.
- Applications that aren't able to use managed identities should use a [service principal](/azure/active-directory/develop/app-objects-and-service-principals) for their access. Where possible, these service principals should use certificates for authentication instead of passwords. Service principals provide a way to provide a non-user identity to applications. These applications can be outside of Azure, or be used to assign access to managed identities or user objects. By using this option instead of user objects, you can govern application identities with less effort. To create a service principal with a certificate, follow [these instructions](/powershell/azure/create-azure-service-principal-azureps).

## Enforce

Follow the guidance in [Govern access for applications in your environment](/azure/active-directory/governance/identity-governance-applications-prepare) to ensure that the right people and applications have access to the right resources.

## Audit

- Follow the guidance in [Audit centralized identity and authentication systems](azure-ad-configuration.md#audit---centralized-identity-and-authentication-system).
- Set the `IdentityProvider` tag to `AzureAD`. Tag applications if they're using either managed identities or service principals.
- Use Azure activity logs to review activities for managed identities, following the guidance in [View managed identity activity](/azure/active-directory/managed-identities-azure-resources/how-to-view-managed-identity-activity).
- Create an alert to generate when a new managed identity is created or assigned a new role, so that you're able to have visibility to access adds.
