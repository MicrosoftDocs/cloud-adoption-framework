---
title: Azure Red Hat Enterprise Linux landing zone
description: 
author: 
ms.author: 
ms.date: 7/22/2024
ms.topic: 
ms.custom: 
---

# Azure Red Hat Enterprise Linux landing zone accelerator

The Red Hat Enterprise Linux (RHEL) landing zone accelerator is an open-source collection of architectural guidance and reference implementation recommendations that accelerate the migration and deployment of RHEL-based workloads to Microsoft Azure. It provides a recommended architectural approach and reference implementation via infrastructure as code templates that you can use to prepare your landing zones. The landing zones adhere to the architectural best practices of the [Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework/) and the Red Hat Infrastructure Standard.

This series describes the RHEL landing zone and covers key design areas and scenarios that you can use to deploy workloads. The Red Hat Enterprise landing zone is an infrastructure as a service solution. The goal of this series is to promote consistent, repeatable, and secure environment deployments and operations that follow best practices.

## Implement a platform foundation

The Azure RHEL landing zone accelerator assumes that you successfully implemented a platform foundation, which includes the shared services required to deploy and operationalize a landing zone. Shared services include networking, security, identity, and governance.

You don't need a platform foundation to implement a landing zone accelerator. But a platform foundation handles a significant amount of the security and management controls that you need to safely manage your cloud environment. If you already have a platform foundation, you can skip this step. For more information, see [Implement Cloud Adoption Framework Azure landing zone](../../../ready/landing-zone/index.md).

## Landing zone accelerator benefits

The landing zone accelerator approach for Azure RHEL provides:

- A modular approach that you can use to customize your environment variables.
- Design guidelines to evaluate critical decisions.
- The landing zone architecture.
- A Microsoft-recommended reference implementation for RHEL on Azure.

## Design areas

There are many considerations to keep in mind when you create Azure landing zones.

- [Resource organization considerations](./rhel-management-group-sub-organization.md)
- [Identity and access management considerations](./rhel-identity-access-management.md)
- [Network topology and connectivity considerations](./rhel-network-topology-connectivity.md)
- [Business continuity disaster recovery](./rhel-business-continuity-disaster-recovery.md)
- [Security considerations](./rhel-security.md)
- [Governance and compliance considerations](./rhel-governance-compliance.md)
- [Management and monitoring considerations](./rhel-management-monitoring.md)
- [Deployment option considerations](./rhel-management-monitoring.md)

## Reference architecture

The following diagram shows the landing zone accelerator architecture.

:::image type="content" source="./images/rhel-landing-zone-architecture.png" alt-text="Diagram that shows the landing zone accelerator architecture." border="false" lightbox="./images/rhel-landing-zone-architecture.png":::

## Next step

[Identity and access management for your Azure RHEL landing zone](./rhel-identity-access-management.md)
