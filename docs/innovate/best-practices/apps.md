---
title: Innovation application development tools
description: Find out about Azure application development tools that align to the Innovate methodology of the Cloud Adoption Framework.
author: Zimmergren
ms.author: pnp
ms.date: 09/07/2023
ms.topic: conceptual
ms.custom: internal
keywords: application development services, application development tools, innovation methodologies
---

# Tools to engage with applications in Azure

Build cloud-native applications to connect customers in new ways. Cloud-native applications are built from the ground up, optimized for cloud scale and performance. They are based on microservices architecture, use managed services, and take advantage of continuous delivery to achieve reliability and faster time to market.

As described in [Engage via applications](../considerations/apps.md), applications can be an important aspect of a minimal viable product (MVP) solution. For example, applications are often required for testing a hypothesis. This article helps you learn the application development tools that Azure provides to accelerate development of those applications.

![Diagram that shows the Cloud Adoption Framework approach to engaging via applications.](../../_images/innovate/engage-via-apps.png)

## Alignment with the Innovate methodology

You can accelerate this type of digital invention through each of the following approaches. Technical guidance for accelerating digital invention is listed in the table of contents on the left side of this page. Those articles are grouped by their approaches to aligning guidance with the overall Innovate methodology.

For this article, assume all inventions that result in an application stem from a shared solution as described in [Empower adoption](./ci-cd.md). Also assume each application results in some type of customer experience for both internal and external customers.

Based on these assumptions, the following three paths are the most common for cloud adoption teams who are developing digital inventions:

- **Low-code application platform:** Empower business subject matter experts to create apps and automate business processes with visual tools that don't require professional developer skills.
- **Intelligent experiences:** Create modern experiences by using cloud platforms to drive rapid deployment and short feedback loops. Expand on web applications to infuse intelligence or even integrate bots.
- **Cloud-native:** Build a new invention that naturally takes advantage of cloud capabilities.

Each path results in advantages and disadvantages that are both short-term and long-term. When the cloud governance team, the cloud operations team, and the cloud center of excellence team are ready to support every approach, you can accelerate adoption with minimal effect on sustainable business operations.

## Toolchain

Depending on the path that the cloud adoption team takes, Azure provides application development services and tools to accelerate the team's ability to build with customer empathy in mind. The following list of Azure offerings is grouped based on the preceding decision paths. These offerings include:

- Azure App Service
- Azure Kubernetes Service (AKS)
- Azure Migrate
- Azure Stack
- Power Apps
- Power Automate
- Power BI

## Get started

Below you'll find articles to help you get started with each of the tools in this toolchain.

> [!NOTE]
> The following links will leave the Cloud Adoption Framework, as they reference supporting content that's beyond the scope of CAF.

### Low-code application platform

- [Power Apps overview](/powerapps/powerapps-overview)
- [Creating applications in Power Apps](/powerapps/maker/)
- Power Apps patterns
  - [Patterns overview](/powerapps/guidance/patterns/overview)
  - [Approval pattern](/powerapps/guidance/patterns/approval-pattern)
  - [Asset management/resource booking pattern](/powerapps/guidance/patterns/asset-management-pattern)
  - [Calculation/transformation pattern](/powerapps/guidance/patterns/calculator-pattern)
  - [Communication/announcement pattern](/powerapps/guidance/patterns/communication-pattern)
  - [Inspection/audit pattern](/powerapps/guidance/patterns/inspection-pattern)
  - [Project management pattern](/powerapps/guidance/patterns/project-management-pattern)
  - [More patterns](/powerapps/guidance/patterns/more-patterns)
- [Plan a Power Apps project](/powerapps/guidance/planning/introduction)
- [Real-world architecture examples](/power-platform/guidance/architecture/real-world-examples/overview)
- [Create a workflow with Power Automate](/power-automate/getting-started)
- [Automate tasks with robotic process automation (RPA)](/power-automate/desktop-flows/introduction)
- [Plan a Power Automate project](/power-automate/guidance/planning/introduction)

### Intelligent experiences

- Modern web apps
  - [Reference solutions for web apps](/azure/architecture/solution-ideas/articles/scalable-ecommerce-web-app)
  - [Create a .NET Core application with Azure SQL Database](/azure/app-service/app-service-web-tutorial-dotnet-sqldatabase)
  - [Create a .NET application with Azure SQL Database](/azure/app-service/app-service-web-tutorial-dotnet-sqldatabase)
  - [Create a PHP application with MySQL](/azure/app-service/tutorial-php-mysql-app)
  - [Create a Node.js with MongoDB](/azure/app-service/tutorial-nodejs-mongodb-app)
- Infusing intelligence
  - [Computer vision service](/azure/cognitive-services/computer-vision/overview)
  - [Translate text in real time](/azure/cognitive-services/translator/quickstart-translator)
  - [Understand sentiment using LUIS](/azure/cognitive-services/LUIS/tutorial-machine-learned-entity)
  - [Recognize speech from a microphone](/azure/cognitive-services/speech-service/get-started-speech-to-text)
  - [Bing web search](/azure/cognitive-services/bing-web-search/tutorial-bing-web-search-single-page-app)
  - [Visual search from an image](/azure/cognitive-services/bing-visual-search/tutorial-visual-search-image-upload)
  - [Intelligent low-code apps](/ai-builder/overview)
  - Chatbots
    - [Choose the right chatbot solution](/azure/bot-service/bot-overview)
    - [Create a bot with Composer](/composer/quickstart-create-bot)
    - [Create and deploy a Microsoft Copilot Studio (formerly Power Virtual Agents) copilot](/microsoft-copilot-studio/fundamentals-get-started)
    - [Create a bot with Bot Framework SDK](/azure/bot-service/bot-service-quickstart-create-bot)

### Cloud-native applications

- Microservices architecture
  - [Design, build, and operate microservices in Azure](/azure/architecture/guide/architecture-styles/microservices)
  - [Reference architecture for microservices with Azure Kubernetes Service (AKS)](/azure/architecture/reference-architectures/containers/aks-microservices/aks-microservices)
  - [Reference architecture for serverless microservices](/samples/azure-samples/serverless-microservices-reference-architecture/serverless-microservices-reference-architecture/)
- Containers
  - [What is Kubernetes?](https://azure.microsoft.com/topic/what-is-kubernetes/)
  - [Prepare an application for Azure Kubernetes Service (AKS)](/azure/aks/tutorial-kubernetes-prepare-app)
  - [Create an Azure Red Hat OpenShift cluster](/azure/openshift/tutorial-create-cluster)
- Spring Boot microservices
  - [Launch an Azure Spring Cloud application](/azure/spring-cloud/quickstart)
  - [Distributed tracing with Azure Spring Cloud](/azure/spring-cloud/how-to-distributed-tracing)
  - [Bind an Azure Cosmos DB to your Azure Spring Cloud application](/azure/spring-cloud/how-to-bind-cosmos)
- Event-driven applications
  - [Learning path for creating serverless applications](/training/paths/create-serverless-applications/)
  - [Azure Functions developer guide](/azure/azure-functions/functions-reference)
  - [Azure Serverless Computing Cookbook](https://azure.microsoft.com/resources/azure-serverless-computing-cookbook/)
  - [Azure Functions introduction](/azure/azure-functions/functions-overview)

## Next steps

Learn about tools to accelerate customer adoption through digital support for your build-measure-learn cycles.

> [!div class="nextstepaction"]
> [Empower adoption](./ci-cd.md)
