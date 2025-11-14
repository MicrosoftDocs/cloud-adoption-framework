---
title: Azure Integration Services application landing zone accelerator
description: Learn to deploy the Azure Integration Services application landing zone accelerator in an Azure landing zone.
author: stephen-sumner
ms.author: pnp
ms.date: 10/13/2025
ms.topic: concept-article
---

# Azure Integration Services application landing zone accelerator in an Azure landing zone

This article provides strategic guidance for deploying Azure Integration Services (AIS) within an Azure landing zone. Azure Integration Services includes Logic Apps, API Management, Service Bus, and Event Grid. These services enable scalable integration across applications, data, and business processes. The AIS application landing zone accelerator automates the deployment of these services, which promotes consistency and scalability while aligning with Azure landing zone standards.

[![Diagram that shows Azure Integration Services landing zone accelerator architecture.](./media/integration-services-enterprise-deployment_highres.png)](./media/integration-services-enterprise-deployment_highres.png#lightbox)

## Establish an Azure landing zone

**Start with an Azure landing zone.** Begin with a foundational [Azure landing zone](../../../ready/landing-zone/index.md) that includes shared services such as identity, networking, and monitoring. Centralized platform teams must own and operate these services to enforce governance, security, and compliance policies across all workloads. This separation of responsibilities allows workload teams to focus on delivering business value through application development without duplicating platform capabilities.

**Understand integration points.** Integration workloads often depend on shared resources like virtual networks, identity providers, and observability tools. Establish clear communication channels between platform and workload teams to align on resource planning. For example, if a workload requires high throughput, the platform team must allocate sufficient IP address space and bandwidth early in the planning cycle. This coordination reduces rework and accelerates deployment timelines.

## How to use the AIS application landing zone accelerator

**Review the architecture diagram.** The architecture diagram illustrates how AIS components integrate within an Azure landing zone. Review this visualization with stakeholders to evaluate tradeoffs in scalability, security, and maintainability. Use the diagram to guide decisions about service boundaries, data flow, and governance controls.

**Deploy the reference implementation.** The GitHub hosted [AIS application landing zone accelerator](https://github.com/Azure/Integration-Services-Landing-Zone-Accelerator/blob/main/docs/scenario1/Reference%20Implementation.md) provides a working environment that includes preconfigured services, governance policies, and automation scripts. Use this implementation to validate architecture decisions, onboard development teams, and begin integration development immediately. This approach reduces setup time and ensures alignment with enterprise standards.

## Next steps

The design areas provide recommendations across key technical domains that Integration workloads must align with enterprise governance models across identity, networking, security, management, and compliance. Use the following design area guidance to ensure consistency and reduce risk:

- [Identity and access management](./identity-and-access-management.md)
- [Network topology and connectivity](./network-topology-and-connectivity.md)
- [Security](./security.md)
- [Management](./management.md)
- [Governance](./governance.md)
