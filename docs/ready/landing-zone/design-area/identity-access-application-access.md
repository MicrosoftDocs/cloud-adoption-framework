---
title: Azure identity and access management design area
description: Understand the identity and access management design area as part of the Azure landing zone design areas.
author: soderholmd
ms.author: dsoderholm 
ms.service: cloud-adoption-framework
ms.topic: conceptual
ms.date: 09/19/2023
---

Application access management

Individual application workloads will have authentication and authorisation requirements beyond those that apply to administrators. Users will require access to applications, which need to be secured using modern authentication methods. In addition, some Azure resources may need to connect to others, such as a web application that uses a SQL Managed Instance, or an Azure Policy that automatically remediates non-compliant resources or users using can use their Microsoft or social identities to access applications or services build by developers.

Design Considerations

•	Learn about authentication and authorization standards like  OAuth 2.0, OpenID Connect (OIDC), JSON web tokens (JWTs), SAML(Security Assertion Markup Language). See What is identity and access management (IAM)? - Microsoft Entra | Microsoft Learn for more information.

•	Developers should consider using Microsoft Identity Platform as the Identity solution for their applications. The Microsoft Identity Platform provides an OpenID Connect standard-compliant authentication service enabling developers to authentication several identity types, including:
o	Work or school accounts, provisioned through Azure AD
o	Personal Microsoft accounts (Skype, Xbox, Outlook.com)
o	Social or local accounts, by using Azure AD 
See Microsoft identity platform overview - Microsoft Entra | Microsoft Learn for more information

•	Managed identities provide an automatically managed identity in Azure Active Directory (Azure AD) for applications to use when connecting to resources that support Azure AD authentication. Applications can use managed identities to obtain Azure AD tokens without having to manage any credentials. See Connecting from your application to resources without handling credentials for an in-depth discussion.

o	Many security breaches of public cloud resources originate with credential theft embedded in code or other text. Enforcing managed identities for programmatic access greatly reduces the risk of credential theft.

o	It's easy to confuse how service principals and managed identities access Azure resources. For an explanation, see Demystifying Service Principals - Managed Identities.  

o	Consider whether to use system-assigned or user-assigned managed identities. See Choose system or user-assigned managed identities for guidance. 

o	To check which Azure resources managed identities support, see Azure services that can use managed identities to access other services. For more information, see Managed identities for Azure resources - Microsoft Entra | Microsoft Learn.

o	You can't transfer Azure resources with user-assigned or system-assigned identities to another Azure subscription. Managed identities are also not preserved if you move a subscription from one directory to another. You must carry out the move and recreate the managed identities manually.

o	System-assigned managed identities can be used to support signing in to a VM using Azure AD authentication. For more information, see Log in to a Windows virtual machine in Azure by using Azure AD - Microsoft Entra | Microsoft Learn.  

•	Evaluate scenarios that involve setting up external users, customers, or partners to secure access to resources. Determine whether these scenarios involve Azure AD B2B or Azure AD B2C configurations. For more information, see External Identities in Azure Active Directory - Microsoft Entra | Microsoft Learn.  


•	Find out which services or applications within your landing zone support Azure AD authentication. To check which Azure services support Azure AD authentication, see Azure services that support Azure AD authentication - Microsoft Entra | Microsoft Learn.  

•	Consider the methods that virtual machine users will use to connect interactively. Azure Bastion, Just-in-Time (JIT), and RDP or SSH have different network requirements and security implications. See Plan for virtual machine remote access for more information.

Design recommendations
•	Use managed identities for Azure resources that don't need to use credentials. Applications that need to authenticate against an Azure service can use managed identities. Ensure that managed identities follow the principle of least privilege when granting access.

•	Use Azure Key Vault to manage secrets, keys, certificates used by applications. Use RBAC to allow administrative access and management for management. Use managed identities to control application access to Key Vault. For a tutorial, see Tutorial: Use a managed identity to access Azure Key Vault - Windows - Microsoft Entra | Microsoft Learn.

•	If you are using DevOps pipelines to deploy applications programmatically, create a service principal and assign the necessary permissions to allow infrastructure or application code to be deployed. See Authenticate your Azure deployment pipeline by using service principals for more information.

•	To access applications that use on-premises authentication remotely through Azure AD, use Azure AD Application Proxy. Application Proxy provides secure remote access to on-premises web applications, including those that use older authentication protocols. After a single sign-on to Azure AD, users can access both cloud and on-premises applications through an external URL or an internal application portal.

•	Use attribute-based access control (ABAC) where supported, to further restrict permissions on data in blob storage and prevent unauthorised access to data. See Allow read access to blobs based on tags and custom security attributes (Preview) - Azure ABAC | Microsoft Learn for more information. 
