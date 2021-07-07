---
title: "Strategy for 'data management and analytics' adoption in Azure"
description: Integrate 'data management and analytics' into your cloud adoption strategy
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/22/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic impact of 'data management and analytics'

Best practice encourages customers to create a single centralized cloud adoption strategy, using the [Cloud Adoption Framework's Strategy methodology](../../strategy/index.md). If you haven't already, use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) to record your cloud adoption strategy.

This article will help expose a number of considerations regarding 'data management and analytics' that will have an impact on your broader strategy.

## 'data management and analytics' motivations

'data management and analytics' is generally aligned to [innovation focused motivations](../../strategy/motivations.md). Customers who integrate this scenario into their cloud adoption strategy are motivated by the following common drivers:

- A scalable analytics framework designed to enable building an enterprise data platform
- Self Service to empower the user in data exploration, data asset creation and product development
- Foster a data led culture with reusable data assets, data communities, secure third-party exchange and in-place sharing
- Share data with confidence secured by policies, common identity, confidentiality and encryption
- Improved customer experiences and engagements
- Transformation of products or services
- Market disruption with new products or services
- Democratization and/or self-service environments

Below are a number key themes outlining how these motivations can be realized within your strategy.

## Prioritize the business outcomes you want your data strategy to achieve

It is key to align your data strategy with your business outcomes. Having a successful data strategy will give you competitive advantage. In essence, most business outcomes can be classified under one or more of these four umbrella categories:

1. **Empower your employees**  
Consider enabling your workforce with real-time knowledge of customers/devices/machines, efficiently collaborating to meet customer or business needs with agility.
2. **Engage with customers**
Deliver a personalized, rich, connected experience, inspired through your brand. Drive loyalty along every step of the customer journey by harnessing the power of data and insights.
3. **Optimise operations**  
Increase the flow of information across your entire business operation. Keep your business processes synchronized and make every interaction valuable through a data driven approach.
4. **Transform your products and development lifecycle**
Gather telemetry data about your services and offerings. Use the data to prioritize a release or create a new feature, and evaluate effectiveness and adoption continuously.

Once you have prioritized your business outcomes, it is key to look at current projects, long-term strategic initiatives and classify them accordingly. Consider combining the 4 business outcomes in a matrix format shown below, based on complexity and impact. Also, think about adding the architectural pillars to help you dive deeper into the scenario.

## Unlocking Strategic Value

Throughout your BI, Analytics & AI maturity journey, there are *key themes* in unlocking the strategic value of data for consistent business growth. There are inherent complexities and ground realities in building a data-driven culture to drive business forward in a consistent, forward thinking, agile and informed way. Before moving to the deploy phase your should focus efforts towards formulating a coherent Data Strategy to achieve desired business outcomes.

## Key Themes

![Key Themes](images/key-themes.png)

If we carefully analyze the above key themes and how they relate to important facets of a coherent Data Strategy:

*"A **data strategy** is the foundation to leveraging **data** as an asset and driving business forward. It's not a patch job for **data** problems. It's a long-term, guiding plan that defines the people, processes, and technology to put in place to solve **data** challenges."*

Creating a strategy is one thing but to execute one on enterprise scale poses a great challenge to organization's existing culture, people, processes, and technology choices. It requires a great deal of commitment and clearer ownership at all levels of an organization.

### Increasing Efficiencies

The agility of the cloud more than ever before it has imposed the need for organizations to adapt quickly and brining efficiencies in all areas of business. According to the [report by Gartner on emerging risks](https://www.gartner.com/en/newsroom/press-releases/2018-10-24-gartner-survey-shows-digitalization-misconceptions-threaten-organizations-as-the-top-emerging-risk-in-3q19), while organizations continue to focus on digital initiatives and invest in them, two-thirds not only fail to deliver upon expectations, but also demonstrate enterprise weaknesses.

### Data Democratization

Central IT has slowly been shifting to shadow IT becoming more de-centralized and enabling agility. They want to innovate quickly by having access to enterprise-wide **unified** quality data in self-serve fashion, in order to meet challenging business requirements. There are many reasons why businesses fail to tap into the full potential of their data - business functions working in separate silos, each team using different tools & standards for data analysis, or a failure to link KPIs to overall business goals.

Data Democratization is the key to delivering that value back to business and achieving the challenging business growth targets.

### Governance

In relation to Data Governance there has to be a right balance in the decentralized world of data democratization approach. If governance is enforced too hard it can stifle innovation. However, not having some core principles and processes in place create data silos. This could result in damaging organizations reputation and potential revenues. Hence a holistic Data Governance approach is fundamental to unlocking strategic value of data in a consistent manner.

In the absence of a well thought-out Data Strategy, there is a clear need to just "get going" and quickly start demonstrating value back to business. In this pursuit, acting on the above key themes or using them as strategic principles wrapped in a framework could not only lead to addressing current business problems but even assist in the formation of future holistic data strategy in an iterative way with validation, yet yielding quick timely results.

This is discussed in more details under [What is data governance?](data-governance.md).

### Iterative Data Strategy Validation Framework

![Iterative Data Strategy Validation Framework](images/data-strategy-framework.png)

Business & Technology Leaders need to develop the mindset and strategies required to generate value from data and scale quickly in a simplified structured manner.

## Business Aligned Objectives

Identifying key priorities in line with business vision and keeping **"think big, start small, and act fast"** ideology is the fundamental key for success. Picking up the right use case(s) doesn't always need to be long haul difficult vetting process, it could be an on-going problem in any business unit where there is enough data to validate its return on investment, more appetite and easy buy-in. Things can move quickly and that's where most of the organization could be struggling to get started.

## Understand the 7 attributes of data for a strong data strategy

To build a strong data strategy, you first need to understand how data works. Understanding these core characteristics will help you build a principled practice around how to deal with data.

1. Data travels fast, but the velocity of data movement cannot defy the laws of physics. It must conform to the laws of the land or the industry that created it.
1. Data never changes by itself, but it is prone to changes and accidental loss, unless explicit measures are in place to mitigate such challenges. Ensure controls, databases and storage anti-corruption measures, monitoring, audits, alerts and downstream processes are in place to deal planned or unforeseen changes.
1. Data by itself, and simply though the act of storing it, does not produce any insights or yield any value. In order to discover insights or extract value, most (if not all) data, independent of the volume, velocity, variety and veracity, has to go through four discrete steps: ingestion, storage, processing, and analytics. These each have their own set of principles, processes, tools, and technologies. Withholding data assets and related insights may affect sociol-economic, political, research and investment decisions, hence it is of paramount importance for organizations to build the capability to provide insights in a secure and responsible manner.
1. All data generated or procured must go through a data classification exercise, unless otherwise explicitly stated. Where needed, the gold standard for dealing with confidential data is encryption at rest and in transit.
1. Data has gravity. This means that data, applications, and services all have their own gravitational pull. But data is the heaviest here, and therefore has the most gravitational pull. Unlike Newton's apple, data doesn't have a physical mass to draw in surrounding objects; instead, latency and throughput act as accelerators to the analytics process.
1. Latency, throughput, and ease of access often warrants that data is duplicated even when that is not the desired outcome. Set up people, processes, tools, and technologies appropriately to balance such requirements against organization's data polices.
1. The speed at which data can be processed is governed by architectural constructs, and facilitated through innovations in software, hardware, and networking. Some of the key architectural considerations are: setting up data distribution, partitioning, cache technologies, batch vs stream-processing, and balancing backend vs client-side processing.

## Defining a Data Strategy

Leveraging data to build better products and higher value services as a point of competitive advantage is nothing new. What is new is the volume, velocity, and variety of data that has been enabled by cloud computing. Designing a modern data analytics platform in the cloud is the convergence of security, governance, monitoring, on-demand scaling, data-ops, and self-service. What distinguishes a great data strategy from a good one is understanding how these facets interplay. We use tools like the Cloud Adoption Framework to ensure architectural cohesiveness, integrity, and best practices.

## A principled approach to your data strategy

With data governance in mind, the following diagram shows the essential stages for data lifecycle:

![data lifecycle](images/data-management-and-quality.png)

An effective data strategy must have provisions for data governance, but they are mutually inclusive, but not the same thing.

For the purpose of this article, let's take a closer look at the considerations to take when building design principles for the four layers that are key in your data strategy, focused towards delivering business outcome and value from data.

### Data ingestion

A key consideration for data ingestion is the ability to build a data pipeline extremely fast, from requirements to production, in a secure and compliant manner. Elements such as metadata driven, self-service, low-code technologies to hydrating your data lake are key. When building a pipeline, consider design, the ability to do data wrangling, scale compute and also data distribution capabilities. In addition, having the right DevOps support for the continuous integration and delivery of your pipeline is critical. Tools such as Azure Data Factory support a plethora of on-premises, Software as a Service and data sources from other public clouds. Having such agility from the get-go is always helpful.

### Storage

Data needs to be tagged and organized in physical and logical layers. Data lakes are key in all modern data analytics architectures. Organizations need to apply appropriate data privacy, security and compliance requirements based on data classification and the industry compliance requirements they operate in. The other key considerations are cataloguing and self-service to aid organization level data democratization to fuel innovation, guided by appreciate access control.

Choosing the right storage based on the workload is key, but even if you don't get it right the first time, the cloud provides you options to failover quickly and provide options to restart the journey reasonably easily. You can choose the right database based on your application requirements. When choosing an analytics platform, make sure you consider the ability to process batch and streaming data.

### Data processing

Your data processing needs will vary according to workload, for example most big data processing has elements of both real-time and batch processing. Most enterprises also have elements of time series processing requirements and the need to process free-form text for enterprise search capabilities.

The most popular organizational processing requirements come from Online Transaction Processing (OLTP). Certain workloads need specialized processing such as High Performance Computing (HPC), also called 'Big Compute'. These use many CPU or GPU-based computers to solve complex mathematical tasks.

For certain specialized workloads, customers can secure execution environments such as Azure confidential computing which helps users secure data while it's 'in use' on public cloud platforms (a state required for efficient processing). The data is protected inside a Trusted Execution Environment (TEE), also known as an enclave. This protects the code and data against viewing and modification from outside of the TEE.  This can provide the ability to train AI models using data sources from different organizations without sacrificing data confidentiality.

### Analytics

Extract, transform, load construct or otherwise called ETL (or ELT depending on where the transform happens) relates to online analytical processing (OLAP), and data warehousing needs. One of the useful capabilities here is the ability to automatically detect schema drift. Consider end-to-end architectures like automated enterprise BI with Azure Synapse Analytics and Azure Data Factory. To support advanced analytics including Machine Learning and AI capabilities, it is key to consider the reusability of platform technologies already in use for other processing requirements of similar nature. Here is a quick start guide with working example for end-to-end processing.

Batch processing on Databricks, R, Python or for deep learning models are common examples. Compute, storage, networking, orchestration and DevOps/MLOps are key considerations here. For super large models, look at distributed training of deep learning models on Azure or the Turning Project. You also need to consider the ability to deal with data and model drift too.

Azure Enterprise Scale Analytics and AI Construction Set helps collate all the four layers together with people, process, security, and compliance. We also suggest using the recommended architectures from Azure Landing Zones to get started. It uses the Microsoft Cloud Adoption Framework and culminates our experience working through thousands of large scale enterprise deployments.

Now that we have covered the four stages, the following representation shows the key capabilities needed on top of your data platform to provide end to end data governance capability.

## Building Blocks

After making all the capability provisions, and taking a principled architectural view as discussed in this section, you will most likely end up with the building blocks required for your cloud strategy journey which may look something like the below:

:::image type="content" source="./images/data-strategy-building-block.png" alt-text="Manage credentials decision tree" lightbox="./images/data-strategy-building-block.png":::

## Data Strategy Summary

Taking a principled approach on additional, but very relevant considerations, such as data governance and responsible AI will pay dividends later.

At Microsoft, we use four core principles of fairness, reliability and safety, privacy and security, and inclusiveness. Underpinning this is two foundational principles of transparency and accountability.

We put responsible AI and our principles into practice through the development of resources and a system of governance. Some of our guidelines focus on human-AI interaction, conversational AI, inclusive design, an AI fairness checklist, and a datasheet for datasets.

In addition to practices, we've developed a set of tools to help others understand, protect, and control AI at every stage of innovation. Our tools are a result of collaboration across various disciplines to strengthen and accelerate responsible AI, spanning software engineering and development, to social sciences, user research, law, and policy.

To further collaboration, we also open-sourced many tools such as Interpret ML and Fair Learn that others can use to contribute and build upon alongside democratising tools through Azure Machine Learning.

The pivot to becoming a data-driven organization is fundamental to deliver competitive advantage in the new normal. We want to help our customers shift from an application only approach to an application and data-led approach, helping to create an end-to-end Data Strategy that can ensure repeatability and scalability across current and future use cases that impact business outcomes.

![Unlocking Innovation](images/data-strategy-innovation.png)

## Commitment

There has to be clear understanding around the adopted approach and desired common business objectives among all the key roles involved in making this a success i.e. Leadership Team (C -- Level), Business Unit, IT, Ops etc.

## Communication & Engagement

Communication being one of the most important elements of this framework and requires communication process to be devised between Leadership, Business, IT & Delivery Teams. Communication assists in delivering effectively in the context of current project but establishing a forum to stay in line, up-to date and focused on the overall objective of formulating a Holistic Data Strategy for future.

Engagement is essential between those designing (and implementing) the data strategy and those contributing, consuming and exploiting the data - e.g. the business units who will make decisions and build outcomes based upon the data. Put another way, data strategies and associated data platforms that are built without engagement of the "end users" of such platforms risk challenges in relevance and adoption.       

There are couple of key strategic processes which would help in delivering successfully in the context of this framework, both of which are discussed in greater detail when [building your plan](plan.md):

1. Formation of Center of Excellence
1. Adopting Agile Delivery Method

## Deliver Value

Finally, data product delivery against the set-out success criteria in a standardized & structured way is going to validate the above iterative framework. Additionally, taking the learning and continuously innovating will help in building business confidence and widening out of the Data Strategy strategic goals, for clearer and quicker adoption across business.

## Next step: Plan for 'data management and analytics'

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for 'data management and analytics'](plan.md)
- [Review your environment or Azure Landing Zone(s)](ready.md)
- [Innovate with 'data management and analytics'](innovate.md)
- [Govern 'data management and analytics'](govern.md)
- [Manage 'data management and analytics'](manage.md)
