---
title: AI Plan - Recommendations to develop an AI adoption plan
description: View a comprehensive guide on AI adoption planning, skill acquisition, resource access, PoC creation, and responsible AI practices for organizations.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Plan - Recommendations to develop an AI adoption plan

This article provides recommendations for planning AI adoption. Strategy provided an end goal to your AI adoption. Here, you get more tactical with preparing your organization to adopt AI. Fundamental to planning is ensuring you have the right skills and planning for AI deployment. Deployment requires thought around responsible AI and your approach to deploying and consuming AI endpoints across your applications.  

## Evaluate AI maturity level

As with any technology, there’s a learning curve to adopting AI. Evaluating your AI maturity level can help you prioritize the right AI opportunities. AI projects that are too advanced for your experience don't provide the return on investment you need. If you plan to build generative AI applications, start with this generative AI technical assessment. At a high level, here are the readiness factors you need to consider.  

| AI Maturity Level | Feasible AI Projects | Skills Required | Data Readiness |
|-------------------|----------------------|-----------------|----------------|
| **Level 1**       | - Microsoft Learn Quickstart <br> - Copilot Studio app | - Basic understanding of AI concepts <br> - Ability to integrate data sources and map out prompts | - Minimal to zero data available <br> - Enterprise data available |
| **Level 2**       | - Any of the previous projects <br> - Custom analytical AI application using Azure AI Services <br> - Custom generative AI chat app with Azure AI Studio without retrieval augmented generation <br> - Custom machine learning app with automated model training <br> - Fine-tuning generative AI model | - Experience with AI model selection <br> - Familiarity with AI deployment and endpoint management <br> - Experience with data cleaning and processing | - Minimal to zero data available <br> - Small, structured dataset <br> - Small amount of domain-specific data available |
| **Level 3**       | - Any of the previous projects <br> - Generative AI app with RAG in Azure AI Studio (or Azure Machine Learning) <br> - Train and deploy machine learning model in Azure Machine Learning <br> - Train and run small AI model on Azure Virtual Machines | - Proficiency in prompt engineering <br> - Proficiency with AI model selection, data chunking, and query processing <br> - Proficiency in data preprocessing, cleaning, splitting, and validating <br> - Grounding data for indexing | - Large amounts of historical business data available for machine learning <br> - Small amount of domain-specific data available |
| **Level 4**       | - Any of the previous projects <br> - Train and run large generative or nongenerative AI app on Azure Virtual Machines, Azure Kubernetes Service, Azure Container Apps | - Advanced AI/ML expertise, including infrastructure management <br> - Proficiency in handling complex AI model training workflows <br> - Experience with orchestration, model benchmarking, and performance optimization <br> - Strong skills in securing and managing AI endpoints | - Large amounts of data available for training |

## Acquire AI skills

Assess your organization’s current AI skill set to identify gaps and determine whether to develop internally or hire externally. A combination of approaches is often needed, balancing in-house development with outsourcing based on broader organizational strategy. For strategic projects, focus on building in-house expertise for long-term success. In areas requiring quick value, external partnerships can fill immediate gaps while internal capabilities are developed. This combination ensures efficiency in the short term and strategic skill growth for long-term competitiveness.

- *Learn AI skills.* The [Microsoft Learn](/) platform has free AI skills [training](/training/), [certifications](/credentials/), and [product-specific guidance](/docs/) for all Microsoft and Azure AI services. Set certifications goals, such as earning Azure AI related certifications: [Azure AI Fundamentals](/credentials/certifications/azure-ai-fundamentals/), [Azure AI Engineer Associate](/credentials/certifications/azure-ai-engineer/) , and [Azure Data Scientist Associate](/credentials/certifications/azure-data-scientist/) . There’s learning resources for other subjects on the platform, so filter the results to return AI-specific results.

- *Recruit AI skills.* For expertise that can't be developed internally within your time frame, recruit professionals. These professionals should have experience in AI model development, generative AI operations, or AI ethics skills.

    - *Form partnerships with educational institutions.* Collaborate with universities and training centers to access fresh talent equipped with the latest AI skills and insights.
    - *Regularly update job descriptions.* Ensure job roles and requirements reflect the rapidly evolving AI landscape, helping you attract candidates with the most relevant skills.
    - *Create an attractive employer brand.* Showcase your organization’s commitment to innovation and technological advancement, making your brand appealing to AI professionals.
    - *Offer competitive compensation packages.* Provide AI professionals with attractive salary structures and benefits to both attract and retain top-tier talent in the field.

- *Use Microsoft partners to access AI skills.* Use a Microsoft partner to address skills shortages. build more complex solutions or increase personnel count to meet time constraints. Use the [Microsoft partners marketplace](https://partner.microsoft.com//partnership/find-a-partner) to find partners with expertise in AI, data, and Azure across multiple industries.

## Gain access to AI resources

As a tactical step to developing AI solutions, you need to be able to access them. The goal here's to provide a quick way to understand and access what you need to start using AI solutions.

- *Access Microsoft Copilots.* Microsoft SaaS Copilots require a license or add-on subscription, except [Microsoft Copilot (free)](https://copilot.microsoft.com/).

    - [Copilot for Microsoft 365](https://www.microsoft.com//microsoft-365/microsoft-copilot#plans)requires a Microsoft 365 business or enterprise license to which you add on the Copilot license.

    - [Copilot Studio](/microsoft-copilot-studio/requirements-licensing-subscriptions) uses a standalone license or as an add-on license.

    - In-product Copilots, see [GitHub](https://azure.microsoft.com//products/github/copilot), [Power Apps](https://www.microsoft.com//power-platform/products/power-apps), [Power BI](https://www.microsoft.com//power-platform/products/power-bi?culture=&country=us), [Dynamics 365](https://www.microsoft.com//dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com//power-platform/products/power-automate), and [Azure](https://azure.microsoft.com//products/copilot/).

    - Role-based agents in Microsoft 365: [Role-based agents for Microsoft 365.](https://www.microsoft.com/microsoft-365/copilot/copilot-for-work#role-based-extensions)

- *Access Azure AI resources.* Azure PaaS and IaaS solutions require an Azure account. These services include Azure AI Studio, Azure Machine Learning, and Azure AI services, which include Azure OpenAI, and Azure Virtual Machines.

## Create an AI proof of concept

A proof of concept (PoC) is a valuable planning tool for AI adoption. It’s technically optional, but it’s a valuable step for anyone new to AI. It provides a concrete evaluation of your AI maturity level and helps you set realistic expectations around delivery timelines. All Microsoft AI platforms have Quickstart articles for PoCs that align with common use cases. Use the table to find the right Quickstart article.

| AI Type  | Quickstart links |
|----------|--------------|
| Generative AI | [Azure AI Studio](/azure/ai-studio/quickstarts/get-started-playground), [Azure OpenAI](/azure/ai-services/openai/assistants-quickstart), [Copilot Studio](/microsoft-copilot-studio/fundamentals-get-started)   |
| Machine learning | [Azure Machine Learning](/azure/machine-learning/tutorial-azure-ml-in-a-day?)         |
| Analytical AI | Azure AI Services: [Content Safety](/azure/ai-services/content-safety/quickstart-jailbreak), [Custom Vision](/azure/ai-services/custom-vision-service/getting-started-build-a-classifier), [Document Intelligence](/azure/ai-services/document-intelligence/quickstarts/try-document-intelligence-studio), [Face](/azure/ai-services/computer-vision/quickstarts-sdk/identity-client-library), \*[AI Language](/azure/ai-services/language-service/overview#available-features), [Speech](/azure/ai-services/speech-service/overview#get-started), \*[Translator](/azure/ai-services/translator/translator-overview#translator-features-and-development-options), [AI Vision](/azure/ai-services/computer-vision/overview#get-started) <br> \**Each feature of this AI service has its own Quickstart guide*|

- *Prioritize AI use cases.* Prioritize use cases that allow you to learn quickly and work toward your overall business impact. Focus on strategic areas like facilitating sales teams, customer-facing applications, and time-intensive processes.

- *Select the right opportunity.* PoCs should align with your current AI maturity level and your prioritized AI opportunities. Within those filters, prefer projects that provide the most value, balancing the opportunity priority, time, and money it takes to see results. Prefer internal use cases for minimized testing risk. Refine PoC and convert to a pilot. Conduct AB testing to create a baseline of what works and what doesn't for your organization.

- *Document learnings*. As you test, you should have a good collection of data leading them to the best strategy for their organization (rule-out pathway). Don't let a PoC make it to production. Reevaluate the skills needed and data readiness. proof-of-concept exercise should determine whether you have the necessary skills and resources to develop AI solutions internally.

- *Reprioritize AI opportunities*. Based on your PoC experience, reevaluate which AI opportunity you want to implement first.

## Plan for responsible AI adoption

Understanding the requirements of Responsible AI helps when setting delivery timelines. To plan for responsible AI, follow these recommendations:

- *Use responsible AI planning tools.* If you’re new to AI, rely on the planning tools available to align development with responsible AI principles. Microsoft has resource to align AI adoption to Responsible AI principles. For more information, see [AI Impact Assessment template](https://www.microsoft.com/ai/tools-practices) , [Human-AI experience toolkit](https://www.microsoft.com/research/project/hax-toolkit/), and [Responsible AI Maturity Model](https://www.microsoft.com/research/publication/responsible-ai-maturity-model/). Plan to review your AI workloads throughout development and regularly after deployment. The frequency of the review depends on your use case and AI use.

- *Plan for AI governance.* Factor in the effort to assess AI risks, develop AI governance policies, and controls needed to eliminate all instances of unauthorized AI use. Set up processes to manage data access, usage, and compliance with regulations. These processes are unique to your organization, data, and AI opportunities. Create clear data ownership policies and ensuring data lineage is traceable. For more information, see [Govern AI](govern.md).

- *Plan for AI security.* Plan to apply secure configurations to Azure resources and models so that you pass any IT security standards. Azure has security baselines for each service. Familiarize yourself with common AI security threats, such as model poisoning, data tampering, and adversarial attacks. Any data fed into AI models should respect the same security, privacy, and sensitivity boundaries as any other technology. For more information, see [Secure AI](secure.md).

- *Plan for AI management.* Consider how you should manage AI systems throughout their lifecycle, from updates to monitoring and resilience. Think about how to handle regular tasks, like deploying updates and maintaining infrastructure, tailored to AI environments. For more information, see [Manage AI](manage.md).

## Plan for AI centralization and endpoint sharing

AI centralization means there’s a single team that manages AI resources and endpoint deployments. The decision to centralize AI models is primarily a governance issue. Centralization allows you to use a single process to deploy, govern, and manage AI endpoints for all AI workloads, rather than allow application teams to control these resources individually. Cost allocation for chargeback and showback and performance are other considerations centralization. If you had an AI CoE, they would determine whose responsibility it's to manage centralized AI resources.

### Start with a centralized model

Centralizing AI deployments under one team gives you greater control over governance. Begin with a centralized approach *(see figure 1*)*,* and as your governance processes mature, you can move to a more decentralized model if needed. If quota becomes a limitation, you can deploy the AI model in another region or request an increased quota.

:::image type="content" source="./images/centralized-ai.svg" alt-text="Diagram showing Centralized AI resources approach. It shows two intelligent applications connected to a centralized AI resources virtual network. A single team can deploy, govern, and retire AI model endpoints for intelligent applications." lightbox="./images/centralized-ai.svg" border="false":::
*Figure 1. Centralized AI resources approach. It shows two intelligent applications connected to a centralized AI resources virtual network. A single team can deploy, govern, and retire AI model endpoints for intelligent applications.*

#### Know when to share AI endpoints with multiple applications

In a centralized model, you can share a single AI endpoint across multiple applications *(see figure 2*)*.

:::image type="content" source="./images/centralized-ai-sharing.svg" alt-text="Diagram showing Centralized AI resources approach. It shows two intelligent applications sharing a single AI endpoint." lightbox="./images/centralized-ai.svg" border="false":::
*Figure 2. Centralized AI resources approach. It shows two intelligent applications sharing a single AI endpoint.*

- *Production use cases to share a single AI endpoint.* Sharing an AI endpoint works best when the same application team develops, deploys, and manages multiple applications that share the same governance and model needs. For sharing nonglobal, regional deployments, a generative AI gateway is best practice. With some configuration in APIM, you can monitor tokens and track costs across applications.

- *Share AI endpoints in nonproduction environments.* Sharing a single AI endpoint in nonproduction environments simplifies resource management without major concerns about performance or operational impact. You can even share a single AI endpoint across different nonproduction environments. Ultimately, there should be flexibility in to try different models before finalizing on the model to be chosen for the use case.

#### Don’t share AI endpoints when governance needs vary

Applications that require different content filter settings (governance on input and output) shouldn't share an endpoint. Don’t share a single AI endpoint if a different AI model would provide a more cost-effective way to meet application requirements.

:::image type="content" source="./images/centralized-ai-no-share.svg" alt-text="Diagram showing Centralized AI resources approach. It shows two intelligent applications with their own AI endpoint." lightbox="./images/centralized-ai-no-share.svg" border="false":::
*Figure 3. Centralized AI resources approach. It shows two intelligent applications with their own AI endpoint.*

### Decentralize AI endpoints for critical applications

Use a decentralized model when isolation, security, and cost tracking are priorities. Decentralization allows teams to manage AI models aligned with their applications. It provides dedicated AI resources to the application where performance or criticality demands it. Gradual decentralization is key. Start with strong governance to manage risks and maintain visibility. As governance matures, teams can be given more autonomy over their AI endpoints.

:::image type="content" source="./images/decentralized-ai.svg" alt-text="Diagram showing Dedicated AI resources per application. It shows two workloads in two separate subscriptions with their own AI resources so they can deploy, govern, and retire their own AI model endpoints." lightbox="./images/decentralized-ai.svg" border="false":::
*Figure 4. Dedicated AI resources per application. It shows two workloads in two separate subscriptions with their own AI resources so they can deploy, govern, and retire their own AI model endpoints.*

## Estimate delivery timelines

Based on your proof-of-concept, assign a delivery timeline to your AI opportunities. Microsoft AI SaaS solutions have the shortest timelines to see a return on investment. Timelines for building AI apps on Azure PaaS and IaaS solutions depend on your use case and AI maturity. Most efforts take weeks to months to have a production-ready AI application.

## Next step

The rest of the guidance focuses on building AI workloads in Azure using PaaS and IaaS solutions. To be successful in Azure, first establish your AI foundation.

> [!div class="nextstepaction"]
> [AI Ready](ready.md)

To adopt a Microsoft Copilot solution, use these links to find more information:

- [Microsoft Copilot for Microsoft 365](/copilot/microsoft-365/microsoft-365-copilot-overview)
- [Microsoft Copilot Studio](/microsoft-copilot-studio/requirements-licensing-subscriptions)

- Role-based agents in Microsoft 365:
    - [Microsoft 365 Copilot for Security](/copilot/security/microsoft-security-copilot)
    - [Microsoft 365 Copilot for Sales](/microsoft-sales-copilot/introduction)
    - [Microsoft 365 Copilot for Service](/microsoft-copilot-service/about-microsoft-copilot-for-service)
    - [Microsoft 365 Copilot for Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance)

- In-product Copilots:
    - [GitHub](https://azure.microsoft.com//products/github/copilot)
    - [Power Apps](https://www.microsoft.com/power-platform/products/power-apps)
    - [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=&country=us)
    - [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai)
    - [Power Automate](https://www.microsoft.com/power-platform/products/power-automate)
    - [Azure](https://azure.microsoft.com/products/copilot/)

Browser-based Copilots:
- [Microsoft Copilot (free)](https://copilot.microsoft.com/)
- [Microsoft Copilot Pro](https://www.microsoft.com/store/b/copilotpro)