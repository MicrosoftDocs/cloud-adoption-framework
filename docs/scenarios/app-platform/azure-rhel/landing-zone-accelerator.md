---
title: Azure Red Hat Enterprise Linux landing zone
description: 
author: 
ms.author: 
ms.date: 
ms.topic: 
ms.custom: 
---

# Azure Red Hat Enterprise Linux (RHEL) landing zone accelerator

The Red Hat Enterprise Linux landing zone accelerator is an open-source collection of architectural guidance and reference implementation recommendations intended to accelerate the migration and deployment of RHEL-based workloads to Microsoft Azure. It provides a recommended architectural approach and reference implementation via infrastructure-as-code templates that prepare your landing zones. The landing zones adhere to the architectural best practices of the [Cloud Adoption Framework](/azure/cloud-adoption-framework/) and the Red Hat Infrastructure Standard.

This document describes Red Hat Enterprise Linux Landing Zone and covers key design areas and scenario to deploy workloads. The Red Hat Enterprise Landing Zone is an Infrastructure as Service solution. The goal is to promote consistent, secure environment following best practices.

## Implement a platform foundation

The Azure Red Hat Enterprise Linux landing zone accelerator assumes that a platform foundation has been successfully implemented, which includes the shared services required to deploy and operationalize a landing zone. Shared services include networking, security, identity, and governance.

A platform foundation isn't mandatory to implement a landing zone accelerator, but it does handle much of the security and management required to safely manage your cloud environment. If you already have a platform foundation, you can skip this step. For more information, review [Implement Cloud Adoption Framework Azure landing zone](../../../ready/landing-zone/index.md).

## Landing zone accelerator benefits

The landing zone accelerator approach for Azure Red Hat Enterprise Linux provides:

- A modular approach that allows you to customize your environment variables.
- Design guidelines for evaluating critical decisions.
- The landing zone architecture.
- A Microsoft-recommended reference implementation for RHEL on Azure.

## Design areas

There are many issues to consider when creating Azure landing zones.

- [Resource organization considerations](./rhel-management-group-sub-organization.md)
- [Identity and access management considerations](./rhel-identity-access-management.md)
- [Network topology and connectivity considerations](./rhel-network-topology-connectivity.md)
- [Business Continuity Disaster Recovery](./rhel-business-continuity-disaster-recovery.md)
- [Security considerations](./rhel-security.md)
- [Governance and Compliance Considerations](./rhel-governance-compliance.md)
- [Management and Monitoring Considerations](./rhel-management-monitoring.md)
- [Deployment option considerations](./rhel-management-monitoring.md)

## Reference architecture

The following diagram shows the landing zone accelerator architecture.

[![Diagram showing the landing zone accelerator architecture.](./images/rhel-landing-zone-architecture.png)](./images/rhel-landing-zone-architecture.png)

## Next steps

Learn about [identity and access management for your Azure Red Hat Enterprise Linux landing zone](./rhel-identity-access-management.md).
