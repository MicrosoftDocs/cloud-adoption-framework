---
title: Azure identity and access management for applications
description: Understand how to provide access to Azure Resources.
author: soderholmd
ms.author: dsoderholm 
ms.topic: conceptual
ms.date: 12/05/2023
---

# Application identity and access management

As teams start migrating or creating cloud native applications, you also need to think about the authentication and access requirements of these applications. These requirements relate to about how users authenticate to applications, and how application resources authenticate to each other, such as a web application accessing a SQL database. This section describes the considerations for application owners and developers when designing the identity and access management for applications.

The [Platform automation and DevOps](/azure/cloud-adoption-framework/ready/landing-zone/design-area/platform-automation-devops) design area recommends moving towards [subscription vending](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending) for applications teams. As part of subscription vending process, application teams need to provide identity and access requirements to the platform team for them to create subscription(s) with correct requirements for the application. This page focuses on the considerations and recommendations for application teams. The responsibility for identity and access for individual applications should be delegated to application owners, using the centralized services provided by the platform team.

## Design considerations

- Learn about authentication and authorization standards like OAuth 2.0, OpenID Connect (OIDC), JSON web tokens (JWTs), and SAML (Security Assertion Markup Language) to understand the possible authentication and authorization standards that can be used for the application. For more information, see [Authentication and Authorization Standards](/entra/fundamentals/introduction-identity-access-management#authentication-and-authorization-standards).

- When requesting an application landing zone from the platform team, consider the following questions to ensure subscriptions are created with correct access and policies:

  - How will end-users authenticate to and access the application?
  - Who will need RBAC access to the resources and services used for the application?
  - Do existing built-in roles cover the RBAC access requirements for both control plane and data plane access or will you need to create new custom roles?
  - Has the Platform team implemented any compliance policies that might cause issues with the application?
  - Which application components need to communicate with each other?
  - Is there any requirement for accessing any of the shared resources deployed in the platform landing zone, such as Microsoft Entra Domain Services?

- Evaluate scenarios that involve setting up external users, customers, or partners to secure access to resources. Determine whether these scenarios involve Microsoft Entra B2B or Microsoft Entra B2C configurations. For more information, see [Overview of Microsoft Entra External ID](/azure/active-directory/external-identities/external-identities-overview).

- Many security breaches of public cloud resources originate with credential theft embedded in code or other text. Using Managed identities and Key Vault for programmatic access greatly reduces the risk of credential theft.

- Assess whether the application or workload requires a service to securely store credentials. [Azure Key Vault](/azure/key-vault/general/overview) can be used to manage secrets, keys, and certificates for applications.

- [Managed identities](/azure/active-directory/managed-identities-azure-resources/overview) provide an automatically managed identity principal for applications and resources to use when connecting to resources that support Microsoft Entra ID authentication. Applications can use managed identities to obtain Microsoft Entra ID tokens without having to manage any credentials. For more information, see [Connecting from your application to resources without handling credentials](/entra/identity/managed-identities-azure-resources/overview-for-developers).

  - Consider whether to use system-assigned or user-assigned managed identities. See [Choosing system or user-assigned managed identities](/azure/active-directory/managed-identities-azure-resources/managed-identity-best-practice-recommendations#choosing-system-or-user-assigned-managed-identities) for guidance.
  - It's easy to confuse how service principals and managed identities access Azure resources. To understand the difference between the two, see [Demystifying Service Principals - Managed Identities](https://devblogs.microsoft.com/devops/demystifying-service-principals-managed-identities/).  
  - Managed identities can be used to authenticate to any service that supports Microsoft Entra authentication. However, not all services support managed identities to access other services. For some services, it may be necessary to store credentials. In this case, credentials should be stored securely, not shared with other services, and should follow the principle of least privilege. For more information, see [Azure services that can use Managed Identities to access other services](/azure/active-directory/managed-identities-azure-resources/managed-identities-status).
  - There are restrictions on the ability to move resources with managed identities between subscriptions and regions. Scenarios that involve moving resources between subscriptions or regions include mergers and acquisitions, and repatriation of resources for data sovereignty reasons. Azure resources with user-assigned or system-assigned identities can't be transferred to another Azure subscription or region. You must delete the managed identities before you move the resources. After the move, you must re-create the managed identities and assign them to the resources. For more information, see [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).
  - Managed identities aren't preserved if you move a subscription from one directory to another. You must carry out the resource move and re-create the managed identities manually. For more information, see [Move managed identity for Azure resources across regions](/entra/identity/managed-identities-azure-resources/how-to-managed-identity-regional-move).
  - Managed identities can be used with Azure VMs to authenticate to any service that [supports Microsoft Entra ID authentication](/azure/active-directory/managed-identities-azure-resources/services-id-authentication-support) without having credentials in your code. For more information, see [How to use managed identities for Azure resources on an Azure VM to acquire an access token](/azure/active-directory/managed-identities-azure-resources/how-to-use-vm-token).  
  - Just like user RBAC role assignments, managed identities should [follow the principle of least privilege when granting access]( /entra/identity/managed-identities-azure-resources/managed-identity-best-practice-recommendations#follow-the-principle-of-least-privilege-when-granting-access).

## Design recommendations

- When building a cloud-native application, developers should default to use the [Microsoft identity platform](/entra/identity-platform/v2-overview) as the identity provider for their applications. The Microsoft identity platform provides an OpenID Connect standard-compliant authentication service enabling developers to authentication several identity types, including:

  - Work or school accounts, provisioned through Microsoft Entra ID
  - Personal Microsoft accounts (Skype, Xbox, Outlook.com)
  - Social or local accounts, by using Microsoft Entra ID

- Use the [Microsoft identity platform best practices and recommendations](/entra/identity-platform/identity-platform-integration-checklist) checklist for guidance on effectively integrating the application with Microsoft Identity Platform.

- Use PIM for managing any privileged role access to application landing zones and use the principle of least privilege when granting RBAC access to resources in the application landing zone.

- Use managed identities to enable access between Azure resources that don't need to use credentials.

- Don't share credentials or managed identities between different environments or applications. Identities used for production resources shouldn't also be used in dev/test resources, even for the same application. Create separate credentials for each instance of an application. This reduces the likelihood of a compromised test instance affecting production data, and makes it easier to revoke credentials when no longer required.

- Use a user-assigned managed identity per resource type, per region when there's a requirement to use managed identities at scale. For example, using Azure Monitoring Agents require a managed identity on the monitored Azure Virtual Machines (VMs) can result in substantial number of identities being created (and deleted) in Microsoft Entra ID. To avoid this churn of identities, use user-assigned managed identities, which can be created once and shared across multiple VMs. Use [Azure Policy](/entra/identity/managed-identities-azure-resources/how-to-assign-managed-identity-via-azure-policy) to implement this recommendation.

- Use Azure Key Vault to manage secrets, keys, certificates used by applications.
  - Use RBAC to manage access to secrets (data plane), and for administrative access (control plane). See [use an Azure RBAC for managing access](/azure/key-vault/general/rbac-guide) for guidance.
  - Use managed identities to control application access to Key Vault. For more information, see [Key Vault authentication](/azure/key-vault/general/authentication).

- Use separate Key Vaults for each application environment (Development, Pre-Production, Production), per region and use RBAC to manage access to secrets, keys and certificates (data plane operations) and access to Key Vault resource (control plane). Key vaults with application secrets should be deployed into the application landing zones. For more information, see [Use an Azure RBAC for managing access](/azure/key-vault/general/rbac-guide).

- If the application team is using CI/CD pipelines to deploy applications programmatically, configure OpenID Connect (OIDC) authentication to your Azure services. OIDC uses a short-lived, credential-free token to authenticate to Azure services. For more information, see [workload identity federation](/entra/workload-id/workload-identity-federation). If OIDC isn't supported, create a service principal and assign the necessary permissions to allow infrastructure or application code to be deployed. For detailed steps, see [Authenticate your Azure deployment pipeline by using service principals](/training/modules/authenticate-azure-deployment-pipeline-service-principals/).

- To access applications that use on-premises authentication remotely through Microsoft Entra ID, use [Microsoft Entra Application Proxy](/azure/active-directory/app-proxy/application-proxy). Application Proxy provides secure remote access to on-premises web applications, including applications that use older authentication protocols. After a single sign-on to Microsoft Entra ID, users can access both cloud and on-premises applications through an external URL or an internal application portal.
  - Application Proxy is deployed as a single instance into a Microsoft Entra ID tenant, and configuration requires the Application Administrator or Global Administrator privileged Entra ID roles. If your organization is using subscription democratization as a role assignment model, application owners may not have the necessary permissions to configure Application Proxy. In this case, the platform team should configure Application Proxy for the application owner.
  - If you are using CI/CD dpeloyment pipelines with sufficient permissions, application owners can configure Application Proxy using the Microsoft Graph API. For more information, see [Configure Application Proxy using the Microsoft Graph API](/graph/application-proxy-configure-api).

- If the application uses legacy protocols such as Kerberos, ensure that the application landing zone has network connectivity to domain controllers in the Identity platform subscription.

- Use attribute-based access control (ABAC) where supported, such as with Azure Blob Storage, to further restrict access and prevent unauthorized access to data. For more information, see [Allow read access to blobs based on tags and custom security attributes](/azure/role-based-access-control/conditions-custom-security-attributes).

### Next steps

>
> [!div class="nextstepaction"]
> [Resource organization](resource-org.md)
