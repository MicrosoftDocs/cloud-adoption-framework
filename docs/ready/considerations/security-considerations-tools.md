---
title: Role-based Access Control for DevOps Tools
description: Security considerations for Role-based Access Controls in DevOps Tools for Landing Zones
author: sikovatc
ms.author: sikovatc
ms.date: 04/27/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Role-based Access Control for DevOps Tools

Security should always be your most important concern in when deploying cloud-based solutions for your infrastructure deployments.
Microsoft keeps the underlying cloud infrastructure secure, but it's up to you to configure security in Azure DevOps Services or GitHub.

## Pre-requisites

Once you've decided on which Azure Landing Zones templates to deploy, you'll need to clone them into your own repository and set up the CI/CD pipelines. For both GitHub and ADO (Azure DevOps), there are several authentication methods available, such as PAT tokens (personal access) or integrating with an identity provider, such as Azure Active Directory. For more information, see the article on [authenticating to Azure DevOps with Personal Access Tokens](/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate).

It's strongly recommended to integrate with Azure AD in order to leverage all its capabilities and help streamline your role assignment process and identity lifecycle management. Refer to the docs on [integrating Azure DevOps with your Azure Active Directory tenant](/azure/devops/organizations/accounts/connect-organization-to-azure-ad). If you're using GitHub, consider [integrating GitHub Enterprise with Azure AD](/azure/active-directory/saas-apps/github-enterprise-cloud-enterprise-account-tutorial).

## General Design Considerations
It's recommended that you maintain tight control of administrators and service account groups across Azure Active Directory and your DevOps tool of choice.
Consider implementing the principle of least privilege across all your role assignments. For example, your organization may have a Platform or Cloud Excellence team that needs to maintain the ARM templates for your Azure Landing Zones. Individual users of that team should be assigned to a Security Group in Azure Active Directory (assuming you're using it as your identity provider), and that Security Group can be assigned to the appropriate roles in your DevOps tool in order to perform their jobs.

In general, for any administrator or highly privileged accounts in Active Directory, it's recommended that their credentials aren't synchronized to Azure Active Directory, and vice-versa. This will reduce the threat of lateral movement where if an administrator in Active Directory is compromised, the attacker won't be able to easily gain access to any cloud assets, such as Azure DevOps, and potentially inject malicious tasks in the CI/CD pipelines. This is particularly important for any users assigned elevated permissions in your DevOps environment, such as Build or Project/Collection Administrators.
For more information, please see the article on [security best practices in Azure Active Directory](/azure/security/fundamentals/identity-management-best-practices).

In the next sections, we'll dive into specific RBAC recommendations for Azure DevOps and GitHub.

## Azure DevOps Role-based Access Considerations

Manage security in Azure DevOps with security groups, policies, and settings at the organization/collection, project, or object level. If integrating with an identity provider such as Azure Active Directory, consider creating [Conditional Access Policies to enforce MFA for all users](/azure/devops/organizations/accounts/change-application-access-policies) with access to your Azure DevOps organization, and potentially, more granular restrictions around IP address, type of device used for access, and device compliance.

For the majority of the team members in your Platform team that is managing your Azure Landing Zones, the Basic access level and Contributor default security group should provide sufficient access. The Contributor security group will allow them to edit the Azure Landing Zone templates in your repository and the CI/CD pipelines that validate and deploy them. It's recommended that you assign your Platform team to the Contributor security group at the project level of Azure DevOps in order to follow the principle of least privilege. These assignments can be done through the Project Settings page shown below.

![Screenshot showing the project settings page where assignments can be made.](../../_images/ready/devops-project-roles.jpg)

Another best practice for your Azure DevOps Projects and organizations is to disable inheritance where possible as users will automatically inherit permissions allowed by their security group assignments. Due to the allow-by-default nature of inheritance, unexpected users can get access or permissions.
For example, if you assign your Platform team Contributor security group membership, take care to verify their permissions on the Azure Landing Zones repository. You should have branch policies in place so verify that the security group isn't allowed to bypass those policies during pull requests. This can be verified under **Project Settings** > **Repositories**.

After you've assigned permissions to users, you should periodically review audit events to monitor and react to unexpected usage patterns by administrators and other users.This can be done by first [creating an audit stream to a Log Analytics workspace](/azure/devops/organizations/audit/azure-devops-auditing). If it's a Sentinel-enabled workspace, you should create analytics rules to alert you on notable events, such as improper use of permissions. 

For more information, reference the links below:

- [Azure DevOps security best practices](/azure/devops/organizations/security/security-best-practices)
- [Detailed review of Azure DevOps groups and permissions](/azure/devops/organizations/security/permissions)
- [Review of Azure DevOps access levels](/azure/devops/organizations/security/access-levels)

## GitHub Role-based Access Considerations

If your primary DevOps tool is GitHub, you can assign users access to resources by granting them roles at the repository level, team level, or organization level.
Once you've forked the Azure Landing Zones repository into your own GitHub Enterprise Cloud organization and integrated with an identity provider such as Azure Active Directory, consider creating a team in GitHub and assigning it "Write" access to your new ALZ repository. 
For the majority of your Platform team modifying and deploying the Landing Zones, write access should be sufficient. For project managers or scrum masters on the team, you may need to assign them the "Maintain" role to that repository. 

Note that, we recommend you manage all of these role assignments through the integrated identity provider. For example, you can synchronize the Platform team for the ALZ repository you've created in GitHub with the corresponding Platform team Security Group in Azure Active Directory. Then, as you dynamically add or remove members to the Azure AD Security Group, those changes will be reflected in your GitHub Enterprise Cloud role assignments. Note - once you've connected a specific GitHub team to an IdP, you're restricted to managing the team membership through the identity provider.

For more information around managing roles and teams in GitHub, see the links below: 

- [GitHub Roles and Scope Levels](https://docs.github.com/en/organizations/managing-peoples-access-to-your-organization-with-roles/roles-in-an-organization)
- [How to manage GitHub permissions after integrating with Identity Provider](https://docs.github.com/en/enterprise-cloud@latest/organizations/organizing-members-into-teams/synchronizing-a-team-with-an-identity-provider-group)
- [Managing Permissions with GitHub Teams](https://docs.github.com/en/organizations/organizing-members-into-teams/about-teams)