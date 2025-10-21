---
title: Manage AI agents
description: Learn to Manage AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
---

# Manage AI agents org-wide

The journey doesn’t end with deployment. In fact, once an AI agent is running in production, it enters the operate and improve phase, which is ongoing. This is where you measure actual business impact against your goals, optimize costs, manage the agent’s lifecycle, and decide on scaling out or winding down as needed. For technical leaders, this phase is about ensuring the solution continues to deliver value and remains aligned with strategic objectives over time.

## Control agent cost and maximize value org-wide

1. **Align cost control with business outcomes.** AI agents consume cloud resources persistently, which introduces cost variability. To control this, assign budgets to teams and require approvals for spending beyond those limits. This enforces discipline and ensures that AI development aligns with strategic priorities. Tie operational spending directly to measurable business outcomes such as labor savings or revenue growth. Without this linkage, cost discussions remain abstract and disconnected from value.

1. **Dashboard and analytics.** Create a dashboard view of agent performance and usage. Track the performance of AI agents by measuring cost per task, accuracy, and response time. Use built-in evaluation tools to collect this data consistently. Schedule quarterly reviews to assess return on investment (ROI) and adjust resource allocation based on performance insights. Summarize things like how many queries were handled, success rates, top topics asked, user satisfaction ratings, and more. Additionally, track [business success metrics](./business-strategy.md#define-success-metrics) from phase one here such as the handle time reduction goal and see if they are being met in real usage. Including these metrics in regular business reviews keeps AI agents on leadership’s radar and ensures accountability.

1. **Calculate and communicate ROI.** Instruct teams to quantify the return on investment each quarter. For example, compare the cost of running the agent with the estimated savings in support labor. This helps justify continued investment or scaling and highlights when costs exceed benefits. Use this data to inform decisions about optimization or retirement.

1. **Analyze cost drivers.** If costs concentrate around large model usage, evaluate alternatives. Consider switching to smaller models or shortening prompts and responses to reduce token counts. Implement a tiered approach where a cheaper model handles initial queries and escalates to a more capable model only when needed. This AI gateway or router approach balances quality and cost.

1. **Evaluate long term pricing options.** If agent usage remains stable and high, consider reserved capacity to reduce costs. For third-party model APIs, evaluate whether self-hosting becomes viable once the solution proves effective. These decisions involve trade-offs between quality, control, and cost, so technical leaders must guide teams through the analysis.

**Azure AI Foundry** provides tools to [Plan and manage costs](/azure/ai-foundry/how-to/costs-plan-manage). Use quota and budget alerts per agent, supports cost-efficient model deployment, and enables teams to monitor and control spending across environments. Consider a [GenAI gateway](/azure/api-management/genai-gateway-capabilities) to rate limit APIs and [import Azure AI Foundry APIs](/azure/api-management/azure-ai-foundry-api) to use them. [Control AI model deployment with built-in policies](/azure/ai-foundry/how-to/built-in-policy-model-deployment) to use cost-efficient models for your environments.

**Microsoft Copilot Studio** offers message packs, Pay-As-You-Go usage, [licensing options](/microsoft-copilot-studio/billing-licensing) to optimize cost. See [Billing rates and management](/microsoft-copilot-studio/requirements-messages-management#view-message-consumption). Understand how to [allocate, monitor, and optimize message usage](/azure/power-platform/admin/manage-copilot-studio-messages-capacity?tabs=new) across environments. [Block unauthorized self-service sign-ups](/microsoft-copilot-studio/admin-block-viral-signups).

## Manage the agent’s lifecycle

AI agents, like any digital product, require structured lifecycle management to remain effective, secure, and aligned with business goals. Technical decision makers must direct their teams to treat each agent as a living system, one that evolves, scales, and eventually retires when it no longer delivers sufficient value.

1. **Conduct periodic reviews.** Establish a regular cadence, quarterly or bi-annually, for reviewing each deployed agent. These reviews must revisit the success metrics defined during the strategy phase and assess whether the agent continues to meet business needs. Include both operational and business indicators:

    - **Operational metrics** such as average handle time, resolution rate, deflection rate which refers to how many inquiries the agent handled without human help, number of tasks automated per week and similar indicators
    - **Business metrics** such as customer satisfaction measured through surveys after interaction, employee productivity measures, cost savings which might be calculated from hours saved, or even revenue influenced in a sales scenario

    Review usage trends, performance drift, and compliance status. Confirm that no unauthorized data sources have been added and that all logging and monitoring systems still function correctly.

2. **Reassess governance after major changes.** When teams introduce new features or integrations, require a governance checkpoint. This mini-review ensures that updates do not introduce security, compliance, or performance risks. Treat this as a lightweight version of the initial approval process, focused on validating changes against enterprise standards.

3. **Plan for scalability.** If the agent’s usage increases, verify that the agent’s architecture supports growth. Direct teams to conduct load testing and coordinate with IT for capacity planning. If expansion into new languages or regions is likely, begin integrating multilingual capabilities and localization support early. This proactive approach avoids reactive fixes and ensures readiness for broader deployment.

4. **Manage change.** For significant updates, such as switching to a new model or altering core functionality, require formal change management. Notify users in advance, document version history, and consider A/B testing to validate improvements. Maintain rollback options to mitigate risk. These practices preserve trust and ensure continuity in user experience.

5. **Retirement or end-of-life.** When an agent no longer delivers value, due to process changes, low usage, or better alternatives, retire it in a controlled manner. Communicate the retirement plan to users, offer alternatives, and revoke access to systems and data. Archive logs and knowledge bases for future reference or audit needs. Update documentation to prevent confusion and conduct a post-mortem to capture lessons learned. Use these insights to refine future AI strategies and avoid repeating past missteps.

## Gather user feedback continuously

Quantitative metrics provide valuable insight, but they do not capture the full picture. To understand how AI agents perform in real-world scenarios, technical decision makers must direct their teams to establish persistent feedback loops with users. These feedback mechanisms help identify usability issues, uncover unmet needs, and guide iterative improvements.

Establish multiple feedback channels to capture diverse perspectives:

- **Maintain in-product rating tools** such as thumbs up/down or star ratings. Review this feedback regularly daily or weekly to identify recurring issues or emerging user needs. Prioritize comments that highlight confusion, unmet expectations, or suggestions for new capabilities.

- **Monitor support tickets** related to the agent’s behavior. Include tickets such as “the bot gave me a wrong answer on policy X” in the product backlog. These reports often reveal gaps in the agent’s knowledge or logic and should trigger targeted updates.

- **Engage business stakeholders** such as department heads or team leads. Schedule periodic check-ins to understand how the agent fits into their workflows. If business processes evolve, the agent must reflect those changes to remain useful.

- **Track unhandled or fallback queries.** Most platforms log instances where the agent fails to respond or defaults to a generic answer. These logs highlight opportunities to expand the agent’s capabilities or knowledge base. Often, users ask for features or information that teams did not anticipate but can reasonably support.

Treat the agent as a product with a user experience that requires continuous refinement. User sentiment shifts over time, so teams must stay attuned to it. Quick responses to feedback such as fixing a frequently misunderstood question or adjusting tone improve adoption and satisfaction across the organization.

## Iterate the framework itself

Managing AI agents over time reveals strengths and limitations in the organization’s operating model. Technical decision makers must periodically assess how well the broader framework strategy, governance, build, and manage supports long-term success. This reflection ensures that the organization adapts its approach based on real-world experience.

For example, the initial governance process might feel too heavy for small updates but insufficient for major changes. Teams may need to streamline certain steps or introduce new checkpoints. Similarly, the build phase might benefit from clearer handoffs between design and deployment, or the manage phase might require stronger cost controls.

Direct teams to treat the framework as a living guide. Encourage them to document lessons learned, propose adjustments, and share feedback across departments. This practice builds organizational maturity and ensures that AI initiatives remain aligned with business goals, risk tolerance, and resource constraints.

By continuously refining both the agents and the framework that supports them, organizations create a sustainable model for AI adoption that delivers measurable value over time.

