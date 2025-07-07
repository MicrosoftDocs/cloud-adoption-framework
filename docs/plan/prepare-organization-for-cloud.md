---
title: Prepare your organization for the cloud
description: This article explains how to choose and implement cloud operating models that distribute Azure responsibilities effectively across your organization. Learn to plan governance, security, and operations teams while selecting centralized, shared management, or decentralized models based on organizational size, maturity, and compliance requirements.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: conceptual
---

# Prepare your organization for the cloud

This article helps you choose and implement a cloud operating model that distributes cloud responsibilities across your organization effectively. An operating model aligns cloud adoption with your organization's size, maturity, and regulatory requirements to accelerate success and reduce risk.

Strategic priorities and portfolio scope determine your cloud operating model. Models vary in accountability structures, landing zone approaches, and operational focus. Organizations that select models that don't align with company goals experience increased time to market, misunderstandings about roles and responsibilities, and increased pressure on IT departments.

## Plan to address your cloud responsibilities

A defined set of responsibilities ensures that governance, security, and operations are consistently managed across your Azure environment. This responsibility clarity establishes accountability and maintains control in the cloud. You must assign individuals or teams to own and execute these responsibilities to support a secure, well-managed Azure environment. Follow this guidance:

1. **Plan for cloud governance.** A cloud governance team assesses risks, documents cloud governance policies, and reports on cloud governance progress. This team establishes the foundation for consistent policy enforcement across your Azure environment. You must establish this team early in your cloud journey to ensure governance standards are in place before workloads are deployed. See [Build a cloud governance team](/azure/cloud-adoption-framework/govern/build-cloud-governance-team).

2. **Plan for cloud security.** Cloud security ensures security is part of every stage of the cloud lifecycle, from development to operations and continuous improvement. Security planning reduces risk and protects your organization's assets throughout the cloud adoption process. You must integrate security considerations into all aspects of your cloud operating model. See [Security Teams, Roles, and Functions](/azure/cloud-adoption-framework/secure/teams-roles).

3. **Plan for cloud management.** Cloud operations maintain effective operations for managing your Azure cloud estate. Successful cloud operations require clearly defined responsibilities and processes for every cloud management area. You must establish these operational processes to ensure consistent service delivery and resource optimization. See [Ready your Azure cloud operations](/azure/cloud-adoption-framework/manage/ready) for a detailed list of responsibilities.

4. **Plan for AI adoption.** AI is a transformational technology that every organization needs to prepare for. Start by developing your [AI Strategy](/azure/cloud-adoption-framework/scenarios/ai/strategy) and [building an AI team](/azure/cloud-adoption-framework/scenarios/ai/center-of-excellence). Also review how to [govern AI](/azure/cloud-adoption-framework/scenarios/ai/govern), [secure AI](/azure/cloud-adoption-framework/scenarios/ai/secure), and [manage AI](/azure/cloud-adoption-framework/scenarios/ai/manage).

## Choose a cloud operating model

An operating model provides the structure for how teams collaborate and manage cloud responsibilities. There are three primary cloud operating models: centralized, shared management, and decentralized. Each operating model offers distinct advantages and tradeoffs based on your organizational needs. You must select the model that aligns with your current requirements and future goals.

| Operating Model | Best For | Responsibilities | Pros | Cons |
|-----------------|----------|------------------|------|------|
| Centralized | Small organizations, new adopters, single-cloud estates | One cloud team manages every function | Simpler control, uniform standards | One team becomes a bottleneck as scale grows |
| Shared Management | Mid-size or enterprise estates, hybrid or multi-cloud | Central platform team controls shared services and governance guardrails; workload teams work autonomously within guardrails | Balances standards with team agility | Requires clear responsibilities and strong coordination |
| Decentralized | Tech-savvy startups, innovation programs | Each team owns every cloud task | High speed and autonomy | Weaker standardization, higher risk of gaps |

1. **Start with a centralized model if you're new to cloud or a small organization.** This model consolidates all cloud responsibilities (governance, security, operations) into a single team. Smaller organizations or startups often benefit from centralized control. Centralized models simplify governance and standardization but can become a bottleneck as cloud usage scales. You must transition to a shared responsibility model when your organization grows and requires more distributed management. Small, highly regulated environments require centralized governance to ensure consistent policy enforcement across all cloud resources and workloads.

2. **Mature toward a shared responsibility model.** In this approach, a central platform team oversees shared services and governance controls, while individual workload teams manage their own operations within established guidelines. Larger enterprises require shared-managmenet responsibilities to scale. This model balances agility and scalability but requires clear coordination and well-defined roles. You must establish clear communication channels and governance processes to make this model effective. Large, highly regulated environments require shared-management governance to ensure consistent policy enforcement across all cloud resources and workloads. For more information, see [Shared management operating model](./shared-management-operating-model.md).

3. **Use a decentralized model for highly autonomous teams.** This model gives each team full control over their cloud workloads, including governance, shared services, and operations. Decentralized models maximize speed and flexibility but increase the risk of inconsistent practices across teams. You must ensure teams have mature cloud practices and strong technical expertise before implementing this model.

4. **Expect operating models to evolve with organizational maturity.** Organizations often begin with a centralized model to establish foundational governance and later evolve to shared or decentralized models. This model evolution enables teams to scale cloud adoption while maintaining control and governance standards. You must plan for this evolution to ensure your operating model can adapt as your organization grows.

5. **Allow for hybrid approaches when appropriate.** Mature teams that build modern applications can benefit from decentralized autonomy, even if the broader organization uses a centralized or shared model. This hybrid approach accelerates innovation while preserving governance standards across the organization. You must evaluate team maturity levels to determine where hybrid approaches add value.

## Secure executive sponsorship

Executive alignment ensures that the operating model supports business priorities. Without this alignment, cloud adoption efforts can lack authority or direction. You must engage leadership early to validate and support your model. Follow this guidance:

1. **Engage business and IT leadership.** Ensure that cloud strategy reflects input from all stakeholders, not just IT teams. This engagement creates buy-in and ensures the operating model aligns with business objectives. You must secure commitment from both business and technical leaders to ensure the model has the authority and resources needed for success.

2. **Align the operating model with strategic goals.** Confirm that the model supports innovation, compliance, and operational efficiency requirements. This alignment ensures the model serves both current needs and future growth plans. You must regularly review and validate this alignment as business priorities evolve.

## Document ownership and accountability

Clear accountability prevents duplication and ensures critical tasks are completed. You must document a RACI (Responsible, Accountable, Consulted, Informed) matrix to clarify roles across teams. Follow this guidance:

1. **Map responsibilities across governance, security, and operations.** Assign clear ownership for each function to prevent gaps in coverage and ensure all critical areas are managed effectively. Responsibility mapping eliminates confusion about who handles specific tasks and decisions. You must ensure every critical function has an assigned owner and backup.

2. **Include partner support in your model** Strategic [partners](https://partner.microsoft.com/partnership/find-a-partner) can accelerate cloud adoption and improve operational outcomes. Identify trusted partners such as Expert MSPs. These partners provide specialized expertise in governance, operations, and transformation that does not exist within your organization. Clarify how partners support platform operations, workload management, and innovation initiatives to avoid confusion and overlap with internal teams.

3. **Communicate the RACI model to all stakeholders.** Ensure that all teams understand their roles and how they interact with others in the operating model. This communication prevents confusion and ensures smooth collaboration. You must provide training and documentation to help teams understand their responsibilities and dependencies.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Partner solutions | [Microsoft Partner Center](https://partner.microsoft.com/partnership/find-a-partner) | Helps identify and connect with trusted partners and expert MSPs for specialized cloud expertise. |
| Operating model reference | [Shared management operating model](./shared-management-operating-model.md) | Provides detailed guidance on implementing the shared responsibility model for enterprise organizations. |
| Governance | [Build a cloud governance team](/azure/cloud-adoption-framework/govern/build-cloud-governance-team) | Offers guidance on forming a team to assess risks, document policies, and enforce governance standards. |
| Security | [Security teams, roles, and functions](/azure/cloud-adoption-framework/secure/teams-roles) | Details roles and responsibilities for integrating security into the cloud lifecycle. |
| Operations | [Ready your Azure cloud operations](/azure/cloud-adoption-framework/manage/ready) | Provides a checklist for preparing operational processes to manage Azure environments effectively. |

## Next steps

> [!div class="nextstepaction"]
> [Prepare your people for Azure](./skill-people-for-cloud.md)