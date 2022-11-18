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

# Application access governance

In addition to user access, application identities are a critical part of workloads operating in Azure.  Providing governance for these identities is vital for deploying workloads in a secure and scalable fashion.

## Guidance - Centralize Application Identities on Azure AD

While migrated workloads may continue to use Active Directory identities, or existing identity platforms such as custom LDAP directories, modernization of these workloads should leverage Azure AD.

Centralizing application identity management with Azure AD provides a unified solution that improves security, reduces cost, and helps ensure compliance.

## Enforce - Centralize Application Identities on Azure AD

Follow the guidance in [Five steps for integrating all your apps with Azure AD](/azure/active-directory/fundamentals/five-steps-to-full-application-integration-with-azure-ad) for establishing processes to modernize applications to use Azure AD.

Follow the guidance in [govern access for applications in your environment](/azure/active-directory/governance/identity-governance-applications-prepare).

## Audit

See the audit for [Centralized identity and authentication systems](azure-ad-configuration.md#audit---centralized-identity-and-authentication-system) for audit mechanisms.

## Guidance - Use Managed Identities

...

## Enforce - Use Managed Identities

...

## Audit - Use Managed Identities

...

## Guidance - Use Service Principles with Certificates

...

## Enforce - Use Service Principles with Certificates

...

## Audit - Use Service Principles with Certificates

...
