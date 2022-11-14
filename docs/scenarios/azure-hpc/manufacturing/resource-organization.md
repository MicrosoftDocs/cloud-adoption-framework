---
title: 'Manufacturing HPC Resource organization | Microsoft Docs'
description: 'To align with the Ready methodology of the Cloud Adoption Framework, implement a naming and tagging strategy that includes business and operational details as components of resource names and metadata tags.'
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 09/23/2022
---

# Resource organization for manufacturing HPC

To align with the [Ready methodology](/azure/cloud-adoption-framework/ready/) of the Cloud Adoption Framework, implement a naming and tagging strategy that includes business and operational details as components of resource names and metadata tags.

## Use single vs multiple Azure subscriptions.

 - In Azure Active Directory (Azure AD), a tenant is representative of an organization. It is a dedicated instance of the Azure AD service that an organization receives and owns when it signs up for using Azure. Each Azure AD tenant is distinct and separate from other Azure AD tenants. An Azure tenant can have multiple subscriptions and each subscription can use the same Azure AD. 
 - You can choose single vs multiple subscription based on the organizations needs.
     - Multiple Subscriptions allow for easy view billing for each subscription and limit who can access the Microsoft Azure services associated with that subscription – for example production vs non-production subscriptions, internal vs external etc.
     - Having multiple subscriptions helps in planning for subscriptions limits.  
     - You can learn more about the decision-making process for subscriptions here.
     - We also recommend that you consider ARM throttling limits while choosing to go with multiple vs single subscription, you can learn more about it here.

## Use Azure resource naming and tagging conventions

The business side of this strategy ensures that resource names and tags include the organizational information you need to identify the teams. Use a resource name along with the business owners who are responsible for resource costs. The operational side ensures that names and tags include information that IT teams use to identify the workload, application, environment, criticality, and other useful information for managing resources.

Resources to name include VMs, load balancers, DNS labels, availability sets, virtual networks, subnets, ExpressRoute, NSGs, application security groups, tags, route tables, managed disks, and public IPs. A sample use case could be to tag all Azure development VMs with the tag Dev. This will ease reporting and billing operations to pull a report for all things Dev. For more information, see [Develop your naming and tagging strategy for Azure resources](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging).

## Next steps
The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario for energy HPC environments.
- [Azure billing active directory tenant](./azure-billing-active-directory-tenant.md)
- [Identity Access Management](./identity-access-management.md)
- [Management](./management.md)
- [Network Topology Connectivity](./network-topology-connectivity.md)
- [Platform Automation DevOps](./platform-automation-devops.md)
- [Security Governance Compliance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- Back to [landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
