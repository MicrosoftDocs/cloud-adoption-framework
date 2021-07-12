---
title: Testing approach for enterprise-scale
description: Testing approach for enterprise-scale
author: jtracey93
ms.author: jatracey
ms.date: 04/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready 
ms.custom: think-tank
---

# Testing approach for enterprise-scale

>[!NOTE]
 > This article only applies to Microsoft Azure and not to any other Microsoft Cloud offerings such as Microsoft 365 or Microsoft Dynamics 365.

Some organizations might want to test their enterprise-scale platform deployment for Azure Policy definitions and assignments, role-based access control (RBAC) custom roles and assignments, and so on. The tests can be completed via automation by using Azure Resource Manager templates (ARM templates), [AzOps](https://github.com/Azure/AzOps), [Terraform](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest), or manually via the Azure portal. This guidance provides an approach that can be used to test changes and their impact in an enterprise-scale platform deployment.

This article can also be used with the [Platform automation and DevOps critical design area](./platform-automation-and-devops.md) guidance as it relates to the PlatformOps and Central functions teams and tasks.

This guidance is most suited to organizations with robust change management processes governing changes to the production environment management group hierarchy. The *canary* management group hierarchy can be independently used to author and test deployments before you deploy them into the production environment.

>[!NOTE]
 > The term "canary" is used to avoid confusion with development environments or test environments. This name is used for illustration purposes only. You might define any name you deem as appropriate for your canary enterprise-scale environment.
 >
 > Similarly, the term “production environment” is used throughout this guidance to refer to the management group hierarchy your organization might have in place that contains the Azure subscriptions and resources for your workloads.

## Platform definition

>[!IMPORTANT]
 > This guidance is not for development environments or test environments that will be used by application or service owners known as landing zones, workloads, applications, or services. These are placed and handled within the production environment management group hierarchy and associated governance (RBAC and Azure Policy).
 >
 > This guidance is only for platform level testing and changes in the context of enterprise-scale.

Enterprise-scale helps you design and deploy the required Azure platform components to enable you to construct and operationalize landing zones at scale.

The platform resources in scope for this article and this testing approach are:

| Product or service | Resource provider and type |
| :--------------- | :------------------------ |
| Management groups | Microsoft.Management/managementGroups |
| Management groups subscription association | Microsoft.Management/managementGroups/subscriptions |
| Policy definitions | Microsoft.Authorization/policyDefinitions |
| Policy initiative definitions or policy set definitions | Microsoft.Authorization/policySetDefinitions |
| Policy assignments | Microsoft.Authorization/policyAssignments |
| RBAC role definitions | Microsoft.Authorization/roleDefinitions |
| RBAC role assignments | Microsoft.Authorization/roleAssignments |
| Subscriptions | Microsoft.Subscription/aliases |

## Example scenarios and outcomes

An example of this scenario is an organization that wants to test the impact and result of a new Azure Policy to govern resources and settings in all landing zones, as per the [Policy-driven governance design principle](./design-principles.md#policy-driven-governance). They don't want to make this change directly to the production environment as they're concerned about the impact it might have.

Using the canary environment to test this platform change will allow the organization to implement and review the impact and result of the Azure Policy change. This process will ensure it satisfies the organization's requirements before they implement the Azure Policy to their production environment.

A similar scenario might be a change to the Azure RBAC role assignments and Azure AD group memberships. It might require a form of testing before the changes are made in the production environment.

>[!IMPORTANT]
 > This is not a common deployment approach or pattern for most customers. It isn't mandatory for enterprise-scale deployments.

[![Diagram of the management group hierarchy with the canary environment testing approach.](./media/canary-mgmt-groups.png)](./media/canary-mgmt-groups.png#lightbox)

_Figure 1: Canary management group hierarchy._

As the diagram shows, the entire enterprise-scale production environment management group hierarchy is duplicated under the `Tenant Root Group`. The *canary* name is appended to the management group display names and IDs. The IDs must be unique within a single Azure AD tenant.

>[!NOTE]
 > The canary environment management group display names can be the same as the production environment management group display names. This might cause confusion for users. Because of this, we recommend to append the name “canary” to the display names, as well as to their IDs.

The canary environment management group hierarchy is then used to simplify testing of the following resource types:

- Management groups
  - Subscription placement
- RBAC
  - Roles (built-in and custom)
  - Assignments
- Azure Policy
  - Definitions (built-in and custom)
  - Initiatives, also known as set definitions
  - Assignments

## What if you don't want to deploy the entire canary environment management group hierarchy?

If you don't want to deploy the entire canary environment management group hierarchy, you can test platform resources within the production environment hierarchy by using sandbox subscriptions as shown in the diagram.

[![Diagram of the testing approach that uses sandboxes.](./media/canary-sandboxes.png)](./media/canary-sandboxes.png#lightbox)

_Figure 2: Enterprise-scale management group hierarchy highlighting sandboxes._

To test Azure Policy and RBAC in this scenario, you need a single Azure subscription with the Owner RBAC role assigned to the identity you wish to complete the testing as, for example, User Account, Service Principal, or Managed Service Identity. This configuration will allow you to author, assign, and remediate Azure Policy definitions and assignments within the scope of the sandbox subscription only.

This sandbox approach can also be used for RBAC testing within the subscription, for example, if you're developing a new custom RBAC role to grant permissions for a particular use case. This testing can all be done in the sandbox subscription and tested before you create and assign roles higher up in the hierarchy.

A benefit of this approach is that the sandbox subscriptions can be used for the time that they're required, and then deleted from the environment.

However, this approach doesn't allow you to test with the inheritance of RBAC and Azure policies from the management group hierarchy.

## Using a single Azure AD tenant

Considerations to take into account when you use a single Azure AD tenant are:

- Follows [Enterprise-scale design recommendations](./enterprise-enrollment-and-azure-ad-tenants.md#define-azure-ad-tenants) for Azure AD Tenants.
- As per the [Cloud Adoption Framework Azure best practices, standardize on a single directory and identity](../../secure/security-top-10.md#9-architecture-standardize-on-a-single-directory-and-identity) guidance, single Azure AD tenants are best practice for most.
  - In a single Azure AD tenant, you can use the different Azure AD groups for both production environments and canary enterprise-scale environments, with the same users, assigned to their relevant management group hierarchy within the same Azure AD tenant.
- Increased or duplicated Azure AD licensing costs because of multiple identities across different Azure AD tenants.
  - This point is especially relevant to customers who use Azure AD Premium features.
- RBAC changes will be more complex in both canary environments and  production environments, as it's likely that the users and groups aren't identical across both Azure AD tenants.
  - Furthermore, the users and groups IDs won't be the same across Azure AD tenants because of them being globally unique.
- Reduces complexity and management overhead caused by managing multiple Azure AD Tenants.
  - Privileged users that must maintain access and sign in to separate tenants to perform testing might make changes to the production environment accidentally, instead of making changes to the canary environment and vice versa.
- Reduces the likelihood of configuration drift and deployment failures.
- Doesn’t require extra security and break-glass or emergency access processes to be created.
- Reduces friction and the time required to implement changes to the enterprise-scale deployment.

## Implementation guidance

Below is guidance on how to implement and use the canary management group hierarchy for enterprise-scale alongside a production environment management group hierarchy.

1. Use separate Azure AD Service Principals (SPNs) or Managed Service Identities (MSIs) that are granted permissions over the relevant production environment or canary environment management group hierarchy.
   - This guidance follows the principle of least privilege (PoLP)
2. Use separate folders within a git repository, branches, or repositories to hold the Infrastructure-as-Code for the production environment and canary environment enterprise-scale deployments.
   - Using the relevant Azure AD Service Principals (SPNs) or Managed Service Identities (MSIs) as part of the CI/CD pipelines depending on which hierarchy is being deployed.
3. Implement git branch policies or security for the canary environment as you have in place for the production environment.
   - Consider reducing the number of approvers and checks for the canary environment to fail-fast.
4. Use the same Azure Pipelines or GitHub actions that use environment variables to change which hierarchy is being deployed. Another option is to clone the pipelines and amend the hard-coded settings to define which hierarchy is being deployed.
   - Using [Azure Pipelines DevOps templates](/azure/devops/pipelines/process/templates) or [GitHub Actions Workflow Templates](https://docs.github.com/en/actions/learn-github-actions/sharing-workflows-with-your-organization) will help prevent the "Don’t Repeat Yourself" (DRY) principle.
5. Have a set of canary subscriptions under a separate EA department and account that can be moved around the canary management group hierarchy as needed.
   - It might be beneficial to have a set of resources always deployed into the canary environment subscriptions.
   - It might be helpful to have Infrastructure-as-Code templates such as ARM templates, Bicep, or Terraform, that create a set of resources that enable validation of changes in the canary environment.
6. Send all Azure activity logs for all Azure subscriptions, including any canary environment subscriptions, to the production environment Azure Log Analytics workspace as per the [enterprise-scale design recommendations](./management-and-monitoring.md).