---
title: Identity and Access Management for Azure HPC
description: Learn about identity and access management for high-performance computing (HPC) using this scenario that builds on the Azure landing zone design area.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/15/2024
---

# Identity and access management for Azure HPC

This article builds on considerations and recommendations that are described in the article [Azure identity and access management design](../../ready/landing-zone/design-area/identity-access.md). It can help you examine design considerations for identity and access management that are specific to the deployment, on Azure, of HPC applications.

[Microsoft Entra Domain Services](/azure/active-directory-domain-services/overview) provides managed domain services like domain join and Group Policy. It also provides access to legacy authentication protocols like lightweight directory access protocol (LDAP) and Kerberos/NTLM authentication. Microsoft Entra Domain Services integrates with your existing Microsoft Entra tenant. This integration enables users to sign in to services and applications connected to the managed domain by using their existing credentials in Microsoft Entra ID. You can also use existing groups and user accounts to help secure access to resources. These features provide a smoother lift-and-shift of on-premises resources to Azure, especially for hybrid environments.

For more information, see [design recommendations for platform access](../../ready/landing-zone/design-area/identity-access-platform-access.md#design-recommendations-for-platform-access) and [Azure identity and access for landing zones](../../ready/landing-zone/design-area/identity-access-landing-zones.md).

## Design considerations

HPC deployment uses the Azure landing zone infrastructure setup for security identity and access management. Keep the following design considerations in mind when you deploy your HPC application:

- Determine the Azure resource administration that's required by various members of the team. Consider providing those team members with elevated Azure resource administration access in a nonproduction environment.
  - For example, give them a [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role.
  - You can also give team members partially elevated administration access, like a partial Virtual Machine Contributor role in a production environment.
  
  Both options achieve a good balance between separation of duties and operational efficiency.
- Review the Azure administration and management activities that you require your teams to do. Consider your HPC on Azure landscape. Determine the best possible distribution of responsibilities within your organization.

  Here are the common Azure activities for administration and management:

  | Azure resource | Azure resource provider | Activities |
  |--|--|--|
  | Virtual machines (VMs) | Microsoft.Compute/virtualMachines | Start, stop, restart, deallocate, deploy, redeploy, change, and resize VMs. Manage extensions, availability sets, and proximity placement groups. |
  | VMs | Microsoft.Compute/disks | Read and write to disk. |
  | Storage | Microsoft.Storage | Read and make changes on storage accounts, for example, a boot diagnostics storage account. |
  | Storage | Microsoft.NetApp | Read and make changes on NetApp capacity pools and volumes. |
  | Storage | Microsoft.NetApp | Take Azure NetApp Files snapshots. |
  | Storage | Microsoft.NetApp | Use Azure NetApp Files cross-region replication. |
  | Networking | Microsoft.Network/networkInterfaces | Read, create, and change network interfaces. |
  | Networking | Microsoft.Network/loadBalancers | Read, create, and change load balancers. |
  | Networking | Microsoft.Network/networkSecurityGroups | Read network security groups. |
  | Networking | Microsoft.Network/azureFirewalls | Read firewalls. |
  | Networking | Microsoft.Network/virtualNetworks | Read, create, and change network interfaces. <br><br> Consider the relevant access that's needed for the resource group of the virtual network and related access if it's different from the resource group of the VMs. |

- A typical HPC setup includes a front end for submitting jobs, a job scheduler or orchestrator, a compute cluster, and shared storage. The jobs can be submitted from on-premises and/or in the cloud. Identity and access management considerations for users and visualization devices might vary depending on the enterprise standards.

- Consider the Microsoft authentication service that you use. Depending on the HPC compute resource orchestrator that you use, various authentication methods are supported, as described here.

  - [Azure CycleCloud](/azure/cyclecloud/overview?view=cyclecloud-8&preserve-view=true) provides [three authentication methods](/azure/cyclecloud/how-to/user-authentication?view=cyclecloud-8&preserve-view=true): a built-in database with encryption, Active Directory, and LDAP.
  - [Azure Batch](/azure/batch/batch-technical-overview) supports [two authentication methods](/azure/batch/security-best-practices): Shared Key and Microsoft Entra ID.
  -  If you want to extend your on-premises capabilities to a hybrid environment, you can authenticate through Active Directory with a read-only domain controller that's hosted on Azure. This approach minimizes traffic across the link. This integration provides a way for users to use their existing credentials to sign in to services and applications that are connected to the managed domain. You can also use existing groups and user accounts to help secure access to resources. These features provide a smoother lift-and-shift of on-premises resources to Azure.
  - Currently, [HPC Pack](/azure/cyclecloud/hpcpack?view=cyclecloud-8&preserve-view=true) nodes must be joined into an Active Directory domain. If you're deploying the HPC Pack cluster in a virtual network that has a site-to-site VPN or Azure ExpressRoute connection to your corporate network (and firewall rules allow access to Active Directory domain Controllers), there's typically already an Active Directory domain. If you don't have an Active Directory domain in your virtual network, you can choose to create one by promoting the head node as domain controller. Another option is to use Microsoft Entra Domain Services to allow the HPC Pack nodes to be domain joined to this service vs. on-premises Active Directory domain controllers. If the head nodes will be deployed on Azure, it's important to determine whether remote users on-premises will be submitting jobs. If remote users are submitting jobs, you should use Active Directory because it provides a better experience and allows certificates to be used properly for authentication. Otherwise, if you're using Microsoft Entra Domain Services instead of Active Directory, the remote clients will need to use the REST API service to submit jobs.
 
For more information, see [Design recommendations for platform access](../../ready/landing-zone/design-area/identity-access-platform-access.md#design-recommendations-for-platform-access) and [Azure identity and access for landing zones](../../ready/landing-zone/design-area/identity-access-landing-zones.md).

### Design considerations for the energy industry

In addition to the preceding considerations, take these considerations into account.

Two common deployment types in oil and gas industry workloads are *cloud only* and *hybrid cloud* models. While it's less complex to have all of your compute, storage, and visualization resources in the cloud, enterprises sometimes use a hybrid model due to multiple business constraints for seismic and reservoir-simulation HPC workloads.

Both the cloud only and hybrid cloud models might have their own unique identity and access needs that affect the type of Active Directory solution to adopt.

Workloads in the cloud only deployment model use Microsoft Entra ID for Azure service fabric authentication, while the HPC hybrid cloud model uses the [Microsoft Entra hybrid identity solution](/azure/active-directory/hybrid/choose-ad-authn) for authentication. Regardless of the deployment type, Linux clients and POSIX-compliant storage solutions require legacy Active Directory support through Microsoft Entra Domain Services.

### Design considerations for the manufacturing industry 

The following diagram shows a manufacturing reference architecture that uses CycleCloud for authentication:

:::image type="content" source="../azure-hpc/media/hpc-identity-access-management-cyclecloud.png" alt-text="Diagram that shows a manufacturing reference architecture that uses Azure CycleCloud." lightbox="../azure-hpc/media/hpc-identity-access-management-cyclecloud.png":::

This diagram shows a manufacturing architecture that uses Batch for authentication: 

:::image type="content" source="../azure-hpc/media/hpc-identity-access-management-batch.png" alt-text="Diagram that shows a manufacturing reference architecture that uses Azure Batch." lightbox="../azure-hpc/media/hpc-identity-access-management-batch.png":::

## Next steps

The following articles provide guidance for various stages of the cloud adoption process. These resources can help you succeed in adopting HPC environments for the cloud.

- [Azure billing offers and Microsoft Entra tenants](../../ready/landing-zone/design-area/azure-billing-microsoft-entra-tenant.md)
- [Management](manage.md)
- [Resource organization](resource-organization.md)
- [Secure](secure.md)
- [Storage](storage.md)
- [HPC landing zone accelerator](azure-hpc-landing-zone-accelerator.md)
- [HPC network topology and connectivity](network-topology-connectivity.md)
- [Compute large-scale HPC application workloads in Azure VMs](compute.md)
