---
title: Administrative access governance guidance
description: This article provides an overview of the suggested identity management tools capabilities and features for user management along with guidance on processes and policies to support user management in your organization. 
author: RobBagby
ms.author: robbag
ms.date: 10/26/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Administrative access

Identity management tools offer capabilities and features that greatly assist user management and access control within a cloud deployment. They also require well-considered processes and policies to support your organization's goals.  The following sections provide guidance, controls, and auditing that can be used.

## Guidance

- Implement two [emergency access accounts](/azure/active-directory/roles/security-emergency-access#store-account-credentials-safely) (sometimes called break glass accounts) that can be used to access the environment in emergency scenarios when normal accounts can't be used.
- Assign at least two users as global administrators to avoid lockout scenarios when an administrator leaves the company or is locked out.
- Consider the guidance in [Security Control: Identity management](/security/benchmark/azure/mcsb-identity-management)
- Use Privileged Identity Management to provide just in time access when privileged access is required.

To manage Privileged Identity Management, follow these steps:

1. Open Azure AD Privileged Identity Management in the Azure portal.
1. Choose **Azure AD Roles**.
1. Select the Role you wish to modify.
1. Select **Settings** and then **Edit**. Edit the following settings:

   - Set **Activation maximum duration (hours)** to be between 30 minutes to 24 hours based on the duration of tasks with that role.
   - Check the **Require justification on activation** checkbox.
   - Check the **Require ticket information on activation** checkbox.
   - Check the **Require approval to activate** checkbox if the role is not used daily.
   - Under the **Assignment** tab, choose whether you want **Allow permanent eligible assignment** to be yes or no and whether you want to set the assignment to expire, thereby forcing audits on specific roles.
   - Under the **Notification** tab, configure an alert to send to a notification list when eligible members activate the role.

## Audit

- Perform access test for break glass accounts monthly.
- [Monitor sign-in and audit log activity](/azure/active-directory/roles/security-emergency-access#monitor-sign-in-and-audit-logs) from the break glass accounts and trigger notifications to other administrators.
- Find users in Roles with [Discovery and Insights (preview) for Azure AD roles](/azure/active-directory/privileged-identity-management/pim-security-wizard) and set up security reviews quarterly.
- [Plan an Azure Active Directory access review](/azure/active-directory/governance/deploy-access-reviews) quarterly.
