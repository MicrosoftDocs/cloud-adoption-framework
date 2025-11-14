---
title: Shared management cloud operations
description: Implement a shared management cloud operating model that scales cloud adoption through platform engineering. Learn to build reusable platform capabilities, establish clear team responsibilities, and enable self-service infrastructure for accelerated Azure workload delivery.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: concept-article
---

# Shared management cloud operations

Shared management cloud operations enable organizations to scale cloud adoption while maintaining governance and agility. This model becomes more effective when platform teams adopt a product mindset, delivering reusable, self-service capabilities that accelerate workload team success. This approach aligns with the emerging industry trend of platform engineering, where internal platform teams build and operate shared services as products for the rest of the organization.

## Implement shared management operations

A shared management operating model balances central control with distributed responsibility across cloud and on-premises environments. This balance enables organizations to maintain governance standards while allowing teams to work at their preferred pace. You need to establish clear boundaries between platform capabilities and workload operations to achieve consistent management across hybrid and multi-cloud estates. Follow this guidance:

1. **Establish platform teams to provide shared cloud services and governance.** Platform teams provide foundational capabilities such as Azure governance, subscription provisioning, hub-and-spoke networking, and developer tooling. These services support all workloads and ensure consistency, security, and scalability across the cloud estate. In hybrid environments, platform teams must coordinate with traditional IT to align governance across on-premises and cloud systems.

2. **Delegate subscription and workload operations to workload teams.** Workload teams manage their own cloud environments within the boundaries defined by platform teams. This delegation allows teams to operate independently while adhering to organizational standards. In hybrid models, workload teams often span both cloud and on-premises environments, so you must define clear operational guidelines for each context.

3. **Create a responsibility matrix between platform, workload, and traditional IT teams.** A responsibility matrix documents ownership of services, operations, and support functions across the technology estate. This documentation reduces ambiguity and increases accountability. For example, one platform team might create reusable infrastructure modules, while another team uses them to build landing zones. Workload teams manage workload-specific resources and operations.

4. **Establish service levels and metrics to govern cross-team collaboration.** Service level agreements (SLAs) and operational metrics define expectations for request handling, support, and delivery timelines. These metrics help improve platform services and ensure alignment across hybrid operations. You must regularly review and refine these metrics to support continuous improvement.

## Build platform capabilities as internal products

A platform capability is a shared service that supports workload teams by accelerating secure and consistent cloud adoption. Treating these capabilities as internal products ensures they are discoverable, reusable, and supportable. You must apply platform engineering and product management practices to scale these services across your organization.

### Design platform services as modular, reusable products

1. **Understand the product mindset.** Modular platform services reduce duplication and increase consistency across workloads. These services provide foundational capabilities that workload teams can consume independently. You must design each service to be reusable, composable, and aligned with Azure best practices.

2. **Define modular platform services based on common workload needs.** Platform services must address repeatable needs such as governance, networking, and developer enablement. These services reduce onboarding time and improve compliance across workloads. Examples include:

    - Azure governance (management groups, policies, blueprints)
    - Subscription vending
    - Hub-and-spoke networking
    - Inner-sourced infrastructure-as-code (IaC) modules based on Azure Verified Modules (AVM)
    - Developer tooling such as internal developer platforms (IDPs)

3. **Design services to be discoverable and self-service.** Platform services must be easy for workload teams to find, understand, and consume. Use service catalogs, documentation, and automation to enable self-service adoption. This approach reduces dependency on the platform team and accelerates delivery.

### Use product management practices to evolve platform capabilities

1. **Establish a product backlog and roadmap for each platform capability.** Product management ensures that platform services remain relevant and valuable to internal consumers. You must treat each platform capability as a product with a defined lifecycle. Each platform service must have a prioritized backlog and roadmap based on internal customer needs. This structure enables continuous improvement and alignment with evolving business requirements.

2. **Collect and act on feedback from workload teams.** Feedback loops ensure that platform services meet the needs of their consumers. Use surveys, interviews, and telemetry to gather insights and adjust priorities. This practice increases adoption and satisfaction.

### Use multiple platform teams to scale across large enterprises

1. **Create specialized platform teams aligned to capability domains.** A single platform team cannot meet the diverse needs of a large organization. You must organize multiple product-aligned teams to scale platform capabilities effectively. Each team must focus on a specific area of the platform, such as:
    - Cloud onboarding
    - Cloud design and build support
    - Cloud security and governance
    - Identity and access management
    - Networking and connectivity

2. **Coordinate across platform teams to ensure consistency.** Platform teams must align on standards, tooling, and integration patterns. Use shared design principles, architectural reviews, and inner-source practices to maintain coherence across services.

## Right-size platform teams for skill coverage and scalability

A right-sized platform team enables consistent delivery of platform capabilities while maintaining agility and operational efficiency. This structure is essential for building and supporting internal platform products that accelerate workload team success. You must balance team size with the breadth of skills required to support cloud adoption at scale.

1. **Start with “two-pizza” teams to maintain agility and focus.** A “two-pizza” team typically includes 6–10 members, which is a widely accepted benchmark for effective team size. This size allows for strong collaboration and fast feedback loops. Avoid larger teams that introduce coordination complexity and reduce delivery velocity.

2. **Ensure skill coverage across key platform domains.** Comprehensive skill coverage ensures that platform teams can design, build, and operate secure and scalable services. You must include specialists in key technical areas to support the full lifecycle of platform capabilities. Staff platform teams with specialists across core domains. A typical enterprise platform team should include:

    | Role                          | Responsibilities                                                                                     | Team Size |
    |-------------------------------|-----------------------------------------------------------------------------------------------------|-----------|
    | Networking Engineers          | Design and manage cloud connectivity and hybrid networking.                                         | 2         |
    | Infrastructure-as-Code (IaC) or DevOps Engineers | Automate deployments and manage CI/CD pipelines.                                                   | 2         |
    | Identity Engineers            | Manage authentication, authorization, and identity governance.                                     | 2         |
    | Security Engineers            | Enforce security policies, monitor threats, and support compliance.                                | 2         |

    This structure ensures that each critical domain is covered by at least two team members for redundancy and collaboration.

3. **Invest in DevOps and IaC skills to enable automation and scalability.** Develop DevOps and IaC capabilities across platform teams. Platform engineers must be proficient in:

| Skill or Tool                     | Description                                                                                     |
|-----------------------------------|-------------------------------------------------------------------------------------------------|
| Azure DevOps or GitHub            | Enable CI/CD and workflow automation to streamline development and deployment processes.        |
| Infrastructure-as-code tools      | Use tools like Terraform and Bicep for repeatable, version-controlled deployments.              |
| GitHub Copilot                    | Accelerate code authoring and reduce errors with AI-assisted development tools.                 |
| Git-based workflows               | Support collaboration, code reviews, and change tracking to enhance team productivity.          |

These skills enable platform teams to deliver scalable, secure, and consistent services across the cloud estate.

## Next steps

> [!div class="nextstepaction"]
> [Choose a cloud operating model](./prepare-organization-for-cloud.md#choose-a-cloud-operating-model)
