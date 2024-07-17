---
title: Resource organization for Red Hat Enterprise Linux on Azure
description: Learn about key design considerations and recommendations for resource organization in RHEL on Azure infrastructure.
author: moisesjgomez, Paul Armstrong, and Mike Savage
ms.author: mgomezcortez
ms.date: 04/03/2024
ms.topic: conceptual
---

# Resource organization for a Red Hat deployment on Azure

When you organize a Red Hat deployment on Azure, carefully consider management groups and subscriptions to ensure that you effectively govern and manage resources.

## Subscription structure

The components for a Red Hat deployment follow the [subscription scaling model](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions#organization-and-governance-design-considerations). This model provides extra control and isolation to the management tooling. Specifically, various subscriptions cater to different aspects of a deployment, for example:

- **Hub virtual network subscriptions** host the hub virtual network infrastructure in a hub-spoke topology. This subscription facilitates secure communication and connectivity among resources within a Red Hat deployment and across other workloads as necessary. It provides hybrid networking for Red Hat deployments. Under the landing zone model, this subscription and its resources reside under the Connectivity management group.

- **Red Hat Management subscriptions** serve as the backbone for identity management components. They house Red Hat IdM primary and replica systems, Red Hat Single Sign-on (SSO) instances, Red Hat Satellite, Ansible Automation Platform, and other essential tools. Under the landing zone model, this subscription resides under the Management management group.

- **Production Workload subscriptions** host production-grade workloads to ensure optimal performance, reliability, and scalability for critical applications. Under the landing zone model, this subscription resides within the Landing Zones management group in either Corp or online management groups, depending on the nature of the workload.

- **Non-production Workload subscriptions** are for nonproduction environments, such as development, testing, and staging. This subscription contains resources for a nonproduction environment so that teams can iterate and validate changes before deployment to production. Under the landing zone model, this subscription resides within the Landing Zones management group in either Corp or Online management groups, depending on the nature of the workload. If you use this subscription as a sandbox environment, you can put it under the Sandbox management group.

## Benefits of a multi-subscription architecture

Implement a multi-subscription architecture for your Red Hat deployment to get:

- **Enhanced identity and access management (IAM)**: Get fine-grained control over IAM policies and access controls that are tailored to specific subscriptions.

- **Effective policy enforcement**: Enforce Azure Policy and governance standards at the subscription level to ensure compliance and security.

- **Accurate billing and cost management**: View clear cost allocation and optimization with delineation of costs that are associated with each subscription.

- **Scalability and resource isolation**: Get independent scalability and resource isolation for various workloads or projects to minimize contention and enhance performance.

## Recommendation

Apply the recommended subscription structure to maximize manageability, governance, and scalability for your Red Hat deployment on Azure. This approach ensures efficient resource utilization, enhanced security, and streamlined operations across your organization.

## Next steps

- Define subscription boundaries and resource allocation based on organizational requirements and workload characteristics.

- Establish IAM policies, access controls, and Azure Policy enforcement mechanisms at the subscription level.
- Implement budget alerts and cost tracking mechanisms to monitor spending and optimize resource utilization.
