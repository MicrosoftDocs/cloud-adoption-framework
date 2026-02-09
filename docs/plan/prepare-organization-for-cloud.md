---
title: Prepare your organization for the cloud
description: Choose and implement a cloud operations approach that distributes Azure responsibilities across your organization. Plan governance, security, and operations teams while selecting centralized, shared, or decentralized models based on organizational size and maturity.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: concept-article
---

# Prepare your organization for the cloud

Successful cloud adoption, whether startup or larger organization, requires more than technical readiness. It requires a cloud adoption plan. A cloud adoption plan converts your cloud strategy into an actionable plan that's specific to your goals. Use this guidance to define your cloud adoption plan.

## Map your cloud adoption journey

Every organization’s cloud journey is different. Startups often begin cloud-native, while enterprises must assess and migrate existing workloads. Knowing your starting point helps you navigate the Cloud Adoption Framework (CAF) effectively.

1. **Build cloud-native.** If you’re a startup with no existing workloads, you build your business cloud-native from the ground up. This approach fosters rapid development using cloud-native design. You follow a portion of CAF Plan: prepare, plan, estimate, document. Then you use [CAF Ready](/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources) to quickly establish your Azure environment and [CAF Cloud-native](/azure/cloud-adoption-framework/cloud-native/plan-cloud-native-solutions) to create cloud-native apps.

2. **Migrate existing workloads.** Enterprises must evaluate their existing IT estate and determine the best migration strategy for each workload based on business drivers. You follow all of CAF Plan: prepare, plan, discovery, select, assess, estimate, document. Then, you prepare your enterprise environment using an Azure landing zone in [CAF Ready](/azure/cloud-adoption-framework/ready/landing-zone/). Then, you execute migration using [CAF Migrate](/azure/cloud-adoption-framework/migrate/plan-migration) and modernize using [CAF Modernize](/azure/cloud-adoption-framework/modernize/prepare-organization-cloud-modernization).

    :::image type="content" source="./images/cloud-adoption-planning-decision-tree.svg" alt-text="Diagram showing a cloud adoption decision tree. Startups should build cloud-native and follow CAF Plan, CAF Ready, and CAF Cloud-native development. Organizations with existing workloads should pick a migration strategy: retire, rehost, refactor, rearchitect, replace, rebuild, or retain. Base the decision on the business driver for each workload." lightbox="./images/cloud-adoption-planning-decision-tree.svg" border="false":::

## Choose a cloud operating model

A cloud operating model defines how your organization manages cloud resources, team responsibilities, and collaboration. Choose a model that fits your current state but also supports future growth. A well-designed operating model helps align cloud efforts with business goals, accelerate workload delivery, clarify accountability, and reduce operational overhead.

1. **"Centralized" cloud operating model**: In a centralized model, a single team is responsible for governance, security, and operations across the entire cloud estate and all workloads. This model ensures consistent policy enforcement and is ideal for small organizations, startups, or highly regulated industries. However, it can become a bottleneck as cloud adoption scales. Reevaluate and adjust responsibilities regularly to maintain agility.

1. **"Shared management" cloud operating model**: In a shared management model, cloud responsibilities are divided between platform teams and workload teams. Platform teams deliver a standardized set of platform "products" used across the organization. They enforce baseline governance policies and maintain platform landing zones for shared services like connectivity, identity, management, and security. Platform teams also offer platform services as products, such as [subscription vending](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending) for application landing zones, developer environments, AI tooling, and data services. Workload teams operate autonomously within these guardrails. This model suits mid-size and enterprise organizations and is especially effective in hybrid or multicloud environments. See [Shared management operations](./shared-management-operating-model.md).

1. **"Decentralized" cloud operating model**: In a decentralized model, each team owns its platform landing zone and manages its workloads independently, including governance and operations. This approach suits highly skilled teams in startups or innovation programs. To mitigate security and compliance risks, assess team capabilities, provide training, and conduct regular audits.

1. **Understand hybrid cloud operating models.** Many organizations benefit from a hybrid approach, where different teams operate under different models based on their maturity and needs. For example, core systems might follow a centralized or shared model, while innovation teams operate more independently. Evaluate team capabilities and business priorities to determine where hybrid models add value without compromising governance.

1. **Evolve operations as needed.** As your organization scales, reassess whether your current operations approach supports your goals. Regularly reassess whether your current model supports your strategic goals and operational needs.

1. **Engage business and IT leadership.** Successful cloud operations require alignment across the organization. Engage both business and IT leaders to ensure the operations approach reflects shared priorities. This collaboration fosters buy-in, secures necessary resources, and ensures the model has the authority to drive change.

| Operations approach | Best for | Responsibilities | Pros | Cons |
|-----------------|----------|------------------|------|------|
| Centralized | Startups, single-cloud estates | One cloud team manages every function | Simpler control, uniform standards | One team becomes a bottleneck as scale grows |
| Shared Management | Mid-size or enterprise estates, hybrid, or multicloud | Platform teams build the [platform landing zones](../ready/index.md), manages shared services, and governance guardrails. <br> Workload teams work autonomously within guardrails | Balances standards with team agility | Requires clear responsibilities and strong coordination |
| Decentralized | Tech-savvy startups, innovation programs | Each team owns every cloud task | High speed and autonomy | Weaker standardization, higher risk of security gaps |

## Plan your cloud responsibilities

Clearly defined responsibilities are essential for consistent governance, security, and operations across your Azure environment. Assign ownership early to maintain control and accountability.

1. **Plan for cloud governance.** Establish a governance team to assess risks, define policies, and monitor progress. This team should be in place before deploying workloads. See [Build a cloud governance team](/azure/cloud-adoption-framework/govern/build-cloud-governance-team).

2. **Plan for cloud security.** Embed security into every stage of the cloud lifecycle from development to operations. A secure foundation protects against threats and ensures compliance. See [Security Teams, Roles, and Functions](/azure/cloud-adoption-framework/secure/teams-roles) to start your security plan.

3. **Plan for cloud management.** Define operational processes to align cloud operations with business goals and ensure consistent service delivery. See [Ready your Azure cloud operations](/azure/cloud-adoption-framework/manage/ready-cloud-operations) for a detailed list of responsibilities.

4. **Plan for AI adoption.** AI is a transformational technology that every organization needs to prepare for. Start by developing your [AI Strategy](/azure/cloud-adoption-framework/scenarios/ai/strategy) and [building an AI team](/azure/cloud-adoption-framework/scenarios/ai/center-of-excellence). Also review how to [govern AI](/azure/cloud-adoption-framework/scenarios/ai/govern), [secure AI](/azure/cloud-adoption-framework/scenarios/ai/secure), and [manage AI](/azure/cloud-adoption-framework/scenarios/ai/manage).

## Document cloud responsibilities

Well-documented cloud responsibilities are essential for clarity, accountability, and operational consistency. It defines who owns what across governance, security, and operations, internally and with partners.

1. **Map responsibilities across governance, security, and operations.** Assign clear ownership for each function to eliminate ambiguity and ensure comprehensive coverage. Include both primary and backup owners to maintain continuity during absences or transitions. This mapping helps teams understand their roles and reduces the risk of missed tasks or duplicated efforts.

2. **Define partner roles.** Clearly outline the scope of responsibilities for strategic [partners](https://partner.microsoft.com/partnership/find-a-partner). Specify which functions partners own, such as platform operations, workload management, or innovation initiatives. Ensure these roles complement internal team responsibilities without overlap.

3. **Communicate the responsibilities to all stakeholders.** Ensure that every team understands its role and how it interacts with others. Provide training, documentation, and onboarding materials to reinforce clarity and support collaboration. This transparency helps teams work effectively within the operations approach and reduces friction across functions.

4. **Review responsibilities regularly.** As your Azure environment grows and team capabilities evolve, revisit your responsibilities assignments to ensure they remain aligned with business goals and operational needs.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Partner solutions | [Microsoft Partner Center](https://partner.microsoft.com/partnership/find-a-partner) | Helps identify and connect with trusted partners and expert partners for specialized cloud expertise. |
| Operations approach | [Shared management operations approach](./shared-management-operating-model.md) | Provides detailed guidance on implementing the shared responsibility model for enterprise organizations. |
| Governance | [Build a cloud governance team](/azure/cloud-adoption-framework/govern/build-cloud-governance-team) | Offers guidance on forming a team to assess risks, document policies, and enforce governance standards. |
| Security | [Security teams, roles, and functions](/azure/cloud-adoption-framework/secure/teams-roles) | Details roles and responsibilities for integrating security into the cloud lifecycle. |
| Manage | [Ready your Azure cloud operations](/azure/cloud-adoption-framework/manage/ready-cloud-operations) | Provides a checklist for preparing operational processes to manage Azure environments effectively. |

## Next steps

> [!div class="nextstepaction"]
> [Prepare your people for Azure](./prepare-people-for-cloud.md)
