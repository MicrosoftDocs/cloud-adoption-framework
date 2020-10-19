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

**Design Considerations**

- Determine Azure resource and service administration vs SAP application administration boundaries between Infrastructure team and SAP application team. Providing SAP team with elevated service administration access in SAP non-production (eg Virtual Machine Contributor) as well as somewhat elevated service administration access in production (eg partial Virtual Machine Contributor) can help achieve a good balance between segregation vs efficiency.

Review what Azure administration and management activities your teams will be required to perform for your SAP on Azure landscape and determine the best possible distribution of responsibilities within your organization.

Common Azure admin activities involved in administration and management of SAP on Azure are listed here: 

| Azure Resource | Azure Resource Provider | Activities |
|---|---|---|
| Virtual Machines | Microsoft.Compute/virtualMachines/ | Start, stop, restart, deallocate, deploy, redeploy, change, resize, Extensions, Availability Sets, Proximity Placement Groups |
| Virtual Machines | Microsoft.Compute/disks | Disk read and write |
| Storage | Microsoft.Storage | Read, Change on Storage accounts (eg boot diagnostics) |
| Storage | Microsoft.NetApp | Read, Change on Netapp Capacity Pools and Volumes |
| Storage | Microsoft.NetApp | ANF snapshots |
| Storage | Microsoft.NetApp | ANF Cross-region replication |
| Networking | Microsoft.Network/networkInterfaces | Read, Create, Change Network Interfaces |
| Networking | Microsoft.Network/loadBalancers | Read, Create, Change Load Balancers |
| Networking | Microsoft.Network/networkSecurityGroups | Read NSG |
| Networking | Microsoft.Network/azureFirewalls | Read firewall |

- If SAP Cloud platform services are used, consider Principal propagation for forwarding the identity from SAP Cloud applciation to SAP On-premise installation (includes IaaS) through Cloud Connector
- Consider migration to Azure as an opportunity to review and re-align identity and access management processes in SAP landscape with those at your enterprise level, where applicable:
  - Review SAP dormant user lockout policies.
  - Review SAP user password policy and align with AD/ AAD.
  - Review LMS (Leavers, Movers and Starters) procedures and align with AD/ AAD. If you are using SAP HCM, it is very likely that the LMS process is driven by SAP.
- Consider using automatic user provisioning feature of Azure AD to provison/de-provision users in SAP SaaS applications.  SAP Analytics Cloud and SAP identity Authentication Service currently support this scenario. 
- NFS communication between Azure Netapp Files and Azure Virtual Machines can be secured with [NFS client encryption using Kerberos](https://docs.microsoft.com/en-us/azure/azure-netapp-files/configure-kerberos-encryption). Azure NetApp Files supports both Active Directory Domain Services (ADDS) and Azure Active Directory Domain Services (AADDS) for AD connections. However, you need to consider the [performance impact of Kerberos on NFSv4.1](https://docs.microsoft.com/en-us/azure/azure-netapp-files/configure-kerberos-encryption#kerberos_performance).
- RFC connections between SAP systems can be secured with Secure Network Communications (SNC) using appropriate protection level ie quality of protection (QoP). SNC protection generates some performance overhead, therefore to protect RFC communication between application servers of the same SAP system, SAP recommends using network security instead of SNC.
Azure services such as Azure Data Factory, on-prem Data Gateway (Logic Apps, PowerBI), etc support SNC-protected RFC connections to an SAP system.

**Design Recommendations**
