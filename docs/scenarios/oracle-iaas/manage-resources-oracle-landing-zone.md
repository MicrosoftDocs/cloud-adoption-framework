---
title: Organize resources for Oracle on Azure VMs landing zone accelerator
description: Learn about organizing resources for Oracle on Azure VMs landing zone accelerator.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 01/10/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
---

# Organize resources for Oracle on Azure VMs landing zone accelerator

To align with the Ready methodology of the Cloud Adoption Framework, implement a naming and tagging strategy that includes business and operational details as components of resource names and metadata tags. 

## Use Azure resource naming and tagging conventions

The business side of this strategy ensures that resource names and tags include the organizational information you need to identify the teams. Use a resource name along with the business owners who are responsible for resource costs.

 The operational side ensures that names and tags include information that IT teams use to identify the workload, application, environment, criticality, and other useful information for managing resources.

Resources to name include VMs, storage, availability sets, virtual networks, subnets, ExpressRoute, NSGs, application security groups, tags. A sample use case could be to tag all Azure development VMs with the tag Dev. This naming convention eases reporting and billing operations to pull a report for all things Dev. For more information, see Develop your naming and tagging strategy for Azure resources.

## Key Azure resources required for Oracle workload

The two key resources required to migrate Oracle to Azure are Azure VMs & Storage. From AWR report, using OMAT (Oracle Migration Assistance Tool), you can determine the right SKU, size of the VM along with optimal storage option. Once you have your VM and storage recommendations, please do follow the naming and tagging conventions.

Since Oracle products are usually licensed by processor core, selecting a VM with the least number of suitable cores provides the best licensing savings for the customers.

## Next steps

- [Strategic impact of Oracle on Azure landing zone accelerator](oracle-landing-zone-strategy.md)  
- [Plan for Oracle on Azure landing zone accelerator](oracle-landing-zone-plan.md)  
- [Oracle on Azure landing zone accelerator](intro-oracle-landing-zone.md) 