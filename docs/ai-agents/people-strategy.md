---
title: People strategy for AI agents
description: Learn the People strategy for AI agents
author: stephen-sumner
ms.author: pnp
ms.date: 11/01/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# People strategy for AI agents

Adopting AI agents is not merely a technical initiative. It’s a strategic transformation that touches every part of the organization. Success depends not only on the right tools and platforms, but also on the right people, structures, and skills. As a technical leader, your role is to architect a team model that balances centralized governance with decentralized innovation, ensuring that every team from engineering to business operations can contribute effectively to AI adoption.

## Roles and responsibilities for agents

Building AI agents is a cross-functional effort. Establish a clear team structure so everyone knows their role. A recommended model is Platform Team vs. Workload (Business) Teams

1. **Platform team responsibilities:** The platform should be centrally managed typically within IT or engineering and responsible for delivering repeatable AI agent capabilities that workload teams need. The platform should also enforce governance policies across workload environments and have visibility into all agents performance and logs.

2. **Workload team responsibilities:** Workload teams, embedded within business units, that actually conceive, build, and own the AI agents for their domain. Empower these teams to innovate within guardrails: they define requirements, design conversational flows, prepare domain-specific data, and integrate the agent into their local systems and processes. The platform team’s guardrails (policies, templates, approved tools) ensure they don’t go off track. This decentralized development speeds up delivery because the people closest to the business problem are building the solution, while the centralized platform team ensures consistency and support.

3. **Enabling, support teams:** Also consider an AI Center of Excellence (CoE) or support team. This is not a bureaucratic layer but an enablement group. Staff it with AI specialists who can create templates, conduct training, and jump in to help various workload teams on short-term projects. The CoE can host internal hackathons, evaluate new AI technologies, and spread best practices throughout the organization. As a leader, ensure the AI CoE has the mandate and resources to accelerate AI adoption. It should have executive support. The AI CoE effectively multiplies your skilled talent by mentoring and guiding others.

## Agent skill assessment and training

Evaluate what new skills your organization needs to build and maintain AI agents. Common skill areas include prompt engineering, data science for model tuning and evaluation, software integration using APIs and cloud platforms, conversational UX design, and AI ethics and governance. Assess your current team against these and identify gaps where, say, your developers might need training on prompt crafting or your data engineers on model monitoring. Decide which gaps you will train existing staff versus hire new talent. For example, you might retrain a web developer to become proficient in using Copilot Studio since it is user-friendly, but for a highly specialized ML engineering need, you might hire an expert or engage a consultant to avoid costly trial and error.

| Skill area | Description |
| --- | --- |
| Prompt engineering | Crafting effective prompts and dialogues for LLMs. |
| Data science | Understanding how to fine-tune models, evaluate model outputs, and handle model-related issues. |
| Software integration | Skills to integrate AI with enterprise systems (APIs, cloud architecture). |
| User experience design |Conversational UX is a specialized skill – making interactions with the AI agent intuitive and friendly. |
| AI governance and ethics | Ability to interpret AI principles and ensure the agent’s design aligns with them (this might be within the CoE or compliance teams). |

**Launch a focused training program to build AI competency across teams.** Approach AI skills development with the same seriousness as adopting a new technology stack. Create a learning plan and use both internal and external resources:

- **Use Microsoft’s free training resources.** Microsoft Learn offers modules and learning paths on AI services. There are also certifications like Azure AI Engineer. Encourage team members to complete relevant modules and perhaps achieve certifications. This builds foundational knowledge in a structured way.

- **Hands-on workshops and hackathons.** Organize internal training sessions where teams practice on real scenarios. For example, a workshop on prompt engineering could involve taking a sample prompt and iteratively improving it with an instructor. Hackathons are a great way for multidisciplinary teams to collaborate and build a small prototype AI agent in 1-2 days, which teaches practical skills and sparks ideas.

- **Vendor or partner-led training.** Consider bringing in Microsoft or a certified partner to run training sessions tailored to your context. This could be an onsite (or virtual) training where your actual use cases are used as examples. For instance, a partner could walk your team through building a prototype agent using your data, teaching them methods along the way. Such guided training often accelerates learning.

- **Mentorship and peer learning.** If you have one or two people who’ve already built an AI agent, set up a mentorship or “office hours” scheme. Those people can coach others through their projects. Create a community channel (Teams chat) for AI practitioners in your company to ask questions and share tips spontaneously.

This capacity building should be ongoing. Start with easier platforms such as training many people on Copilot Studio to get quick wins while a subset of developers learn advanced Foundry skills in parallel for the harder projects. Also include non-developers. Domain experts should learn how to work with and supervise AI agents and support and operations teams need to know how to maintain them. Continuous training is key so budget for it and update curricula as AI tech evolves quickly.

## Next step

> [!div class="nextstepaction"]
> [Data strategy](./data-strategy.md)