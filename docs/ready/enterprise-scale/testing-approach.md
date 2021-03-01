---
title: Testing approach for Enterprise Scale
description: Testing approach for Enterprise Scale
author: jtracey93
ms.author: jatracey
ms.date: 01/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready 
ms.custom: think-tank
---

# Testing approach for Enterprise Scale

We recognize that large organizations may wish to test their Enterprise Scale deployments (Azure Policy definitions and assignments, RBAC custom roles and assignments, etc.) whether this is via automation (ARM Templates, AzOps, Terraform etc.) or manually via the portal. This article will provide a suggested approach that can be taken to achieve the testing of changes and their impact in Enterprise Scale deployments.

## Reasons To Not Use Separate Azure AD Tenants for Enterprise Scale

- As per the [Cloud Adoption Framework Azure Best Practices - "Standardize on a single directory and identity"](../../security/security-top-10#9-architecture-standardize-on-a-single-directory-and-identity) guidance
- Increased/Duplicated Azure AD licensing costs due to multiple identities across different Azure AD Tenants.
- Azure Policy & RBAC testing is not as accurate due to most parameters requiring to be changed between different Azure AD Tenants
  - This also increases chances of the testing not actually benefitting the deployment process due to potential for increased deployment failures.
- Single Tenant approach:
  - Allows for a single break-glass/emergency access process for all environments
  - Reduces complexity
  - Reduces chances for configuration drift
  - Reduces time to make changes and to deploy into production

## Diagram 

![Diagram that shows management group hierarchy.](./media/canary-mgmt-groups.png)

_Figure 1: Canary Management Group hierarchy._

## Explanation

As the above diagram shows, the entire "production" Management Group hierarchy is duplicated beneath the ```Tenant Root Group``` and the "canary" name is appended to the Management Group display names (this can also be done for the Management Group IDs, as they must be unique within the Tenant).

>[!NOTE] The term "canary" is used to avoid confusion with development or test environments. 

The "canary" Management Group hierarchy is then used to test the following resource types:

- Management Groups
- RBAC
  - Roles
  - Assignments
- Azure Policy
  - Definitions
  - Initiatives 
  - Assignments

>[!IMPORTANT]This is not for development or test environments that would be used by application/service owners; these are handled within the "production" Management Group hierarchy and associated governance (RBAC & Azure Policy).

## Implementation Guidance

Below is some guidance on how to implement and use the "canary" Management Group hierarchy for Enterprise Scale:

1. Use separate Azure AD SPNs or MSIs that are granted permissions over the relevant "production" or "canary" Management Group hierarchy
   - This follows the principle of least privilege (PoLP)
2. Use separate git branches or repositories to hold the Infrastructure-as-Code for the "production" and "canary" Management Group hierarchies and their associated RBAC & Azure Policies.
   - Using the relevant Azure AD SPN or MSI as part of the CI/CD pipelines depending on which hierarchy is being deployed to
