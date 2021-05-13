---
title: Enterprise-scale support for Windows Virtual Desktop
description: Learn how enterprise-scale support for the Windows Virtual Desktop Construction Set can accelerate the adoption of Windows Virtual Desktop.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise-scale support for the Windows Virtual Desktop Construction Set

Enterprise-scale construction sets provide you with a specific architectural approach and reference implementation. These construction sets enable effective construction and start-up of platform workload landing zones. These landing zones are within the Cloud Adoption Framework enterprise-scale landing zone. The Windows Virtual Desktop Construction Set is used after you've implemented an enterprise-scale landing zone. Review the enterprise-scale [Overview](/azure/cloud-adoption-framework/ready/enterprise-scale/) and [implementation guidance](/azure/cloud-adoption-framework/ready/enterprise-scale/implementation) before deploying the Windows Virtual Desktop Construction Set.

## Getting started with the Windows Virtual Desktop Construction Set

Not everyone adopts Windows Virtual Desktop on Azure in the same way. The Cloud Adoption Framework for Azure enterprise-scale construction set architecture varies between organizations. The technical considerations and design recommendations of the construction set might result in trade-offs based on your organization's needs. Some variation happens, but if you follow the core recommendations, the resulting architecture prepares your organization for sustainable scale. The construction set is modular by design so that you can customize environmental variables. The construction set approach to landing zones includes three sets of assets to support cloud teams.

### Design guidelines

Learn about guidelines that drive the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone. There are six critical design areas:

- [Identity and Access Management](./eslz-identity-and-access-management.md)
- [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
- [Management and monitoring](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps](./eslz-platform-automation-and-devops.md)

### Architecture

The following image shows a conceptual reference architecture that demonstrates design areas and best practices.

![Construction Set Architecture](media\windowsvirtualdesktoparchitecture.png)

### Implementation with Azure Resource Manager (ARM) Templates for Remote Desktop Services

ARM Windows Virtual Desktop Templates are a collection of the Infrastructure as Code ARM Template to deploy a Windows Virtual Desktop environment on Azure.

The [Automate Windows Virtual Desktop deployments in Azure Cloud](https://github.com/Azure/RDS-Templates/tree/master/ARM-wvd-templates) GitHub repository contains code that can be used to automatically deploy Windows Virtual Desktop environments in the Azure Cloud.

## Next steps

Review the Windows Virtual Desktop Construction Set critical design areas to make considerations and recommendations for your Windows Virtual Desktop Construction Set architecture.

> [!div class="nextstepaction"]
> [Identity and Access Management](./eslz-identity-and-access-management.md)
