---
title: Select your cloud operating model
description: Learn how to choose and implement a cloud operating model that aligns with your organization's size, maturity, and regulatory requirements for successful Azure adoption.
author: stephen-sumner
ms.author: microsoft-alias
ms.date: 07/15/2025
ms.topic: conceptual
---

# Select your cloud operating model

This article helps you choose and implement a cloud operating model that distributes cloud responsibilities across your organization effectively. An operating model aligns cloud adoption with your organization's size, maturity, and regulatory requirements to accelerate success and reduce risk.

## Understand operating models

Operating models provide the structure for team collaboration and cloud responsibility management. This structure supports consistent governance, accelerates innovation, and reduces risk. Organizations must understand available models and how they evolve with organizational growth to select the best fit for their needs. Follow this guidance:

1. **Learn the three primary operating models.** These models—centralized, shared management, and decentralized—offer different balances of control, agility, and scalability. Each model defines how responsibilities are distributed across teams and determines the level of autonomy each team has in cloud resource management.

2. **Expect operating models to evolve with organizational maturity.** Organizations often begin with a centralized model to establish foundational governance and later evolve to shared or decentralized models. This flexibility enables teams to scale cloud adoption while maintaining control and governance standards.

3. **Allow for hybrid approaches when appropriate.** Mature teams that build modern applications can benefit from decentralized autonomy, even if the broader organization uses a centralized or shared model. This approach accelerates innovation while preserving governance standards across the organization.

## Assess your organization's characteristics

Organizational characteristics determine which operating model is most effective. A mismatch between model and context can create inefficiencies, compliance risks, or adoption delays. You must evaluate your current state to inform your model selection. Follow this guidance:

1. **Evaluate your organization's size and structure.** Smaller organizations or startups often benefit from centralized control, while larger enterprises require distributed responsibilities to scale effectively. Consider your current team size, organizational complexity, and resource availability when you make this evaluation.

2. **Assess your cloud maturity level.** Organizations new to cloud benefit from centralized governance to establish foundational practices. As maturity increases, shared or decentralized models support agility and innovation while maintaining necessary controls.

3. **Identify regulatory and compliance requirements.** Highly regulated environments require centralized or shared governance to ensure consistent policy enforcement across all cloud resources and workloads.

## Choose an operating model

Each operating model offers distinct advantages and tradeoffs based on your organizational needs. You must select the model that aligns with your current requirements and future goals. Follow this guidance:

1. **Start with a centralized model if you're new to cloud or a small organization.** This model consolidates all cloud responsibilities (governance, security, operations) into a single team. It simplifies governance and standardization but can become a bottleneck as cloud usage scales. Transition to a shared responsibility model when your organization grows and requires more distributed management.

2. **Use a shared responsibility model for mid-size or enterprise organizations.** In this approach, a central platform team oversees shared services and governance controls, while individual workload teams manage their own operations within established guidelines. This setup encourages both agility and scalability but requires clear coordination and well-defined roles. For more information, see [Shared management operating model](./shared-management-operating-model.md).

3. **Use a decentralized model for highly autonomous teams.** This model gives each team full control over their cloud workloads, including governance, shared services, and operations. It maximizes speed and flexibility but increases the risk of inconsistent practices across teams. This model works best for organizations with mature cloud practices and strong technical expertise.

| Operating Model | Best For | Responsibilities | Pros | Cons |
|-----------------|----------|------------------|------|------|
| Centralized | Small organizations, new adopters, single-cloud estates | One cloud team manages every function | Simpler control, uniform standards | One team becomes a bottleneck as scale grows |
| Shared Management | Mid-size or enterprise estates, hybrid or multi-cloud | Central platform team controls shared services and governance guardrails; workload teams work autonomously within guardrails | Balances standards with team agility | Requires clear responsibilities and strong coordination |
| Decentralized | Tech-savvy startups, innovation programs | Each team owns every cloud task | High speed and autonomy | Weaker standardization, higher risk of gaps |

## Secure executive sponsorship

Executive alignment ensures that the operating model supports business priorities. Without this alignment, cloud adoption efforts can lack authority or direction. You must engage leadership early to validate and support your model. Follow this guidance:

1. **Engage business and IT leadership.** Ensure that cloud strategy reflects input from all stakeholders, not just IT teams. This engagement creates buy-in and ensures the operating model aligns with business objectives.

2. **Align the operating model with strategic goals.** Confirm that the model supports innovation, compliance, and operational efficiency requirements. This alignment ensures the model serves both current needs and future growth plans.

## Include partner support in your model

Strategic [partners](https://partner.microsoft.com/partnership/find-a-partner) can accelerate cloud adoption and improve operational outcomes. You must define how partners contribute to your operating model. Follow this guidance:

1. **Identify trusted partners such as Expert MSPs.** These partners provide specialized expertise in governance, operations, and transformation that does not exist within your organization.

2. **Document partner roles in your model.** Clarify how partners support platform operations, workload management, and innovation initiatives to avoid confusion and overlap with internal teams.

## Document ownership and accountability

Clear accountability prevents duplication and ensures critical tasks are completed. You must document a RACI (Responsible, Accountable, Consulted, Informed) matrix to clarify roles across teams. Follow this guidance:

1. **Map responsibilities across governance, security, and operations.** Assign clear ownership for each function to prevent gaps in coverage and ensure all critical areas are managed effectively.

2. **Communicate the RACI model to all stakeholders.** Ensure that all teams understand their roles and how they interact with others in the operating model. This communication prevents confusion and ensures smooth collaboration.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Partner Solutions | [Microsoft Partner Center](https://partner.microsoft.com/partnership/find-a-partner) | Helps identify and connect with trusted partners and Expert MSPs for specialized cloud expertise |
| Operating Model Reference | [Shared management operating model](./shared-management-operating-model.md) | Provides detailed guidance on implementing the shared responsibility model for enterprise organizations |

## Next steps

> [!div class="nextstepaction"]
> [Prepare your people for Azure](./prepare-people-for-azure.md)