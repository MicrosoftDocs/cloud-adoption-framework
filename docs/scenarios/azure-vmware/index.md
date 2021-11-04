---
title: Introduction to the Azure VMware Solution adoption scenario
description: Learn about the Azure VMware Solution adoption scenario
author: mpvenables
ms.author: janet
ms.date: 09/02/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-azure-vmware, think-tank
---

# Migrate to Azure with Azure VMware Solution

Azure VMware Solution provides your organization with options when migrating to Azure. Migrating VMware resources from on-premises datacenters to a dedicated cloud environment on Azure can lower complexity, help you to minimize negative impacts to business continuity, and reduce the time required for your migration. Azure VMware Solution enables you to adopt cloud technology at a pace that matches your organization's requirements, adding cloud services incrementally as your business evolves.

## Microsoft Azure VMware Solution

Azure VMware Solution is a first party Microsoft Azure service built with VMware that delivers a familiar vSphere-based, single-tenant, private cloud on Azure. The VMware technology stack includes vSphere, NSX-T, vSAN, and HCX. Running natively on dedicated infrastructure in Azure datacenters, Azure VMware Solution provides a consistent experience to customers with existing on-premises VMware environments. Customers can set up the environment in hours, and quickly migrate virtual machine (VM) resources. Microsoft operates and supports the Azure VMware Solution environment and all necessary networking, storage, and management services.

## Common customer journeys

- **Migrating VMware workloads to Azure:** the market reality is that organizations are moving to the cloud. The driving force for this migration timeline may be a need to quickly exit a datacenter, or scale your business capabilities beyond existing infrastructure. However, how your organization chooses to approach migration can vary significantly. For large businesses with existing VMware investments, it's important to maintain operational consistency for VMware environments in Azure.
- **Extending hybrid and multicloud agility:** customers seek common configurations like hybrid VMware architectures when adopting Azure VMware Solution. Organizations are looking to increase agility between resources on-premises and in the cloud by extending vSphere-based VMware environments to Azure. Hybrid and multicloud capabilities enable resource management consistency across on-premises and cloud environments and modernize applications by connecting them to Azure-native cloud services.
- **Cost-optimizing licensing and billing:** in their migration journey, customers should consider how to best take advantage of on-premises licensing and billing to maximize their cloud investment. Microsoft offers Azure Hybrid Benefit, and Extended Security Updates for some versions of Windows and SQL Server. These extended security updates and licensing benefits are extended to Azure VMware Solution. With many VMware workloads now running on Windows and SQL Server, customers can benefit from License Mobility - and reduce the economic impact of a cloud migration project. Centralized billing and support on Azure VMware Solution simplifies the tracking and management of cloud spend.
- **Developing cloud skilling:** Your organization's IT team has a great deal of expertise across on-premises systems like VMware. With the addition of cloud, many of these roles need retraining and more process improvements to adopt and manage new technologies. Developing these cloud competencies can be a significant investment in your time and resources. Because Azure VMware Solution provides consistency with how VMware resources are managed on-premises, there's little to no change required. Through a seamless connection to other Azure services, such as Azure Storage solutions, Azure hybrid identity, and monitoring and security services organizations can grow competencies incrementally in necessary cloud-focused up-skilling and cross-skilling.

## Components of the scenario

This scenario is designed to guide the end-to-end customer journey, throughout the cloud adoption lifecycle. Completing the journey requires a few key guidance sets:

- **Cloud Adoption Framework:** These articles walk through the [considerations and recommendations of each CAF methodology](../../overview.md). Use these articles to prepare decision makers, central IT, and the cloud center of excellence for adoption of Azure VMware Solution.
- **Reference architectures:** These [reference solutions](/azure/architecture/browse/) help to accelerate the deployment of Azure VMware Solution.
- **Featured Azure products:** Learn more about the [products that support your VMware strategy](/azure/azure-vmware/integrate-azure-native-services) in Azure.
- **Microsoft Learn modules:** Get the [hands-on skilling required](/learn/paths/run-vmware-workloads-azure-vmware-solution/) to implement, maintain, and support Azure VMware Solution.

## Next steps

Cloud adoption best practices encourage customers to create a single, centralized cloud adoption strategy by using the Cloud Adoption Framework's Strategy methodology. The next article outlines technical considerations of Azure VMware Solution that might affect your strategy.

> [!div class="nextstepaction"]
> [Strategic impact of Azure VMware Solution](./strategy.md)
