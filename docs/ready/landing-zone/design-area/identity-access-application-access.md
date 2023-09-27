---
title: Azure identity and access management design area
description: Understand how to provide access to Azure Resources.
author: soderholmd
ms.author: dsoderholm 
ms.topic: conceptual
ms.date: 09/19/2023
---

# Application access management

Individual application workloads have authentication and authorization requirements beyond those that apply to administrators. Users require access to applications, which need to be secured using modern authentication methods. In addition, some Azure resources may need to connect to others, such as a web application that uses a SQL Managed Instance, or an Azure Policy that automatically remediates noncompliant resources.

## Design Considerations

- Learn about authentication and authorization standards like  OAuth 2.0, OpenID Connect (OIDC), JSON web tokens (JWTs), SAML(Security Assertion Markup Language). See [Authentication and Authorization Standards](/azure/active-directory/fundamentals/introduction-identity-access-management?toc=%2Fazure%2Factive-directory%2Fdevelop%2Ftoc.json&bc=%2Fazure%2Factive-directory%2Fdevelop%2Fbreadcrumb%2Ftoc.json#authentication-and-authorization-standards) for more information.

- Developers should consider using Microsoft Identity Platform as the Identity solution for their applications. The Microsoft Identity Platform provides an OpenID Connect standard-compliant authentication service enabling developers to authentication several identity types, including:

  - Work or school accounts, provisioned through Microsoft Entra ID
  - Personal Microsoft accounts (Skype, Xbox, Outlook.com)
  - Social or local accounts, by using Microsoft Entra ID
  
  See [Microsoft identity platform overview](/azure/active-directory/develop/v2-overview) for more information.

- Managed identities provide an automatically managed identity in Microsoft Entra ID for applications to use when connecting to resources that support Microsoft Entra ID authentication. Applications can use managed identities to obtain Microsoft Entra ID tokens without having to manage any credentials. See [Connecting from your application to resources without handling credentials](/azure/active-directory/managed-identities-azure-resources/overview-for-developers?tabs=portal%2Cdotnet) for an for more information.

  - Many security breaches of public cloud resources originate with credential theft embedded in code or other text. Enforcing managed identities for programmatic access greatly reduces the risk of credential theft.

  - It's easy to confuse how service principals and managed identities access Azure resources. For an explanation, see [Demystifying Service Principals - Managed Identities](https://devblogs.microsoft.com/devops/demystifying-service-principals-managed-identities/).  

  - Consider whether to use system-assigned or user-assigned managed identities. See [Choosing system or user-assigned managed identities](/azure/active-directory/managed-identities-azure-resources/managed-identity-best-practice-recommendations#choosing-system-or-user-assigned-managed-identities) for guidance.

  - To check which Azure resources managed identities support, see Azure services that can use managed identities to access other services. For more information, see [Azure services that can use Managed Identities to access other services](/azure/active-directory/managed-identities-azure-resources/managed-identities-status).

  - You can't transfer Azure resources with user-assigned or system-assigned identities to another Azure subscription. Managed identities are also not preserved if you move a subscription from one directory to another. You must carry out the move and recreate the managed identities manually.

  - Managed identities can be used with Azure VMs to authenticate to any service that supports Microsoft Entra authentication without having credentials in your code. For more information, see [How to use managed identities for Azure resources on an Azure VM to acquire an access token](/azure/active-directory/managed-identities-azure-resources/how-to-use-vm-token).  

- Evaluate scenarios that involve setting up external users, customers, or partners to secure access to resources. Determine whether these scenarios involve Microsoft Entra B2B or Microsoft Entra B2C configurations. For more information, see [Overview of Microsoft Entra External ID](/azure/active-directory/external-identities/external-identities-overview).  

- Find out which services or applications within your landing zone support Microsoft Entra authentication. To check which Azure services support Microsoft Entra authentication, see [Azure services that support Microsoft Entra authentication](/azure/active-directory/managed-identities-azure-resources/services-id-authentication-support).  

- Consider the methods that virtual machine users use to connect interactively. Azure Bastion, Just-in-Time (JIT), and RDP or SSH have different network requirements and security implications. For more information, see [Plan for virtual machine remote access](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-virtual-machine-remote-access).

## Design recommendations

- Use [managed identities](/azure/active-directory/managed-identities-azure-resources/overview) for Azure resources that don't need to use credentials. Applications that need to authenticate against an Azure service can use managed identities. Ensure that managed identities follow the principle of least privilege when granting access.

- Use Azure Key Vault to manage secrets, keys, certificates used by applications. Use RBAC to allow administrative access and management for management. Use managed identities to control application access to Key Vault. For a tutorial, see Tutorial: [Use a managed identity to access Azure Key Vault](/azure/active-directory/managed-identities-azure-resources/tutorial-windows-vm-access-nonaad).

- If you are using DevOps pipelines to deploy applications programmatically, create a service principal and assign the necessary permissions to allow infrastructure or application code to be deployed. For more information, see [Authenticate your Azure deployment pipeline by using service principals](/training/modules/authenticate-azure-deployment-pipeline-service-principals/).

- To access applications that use on-premises authentication remotely through Microsoft Entra ID, use [Microsoft Entra Application Proxy](/azure/active-directory/app-proxy/application-proxy). Application Proxy provides secure remote access to on-premises web applications, including those that use older authentication protocols. After a single sign-on to Microsoft Entra ID, users can access both cloud and on-premises applications through an external URL or an internal application portal.

- Use attribute-based access control (ABAC) where supported, to further restrict permissions on data in blob storage and prevent unauthorized access to data. For more information, see [Allow read access to blobs based on tags and custom security attributes](/azure/role-based-access-control/conditions-custom-security-attributes).
