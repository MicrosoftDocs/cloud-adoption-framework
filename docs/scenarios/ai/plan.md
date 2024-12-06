---
title: AI Plan - Process to plan for AI adoption
description: Learn the process to plan for AI adoption with best practices and recommendations.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Plan - Process to plan for AI adoption

This article outlines the organizational process for planning AI adoption. An AI adoption plan details the steps an organization must take to integrate AI into its operations. This plan ensures alignment between AI initiatives and business goals. It helps organizations allocate resources, develop skills, and deploy technology for effective AI adoption.

:::image type="content" source="./images/ai-plan.svg" alt-text="Diagram showing the AI adoption process: AI Strategy, AI Plan, AI Ready, Govern AI, Manage AI, and Secure AI." lightbox="./images/ai-plan.svg" border="false":::

## Assess AI skills

In your [technology strategy](./strategy.md#define-an-ai-technology-strategy), you identified AI uses cases and AI solutions for each. These solutions require certain AI skills to adopt. Evaluate your current AI skills and identify gaps to address before proceeding. An AI maturity assessment helps determine your readiness to implement AI. It also guides the selection of use cases that match your capabilities and expedites your success. Use the following table to assess your AI maturity level. For more information, see [Technical Assessment for Generative AI in Azure](/assessments/443670b4-11d1-4dd7-8128-b2bdb7a2bf2f/).

  | AI maturity level | Skills required | Data readiness | Feasible AI use cases |
  |-------------------|-----------------|----------------|----------------------|
  | Level 1       | ▪ Basic understanding of AI concepts <br> ▪ Ability to integrate data sources and map out prompts | ▪ Minimal to zero data available <br> ▪ Enterprise data available | ▪ Azure quickstart (*see table*) <br> ▪ Copilot Studio app |
  | Level 2       | ▪ Experience with AI model selection <br> ▪ Familiarity with AI deployment and endpoint management <br> ▪ Experience with data cleaning and processing | ▪ Minimal to zero data available <br> ▪ Small, structured dataset <br> ▪ Small amount of domain-specific data available | ▪ Any of the previous projects <br> ▪ Custom analytical AI workload that uses Azure AI services <br> ▪ Custom generative AI chat app without Retrieval Augmented Generation (RAG) in Azure AI Foundry  <br> ▪ Custom machine learning app with automated model training <br> ▪ Fine-tuning a generative AI model |
  | Level 3       | ▪ Proficiency in prompt engineering <br> ▪ Proficiency in AI model selection, data chunking, and query processing <br> ▪ Proficiency in data preprocessing, cleaning, splitting, and validating <br> ▪ Grounding data for indexing | ▪ Large amounts of historical business data available for machine learning <br> ▪ Small amount of domain-specific data available | ▪ Any of the previous projects <br> ▪ Generative AI app with RAG in Azure AI Foundry (or Azure Machine Learning) <br> ▪ Training and deploying a machine learning model in Machine Learning <br> ▪ Training and running a small AI model on Azure Virtual Machines |
  | Level 4    | ▪ Advanced AI / machine learning expertise, including infrastructure management <br> ▪ Proficiency in handling complex AI model training workflows <br> ▪ Experience with orchestration, model benchmarking, and performance optimization <br> ▪ Strong skills in securing and managing AI endpoints | ▪ Large amounts of data available for training | ▪ Any of the previous projects <br> ▪ Training and running a large generative or nongenerative AI app on Virtual Machines, Azure Kubernetes Service, or Azure Container Apps |

## Acquire AI skills

Acquiring AI skills requires organizations to assess their current talent pool and determine whether to upskill, recruit, or partner with external experts. Assess your current talent pool to identify needs for upskilling, recruiting, or external partnerships. Building a skilled AI team ensures you can adapt to challenges and handle various AI projects. AI constantly evolves, so maintaining a culture of continuous learning supports innovation and keeps skills current.

- *Learn AI skills.* Use the [AI learning hub](/ai/) platform for free AI training, certifications, and product guidance. Set certification goals, such as earning [Azure AI Fundamentals](/credentials/certifications/azure-ai-fundamentals/), [Azure AI Engineer Associate](/credentials/certifications/azure-ai-engineer/), and [Azure Data Scientist Associate](/credentials/certifications/azure-data-scientist/) certifications.

- *Recruit AI professionals.* For expertise beyond your internal capabilities, recruit AI professionals experienced in model development, generative AI, or AI ethics. These professionals are in high-demand. Consider collaborating with educational institutions to access fresh talent. Make sure to update job descriptions to reflect evolving AI needs, and offer competitive compensation. Create an attractive employer brand. Showcase your organization’s commitment to innovation and technological advancement, making your brand appealing to AI professionals.

- *Use Microsoft partners to acquire AI skills.* Use the [Microsoft partners marketplace](https://partner.microsoft.com//partnership/find-a-partner) to address skill shortages and meet time constraints. Microsoft partners provide AI, data, and Azure expertise across various industries.

## Access AI resources

As a tactical step to developing AI solutions, you need to be able to access them. The goal is to provide a quick way to understand and access what you need to start using Microsoft AI solutions.

- *Access Microsoft 365 Copilot.* Most Microsoft SaaS Copilots require a license or an add-on subscription. [Microsoft 365 Copilot](https://www.microsoft.com//microsoft-365/microsoft-copilot#plans) requires a Microsoft 365 business or enterprise license to which you add on the Copilot license.

- *Access Microsoft Copilot Studio.* [Microsoft Copilot Studio](/microsoft-copilot-studio/requirements-licensing-subscriptions) uses a standalone license or an add-on license.

- *Access in-product Copilots.* In-product Copilots have different access requirements for each, but access to the primary product is required. For more information on each, see [GitHub](https://azure.microsoft.com//products/github/copilot), [Power Apps](https://www.microsoft.com//power-platform/products/power-apps), [Power BI](https://www.microsoft.com//power-platform/products/power-bi), [Dynamics 365](https://www.microsoft.com//dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com//power-platform/products/power-automate), and [Azure](https://azure.microsoft.com//products/copilot/).

- *Access role-based Copilots.* Role-based Copilots also have their own access requirements. For more information, see [Role-based agents for Microsoft 365 Copilot](https://www.microsoft.com/microsoft-365/copilot/copilot-for-work#role-based-agents) and [Microsoft Copilot for Security](https://www.microsoft.com/security/business/ai-machine-learning/microsoft-copilot-security).

- *Access Azure AI resources.* Azure PaaS and IaaS solutions require an [Azure account](https://azure.microsoft.com/pricing/purchase-options/azure-account/search). These services include Azure OpenAI Service, Azure AI Foundry, Azure Machine Learning, Azure AI services, Azure Virtual Machines, and Azure CycleCloud.

## Prioritize AI use cases

After assessing skills, resources, and AI maturity, prioritize AI use cases identified in your [AI Strategy](./strategy.md#identify-ai-use-cases). This prioritization ensures you focus on projects that offer the greatest value, align with business goals, and match your current capabilities. Follow these steps:

- *Assess skills and resources*. After acquiring AI skills, review your current AI maturity, available data, and resource access. This assessment helps reset priorities based on what's possible.

- *Evaluate use cases.* Prioritize projects based on their feasibility and strategic value they add to your organization. Align AI use cases with your strategic objectives to ensure that efforts contribute to overall success.

- *Select top use cases.* Create a shortlist of high-priority AI use cases that form the basis for further exploration and testing.

## Create an AI proof of concept

Developing an AI proof of concept (PoC) validates the feasibility and potential value of a prioritized use case on a smaller scale. The PoC process helps refine use case priority, reduce risk, and identify challenges before moving to full-scale deployment. This iterative approach lets you adjust your AI plan based on real-world insights.

- *Select the right opportunity.* From your shortlist of AI use cases, choose a high-value project that aligns with your AI maturity level. Ideally, start with an internal project, not customer facing. Internal projects minimize risk and provide a foundation for testing the workload. Use the PoC to validate the approach and refine it before expanding to production. Conduct A/B testing to establish what works and gather baseline data.

- *Start with an Azure quickstart guide.* Azure offers step-by-step guidance for creating basic applications using its AI platforms. These guides, called quickstarts, help you deploy an application and include instructions for deleting it afterward. Quickstarts provide a simple way to familiarize your organization with the technology.

    | AI type  | Azure AI quickstart guide |
    |----------|--------------|
    | Generative AI | [Azure AI Foundry](/azure/ai-studio/quickstarts/get-started-playground), [Azure OpenAI](/azure/ai-services/openai/assistants-quickstart), [Copilot Studio](/microsoft-copilot-studio/fundamentals-get-started)   |
    | Machine learning | [Azure Machine Learning](/azure/machine-learning/tutorial-azure-ml-in-a-day?)         |
    | Analytical AI | Azure AI services: [Azure AI Content Safety](/azure/ai-services/content-safety/quickstart-jailbreak), [Azure AI Custom Vision](/azure/ai-services/custom-vision-service/getting-started-build-a-classifier), [Document Intelligence Studio](/azure/ai-services/document-intelligence/quickstarts/try-document-intelligence-studio), [Face service](/azure/ai-services/computer-vision/quickstarts-sdk/identity-client-library), \*[Azure AI Language](/azure/ai-services/language-service/overview#available-features), [Azure AI Speech](/azure/ai-services/speech-service/overview#get-started), \*[Azure AI Translator](/azure/ai-services/translator/translator-overview#translator-features-and-development-options), [Azure AI Vision](/azure/ai-services/computer-vision/overview#get-started). <br> \**Each feature of this AI service has its own quickstart guide.*|

- *Reprioritize AI opportunities*. Use the insights gained from the PoC to refine your list of AI use cases. If the PoC presents unexpected challenges, adjust your priorities and focus on more feasible projects.

## Implement responsible AI

Responsible AI adoption requires incorporating ethical frameworks and regulatory practices into your AI implementation plan. This approach ensures that AI initiatives align with organizational values, protect user rights, and comply with legal standards.

- *Use responsible AI planning tools.* To integrate responsible AI principles into your adoption process, use tools and frameworks that support ethical AI practices. Microsoft offers several resources.

    | Responsible AI planning tool | Description |
    | --- | --- |
    | [AI impact assessment template](https://www.microsoft.com/ai/tools-practices)| Evaluate potential social, economic, and ethical impacts of AI initiatives.|
    | [Human-AI eXperience Toolkit](https://www.microsoft.com/research/project/hax-toolkit/) | Design AI systems that prioritize user well-being and foster positive interactions. |
    | [Responsible AI Maturity Model](https://www.microsoft.com/research/publication/responsible-ai-maturity-model/) | Assess and advance your organization's maturity in implementing responsible AI practices.|
    | [Responsible AI for workload teams](/azure/well-architected/ai/responsible-ai) | Recommendations for workload teams to implement responsible AI when building workloads in Azure. |

- *Start the AI governance process.* Responsible AI adoption involves creating governance policies to guide AI projects and monitor AI system behaviors. Start by identifying organizational risks specific to your AI initiatives. Document governance policies that outline responsibilities, compliance requirements, and ethical standards. See the article on Govern AI for details on this process.
    > [!div class="nextstepaction"]
    > [Govern AI](./govern.md)

- *Start the AI management process.* AI management frameworks, such as GenAIOps or MLOps, help ensure ongoing adherence to responsible AI principles as your AI systems evolve. These practices involve deployment management, continuous monitoring, and cost optimization for AI models in production. See the article on Manage AI for details on this process.
    > [!div class="nextstepaction"]
    > [Manage AI](./manage.md)

- *Start the AI security process.* Security forms a critical part of responsible AI adoption. Regular security assessments help protect the confidentiality, integrity, and availability of your AI systems. Conduct risk assessments that address potential security threats specific to AI, such as adversarial attacks or data breaches. See the article on Secure AI for details on this process.
    > [!div class="nextstepaction"]
    > [Secure AI](./secure.md)

## Estimate delivery timelines

Estimating delivery timelines involves setting realistic schedules and milestones for AI project implementation. Clear timelines allow organizations to allocate resources effectively and manage stakeholder expectations, supporting a structured progression from proof of concept to production. By establishing specific milestones, organizations can measure their progress, identify potential delays, and make adjustments to keep projects on track and within budget.

Based on your PoC, assign a delivery timeline for your AI opportunities. Create a timeline with clear milestones and deliverables for implementing selected use cases. Assign teams, define roles, and secure necessary tools or partnerships. Microsoft AI SaaS solutions provide the shortest timelines for seeing a return on investment. Timelines for building AI apps on Azure PaaS and IaaS solutions depend on your use case and AI maturity. In most cases, it takes weeks or months before you have a production-ready AI workload.

## Next step

To ***build*** AI workloads with Azure PaaS or IaaS services, follow the [AI Ready](./ready.md) guidance to establish your AI foundation. If you decided to ***buy*** a Microsoft Copilot SaaS solution, skip to the [Govern AI](./govern.md) guidance to establish organizational governance for AI.

> [!div class="nextstepaction"]
> [AI Ready (only for AI PaaS and IaaS adoption)](ready.md)

> [!div class="nextstepaction"]
> [Govern AI (for AI SaaS, PaaS, and IaaS adoption)](ready.md)
