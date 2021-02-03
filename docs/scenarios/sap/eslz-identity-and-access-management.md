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

# Identity and access management for SAP on Azure Construction Set

## Title

**Design Considerations**

- Determine Azure resource and service administration vs SAP application administration boundaries between Infrastructure team and SAP application team. Providing SAP team with elevated service administration access in SAP non-production (eg Virtual Machine Contributor) as well as somewhat elevated service administration access in production (eg partial Virtual Machine Contributor) can help achieve a good balance between segregation vs efficiency.

Review what Azure administration and management activities your teams will be required to perform for your SAP on Azure landscape and determine the best possible distribution of responsibilities within your organization.

Common Azure admin activities involved in administration and management of SAP on Azure are listed here: 

| Azure Resource | Azure Resource Provider | Activities |
|---|---|---|
| Virtual Machines | Microsoft.Compute/virtualMachines | Start, stop, restart, deallocate, deploy, redeploy, change, resize, Extensions, Availability Sets, Proximity Placement Groups |
| Virtual Machines | Microsoft.Compute/disks | Disk read and write |
| Storage | Microsoft.Storage | Read, Change on Storage accounts (eg boot diagnostics) |
| Storage | Microsoft.NetApp | Read, Change on NetApp Capacity Pools and Volumes |
| Storage | Microsoft.NetApp | ANF snapshots |
| Storage | Microsoft.NetApp | ANF Cross-region replication |
| Networking | Microsoft.Network/networkInterfaces | Read, Create, Change Network Interfaces |
| Networking | Microsoft.Network/loadBalancers | Read, Create, Change Load Balancers |
| Networking | Microsoft.Network/networkSecurityGroups | Read NSG |
| Networking | Microsoft.Network/azureFirewalls | Read firewall |

- If SAP Cloud platform services are used, consider Principal propagation for forwarding the identity from SAP Cloud application to SAP On-premise installation (includes IaaS) through Cloud Connector
- Consider migration to Azure as an opportunity to review and re-align identity and access management processes in SAP landscape with those at your enterprise level, where applicable:
  - Review SAP dormant user lockout policies.
  - Review SAP user password policy and align with AD/ AAD.
  - Review LMS (Leavers, Movers and Starters) procedures and align with AD/ AAD. If you are using SAP HCM, it is very likely that the LMS process is driven by SAP.
- Consider using automatic user provisioning feature of Azure AD to provision/de-provision users in SAP SaaS applications.  SAP Analytics Cloud and SAP identity Authentication Service currently support this scenario. 
- NFS communication between Azure NetApp Files and Azure Virtual Machines can be secured with [NFS client encryption using Kerberos](https://docs.microsoft.com/azure/azure-netapp-files/configure-kerberos-encryption). Azure NetApp Files supports both Active Directory Domain Services (ADDS) and Azure Active Directory Domain Services (AADDS) for AD connections. However, you need to consider the [performance impact of Kerberos on NFSv4.1](https://docs.microsoft.com/azure/azure-netapp-files/configure-kerberos-encryption#kerberos_performance).
- RFC connections between SAP systems can be secured with Secure Network Communications (SNC) using appropriate protection level ie quality of protection (QoP). SNC protection generates some performance overhead, therefore to protect RFC communication between application servers of the same SAP system, SAP recommends using network security instead of SNC.
Azure services such as Azure Data Factory, on-prem Data Gateway (Logic Apps, PowerBI), etc support SNC-protected RFC connections to an SAP system.

**Design Recommendations**

 - Implement Single Sign-on (SSO) using Azure Active Directory or Active Directory Federation Services (AD FS) for end users to connect to SAP applications where possible.
    - SSO to [SAP Netweaver](https://docs.microsoft.com/azure/active-directory/saas-apps/sap-netweaver-tutorial) based web applications like Fiori, webgui etc. can be implemented using SAML
    - SSO to SAP GUI can be implemented using either SAP SSO or a 3rd party solution
    - SSO to [SAP SaaS applications](https://docs.microsoft.com/azure/active-directory/saas-apps/sap-customer-cloud-tutorial) like SAP Analytics Cloud, SAP Cloud Platform, SAP Cloud Platform IAS and SAP C4C with Azure AD can be implemented using SAML.

 - If SAP Cloud Identity Authentication Service is used it is recommended to integrate it with Azure AD.  With this integration Identity Authentication acts as a proxy Identity Provider and Azure AD as the main authentication authority. The authentication requests sent to Identity Authentication are redirected to Azure AD. User management and authentication is done on Azure AD side.

- Consider using automatic user provisioning feature of Azure AD to provision/de-provision users in SAP SaaS applications. SAP Analytics Cloud and SAP identity Authentication Service currently support this scenario.  

- If SuccessFactors is used as HCM application leverage the [automated user provisioning](https://docs.microsoft.com/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial) feature to Azure AD. When a new employee is added to SuccessFactors, a user account is automatically created in Azure Active Directory and optionally Microsoft 365 and other SaaS applications supported by Azure AD, with write-back of the email address to SuccessFactors"
