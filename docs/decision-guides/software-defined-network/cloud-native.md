---
title: "Software Defined Networking: Cloud-native"
description: Use the Cloud Adoption Framework for Azure to learn about cloud-native virtual networks, which are required for deploying VMs to the cloud.
author: alexbuckgit
ms.author: abuck
ms.date: 02/11/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: decision-guide
ms.custom: internal
---

# Software Defined Networking: Cloud-native

A cloud-native virtual network is required when deploying IaaS resources such as virtual machines to a cloud platform. Access to virtual networks from external sources, similar to the web, need to be explicitly provisioned. These types of virtual networks support the creation of subnets, routing rules, and virtual firewall and traffic management devices.

A cloud-native virtual network has no dependencies on your organization's on-premises or other non-cloud resources to support the cloud-hosted workloads. All required resources are provisioned either in the virtual network itself or by using managed PaaS offerings.

## Cloud-native assumptions

Deploying a cloud-native virtual network assumes the following:

- The workloads you deploy to the virtual network have no dependencies on applications or services that are accessible only from inside your on-premises network. Unless they provide endpoints accessible over the public internet, applications and services hosted internally on-premises are not usable by resources hosted on a cloud platform.
- Your workload's identity management and access control depends on the cloud platform's identity services or IaaS servers hosted in your cloud environment. You will not need to directly connect to identity services hosted on-premises or other external locations.
- Your identity services do not need to support single sign-on (SSO) with on-premises directories.

Cloud-native virtual networks have no external dependencies. This makes them simple to deploy and configure, and as a result this architecture is often the best choice for experiments or other smaller self-contained or rapidly iterating deployments.

Additional issues your cloud adoption teams should consider when discussing a cloud-native virtual networking architecture include:

- Existing workloads designed to run in an on-premises datacenter may need extensive modification to take advantage of cloud-based functionality, such as storage or authentication services.
- Cloud-native networks are managed solely through the cloud platform management tools, and therefore may lead to management and policy divergence from your existing IT standards as time goes on.

## Next steps

For more information about cloud-native virtual networking in Azure, see:

- [Azure Virtual Network guides](/azure/virtual-network/virtual-network-vnet-plan-design-arm): Newly created virtual networks are cloud-native by default. Use these guides to help plan the design and deployment of your virtual networks.
- [Azure networking limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#networking-limits): Each virtual network and connected resources exists in a single subscription. These resources bound by subscription limits.
