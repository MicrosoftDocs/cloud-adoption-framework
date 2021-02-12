---
title: Identity and access management for SAP on Azure Construction Set
description: Learn about design considerations and recommendations that relate to identity and access management in an SAP deployment on Microsoft Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/12/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Identity and access management for SAP on Azure Construction Set

This article examines design considerations and recommendations that relate to identity and access management in an SAP deployment on Microsoft Azure.

## Design considerations

- Determine the Azure resource administration boundaries versus the SAP Basis administration boundaries between the Infrastructure team and the SAP Basis team. Consider providing the SAP Basis team with elevated Azure resource administration access in an SAP non-production environment. For example, give them a [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role. You can also give them partially elevated administration access like partial Virtual Machine Contributor in a production environment. Both options achieve a good balance between separation of duties and operational efficiency.

- Review the Azure administration and management activities you require your teams to do. Consider your SAP on Azure landscape. Figure out the best possible distribution of responsibilities within your organization.

Common Azure admin activities involved in administration and management of SAP on Azure are listed here:

| Azure Resource | Azure Resource Provider | Activities |
|---|---|---|
| Virtual Machines | Microsoft.Compute/virtualMachines | Start, stop, restart, deallocate, deploy, redeploy, change, resize, Extensions, Availability Sets, Proximity Placement Groups |
| Virtual Machines | Microsoft.Compute/disks | Read and write to disk |
| Storage | Microsoft.Storage | Read, Change on Storage accounts (for example boot diagnostics) |
| Storage | Microsoft.NetApp | Read, Change on NetApp Capacity Pools and Volumes |
| Storage | Microsoft.NetApp | ANF snapshots |
| Storage | Microsoft.NetApp | ANF Cross-region replication |
| Networking | Microsoft.Network/networkInterfaces | Read, Create, Change Network Interfaces |
| Networking | Microsoft.Network/loadBalancers | Read, Create, Change Load Balancers |
| Networking | Microsoft.Network/networkSecurityGroups | Read NSG |
| Networking | Microsoft.Network/azureFirewalls | Read firewall |

- If you're using SAP Cloud Platform services, consider using Principal Propagation to forward an identity from SAP Cloud Platform application to your on-premises SAP landscape. Use SAP Cloud Connector.

- Consider a migration to Azure an opportunity to review and realign identity and access management processes. Review the processes in your SAP landscape and the processes at your enterprise level:
  - Review SAP dormant user lockout policies.
  - Review SAP user password policy and align it with Azure Active Directory (AD).
  - Review Leavers, Movers, and Starters (LMS) procedures and align them with Azure AD. If you're using SAP Human Capital Management (HCM), it's likely that the LMS process is driven by SAP HCM.

- Consider using automatic user provisioning feature of Azure AD to set up and remove users in SAP SaaS applications. SAP Analytics Cloud and SAP Identity Authentication Service currently support this scenario.

- Network File System (NFS) communication between Azure NetApp Files and Azure Virtual Machines can be secured with [NFS client encryption using Kerberos](/azure/azure-netapp-files/configure-kerberos-encryption). Azure NetApp Files supports both Active Directory Domain Services (ADDS) and Azure Active Directory Domain Services (AADDS) for Azure AD connections. Consider the [performance impact of Kerberos on NFSv4.1](/azure/azure-netapp-files/configure-kerberos-encryption#kerberos_performance).

- Remote Function Call (RFC) connections between SAP systems can be secured with Secure Network Communications (SNC) using appropriate protection level like quality of protection (QoP). SNC protection generates some performance overhead. To protect RFC communication between application servers of the same SAP system, SAP recommends using network security instead of SNC.
These Azure services support SNC-protected RFC connections to an SAP system: Azure Data Factory, on-premises data gateway (Logic Apps, Power BI), and so on.

## Design recommendations

- Implement Single Sign-on (SSO) using Azure Active Directory or Active Directory Federation Services (AD FS) so the end users can connect to SAP applications:
  - Implement [SSO to SAP Netweaver](/azure/active-directory/saas-apps/sap-netweaver-tutorial) based web applications like SAP Fiori, WebGUI, and so on, with SAML.
  - SSO to SAP GUI can be implemented using either SAP NetWeaver Single Sign-On product (SAP NW SSO) or a partner solution.
  - Implement [SSO to SAP SaaS applications](/azure/active-directory/saas-apps/sap-customer-cloud-tutorial) like SAP Analytics Cloud, SAP Cloud Platform, SAP Cloud Platform IAS, and SAP C4C with Azure AD using SAML.

- If you're using SAP Cloud Identity Authentication Service (SAP IAS), it's recommended to integrate IAS with Azure AD. With this integration, SAP IAS acts as a proxy Identity Provider and forwards Identity Authentication requests to Azure AD. User management is done in Azure AD.

- If you're using SAP SuccessFactors, it's recommended to use the [automated user provisioning](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial) feature of Azure AD. With this integration, as you add new employees to SAP SuccessFactors, you can automatically create their user accounts in Azure AD. Optionally, user accounts can be created in Microsoft 365 and other SaaS applications supported by Azure AD. Use write-back of the email address to SAP SuccessFactors.
