---
title: Azure Active Directory configuration governance guidance
description: This article provides guidance on the architecture and configuration of Azure Active Directory regarding identity governance.
author: RobBagby
ms.author: robbag
ms.date: 10/26/2022
ms.topic: conceptual
ms.subservice: govern
ms.custom: internal, UpdateFrequency2
---

# Azure Active Directory configuration

The architecture and configuration of Microsoft Azure Active Directory (Azure AD) is a key element in identity governance in the Azure cloud.  Azure AD is Azure's identity and authentication management service, and it acts as the foundation for other practices.

This article recommends using Azure AD as the centralized identity and authentication system for your applications. The article provides suggested configurations and guidance on enforcing and auditing those configurations.

| Guidance | Enforce | Audit |
| --- | --- | ---|
| [Centralized identity and authentication](#guidance---centralized-identity-and-authentication-system) | [enforce](#enforce---centralized-identity-and-authentication-system) | [audit](#enforce---centralized-identity-and-authentication-system) |
| [Default user permissions](#guidance---default-user-permissions) | [enforce](#enforce---default-user-permissions) | [audit](#enforce---default-user-permissions) |
| [Password management](#guidance---password-management) | [enforce](#enforce---password-management) | [audit](#enforce---password-management) |
| [Legacy authentication](#guidance---legacy-authentication) | [enforce](#enforce---legacy-authentication) | [audit](#enforce---legacy-authentication) |
| [Sign-in and user risk policies](#guidance---sign-in-and-user-risk-policies) | [enforce](#enforce---sign-in-and-user-risk-policies) | [audit](#enforce---sign-in-and-user-risk-policies) |
| [Conditional access](#guidance---conditional-access) | [enforce](#enforce---conditional-access) | [audit](#audit---conditional-access)

## Guidance - Centralized identity and authentication system

Standardize on Azure AD as your organization's identity and authentication platform for Microsoft cloud resources, application, and organizational identities. In addition, you should synchronize Windows Server Active Directory identities to Azure AD to ensure centralized management.

- Standardize on Azure AD as the central identity platform.
- Use Azure AD for authentication for new applications.
- Build a roadmap to migrate existing applications to Azure AD for authentication.
- Use Azure AD single sign-on for third party applications for centralized authentication.

## Enforce - Centralized identity and authentication system

Due to the nature of identity authentication in workloads, there's no comprehensive option to enforce the use of a specific identity system.  However, one option is to ensure resources are tagged with the identity system in use.

Assign the [Append a tag and its value to resources](https://portal.azure.com/#view/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F2a0e14a6-b0a6-4fab-991a-187a4f81c498) Azure Policy with the tag name set to "IdentityProvider" and the tag value set to "Undefined". This policy will only set the tag value to be "Undefined" if the tag isn't provided.

:::image type="content" source="./media/tag-policy.png" alt-text="A picture of the portal page where you add a tag policy.":::

Resources that use Azure AD as the centralized identity system should be tagged with AzureAD.  All others should be reviewed and defined in the audit process.

## Audit - Centralized identity and authentication system

Use an [Azure Resource Graph](/azure/governance/resource-graph/overview) query like the following to audit the state of identity providers for applications, such as those using Microsoft Web Sites or Virtual Machines.

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

You should also maintain a configuration management database (CMDB) for applications and review it quarterly. Meet with application owners of applications still in migration to review timeline and requirements. The CMDB should contain the following information about each application:

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

### Graph API

Update the Authorization Policy to enforce the above settings via the Microsoft Graph REST API with the following [authorizationPolicy](/graph/api/resources/authorizationpolicy):

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

### Azure portal

- Set [Users can register applications](/azure/active-directory/roles/delegate-app-roles#restrict-who-can-create-applications) to No.
- Set [default Azure Active Directory](/azure/active-directory/fundamentals/users-default-permissions) user permission **Restrict access to Azure AD administration portal** to Yes.
- Set [LinkedIn account connections](/azure/active-directory/enterprise-users/linkedin-integration#enable-linkedin-account-connections-in-the-azure-portal) to No.
- [Configure external collaboration settings](/azure/active-directory/external-identities/external-collaboration-settings-configure) to:
  - Set **Guest user access restrictions** to **Guest user access is restricted to properties of memberships of their own directory objects (most restrictive)**.
  - Set **Guest invite restrictions** to **Only users assigned to specific admin roles can invite guest users**.
  - Set **Collaboration Restrictions** to **Allow invitations only to the specified domains (most restrictive)**.
  - Select the domains that you'll allow collaboration with.

## Audit - Default user permissions

Use an [Microsoft Graph Query](/graph/api/authorizationpolicy-get) API call like the following to audit the default user settings.

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
- Set passwords not to expire through the [Password Expiration Policy](/microsoft-365/admin/manage/set-password-expiration-policy?source=recommendations):
  - Navigate to: Setup - Microsoft 365 admin center
  - Select Set passwords to never expire
  - Select Get Started and follow the wizard's instructions.

## Audit - Password management

### Graph API to audit password expiration

Use a [Microsoft Graph Query](/graph/api/authorizationpolicy-get) API call like the following to audit password expiration.

```http
GET https://graph.microsoft.com/v1.0/users?$select=userPrincipalName,lastPasswordChangeDateTime,passwordPolicies
```

The resulting **passwordPolicies** setting should be set to "DisablePasswordExpiration".

### Graph API to audit if self-service password is enabled

Use a [Microsoft Graph Query](/graph/api/authorizationpolicy-get) API call like the following to audit if self-service password is enabled.

```http
GET /policies/authorizationPolicy
```

The resulting **allowedToUseSSPR** property should be set to "True".

### PowerShell to audit that passwords don't expire

Use the following script to produce a CSV file that contains an audit of whether user passwords are set to never expire.

```powershell
$auditPath = "./Audits/"

New-Item -Path $auditPath -ItemType Directory

$passwordExpyAudit = $auditPath + "/password-expiration" + "$date" + ".csv"

Get-MGUser -All | Select-Object UserPrincipalName, @{N="PasswordNeverExpires";E={$_.PasswordPolicies -contains "DisablePasswordExpiration"}} | export-csv -path  "$passwordExpyAudit"
```

### PowerShell to audit that self-service password reset is enabled

Use the following script to produce a CSV file that contains an audit of whether self-service password reset is enabled.

```powershell
$auditPath = "./Audits/"

New-Item -Path $auditPath -ItemType Directory

$passwordResetAudit = $auditPath + "/password-reset" + "$date" + ".csv"

Get-MgPolicyAuthorizationPolicy |  export-csv -path  "$passwordResetAudit"
```

## Guidance - Legacy authentication

Legacy authentication doesn't support multifactor authentication (MFA). MFA improves the security posture in organizations.

- Determine if your organization currently supports legacy authentication.
- Disable legacy authentication to limit exposure to attacks.

## Enforce - Legacy authentication

- [Identify legacy authentication use](/azure/active-directory/conditional-access/block-legacy-authentication#identify-legacy-authentication-use)
- Follow the guidance in [Directly blocking legacy authentication](/azure/active-directory/conditional-access/block-legacy-authentication#directly-blocking-legacy-authentication) to create a conditional access policy to block legacy authentication.

## Audit - Legacy authentication

Use the following Log Analytics query to audit conditional access policy changes.

```bash
AuditLogs
| where Category == "Policy" and LoggedByService == "Conditional Access"
| project ActivityDateTime, InitiatedBy.user.userPrincipalName, TargetResources[0].displayName, ActivityDisplayName
```

## Guidance - Sign-in and user risk policies

Enable sign-in and user risk policies to enable you to measure and review risk scenarios. These policies can be configured to require MFA or a password reset for risky users.

## Enforce - Sign-in and user risk policies

Follow the [guidance to configure and enable risk policies](/azure/active-directory/identity-protection/howto-identity-protection-configure-risk-policies):

- Configure the user risk policy to:
  - Require a secure password reset when user risk level is High
  - Require Azure AD MFA before the user can create a new password with Self-Service Password Reset to remediate their risk.
- Configure the sign-in risk policy to require Azure AD multifactor authentication when sign-in risk level is medium or high.

## Audit - Sign-in and user risk policies

Use the following resources to audit user risk and investigate past risky users.

- Audit [user risk](/azure/active-directory/identity-protection/howto-identity-protection-investigate-risk#risky-users) every three months.
- Use the [investigation framework](/azure/active-directory/identity-protection/howto-identity-protection-investigate-risk#investigation-framework) to investigate users that have had risks, and the details about the detections and risk history.

## Guidance - Conditional Access

Deploy conditional access policies to protect identities from compromise. Consider requiring specific access conditions, such as location and device security. Check for things like high-risk sign-in patterns or impossible travel.

## Enforce - Conditional Access

Review the lists of [Common Conditional Access policies](/azure/active-directory/conditional-access/howto-conditional-access-policy-admin-mfa) for recommended patterns.

In addition to the "Block legacy authentication" policy, above, it's recommended to implement:

- The MFA scenarios
- Require password change for risky users
- Require compliant or hybrid joined devices
- Block access for unknown or unsupported device platforms
- Block access by location
- Require authentication strength for external users

## Audit - Conditional Access

- To audit conditional access, use the Azure Active Directory Audit logs for policy changes.  The article [Troubleshooting Condition Access policy changes](/azure/active-directory/conditional-access/troubleshoot-policy-changes-audit-log) provides guidance for creating alerts to notify operators if a policy has been changed.
- Keep conditional access audit logs for 60 days to provide for a monthly audit cycle.
- To audit actual conditional access activities, use the method described in [Condition Access insights and reporting](/azure/active-directory/conditional-access/howto-conditional-access-insights-reporting)
