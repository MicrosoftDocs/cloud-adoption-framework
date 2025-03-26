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

In your [technology strategy](./strategy.md#define-an-ai-technology-strategy), you defined AI use cases and selected solutions. Each solution requires specific AI skills. Assess your current skills, identify gaps, and address them before implementation. Use an AI maturity assessment to measure readiness, align use cases with capabilities, and accelerate progress. Refer to the following table to assess your maturity.

  | AI maturity level | Skills required | Data readiness | Feasible AI use cases |
  |-------------------|-----------------|----------------|----------------------|
  | Level 1       | ▪ Basic understanding of AI concepts <br> ▪ Ability to integrate data sources and map out prompts | ▪ Minimal to zero data available <br> ▪ Enterprise data available | ▪ Azure quickstart (*see table*) <br> ▪ Any Copilot solution |
  | Level 2       | ▪ Experience with AI model selection <br> ▪ Familiarity with AI deployment and endpoint management <br> ▪ Experience with data cleaning and processing | ▪ Minimal to zero data available <br> ▪ Small, structured dataset <br> ▪ Small amount of domain-specific data available | ▪ Any of the previous projects <br> ▪ Custom analytical AI workload that uses Azure AI services <br> ▪ Custom generative AI chat app without Retrieval Augmented Generation (RAG) in Azure AI Foundry  <br> ▪ Custom machine learning app with automated model training <br> ▪ Fine-tuning a generative AI model |
  | Level 3       | ▪ Proficiency in prompt engineering <br> ▪ Proficiency in AI model selection, data chunking, and query processing <br> ▪ Proficiency in data preprocessing, cleaning, splitting, and validating <br> ▪ Grounding data for indexing | ▪ Large amounts of historical business data available for machine learning <br> ▪ Small amount of domain-specific data available | ▪ Any of the previous projects <br> ▪ Generative AI app with RAG in Azure AI Foundry (or Azure Machine Learning) <br> ▪ Training and deploying a machine learning model in Machine Learning <br> ▪ Training and running a small AI model on Azure Virtual Machines |
  | Level 4    | ▪ Advanced AI / machine learning expertise, including infrastructure management <br> ▪ Proficiency in handling complex AI model training workflows <br> ▪ Experience with orchestration, model benchmarking, and performance optimization <br> ▪ Strong skills in securing and managing AI endpoints | ▪ Large amounts of data available for training | ▪ Any of the previous projects <br> ▪ Training and running a large generative or nongenerative AI app on Virtual Machines, Azure Kubernetes Service, or Azure Container Apps |

## Acquire AI skills

Acquiring AI skills requires organizations to assess their current talent pool and determine whether to upskill, recruit, or partner with external experts. Assess your current talent pool to identify needs for upskilling, recruiting, or external partnerships. Building a skilled AI team ensures you can adapt to challenges and handle various AI projects. AI constantly evolves, so maintaining a culture of continuous learning supports innovation and keeps skills current.

- *Learn AI skills.* Use the [AI learning hub](/ai/) platform for free AI training, certifications, and product guidance. For Azure use, set certification goals, such as earning [Azure AI Fundamentals](/credentials/certifications/azure-ai-fundamentals/), [Azure AI Engineer Associate](/credentials/certifications/azure-ai-engineer/), and [Azure Data Scientist Associate](/credentials/certifications/azure-data-scientist/) certifications.

- *Recruit AI professionals.* For expertise beyond your internal capabilities, recruit AI professionals experienced in model development, generative AI, or AI ethics. These professionals are in high-demand. Consider collaborating with educational institutions. Make sure to update job descriptions to reflect evolving AI needs, and offer competitive compensation. Create an attractive employer brand. Showcase your organization’s commitment to innovation and technological advancement, making your brand appealing to AI professionals.

- *Use Microsoft partners to acquire AI skills.* Use the [Microsoft partners marketplace](https://partner.microsoft.com//partnership/find-a-partner) to address skill shortages and meet time constraints. Microsoft partners provide AI, data, and Azure expertise across various industries.

## Access AI resources

Use the following guidance to quickly understand access requirements for Copilot and Azure AI offerings:

- *Access Microsoft 365 Copilot.* Most Microsoft SaaS Copilots require a license or an add-on subscription. [Microsoft 365 Copilot](https://www.microsoft.com//microsoft-365/microsoft-copilot#plans) requires a Microsoft 365 business or enterprise license to which you add on the Copilot license.

- *Access Microsoft Copilot Studio.* [Microsoft Copilot Studio](/microsoft-copilot-studio/requirements-licensing-subscriptions) uses a standalone license or an add-on license.

- *Access in-product Copilots.* In-product Copilots have different access requirements for each, but access to the primary product is required. For more information on each, see [GitHub](https://azure.microsoft.com//products/github/copilot), [Power Apps](https://www.microsoft.com//power-platform/products/power-apps), [Power BI](https://www.microsoft.com//power-platform/products/power-bi), [Dynamics 365](https://www.microsoft.com//dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com//power-platform/products/power-automate), [Microsoft Fabric](/fabric/fundamentals/copilot-enable-fabric), and [Azure](https://azure.microsoft.com//products/copilot/).

- *Access role-based Copilots.* Role-based Copilots also have their own access requirements. For more information, see [Role-based agents for Microsoft 365 Copilot](https://www.microsoft.com/microsoft-365/copilot/copilot-for-work#role-based-agents) and [Microsoft Copilot for Security](https://www.microsoft.com/security/business/ai-machine-learning/microsoft-copilot-security).

- *Access Azure services.* Azure PaaS and IaaS solutions require an [Azure account](https://azure.microsoft.com/pricing/purchase-options/azure-account/search). These services include Azure OpenAI Service, Azure AI Foundry, Azure Machine Learning, Azure AI services, Azure Virtual Machines, and Azure CycleCloud.

## Prioritize AI use cases

Prioritize the use cases defined in your [AI Strategy](./strategy.md#identify-ai-use-cases). Focus on projects that provide the most value, align with business goals, and match your current capabilities.

1. *Assess skills and resources*. Review your AI maturity, data availability, tools, and staffing. Use this input to reset priorities based on what's achievable.

1. *Evaluate use cases.* Rank each use case based on feasibility and strategic value. Confirm alignment with organizational goals.

1. *Select top use cases.* Create a shortlist of high-priority use cases.

## Create an AI proof of concept

If you plan to build an AI agent or workload, create a proof of concept (PoC) to validate feasibility and value. The PoC or trial helps prioritize use cases, reduce risk, and uncover challenges before scaling.

1. *Choose the right use case.* Select a high-value project from your AI shortlist that matches your AI maturity. If you're building an AI app, start with an internal, non-customer-facing project to limit risk and test your approach. Use A/B testing to validate the solution and gather baseline data.

- *Get started.* Microsoft has step-by-step guidance for POCs on its various AI services. Use the following table to find the right get started guide.

    | AI type  | Get started guide |
    |----------|--------------|
    | Generative AI | Azure PaaS: [Azure AI Foundry](/azure/ai-studio/quickstarts/get-started-playground) and [Azure OpenAI](/azure/ai-services/openai/assistants-quickstart)<br><br>Microsoft Copilot: [Copilot Studio](/microsoft-copilot-studio/fundamentals-get-started)   |
    | Machine learning | [Azure Machine Learning](/azure/machine-learning/tutorial-azure-ml-in-a-day?)         |
    | Analytical AI | Azure AI services: [Azure AI Content Safety](/azure/ai-services/content-safety/quickstart-jailbreak), [Azure AI Custom Vision](/azure/ai-services/custom-vision-service/getting-started-build-a-classifier), [Document Intelligence Studio](/azure/ai-services/document-intelligence/quickstarts/try-document-intelligence-studio), [Face service](/azure/ai-services/computer-vision/quickstarts-sdk/identity-client-library), [Azure AI Language](/azure/ai-services/language-service/overview#available-features), [Azure AI Speech](/azure/ai-services/speech-service/overview#get-started), [Azure AI Translator](/azure/ai-services/translator/translator-overview#translator-features-and-development-options), [Azure AI Vision](/azure/ai-services/computer-vision/overview#get-started)<br>*Each feature of this AI service has its own guide.* |

1. *Reprioritize based on results.* Use the PoC to reprioritize your use cases. If the POC reveals major challenges, shift to more practical opportunities.

## Implement responsible AI

Build responsible AI into your implementation plan from the start. Apply ethical principles, follow regulatory standards, and create governance practices that ensure your AI systems align with organizational values, protect user rights, and meet compliance requirements.

1. *Use responsible AI planning tools.* Use the following table to find responsible AI tools and frameworks.

    | Responsible AI planning tool | Description |
    | --- | --- |
    | [AI impact assessment template](https://www.microsoft.com/ai/tools-practices)| Evaluate the social, economic, and ethical effects of AI initiatives.|
    | [Human-AI eXperience Toolkit](https://www.microsoft.com/research/project/hax-toolkit/) | Design AI systems that support user well-being and positive interaction. |
    | [Responsible AI Maturity Model](https://www.microsoft.com/research/publication/responsible-ai-maturity-model/) | Assess and advance your organization’s responsible AI maturity.|
    | [Responsible AI for workload teams](/azure/well-architected/ai/responsible-ai) | Follow practical guidance for applying responsible AI in Azure workloads. |

1. *Start AI governance.* Establish governance to guide AI projects and monitor system behavior. Identify AI-related risks, then define policies covering roles, compliance, and ethical requirements. See [Govern AI](./govern.md) for details.

1. *Start AI management.* Use AI operations frameworks like GenAIOps or MLOps. These frameworks include deployment tracking, performance monitoring, and cost control. See [Manage AI](./manage.md) for details.

1. *Start AI security.* Protect AI systems with regular security assessments. Address threats such as adversarial inputs and data breaches. See [Secure AI](./secure.md) for details on this process.

## Estimate delivery timelines

Assign a delivery timeline to each AI opportunity based on insights from your PoC. Microsoft Copilots provide the shortest timelines for seeing a return on investment (days to weeks). Timelines for building AI workloads with Azure vary by use case and your AI maturity level. Most build projects require several weeks to months to reach production readiness.

## Next step

To build AI workloads with Azure, proceed to [AI Ready](./ready.md). For Copilot adoption, skip to the [Govern AI](./govern.md) to establish organizational AI  governance.

> [!div class="nextstepaction"]
> [AI Ready (Azure only)](ready.md)

> [!div class="nextstepaction"]
> [Govern AI (Copilots and Azure)](ready.md)
