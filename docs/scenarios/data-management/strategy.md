---
title: Integrate data management and analytics into your cloud adoption strategy
description: Understand how to integrate data management and analytics into your cloud adoption strategy.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/22/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Integrate data management and analytics into your cloud adoption strategy

A best practice for customers is to create a single, centralized cloud adoption strategy by using the [Strategy methodology in the Cloud Adoption Framework for Azure](../../strategy/index.md). If you haven't already, use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) to record your cloud adoption strategy.

This article exposes considerations about data management and analytics that will affect your broader strategy.

Before implementing the data management and analytics scenario, you should have a plan in place for your data strategy. You can start small with a single use-case or you might have a much set of large use-cases which will require prioritization. A strategy can help you establish your processes and start off the initial conversations, within the business, on the pillars you need to concentrate on.

## Prioritize business outcomes for your data strategy

It's key to align your data strategy with your business outcomes. Having a successful data strategy will give you a competitive advantage. Most business outcomes can be classified under one or more of these four categories:

- **Empower your employees**: Consider enabling your workforce with real-time knowledge of customers, devices, and machines. This knowledge will help them efficiently collaborate to meet customer or business needs with agility.

- **Engage with customers**: Deliver a personalized, rich, connected experience that's inspired through your brand. Drive loyalty along every step of the customer journey by harnessing the power of data and insights.

- **Optimize operations**: Increase the flow of information across your entire business operation. Keep your business processes synchronized, and make every interaction valuable through a data-driven approach.

- **Transform your products and development life cycle**: Gather telemetry data about your services and offerings. Use the data to prioritize a release or create a new feature, and evaluate effectiveness and adoption continuously.

After you've prioritized your business outcomes, look at your current projects and long-term strategic initiatives, and classify them accordingly. Consider combining the four business outcomes in a matrix format, based on complexity and impact. Also, think about adding the architectural pillars to help you dive deeper into the scenario.

## Unlock strategic value

There are inherent complexities and ground realities in building a data-driven culture to drive business forward in a consistent, forward-thinking, agile, and informed way. Before you move to the deployment phase, you should focus efforts toward formulating a coherent data strategy to achieve desired business outcomes.

Data management and analytics are aligned to [innovation-focused motivations](../../strategy/motivations.md). Customers who integrate this scenario into their cloud adoption strategy are motivated by the following common drivers:

- A scalable analytics framework designed to enable building an enterprise data platform
- Self-service to empower users in data exploration, data asset creation, and product development
- Fostering a data-led culture with reusable data assets, data communities, secure third-party exchange, and in-place sharing
- Sharing data with confidence by using policies, common identity, confidentiality, and encryption
- Improved customer experiences and engagements
- Transformation of products or services
- Market disruption with new products or services

The following key themes outline how you can realize these motivations in your strategy. Carefully analyze them and think about how they relate to a coherent data strategy. Also think about how they can unlock the strategic value of data for consistent business growth.

![Diagram that shows the key themes of increasing efficiencies, data democratization, and governance.](./images/key-themes.png)

*"A data strategy is the foundation to using data as an asset and driving business forward. It's not a patch job for data problems. It's a long-term, guiding plan that defines the people, processes, and technology to put in place to solve data challenges."*

Creating a strategy is one thing. Executing a strategy at enterprise-scale poses a great challenge to an organization's existing culture, people, processes, and technology choices. It requires commitment and clear ownership at all levels of an organization.

### Increasing efficiencies

The agility of the cloud has imposed the need for organizations to adapt quickly and bring efficiencies to all areas of business. According to the [report by Gartner on emerging risks](https://www.gartner.com/en/newsroom/press-releases/2018-10-24-gartner-survey-shows-digitalization-misconceptions-threaten-organizations-as-the-top-emerging-risk-in-3q19), although organizations continue to focus on digital initiatives and invest in them, two-thirds fail to deliver upon expectations and demonstrate enterprise weaknesses.

## Operationalize data management

In many organizations Central IT has slowly, become more decentralized to enable agility. Businesses want to innovate quickly by having access to enterprise-wide unified data in self-serve fashion to meet challenging business requirements.

There are many reasons why businesses fail to tap into the full potential of their data. It might be because business functions work in silos, where each team uses different tools and standards for data analysis. Or it might be a failure to link key performance indicators to overall business goals.

Data democratization helps deliver that value back to business and achieve challenging targets for business growth.

- Understand and prioritize your LOBs needs'.
- Distribute data across domains to enable ownership and bring data to closer to users.
- Deploy self-service data products to drive insights and business value.

With data governance, there has to be the right balance in the decentralized world of a data democratization approach. If governance is enforced too hard, it can stifle innovation. However, not having some core principles and processes in place might create data silos. These silos can result in damaging an organization's reputation and potential revenues. That's why a holistic data governance approach is fundamental to unlocking strategic value of data in a consistent way.

In the absence of a well-thought-out data strategy, there's a clear need to just "get going" and quickly start demonstrating value back to the business. In this pursuit, acting on the preceding key themes or using them as strategic principles wrapped in a framework can address current business problems. It can also help the formation of a holistic data strategy, in an iterative way with validation, and still yield timely results.

Business and technology leaders need to develop the mindset and strategies required to generate value from data and scale quickly in a simplified, structured way.

For more information, see [What is data governance?](./govern.md).

## Develop a data-driven culture

To build a successful data strategy, you need a data-driven culture. Develop one that fosters open, collaborative participation consistently. The entire workforce can then learn, communicate, and improve the organization's business outcomes. Developing a data-driven culture will also improve each employee's ability to generate impact or influence, backed by data.

Where you start on the journey will depend on your organization, your industry, and where you are in the maturity curve.  Here, is an example of a created maturity model measuring the maturity of the AI usage in an organization:

:::image type="content" source="./images/data-strategy-maturity.png" alt-text="Diagram of an organization's maturity evolving." lightbox="./images/data-strategy-maturity.png":::

### Level 0

Data is not exploited programmatically and consistently. The data focus within the company is from an application development perspective.

On this level, an organization often has unplanned analytics projects. Additionally, each application is highly specialized to the unique data and stakeholder needs. Each application has significant code bases and engineering teams, with many being engineered outside IT. Finally, use case enablement and analytics are siloed.

### Level 1

Here, teams are being formed and strategy is being created, but analytics still is departmentalized. At this level, organizations tend to be good at traditional data capture and analytics. They might have a level of commitment to cloud-based approaches. For example, they might already be accessing data from the cloud.

### Level 2

The innovation platform is almost ready, with workflows in place to deal with data quality. The organization can answer a few "why" questions.

At this level, organizations are actively looking for an end-to-end data strategy with centrally governed data lake stores controlling data store sprawl and improving data discoverability. They're ready for smart applications that bring compute to the centrally governed data lakes. These applications will reduce the need for federated copies of important data, reduce privacy risks, and reduce compute costs.

Organizations at this level are also ready for multitenant, centrally hosted, shared data services for common data computing tasks. These shared data services will enable the speed of insights from data-science-driven intelligence services.

### Level 3

A characteristic of this level is a holistic approach to data. Projects related to data are deeply integrated with business outcomes. The organization uses analytics platforms to make predictions.

At this level, organizations are unlocking digital innovation from the perspective of both data estate and application development. They have the foundational data services, including data lakes and shared data services, in place.

Multiple teams across the company are successfully delivering on critical business workloads, key business use cases, and measurable outcomes. Telemetry is being used to identify new shared data services. IT is a trusted advisor to teams across the company to help improve critical business processes through the end-to-end trusted and connected data strategy.

### Level 4

Here, the entire company uses a data-driven culture, frameworks, and standards enterprise. Observers see automation, centers of excellence around analytics or automation, and data-driven feedback loops in action.

## Develop business-aligned objectives

Identifying priorities in line with the business vision and keeping a "think big, start small, and act fast" ideology are keys for success. Picking up the right use case doesn't always need to be a long-haul, difficult vetting process. It could be an ongoing problem in any business unit where there's enough data to validate its return on investment, more appetite, and easy buy-in. Things can move quickly, and that's where most of the organization can be struggling to get started.

## Understand the attributes of data

To build a strong data strategy, you first need to understand how data works. Understanding core characteristics of data will help you build a principled practice around how to deal with data.

Data travels fast, but the velocity of data movement can't defy the laws of physics. It must conform to the laws of the land or the industry that created it.

Data never changes by itself, but it's prone to changes and accidental loss, unless explicit measures are in place to mitigate such challenges. To deal with unforeseen changes, ensure that anti-corruption measures for controls, databases, and storage are in place. Also ensure that monitoring, audits, alerts, and downstream processes are in place to deal planned or unforeseen changes.

Data by itself, and simply the act of storing it, doesn't produce any insights or yield any value. To discover insights or extract value, most or all of the data, independent of the volume, velocity, variety, and veracity, has to go through four discrete steps:

1. Ingestion
1. Storage
1. Processing
1. Analytics

Each step has its own set of principles, processes, tools, and technologies.

Withholding data assets and related insights might affect socioeconomic, political, research, and investment decisions. That's why it's paramount for organizations to build the capability to provide insights in a secure and responsible way. All data that's generated or acquired must go through a data classification exercise, unless otherwise explicitly stated. Where needed, the gold standard for dealing with confidential data is encryption at rest and in transit.

Data, applications, and services all have their own gravitational pull. But data is the heaviest here, and so it has the most gravitational pull. Unlike Newton's apple, data doesn't have a physical mass to draw in surrounding objects. Instead, latency and throughput act as accelerators to the analytics process. Latency, throughput, and ease of access often require duplication of data, even when that isn't the desired outcome. Set up people, processes, tools, and technologies appropriately to balance such requirements against the organization's data policies.

Architectural constructs govern the speed at which data can be processed. And they're facilitated through innovations in software, hardware, and networking. Some of the architectural considerations are:

- Setting up data distribution
- Partitioning
- Cache technologies
- Batch versus stream processing
- Balancing back-end versus client-side processing

## Define a data strategy

Using data to build better products and higher-value services as a point of competitive advantage is nothing new. What is new is the volume, velocity, and variety of data that cloud computing has enabled.

Designing a modern data analytics platform in the cloud is the convergence of security, governance, monitoring, on-demand scaling, data operations, and self-service. Understanding how these facets interplay distinguishes a great data strategy from a good one. You can use tools like the Cloud Adoption Framework to help ensure architectural cohesiveness, integrity, and best practices.

With data governance as the focus, the following diagram shows the main stages of a data life cycle:

![Diagram of a data life cycle.](./images/data-management-and-quality.png)

An effective data strategy must have provisions for data governance. They're mutually inclusive, but not the same thing.

Let's take a closer look at the considerations to make when you're building design principles for the layers in your data strategy. Focus on delivering business outcomes and value from data.

### Data ingestion

A key consideration for data ingestion is the ability to build a data pipeline fast, from requirements to production, in a secure and compliant manner. Important elements include metadata-driven, self-service, low-code technologies to hydrate your data lake.

When you're building a pipeline, consider design, along with the ability to wrangle data, scale compute, and distribute data. Also, having the right DevOps support for the continuous integration and delivery of your pipeline is critical.

Tools such as Azure Data Factory support a plethora of on-premises data sources, software as a service (SaaS) data sources, and data sources from other public clouds. Having such agility from the start is always helpful.

### Storage

Tag and organize data in physical and logical layers. Data lakes are part of all modern data analytics architectures. Organizations must apply appropriate data privacy, security, and compliance requirements based on data classification and the industry compliance requirements that they operate in. The other key considerations are cataloging and self-service to aid organization-level data democratization to fuel innovation, guided by appropriate access control.

Choose the right storage based on the workload. Even if you don't get it right the first time, the cloud gives you options to fail over quickly and to restart the journey. You can choose the right database based on your application requirements. When you're choosing an analytics platform, be sure to consider the ability to process batch and streaming data.

### Data processing

Your data processing needs will vary according to the workload. For example, most big data processing has elements of both real-time and batch processing. Most enterprises also have elements of time series processing requirements and the need to process free-form text for enterprise search capabilities.

The most popular organizational processing requirements come from online transaction processing (OLTP). Certain workloads need specialized processing, such as high-performance computing (HPC), also called "big compute." These workloads use many CPU or GPU-based computers to solve complex mathematical tasks.

For certain specialized workloads, customers can secure execution environments like Azure confidential computing, which helps users secure data while it's in use on public cloud platforms. This state is required for efficient processing. The data is protected inside a trusted execution environment (TEE), also known as an enclave. This environment protects the code and data against viewing and modification from outside the TEE. It creates the ability to train AI models by using data sources from different organizations without sacrificing data confidentiality.

### Analytical processing

The extract, transform, load (ETL) construct relates to online analytical processing (OLAP) and data warehousing needs. One of the useful capabilities is the ability to automatically detect schema drift.

### Data strategy summary

Taking a principled approach on other (but relevant) considerations, such as data governance and responsible AI, will pay dividends later.

At Microsoft, we use four core principles: fairness, reliability and safety, privacy and security, and inclusiveness. Underpinning these principles are two foundational principles of transparency and accountability.

We put responsible AI and our principles into practice through the development of resources and a system of governance. Some of our guidelines focus on human/AI interaction, conversational AI, inclusive design, an AI fairness checklist, and a data sheet for datasets.

In addition to practices, we've developed a set of tools to help others understand, protect, and control AI at every stage of innovation. Our tools are a result of collaboration across various disciplines to strengthen and accelerate responsible AI. That collaboration has spanned software engineering and development, social sciences, user research, law, and policy.

To further collaboration, we open-sourced many tools, such as InterpretML and Fairlearn. Others can contribute to and build upon these tools. We also democratized tools through Azure Machine Learning.

The pivot to becoming a data-driven organization is fundamental to deliver competitive advantage in the new normal. We want to help our customers' shift from an application-only approach to an application and data-led approach. An approach that focuses on applications and data can help create an end-to-end data strategy that ensures repeatability and scalability across current and future use cases that affect business outcomes.

![Diagram of unlocking digital innovation.](./images/data-strategy-innovation.png)

## Foster commitment, communication, and engagement

There must be clear understanding around the adopted approach and common business objectives among all key roles involved in making your data strategy a success. The key roles might include the leadership team (C-level), business units, IT, operations, and delivery teams.

Communication is one of the most important elements of this framework. An organization must devise a process for effective communication across roles. Communication helps deliver effectively in the context of the current project. It also establishes a forum to stay in line, up to date, and focused on the overall objective of formulating a holistic data strategy for the future.

Engagement is essential between these two groups:

- Team members who design and implement the data strategy
- Team members who contribute to, consume, and exploit the data, such as the business units that will make decisions and build outcomes based upon the data

Put another way, data strategies and associated data platforms that are built without engagement of the users of such platforms risk challenges in relevance and adoption.

Two strategic processes will help to deliver successfully in the context of this framework:

- Formation of a center of excellence
- Adoption of an agile delivery method

For more information, see [Develop a plan for data management and analytics](./plan.md).

## Deliver value

When you deliver data products against the success criteria in a standardized and structured way, that delivery will validate the iterative framework. Additionally, when you take the learning and continuously innovate, that will help build business confidence and widen the goals of a data strategy. This process will provide clearer and quicker adoption across the business.

## Next steps

The following articles can guide your cloud adoption journey and help your cloud adoption scenario to succeed:

- [Develop a plan for data management and analytics](./plan.md)
- [Review your environment for Azure landing zones](./ready.md)
- [Govern data management and analytics](./govern.md)
- [Secure data management and analytics](./secure.md)
