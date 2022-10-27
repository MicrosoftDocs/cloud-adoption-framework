---
title: Application access governance guidance
description: This article provides guidance on managing application access management and auditing guidance.
author: RobBagby
ms.author: robbag
ms.date: 10/26/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

TODO: This article seems light on the overview, guidance and audit guidance.

# Application access governance

In addition to user access, application identities are a critical part of workloads operating in Azure.  Providing governance for these identities is vital for deploying workloads in a secure and scalable fashion.

## Guidance - Centralize Application Identities on Azure AD

While migrated workloads might continue to use Active Directory identities, or existing identity platforms such as custom LDAP directories, modernization of these workloads should leverage Azure AD.

Centralizing application identity management with Azure AD provides a unified solution that improves security, reduces cost, and helps ensure compliance.

## Enforce - Centralize Application Identities on Azure AD

Follow the guidance in [Five steps for integrating all your apps with Azure AD](/azure/active-directory/fundamentals/five-steps-to-full-application-integration-with-azure-ad) for establishing processes to modernize applications to use Azure AD.

Follow the guidance in [govern access for applications in your environment](/azure/active-directory/governance/identity-governance-applications-prepare).

## Audit - Centralize Application Identities on Azure AD

See the audit for [Centralized identity and authentication systems](azure-ad-configuration.md#audit---centralized-identity-and-authentication-system) for audit mechanisms.

Resources should be flagged as being centralized in Azure AD if they are using either Managed Identities or Service Principals, below.

## Guidance - Use Managed Identities

[Managed Identities](azure/active-directory/managed-identities-azure-resources/overview) provide a way for Azure to manage secrets without having to manage credentials for Azure services.  By using managed identities, you can enable services to have an identity object distinct from users, and receive Azure AD tokens without needing to manage credentials.

Applications made up of Azure services should use managed identities instead of service accounts or other identity records.

## Enforce - Use Managed Identities

Each Azure resource type has its own guidance for using managed identities for it.  See the [Managed Identity How-to Guides](azure/active-directory/managed-identities-azure-resources/qs-configure-portal-windows-vm) for instructions on how to deploy and managed identities

## Audit - Use Managed Identities

Use Azure Activity Logs to review activities for managed identities, following the guide for [View managed identity activity](azure/active-directory/managed-identities-azure-resources/how-to-view-managed-identity-activity).

Create an alert to generate when a new managed identity is created or assigned a new role, so that you are able to have visibility to access adds.

To audit alignment of applications to Azure AD, refer to the [audit guidance above](#audit---centralize-application-identities-on-azure-ad).

## Guidance - Use Service Principals

[Service Principals](azure/active-directory/develop/app-objects-and-service-principals) provide a way to provide a non-user identity to applications.  These applications can be outside of Azure, or be used to assign access to managed identities or user objects.  By using this option instead of user objects, you can govern application identities with less effort.

Applications that are not able to use managed identities should use app registration/service principals for their access.  Where possible, these service principals should use certificates for authentication instead of passwords.

## Enforce - Use Service Principals

To create a service principal with a certificate, follow [these instructions](azure/create-azure-service-principal-azureps?view=azps-9.1.0).  These instructions provide methods for deploying service principals in a variety of configuration.

## Audit - Use Service Principals

To audit alignment of applications to Azure AD, refer to the [audit guidance above](#audit---centralize-application-identities-on-azure-ad).
