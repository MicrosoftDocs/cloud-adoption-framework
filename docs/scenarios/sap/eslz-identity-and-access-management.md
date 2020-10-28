---
title: "Enterprise-Scale identity and access management for <Insert narrative Name>"
description: Describe how this enterprise-scale scenario can improve identity and access management of SAP
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Identity and access management for SAP Enterprise-Scale scenario

## Title

Design Considerations

Determine Azure resource and service administration vs SAP application administration boundaries between Infrastructure team and SAP application team. Providing SAP team with elevated service administration access in SAP non-production (eg Virtual Machine Contributor) as well as somewhat elevated service administration access in production (eg partial Virtual Machine Contributor) can help achieve a good balance between segregation vs efficiency.

If SAP Cloud platform services are used, consider Principal propagation for forwarding the identity from SAP Cloud applciation to SAP On-premise installation (includes IaaS) through Cloud Connector

Consider migration to Azure as an opportunity to review and re-align identity and access management processes in SAP landscape with those at your enterprise level, where applicable:
 • Review SAP dormant user lockout policies.
 • Review SAP user password policy and align with AD/ AAD.
 • Review LMS (Leavers, Movers and Starters) procedures and align with AD/ AAD. If you are using SAP HCM, it is very likely that the LMS process is driven by SAP.

Consider using automatic user provisioning feature of Azure AD to provison/de-provision users in SAP SaaS applications.  SAP Analytics Cloud and SAP identity Authentication Service currently support this scenario. 

NFS communication between Azure Netapp Files and Azure Virtual Machines can be secured with NFS client encryption using Kerberos. Azure NetApp Files supports both Active Directory Domain Services (ADDS) and Azure Active Directory Domain Services (AADDS) for AD connections. Before you create an AD connection, you need to decide whether to use ADDS or AADDS. However, you need to consider the performance impact of Kerberos on NFSv4.1.

RFC connections between SAP systems can be secured using Secure Network Communications (SNC) using appropriate protection level ie quality of protection (QoP). SNC protection generates some performance overhead, therefore to protect RFC communication between application servers of the same SAP system, SAP recommends using network security instead of SNC.
Azure services such as Azure Data Factory, on-prem Data Gateway (Logic Apps, PowerBI), etc support SNC-protected RFC connections to an SAP system.

Privileged Identity Management can be used so that users are eligible for privileged roles on AAD and Azure resources.
Enterprises could take this to even further by including Application, middleware, database etc. by using 3rd party tools such as CyberArk.



Design Recommendations

If SAP Cloud Identity Authentication Service is used it is recommended to integrate it with Azure AD.  With this integration Identity Authentication acts as a proxy Identity Provider and Azure AD as the main authentication authority. The authentication requests sent to Identity Authentication are redirected to Azure AD. User management and authentication is done on Azure AD side.
 
Implement Single Sign-on (SSO) using Azure Active Directory or Active Directory Federation Services (AD FS) for end users to connect to SAP applications where possible.
     • SSO to SAP Fiori and web applications can be implemented using SAML
     • SSO to SAP GUI can be implemented using either SAP SSO or a 3rd party solution
       For SAP SaaS applications like SAP Analytics Cloud, SAP Cloud Platform, SAP Cloud Platform IAS and SAP C4C use the gallery app in Azure AD to configure SSO based on SAML.

If SuccessFactors is used as HCM application leverage the automated user provisioning feature to Azure AD. When a new employee is added to SuccessFactors, a user account is automatically created in Azure Active Directory and optionally Microsoft 365 and other SaaS applications supported by Azure AD, with write-back of the email address to SuccessFactors

Emphasis: Determine your deployment scenario Active Directory on-prem vs Active Directory on Azure IaaS vs Azure Active Directory and identify identity and authentication provider for each of your SAP applications.

Use Azure Key vault to store 
1. Keys and secrets to the orchestration layer such as ansible and terraform 
2. Passwords of SAP administrative user accounts, keys and certificates such as HANA or OS administrator users

