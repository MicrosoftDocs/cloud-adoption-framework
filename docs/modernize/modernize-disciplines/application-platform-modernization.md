---
title: Application platform modernization
description: Learn how to evaluate your options for adopting modern application platforms during cloud adoption-related modernization.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: internal, seo-caf-modernize
keywords: application platform, modern, cloud modernization, cloud adoption framework
---
<!--
Dependencies: Cross-link to [Compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/scenarios/aks/toc.json) - We are concerned with a subset of this decision tree that relates to app plat)
Primary Deliverable: CAF/modernize/application-platform-modernization.md
This should fit into one net new article.
-->

# Application platform modernization

Increasingly, we're seeing customers who value the idea of innovating at a faster pace. They're using cloud-native architectures with loosely coupled microservices, managed databases, AI, DevOps support, and built-in monitoring to detect failures and problems before they happen.

## Use of this article

This article outlines how to evaluate your options for adopting modern application platforms during cloud adoption-related modernization.

## Adopt modern application platform

Adopting a modern application platform with Azure means that your apps run anywhere with limitless scale, intelligence, insights, and machine learning. *What percentage of your applications currently leverage a microservices architecture?* *Are there specific compliance or country-specific data requirements?* *Do your apps handle any sensitive personally identifiable information?*

:::image type="content" source="../../_images/modernize/future-state-vision.png" alt-text="Diagram showing intelligent cloud-native applications as future state vision.":::

**Cloud-native intelligent apps:** You can package application code and dependencies in containers, deploy as microservices, harness the power of data & AI, and build and deploy with developer tools and DevOps. These apps are typically powered by elastic infrastructure that adjusts to the varying load, supports zero downtime rollouts, and provides low latency access to data worldwide. Azure empowers your teams with the most advanced machine learning capabilities to build responsible AI solutions on your terms. Building net new cloud native applications, we have a database that fits your specific use case and needs.

**Analytics and insights:**  As the volume, variety, and velocity of data continue to grow, so too does the need to get timely insights. Only Azure provides the scale and performance needed to deliver immediate insights on your business, at incredible value. No other cloud analytics service comes close to Azure Synapse Analytics’ price-performance. Not AWS Redshift, Snowflake or GCP BigQuery.

**Data science:** A strong data and analytics foundation unlocks the potential of data science and machine learning.

For more information, see the following articles:

- [Build cloud-native applications that run anywhere.](https://azure.microsoft.com/blog/build-cloudnative-applications-that-run-anywhere/)
- [Harness the power of data and AI in your applications with Azure](https://azure.microsoft.com/blog/harness-the-power-of-data-and-ai-in-your-applications-with-azure/)
- [Data migration types](modernize/../data-platform-modernization.md)

## Deploy modern application platform

While lift and shift to IaaS is a viable path to the cloud for many applications, this route won't unlock all possible cloud benefits. If you're looking to get the most from the cloud and tap into advanced capabilities like improved resiliency, global scale, or maximum agility, cloud native applications are built from the ground up and optimized for cloud scale and performance. They’re based on microservices architectures and they use Azure Managed Services, taking advantage of continuous delivery to achieve reliability and faster time to market.

:::image type="content" source="../../_images/modernize/app-platform-infrastructure-abstraction.png" alt-text="Graphic showing infrastructure abstraction as an app platform modernization option.":::

Azure is a turn-key delivery platform for modern applications that offers a broad range of managed services for all application scenarios. Azure allows you to choose the best approach for your cloud-native applications, like:

- Containerize your applications and let Azure Managed Services handle container orchestration, provisioning, upgrading, and scaling cluster resources based on demand. *What has kept you from adopting containers?* *Do you currently deploy, or intend to deploy applications using containers on multi-cloud/hybrid environments?*
- Simplify the development of distributed cloud applications and take advantage of an enterprise-grade microservices platform with built-in security and autoscaling.
- Build cloud-native apps without the need to provision and manage infrastructure using a fully managed platform where scaling, availability, and performance are handled for you.

One way of evaluating the different options is to look at productivity versus infrastructure control and the level of infrastructure abstraction. If you want to focus on your code and application functionality first, and not the underlying infrastructure, then options like Serverless or [Azure App Service](/rest/api/appservice/) can be right for you. Here, the underlying infrastructure gets handled for you, which saves you time and allows you to focus only on what’s most important to you.

Alternatively, if you want to keep tighter control over infrastructure management, then options like containers and [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) might be the best choice for you.

You can also use a combination of all of these services. For more information, see the following articles:

- [.NET -> AKS](/azure/migrate/tutorial-app-containerization-aspnet-kubernetes)
- [Java -> AKS](/azure/migrate/tutorial-app-containerization-java-kubernetes)
- [Identity Baseline](../../_images/govern/identity-baseline.png)
- [.NET -> App Service](/azure/migrate/tutorial-app-containerization-aspnet-app-service)
- [Resource Consistency](../../_images/govern/resource-consistency.png)
- [Java -> App Service](/azure/migrate/tutorial-app-containerization-java-app-service)
- [CI/CD Day 2](/azure/migrate/tutorial-app-containerization-azure-pipeline)

### Landing zone accelerator options

To accelerate application platform modernization, use the [AKS Landing Zone accelerator](/azure/cloud-adoption-framework/scenarios/aks/enterprise-scale-landing-zone). This ready-made deployment experience supports containerization of multiple workloads.

:::image type="content" source="../../_images/modernize/azure-landing-zones.png" alt-text="Graphic showing three landing zone implementation options.":::

Each [landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) supports one or more applications in your cloud portfolio using the inherited controls.

Landing zone implementations establish an enterprise control plane by defining environmental configuration and controls required for compliant operations management.

For more information about planning and understanding your modernization options, see the following articles:

- [Plan for modern application platforms](/azure/cloud-adoption-framework/scenarios/aks/plan)
- [Understand considerations and options for initial containers](../../scenarios/aks/plan.md#considerations-for-initial-containers)
- [Compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/scenarios/aks/toc.json)
- [Container options](/azure/cloud-adoption-framework/scenarios/aks/plan)<!--(influences core app plat decisions)-->
- <!--Link to Understanding modernize disciplines-->

## Migrate applications

Today, your workloads are on virtual machines (VMs). When you modernize, you can allow workload portability between container hosts across hybrid, multicloud, and the edge with diverse container orchestration options.
[Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) offers fully managed Kubernetes clusters for deployment, scaling, and management of containerized applications.

In the following image, see an example of quick modernization flow without a single line of code.

:::image type="content" source="../../_images/modernize/quick-modernization-without-code.png" alt-text="Graphic showing process of modernization without a single line of code.":::

- Run any container of your choice on Azure
- Build your own or use a prescriptive platform
- Faster app deployment with integrated Visual Studio family of products and Visual Studio Team Server

:::image type="content" source="../../_images/modernize/dotnet-to-azure-app-service-azure-sql.png" alt-text="Graphic showing Azure server and database migration flow examples.":::

### Use microservices

Microservices architecture means breaking large software projects into smaller, independent, and loosely coupled modules. The range of Azure offerings gives you the flexibility to implement independent services with a framework designed for distributed systems, using containers, or with a serverless approach.

:::image type="content" source="../../_images/modernize/rearchitect-with-microservices.png" alt-text="Graphic showing monolithic versus microservices.":::

When you use microservices:

- Each service is independent, so you can develop a new project on its own schedule.
- You can use any language or stack that best fits current requirements.
- Scaling up is easier than with VMs or containers, as it only requires deploying more services as needed.
- Application maintenance is easier. Developers work on individual services, so the code base the developer works with is smaller, easier to manage, and easier to understand.
- Microservices-based applications are more resilient and stable. If one or more services fail, the application continues to work.
- Individual service instances can be upgraded, changed or taken down without negative impact to the entire application.

### Serverless application platform components

At the center of the Serverless platform, are our compute offerings: Azure Functions and Azure Logic Apps. Azure Functions is an event-based Serverless compute experience that helps you accelerate your development. Logic Apps is a powerful orchestration tool. It enables building a Serverless app in minutes by orchestrating multiple functions using a visual workflow tool.

:::image type="content" source="../../_images/modernize/serverless-application-platform-components.png" alt-text="Graphic showing serverless app plat components.":::

Let's say you have your apps up and running using Serverless. Congratulations! Next, collect intelligence from different apps across platforms to action on. The following essential components are core to building Serverless applications:

- **Data/Storage:** Functions has triggers and bindings with Azure document DB and Azure Blob storage.
- **Triggers:** Event responses used to trigger your custom code. They allow you to respond to events across the Azure platform or on premise.
- **Bindings:** Represent the necessary metadata used to connect your code to the desired trigger or associated input or output data.
- **Messaging:** Queues and topics using Azure Service Bus and Azure Event Hubs.
- **Integration:** Includes core LOB apps and SaaS apps integration via Azure Logic Apps.
- **Intelligence on data and sentiment:** Predictive analysis using Cognitive services and Machine learning.
- **Conversation as a service:** Equip developers to build apps that offer an end-to-end experience for their users. Azure Bot Service offers a Serverless interactive bot experience.

Developers are spending more time writing code, which allows them to add huge business impact with Serverless. Microsoft offers numerous development tools, such as IDE Support for Visual Studio in Azure Functions and Logic Apps, which enable local development and visual debugging capability, all with your tools of choice.

#### Use cases for Serverless

We've highlighted the following top scenarios and use cases for Serverless:

- **Real-time Stream analytics:** Uses Functions to feed real-time streams of data from application tracking into structured data and store it in SQL online.
- **SaaS event processing:** Uses Functions and Logic Apps to analyze data from an excel file in OneDrive and perform validation, filtration, sorting, and convert data into consumable business charts.
- **Web app architecture:** Used often in creating targeted marketing collateral. When you select on a webpage, it triggers a webhook that uses a function to create an ad that matches your customer profile and displays a completed webpage.
- **Real-time bot messaging:** When you send a message to a chatbot, Functions calls Cortana analytics to generate appropriate answers and sends a response back.
