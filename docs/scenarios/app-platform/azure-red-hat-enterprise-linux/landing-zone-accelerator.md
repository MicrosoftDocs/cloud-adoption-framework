---
title: Azure Red Hat Enterprise Linux landing zone accelerator
description: Learn how to use the Red Hat Enterprise Linux (RHEL) landing zone accelerator to create a consistent, repeatable, and secure environment deployment.
author: parmstro
ms.author: temandin
ms.date: 7/24/2024
ms.topic: conceptual
---

# Azure Red Hat Enterprise Linux landing zone accelerator

The Red Hat Enterprise Linux (RHEL) landing zone accelerator is an open-source collection of architectural guidance and reference implementation recommendations. You can use this guidance to accelerate the migration and deployment of RHEL-based workloads to Microsoft Azure. This article provides a recommended architectural approach and reference implementation via infrastructure as code (IaC) templates that you can use to prepare your landing zones. The landing zones adhere to the architectural best practices of the [Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework/) and Red Hat Infrastructure Standard.

This article is the first article in a series that describes the RHEL landing zone and covers key design areas and scenarios that you can use to deploy workloads. The RHEL landing zone is an infrastructure as a service (IaaS) solution. The goal of this series is to promote consistent, repeatable, and secure environment deployments and operations that follow best practices.

## Implement a platform foundation

The Azure RHEL landing zone accelerator assumes that you successfully implemented a platform foundation, including the shared services that you require to deploy and operationalize a landing zone. Shared services include networking, security, identity, and governance services.

You don't need a platform foundation to implement a landing zone accelerator. But a platform foundation handles a significant amount of the security and management controls that you need to safely manage your cloud environment. If you already have a platform foundation, you can skip this step. For more information, see [Implement an Azure landing zone](../../../ready/landing-zone/index.md).

## Landing zone accelerator benefits

The landing zone accelerator method for Azure RHEL provides:

- A modular approach that you can use to customize your environment variables.
- Design guidelines to evaluate critical decisions.
- The landing zone architecture.
- A Microsoft-recommended reference implementation for RHEL on Azure.

## Design areas

There are many considerations to keep in mind when you create Azure landing zones. Think about considerations for:

- [Identity and access management](./identity-access-management.md)
- [Business continuity and disaster recovery](./business-continuity-disaster-recovery.md)
- [Network topology and connectivity](./network-topology-connectivity.md)
- [Resource organization](./resource-organization.md)
- [Security](./security.md)
- [Management and monitoring](./management-monitoring.md)
- [Governance and compliance](./governance-compliance.md)
- [Deployment options](./platform-automation-devops.md)

## Reference architecture

The following diagram shows the landing zone accelerator architecture.

:::image type="content" source="./images/landing-zone-accelerator/landing-zone-architecture.svg" alt-text="Diagram that shows the landing zone accelerator architecture." border="false" lightbox="./images/landing-zone-accelerator/landing-zone-architecture.svg":::

*Download a [Visio file](https://github.com/Microsoft/CloudAdoptionFramework/tree/main/scenarios/app-platform/azure-rhel/azure-landing-zone-rhel-full-view.vsdx) of this architecture.*

## Next step

[Identity and access management for your Azure RHEL landing zone](./identity-access-management.md)
