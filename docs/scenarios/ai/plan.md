---
title: AI Plan - Recommendations for developing an AI adoption plan
description: View a comprehensive guide on AI adoption planning, skill acquisition, resource access, PoC creation, and responsible AI practices for organizations.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Plan - Recommendations for developing an AI adoption plan

This article provides recommendations for planning AI adoption. Strategy provides an end goal to your AI adoption. During this stage, you get more tactical about preparing your organization to adopt AI. During planning, you need to ensure that you have the right skills and planning for AI deployment. When you deploy AI, you need to consider responsible AI practices and your approach to deploying and consuming AI endpoints across your applications.  

## Evaluate your AI maturity level

As with any technology, there's a learning curve to adopting AI. Evaluating your AI maturity level can help you prioritize AI opportunities. AI projects that are too advanced for your experience don't provide the return on investment you need. If you plan to build generative AI applications, start with this generative AI technical assessment. At a high level, here are the readiness factors you need to consider:

| AI maturity level | Feasible AI projects | Skills required | Data readiness |
|-------------------|----------------------|-----------------|----------------|
| Level 1       | - Microsoft Learn quickstart <br> - Copilot Studio app | - Basic understanding of AI concepts <br> - Ability to integrate data sources and map out prompts | - Minimal to zero data available <br> - Enterprise data available |
| Level 2       | - Any of the previous projects <br> - Custom analytical AI application that uses Azure AI services <br> - Custom generative AI chat app without Retrieval Augmented Generation (RAG) in Azure AI Studio  <br> - Custom machine learning app with automated model training <br> - Fine-tuning a generative AI model | - Experience with AI model selection <br> - Familiarity with AI deployment and endpoint management <br> - Experience with data cleaning and processing | - Minimal to zero data available <br> - Small, structured dataset <br> - Small amount of domain-specific data available |
| Level 3       | - Any of the previous projects <br> - Generative AI app with RAG in Azure AI Studio (or Azure Machine Learning) <br> - Training and deploying a machine learning model in Machine Learning <br> - Training and running a small AI model on Azure Virtual Machines | - Proficiency in prompt engineering <br> - Proficiency in AI model selection, data chunking, and query processing <br> - Proficiency in data preprocessing, cleaning, splitting, and validating <br> - Grounding data for indexing | - Large amounts of historical business data available for machine learning <br> - Small amount of domain-specific data available |
| Level 4    | - Any of the previous projects <br> - Training and running a large generative or nongenerative AI app on Virtual Machines, Azure Kubernetes Service, or Azure Container Apps | - Advanced AI / machine learning expertise, including infrastructure management <br> - Proficiency in handling complex AI model training workflows <br> - Experience with orchestration, model benchmarking, and performance optimization <br> - Strong skills in securing and managing AI endpoints | - Large amounts of data available for training |

## Acquire AI skills

Assess your organization's current AI skill set to identify gaps and determine whether to develop internally or hire external talent. A combination of approaches is often needed, balancing in-house development with outsourcing, based on broader organizational strategy. For strategic projects, focus on building in-house expertise for long-term success. In areas that require quick value, external partnerships can fill immediate gaps while internal capabilities are developed. This combination ensures efficiency in the short term and strategic skill growth for long-term competitiveness.

- *Learn AI skills.* The [Microsoft Learn](/) platform provides free AI skills [training](/training/), [certifications](/credentials/), and [product-specific guidance](/docs/) for all Microsoft and Azure AI services. Set certification goals, such as earning certifications related to Azure AI. These certifications include [Azure AI Fundamentals](/credentials/certifications/azure-ai-fundamentals/), [Azure AI Engineer Associate](/credentials/certifications/azure-ai-engineer/), and [Azure Data Scientist Associate](/credentials/certifications/azure-data-scientist/) . There are learning resources for other subjects on the platform, so filter the results to return AI-specific results.

- *Recruit AI professionals.* For expertise that you can't develop internally within your time frame, recruit professionals. These professionals should have experience in AI model development, generative AI operations, or AI ethics.

    - *Form partnerships with educational institutions.* Collaborate with universities and training centers to find fresh talent with the latest AI skills and insights.
    - *Regularly update job descriptions.* Ensure that job roles and requirements reflect the rapidly evolving AI landscape. Doing so helps you attract candidates with the most relevant skills.
    - *Create an attractive employer brand.* Showcase your organization's commitment to innovation and technological advancement to make your brand appealing to AI professionals.
    - *Offer competitive compensation packages.* Provide AI professionals with attractive salary structures and benefits to attract and retain top-tier talent in the field.

- *Use Microsoft partners to acquire AI skills.* Use a Microsoft partner to address skill shortages. Build more complex solutions or increase personnel count to meet time constraints. Use the [Microsoft partners marketplace](https://partner.microsoft.com//partnership/find-a-partner) to find partners who have expertise in AI, data, and Azure across multiple industries.

## Access to AI resources

This section provides a quick way to help you understand and access what you need to start using AI solutions.

- *Access Microsoft copilots.* Microsoft software as a service (SaaS) copilots require a license or an add-on subscription, except for [the free version](https://copilot.microsoft.com/).

    - [Copilot for Microsoft 365](https://www.microsoft.com//microsoft-365/microsoft-copilot#plans) requires a Microsoft 365 business or enterprise license to which you add on the Copilot license.
    - [Copilot Studio](/microsoft-copilot-studio/requirements-licensing-subscriptions) uses a standalone license or an add-on license.
    - In-product Copilots. See [GitHub](https://azure.microsoft.com//products/github/copilot), [Power Apps](https://www.microsoft.com//power-platform/products/power-apps), [Power BI](https://www.microsoft.com//power-platform/products/power-bi?culture=&country=us), [Dynamics 365](https://www.microsoft.com//dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com//power-platform/products/power-automate), and [Azure](https://azure.microsoft.com//products/copilot/).
    - Role-based agents in Microsoft 365. [See the product page](https://www.microsoft.com/microsoft-365/copilot/copilot-for-work#role-based-extensions).

- *Access Azure AI resources.* Azure PaaS and IaaS solutions require an Azure account. These services include Azure AI Studio, Azure Machine Learning, and Azure AI services, which include Azure OpenAI Service and Azure Virtual Machines.

## Create an AI proof of concept

A proof of concept (PoC) is a valuable planning tool for AI adoption. This step is optional, but it's a valuable step for anyone who's new to AI. It provides a concrete evaluation of your AI maturity level and helps you set realistic expectations around delivery timelines. For all Microsoft AI platforms, quickstart articles that provide PoCs that align with common use cases are available. Use the following table to find the right quickstart article.

| AI type  | Quickstart link |
|----------|--------------|
| Generative AI | [Azure AI Studio](/azure/ai-studio/quickstarts/get-started-playground), [Azure OpenAI](/azure/ai-services/openai/assistants-quickstart), [Copilot Studio](/microsoft-copilot-studio/fundamentals-get-started)   |
| Machine learning | [Azure Machine Learning](/azure/machine-learning/tutorial-azure-ml-in-a-day?)         |
| Analytical AI | Azure AI services: [Azure AI Content Safety](/azure/ai-services/content-safety/quickstart-jailbreak), [Azure AI Custom Vision](/azure/ai-services/custom-vision-service/getting-started-build-a-classifier), [Document Intelligence Studio](/azure/ai-services/document-intelligence/quickstarts/try-document-intelligence-studio), [Face service](/azure/ai-services/computer-vision/quickstarts-sdk/identity-client-library), \*[Azure AI Language](/azure/ai-services/language-service/overview#available-features), [Azure AI Speech](/azure/ai-services/speech-service/overview#get-started), \*[Azure AI Translator](/azure/ai-services/translator/translator-overview#translator-features-and-development-options), [Azure AI Vision](/azure/ai-services/computer-vision/overview#get-started). <br> \**Each feature of this AI service has its own quickstart guide.*|

- *Prioritize AI use cases.* Prioritize use cases that allow you to learn quickly and that have the most business impact. Focus on strategic areas like facilitating sales teams, customer-facing applications, and time-intensive processes. Balance short-term projects that can demonstrate immediate value with long-term strategic initiatives. Consider the required investment in terms of time, budget, and personnel. 

- *Select the right opportunity.* PoCs should align with your current AI maturity level and your prioritized AI opportunities. Within those PoCs, prioritize projects that provide the most value, balancing the opportunity priority and the time and cost that it takes to see results. Prefer internal use cases to minimize testing risk. Refine the PoC and then convert to a pilot. Conduct AB testing to create a baseline of what works and what doesn't work.

- *Document learnings*. As you test, you should have a good collection of data leading to the best strategy for your organization (a rule-out pathway). Don't let a PoC make it to production. Reevaluate the skills needed and data readiness. The PoC should help you determine whether you have the necessary skills and resources to develop AI solutions internally.

- *Reprioritize AI opportunities*. Based on your PoC experience, reevaluate which AI opportunity you want to implement first.

## Plan for responsible AI adoption

When you set delivery timelines, it helps to understand the requirements of responsible AI. To plan for responsible AI, follow these recommendations:

- *Use responsible-AI planning tools.* If you're new to AI, rely on the available planning tools to align development with responsible AI principles. Microsoft has resources to align AI adoption to responsible AI principles. For more information, see the [AI impact assessment template](https://www.microsoft.com/ai/tools-practices), the [Human-AI eXperience Toolkit](https://www.microsoft.com/research/project/hax-toolkit/), and the [Responsible AI Maturity Model](https://www.microsoft.com/research/publication/responsible-ai-maturity-model/). Plan to review your AI workloads throughout development and regularly after deployment. The frequency of the review depends on your use case and AI use.

- *Plan for AI governance.* Factor in the effort for assessing AI risks, developing AI governance policies, and setting the controls needed to eliminate all instances of unauthorized AI use. Set up processes to manage data access, data usage, and compliance with regulations. These processes are unique to your organization, data, and AI opportunities. Create clear data ownership policies and ensure that data lineage is traceable. For more information, see [Govern AI](govern.md).

- *Plan for AI security.* Plan to apply secure configurations to Azure resources and models so that you pass IT security standards. Azure provides security baselines for each service. Familiarize yourself with common AI security threats, such as model poisoning, data tampering, and adversarial attacks. Any data fed into AI models should respect the same security, privacy, and sensitivity boundaries as any other data or technology. For more information, see [Secure AI](secure.md).

- *Plan AI management.* Consider how you should manage AI systems throughout their lifecycles, from updates to monitoring and resilience. Think about how to handle regular tasks, like deploying updates and maintaining infrastructure. Tailor these plans to AI environments. For more information, see [Manage AI](manage.md).

## Plan for AI centralization and endpoint sharing

When AI is centralized, there's a single team that manages AI resources and endpoint deployments. The centralization of AI models is primarily a governance issue. Centralization allows you to use a single process to deploy, govern, and manage AI endpoints for all AI workloads rather than allowing application teams to control these resources individually. Centralization also affects performance and cost allocation for chargeback and showback. If you have an AI Center of Excellence, this group determines whose responsibility it is to manage centralized AI resources.

- *Start with a centralized model.* Centralizing AI deployments under one team gives you more control over governance. Begin with a centralized approach. As your governance processes mature, you can move to a more decentralized model if you need to. If quota becomes a limitation, you can deploy the AI model in another region or request an increased quota.

   The following diagram shows a centralized AI resources approach. It shows two intelligent applications that are connected to a centralized AI resources virtual network. A single team can deploy, govern, and retire AI model endpoints for intelligent applications.
  
   :::image type="content" source="./images/centralized-ai.svg" alt-text="Diagram that shows a centralized AI resources approach. It shows two intelligent applications connected to a centralized AI resources virtual network." lightbox="./images/centralized-ai.svg" border="false":::

- *Know when to share AI endpoints.* In a centralized model, you can share a single AI endpoint across multiple applications, as shown in the following diagram. Sharing an AI endpoint in production works best when the same application team develops, deploys, and manages multiple applications that share the same governance and model needs. For sharing nonglobal, regional deployments, a generative AI gateway is a best practice. With some configuration in Azure API Management, you can monitor tokens and track costs across applications. Sharing a single AI endpoint in nonproduction environments simplifies resource management without creating major concerns about performance or operational impact. You can even share a single AI endpoint across different nonproduction environments. Ultimately, you should be flexible and try different models before you choose one.

    :::image type="content" source="./images/centralized-ai-sharing.svg" alt-text="Diagram that shows a centralized AI resources approach. It shows two intelligent applications that share a single AI endpoint." lightbox="./images/centralized-ai-sharing.svg" border="false":::

- *Don't share AI endpoints when governance needs vary.* Applications that require different content filter settings (governance on input and output) shouldn't share an endpoint. Don't share a single AI endpoint if a different AI model would provide a more cost-effective way to meet application requirements.
The following diagram shows two intelligent applications, each with its own AI endpoint.

    :::image type="content" source="./images/centralized-ai-no-share.svg" alt-text="Diagram that shows a centralized AI resources approach. It shows two intelligent applications, each with its own AI endpoint." lightbox="./images/centralized-ai-no-share.svg" border="false":::

- *Decentralize AI endpoints for critical applications.* Use a decentralized model when isolation, security, and cost tracking are priorities. Decentralization allows teams to manage AI models that are aligned with their applications. It provides dedicated AI resources to the application when performance or criticality demands it. Gradual decentralization is key. Start with strong governance to manage risks and maintain visibility. As governance matures, teams can be given more autonomy over their AI endpoints.

  The following diagram shows a model in which AI resources are dedicated to each application. It shows two workloads in two separate subscriptions with their own AI resources so they can deploy, govern, and retire their own AI model endpoints.

  :::image type="content" source="./images/decentralized-ai.svg" alt-text="Diagram that shows dedicated AI resources for each application." lightbox="./images/decentralized-ai.svg" border="false":::

## Estimate delivery timelines

Based on your PoC, assign a delivery timeline for your AI opportunities. Create a timeline with clear milestones and deliverables for implementing selected use cases. Assign teams, define roles, and secure necessary tools or partnerships.  

Microsoft AI SaaS solutions provide the shortest timelines for seeing a return on investment. Timelines for building AI apps on Azure PaaS and IaaS solutions depend on your use case and AI maturity. In most cases, it takes weeks or months before you have a production-ready AI application. 

## Next step

The rest of this guidance focuses on building AI workloads in Azure by using PaaS and IaaS solutions. To be successful in Azure, you must first establish your AI foundation.

> [!div class="nextstepaction"]
> [AI Ready](ready.md)

For more information about adopting a Microsoft Copilot solution, see these resources:

- [Copilot for Microsoft 365](/copilot/microsoft-365/microsoft-365-copilot-overview)
- [Copilot Studio](/microsoft-copilot-studio/requirements-licensing-subscriptions)
- Role-based agents in Microsoft 365:
    - [Microsoft 365 Copilot for Security](/copilot/security/microsoft-security-copilot)
    - [Microsoft 365 Copilot for Sales](/microsoft-sales-copilot/introduction)
    - [Microsoft 365 Copilot for Service](/microsoft-copilot-service/about-microsoft-copilot-for-service)
    - [Microsoft 365 Copilot for Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance)
- In-product copilots:
    - [GitHub](https://azure.microsoft.com//products/github/copilot)
    - [Power Apps](https://www.microsoft.com/power-platform/products/power-apps)
    - [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=&country=us)
    - [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai)
    - [Power Automate](https://www.microsoft.com/power-platform/products/power-automate)
    - [Azure](https://azure.microsoft.com/products/copilot/)
    
Browser-based copilots:
- [Copilot (free)](https://copilot.microsoft.com/)
- [Copilot Pro](https://www.microsoft.com/store/b/copilotpro)
