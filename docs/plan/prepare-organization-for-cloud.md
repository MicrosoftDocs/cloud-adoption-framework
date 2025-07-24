---
title: Prepare your organization for the cloud
description: Choose and implement a cloud operating model that distributes Azure responsibilities across your organization. Plan governance, security, and operations teams while selecting centralized, shared, or decentralized models based on organizational size and maturity.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: conceptual
---

# Prepare your organization for the cloud

A successful cloud journey requires more than technical readiness. It demands strategic alignment, clear responsibilities, and a tailored approach based on your organization’s starting point. Use this guidance to define your path, assign ownership, and build a secure, well-managed, and future-ready Azure environment.

## Map your cloud adoption journey

Every organization’s cloud journey is different. Startups often begin cloud-native, while enterprises must assess and migrate existing workloads. Knowing your starting point helps you navigate the Cloud Adoption Framework (CAF) effectively.

1. **Startups: Build cloud-native.** Startups have the advantage of designing their business and applications with cloud-native principles from the outset. This approach fosters agility, scalability, and rapid innovation. Prepare your organization using CAF Plan. Prepare your foundational environment using CAF Ready. Develop cloud-native solutions using CAF Innovate.

2. **Enterprises: Migrate and modernize.** Enterprises must evaluate their existing IT estate and determine the best migration strategy for each workload based on business drivers. Prepare your environment using an Azure landing zone. Build or extend your landing zone to support hybrid or multi-cloud scenarios. Ensure identity, networking, and security are in place. Then you execute migration using CAF Migrate and modernize using CAF Modernize

:::image type="content" source="./images/cloud-adoption-planning-decision-tree.svg" alt-text="Diagram showing a cloud adoption decision tree. Startups should build cloud-native and follow CAF Plan, CAF Ready, and CAF Innovate (cloud-native development). Organizations with existing workloads should pick a migration strategy: retire, rehost, refactor, rearchitect, replace, rebuild, or retain. Base the decision on the business driver for each workload." lightbox="./images/cloud-adoption-planning-decision-tree.svg" border="false":::

## Choose how to manage the cloud

How you operate the cloud (cloud operating model) defines how teams manage responsibilities and collaborate. Choosing the right model ensures alignment with business goals, accelerates delivery, clarifies accountability, and reduces operational overhead. As your organization grows, reassess whether your current model still supports your goals. Transition from centralized to shared or hybrid models as needed. Evaluate team maturity to determine where hybrid models add value without compromising governance. For example, some teams might benefit from decentralized autonomy even within a broader centralized or shared framework.

| Operations approach | Best For | Responsibilities | Pros | Cons |
|-----------------|----------|------------------|------|------|
| Centralized | Small organizations, new adopters, single-cloud estates | One cloud team manages every function | Simpler control, uniform standards | One team becomes a bottleneck as scale grows |
| Shared Management | Mid-size or enterprise estates, hybrid, or multicloud | Platform teams build the [Azure landing zone](../ready/index.md), manages shared services, and governance guardrails. <br> Workload teams work autonomously within guardrails | Balances standards with team agility | Requires clear responsibilities and strong coordination |
| Decentralized | Tech-savvy startups, innovation programs | Each team owns every cloud task | High speed and autonomy | Weaker standardization, higher risk of security gaps |

1. **Understand centralized operations.** A centralized model consolidates governance, security, and operations into a single team. It ensures consistent policy enforcement and is ideal for small organizations, startups, or regulated industries. However, it can become a bottleneck as adoption scales. Regularly assess and adjust responsibilities as needed.

1. **Understand shared management operations.** In a shared management model, platform and workload teams collaborate. A governance team defines cloud policies. Platform teams build and maintain the Azure landing zone to enforce cloud policies. Workload teams operate autonomously within those guardrails. This model suits mid-size and enterprise organizations with hybrid or multicloud environments. See [Shared management operating model](./shared-management-operating-model.md).

1. **Understand decentralized operations.** Decentralized models give teams full ownership of their cloud workloads, including governance and operations. This approach suits highly skilled teams in startups or innovation programs. To avoid security and compliance risks, evaluate team capabilities, provide training, and conduct regular audits.

## Plan your cloud responsibilities

Clearly defined responsibilities are essential for consistent governance, security, and operations across your Azure environment. Assign ownership early to maintain control and accountability.

1. **Plan for cloud governance.** Establish a governance team to assess risks, define policies, and monitor progress. This team should be in place before deploying workloads. See [Build a cloud governance team](/azure/cloud-adoption-framework/govern/build-cloud-governance-team).

2. **Plan for cloud security.** Embed security into every stage of the cloud lifecycle—from development to operations. A secure foundation protects against threats and ensures compliance. See [Security Teams, Roles, and Functions](/azure/cloud-adoption-framework/secure/teams-roles) to start your security plan.

3. **Plan for cloud management.** Define operational processes to align cloud operations with business goals and ensure consistent service delivery. See [Ready your Azure cloud operations](/azure/cloud-adoption-framework/manage/ready) for a detailed list of responsibilities.

4. **Plan for AI adoption.** AI is a transformational technology that every organization needs to prepare for. Start by developing your [AI Strategy](/azure/cloud-adoption-framework/scenarios/ai/strategy) and [building an AI team](/azure/cloud-adoption-framework/scenarios/ai/center-of-excellence). Also review how to [govern AI](/azure/cloud-adoption-framework/scenarios/ai/govern), [secure AI](/azure/cloud-adoption-framework/scenarios/ai/secure), and [manage AI](/azure/cloud-adoption-framework/scenarios/ai/manage).

### Secure executive sponsorship

1. **Engage business and IT leadership.** Ensure that cloud strategy reflects input from all stakeholders, not just IT teams. This engagement creates buy-in and ensures the operating model aligns with business objectives. You must secure commitment from both business and technical leaders to ensure the model has the authority and resources needed for success.

2. **Align the operating model with strategic goals.** Confirm that the model supports innovation, compliance, and operational efficiency requirements. This alignment ensures the model serves both current needs and future growth plans. You must regularly review and validate this alignment as business priorities evolve.

## Document cloud responsibilities

A documented responsibility model defines clear ownership across governance, security, and operations. This clarity prevents duplication, ensures accountability, and supports consistent execution of critical tasks. You must define, assign, and communicate responsibilities to align teams and partners around shared cloud goals.

1. **Map responsibilities across governance, security, and operations.** Assign clear ownership for each function to prevent gaps in coverage and ensure all critical areas are managed effectively. Responsibility mapping eliminates confusion about who handles specific tasks and decisions. Assign primary and backup owners for each function. Designate individuals or teams responsible for each function and ensure a backup is available. This redundancy ensures continuity during absences or transitions.

2. **Include partner responsibilities in your operating model.** [Partner](https://partner.microsoft.com/partnership/find-a-partner) contributions must be clearly defined to avoid overlap with internal teams. Strategic partners such as Microsoft Expert managed service provides offer specialized capabilities that accelerate cloud adoption and improve operational maturity. Identify partners that support your cloud strategy. Clarify the scope of partner responsibilities. Define which functions partners own, such as platform operations, workload management, or innovation initiatives. Ensure these responsibilities are distinct from internal team roles.

3. **Communicate the responsibilities to all stakeholders.** Ensure that all teams understand their roles and how they interact with others in the operating model. This communication prevents confusion and ensures smooth collaboration. You must provide training and documentation to help teams understand their responsibilities and dependencies.

4. **Review responsibilities.** A static responsibility model becomes outdated as your Azure environment evolves. Regular reviews ensure that responsibilities align with team capacity, skill set, and business priorities. As your Azure environment grows, review the distribution of responsibilities regularly to ensure it aligns with team abilities, capacity, and business goals.

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