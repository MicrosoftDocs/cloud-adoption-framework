---
title: Resource organization considerations for SAP in Azure
description: Evaluate how resources will be organized when deploying SAP to Azure.
author: JeffreyMitchell
ms.author: brblanch
ms.date: 3/12/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

<!-- docutune:casing "Azure Fence Agent" -->
<!-- docutune:ignore DB -->

# Resource organization for SAP on Azure

To align with the [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework, implement a naming and tagging strategy that includes business and operational details as components of resource names and metadata tags.

## Use Azure resource naming and tagging conventions

The business side of this strategy ensures that resource names and tags include the organizational information you need to identify the teams. Use a resource name along with the business owners who are responsible for resource costs. The operational side ensures that names and tags include information that IT teams use to identify the workload, application, environment, criticality, and other useful information for managing resources.

Resources to name include VMs, load balancers, DNS labels, availability sets, virtual networks, subnets, ExpressRoute, NSGs, application security groups, tags, route tables, managed disks, and public IPs. A sample use case could be to tag all Azure development VMs with the tag `Dev`. This eases reporting and billing operations to pull a report for all things `Dev`. For more information, see [Develop your naming and tagging strategy for Azure resources](../../ready/azure-best-practices/naming-and-tagging.md).