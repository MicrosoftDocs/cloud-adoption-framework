---
title: Azure identity and access management for energy HPC
description: Learn about identity and access management for high-performance computing (HPC) using this energy industry scenario that builds on the Azure landing zone design area.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 11/09/2022
---

# Azure identity and access management for energy HPC

The guidance in this article can help you examine design considerations and recommendations that relate to identity and access management for high-performance computing (HPC). This scenario is specific to the deployment of an HPC application for the energy industry. For more information about design considerations and recommendations, see the [Azure landing zone design area for identity and access management](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access).

[Azure Active Directory Domain Services](/azure/active-directory-domain-services/overview) (Azure AD DS) can make use of managed domain services such as domain join, group policy, and access to legacy authentication protocols like lightweight directory access protocol (LDAP) and Kerberos/NTLM authentication. Azure AD DS integrates with your existing Azure Active Directory (Azure AD) tenant, so users can sign into services and applications connected to the managed domain using their Azure AD credentials. You can also use existing groups and user accounts to secure access to resources. These features provide a smoother lift-and-shift of on-premises resources to Azure, especially for a hybrid environment.

For more information, see [design recommendations for platform access](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-platform-access#design-recommendations-for-platform-access) and [Azure identity and access for landing zones](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-landing-zones).

## Design considerations

HPC deployment uses the Azure landing zone infrastructure setup for security identity and access management needs.

Two common deployment types in oil and gas industry workloads are *cloud only* and *hybrid cloud* models. While it's less complex to have all of your compute, storage, and visualization resources in the cloud, our customers sometimes use a hybrid model due to multiple business constraints for seismic and reservoir-simulation HPC workloads.

Both the cloud only and hybrid cloud models might have their own unique identity and access needs that affect which type of active directory solution to adopt.

Workloads in the cloud only deployment model use Azure AD for Azure service fabric authentication, while the HPC hybrid cloud model uses the [Azure AD hybrid identity solution](/azure/active-directory/hybrid/choose-ad-authn) for authentication. Regardless of the deployment type, Linux clients and POSIX-compliant storage solutions require legacy active directory support through Azure AD DS.

A typical HPC setup includes a frontend for submitting jobs, a job scheduler or orchestrator, a compute cluster, and shared storage. The jobs can be submitted from on-premises and/or in the cloud. Identity and access management considerations for users and visualization devices might vary depending on the enterprise standards.

Review the Azure administration and management activities that you require from your teams. Consider your HPC needs on Azure resources. Determine the best possible distribution of responsibilities within your organization.

## Design recommendations

Depending on the HPC compute resource orchestrator that you choose, different types of authentication methods are supported:

- [Azure CycleCloud](/azure/cyclecloud/overview) offers three methods of authentication: a built-in database with encryption, active directory, or LDAP.
- [Azure Batch](/azure/batch/batch-technical-overview) supports two methods of authentication: shared key and Azure AD.
- [Microsoft HPC Pack](/powershell/high-performance-computing/overview-of-microsoft-hpc-pack): Currently all HPC Pack nodes must be joined into an active directory domain. If you deploy the HPC Pack cluster in a virtual network that has a site-to-site VPN or ExpressRoute connection with your corporate network, there's usually an existing active directory domain. If you don't have an active directory domain in your virtual network yet, you can choose to create one by promoting the head node as domain controller.

## Next steps

The following articles provide guidance for specific steps in the cloud adoption journey for energy HPC environments.

- [Azure billing and Azure Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Compute](./compute.md)
- [Management](./management.md)
- [Network topology and connectivity](./network-topology-connectivity.md)
- [Platform automation and DevOps](./platform-automation-devops.md)
- [Resource organization](./resource-organization.md)
- [Governance and compliance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- [HPC landing zone accelerator](../azure-hpc-landing-zone-accelator.md)
