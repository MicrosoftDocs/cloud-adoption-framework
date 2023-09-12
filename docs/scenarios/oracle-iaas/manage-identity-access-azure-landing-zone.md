---
title: Manage identity and access for Oracle on Azure VMs landing zone accelerator
description: Learn how to manage identity and access for Oracle on Azure VMs landing zone accelerator.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 08/31/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
--- 

# Manage identity and access for Oracle on Azure VMs landing zone accelerator

This article builds on many recommendations defined in the [Azure landing zone design area for identity and access management](../../ready/landing-zone/design-area/identity-access.md) article. Azure VMs landing zones for Oracle don't have any specific recommendations for using identity and Access Management (IAM) for Oracle databases. However, IAM provides role based access to the users who manage the  Azure Infrastructure (VM and Storage) on which the Oracle workload resides.

## Design considerations

Implement single sign-on (SSO) using Azure AD or Active Directory Federation Services (AD FS) so the database administrator(s) can connect to on-premises and cloud-based Oracle databases.  

If you're using other Oracle enterprise services like Fusion ERP, you should integrate all Oracle services with Azure AD. This integration enables management for all users within a single control plane of Azure AD.

It's recommended to use the [automated user provisioning](https://learn.microsoft.com/azure/active-directory/app-provisioning/user-provisioning) feature of Azure AD. With this integration, user accounts are seamlessly be created in Azure AD when employees join the organization.  

The following table shows common Azure admin activities involved in  managing Oracle on Azure VMs & storage.

|Azure resource  |Azure resource provider  |Activities  |
|:----|:----|:----|
|Virtual machines  |Microsoft.Compute/virtualMachines  |Start, stop, restart, deallocate, deploy, redeploy, change, resize, extensions, availability sets, proximity placement groups  |
|Virtual machines  |Microsoft.Compute/disks  |Read and write to disk  |
|Storage  |Microsoft.Storage  |Read, change on storage accounts (for example boot diagnostics)  |
|Storage  |Microsoft.NetApp  |Read, change on NetApp capacity pools and volumes  |
|Storage  |Microsoft.NetApp  |ANF snapshots  |
|Storage  |Microsoft.NetApp  |ANF Cross-region replication  |
|Networking  |Microsoft.Network/networkInterfaces  |Read, create, change network interfaces  |
|Networking  |Microsoft.Network/loadBalancers  |Read, create, change load balancers  |
|Networking  |Microsoft.Network/networkSecurityGroups  |Read NSG  |
|Networking  |Microsoft.Network/azureFirewalls  |Read firewall  |
|Networking  |Microsoft.Network/azureFirewalls  |Read firewall  |

- If you're using on-premises Oracle databases, consider using principal propagation to forward an identity from Oracle cloud platform application to your on-premises Oracle landscape using Azure AD Connect Cloud Sync.  

- Consider a migration to Azure an opportunity to review and realign identity and access management processes. Review the processes in your Oracle landscape and the processes at your enterprise level:  

    - Review Oracle dormant user lockout policies.
    - Review Oracle user password policy and align it with Azure AD.
    - Review Starters, Leavers, and Transfers procedures and align them with Azure AD.  

- Secure Network File System (NFS) communication between Azure NetApp Files and Azure Virtual Machines with NFS client encryption using Kerberos. Azure NetApp Files supports both Active Directory Domain Services (AD DS) and Azure Active Directory Domain Services for Azure AD connections. Consider the performance impact of Kerberos on NFS v4.1.  

- Consider incorporating Oracle Identity Governance, which includes Oracle Access Management and Oracle Unified Directory.
    - Oracle Access Management enables Identity Management and Role & Entitlement Management to enable segregation of duties. This enables Web-access Management, single sign-on (SSO), Federation, Multifactor Authentication (MFA), and Adaptive Risk-Aware Access.  

    - Oracle Unified Directory provides Directory Virtualization and Synchronization of underlying directory users.  

## Design recommendations

- Implement single sign-on (SSO) using Azure AD or Active Directory Federation Services (AD FS) so the database administrator(s) can connect to on-premises and cloud-based Oracle databases.  
- If you're using other Oracle enterprise services like Fusion ERP, you should integrate all Oracle services with Azure AD. This integration enables management for all users within a single control plane of Azure AD.

- It's recommended to use the automated user provisioning feature of Azure AD. With this integration, user accounts are seamlessly created in Azure AD when employees join the organization.

## Next steps

- [Strategic impact of Oracle on Azure landing zone accelerator](oracle-landing-zone-strategy.md)  
- [Plan for Oracle on Azure landing zone accelerator](oracle-landing-zone-plan.md)  
- [Oracle on Azure landing zone accelerator](intro-oracle-landing-zone.md)

