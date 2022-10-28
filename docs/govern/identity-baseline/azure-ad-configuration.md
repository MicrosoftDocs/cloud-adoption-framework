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

This article recommends using Azure AD as the centralized identity and authentication system for your applications. The article provides suggested configurations and guidance on enforcing and auditing those configurations.

| Guidance | Enforce | Audit | Description |
| --- | --- | ---| --- |
| [Centralized identity and authentication](#guidance---centralized-identity-and-authentication-system) | - | [audit](#enforce---centralized-identity-and-authentication-system) | - |
| [Default user permissions](#guidance---default-user-permissions) | [enforce](#enforce---default-user-permissions) | [audit](#enforce---default-user-permissions) | - |
| [Password management](#guidance---password-management) | [enforce](#enforce---password-management) | [audit](#enforce---password-management) | - |
| [Legacy authentication](#guidance---legacy-authentication) | [enforce](#enforce---legacy-authentication) | [audit](#enforce---legacy-authentication) | - |
| [Sign-in and user risk policies](#guidance---sign-in-and-user-risk-policies) | - | [audit](#enforce---sign-in-and-user-risk-policies) | - |

## Guidance - Centralized identity and authentication system

Standardize on Azure AD as your organization's identity and authentication platform for Microsoft cloud resources, application, and organizational identities. In addition, you should synchronize Windows Server Active Directory identities to Azure AD to ensure centralized management.

- Standardize on Azure AD as the central identity platform.
- Use Azure AD for authentication for new applications.
- Build a roadmap to migrate existing applications to Azure AD for authentication.
- Use Azure AD single sign-on for third party applications for centralized authentication.

## Enforce - Centralized identity and authentication system

Due to the nature of identity authentication in workloads, there is no comprehensive option to enforce the identity system used by a given system.  However, one option is to tag resources based on the identity system in use.

By assigning the [Append a tag and its value to resources](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F2a0e14a6-b0a6-4fab-991a-187a4f81c498) Azure Policy, you can specify behavior for if a tag is not provided on resources in the policy's assignment scope.

![Tag Policy GUI](./media/Tagpolicy.png)

By assigning it with the with the tag name of "IdentityProvider" and tag value of "Undefined", you will create the following behavior:

- If a tag for IdentityProvider is added, it will be used.
- Otherwise, it will be marked as Undefined.

Resources that use Azure AD as the centralized identity system should be tagged with AzureAD.  All others should be reviewed and defined.

## Audit - Centralized identity and authentication system

Use an [Azure Resource Graph](/azure/governance/resource-graph/overview) query like the following to audit the state of identity providers for applications, such as those using Application Services or Virtual Machines.

```bash
resources
| where type == "Microsoft.Compute/virtualMachines" or type contains "Microsoft.Web/sites"
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

## Guidance - Default user permissions

Restrict default user permissions to remove unneeded access granted in default settings.

- Configure Azure AD to prevent users from being able to register applications.
- Restrict access to the Azure AD administration portal.
- Don't allow users to connect their user accounts to LinkedIn.
- Reduce collaboration settings to ensure:
  - Only authorized users can grant guest access.
  - Guests have limited visibility in to the environment.
  - Guest invitations can only be sent to specific, pre-approved domain.

## Enforce - Default user permissions

>Below needs to be QCed from the email discussion.

You can update the Authorization Policy to enforce these settings via the Microsoft Graph REST API with the following [authorizationPolicy](https://learn.microsoft.com/en-us/graph/api/resources/authorizationpolicy?view=graph-rest-1.0):

``` json
{
  "id": "String (identifier)",
  "description": "String",
  "displayName": "String",
  "blockMsolPowerShell": true,
  "defaultUserRolePermissions": {
      "allowedToCreateApps": false,
      "allowedToCreateSecurityGroups": false,
      "allowedToReadOtherUsers": false,
      "permissionGrantPoliciesAssigned": []
},
  "allowedToUseSSPR": true,
  "allowedToSignUpEmailBasedSubscriptions": true,
  "allowEmailVerifiedUsersToJoinOrganization": true,
  "allowInvitesFrom": "adminsAndGuestInviters",
  "guestUserRoleId": "Guid"
}
```

Alternatively you can configure the following Azure AD user settings from the portal:

- Set [Users can register applications](/azure/active-directory/roles/delegate-app-roles#restrict-who-can-create-applications) to No.
- Set [default Azure Active Directory](/azure/active-directory/fundamentals/users-default-permissions) user permission **Restrict access to Azure AD administration portal** to Yes.
- Set [LinkedIn account connections](/azure/active-directory/enterprise-users/linkedin-integration#enable-linkedin-account-connections-in-the-azure-portal) to No.
- [Configure external collaboration settings](/azure/active-directory/external-identities/external-collaboration-settings-configure) to:
  - Set **Guest user access restrictions** to **Guest user access is restricted to properties of memberships of their own directory objects (most restrictive)**.
  - Set **Guest invite restrictions** to **Only users assigned to specific admin roles can invite guest users**.
  - Set **Collaboration Restrictions** to **Allow invitations only to the specified domains (most restrictive)**.
  - Select the domains that you'll allow collaboration with.

## Audit - Default user permissions

Use an [Microsoft Graph Query](https://learn.microsoft.com/graph/api/authorizationpolicy-get?view=graph-rest-1.0) API call like the following to audit the default user settings.

```http
GET https://graph.microsoft.com/v1.0/policies/authorizationPolicy
```

Then confirm the settings of specific items in the response:

```http
    "allowInvitesFrom": "adminsAndGuestInviters",
```

```http

    "defaultUserRolePermissions": {
        "allowedToCreateApps": false,
        "allowedToCreateSecurityGroups": true,
        "allowedToReadOtherUsers": false,
        "permissionGrantPoliciesAssigned": []
    }

```

Alternatively, you can review the user permissions by checking the portal configuration above.

## Guidance - Password management

Central management of password reset causes a management burden and can lead users to delay updating passwords. Expiring passwords leads users to creating weak and predictable passwords.

- Enable self-service password reset.
- Don't expire passwords.

## Enforce - Password management

- Enable [Azure Active Directory self-service password reset](/azure/active-directory/authentication/tutorial-enable-sspr).
- Set passwords not to expire through the [Password Expiration Policy](https://learn.microsoft.com/microsoft-365/admin/manage/set-password-expiration-policy?source=recommendations&view=o365-worldwide):
    - 	Navigate to: Setup - Microsoft 365 admin center
    - Select Set passwords to never expire
    - Select Get Started and follow the wizard's instructions.

> TODO: Validate whether we should suggest the following guidance: Use [Azure Active Directory password policies](/azure/active-directory/authentication/concept-sspr-policy) to ensure password expiry is false.  
> FINDING: The Password Policies determine the contents of the password, but the Expiration policy appears to be a different setting.
> We can still plan for if we want to give a default password complexity policy.

## Audit - Password management

Use an [Microsoft Graph Query](https://learn.microsoft.com/graph/api/authorizationpolicy-get?view=graph-rest-1.0) API call like the following to audit the default user settings.

```http
GET https://graph.microsoft.com/v1.0/users?$select=userPrincipalName,lastPasswordChangeDateTime,passwordPolicies
```

The resulting `passwordPolicies` setting should be set to "DisablePasswordExpiration"

Use can also use the following Graph PowerShell code to audit the password expiry state and export to a CSV:

```powershell
$auditFolder = "./AuditResults"
$date = get-Date -Format "yyyy-MM-dd-HH-mm-ss"
$auditPath = $auditFolder + '-' + $date
New-Item -Path $auditPath -ItemType Directory
$passwordExpyAudit = $auditPath + "/password-expiration.csv"
Get-MGUser -All | Select-Object UserPrincipalName, @{N="PasswordNeverExpires";E={$_.PasswordPolicies -contains "DisablePasswordExpiration"}} | export-csv -path  $passwordExpyAudit
```

## Guidance - Legacy authentication

Legacy authentication doesn't support multifactor authentication (MFA). MFA improves the security posture in organizations.

- Determine if your organization currently supports legacy authentication.
- Disable legacy authentication to limit exposure to attacks.

## Enforce - Legacy authentication

- [Identify legacy authentication use](/azure/active-directory/conditional-access/block-legacy-authentication#identify-legacy-authentication-use)
- Follow the guidance in [Directly blocking legacy authentication](/azure/active-directory/conditional-access/block-legacy-authentication#directly-blocking-legacy-authentication) to create a conditional access policy to block legacy authentication.

## Audit - Legacy authentication

>TODO: Should we suggest creating an alert for changes to Conditional Access Policies such as the following query suggested in [geeksforgeeks blog post](https://www.geeksforgeeks.org/microsoft-azure-create-alert-for-conditional-access-policy-changes/):

```bash
AuditLogs
| where Category == "Policy" and LoggedByService == "Conditional Access"
| project ActivityDateTime, InitiatedBy.user.userPrincipalName, TargetResources[0].displayName, ActivityDisplayName
```

> TODO: Should we include guidance from sources like:

> [Troubleshooting Conditional Access policy changes](/azure/active-directory/conditional-access/troubleshoot-policy-changes-audit-log)

> I think it makes sense to include it in an additional resource below, but I'm not sure the best way.

## Guidance - Sign-in and user risk policies

Enable sign-in and user risk policies to enable you to measure and review risk scenarios. These policies can be configured to require MFA or a password reset for risky users.

- Follow the [guidance to configure and enable risk policies](/azure/active-directory/identity-protection/howto-identity-protection-configure-risk-policies)
- Configure the user risk policy to:
  - Require a secure password reset when user risk level is High
  - Require Azure AD MFA before the user can create a new password with Self-Service Password Reset to remediate their risk.
- Configure the sign-in risk policy to require Azure AD multifactor authentication when sign-in risk level is medium or high.

## Enforce - Sign-in and user risk policies

N/A

## Audit - Sign-in and user risk policies

Use the following resources to audit user risk and investigate past risky users.

- Audit [user risk](/azure/active-directory/identity-protection/howto-identity-protection-investigate-risk#risky-users) every three months.
- Use the [investigation framework](/azure/active-directory/identity-protection/howto-identity-protection-investigate-risk#investigation-framework) to investigate users that have had risks, and the details about the detections and risk history.
