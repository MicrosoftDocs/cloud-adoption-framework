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

Adopting AI agents requires more than technical implementation. It demands a deliberate organizational shift. Define clear roles, team structures, and skill development plans to ensure the right people support the design, deployment, and maintenance of AI solutions. Avoid treating AI as isolated technical experiments. Effective adoption depends on cross-functional collaboration and new capabilities across the organization.

:::image type="content" source="./images/agent-teams.png" alt-text="Diagram that shows how to workload teams, platform teams, and AI CoE work together." lightbox="./images/agent-teams.png" border="false":::

Addressing these people factors early ensures the organization builds the right team structure and capabilities from the outset. This alignment enables teams to deliver higher-quality agents and respond more effectively to change. It transforms AI adoption into a scalable organizational capability rather than a one-time initiative.

## Define responsibilities for agent development

Establish a clear division of responsibilities. A proven model includes a central platform and distributed workloads. This structure supports scalable innovation. Workloads provide business-aligned solutions quickly. The platform enforces consistency and governance.

1. **Platform responsibilities:** The platform provides shared infrastructure, tools, and governance enforcement. Platform builders align the "platform products" they create so that agent developers can consume these products in line with the organization's [responsible AI policies](./responsible-ai.md). Platform responsibilities include creating reusable components, enforcing security and compliance standards, and managing shared services such as Microsoft Copilot Studio subscriptions and permissions. The platform also monitors agent performance across the organization.

2. **Workload responsibilities:** Agent workloads operate within business units and own the agents for their domains. Agent developers define agent requirements, provide domain-specific data, design conversation flows, and integrate agents into business processes. Platform guardrails ensure safe and consistent innovation. Workload developers are responsible for upholding the responsible AI principles throughout development. The platform products they consume only provide guardrails for AI agents. Workload developers must ultimately enforce and evaluate the agent's compliance with the organization's responsible AI principles.

3. **AI Center of Excellence (AI CoE):** An AI CoE consists of an internal team of experts who drive successful and valuable AI outcomes. The AI CoE prevents fragmented or ungoverned AI adoption. It establishes a strong foundation for AI initiatives and provides business and technical consultation that supports successful AI integration. For more information, see [Establish an AI CoE](/azure/cloud-adoption-framework/scenarios/ai/center-of-excellence)

## Gain agent skills and training

Identify the skills required to support AI agents and address gaps through training or hiring. Ensure each project team has access to the necessary expertise. Retrain existing staff where feasible (for example, upskill web developers to use Copilot Studio) and bring in specialists for advanced needs (for example, ML engineers for complex Foundry projects). Use internal training for foundational skills and external partners for specialized instruction.
Common skill areas include:

| Skill area | Description |
| --- | --- |
| [Prompt engineering](/azure/ai-foundry/openai/concepts/prompt-engineering) | Crafting effective instructions and orchestration for agents. |
| Agent optimization | [Fine-tuning models](/azure/ai-foundry/concepts/fine-tuning-overview), evaluating model outputs, understanding AI performance metrics. |
| AI ethics and governance | Interpreting [responsible AI principles](./responsible-ai.md) and ensuring agents adhere to them. |

Develop a structured training program to build AI competency across teams. Treat skills development as a core part of technology adoption. Use a combination of internal and external resources:

- **Use Microsoft’s free training resources.** Use Microsoft Learn’s free online modules and certifications such as [Azure AI Engineer Associate](/credentials/certifications/azure-ai-engineer/?practice-assessment-type=certification) to give your team a grounding in AI services

- **Run hands-on workshops.** Run hands-on workshops or hackathons internally. For example, hold a prompt engineering lab where participants practice improving AI responses or a hackathon, where cross-functional teams prototype a simple agent in a day or two. This not only builds skills but also enthusiasm and idea-sharing.

- **Consider partner-led training.** Bring in Microsoft or [certified training partners](/training/educator-center/programs/global-training-partner/find-global-training-partner) for tailored sessions or bootcamps on your specific tools like an Foundry or Copilot Studio. You can train on your actual data. This accelerates learning through expert guidance.

- **Encourage mentorship and peer learning.** If some employees already built AI agents, recognize them as champions who can coach others. Create internal communities of practice such as a Teams channel for AI agent developers to ask questions and share tips.

Build AI proficiency across both technical and business teams. Plan for continuous learning to keep pace with evolving AI technologies. Allocate time for regular training updates and refreshers.

## Address AI change

Prepare the organization for AI-driven change. Manage expectations by communicating early about what AI agents should and shouldn't do. From the leadership perspective, reinforce that adopting AI agents is a strategic priority so that managers encourage their teams to embrace the new tools. Celebrate successes and recognize teams that deliver value with AI to foster a culture of innovation.

## Next step

> [!div class="nextstepaction"]
> [Data strategy](./data-strategy.md)