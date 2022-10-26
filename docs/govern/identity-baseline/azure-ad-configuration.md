---
title: Azure Active Directory configuration governance guidance
description: This article provides guidance on the architecture and configuration of Azure Active Directory regarding identity governance.
author: RobBagby
ms.author: robbag
ms.date: 10/26/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Azure Active Directory configuration

The architecture and configuration of Microsoft Azure Active Directory (Azure AD) is a key element in identity governance in the Azure cloud.  Azure AD is Azure's identity and authentication management service, and it acts as the foundation for other practices.

This article provides guidance about using Azure AD as the centralized identity and authentication system for your applications. The article provides suggested configurations and guidance on enforcing and auditing those configurations.

## Guidance - Centralized identity and authentication system

- Standardize on Azure AD as the central identity platform.
- Use Azure AD for authentication for new applications.
- Build a roadmap to migrate existing applications to Azure AD for authentication.
- Use Azure AD single sign-on for third party applications for centralized authentication.

## Enforce - Centralized identity and authentication system

N/A

## Audit - Centralized identity and authentication system

Add a tag to virtual machines and Azure App Services called "IdentityProvider". Set the tag to the name of the identity provider. Use "AzureAD" for Azure AD,

Use an [Azure Resource Graph](/azure/governance/resource-graph/overview) query like the following to audit the state of identity providers for applications.

```bash
resources
| where tags.IdentityProvider != "AzureAD"
| extend IdentityProvider = tags.IdentityProvider
| extend ResourceOwner = tags.Owner
| project
    ResourceId = tolower(tostring(id)),
    IdentityProvider = tags.IdentityProvider,
    ResourceOwner = tags.Owner, 
    Location = tolower(location),
    ResourceGroup = resourceGroup,
    SubscriptionId = subscriptionId
```

Maintain a configuration management database (CMDB) for applications and review it quarterly. Meet with application owners of applications still in migration to review timeline and requirements. The CMDB should contain the following information about each application:

- Application owner
- Uses Azure AD or Azure AD single sign-on?
- If not:
  - Migration date
  - Migration steps

## Guidance - Default User Permissions

Restrict default user permissions to remove unneeded access granted in default settings.

- Configure Azure AD to prevent users from being able to register applications.
- Restrict access to the Azure AD administration portal.
- Don't allow users to connect their user accounts to LinkedIn.
- Reduce collaboration settings to ensure:
  - Only authorized users can grant guest access.
  - Guests have limited visibility in to the environment.
  - Guest invitations can only be sent to specific, pre-approved domain.

## Enforce - Default User Permissions

TODO: Should we suggest the use of [authorization policies](https://learn.microsoft.com/graph/api/resources/authorizationpolicy?view=graph-rest-1.0) for enforcement?

Configure the following Azure AD user settings:

- Set [Users can register applications](/azure/active-directory/roles/delegate-app-roles#restrict-who-can-create-applications) to No.
- Set [default Azure Active Directory](/azure/active-directory/fundamentals/users-default-permissions) user permission **Restrict access to Azure AD administration portal** to Yes.
- Set [LinkedIn account connections](/azure/active-directory/enterprise-users/linkedin-integration#enable-linkedin-account-connections-in-the-azure-portal) to No.
- [Configure external collaboration settings](/azure/active-directory/external-identities/external-collaboration-settings-configure) to:
  - Set **Guest user access restrictions** to **Guest user access is restricted to properties of memberships of their own directory objects (most restrictive)**.
  - Set **Guest invite restrictions** to **Only users assigned to specific admin roles can invite guest users**.
  - Set **Collaboration Restrictions** to **Allow invitations only to the specified domains (most restrictive)**.
  - Select the domains that you'll allow collaboration with.

## Audit - Default User Permissions

TODO: Is there an automated way to review user settings in Azure AD? Graph query?

## Guidance - password management

Enable self-service password reset and don't expire passwords. Enabling self-service eases the management of passwords. Expiring passwords leads users to creating weak and predictable passwords.

## Enforce - password management

- Enable [Azure Active Directory self-service password reset](/azure/active-directory/authentication/tutorial-enable-sspr)
- TODO: Validate whether we should suggest the following guidance: Use [Azure Active Directory password policies](/azure/active-directory/authentication/concept-sspr-policy) to ensure password expiry is false.

## Audit - password management

Use the following Azure PowerShell code to audit the password expiry state.

```powershell
$auditFolder = "./AuditResults"
$date = get-Date -Format "yyyy-MM-dd-HH-mm-ss"
$auditPath = $auditFolder + '-' + $date
New-Item -Path $auditPath -ItemType Directory
$passwordExpyAudit = $auditPath + "/password-expiration.csv"
Get-MGUser -All | Select-Object UserPrincipalName, @{N="PasswordNeverExpires";E={$_.PasswordPolicies -contains "DisablePasswordExpiration"}} | export-csv -path  $passwordExpyAudit
```

## Guidance - legacy authentication

Disable legacy authentication to limit exposure to attacks. Many legacy authentication systems don't enforce multifactor authentication.

## Enforce - legacy authentication

Follow the guidance in [Directly blocking legacy authentication](/azure/active-directory/conditional-access/block-legacy-authentication#directly-blocking-legacy-authentication) to create a conditional access policy to block legacy authentication.

## Audit - legacy authentication

TODO: Should we suggest creating an alert for changes to Conditional Access Policies such as the following query suggested in [geeksforgeeks blog post](https://www.geeksforgeeks.org/microsoft-azure-create-alert-for-conditional-access-policy-changes/):

```bash
AuditLogs
| where Category == "Policy" and LoggedByService == "Conditional Access"
| project ActivityDateTime, InitiatedBy.user.userPrincipalName, TargetResources[0].displayName, ActivityDisplayName
```

TODO: Should we include guidance from sources like:

[Troubleshooting Conditional Access policy changes](/azure/active-directory/conditional-access/troubleshoot-policy-changes-audit-log)

## Guidance - sign-in and user risk policies

Enable sign in and user risk policies to enable you to measure and review risk scenarios.

- Follow the [guidance to configure and enable risk policies](/azure/active-directory/identity-protection/howto-identity-protection-configure-risk-policies)
- Configure the user risk policy to:
  - Require a secure password reset when user risk level is High
  - Require Azure AD MFA before the user can create a new password with Self-Service Password Reset to remediate their risk.
- Configure the sign-in risk policy to require Azure AD multifactor authentication when sign-in risk level is medium or high.

## Enforce - sign in and user risk policies

N/A

## Audit - sign in and user risk policies

- Audit [user risk](/azure/active-directory/identity-protection/howto-identity-protection-investigate-risk#risky-users) every three months.
- Use the [investigation framework](/azure/active-directory/identity-protection/howto-identity-protection-investigate-risk#investigation-framework) to investigate users that have had risks, and the details about the detections and risk history.
