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

Start by establishing a **clear ownership model** for AI across the organization. Define who sets the AI strategy, who builds and maintains agents, and how teams collaborate. You should formalize this through a **platform-and-workload team structure.**

1. **Platform team responsibilities:** The platform should be centrally managed typically within IT or engineering and responsible for delivering repeatable AI agent capabilities that workload teams need. The platform should also enforce governance policies across workload environments and have visibility into all agents performance and logs.

2. **Workload team responsibilities:** Workload teams, embedded within business units, should be empowered to innovate using these platform services. Your role is to ensure they have the autonomy to define agent requirements, build conversational flows, prepare domain-specific data, and integrate agents into local systems while staying within the guardrails provided by the platform team.

3. **Enabling, support teams:** To accelerate adoption and reduce friction, you should establish an AI Center of Excellence (CoE). This is not a governance body. It’s an enabling function. Staff it with specialists who can provide reusable templates, training programs, and short-term project support. The CoE should host internal workshops, investigate emerging technologies, and share best practices across teams. As a leader, you must ensure the CoE has the authority and resources to act as a multiplier across the organization.

## Agent skill assessment and training

AI competency directly impacts business outcomes such as return on investment, risk mitigation, and operational efficiency. Treating AI skills as a strategic asset ensures your organization uses AI responsibly and effectively.

### Assess current skills

Begin by conducting a **skills assessment** across your organization. Identify what new skills are needed to deliver and sustain AI agents, then evaluate your team’s proficiency in each area. Common skills include:

| Skill area | Description |
| --- | --- |
| Prompt engineering | Crafting effective prompts and dialogues for LLMs. |
| Data science | Understanding how to fine-tune models, evaluate model outputs, and handle model-related issues. |
| Software integration | Skills to integrate AI with enterprise systems (APIs, cloud architecture). |
| User experience design |Conversational UX is a specialized skill – making interactions with the AI agent intuitive and friendly. |
| AI governance and ethics | Ability to interpret AI principles and ensure the agent’s design aligns with them (this might be within the CoE or compliance teams). |

Document gaps such as developers skilled in web applications but unfamiliar with AI integration. This assessment informs whether to train existing staff or hire new talent

### Close agent skill gap

Decide where to train and where to hire. For each gap, determine if it’s feasible to upskill existing staff or faster to bring in new talent. Often, core development teams can be trained on prompt engineering and AI service usage, especially with Microsoft’s user-friendly tools. However, for highly specialized areas, you might hire an expert or use a consultant to avoid learning by costly mistakes.

**Launch a focused training program to build AI competency across teams.** Approach AI skills development with the same seriousness as adopting a new technology stack. Create a learning plan and use both internal and external resources:

- **Use Microsoft’s free training resources.** Microsoft Learn offers modules and learning paths on AI services. There are also certifications like Azure AI Engineer. Encourage team members to complete relevant modules and perhaps achieve certifications. This builds foundational knowledge in a structured way.

- **Hands-on workshops and hackathons.** Organize internal training sessions where teams practice on real scenarios. For example, a workshop on prompt engineering could involve taking a sample prompt and iteratively improving it with an instructor. Hackathons are a great way for multidisciplinary teams to collaborate and build a small prototype AI agent in 1-2 days, which teaches practical skills and sparks ideas.

- **Vendor or partner-led training.** Consider bringing in Microsoft or a certified partner to run training sessions tailored to your context. This could be an onsite (or virtual) training where your actual use cases are used as examples. For instance, a partner could walk your team through building a prototype agent using your data, teaching them methods along the way. Such guided training often accelerates learning.

- **Mentorship and peer learning.** If you have one or two people who’ve already built an AI agent, set up a mentorship or “office hours” scheme. Those people can coach others through their projects. Create a community channel (Teams chat) for AI practitioners in your company to ask questions and share tips spontaneously.

### Start and build new skills in parallel

In parallel, adopt a **phased skill-building strategy**. Start with platforms your teams already understand, such as Copilot Studio, and begin deploying agents. Simultaneously, send a subset of your staff for training on Azure AI Foundry to prepare for more advanced custom agents. Consider bringing in Microsoft partners to launch initial projects while your team shadows and learns.

#### Continuous training

Importantly, extend training beyond developers. Ensure that **domain experts** within workload teams understand how to work with AI agents, how to feed them new information, interpret outputs, and recognize limitations. Train support and operations teams to maintain and troubleshoot AI solutions. You should mandate cross-functional training and allocate budget for ongoing learning, recognizing that AI technologies evolve rapidly.