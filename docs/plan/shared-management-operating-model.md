---
title: Shared management cloud operating model
description: Learn how to adopt a shared management cloud operating model to balance agility and control in Azure as well as hybrid and multi-cloud environments.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: conceptual
---

# Shared management cloud operating model

A shared management operating model enables organizations to scale cloud adoption while maintaining governance and agility. This model becomes more effective when platform teams adopt a product mindset, delivering reusable, self-service capabilities that accelerate workload team success. This approach aligns with the emerging industry trend of platform engineering, where internal platform teams build and operate shared services as products for the rest of the organization.

## Implement a shared management operating model

A shared management operating model balances central control with distributed responsibility across cloud and on-premises environments. This balance enables organizations to maintain governance standards while allowing teams to work at their preferred pace. You need to establish clear boundaries between platform capabilities and workload operations to achieve consistent management across hybrid and multi-cloud estates. Follow this guidance:

1. **Establish platform teams to provide shared cloud services and governance.** Platform teams create and maintain core capabilities that all workloads require, such as Azure governance, subscription provisioning, hub networking, and developer tooling. These centralized services ensure consistency, security, and scalability across your entire cloud estate. In hybrid environments, these teams coordinate with traditional IT teams to align governance practices across all technology environments.

2. **Delegate subscription and workload operations to workload teams.** Workload teams manage their own cloud environments within the boundaries defined by platform teams. This delegation enables teams to operate at their own pace while adhering to organizational standards. In hybrid models, application teams often include staff with responsibilities across both on-premises and cloud environments, requiring clear operational guidelines for each context.

3. **Create a responsibility matrix between platform, workload, and traditional IT teams.** Document which team owns each service, operation, and support function across your technology estate. This documentation reduces confusion and increases accountability, especially when responsibilities span both cloud and on-premises systems. For example, one platform team might implement Azure Policy and create infrastructure modules while another team uses these modules to build landing zones. Workload teams manage workload-specific resources.

4. **Establish service levels and metrics to govern cross-team collaboration.** Define expectations for request handling, support, and delivery timelines between platform, workload, and traditional IT teams. Use these metrics to continuously improve platform services and ensure alignment across hybrid operations.

## Build platform capabilities as internal products

Platform engineering transforms shared services into discoverable, reusable, and supportable products. These products enable workload teams to adopt cloud services faster and more securely. Follow this guidance:

1. **Design platform services as modular, reusable products.** Examples include:
    - Azure governance (management groups, policies, blueprints)
    - Subscription vending
    - Hub-and-spoke networking
    - Inner-sourced infrastructure-as-code (IaC) modules based on Azure Verified Modules (AVM)
    - Developer tooling such as internal developer platforms (IDPs)

2. **Use product management practices to evolve platform capabilities.** Treat each platform capability as a product with a defined roadmap, backlog, and customer feedback loop. This approach ensures that services remain relevant and valuable to internal consumers.

3. **Support multiple platform teams to scale across large enterprises.** In large organizations, a single platform team cannot meet all needs. Instead, organize multiple product-aligned teams focused on areas such as:
    - Cloud onboarding
    - Cloud design and build support
    - Cloud security and governance
    - Identity and access management
    - Networking and connectivity

## Right-size platform teams for skill coverage and scalability

Effective platform teams require a mix of specialized skills and a manageable team size to deliver and support platform products. Follow this guidance:

1. **Start with “two-pizza” teams to maintain agility and focus.** A team that can be fed with two pizzas (typically 6–10 people) is a well-known industry benchmark for team size. This size supports rapid iteration and strong collaboration.

2. **Ensure skill coverage across key platform domains.** A typical enterprise platform team should include:
    - 2 x networking engineers
    - 2 x IaC/DevOps engineers
    - 2 x identity engineers
    - 2 x security engineers

3. **Invest in DevOps and IaC skills to enable automation and scalability.** Platform teams must be proficient in:
    - Azure DevOps or GitHub
    - Infrastructure-as-Code tools such as Terraform and Bicep
    - GitHub Copilot and other AI-assisted development tools
    - Git-based workflows for version control and collaboration

## Next steps

> [!div class="nextstepaction"]
> [Choose a cloud operating model](./prepare-organization-for-cloud.md#choose-a-cloud-operating-model)
