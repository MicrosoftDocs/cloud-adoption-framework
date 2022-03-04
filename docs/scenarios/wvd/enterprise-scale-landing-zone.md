---
title: Enterprise-scale support for Azure Virtual Desktop
description: Learn how enterprise-scale support for the Azure Virtual Desktop construction set can accelerate the adoption of Azure Virtual Desktop.
author: wahidsaleemi
ms.author: wasaleem
ms.date: 03/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Enterprise-scale support for Azure Virtual Desktop

Azure Virtual Desktop (AVD) Landing Zone Accelerator provides you with a specific architectural approach and reference implementation. This solution provides an architectural approach and reference implementation to prepare landing zone subscriptions for an enterprise Azure Virtual Desktop (AVD) deployment. The implementation adheres to the architecture and best practices of the Cloud Adoption Framework's Azure landing zones with a focus on the design principles of enterprise-scale. This solution is used after you've implemented an enterprise-scale landing zones. Review the [enterprise-scale overview](../../ready/enterprise-scale/index.md) and [implementation guidance](../../ready/enterprise-scale/implementation.md) before deploying the enterprise-scale for Azure Virtual Desktop solution.

This solution is open source. You can adapt the templates to create an architecture that meets your needs. The following guidance provides design considerations for implementing an enterprise ready AVD deployment in your landing zone.

## Adopt Azure Virtual Desktop Landing Zone Accelerator

Not everyone adopts Azure Virtual Desktop in the same way and architectures vary between organizations. The technical considerations and design recommendations of the construction set might result in trade-offs based on your organization's needs. Some variation happens, but if you follow the core recommendations, the resulting architecture prepares your organization for sustainable scale. The Azure Virtual Desktop Landing Zone Accelerator is modular by design so that you can customize environment variables.

### Design guidelines

Learn about guidelines that drive the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone. There are eight critical design areas:

- [Enterprise enrollment](./eslz-enterprise-enrollment.md)
- [Identity and access management](./eslz-identity-and-access-management.md)
- [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
- [Resource organization](./eslz-resource-organization.md)
- [Management and monitoring](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps](./eslz-platform-automation-and-devops.md)

### Architecture

The following image shows a conceptual reference architecture that demonstrates design areas and best practices.

[![A diagram of a reference architecture for an Azure Virtual Desktop environment.](./media/azure-virtual-desktop-architecture.png)](./media/azure-virtual-desktop-architecture.png#lightbox)

## Deploy Azure Virtual Desktop Landing Zone Accelerator

AVD Landing Zone Accelerator includes an open source collection of Azure Resource Manager, Bicep and Terraform templates, available in the [`AVD Accelerator`](https://github.com/Azure/avdaccelerator) repo.

These templates are used to deploy infrastructure components such as virtual machines, networks, and storage to Azure. To get the templates, see the [`AVD Accelerator`](https://github.com/Azure/avdaccelerator) repo. There, you will find scenarios to help get you started on setting up your AVD environment quickly. Conceptually, this workload should sit in the landing zones management group of an enterprise-scale landing zones deployment and be connected to the hub.

### Custom deployments

The [automate Azure Virtual Desktop deployments in Azure](https://github.com/Azure/RDS-Templates/tree/master/ARM-wvd-templates) GitHub repository contains code that lets you deploy Azure Virtual Desktop environments in the Azure cloud.

## Next steps

Review the critical design considerations and recommendations related to identity and access management specific to the deployment of Azure Virtual Desktop.

> [!div class="nextstepaction"]
> [Identity and access management](./eslz-identity-and-access-management.md)
