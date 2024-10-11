---
title: AI Strategy - Recommendations to develop an AI adoption strategy
description: Get recommendations for developing an AI adoption strategy. Identify use cases and define strategies for data, technologies, and Responsible AI. 
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# AI Strategy - Recommendations to develop an AI adoption strategy

An AI strategy helps you define your vision and goals for AI adoption. This strategy allows you to identify areas where AI can add value, choose the right solutions, and measure progress. A well-planned AI strategy aligns with your business objectives, ensuring that AI projects contribute to overall success. To oversee the AI adoption process, establish an [AI center of excellence](./center-of-excellence.md) (AI CoE) or appoint someone to set goals to measure progress.

## Define an AI technology strategy

Defining an AI technology strategy involves identifying use cases and solutions that align with your goals. This strategy ensures that your AI initiatives address your business needs and maximize value.

### Identify AI use cases

Identifying AI use cases involves listing tasks and processes where AI might add value. This approach lets you explore your current needs and prioritize AI initiatives that align with your strategic goals.

- *Understand AI.* AI supports two goals: enhancing individual efficiency and improving business processes. Generative AI fosters productivity and enhances customer experiences. Non-generative AI, such as machine learning, is ideal for analyzing structured data and automating repetitive tasks.

- *Analyze business processes for automation opportunities.* Identifying processes that are suitable for automation can greatly enhance efficiency and reduce operational costs. Examine your workflows to find repetitive tasks, data-heavy operations, or areas with high error rates where AI can make a significant impact.

- *Conduct an assessment.* Gather input from various departments to understand challenges and inefficiencies that could be addressed by using AI. Document current workflows to identify areas where AI can automate tasks or provide insights.

- *Align AI initiatives with strategic goals.* Aligning AI projects with your strategic objectives ensures that efforts contribute to overall business success. Map out how AI can enhance productivity or streamline processes, and prioritize use cases that directly support your company's mission and goals.

- *Explore industry use cases.* Research how other businesses use AI to gain insights. Stay informed about emerging AI technologies and applications that are relevant to your industry.

For more information, see [Example AI use cases](strategy.md#example-ai-use-cases).

### Identify AI solutions

An AI technology strategy involves selecting the right tools and platforms for each AI use case. You need to choose between Software as a Service (SaaS), Platform as a Service (PaaS), or Infrastructure as a Service (IaaS) based on your goals and technical needs. This strategy helps you align technology choices with specific objectives, ensuring a scalable and cost-effective AI implementation.

For each use case, identify an AI technology to support it. Microsoft provides software (SaaS), platform (PaaS), and infrastructure (IaaS) services that you can use to adopt AI. Each service model affects the [AI shared responsibility](/azure/security/fundamentals/shared-responsibility-ai) between you and Microsoft. Use the following decision tree to narrow the options for each AI opportunity. After you identify a service, review the skills and data needed to be successful. Also understand the cost factors to avoid surprises later.

:::image type="content" source="./images/ai-decision-tree.svg" alt-text="Diagram that shows Microsoft and Azure services and decision points that indicate each service." border="false":::

#### Buy AI software services (Saas)

Microsoft provides a range of Copilot generative AI services to enhance individual efficiency. These Copilots allow you to buy software as a service (SaaS) to provide AI capabilities across your business or to specific individuals. Adopting SaaS products requires very few skills.

Microsoft 365 Copilot uses enterprise data in Microsoft Graph. [Categorize your data](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot#step-1-deploy-or-validate-your-data-protection) with sensitivity labels. Role-based Copilots have different data connection and plug-in options in ingest data. Most in-product Copilots don’t require additional data preparation. Check the documentation for each service for more information. For Copilot Studio, [connect data](/microsoft-copilot-studio/knowledge-copilot-studio) from across your enterprise and external public websites. Copilot Studio automates much of the data processing needed to create custom copilots for various business applications.

| Microsoft Copilots | Description | User | Skills | Data | Cost |
|--------|--------|-------| --- | --- | --- |
| Microsoft 365 Copilot | Use [Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-overview) for an enterprise-wide solution that automates work in Microsoft 365 apps and provides an enhanced-security way to chat with business data in Microsoft Graph. | Business | General IT and data management | Yes | [License](https://www.microsoft.com/microsoft-365/microsoft-copilot#plans) |
| Role-based Copilots | Use [Microsoft Copilot for Security](/copilot/security/microsoft-security-copilot) and role-based agents for Microsoft 365 like [Microsoft 365 Copilot for Sales](https://www.microsoft.com/microsoft-365/copilot/copilot-for-sales), [Microsoft 365 Copilot for Service](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-service), and [Microsoft 365 Copilot for Finance](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-for-finance), to enhance productivity for specific business roles. | Business | General IT and data management | Yes | Licenses or [Security Compute Units (Copilot for Security)](https://www.microsoft.com/security/business/ai-machine-learning/microsoft-copilot-security#pricing) |
| In-product Copilots | Use copilots to enhance productivity within Microsoft products, such as [GitHub](https://azure.microsoft.com/products/github/copilot), [Power Apps](https://www.microsoft.com/power-platform/products/power-apps), [Power BI](https://www.microsoft.com/power-platform/products/power-bi?culture=en-us&country=us), [Dynamics 365](https://www.microsoft.com/dynamics-365/solutions/ai), [Power Automate](https://www.microsoft.com/power-platform/products/power-automate), and [Azure](https://azure.microsoft.com/products/copilot/). | Business and individual | None | Yes | Free or subscription |
| Copilot Free or Pro | Use the [free](https://copilot.microsoft.com/) version for browser-based access to GPT models. Use [Copilot Pro](https://www.microsoft.com/store/b/copilotpro) for better performance and more capacity. | Individual | None | No | None for Free or [subscription for Pro](https://www.microsoft.com/store/b/copilotpro?msockid=1e787d5f5c8d61da16f469995d146045) |

#### Build AI workloads with AI platform (PaaS)

Microsoft offers a range of platform-as-a-service (PaaS) solutions for building AI workloads. Your AI goals determine the solution, skills, and data needed for deployment. Azure provides platforms suited to different skill levels, from beginner-friendly options to advanced tools for experienced developers and data scientists. Choose a platform that aligns with both your current needs and future goals. To estimate costs, use the relevant [pricing pages](https://azure.microsoft.com/products/) and the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator).

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|  ----|-------------| ---------| ---- |
| Build RAG applications with low-code platform | [Copilot Studio](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) | Yes | Using a low-code platform to connect data sources, mapping out prompts, and deploying copilots to various locations | [License](https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio#Pricing) |
| Build RAG applications with code-first platform | [Azure AI Studio](/azure/ai-studio/what-is-ai-studio) or [Azure OpenAI](/azure/ai-services/openai/overview) | Yes | Selecting models, orchestrating dataflow, chunking data, enriching chunks, choosing indexing, understanding query types (full-text, vector, hybrid), understanding filters and facets, performing reranking, engineering prompt flow, deploying endpoints, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Fine-tune generative AI models | [Azure AI Studio](/azure/ai-studio/what-is-ai-studio) | Yes | Preprocessing data, splitting data into training and validation data, validating models, configuring additional parameters, improving models, deploying models, and consuming endpoints in apps | Compute, number of tokens in and out, AI services consumed, storage, and data transfer |
| Train and inference machine learning models by using your own data | [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning) or [Microsoft Fabric](/fabric/get-started/microsoft-fabric-overview) | Yes | Preprocessing data, training models by using code or automation, improving models, deploying machine learning models, and consuming endpoints in apps | Compute, storage, and data transfer |
| Consume analytical AI models in applications | [Azure AI services](/azure/ai-services/what-are-ai-services) | Yes | Picking the right AI model, securing endpoints, consuming endpoints in apps, and fine-tuning as needed | Use of model endpoints consumed, storage, data transfer, compute (if you train custom models) |

#### Bring your own models with infrastructure services (IaaS)

For advanced AI needs, Azure Virtual Machines provide access to GPUs and CPUs, enabling you to bring your own AI models to Azure using virtual machine (VM) images. Although Azure PaaS solutions are generally the preferred pathway for AI adoption, consider IaaS if you need more control and customization. Refer to the relevant [pricing pages](https://azure.microsoft.com/products/) and the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator).

| AI goal | Microsoft solution | Data needed | Skills required | Main cost factors |
| --------------|  ----|-------------| ---------| ---- |
| Train and inference your own AI models. Bring your own models to Azure. | [Azure Virtual Machines](/azure/virtual-machines/overview) | Yes | Infrastructure management, IT, program installation, model training, model benchmarking, orchestration, deploying endpoints, securing endpoints, and consuming endpoints in apps | Compute, compute node orchestration, managed disks, storage transactions, public IPs, and other Azure services used |

### Define an AI data strategy

An AI data strategy outlines data collection, storage, and usage practices that meet regulatory, ethical, and operational standards. This strategy promotes reliable AI outputs and ensures data security and privacy.

- *Protect data security and privacy.* Establish robust security measures, including encryption, access controls, and anonymization, to safeguard sensitive data in AI processes. Define access controls to protect data from unauthorized use and breaches. Don't let data boundaries blur when data is fed into AI systems. For example, AI workloads for all employees should only use data that's appropriate for all employees. Internet-facing AI workloads must only use data that's appropriate for public use.

- *Manage the data lifecycle.* Define how data will be collected, stored, processed, and retired. Ensure compliance with data retention and disposal policies, and use version control to maintain accuracy across model updates and data changes.

- *Define acceptable use.* Provide limits on how individuals and systems interact with AI. Read the data security and privacy policies for individual products to define what data should be shared. Some services, like Azure OpenAI, allow you to elevate privacy levels above the platform default.

- *Monitor and evaluate continuously.* Set up ongoing monitoring of AI models and data pipelines to ensure data quality, performance, and fairness over time. Regularly audit data and model outputs to identify any shifts that could affect reliability or compliance.

## Define a responsible AI strategy

A responsible AI strategy guides you in building AI systems that are ethical, fair, and transparent. It governs your business processses This strategy involves monitoring AI systems to prevent bias, ensuring data transparency, and fostering accountability. By adopting responsible AI practices, you can build trust with customers and stakeholders, promoting a positive AI impact.

Microsoft follows six [responsible AI](https://www.microsoft.com/ai/responsible-ai#advancing-aI-policy) principles when developing AI systems. These principles govern the process of building AI workloads that are beneficial to all end users. You need to define or adopt similar principles to guide your process of managing AI workloads. Microsoft has [tools and processes](https://www.microsoft.com/ai/tools-practices#tabs-pill-bar-oc8dad_tab1) to help you map, measure, and manage the AI workloads in accordance with responsible AI principles.

- *Ensure regulatory compliance.* Regulatory requirements dictate how you adopt, build, and manage AI workloads. Ensure you know the regulatory requirements for AI workloads in every country you operate.

- *Set up data governance and accountability.* Create a governance framework to assign responsibility for managing data quality, enforcing ethical AI practices, and ensuring proper data usage. Implement auditing processes to maintain accountability throughout AI data handling.

- *Mitigate data biases.* Identify potential biases in datasets and apply strategies to reduce them. Regularly assess fairness, address imbalances, and ensure that AI outputs are unbiased toward any group or demographic.

- *Ensure data transparency.* Enable stakeholders to understand how data is collected, used, and processed in AI systems. Provide clear traceability of data inputs and AI decisions to foster trust and accountability.

## Next step

> [!div class="nextstepaction"]
> [Create a plan to adopt AI](plan.md)

## Example AI use cases

Example AI use cases show how AI can solve specific problems and improve processes within your business. These examples cover a range of applications, from automating tasks to analyzing data for better decision-making. By reviewing AI use cases, you can gain insights into potential AI applications relevant to your industry.

| **Generative AI**| **Non-generative AI** |
| --- | ---|
| Marketing: Automatically create social media posts and email newsletters. | Prediction: Forecast trends or optimize operations based on historical data. |
| E-commerce platforms: Generate personalized product recommendations and tailored shopping experiences. | Process automation: Automate routine tasks and workflows that don't require content generation, such as customer service bots. |
| Product design: Quickly create multiple variations of product prototypes or design elements. | Data analysis: Uncover patterns in structured data for insights and data-driven decisions. |
| Software development: Automate repetitive code generation, such as CRUD operations. | Model simulation: Simulate complex systems (fluid dynamics, finite element analysis) to predict behavior and optimize designs or processes. |
| Educational platforms: Generate personalized quizzes and study materials for students. | Anomaly detection: Identify unusual patterns in data. You can use this strategy for fraud detection or equipment failure prediction, for example. |
| Customer service: Provide context-based responses through AI-driven chatbots. | Recommendation: Offer personalized recommendations based on user behavior, commonly used in e-commerce and streaming services. |
| Advertising agencies: Create targeted ad variations for different audience segments. | Optimization: Improve efficiency by solving complex problems (supply chain optimization, resource allocation). |
| Health and wellness apps: Generate customized workout routines and meal plans. | Sentiment analysis: Analyze text from social media or customer reviews to gauge public sentiment and enhance the customer experience. |

## Example AI adoption strategy

An AI adoption strategy provides a roadmap for integrating AI into your operations. It includes setting goals, identifying AI opportunities, and defining success metrics. By using an AI adoption strategy, you can systematically approach AI integration, ensuring it aligns with your mission and delivers measurable benefits. The example is based on a fictional company, Contoso, that has a customer-facing e-commerce application and employs sales representatives who need to forecast business data. The company develops a product and needs to manage inventory for production. Its sales channels include private companies and highly regulated public sector agencies. These agencies require a separate, custom e-commerce app to meet regulations. Here's the company's AI adoption strategy:

| Goals| Objectives| Opportunities | Success metrics| AI approach | Microsoft solution| Data needs| Skill needs| Cost factors |
| -------------| ----------| ------|  ----| ---------------| -------| -----| ------------------| -----|
| Automate business process | Improve customer satisfaction | E-commerce web application chat feature| Increased customer retention rate| PaaS, generative AI, RAG | Azure AI Studio| Item descriptions and pairings | RAG and cloud app development | Usage |
| Automate business process | Reduce costs | Internal app document-processing workflow| Increased completion rate| Analytical AI, fine-tuning | Azure AI services - Document Intelligence| Standard documents| App development | Estimated usage |
| Automate business process | Reduce costs | Inventory management application and product purchasing | Shorter shelf life of inventory| Machine learning, training models| Azure Machine Learning | Historical inventory and sales data| Machine learning and app development | Estimated usage |
| Enhance individual productivity | Improve employee experience | Daily work across company | Increased employee satisfaction survey results | SaaS generative AI| The free version of Copilot and Microsoft 365 Copilot| OneDrive data| General IT| Subscription costs|
| Automate business process | Increase sales| E-commerce application for regulated industry chat feature | Increased sales| IaaS generative AI model training | Azure Virtual Machines | Vast training data on domain-specific data | Cloud infrastructure, app development, VM maintenance, networking | Infrastructure and software |
