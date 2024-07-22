---
title: Resource organization for Red Hat Enterprise Linux on Azure
description: Learn about key design considerations and recommendations for resource organization in RHEL on Azure infrastructure.
author: moisesjgomez
ms.author: mgomezcortez
ms.date: 07/24/2024
ms.topic: conceptual
---

# Resource organization for Red Hat Enterprise Linux on Azure

When you organize a Red Hat Enterprise Linux (RHEL) deployment on Azure, carefully consider management groups and subscriptions to ensure that you effectively govern and manage resources.

## Subscription structure

The components for a RHEL deployment follow the [subscription scaling model](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions#organization-and-governance-design-considerations). This model provides extra control and isolation for the management tooling. Various subscriptions cater to different aspects of a deployment, for example:

- **Hub virtual network subscriptions** host the hub virtual network infrastructure in a hub-spoke topology. This subscription facilitates secure communication and connectivity among resources within a RHEL deployment and across other workloads as necessary. It provides hybrid networking for RHEL deployments. Under the landing zone model, this subscription and its resources reside in the Connectivity management group.

- **Red Hat Management subscriptions** serve as the backbone for identity management components. They house Red Hat IdM primary systems and replica systems, Red Hat Single Sign-on (SSO) instances, Red Hat Satellite, Ansible Automation Platform, and other essential tools. Under the landing zone model, this subscription resides in the Management management group.

- **Production Workload subscriptions** host production-grade workloads to ensure optimal performance, reliability, and scalability for critical applications. Under the landing zone model, this subscription resides in the Landing Zones management group, which is in either the Corp or Online management group, depending on the nature of the workload.

- **Nonproduction Workload subscriptions** are for nonproduction environments, such as development, testing, and staging. This subscription contains resources for a nonproduction environment so that teams can iterate and validate changes before deployment to production. Under the landing zone model, this subscription resides in the Landing Zones management group, which is in either the Corp or Online management group, depending on the nature of the workload. If you use this subscription as a sandbox environment, you can place it in the Sandbox management group.

## Benefits of a multi-subscription architecture

Implement a multi-subscription architecture for your RHEL deployment to get:

- **Enhanced identity and access management (IAM)**: Have fine-grained control over IAM policies and access controls that are tailored to specific subscriptions.

- **Effective policy enforcement**: Enforce Azure Policy and governance standards at the subscription level to ensure compliance and security.

- **Accurate billing and cost management**: Provide clear cost allocation and optimization with a breakdown of costs that are associated with each subscription.

- **Scalability and resource isolation**: Get independent scalability and resource isolation for various workloads or projects to minimize contention and enhance performance.

Apply the recommended subscription structure to maximize manageability, governance, and scalability for your RHEL deployment on Azure. This approach ensures efficient resource usage, enhanced security, and streamlined operations across your organization.

## Next steps

- Define subscription boundaries and resource allocation based on organizational requirements and workload characteristics.

- Establish IAM policies, access controls, and Azure Policy enforcement mechanisms at the subscription level.
- Implement budget alerts and cost tracking mechanisms to monitor spending and optimize resource usage.
