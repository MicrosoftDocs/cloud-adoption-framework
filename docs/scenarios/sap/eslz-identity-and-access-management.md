---
title: Identity and access management for SAP on Azure
description: Learn more about design considerations and recommendations that relate to identity and access management in an SAP deployment on Microsoft Azure.
author: JefferyMitchell
ms.author: brblanch
ms.date: 02/12/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

<!-- docutune:casing LMS -->

# Identity and access management for SAP

This article builds on a number of considerations and recommendations defined in the Azure landing zone article [enterprise-scale design area for identity and access management](../../ready/enterprise-scale/identity-and-access-management.md). Following the guidance in this article will help examine design considerations and recommendations that relate to identity and access management specific to the deployment of an SAP platform on Microsoft Azure. Since SAP is an mission-critical platform, the guidance on the enterprise-scale design areas should also be included in your design.

**Design considerations:**

- Determine the Azure resource administration boundaries versus the SAP Basis administration boundaries between the infrastructure team and the SAP Basis team. Consider providing the SAP Basis team with elevated Azure resource administration access in an SAP non-production environment. For example, give them a [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role. You can also give them partially elevated administration access like partial Virtual Machine Contributor in a production environment. Both options achieve a good balance between separation of duties and operational efficiency.

- Review the Azure administration and management activities you require your teams to do. Consider your SAP on Azure landscape. Determine the best possible distribution of responsibilities within your organization.

Here are common Azure admin activities involved in administration and management of SAP on Azure:

| Azure resource | Azure resource provider | Activities |
|---|---|---|
| Virtual machines | Microsoft.Compute/virtualMachines | Start, stop, restart, deallocate, deploy, redeploy, change, resize, extensions, availability sets, proximity placement groups |
| Virtual machines | Microsoft.Compute/disks | Read and write to disk |
| Storage | Microsoft.Storage | Read, change on storage accounts (for example boot diagnostics) |
| Storage | Microsoft.NetApp | Read, change on NetApp capacity pools and volumes |
| Storage | Microsoft.NetApp | ANF snapshots |
| Storage | Microsoft.NetApp | ANF Cross-region replication |
| Networking | Microsoft.Network/networkInterfaces | Read, create, change network interfaces |
| Networking | Microsoft.Network/loadBalancers | Read, create, change load balancers |
| Networking | Microsoft.Network/networkSecurityGroups | Read NSG |
| Networking | Microsoft.Network/azureFirewalls | Read firewall |

- If you're using SAP Cloud Platform services, consider using principal propagation to forward an identity from SAP Cloud Platform application to your on-premises SAP landscape. Use SAP Cloud Connector.

- Consider a migration to Azure an opportunity to review and realign identity and access management processes. Review the processes in your SAP landscape and the processes at your enterprise level:
  - Review SAP dormant user lockout policies.
  - Review SAP user password policy and align it with Azure Active Directory (Azure AD).
  - Review leavers, movers, and starters (LMS) procedures and align them with Azure AD. If you're using SAP Human Capital Management (HCM), it's likely that SAP HCM drives the LMS process.

- Consider using the automatic user provisioning feature of Azure AD to set up and remove users in SAP SaaS applications. SAP Analytics Cloud and SAP Identity Authentication service currently support this scenario.

- Secure Network File System (NFS) communication between Azure NetApp Files and Azure Virtual Machines with [NFS client encryption using Kerberos](/azure/azure-netapp-files/configure-kerberos-encryption). Azure NetApp Files supports both Active Directory Domain Services (AD DS) and Azure Active Directory Domain Services for Azure AD connections. Consider the [performance impact of Kerberos on NFS v4.1](/azure/azure-netapp-files/configure-kerberos-encryption#kerberos_performance).

- Secure Remote Function Call (RFC) connections between SAP systems with secure network communications (SNC) using appropriate protection level like quality of protection (QoP). SNC protection generates some performance overhead. To protect RFC communication between application servers of the same SAP system, SAP recommends using network security instead of SNC. These Azure services support SNC-protected RFC connections to an SAP system: Azure Data Factory, on-premises data gateway (Logic Apps, Power BI), and so on.

**Design recommendations:**

- Implement single sign-on (SSO) using Azure AD or Active Directory Federation Services (AD FS) so the end users can connect to SAP applications:
  - Implement [SSO to SAP NetWeaver](/azure/active-directory/saas-apps/sap-netweaver-tutorial) based web applications like SAP Fiori, SAP WebGUI, and so on, with SAML.
  - You can implement SSO to SAP GUI using either SAP NetWeaver SSO or a partner solution.
  - Implement [SSO to SAP SaaS applications](/azure/active-directory/saas-apps/sap-customer-cloud-tutorial) like SAP Analytics Cloud, SAP Cloud Platform, SAP Cloud Platform Identity Authentication service, and SAP C4C with Azure AD using SAML.

- If you're using SAP Cloud Platform Identity Authentication service, you should integrate it with Azure AD. This integration lets SAP IAS act as a proxy identity provider and forward identity authentication requests to Azure AD, which handles user management.

- If you're using SAP SuccessFactors, it's recommended to use the [automated user provisioning](/azure/active-directory/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial) feature of Azure AD. With this integration, as you add new employees to SAP SuccessFactors, you can automatically create their user accounts in Azure AD. Optionally, user accounts can be created in Microsoft 365 and other SaaS applications supported by Azure AD. Use write-back of the email address to SAP SuccessFactors.
