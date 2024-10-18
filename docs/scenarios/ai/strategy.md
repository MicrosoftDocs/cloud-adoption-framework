---
title: AI Strategy - Recommendations for organizations developing an AI adoption strategy
description: Learn the process to develop a strategy for AI adoption with best practices and recommendations.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Strategy - Recommendations for organizations developing an AI adoption strategy

An AI strategy outlines the organizational process for developing an AI adoption strategy. It helps you identify where AI can add value, select the right solutions, and measure progress. A well-planned AI strategy aligns with your business objectives and ensures that AI projects contribute to overall success. Create an [AI center of excellence](./center-of-excellence.md) (AI CoE), or appoint an AI lead to oversee your AI adoption.

:::image type="content" source="./images/aistrategy.svg" alt-text="Diagram showing the AI adoption framework process. It highlights AI Strategy. The process with AI Strategy, AI Plan, AI Ready as sequential steps. Then Secure AI, Govern AI, and Manage AI are cyclical processes after AI Ready. Undergirding the entire process is Responsible AI." lightbox="./images/aistrategy.svg" border="false":::

## Identify AI use cases

AI supports two main goals: enhancing individual efficiency and improving business processes. Generative AI fosters productivity and enhances customer experiences, while nongenerative AI, such as machine learning, is ideal for analyzing structured data and automating repetitive tasks. With this understanding, identify areas across your business where AI could add value.

- *Look for automation opportunities.* Identify processes suitable for automation to improve efficiency and reduce operational costs. Focus on repetitive tasks, data-heavy operations, or areas with high error rates where AI can have a significant effect.

- *Conduct an assessment.* Gather input from various departments to identify challenges and inefficiencies that AI could address. Document current workflows to find areas where AI can automate tasks or provide insights.

- *Align AI initiatives with strategic goals.* Align AI projects with your strategic objectives to ensure that efforts contribute to overall success. Map out how AI can enhance productivity or streamline processes, and prioritize use cases that support your company’s mission and goals.

- *Explore industry use cases.* Research how other businesses use AI for insights. Stay informed about emerging AI technologies and applications relevant to your industry.

- *Set success metrics.* For each use case, define a success metric to guide your AI adoption. A clear objective shapes the technology you adopt and focuses your efforts.

For more information, see [example AI use cases](#example-ai-use-cases) and [example AI adoption strategy](#example-ai-adoption-strategy).

## Define an AI technology strategy

An AI technology strategy involves selecting the right tools and platforms for each AI use case. Choose between software as a service (SaaS), platform as a service (PaaS), or infrastructure as a service (IaaS) based on your goals and technical needs. Each service model impacts the [AI shared responsibility](/azure/security/fundamentals/shared-responsibility-ai) between you and Microsoft. For each use case, identify a supporting AI technology.

Use the decision tree to narrow down options for each AI opportunity. While the adoption guidance focuses on Azure, it's important to understand the AI options available to your business. After selecting a service, review the skills and data needed to succeed, and consider cost factors to avoid surprises.

:::image type="content" source="./images/ai-decision-tree.svg" alt-text="Diagram that shows Microsoft and Azure services and decision points that indicate each service." border="false":::

### Buy AI software services (SaaS)

Microsoft offers various Copilot generative AI services that enhance individual efficiency. These Copilots allow you to purchase software as a service (SaaS) for AI capabilities across your business or for specific users. SaaS products generally require minimal technical skills.

In terms of data needs, *Microsoft 365 Copilot* uses enterprise data in Microsoft Graph. You can [Categorize your data](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot#step-1-deploy-or-validate-your-data-protection) with sensitivity labels. *Role-based Copilots* have different data connection and plug-in options in ingest data. Most *in-product Copilots* don’t require extra data preparation. *Copilot Studio* automates much of the data processing needed to create custom copilots for various business applications.

| Microsoft Copilots | Description | User | Skills | Data | Cost |
|--------|--------|-------| --- | --- | --- |
| Microsoft 365 Copilot | Use [Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-overview) for an enterprise-wide solution that automates work in Microsoft 365 apps and provides an enhanced-security way to chat with business data in Microsoft Graph. | Business | General IT and data management | Yes | [License](https://www.microsoft.com/microsoft-365/microsoft-copilot#plans) |
| Role-based Copilots | Use [Microsoft Copilot for Security](/copilot/security/microsoft-security-copilot) and role-based agents for Microsoft 365, such as [Microsoft 365 Copilot for Sales](https://www.microsoft.com/microsoft-365/copilot/copilot-for-sales), [Microsoft 365 Copilot for Service](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-service), and [Microsoft 365 Copilot for Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance), to enhance productivity for specific business roles. | Business | General IT and data management | Yes | Licenses or [Security Compute Units (Copilot for Security)](https://www.microsoft.com/security/business/ai-machine-learning/microsoft-copilot-security#pricing) |
| In-product Copilots | Use copilots to enhance productivity within Microsoft products, such as [GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](https://www.microsoft.com/power-platform/products/power-apps), [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=en-us&country=us), [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com/power-platform/products/power-automate), and [Azure](https://azure.microsoft.com/products/copilot/). | Business and individual | None | Yes | Free or subscription |
| Copilot Free or Pro | Use the [free](https://copilot.microsoft.com/) version for browser-based access to Azure OpenAI models. Use [Copilot Pro](https://www.microsoft.com/store/b/copilotpro) for better performance and more capacity. | Individual | None | No | None for Free or [subscription for Pro](https://www.microsoft.com/store/b/copilotpro?msockid=1e787d5f5c8d61da16f469995d146045) |

### Build AI workloads with AI platform (PaaS)

Microsoft provides various platform-as-a-service (PaaS) options for building AI workloads. The platform you choose depends on your AI goals, required skills, and data needs. Azure offers platforms suitable for different expertise levels, from beginner-friendly tools to advanced options for experienced developers and data scientists. Review the [pricing pages](https://azure.microsoft.com/products/) and use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) to estimate casts.

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|  ----|-------------| ---------| ---- |
| Build RAG applications with low-code platform | [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) | Yes | Using a low-code platform to connect data sources, mapping out prompts, and deploying copilots to various locations | [License](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio#Pricing) |
| Build RAG applications with code-first platform | [Azure AI Studio](/azure/ai-studio/what-is-ai-studio) or [Azure OpenAI](/azure/ai-services/openai/overview) | Yes | Selecting models, orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, engineering prompt flow, deploying endpoints, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Fine-tune generative AI models | [Azure AI Studio](/azure/ai-studio/what-is-ai-studio) | Yes | Preprocessing data, splitting data into training and validation data, validating models, configuring other parameters, improving models, deploying models, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Train and inference machine learning models by using your own data | [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) or [Microsoft Fabric](/fabric/get-started/microsoft-fabric-overview) | Yes | Preprocessing data, training models by using code or automation, improving models, deploying machine learning models, and consuming endpoints in apps | Compute, storage, and data transfer |
| Consume analytical AI models in applications | [Azure AI services](/azure/ai-services/what-are-ai-services) | Yes | Picking the right AI model, securing endpoints, consuming endpoints in apps, and fine-tuning as needed | Use of model endpoints consumed, storage, data transfer, compute (if you train custom models) |

### Bring your own models with infrastructure services (IaaS)

For organizations needing more control and customization, Microsoft offers infrastructure-as-a-service (IaaS) solutions. While Azure AI platforms (PaaS) are preferred for AI workloads, Azure Virtual Machines provides access to GPUs and CPUs for advanced AI needs. This setup allows you to bring your own models to Azure using virtual machine (VM) images. Refer to the relevant [pricing pages](https://azure.microsoft.com/products/) and the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator).

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|  ----|-------------| ---------| ---- |
| Train and inference your own AI models. Bring your own models to Azure. | [Azure Virtual Machines](/azure/virtual-machines/overview) | Yes | Infrastructure management, IT, program installation, model training, model benchmarking, orchestration, deploying endpoints, securing endpoints, and consuming endpoints in apps | Compute, compute node orchestration, managed disks, storage transactions, public IPs, and other Azure services used |

## Define an AI data strategy

An AI data strategy outlines data collection, storage, and usage practices that align with regulatory, ethical, and operational standards. This strategy ensures reliable AI outputs and promotes data security and privacy.

- *Protect data security and privacy*. Establish robust measures, such as encryption, access controls, and anonymization, to safeguard data. Define access controls to protect against unauthorized use. Limit data exposure to ensure that data used in AI processes matches its intended audience.

- *Manage the data lifecycle*. Define how you collect, store, process, and retire data. Adhere to data retention and disposal policies, and use version control to maintain data accuracy across updates.

- *Define acceptable use*. Set boundaries on how individuals and systems interact with AI. Review data security and privacy policies for specific products to understand data sharing limitations. Some services, like Azure OpenAI, offer elevated privacy levels.

- *Monitor and evaluate continuously*. Regularly audit data and model outputs to ensure data quality, performance, and fairness. Monitor AI models and data pipelines to identify any shifts that could affect reliability or compliance.

- *Ensure data governance*. Apply data governance principles to ensure that AI systems remain transparent, accountable, and in compliance with legal and ethical standards. This governance involves categorizing data based on sensitivity and implementing policies to control access, usage, and storage.

- *Plan for data scalability*. Anticipate the volume, velocity, and variety of data needed for AI workloads. Use flexible data architectures to scale with demand. Consider cloud-based infrastructures for efficient resource allocation and dynamic scaling capabilities.

- *Incorporate real-time data processing*. For AI systems requiring rapid decision-making, include provisions for streaming and real-time data processing. Ensure your architecture supports low-latency processing to maintain performance in high-demand environments.

- *Implement AI fairness and bias controls*. Set up processes to detect and mitigate bias in data. Use tools like Fairlearn to ensure that AI models provide fair and equitable outcomes, especially when handling sensitive data attributes.

- *Foster collaboration between AI and data teams*. Align AI development efforts with data engineering teams to ensure that AI models are built with high-quality, well-managed data. Establish a unified pipeline for AI model training and data updates.

- *Automate data management tasks*. Use AI and machine learning to automate repetitive data management tasks such as tagging, cataloging, and data quality checks. Automation improves accuracy and frees up resources for more strategic work.

For more information, see [Cloud scale analytics data strategy](/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/strategy#understand-data-attributes).

## Define a responsible AI strategy

A responsible AI strategy outlines your role in ensuring that AI solutions remain trustworthy and beneficial for all users. You and your AI provider, in this case Microsoft, share this responsibility. Your responsibilities vary depending on whether you use software as a service (SaaS), such as Microsoft Copilots, or an AI platform as a service (PaaS), like Azure AI Studio.

- *Establish AI accountability.* As AI technology and regulations advance, assign someone to monitor and govern these changes. It's typically a responsibility of the [AI CoE](./center-of-excellence.md) or an AI lead.

- *Align with established responsible AI principles.* Microsoft follows six [responsible AI](https://www.microsoft.com/ai/responsible-ai#advancing-aI-policy) principles that adhere to the [NIST Artificial Intelligence Risk Management Framework (AI RMF)](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.100-1.pdf). Use these principles as business goals to define success and govern your AI adoption.

- *Identify responsible AI tools.* Responsible AI tools ensure that your AI aligns with broader responsible AI practices. As part of your strategy, identify which Responsible AI [tools and processes](https://www.microsoft.com/ai/tools-practices#tabs-pill-bar-oc8dad_tab1) are relevant.

- *Understand legal and regulatory compliance requirements.* Legal and regulatory compliance influence how you build and manage AI workloads. Research and adhere to the requirements governing AI where you operate.

## Next step

> [!div class="nextstepaction"]
> [AI Plan](plan.md)

### Example AI use cases

Example AI use cases show how AI can solve specific problems and improve processes within your business. These examples cover a range of applications, from automating tasks to analyzing data for better decision-making. By reviewing AI use cases, you can gain insights into potential AI applications relevant to your industry.

| Generative AI| Nongenerative AI |
| --- | ---|
| Marketing: Automatically create social media posts and email newsletters. | Prediction: Forecast trends or optimize operations based on historical data. |
| E-commerce platforms: Generate personalized product recommendations and tailored shopping experiences. | Process automation: Automate routine tasks and workflows that don't require content generation, such as customer service bots. |
| Product design: Quickly create multiple variations of product prototypes or design elements. | Data analysis: Uncover patterns in structured data for insights and data-driven decisions. |
| Software development: Automate repetitive code generation, such as CRUD operations. | Model simulation: Simulate complex systems (fluid dynamics, finite element analysis) to predict behavior and optimize designs or processes. |
| Educational platforms: Generate personalized study materials for students. | Anomaly detection: Identify unusual patterns in data. You can use this strategy for fraud detection or equipment failure prediction, for example. |
| Customer service: Provide context-based responses through AI-driven chatbots. | Recommendation: Offer personalized recommendations based on user behavior, commonly used in e-commerce and streaming services. |
| Advertising agencies: Create targeted ad variations for different audience segments. | Optimization: Improve efficiency by solving complex problems (supply chain optimization, resource allocation). |
| Health and wellness apps: Generate customized workout routines and meal plans. | Sentiment analysis: Analyze text from social media or customer reviews to gauge public sentiment and enhance the customer experience. |

### Example AI adoption strategy

An AI adoption strategy provides a roadmap for integrating AI into your operations. It includes setting goals, identifying AI opportunities, and defining success metrics. By using an AI adoption strategy, you can systematically approach AI integration, ensuring it aligns with your mission and delivers measurable benefits. The example is based on a fictional company, Contoso, that has a customer-facing e-commerce application and employs sales representatives who need to forecast business data. The company develops a product and needs to manage inventory for production. Its sales channels include private companies and highly regulated public sector agencies. These agencies require a separate, custom e-commerce app to meet regulations. Here's the company's AI adoption strategy:

| Goals| Objectives| Opportunities | Success metrics| AI approach | Microsoft solution| Data needs| Skill needs| Cost factors |
| -------------| ----------| ------|  ----| ---------------| -------| -----| ------------------| -----|
| Automate business process | Improve customer satisfaction | E-commerce web application chat feature| Increased customer retention rate| PaaS, generative AI, RAG | Azure AI Studio| Item descriptions and pairings | RAG and cloud app development | Usage |
| Automate business process | Reduce costs | Internal app document-processing workflow| Increased completion rate| Analytical AI, fine-tuning | Azure AI services - Document Intelligence| Standard documents| App development | Estimated usage |
| Automate business process | Reduce costs | Inventory management application and product purchasing | Shorter shelf life of inventory| Machine learning, training models| Azure Machine Learning | Historical inventory and sales data| Machine learning and app development | Estimated usage |
| Enhance individual productivity | Improve employee experience | Daily work across company | Increased employee satisfaction survey results | SaaS generative AI| The free version of Copilot and Microsoft 365 Copilot| OneDrive data| General IT| Subscription costs|
| Automate business process | Increase sales| E-commerce application for regulated industry chat feature | Increased sales| IaaS generative AI model training | Azure Virtual Machines | Vast training data on domain-specific data | Cloud infrastructure, app development, VM maintenance, networking | Infrastructure and software |
