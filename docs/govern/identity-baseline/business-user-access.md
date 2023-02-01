---
title: Business user access governance guidance
description: This article provides guidance to minimize the risk of business users accessing applications along with auditing guidance.
author: RobBagby
ms.author: robbag
ms.date: 10/26/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Business user access

Risks related to governing business users are largely related to the complexity of your organization's identity infrastructure. If all your users and groups are managed using a single directory or cloud-native identity provider using minimal integration with other services, your risk level will likely be small. As a result, following the [Azure AD Configuration Baseline](azure-ad-configuration.md) will address many of your core user risks.

The following sections provide additional guidance, and auditing that can be used to manage business user accounts.

## Guidance

Implement the following to improve the management of your user accounts:

- Use Azure Active Directory security groups to assign access to users.  Don't assign access directly to users.
- Assign an owner to every Azure AD security group.  This owner is responsible for the access granted to the group. Follow [these instructions for adding owners to a group](/azure/active-directory/fundamentals/how-to-manage-groups).
- Use [Self-Service group management](/azure/active-directory/enterprise-users/groups-self-service-management) to allow owners to control access to the groups.
- Perform a periodic review of membership of every security group, and remove unneeded access.  Use an [Azure Active Directory Access Review](/azure/active-directory/governance/create-access-review) to manage the process.
- Don't use mail-enabled security groups, because they're read-only from the Graph API.
- Periodically perform a review of inactive accounts, and take steps to review.

## Audit

Perform the following audits quarterly to verify that business user access is being managed.

### Audit owners

Use a [Microsoft Graph Query](/graph/api/authorizationpolicy-get) API call like the following to audit if groups have owners.

```http
GET https://graph.microsoft.com/v1.0/groups
```

If a specific group in the return has the **owners** relationship object set to `null`, then the group is missing an owner.

### Audit group access review

Use a [Microsoft Graph Query](/graph/api/authorizationpolicy-get) API call like the following to create an access review schedule.

```http
POST https://graph.microsoft.com/v1.0/identityGovernance/accessReviews/definitions
Content-type: application/json
{
  "displayName": "Test create",
  "descriptionForAdmins": "New scheduled access review",
  "descriptionForReviewers": "If you have any questions, contact jerry@contoso.com",
  "scope": {
    "@odata.type": "#microsoft.graph.accessReviewQueryScope",
    "query": "/groups/02f3bafb-448c-487c-88c2-5fd65ce49a41/transitiveMembers",
    "queryType": "MicrosoftGraph"
  },
  "reviewers": [
    {
      "query": "/users/398164b1-5196-49dd-ada2-364b49f99b27",
      "queryType": "MicrosoftGraph"
    }
  ],  
  "settings": {
    "mailNotificationsEnabled": true,
    "reminderNotificationsEnabled": true,
    "justificationRequiredOnApproval": true,
    "defaultDecisionEnabled": false,
    "defaultDecision": "None",
    "instanceDurationInDays": 7,
    "recommendationsEnabled": true,
    "recurrence": {
      "pattern": {
        "type": "weekly",
        "interval": 4
      },
      "range": {
        "type": "noEnd",
        "startDate": "2020-09-08T12:02:30.667Z"
      }
    }
  }
}
```

Customize the code block attributes to match the scope that you want to create, such as by specifying the name of the access review, the targeted group, and the reviewers.

Learn more about how to [automate access reviews](/graph/api/resources/accessreviewsv2-overview)

### Audit inactive accounts

Use a [Microsoft Graph Query](/graph/api/authorizationpolicy-get) API call like the following to audit inactive users.

```http
GET https://graph.microsoft.com/beta/users?filter=signInActivity/lastSignInDateTime le 2019-06-01T00:00:00Z
```

Replace the data in this API call to be 30 days before your current time.  Any returned accounts won't have logged in for 30 days, and require more investigation.
