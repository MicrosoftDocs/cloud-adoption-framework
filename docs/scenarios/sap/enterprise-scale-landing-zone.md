---
title: SAP on Azure landing zone accelerator
description: Learn about SAP on Azure landing zone accelerator.
author: JefferyMitchell
ms.author: brblanch
ms.date: 02/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# SAP on Azure landing zone accelerator

SAP on Azure landing zone accelerator provide specific architectural approach and reference implementation that enables effective construction and operationalization of platform workload landing zones within the Cloud Adoption Framework enterprise-scale landing zone. After you have successfully implemented an enterprise-scale landing zone, they can use SAP on Azure landing zone accelerator. Review the enterprise-scale [overview](../../ready/enterprise-scale/index.md) and [implementation guidance](../../ready/enterprise-scale/implementation.md) before deploying SAP on Azure landing zone accelerator.

## Adopt SAP on Azure landing zone accelerator

Not all customers adopt SAP on Azure in the same way. The SAP on Azure landing zone accelerator architecture varies between customers. The technical considerations and design recommendations of SAP on Azure landing zone accelerator might lead to different trade-offs based on your organization's scenario. If you follow the core recommendations, the resulting architecture sets your organization on a path to a sustainable scale. The SAP on Azure landing zone accelerator is modular by design. You can customize environmental variables. This solution approach to landing zones includes three sets of assets to support cloud teams:

- [Design guidelines](#design-guidelines)
- [Architecture](#architecture)
- [Implementation](#implementation)

## Design guidelines

You have to make critical decisions that drive the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone. Consider these six critical design areas:

- [Identity and access management](./eslz-identity-and-access-management.md)
- [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
- [Management and monitoring](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps](./eslz-platform-automation-and-devops.md)

## Architecture

The following image shows a conceptual reference architecture that demonstrates design areas:

:::image type="content" source="./media/overview-architecture.png" alt-text="A diagram depicting the SAP on Azure landing zone accelerator conceptual reference architecture." lightbox="./media/overview-architecture.png":::

## Implementation

The **SAP on Azure deployment automation framework** is a collection of processes combined with a flexible workflow. The [SAP deployment automation framework repository](https://github.com/Azure/sap-hana) has code that automatically deploys SAP landscapes in the Azure cloud.

The templates are split into two categories:

- Terraform modules deploy the infrastructure components in Azure:
  - VMs
  - Network
  - Storage
- Ansible playbooks run different roles to:
  - Set up and deploy VMs
  - Install SAP HANA
  - Install other required applications

Deploy and install the Ansible playbook components on the infrastructure that the Terraform modules built.

![Diagram showing an overview of a SAP reference implementation.](./media/overview-automation.png)

## Next steps

Review the design areas of SAP on Azure landing zone accelerator that are critical to making complete considerations and recommendations for your SAP on Azure landing zone accelerator architecture:

- [Identity and access management](./eslz-identity-and-access-management.md)
