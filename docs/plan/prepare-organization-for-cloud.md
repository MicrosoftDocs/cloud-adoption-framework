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

## Understand your cloud responsibilities

A defined set of responsibilities ensures that governance, security, and operations are consistently managed across your Azure environment. This clarity is essential in the context of this article to establish accountability and maintain control in the cloud. You must assign individuals or teams to own and execute these responsibilities to support a secure, well-managed Azure environment.

1. **Plan for cloud governance.** A cloud governance team assesses risks, documents cloud governance policies, and reports on cloud governance progress. You must establish this team early in your cloud journey to ensure governance standards are in place before workloads are deployed. See [Build a cloud governance team](/azure/cloud-adoption-framework/govern/build-cloud-governance-team).

2. **Plan for cloud security.** Cloud security is essential at every stage of the cloud lifecycle, including development, operations, and continuous improvement. A secure foundation ensures protection against threats and compliance with organizational policies. You must embed security considerations into all aspects of your cloud operating model to safeguard resources and data effectively. See [Security Teams, Roles, and Functions](/azure/cloud-adoption-framework/secure/teams-roles) to start your security plan.

3. **Plan for cloud management.** Effective cloud management ensures your Azure cloud estate aligns with business objectives and minimizes the effects of incidents. Successful cloud operations require clearly defined responsibilities and processes for every cloud management area. You must establish these operational processes to ensure consistent service delivery and resource optimization. See [Ready your Azure cloud operations](/azure/cloud-adoption-framework/manage/ready) for a detailed list of responsibilities.

4. **Plan for AI adoption.** AI is a transformational technology that every organization needs to prepare for. Start by developing your [AI Strategy](/azure/cloud-adoption-framework/scenarios/ai/strategy) and [building an AI team](/azure/cloud-adoption-framework/scenarios/ai/center-of-excellence). Also review how to [govern AI](/azure/cloud-adoption-framework/scenarios/ai/govern), [secure AI](/azure/cloud-adoption-framework/scenarios/ai/secure), and [manage AI](/azure/cloud-adoption-framework/scenarios/ai/manage).

## Choose a cloud operating model

A cloud operating model defines how teams manage responsibilities and collaborate across cloud environments. Selecting the right model ensures alignment with business goals, accelerates delivery, clarifies accountability, and reduces operational overhead. You must choose a model that supports your current needs and enables future scalability

| Operating Model | Best For | Responsibilities | Pros | Cons |
|-----------------|----------|------------------|------|------|
| Centralized | Small organizations, new adopters, single-cloud estates | One cloud team manages every function | Simpler control, uniform standards | One team becomes a bottleneck as scale grows |
| Shared Management | Mid-size or enterprise estates, hybrid or multi-cloud | Platform team(s) build the [Azure landing zone](../ready/index.md), manages shared services, and governance guardrails. Workload teams work autonomously within guardrails | Balances standards with team agility | Requires clear responsibilities and strong coordination |
| Decentralized | Tech-savvy startups, innovation programs | Each team owns every cloud task | High speed and autonomy | Weaker standardization, higher risk of security gaps |

### Start with a centralized model if you're new to cloud or startup

A centralized model consolidates all cloud responsibilities (governance, security, operations) into a single team. This model is ideal for small organizations, startups, or new cloud adopters.

1. **Assign all cloud responsibilities to a single cloud team.** The centralized team manages governance, security, operations, and platform services. Centralized control simplifies decision-making and enforces consistent standards. However, this model can become a bottleneck as cloud adoption scales. Assign responsibilities by designating a dedicated team and documenting their roles.

2. **Use centralized governance in regulated environments.** Centralized models ensure consistent policy enforcement across all workloads. This approach is essential in industries with strict compliance requirements. Assign the centralized team to oversee compliance and regularly review policies to maintain regulatory alignment.

3. **Plan to evolve the model as your organization grows.** Centralized models do not scale well for larger organizations. You must monitor team capacity and cloud usage to determine when to transition to a shared model. Regularly assess organizational needs and prepare to shift responsibilities as cloud adoption increases.

### Use a shared responsibility model if you're an enterprise

A shared responsibility model defines how platform and workload teams collaborate to manage cloud environments. This model is essential for mid-size and enterprise organizations that operate in hybrid or multi-cloud environments. It enables scalability, governance, and agility by clearly assigning responsibilities and enforcing standards.

1. **Establish one or more platform teams to manage shared services and governance.** Platform teams build and maintain the Azure landing zone, enforce governance controls, and manage shared infrastructure. This structure ensures consistency while enabling scale.

2. **Allow workload teams to operate autonomously within governance guardrails.** Application teams manage their own deployments and operations, increasing agility. Guardrails—such as Azure Policy, service restrictions, and standardized templates—ensure compliance.

3. **Define clear roles and responsibilities across teams.** Document who creates governance standards (typically a governance team) and who implements them (typically a platform team). This clarity prevents duplication and gaps in accountability.

4. **Establish communication channels and escalation paths.** Regular coordination between platform and workload teams is essential to maintain alignment and resolve issues quickly.

For more information, see [Shared management operating model](./shared-management-operating-model.md).

### Use a decentralized model for mature autonomous teams

A decentralized model gives each team full ownership of their cloud workloads, including governance, operations, and shared services. This model maximizes speed and autonomy but increases the risk of inconsistent practices.

1. **Ensure teams have strong cloud expertise and mature practices.** Only highly skilled teams should operate independently to prevent security gaps and operational inefficiencies. You must evaluate team capabilities and provide training to build maturity before adopting decentralized models.

2. **Implement decentralized models in innovation-focused environments.** This model is suitable for tech-savvy startups or internal innovation programs where speed outweighs standardization. You must assess the environment's focus on innovation and agility to determine if a decentralized model is appropriate.

3. **Monitor for compliance and security risks.** Regular audits ensure decentralized teams follow organizational policies and maintain secure configurations. You must establish a process for auditing teams and addressing any gaps in compliance or security.

### Evolve your operating model as your organization matures

Operating models must adapt to organizational growth, team maturity, and cloud complexity.

1. **Review your operating model.** As your organization scales, reassess whether your current model supports your goals. Transition from centralized to shared or hybrid models as needed.

2. **Adopt hybrid approaches where appropriate.** Some teams may benefit from decentralized autonomy even if the broader organization uses a centralized or shared model. You must evaluate team maturity to determine where hybrid models add value without compromising governance.

### Secure executive sponsorship

Executive alignment ensures that the operating model supports business priorities. Without this alignment, cloud adoption efforts can lack authority or direction. You must engage leadership early to validate and support your model. Follow this guidance:

1. **Engage business and IT leadership.** Ensure that cloud strategy reflects input from all stakeholders, not just IT teams. This engagement creates buy-in and ensures the operating model aligns with business objectives. You must secure commitment from both business and technical leaders to ensure the model has the authority and resources needed for success.

2. **Align the operating model with strategic goals.** Confirm that the model supports innovation, compliance, and operational efficiency requirements. This alignment ensures the model serves both current needs and future growth plans. You must regularly review and validate this alignment as business priorities evolve.

## Document ownership and accountability

Clear accountability prevents duplication and ensures critical tasks are completed. You must document responsibilities to clarify roles across teams. Follow this guidance:

1. **Map responsibilities across governance, security, and operations.** Assign clear ownership for each function to prevent gaps in coverage and ensure all critical areas are managed effectively. Responsibility mapping eliminates confusion about who handles specific tasks and decisions. You must ensure every critical function has an assigned owner and backup.

2. **Include partner support in your model** Strategic [partners](https://partner.microsoft.com/partnership/find-a-partner) can accelerate cloud adoption and improve operational outcomes. Identify trusted partners such as Expert MSPs. These partners provide specialized expertise in governance, operations, and transformation that does not exist within your organization. Clarify how partners support platform operations, workload management, and innovation initiatives to avoid confusion and overlap with internal teams.

3. **Communicate the responsibilities to all stakeholders.** Ensure that all teams understand their roles and how they interact with others in the operating model. This communication prevents confusion and ensures smooth collaboration. You must provide training and documentation to help teams understand their responsibilities and dependencies.

4. **Review responsibilities.** As your Azure environment grows, review the distribution of responsibilities regularly to ensure it aligns with team abilities, capacity, and business goals.

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
> [Prepare your people for Azure](./prepare-people-for-cloud.md)