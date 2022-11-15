---
title: 'Azure Identity and Access Management| Microsoft Docs'
description: 'This HPC energy scenario article builds on a number of considerations and recommendations defined in the Azure landing zone article Azure landing zone design area for identity and access management.'
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 09/23/2022
---

# Azure Identity and Access Management

This article builds on a number of considerations and recommendations defined in the Azure landing zone article [Azure landing zone design area for identity and access management](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access). Following the guidance in this article will help examine design considerations and recommendations that relate to identity and access management specific to the deployment of an HPC application designed for the financial industry on Microsoft Azure.

[Azure Active Directory](/azure/active-directory-domain-services/overview) Domain Services (Azure ADD) can be employed to make use of managed domain services such as domain join, group policy and access to legacy authentication protocols such as lightweight directory access protocol (LDAP) and Kerberos/NTLM authentication. Azure AD DS integrates with your existing Azure AD tenant. This integration lets users sign into services and applications connected to the managed domain using their existing credentials in Azure AD. You can also use existing groups and user accounts to secure access to resources. These features provide a smoother lift-and-shift of on-premises resources to Azure, especially for a hybrid environment.

For more details, refer to [design recommendations for platform access](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-platform-access#design-recommendations-for-platform-access) and [Azure identity and access for landing zones](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-landing-zones).

## HPC Design Considerations

HPC deployment will leverage the Azure Landing Zone infrastructure setup for its Security Identity and Access Management needs.

Two of the common deployment scenarios in Energy Oil and Gas workloads are Cloud Only and the Cloud Hybrid Model. While it is less complex to have all your resources in the cloud (compute, storage, and visualization), it is not uncommon for our customers to have a Hybrid model due to multiple business constraints for Seismic and Reservoir Simulation HPC workloads.

Both HPC in the Cloud Only and HPC Cloud Hybrid model may have their own unique identity and access needs and consideration on which type of Active Directory solution to adopt.

Such workloads in the Cloud Only deployment model will leverage Azure Active Directory (Azure AD) for Azure fabric authentication, while HPC hybrid deployment model will leverage Microsoft [Azure AD Hybrid solution](/azure/active-directory/hybrid/choose-ad-authn?toc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Farchitecture%2Ftoc.json&bc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Farchitecture%2Fbread%2Ftoc.json) for authentication need based on decision made by cloud team. Independently on the type of deployment, Linux clients and POSIX compliant storage solutions require legacy AD support through Azure Active Directory Domain Services.

A typical HPC setup includes a front-end for submitting jobs, a job scheduler or orchestrator, a compute cluster, and shared storage. The jobs can be submitted from on-premises and/or in the cloud.   IAM considerations for users and visualization devices may vary depending on the enterprise standards.

Review the Azure administration and management activities you require your teams to do. Consider your HPC on Azure landscape. Determine the best possible distribution of responsibilities within your organization.

## HPC Design recommendations

Depending on the chosen HPC Compute Resource Orchestrator, different types of authentication methods are supported:

 - Azure CycleCloud – offers three methods of authentication: a built-in database with encryption, Active Directory, or LDAP.
 - Azure Batch - Batch account access supports two methods of authentication: Shared Key and Azure Active Directory (Azure AD).
 - Microsoft HPC Pack - Currently all HPC Pack nodes must be joined into an Active Directory Domain. If you are deploying the HPC Pack cluster in a virtual network which has a Site-to-Site VPN or ExpressRoute connection with your corporate network, typically there is already an existing Active Directory Domain. If you don't have an AD domain in your virtual network yet, you can choose to create a new AD domain by promoting the head node as domain controller.

## Next steps
The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario for energy HPC environments.
- [Azure billing active directory tenant](./azure-billing-active-directory-tenant.md)
- [Compute](./compute.md)
- [Management](./management.md)
- [Network Topology Connectivity](./network-topology-connectivity.md)
- [Platform Automation DevOps](./platform-automation-devops.md)
- [Resource Organization](./resource-organization.md)
- [Security Governance Compliance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- Back to [landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)

