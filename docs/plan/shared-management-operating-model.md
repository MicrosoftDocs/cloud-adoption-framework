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

## Adopt a shared management model

A shared management model enables organizations to scale cloud adoption while maintaining governance and agility across hybrid and multi-cloud environments. This approach is particularly effective for customers who retain on-premises estates while building parallel cloud estates in Azure. You need to adopt this model to ensure consistency and control across both environments. Follow this guidance:

1. **Establish a central platform team to manage shared cloud services and governance.** This team owns core capabilities such as Azure governance, subscription vending, hub networking, and developer tooling. Centralizing these services ensures consistency, security, and scalability across the cloud estate. In hybrid environments, this team should also coordinate with traditional IT to align governance practices.

2. **Delegate subscription and workload operations to federated workload teams.** Workload teams manage their own cloud environments within the boundaries defined by the platform team. This delegation empowers teams to move faster while adhering to organizational standards. In hybrid models, workload teams may include IT staff with dual responsibilities across on-premises and cloud.

3. **Define clear boundaries of responsibility between platform, workload, and traditional IT teams.** Use a shared responsibility matrix (e.g., RACI) to clarify ownership of services, operations, and support. This clarity reduces friction and improves accountability, especially when roles span both cloud and on-premises systems.

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
