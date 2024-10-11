---
title: AI Plan - Recommendations for developing an AI adoption plan
description: View a comprehensive guide on AI adoption planning, skill acquisition, resource access, PoC creation, and responsible AI practices for organizations.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Plan - Recommendations for developing an AI adoption plan

An AI adoption plan outlines the necessary steps for an organization to incorporate AI into its operations. This guidance is essential because a structured approach enables organizations to align AI initiatives with business goals, ensuring that resources, skills, and technology align effectively for successful deployment.

## Evaluate AI maturity

Organizations can evaluate AI maturity to understand their current capabilities and readiness to implement AI. This step matters because it allows organizations to choose AI projects that match their skill level and available data, increasing the chances of achieving a positive return on investment while reducing the risk of overreaching.

| AI maturity level | Feasible AI projects | Skills required | Data readiness |
|-------------------|----------------------|-----------------|----------------|
| Level 1       | ▪ Microsoft Learn quickstart <br> ▪ Copilot Studio app | ▪ Basic understanding of AI concepts <br> ▪ Ability to integrate data sources and map out prompts | ▪ Minimal to zero data available <br> ▪ Enterprise data available |
| Level 2       | ▪ Any of the previous projects <br> ▪ Custom analytical AI application that uses Azure AI services <br> ▪ Custom generative AI chat app without Retrieval Augmented Generation (RAG) in Azure AI Studio  <br> ▪ Custom machine learning app with automated model training <br> ▪ Fine-tuning a generative AI model | ▪ Experience with AI model selection <br> ▪ Familiarity with AI deployment and endpoint management <br> ▪ Experience with data cleaning and processing | ▪ Minimal to zero data available <br> ▪ Small, structured dataset <br> ▪ Small amount of domain▪specific data available |
| Level 3       | ▪ Any of the previous projects <br> ▪ Generative AI app with RAG in Azure AI Studio (or Azure Machine Learning) <br> ▪ Training and deploying a machine learning model in Machine Learning <br> ▪ Training and running a small AI model on Azure Virtual Machines | ▪ Proficiency in prompt engineering <br> ▪ Proficiency in AI model selection, data chunking, and query processing <br> ▪ Proficiency in data preprocessing, cleaning, splitting, and validating <br> ▪ Grounding data for indexing | ▪ Large amounts of historical business data available for machine learning <br> ▪ Small amount of domain▪specific data available |
| Level 4    | ▪ Any of the previous projects <br> ▪ Training and running a large generative or nongenerative AI app on Virtual Machines, Azure Kubernetes Service, or Azure Container Apps | ▪ Advanced AI / machine learning expertise, including infrastructure management <br> ▪ Proficiency in handling complex AI model training workflows <br> ▪ Experience with orchestration, model benchmarking, and performance optimization <br> ▪ Strong skills in securing and managing AI endpoints | ▪ Large amounts of data available for training |

For more information, see [Technical Assessment for Generative AI in Azure](https://learn.microsoft.com/assessments/443670b4-11d1-4dd7-8128-b2bdb7a2bf2f/).

## Acquire AI skills

Teams need to acquire the right AI skills by assessing the existing talent and deciding whether to develop skills internally or hire external experts. This process is important because a capable team supports sustained AI adoption, enabling organizations to respond quickly to new challenges and maintain competitive relevance through continuous learning.

- *Learn AI skills.* The [Microsoft Learn](/) platform provides free AI skills [training](/training/), [certifications](/credentials/), and [product-specific guidance](/docs/) for all Microsoft and Azure AI services. Set certification goals, such as earning certifications related to Azure AI. These certifications include [Azure AI Fundamentals](/credentials/certifications/azure-ai-fundamentals/), [Azure AI Engineer Associate](/credentials/certifications/azure-ai-engineer/), and [Azure Data Scientist Associate](/credentials/certifications/azure-data-scientist/) . There are learning resources for other subjects on the platform, so filter the results to return AI-specific results.

- *Recruit AI professionals.* For expertise that you can't develop internally within your time frame, recruit professionals. These professionals should have experience in AI model development, generative AI operations, or AI ethics.

    - *Form partnerships with educational institutions.* Collaborate with universities and training centers to find fresh talent with the latest AI skills and insights.
    - *Regularly update job descriptions.* Ensure that job roles and requirements reflect the rapidly evolving AI landscape. Doing so helps you attract candidates with the most relevant skills.
    - *Create an attractive employer brand.* Showcase your organization's commitment to innovation and technological advancement to make your brand appealing to AI professionals.
    - *Offer competitive compensation packages.* Provide AI professionals with attractive salary structures and benefits to attract and retain top-tier talent in the field.

- *Use Microsoft partners to acquire AI skills.* Use a Microsoft partner to address skill shortages. Build more complex solutions or increase personnel count to meet time constraints. Use the [Microsoft partners marketplace](https://partner.microsoft.com//partnership/find-a-partner) to find partners who have expertise in AI, data, and Azure across multiple industries.

## Access AI resources

Organizations must access AI resources by identifying and using tools, platforms, and software necessary for AI deployment. This step is important because it provides a quick way to understand what is needed to begin using AI solutions, helping organizations avoid delays due to resource constraints.

- *Access Microsoft copilots.* Most Microsoft SaaS Copilots require a license or an add-on subscription.

    - [Microsoft 365 Copilot](https://www.microsoft.com//microsoft-365/microsoft-copilot#plans) requires a Microsoft 365 business or enterprise license to which you add on the Copilot license.
    - [Copilot Studio](/microsoft-copilot-studio/requirements-licensing-subscriptions) uses a standalone license or an add-on license.
    - In-product Copilots have different access requirements for each, but access to the primary product is required. For more information on each, see [GitHub](https://azure.microsoft.com//products/github/copilot), [Power Apps](https://www.microsoft.com//power-platform/products/power-apps), [Power BI](https://www.microsoft.com//power-platform/products/power-bi), [Dynamics 365](https://www.microsoft.com//dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com//power-platform/products/power-automate), and [Azure](https://azure.microsoft.com//products/copilot/).
    - Role-based Copilots also have their own access requirements. For more information, see [Role-based agents for Microsoft 365 Copilot](https://www.microsoft.com/microsoft-365/copilot/copilot-for-work#role-based-agents) and [Microsoft Copilot for Security](https://www.microsoft.com/security/business/ai-machine-learning/microsoft-copilot-security).

- *Access Azure AI resources.* Azure PaaS and IaaS solutions require an Azure account. These services include Azure OpenAI Service, Azure AI Studio, Azure Machine Learning, Azure AI services, and Azure Virtual Machines.

## Create an AI proof of concept

An AI proof of concept (PoC) demonstrates the potential of AI projects on a small scale before full deployment. This process is important because it allows organizations to test feasibility, gather insights, and refine AI use cases, ensuring that they commit to projects that align with their capabilities and business objectives.

| AI type  | Quickstart link |
|----------|--------------|
| Generative AI | [Azure AI Studio](/azure/ai-studio/quickstarts/get-started-playground), [Azure OpenAI](/azure/ai-services/openai/assistants-quickstart), [Copilot Studio](/microsoft-copilot-studio/fundamentals-get-started)   |
| Machine learning | [Azure Machine Learning](/azure/machine-learning/tutorial-azure-ml-in-a-day?)         |
| Analytical AI | Azure AI services: [Azure AI Content Safety](/azure/ai-services/content-safety/quickstart-jailbreak), [Azure AI Custom Vision](/azure/ai-services/custom-vision-service/getting-started-build-a-classifier), [Document Intelligence Studio](/azure/ai-services/document-intelligence/quickstarts/try-document-intelligence-studio), [Face service](/azure/ai-services/computer-vision/quickstarts-sdk/identity-client-library), \*[Azure AI Language](/azure/ai-services/language-service/overview#available-features), [Azure AI Speech](/azure/ai-services/speech-service/overview#get-started), \*[Azure AI Translator](/azure/ai-services/translator/translator-overview#translator-features-and-development-options), [Azure AI Vision](/azure/ai-services/computer-vision/overview#get-started). <br> \**Each feature of this AI service has its own quickstart guide.*|

- *Prioritize AI use cases.* Prioritize use cases that allow you to learn quickly and that have the most business impact. Focus on strategic areas like facilitating sales teams, customer-facing applications, and time-intensive processes. Balance short-term projects that can demonstrate immediate value with long-term strategic initiatives. Consider the required investment in terms of time, budget, and personnel. Prefer workloads with a narrow scope to build faster and minimize risk.

- *Select the right opportunity.* PoCs should align with your current AI maturity level and your prioritized AI opportunities. Within those PoCs, prioritize projects that provide the most value, balancing the opportunity priority and the time and cost that it takes to see results. Prefer internal use cases to minimize testing risk. Refine the PoC and then convert to a pilot. Conduct AB testing to create a baseline of what works and what doesn't work.

- *Document learnings*. As you test, you should have a good collection of data leading to the best strategy for your organization (a rule-out pathway). Don't let a PoC make it to production. Reevaluate the skills needed and data readiness. The PoC should help you determine whether you have the necessary skills and resources to develop AI solutions internally.

- *Reprioritize AI opportunities*. Based on your PoC experience, reevaluate which AI opportunity you want to implement first.

## Plan for responsible AI

Organizations should plan for responsible AI by implementing practices that promote ethical, secure, and reliable AI use. This approach is crucial because it ensures that AI applications align with organizational values and regulatory requirements, protecting users, minimizing risks, and building trust in AI systems.

- *Use responsible-AI planning tools.* Microsoft has resources to align AI adoption to responsible AI principles. For more information, see the [AI impact assessment template](https://www.microsoft.com/ai/tools-practices), the [Human-AI eXperience Toolkit](https://www.microsoft.com/research/project/hax-toolkit/), and the [Responsible AI Maturity Model](https://www.microsoft.com/research/publication/responsible-ai-maturity-model/). Plan to review your AI workloads throughout development and regularly after deployment. The frequency of the review depends on your use case and AI use.

- *Plan AI security.* Plan to assess security risks specific to AI workloads. Based on those risks, you must implement security controls and maintain them over time. Review [Secure AI](secure.md) before deployment.

- *Plan AI governance.* Plan to govern AI workloads using automated and manual enforcement. Review [Govern AI](govern.md) before deployment.

- *Plan AI management.* Plan to determine who's responsible for deploying and configuring AI resource to meet governance and security standards. Develop a plan for AI endpoint sharing and how to measure AI workloads throughout their lifecycle. Review [Manage AI](manage.md) before deployment.

## Estimate delivery timelines

Teams need to estimate delivery timelines by planning realistic schedules and milestones for AI project implementation. Clear timelines help organizations allocate resources effectively, manage expectations, and ensure that AI initiatives progress efficiently from proof of concept to full deployment.

Based on your PoC, assign a delivery timeline for your AI opportunities. Create a timeline with clear milestones and deliverables for implementing selected use cases. Assign teams, define roles, and secure necessary tools or partnerships. Microsoft AI SaaS solutions provide the shortest timelines for seeing a return on investment. Timelines for building AI apps on Azure PaaS and IaaS solutions depend on your use case and AI maturity. In most cases, it takes weeks or months before you have a production-ready AI application.

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
