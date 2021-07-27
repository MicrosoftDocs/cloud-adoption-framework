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

Azure can be consumed via Subscriptions that may be from multiple [offer types](https://azure.microsoft.com/support/legal/offer-details/) (e.g. EA, MCA, CSP etc.). All of these various [offer types](https://azure.microsoft.com/support/legal/offer-details/) can be used together with each other to provide customers flexibility in their billing options when consuming Azure.

![Diagram that shows Azure Scopes within a single Azure AD Tenant with multiple billing offer Subscriptions.](./media/az-scopes-billing.png)

*Figure 1: The Azure Scopes in a single Azure AD Tenant with Subscriptions of different offer types.*

An Enterprise Scale architecture supports Azure Subscriptions from any [offer type](https://azure.microsoft.com/support/legal/offer-details/). This is due to the fact that an Enterprise Scale architecture only requires Azure Subscriptions to be within a single Azure AD Tenant to then be brought into the Management Group hierarchy within that Tenant. They then can be managed by the various controls implemented as part of the Enterprise Scale platform; like Azure Policies and Role-Based Access Controls (RBAC).

>[!NOTE]
> Enterprise Scale is only scoped and deployed into a single Azure AD Tenant, however the billing options used may span multiple Azure AD Tenants. 
>  
> For example an EA Enrollment supports Azure Subscriptions across multiple Azure AD Tenant's.

## Plan for enterprise enrollment

An Enterprise Agreement (EA) enrollment represents the commercial relationship between Microsoft and how your organization uses Azure. It provides the basis for billing across all your subscriptions and affects administration of your digital estate. Your EA enrollment is managed via the Azure EA portal (https://ea.azure.com). An enrollment often represents an organization's hierarchy, which includes departments, accounts, and subscriptions. This hierarchy represents cost centres groups within an organization.

![Diagram that shows Azure EA hierarchies.](./media/ea.png)

*Figure 2: An Azure EA enrollment hierarchy.*

- Departments help to segment costs into logical groupings and to set a budget or quota at the department level. The quota isn't enforced firmly and is used for reporting purposes.
- Accounts are organizational units in the Azure EA portal. They can be used to manage subscriptions and access reports.
- Subscriptions are the smallest unit in the Azure EA portal. They're containers for Azure services managed by the Service Administrator. They're where your organization deploys Azure services.
- [EA enrollment roles](/azure/cost-management-billing/manage/understand-ea-roles#enterprise-user-roles) link users with their functional role. These roles are:
  - Enterprise Administrator
  - Department Administrator
  - Account Owner
  - Service Administrator
  - Notification Contact

**Design considerations:**

- The enrollment provides a hierarchical organizational structure to govern the management of subscriptions as detailed further [here.](/azure/cost-management-billing/manage/understand-ea-roles#azure-enterprise-portal-hierarchy)
- Multiple environments can be separated at an EA-account level to support holistic isolation.
- There can be multiple administrators appointed to a single enrollment.
- Each subscription must have an associated Account Owner.
- Each Account Owner will be made a subscription owner for any subscriptions provisioned under that account.
- A subscription can belong to only one account at any given time.
- A subscription can be suspended based on a specified set of criteria.

**Design recommendations:**

- Only use the authentication type `Work or school account` for all account types. Avoid using the `Microsoft account (MSA)` account type.
- Set up the Notification Contact email address to ensure notifications are sent to an appropriate group mailbox.
- Assign a budget for each account, and establish an alert associated with the budget.
- An organization can have a variety of structures, such as functional, divisional, geographic, matrix, or team structure. Use organizational structure to map your organization structure to your enrollment hierarchy.
- Create a new department for IT if business domains have independent IT capabilities.
- Restrict and minimize the number of account owners within the enrollment to avoid the proliferation of admin access to subscriptions and associated Azure resources.
- If multiple Azure Active Directory (Azure AD) tenants are used, verify that the Account Owner is associated with the same tenant as where subscriptions for the account are provisioned.
- Set up Enterprise Dev/Test and production environments at an EA account level to support holistic isolation.
- Utilize the [Enterprise Dev/Test Offer](/azure/cost-management-billing/manage/ea-portal-administration#enterprise-devtest-offer) for Dev/Test workloads.
  - Ensure you comply with the usage terms as detailed [here.](https://azure.microsoft.com/offers/ms-azr-0148p/)
- Don't ignore notification emails sent to the notification account email address. Microsoft sends important EA-wide communications to this account.
- Don't move or rename an EA account in Azure AD.
- Periodically audit the EA portal to review who has access and avoid using a Microsoft account where possible.
- Enable both **DA View Charges** and **AO View Charges** on every EA enrollment, as per [these instructions](/azure/cost-management-billing/costs/assign-access-acm-data#enable-access-to-costs-in-the-azure-portal), to allow Azure Cost Management data to be visible in the Azure Portal to users with required permissions. 

## Plan for Microsoft Customer Agreement (MCA)

A Microsoft Customer Agreement (MCA) is the new modern commerce platform offering for Azure which represents the commercial relationship between Microsoft and how your organization uses Azure. The Microsoft Customer Agreement enables a streamlined, electronic transaction in an eleven-page agreement that doesn’t expire. It provides the basis for billing across all your subscriptions and affects administration of your digital estate. Your MCA is managed via the Azure portal (https://portal.azure.com).

An MCA often represents an organization's hierarchy, which is constructed from billing profiles, invoice sections and subscriptions. This hierarchy represents cost centres groups within an organization.

![Diagram that shows an MCA hierarchy.](./media/mca-hierarchy.png)

*Figure 3: An MCA hierarchy using Invoice Sections.*

>[!IMPORTANT]
> If migrating from an EA to an MCA, please review the following pages:
>  
> - [Complete Enterprise Agreement tasks in your billing account for a Microsoft Customer Agreement](/azure/cost-management-billing/manage/mca-enterprise-operations)
> - [Set up your billing account for a Microsoft Customer Agreement](/azure/cost-management-billing/manage/mca-setup-account)

**Design considerations:**

- The MCA provides a hierarchical organizational structure to govern the management of subscriptions as detailed further [here.](/azure/cost-management-billing/manage/mca-section-invoice)
- An MCA billing account is managed by a single Azure AD Tenant only.
  - However, Subscriptions across multiple Azure AD Tenants are supported on a single MCA as detailed [here](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants#how-tenants-and-subscriptions-relate-to-billing-account) and [here.](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants#manage-subscriptions-under-multiple-tenants-in-a-single-microsoft-customer-agreement)
- New Azure Subscriptions provisioned upon an MCA are always associated to the Azure AD Tenant to which the MCA billing account is located in.
- MCAs utilize the RBAC model and therefore multiple users can be assigned with the required roles at the same scopes (e.g. Billing Account, Billing Profile, Invoice Section)
  - These billing roles and assignments are outside of the standard Azure RBAC roles and assignments. 
    - E.g. They cannot be assigned at a Management Group or Resource Group scope.
- A subscription can belong to only one Invoice Section at any given time.
  - Subscriptions can only be moved between Invoice Sections within the same Billing Profile.
- An optional Purchase Order (PO) number can be set on a Billing Profile.
- A subscription can be suspended based on a specified set of criteria.
- Before provisioning additional Billing Profiles review the potential impacts to charges and reservations detailed [here.](/azure/cost-management-billing/manage/mca-section-invoice#things-to-consider-when-adding-new-billing-profiles)

**Design recommendations:**

- Set up the **Contact** email address on the MCA Billing Account to ensure notifications are sent to an appropriate group mailbox.
- Assign a budget for each Invoice Section and/or Billing Profile, and establish an alert associated with the budget.
- An organization can have a variety of structures, such as functional, divisional, geographic, matrix, or team structure. Use organizational structure to map your organization structure to your MCA hierarchy.
  - Invoice Sections are suitable in most scenarios.
- Create a new Invoice Section for IT, if business domains have independent IT capabilities.
- Don't ignore notification emails sent to the **Contact** email address. Microsoft sends important communications to this address.
- Periodically audit the MCA Billing RBAC role assignments to review who has access.
- Utilize the Azure Plan Dev/Test Offer for Dev/Test workloads.
  - Ensure you comply with the usage terms as detailed [here.](https://azure.microsoft.com/offers/ms-azr-0148g/)

## Plan for Cloud Solutions Provider (CSP)

The Cloud Solutions Provider (CSP) is available for Microsoft partners to enable them to transact across Microsoft Cloud services (i.e. Azure, O365, Enterprise Mobility Suite and Dynamics CRM Online) through a single platform. CSP enables partners to: own the customer lifecycle and relationship end-to-end; set the price and terms and directly bill customers; directly provision and manage subscriptions; attach value-added services; and be the first point of contact for customer support.

[CSP for Azure](https://azure.microsoft.com/offers/ms-azr-0145p/) comes in the form of Azure Plan in CSP subscriptions that are hosted upon the partner's [Microsoft Partner Agreement (MPA)](/azure/cost-management-billing/understand/mpa-overview). The MPA is similar to the MCA, mentioned above, as they are both hosted on the modern commerce platform and also both use the [Microsoft Customer Agreement](https://www.microsoft.com/licensing/docs/customeragreement) simplified purchase agreement.

![Diagram that shows an MPA hierarchy.](./media/mpa-hierarchy.png)

*Figure 3: An MPA hierarchy.*

>[!IMPORTANT]
> An MPA is managed completely by the partner (CSP).

**Design considerations:**

- A CSP reseller relationship must be established between the partner and each Azure AD Tenant that the customer wishes to provision Azure Plan in CSP Subscriptions in.
- New Azure Plan in CSP Subscriptions can only be provisioned by the partner.
- A subscription can be suspended based on a specified set of criteria and also by the partner.
- Azure Reservations can, by default, only be purchased by the partner for their customer.
  - Customers can however be granted permission to purchase their own Azure Reservations from their CSP via the [**Customer Permissions** feature.](/partner-center/give-customers-permission)

**Design recommendations:**

- Work with your CSP partner to ensure Azure Lighthouse is utilized for their access over Administer on Behalf of (AOBO) for most support scenarios.
  - As per the guidance, [Azure Lighthouse and the Cloud Solution Provider program.](/lighthouse/concepts/cloud-solution-provider)
- Work with your CSP partner to understand support case creation and escalation processes.
- Discuss Subscription self-service creation possibilities with your CSP partner.

## Define Azure AD tenants

An Azure AD tenant provides identity and access management, which is an important part of your security posture. An Azure AD tenant ensures that authenticated and authorized users have access to only the resources for which they have access permissions. Azure AD provides these services to applications and services deployed in Azure and also to services and applications deployed outside of Azure (such as on-premises or third-party cloud providers).

Azure AD is also used by software as a service applications such as Microsoft 365 and Azure Marketplace. Organizations already using on-premises Active Directory can use their existing infrastructure and extend authentication to the cloud by integrating with Azure AD. Each Azure AD directory has one or more domains. A directory can have many subscriptions associated with it but only one Azure AD tenant.

Ask basic security questions during the Azure AD design phase, such as how your organization manages credentials and how it controls human, application, and programmatic access.

**Design considerations:**

- Multiple Azure AD tenants can function in the same enrollment.

**Design recommendations:**

- Use Azure AD seamless single sign-on based on the selected [planning topology](/azure/active-directory/hybrid/plan-connect-topologies).
- If your organization doesn't have an identity infrastructure, start by implementing an Azure-AD-only identity deployment. Such deployment with [Azure AD Domain Services](/azure/active-directory-domain-services) and [Microsoft Enterprise Mobility + Security](/mem/intune/fundamentals/what-is-intune) provides end-to-end protection for SaaS applications, enterprise applications, and devices.
- Multi-factor authentication provides another layer of security and a second barrier of authentication. Enforce [multi-factor authentication](/azure/active-directory/authentication/concept-mfa-howitworks) and [conditional access policies](/azure/active-directory/conditional-access/overview) for all privileged accounts for greater security.
- Plan and implement for [emergency access](/azure/active-directory/users-groups-roles/directory-emergency-access) or break-glass accounts to prevent tenant-wide account lockout.
- Use [Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) for identity and access management.
- Avoid creating multiple Azure AD Tenants as per the guidance in [Testing approach for enterprise scale](./testing-approach.md) and [Cloud Adoption Framework Azure best practices guidance to standardize on a single directory and identity](../../secure/security-top-10.md#9-architecture-standardize-on-a-single-directory-and-identity).
- Use [Azure Lighthouse](/azure/lighthouse/overview) where appropriate, in the following scenarios:
  - 3rd Party/Partner access to Azure resources in customer Azure AD Tenants.
  - Centralized access to Azure resources in Azure AD Multi-Tenant architectures.
