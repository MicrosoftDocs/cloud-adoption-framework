---
title: Microsoft Cloud Adoption Framework for Azure
description: Learn to adopt Azure with structured guidance that supports every stage of a cloud adoption journey, from strategy to operations.
author: stephen-sumner
ms.author: pnp
ms.date: 09/04/2025
ms.update-cycle: 1095-days
ms.topic: conceptual
ms.subservice: caf-general
ms.custom: internal, homepage, UpdateFrequency3
---

# What is the Microsoft Cloud Adoption Framework for Azure?

The Microsoft Cloud Adoption Framework for Azure provides step-by-step guidance for success in the cloud. This proven framework helps organizations plan, deploy, and operate cloud solutions that align with business objectives while reducing risks and accelerating time-to-value.

**Key insight**: The Cloud Adoption Framework serves as the definitive guide for Azure adoption, used by thousands of organizations worldwide to build their business operations with cloud technology.

:::image type="content" source="caf-overview.png" alt-text="Diagram overview of the Cloud Adoption Framework for Azure showing seven core methodologies: Strategy, Plan, Ready, Adopt, Govern, Secure, and Manage. Foundational methodologies flow sequentially. Operational methodologies run in parallel during operations." lightbox="caf-overview.png" border="false":::

## Quick start options

Choose your starting point based on where you are in your cloud journey:

- **New to Azure?** [Define your cloud strategy and business goals](/azure/cloud-adoption-framework/strategy/) to align stakeholders and set success metrics
- **Ready to build infrastructure?** [Set up Azure landing zones](./ready/landing-zone/index.md) for a secure, scalable cloud foundation
- **Have workloads to migrate?** [Plan your migration approach](/azure/cloud-adoption-framework/migrate/plan-migration) with proven migration strategies
- **Looking for specific solutions?** [Explore cloud adoption scenarios](#cloud-adoption-scenarios) for AI, analytics, hybrid, and more

## What problems does the Cloud Adoption Framework solve?

The Cloud Adoption Framework addresses the most common challenges organizations face when adopting Azure cloud technologies. This comprehensive framework helps you:

- **Reduce migration risks** with battle-tested methodologies used by thousands of organizations
- **Optimize cloud costs** by following proven patterns for efficient resource management and cost control
- **Accelerate deployment timelines** with clear roadmaps for planning, migrating, and optimizing workloads
- **Ensure security and compliance** through integrated governance and security best practices from day one
- **Avoid common pitfalls** that can derail cloud adoption projects and waste resources

**In summary**: The Cloud Adoption Framework eliminates guesswork from Azure adoption by providing a structured, proven approach that reduces time-to-value and minimizes costly mistakes.

The framework integrates with the [Well-Architected Framework](/azure/well-architected/) and [Azure Architecture Center](/azure/architecture/) to provide end-to-end guidance for designing, building, and managing secure, scalable, and resilient cloud solutions.

## How do you determine if the Cloud Adoption Framework is right for your organization?

The Microsoft Cloud Adoption Framework serves organizations across all industries and sizes pursuing Azure cloud adoption. This framework is designed to meet you wherever you are in your cloud journey, from initial planning to optimization of existing deployments.

**Common use cases for the Cloud Adoption Framework include**:

| Organization Type   | How the framework helps                                                                         | Best starting point |
|---------------------|-------------------------------------------------------------------------------------------------|---------------------|
| **Startups**        | Build cloud-native solutions from the ground up with proven architectural patterns. Access [Microsoft for Startups](https://www.microsoft.com/startups) for Azure credits and resources. | [Strategy methodology](/azure/cloud-adoption-framework/strategy/) |
| **Enterprises**     | Navigate complex migrations, hybrid environments, and large-scale cloud operations with governance and security controls. | [Ready methodology](./ready/landing-zone/index.md) |
| **New Azure users** | Learn Azure best practices and avoid common mistakes through structured guidance and hands-on learning paths. | [Plan methodology](/azure/cloud-adoption-framework/plan/) |
| **Existing customers** | Optimize current Azure deployments, improve cost management, and mature cloud operations. | [Manage methodology](/azure/cloud-adoption-framework/manage/) |

**Key insight**: The Cloud Adoption Framework adapts to your organization's size, industry, and cloud maturity level, making it the most flexible and comprehensive Azure adoption methodology available.

## How does the Cloud Adoption Framework work?

The Cloud Adoption Framework organizes Azure guidance into seven core methodologies that guide your complete cloud adoption journey. These methodologies follow a logical progression: foundational phases establish your Azure environment and deploy workloads, while operational phases provide ongoing cloud management and optimization.

**The Cloud Adoption Framework methodology explained**: Think of the framework as a roadmap with two distinct phases. The foundational methodologies (Strategy, Plan, Ready, Adopt) follow a sequential approach to build your Azure foundation, while the operational methodologies (Govern, Secure, Manage) run continuously throughout your cloud operations to ensure long-term success.

### Foundational methodologies: Building your Azure foundation

The foundational phase follows a step-by-step approach to establish your cloud presence and deploy your first workloads.

| CAF methodology | Outcome | How to |
|-------------|---------|-------|
| 🚀 [**1. Strategy**](/azure/cloud-adoption-framework/strategy/) | Align cloud adoption to business goals. | Use the Cloud Adoption Framework to map business drivers to measurable cloud outcomes. |
| 📝 [**2. Plan**](/azure/cloud-adoption-framework/plan/) | Create a custom plan to adopt the cloud. | Prepare people, processes, and technology for transformation. Understand the costs of the cloud. |
| 🛠️ [**3. Ready**](/azure/cloud-adoption-framework/ready/) | Ready the Azure environment to host workloads and scale. | Use the Cloud Adoption Framework and Azure Architecture Center to establish foundational governance and to deploy the Azure platform landing zones that you need. You plug Azure application landing zones into this foundation. |
| 🌐 [**4. Adopt**](/azure/cloud-adoption-framework/adopt/) | Deploy workloads in Azure that align to business needs. | Use the Cloud Adoption Framework, the Azure Architecture Center, and the Well-Architected Framework to design and deploy workloads to Azure application landing zones. Use application Azure landing zone accelerators for faster, repeatable deployments. |

### Operational methodologies: Ensuring ongoing success

The operational phase runs continuously to maintain, secure, and optimize your Azure environment. These three methodologies work in parallel to ensure your cloud operations remain efficient, secure, and compliant.

**Best practice**: Start building toward operational excellence during the Strategy and Plan phases, but these methodologies become critical as your workloads move into production and scale.

| CAF methodology  | Outcome | How to |
|-------------|---------|-------|
| 🛡️ [**5. Govern**](/azure/cloud-adoption-framework/govern/) | Maintain control and compliance. | Use the Cloud Adoption Framework, the Azure Architecture Center, and the Well-Architected Framework to define governance policies, enforce compliance, and manage costs. |
| 🔒 [**6. Secure**](/azure/cloud-adoption-framework/secure/) | Protect workloads against evolving threats. | Implement security controls, monitor threats, and execute incident response to reduce risk and protect assets. |
| ⚙️ [**7. Manage**](/azure/cloud-adoption-framework/manage/) | Ensure operational excellence. | Optimize performance, maintain availability, and drive continuous improvement in operations. |

## What specific scenarios does the Cloud Adoption Framework address?

The Cloud Adoption Framework provides scenario-based guidance tailored to specific technologies and business needs. These scenarios apply the framework's proven principles to real-world use cases, offering actionable steps and technology-specific best practices.

**How to choose the right scenario**: Select scenarios based on your organization's specific technology stack, business requirements, or strategic initiatives. Many organizations benefit from multiple scenarios as they expand their Azure footprint.

| CAF Scenario | What it solves | Best for organizations that need |
|--------------|-----------------|----------------------------------|
| [AI adoption](./scenarios/ai/index.md) | Implement AI solutions in Azure effectively and responsibly. | Responsible AI deployment, ML model governance, AI ethics compliance |
| [Azure VMware Solution](./scenarios/azure-vmware/index.md) | Migrate VMware workloads to Azure with minimal disruption. | VMware infrastructure migration, hybrid cloud strategy |
| [Cloud-Scale Analytics](./scenarios/data-management/index.md) | Build secure, scalable, and modern data platforms. | Data modernization, analytics platforms, data governance |
| [Hybrid and Multicloud](./scenarios/hybrid/index.md) | Integrate on-premises, Azure, and other cloud environments. | Multi-cloud strategy, hybrid connectivity, workload portability |
| [Modern Application Platform](./scenarios/app-platform/index.md) | Modernize apps using containers, microservices, and PaaS. | Application modernization, container adoption, microservices architecture |
| [Oracle on Azure](./scenarios/oracle-on-azure/index.md) | Run and manage Oracle workloads in Azure. | Oracle database migration, enterprise application continuity |
| [SAP on Azure](./scenarios/sap/index.md) | Deploy and operate SAP solutions using Azure-native tools. | SAP migration, ERP modernization, mission-critical workloads |
| [Virtual Desktop](./scenarios/azure-virtual-desktop/index.md) | Deliver and manage virtual desktops at scale with Azure. | Remote work enablement, desktop virtualization, end-user computing |
| [High-performance computing](./scenarios/azure-hpc/index.md) | Run compute-intensive workloads efficiently in Azure. | Scientific computing, financial modeling, engineering simulations |

**Key insight**: Cloud Adoption Framework scenarios bridge the gap between general cloud adoption guidance and specific technology implementation, providing detailed roadmaps for complex, real-world deployments.
