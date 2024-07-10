---
title: 
description: 
author: 
ms.author: 
ms.date: 
ms.topic: 
ms.custom: 
---

# Resource Organization for Red Hat Deployment on Azure

In organizing a Red Hat deployment on Azure, careful consideration of management groups and subscriptions is crucial for effective governance and resource management.

## Subscription Structure

The components for a Red Hat deployment follow the subscription scaling model outlined in the Azure Cloud Adoption Framework [documentation](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions#organization-and-governance-design-considerations). This model provides extra control and isolation to the management tooling. Specifically, various subscriptions are employed to cater to different aspects of the deployment:

1. **Hub VNet Subscription:** Hosting the Hub virtual network infrastructure in a Hub-Spoke topology, this subscription facilitates secure communication and connectivity among resources within your Red Hat deployment, across other workloads as necessary, and enables hybrid networking for Red Hat deployments. Under the Landing Zone model, this subscription and its resources would reside under the "Connectivity" Management Group.

2. **Red Hat Management Subscription:** This subscription serves as the backbone for identity management components, housing Identity Management primary and replica systems, Red Hat single sign-on instances, Red Hat Satellite, Ansible Automation Platform, and other essential tools. Under the Landing Zone model, this subscription would reside under the "Management" Management Group.

3. **Production Workload Subscription:** Reserved for hosting production-grade workloads, ensuring optimal performance, reliability, and scalability for critical applications. Under the Landing Zone model, this subscription would reside within the "Landing Zones" management group in either "Corp" or "Online" Management Groups depending on the nature of the workload.

4. **Non-production Workload Subscription:** Dedicated to nonproduction environments such as development, testing, and staging, this subscription would contain resources for a non-production environment allowing teams to iterate and validate changes before deployment to production. Under the Landing Zone model, this subscription can reside within the "Landing Zones" management group in either "Corp" or "Online" Management Groups depending on the nature of the workload. If it is for a sandbox environment, it can also reside under the "Sandbox" Management Group.

## Benefits of Multi-Subscription Architecture

Implementing a multi-subscription architecture for your Red Hat deployment offers several key benefits:

- **Enhanced Identity and Access Management(IAM):** Fine-grained control over IAM policies and access controls tailored to specific subscriptions.
- **Effective Policy Enforcement:** Enforcement of Azure Policy and governance standards at the subscription level, ensuring compliance and security.

- **Accurate Billing and Cost Management:** Clear cost allocation and optimization with delineation of costs associated with each subscription.

- **Scalability and Resource Isolation:** Independent scalability and resource isolation for different workloads or projects, minimizing contention and enhancing performance.

## Recommendation

Apply the recommended subscription structure to maximize manageability, governance, and scalability for your Red Hat deployment on Azure. This approach ensures efficient resource utilization, enhanced security, and streamlined operations across your organization.

## Next Steps

- Define subscription boundaries and resource allocation based on organizational requirements and workload characteristics.
- Establish IAM policies, access controls, and Azure Policy enforcement mechanisms at the subscription level.
- Implement budget alerts and cost tracking mechanisms to monitor spending and optimize resource utilization.
