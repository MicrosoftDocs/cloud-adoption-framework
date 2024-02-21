---
title: Azure identity and access management for applications
description: Learn about considerations and recommendations that application owners and developers can use to design the identity and access management for cloud-native applications.
author: soderholmd
ms.author: dsoderholm 
ms.topic: conceptual
ms.date: 02/21/2024
---

# Application identity and access management

This article describes considerations and recommendations that application owners and developers can use to design the identity and access management for cloud-native applications.

If your team migrates or creates cloud-native applications, you must consider the authentication and access requirements for the applications. These requirements determine how users authenticate to applications and how application resources authenticate to each other, for example when a web application accesses a SQL database. 

In the [platform automation and DevOps design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/platform-automation-devops), we recommend that applications teams transition to [subscription vending](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending). As part of the subscription vending process, application teams need to provide identity and access requirements to the platform team so they can create the appropriate subscriptions. The application owners are responsible for the identity and access management of individual applications. They should manage configurations via the centralized services that the platform team provides.

## Design considerations

#### Authentication and authorization standards

- Consider the authentication and authorization standards, like OAuth 2.0, OpenID Connect, JSON web tokens (JWTs), and SAML (Security Assertion Markup Language). Determine which authentication and authorization standards you can use for your application. For more information, see [Authentication and authorization standards](/entra/fundamentals/introduction-identity-access-management#authentication-and-authorization-standards).

- When you request an application landing zone from the platform team, you can help ensure that they create subscriptions with the correct access and policies. Consider asking the platform team the following questions:

  - How will end users authenticate to and access the application?
  
  - Who will need role-based access control (RBAC) access to the resources and services used for the application?
  - Do existing built-in roles cover the RBAC access requirements for both control plane and data plane access or will you need to create new custom roles?
  - Has the Platform team implemented any compliance policies that might cause issues with the application?
  - Which application components need to communicate with each other?
  - Is there any requirement for accessing any of the shared resources deployed in the platform landing zone, such as Microsoft Entra Domain Services?

#### External users

Evaluate scenarios that involve setting up external users, customers, or partners so they can access resources. Determine whether these scenarios involve Microsoft Entra B2B or Azure Active Directory B2C (Azure AD B2C) configurations. For more information, see [Overview of Microsoft Entra External ID](/azure/active-directory/external-identities/external-identities-overview).

#### Azure Key Vault and managed identities

- Many security breaches of public cloud resources originate from credential theft that's embedded in code or other text. You can use managed identities and [Key Vault](/azure/key-vault/general/overview) to implement programmatic access and help reduce the risk of credential theft.

- Determine whether your application or workload requires a service to securely store credentials. You can use Key Vault to manage secrets, keys, and certificates for applications.

- [Managed identities](/azure/active-directory/managed-identities-azure-resources/overview) provide an automatically managed identity principal that applications and resources use when they connect to resources that support Microsoft Entra ID authentication. Applications can use managed identities to obtain Microsoft Entra ID tokens without having to manage any credentials. For more information, see [Connecting from your application to resources without handling credentials](/entra/identity/managed-identities-azure-resources/overview-for-developers).

  - Consider whether to use system-assigned or user-assigned managed identities. For more information, see [Choosing system or user-assigned managed identities](/azure/active-directory/managed-identities-azure-resources/managed-identity-best-practice-recommendations#choosing-system-or-user-assigned-managed-identities).
  
  - It's easy to confuse how service principals (SPNs) and managed identities access Azure resources. To understand the difference between the two, see [Demystifying service principals—Managed identities](https://devblogs.microsoft.com/devops/demystifying-service-principals-managed-identities).
  - Where possible, use managed identities to support authentication rather than using SPNs and Microsoft Entra ID app registrations. You must have the application administrator or application developer RBAC roles to create SPNs and app registrations. These privileged roles are typically assigned to the platform team or identity team. Use managed identities to eliminate the need for the platform team to create SPNs and app registrations for your application team.
  - You can use managed identities to authenticate to any service that supports Microsoft Entra authentication. However, not all services support managed identities to access other services. For some services, it might be necessary to store credentials. You should securely store credentials, avoid sharing credentials with other services, and follow the principle of least privilege. For more information, see [Azure services that can use managed identities to access other services](/azure/active-directory/managed-identities-azure-resources/managed-identities-status).
  - There are restrictions on moving resources with managed identities between subscriptions and regions. For example, you might move resources between subscriptions or regions for a merger, acquisition, or repatriation of resources for data sovereignty reasons.
  
    If an Azure resource has user-assigned or system-assigned identities, you can't transfer the resource to another Azure subscription or region. You must delete the managed identities before you move the resource. After the move, you must re-create the managed identities and assign them to the resource. For more information, see [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).
  - If you move a subscription from one directory to another, managed identities aren't preserved. You must move the resource and then manually re-create the managed identities. For more information, see [Move managed identities for Azure resources across regions](/entra/identity/managed-identities-azure-resources/how-to-managed-identity-regional-move).
  - To avoid having credentials in your code, you can use managed identities with Azure virtual machines (VMs) to authenticate to any service that [supports Microsoft Entra ID authentication](/azure/active-directory/managed-identities-azure-resources/services-id-authentication-support). For more information, see [Use managed identities for Azure resources on a VM to acquire an access token](/azure/active-directory/managed-identities-azure-resources/how-to-use-vm-token).  
  - Similar to user RBAC role assignments, [follow the principle of least privilege]( /entra/identity/managed-identities-azure-resources/managed-identity-best-practice-recommendations#follow-the-principle-of-least-privilege-when-granting-access) when you grant a managed identity access to a resource.

## Design recommendations

#### Microsoft identity platform

- When developers build a cloud-native application, they should use the [Microsoft identity platform for developers](/entra/identity-platform/v2-overview) as the identity provider for their applications. The Microsoft identity platform provides an OpenID Connect standard-compliant authentication service that developers can use to authenticate several identity types, including:

  - Work or school accounts, provisioned through Microsoft Entra ID
  
  - Personal Microsoft accounts (Skype, Xbox, Outlook.com)
  - Social or local accounts, by using Microsoft Entra ID

- Use the [Microsoft identity platform best practices and recommendations](/entra/identity-platform/identity-platform-integration-checklist) checklist for guidance on effectively integrating the application with the Microsoft identity platform.

- Use Microsoft Entra Privileged Identity Management (PIM) for managing privileged role access to application landing zones. Use the principle of least privilege when you grant RBAC access to resources in the application landing zone.

#### Managed identities

- Use managed identities to enable access between Azure resources that don't need to use credentials.

- Don't share credentials or managed identities among various environments or applications. For example, don't use identities for production resources and also in dev/test resources, even for the same application. Create separate credentials for each instance of an application to reduce the likelihood of a compromised test instance affecting production data. Separate credentials also make it easier to revoke credentials when they're no longer required.

- When there's a requirement to use managed identities at scale, use a user-assigned managed identity for each resource type in each region. This approach prevents a churn of identities. For example, Azure Monitor Agent requires a managed identity on monitored Azure virtual machines (VMs), which can cause Microsoft Entra ID to create (and delete) a substantial number of identities.  You can create user-assigned managed identities once and share them across multiple VMs. Use [Azure Policy](/entra/identity/managed-identities-azure-resources/how-to-assign-managed-identity-via-azure-policy) to implement this recommendation.

#### Key Vault

- Use Key Vault to manage the secrets, keys, certificates that applications use.
  - Use RBAC to manage access to secrets (data plane) and for administrative access (control plane). For more information, see [Use Azure RBAC for managing access](/azure/key-vault/general/rbac-guide).

  - Use managed identities to control application access to Key Vault. For more information, see [Key Vault authentication](/azure/key-vault/general/authentication).

- Use separate key vaults for each application environment (development, pre-production, production) in each region. Use RBAC to manage access to secrets, keys, and certificates (data plane operations) and access to Key Vault (control plane). Deploy key vaults that have application secrets into the application landing zones. For more information, see [Use an Azure RBAC for managing access](/azure/key-vault/general/rbac-guide).

#### OpenID Connect

- If your application team uses continuous integration and continuous delivery (CI/CD) pipelines to deploy applications programmatically, configure OpenID Connect authentication to your Azure services. OIDC uses a temporary, credential-free token to authenticate to Azure services. For more information, see [Workload identity federation](/entra/workload-id/workload-identity-federation).

  If OIDC isn't supported, create a service principal and assign the necessary permissions to allow infrastructure or application code to be deployed. For more information, see the training module, [Authenticate your Azure deployment pipeline by using service principals](/training/modules/authenticate-azure-deployment-pipeline-service-principals).

#### Microsoft Entra application proxy

- To access applications that use on-premises authentication remotely via Microsoft Entra ID, use [Microsoft Entra application proxy](/azure/active-directory/app-proxy/application-proxy). Microsoft Entra application proxy provides secure remote access to on-premises web applications, including applications that use older authentication protocols. After a single sign-on to Microsoft Entra ID, users can access both cloud and on-premises applications via an external URL or an internal application portal.
  - You can deploy Microsoft Entra application proxy as a single instance into a Microsoft Entra ID tenant. Configuration requires the application administrator or global administrator privileged Entra ID roles. If your organization uses subscription democratization as a role assignment model, application owners might not have the necessary permissions to configure Microsoft Entra application proxy. In this case, the platform team should configure Microsoft Entra application proxy for the application owner.
  
  - If you use CI/CD deployment pipelines with sufficient permissions, application owners can [configure Microsoft Entra application proxy by using the Microsoft Graph API](/graph/application-proxy-configure-api).

- If the application uses legacy protocols, such as Kerberos, ensure that the application landing zone has network connectivity to domain controllers in the Microsoft identity platform subscription.

#### Attribute-based access control

- [Use attribute-based access control (ABAC)](/azure/role-based-access-control/conditions-custom-security-attributes) where supported, for example with Azure Blob Storage, to further restrict access and prevent unauthorized access to data.

#### Microsoft Entra ID identities

- Where possible, [use Microsoft Entra ID identities to control access to Azure virtual machines](/entra/identity/devices/howto-vm-sign-in-azure-ad-windows). Use Microsoft Entra ID instead of local authentication to provide access, such as Microsoft Entra Conditional Access, audit logging, and multi-factor authentication, to services. This configuration reduces the risk of attackers exploiting insecure local authentication services. For more information, see [Log into a Linux virtual machine in Azure by using Microsoft Entra ID and OpenSSH](/entra/identity/devices/howto-vm-sign-in-azure-ad-linux).

### Next steps

>
> [!div class="nextstepaction"]
> [Resource organization](resource-org.md)
