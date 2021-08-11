---
title: Enterprise Agreement enrollment and Azure Active Directory tenants
description: Enterprise enrollment and Azure Active Directory tenants.
author: jtracey93
ms.author: jatracey
ms.date: 07/26/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Enterprise Agreement enrollment and Azure Active Directory tenants

Azure can be consumed via Azure subscriptions that might be from multiple [offer types](https://azure.microsoft.com/support/legal/offer-details/) (for example EA, MCA, CSP etc.). All of these offer types can be used together to give customers flexibility in their billing options.

![Diagram that shows Azure Scopes within a single Azure A D Tenant with multiple billing offer subscriptions.](./media/az-scopes-billing.png)

An enterprise-scale architecture supports subscriptions from any [offer type](https://azure.microsoft.com/support/legal/offer-details/). Azure subscriptions have to be within a single Azure Active Directory (Azure AD) tenant to then be brought into the Management Group hierarchy within that tenant. From there, they can be managed by the various controls in an enterprise-scale platform such as Azure Policies and Role-Based Access Controls (RBAC).

>[!NOTE]
> Enterprise-scale architecture is only scoped and deployed into a single Azure AD tenant; however, the billing options might span multiple Azure AD tenants. 
>  
> For example, an Enterprise Agreement (EA) enrollment supports Azure subscriptions across multiple Azure AD tenants.

## Plan for EA enrollment

An Enterprise Agreement (EA) enrollment represents the commercial relationship between Microsoft and how your organization uses Azure. It provides the basis for billing across all of your subscriptions and affects administration of your digital estate. Your EA enrollment is managed via the Azure EA portal (https://ea.azure.com). An enrollment often represents an organization's hierarchy, including departments, accounts, and subscriptions. This hierarchy represents cost centers within an organization.

![Diagram that shows Azure E A hierarchies.](./media/ea.png)

- Departments help to segment costs into logical groupings and to set a budget or quota at the department level. The quota isn't firmly enforced; it's used for reporting purposes.
- Accounts are organizational units in the Azure EA portal. They can be used to manage subscriptions and access reports.
- Subscriptions are the smallest unit in the Azure EA portal. They're containers for Azure services that are managed by the Service Administrator. This is where your organization deploys Azure services.
- [EA enrollment roles](/azure/cost-management-billing/manage/understand-ea-roles#enterprise-user-roles) link users with their functional role. These roles are:
  - Enterprise administrator
  - Department administrator
  - Account owner
  - Service administrator
  - Notification contact

### EA enrollment relationship with Azure AD and Azure RBAC 

When you use an EA enrollment to provide Azure subscriptions, there are multiple authentication and authorization boundaries that are important to understand. More importantly, you need to understand the relationship between these boundaries.

There is a inherent trust relationship between Azure subscriptions and an Azure AD tenant, which is detailed further at [Associate or add an Azure subscription to your Azure Active Directory tenant](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory). An EA enrollment can also use an Azure AD tenant as an identity provider (IdP), depending on the [authentication level](/azure/cost-management-billing/manage/ea-portal-troubleshoot#authentication-level-types) set on the enrollment and which option was selected when the enrollment account owner was created. 

However, the EA enrollment roles, apart from the account owner, provide no access to Azure AD or the Azure subscriptions within that enrollment.

For example, a finance user is granted the enterprise administrator role on the EA enrollment. The finance user is a standard user with no elevated permissions or roles assigned to them in Azure AD or on any Azure Management Group, subscription, resource group, or resource. The finance user can only perform the roles listed at [Managing Azure Enterprise Agreement roles](/azure/cost-management-billing/manage/understand-ea-roles#enterprise-administrator) and can't access the Azure subscriptions on the enrollment.

The only Enterprise Agreement role that has access to Azure subscriptions is the account owner because this role was created when the subscription was created.

![Diagram that shows Azure E A relationship with Azure A D and Azure R B A C.](./media/ea-azure-relationship.png)

#### Design considerations:

- The enrollment provides a hierarchical organizational structure to govern the management of subscriptions. See [Managing Azure Enterprise Agreement roles](/azure/cost-management-billing/manage/understand-ea-roles#azure-enterprise-portal-hierarchy).
- There can be multiple administrators appointed to a single enrollment.
- Each subscription must have an associated account owner.
- Each account owner is a subscription owner for any subscriptions provisioned under that account.
- A subscription can belong to only one account at a time.
- A subscription can be suspended based on a specified set of criteria.
- Enrollment billing and usage reports can be filtered by departments and accounts.
- Review the limitations at [Programmatically create Azure Enterprise Agreement subscriptions with the latest APIs](/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=rest#limitations-of-azure-enterprise-subscription-creation-api) relating to the EA subscription creation API.

#### Design recommendations:

- Only use the authentication type `Work or school account` for all account types. Avoid using the `Microsoft account (MSA)` account type.
- Set up the **Notification Contact** email address to ensure notifications are sent to an appropriate group mailbox.
- An organization can have a variety of structures, such as functional, divisional, geographic, matrix, or team structure. Use departments and accounts to map your organizations structure to your enrollment hierarchy to assist with billing separation.
- Use [Azure Cost Management](/azure/cost-management-billing/cost-management-billing-overview) reports and views, which can use Azure metadata (for example, tags and location) to explore and analyze your organization's costs.
- Restrict and minimize the number of account owners within the enrollment to limit admin access to subscriptions and associated Azure resources.
- Assign a budget for each department and account, and establish an alert associated with the budget.
- Create a new department for IT if business domains have independent IT capabilities.
- If you use multiple Azure AD tenants, verify that the account owner is associated with the same tenant as where subscriptions for the account are provisioned.
- Use the [Enterprise Dev/Test Offer](/azure/cost-management-billing/manage/ea-portal-administration#enterprise-devtest-offer) for Dev/Test workloads, where available. Ensure you comply with the [usage terms](https://azure.microsoft.com/offers/ms-azr-0148p/)
- Don't ignore notification emails sent to the notification account email address. Microsoft sends important EA-wide communications to this account.
- Don't move or rename an EA account in Azure AD.
- Periodically audit the Azure EA portal to review who has access, and avoid using a Microsoft account where possible.
- [Enable both **DA View Charges** and **AO View Charges** on every EA enrollment](/azure/cost-management-billing/costs/assign-access-acm-data#enable-access-to-costs-in-the-azure-portal) to allow Azure cost management data to be visible in the Azure portal to users with required permissions. 

## Plan for Microsoft Customer Agreement

The Microsoft Customer Agreement is the new modern commerce platform offering for Azure. It represents the commercial relationship between Microsoft and how your organization uses Azure. The agreement enables a streamlined, electronic transaction in an 11 page agreement that doesn't expire. It provides the basis for billing across all your subscriptions and affects administration of your digital estate. Your agreement is managed via the Azure portal (https://portal.azure.com).

The customer agreement often represents an organization's hierarchy, which is constructed from billing profiles, invoice sections, and subscriptions. This hierarchy represents cost centers within an organization.

![Diagram that shows the Microsoft Customer Agreement hierarchy.](./media/mca-hierarchy.png)

>[!IMPORTANT]
> If migrating from an EA to a Microsoft Customer Agreement, please review these articles:
>  
> - [Complete Enterprise Agreement tasks in your billing account for a Microsoft Customer Agreement](/azure/cost-management-billing/manage/mca-enterprise-operations)
> - [Set up your billing account for a Microsoft Customer Agreement](/azure/cost-management-billing/manage/mca-setup-account)

### Design considerations:

- The agreement provides a hierarchical organizational structure to govern the management of subscriptions. See [Organize costs by customizing your billing account](/azure/cost-management-billing/manage/mca-section-invoice).
- An agreement billing account is managed by a single Azure AD tenant. However, subscriptions across multiple Azure AD tenants are supported on a single agreement. See [How tenants and subscriptions relate to billing account](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants#how-tenants-and-subscriptions-relate-to-billing-account) and [Manage subscriptions under multiple tenants in a single Microsoft Customer Agreement](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants#manage-subscriptions-under-multiple-tenants-in-a-single-microsoft-customer-agreement).
- New Azure subscriptions provisioned upon an agreement are always associated to the Azure AD tenant in which the agreement billing account is located.
- Agreements use the RBAC model. Multiple users can be assigned with the required roles at the same scopes (for example, billing account, billing profile, invoice section). These billing roles and assignments are outside of the standard Azure RBAC roles and assignments. They cannot be assigned at a management group or resource group scope.
- A subscription can belong to only one invoice section at any given time. Subscriptions can only be moved between invoice sections within the same billing profile.
- An optional purchase order (PO) number can be set on a billing profile.
- A subscription can be suspended based on a specified set of criteria.
- Before you provision additional billing profiles, [review the potential impacts to charges and reservations](/azure/cost-management-billing/manage/mca-section-invoice#things-to-consider-when-adding-new-billing-profiles).
- Use [Azure Cost Management](/azure/cost-management-billing/cost-management-billing-overview) reports and views, which can use Azure metadata (for example, tags and location) to explore and analyze your organization's costs.

### Design recommendations:

- Set up the **Contact** email address on the agreement billing account to ensure notifications are sent to an appropriate group mailbox.
- Assign a budget for each invoice section and/or billing profile, and establish an alert associated with the budget.
- An organization can have a variety of structures, such as functional, divisional, geographic, matrix, or team. Use organizational structures to map your organization to your agreement hierarchy. Invoice sections are suitable in most scenarios.
- Create a new invoice section for IT (if your business domain has independent IT capabilities).
- Don't ignore notification emails sent to the **Contact** email address. Microsoft sends important communications to this address.
- Periodically audit the agreement billing RBAC role assignments to review who has access.
- Use the Azure Plan Dev/Test Offer for Dev/Test workloads, where available. Ensure you [comply with the usage terms](https://azure.microsoft.com/offers/ms-azr-0148g/).

## Plan for Cloud Solution Provider (CSP)

The Cloud Solution Provider (CSP) enables Microsoft partners to transact across Microsoft Cloud services through a single platform.

CSP enables partners to: 

- own the customer lifecycle and relationship end-to-end,
- set the price and terms and directly bill customers,
- directly provision and manage subscriptions, 
- Attach value-added services, and
- Be the first point of contact for customer support.

[CSP for Azure](https://azure.microsoft.com/offers/ms-azr-0145p/) comes in the form of Azure plan in CSP subscriptions that are hosted on the partner's [Microsoft Partner Agreement](/azure/cost-management-billing/understand/mpa-overview). The partner agreement is similar to the customer agreement mentioned above; they are both hosted on the modern commerce platform and both use the [Microsoft Customer Agreement](https://www.microsoft.com/licensing/docs/customeragreement) simplified purchase agreement.

![Diagram that shows an MPA hierarchy.](./media/mpa-hierarchy.png)

>[!IMPORTANT]
> A Microsoft Partner Agreement is managed completely by the partner CSP.

### Design considerations:

- A [CSP reseller relationship](/partner-center/request-a-relationship-with-a-customer) must exist between the partner and each Azure AD tenant that the customer wants to provision Azure plan in CSP subscriptions in.
- New Azure plan in CSP subscriptions can only be provisioned by the partner.
- A subscription can be suspended based on a specified set of criteria and also by the partner.
- Azure usage charges access can be enabled by the partner for their customers, on a per customer basis. See [Enable the policy to view Azure usage charges](/azure/cost-management-billing/costs/get-started-partners#enable-cost-management-for-customer-tenant-subscriptions). Partners can also provide access to Azure usage charges by using other tools.
- Azure reservations can, by default, only be purchased by the partner for their customer. Customers can, however, be given permission to purchase their own Azure reservations from their CSP via the [**Customer Permissions** feature](/partner-center/give-customers-permission).

### Design recommendations:

- Work with your CSP partner to ensure Azure Lighthouse is used for their access over Administer on Behalf of (AOBO) for most support scenarios. See [Azure Lighthouse and the Cloud Solution Provider program](/lighthouse/concepts/cloud-solution-provider).
- Work with your CSP partner to understand support case creation and escalation processes.
- Discuss subscription self-service creation possibilities with your CSP partner.
- Use [Azure Cost Management](/azure/cost-management-billing/cost-management-billing-overview) reports and views, which can use Azure metadata (for example, tags and location) to explore and analyze your organization's costs.

## Define Azure AD tenants

An Azure AD tenant provides identity and access management, which is an important part of your security posture. An Azure AD tenant ensures that authenticated and authorized users only have access to the resources for which they have access permissions. Azure AD provides these services to applications and services deployed in and outside of Azure (such as on-premises or third-party cloud providers).

Azure AD is also used by software as a service (SaaS) applications such as Microsoft 365 and Azure Marketplace. Organizations already using on-premises Active Directory can use their existing infrastructure and extend authentication to the cloud by integrating with Azure AD. Each Azure AD directory has one or more domains. A directory can have many subscriptions associated with it, but only one Azure AD tenant.

Ask basic security questions during the Azure AD design phase, such as how your organization manages credentials and how it controls human, application, and programmatic access.

### Design considerations:

- Multiple Azure AD tenants can function in the same enrollment.
- Azure Lighthouse only supports delegation at the subscription and resource group scopes.

### Design recommendations:

- Use Azure AD seamless single sign-on based on the selected [planning topology](/azure/active-directory/hybrid/plan-connect-topologies).
- If your organization doesn't have an identity infrastructure, start by implementing an Azure-AD-only identity deployment. Deployment with [Azure AD Domain Services](/azure/active-directory-domain-services) and [Microsoft Enterprise Mobility + Security](/mem/intune/fundamentals/what-is-intune) provides end-to-end protection for SaaS applications, enterprise applications, and devices.
- Multi-factor authentication provides another layer of security and a second barrier of authentication. For greater security, enforce [multi-factor authentication](/azure/active-directory/authentication/concept-mfa-howitworks) and [conditional access policies](/azure/active-directory/conditional-access/overview) for all privileged accounts.
- Plan and implement for [emergency access](/azure/active-directory/users-groups-roles/directory-emergency-access) or break-glass accounts to prevent tenant-wide account lockout.
- Use [Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) for identity and access management.
- Avoid creating multiple Azure AD tenants. See [Testing approach for enterprise scale](./testing-approach.md) and [Cloud Adoption Framework Azure best practices guidance to standardize on a single directory and identity](../../secure/security-top-10.md#9-architecture-standardize-on-a-single-directory-and-identity).
- Use [Azure Lighthouse](/azure/lighthouse/overview) in the following scenarios:
  - Third Party/Partner access to Azure resources in customer Azure AD tenants.
  - Centralized access to Azure resources in Azure AD multi-tenant architectures.
