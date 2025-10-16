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

Adopting AI agents is as much about organizational change as it is about tech. Define roles, team structures, and skill development plans so that the right people are in place to design, build, and maintain your AI solutions. A common pitfall is to treat AI projects as isolated technical experiments. Successful AI agent adoption requires cross-functional collaboration and new expertise across the company

## Define team structure

Establish a clear model dividing responsibilities. A recommended approach is to have a central platform team and distributed workload teams. This structure allows innovation to scale. Those closest to the business problem develop the solution, ensuring relevance and faster iteration while the platform team ensures they don’t “reinvent the wheel” or violate governance.

1. **Platform team responsibilities:** provides the common infrastructure, tools, and governance frameworks for AI agents. They create reusable components, templates, and enforce standards/policies on things like security and compliance. They also operate any shared services, like the Microsoft Copilot Studio subscription and permissions, and monitor overall agent performance across the organization.

2. **Workload team responsibilities:** Workload teams are embedded in business units (HR, Finance, Customer Service) and build and own the AI agents for their domain. These teams include subject matter experts and developers or power users. They define the agent’s requirements, supply domain-specific data, craft the conversation flows or skills, and integrate the agent into their local processes. The platform team’s guardrails (policies, approved tools, templates) ensure they innovate in a safe and consistent way.

3. **AI Center of Excellence (AI CoE):** It can be valuable to establish a small expert group or AI CoE as an enablement layer. The CoE is not a bottleneck for approval, but rather a support squad of AI specialists (data scientists, experienced AI developers, ethics or compliance experts) who provide consulting to all workload teams. They might conduct training sessions, help review agent designs for quality, run internal hackathons to spur ideas, and stay on top of emerging AI technologies to advise the organization. Ensure the AI CoE has executive support and a clear mission to accelerate AI adoption through best practices and mentorship.

Clarify this division of labor early, so everyone knows who is responsible for what. For example, the platform team might own ML model selection and cost management, while the business team focuses on the agent’s use case and continuous improvement in that context.

## Gain agent skills and training

Assess what new skills your organization needs for AI agents and plan to upskill or hire accordingly. Common skill areas include:

| Skill area | Description |
| --- | --- |
| Prompt engineering | Crafting effective prompts and conversation flows for large language models. |
| Data science | Fine-tuning models, evaluating model outputs, understanding AI performance metrics. |
| Software integration | Connecting AI agents to enterprise systems via APIs, managing cloud resources for AI. |
| User experience design | Designing intuitive conversational interfaces and dialogues. |
| AI governance and ethics | Interpreting responsible AI principles and ensuring agents adhere to them. |

Ensure each project team has access to these skills. You may train existing staff for some (for example, retrain a web developer to use Copilot Studio’s low-code tools) and hire specialists for others (e.g. an experienced ML engineer for a complex Foundry project). Decide which gaps can be filled with internal training and which require new talent or external partners

**Launch a focused training program to build AI competency across teams.** Approach AI skills development with the same seriousness as adopting a new technology stack. Create a learning plan and use both internal and external resources:

- **Use Microsoft’s free training resources.** Use Microsoft Learn’s free online modules and certifications such as Azure AI Engineer Associate to give your team a grounding in AI services

- **Run hands-on workshops.** Run hands-on workshops or hackathons internally. For example, hold a prompt engineering lab where participants practice improving AI responses or a hackathon where cross-functional teams prototype a simple agent in a day or two. This not only builds skills but also enthusiasm and idea-sharing.

- **Consider partner-led training.** Bring in Microsoft or certified partners for tailored sessions or bootcamps on your specific tools like an Azure AI Foundry deep dive or a Copilot Studio workshop using your actual data. This accelerates learning through expert guidance.

- **Encourage mentorship and peer learning.** If some employees have already built AI agents, recognize them as champions who can coach others. Create internal communities of practice such as a Teams channel for AI agent developers to ask questions and share tips.

The objective is to cultivate a broad base of AI proficiency, not just in IT but also among business domain experts who will be working with agents. Plan for continuous learning because AI tech evolves rapidly. Budget time for periodic training updates or refresher courses

## Address change management

Prepare the organization for AI-driven change. Communicate early about what AI agents will and won’t do to manage expectations. Involve end users in pilot testing to gather feedback and build buy-in. From the leadership perspective, reinforce that adopting AI agents is a strategic priority so that managers encourage their teams to embrace the new tools. Celebrate successes and recognize teams that deliver value with AI to foster a culture of innovation.

## Next step

> [!div class="nextstepaction"]
> [Data strategy](./data-strategy.md)