---
title: SAP on Azure landing zone accelerator
description: Learn about SAP on Azure landing zone accelerator.
author: JefferyMitchell
ms.author: brblanch
ms.date: 05/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# SAP on Azure landing zone accelerator

SAP on Azure landing zone accelerator enables effective construction and operationalization of platform workload landing zones within the Cloud Adoption Framework enterprise-scale landing zone by providing a specific architectural approach and reference implementation. You can use SAP on Azure landing zone accelerator after you successfully implement an enterprise-scale landing zone. Review the [enterprise-scale overview](../../ready/enterprise-scale/index.md) and [implementation guidance](../../ready/enterprise-scale/implementation.md) before you deploy SAP on Azure landing zone accelerator.

## Adopt SAP on Azure landing zone accelerator

Architecture for SAP on Azure landing zone accelerator varies from customer to customer. Technical considerations and SAP on Azure landing zone accelerator design recommendations can lead to trade-offs based on each organization's particular scenario. Follow the core recommendations to find an architecture that sets your organization on a path to sustainable scaling. SAP on Azure landing zone accelerator is modular by design, and you can customize environmental variables. This solution approach to landing zones includes the following assets to support your cloud teams:

- [Design guidelines](#design-guidelines)
- [Architecture](#architecture)
- [Implementation](#implementation)

## Design guidelines

You must make critical decisions that drive the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone. Consider these six critical design areas:

- [Identity and access management](./eslz-identity-and-access-management.md)
- [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
- [Management and monitoring](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps](./eslz-platform-automation-and-devops.md)

## Architecture

The following diagram is a conceptual reference architecture that shows the six critical design areas:

:::image type="content" source="./media/overview-architecture.png" alt-text="A diagram depicting the SAP on Azure landing zone accelerator conceptual reference architecture." lightbox="./media/overview-architecture.png":::

## Implementation

The **SAP on Azure deployment automation framework** is a collection of processes combined with a flexible workflow. The [SAP deployment automation framework repository](https://github.com/Azure/sap-hana) contains code for automatic deployment of SAP landscapes in the Azure cloud. Templates are split into the following categories:

- Terraform modules. These deploy infrastructure components in Azure, and they include:
  - VMs
  - Network
  - Storage
- Ansible playbooks. These run various that can:
  - Set up and deploy VMs
  - Install SAP HANA
  - Install other required applications

Deploy and install Ansible playbook components on the infrastructure that the Terraform modules build.

![Diagram showing an overview of a SAP reference implementation.](./media/overview-automation.png)

## Next steps

Review the design areas of SAP on Azure landing zone accelerator that provide considerations and recommendations for your SAP on Azure landing zone accelerator architecture.

- [Identity and access management](./eslz-identity-and-access-management.md)
