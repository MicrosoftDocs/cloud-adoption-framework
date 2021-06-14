---
title: AI applications
description: Discover the applications of AI to infuse AI into your application development. Use Microsoft Azure Cognitive Services to become enterprise-ready.
author: v-hanki
ms.author: janet
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: think-tank, seo-caf-innovate
keywords: AI applications, examples of AI applications, AI application checklist, applications of AI, AI agents
---

# AI applications and agents

The applications of AI cover a wide variety of applications, such as electronic trading platforms, remote sensing, robot control, and medical diagnosis. Infusing AI into an application can be difficult and time-consuming. Until recently, you needed a deep understanding of machine learning and months of development to acquire data, train models, and deploy them at scale. Even then, success wasn't guaranteed. The path was filled with obstacles and pitfalls, causing teams to fail to realize value from their AI investments.

## AI applications

Microsoft Azure Cognitive Services are domain-specific AI services available as APIs. These services remove the challenges of building AI into your applications and are designed to make them productive, enterprise ready, and trusted. They make it possible for you to build on the latest breakthroughs in AI without building and deploying your own models; instead, you can deploy AI models by using just a few lines of code. Even without a large data science team, you can quickly create AI applications that see, hear, speak, understand, and even begin to reason.

Common examples of AI applications include:

- Sentiment analysis
- Object detection
- Translation
- Personalization
- Robotic process automation

Follow these guidelines to plan your AI application development and deployment:

- Become familiar with the multitude of capabilities and services offered within Azure Cognitive Services, and determine which ones you'll be using.
- Determine whether you have custom data with which you want to train and customize AI models. Certain services can be customized.
- Explore the Azure Cognitive Services quickstart tutorials to learn how to use SDK and REST APIs. The Cognitive Services SDKs are available for many popular dev languages, including C#, Python, Java, JavaScript, and Go.
- Determine whether you need to deploy these Cognitive Services in containers.

## AI applications checklist

To get started, first familiarize yourself with the various categories and services within Azure Cognitive Services, such as vision, speech, language, decision, and web search. Visit the product pages to learn more and to interact with demos. Each category on the page offers a set of quick starts, tutorials, and how-to guides for the REST APIs and SDKs. You can also read an e-book that describes common scenarios and how to build your first AI application with Cognitive Services.

- Read the [Cognitive Services documentation](/azure/cognitive-services/).
- Explore [interactive demos across the product/service pages](https://azure.microsoft.com/services/cognitive-services/).
- Read the e-book, [Building Intelligent Apps with Cognitive APIs](https://azure.microsoft.com/resources/building-intelligent-apps-with-cognitive-apis/).
- Download the [Intelligent Kiosk](https://github.com/Microsoft/Cognitive-Samples-IntelligentKiosk) to experience and demo the services. <!-- docutune:casing "Intelligent Kiosk" -->
- Learn more about [Container support in Azure Cognitive Services](/azure/cognitive-services/cognitive-services-container-support).
- Review [reference architectures for AI solutions](/azure/architecture/browse/#ai--machine-learning).

## AI agents

The Microsoft Azure AI platform aims to empower developers to innovate and accelerate their projects. For conversational AI, Azure offers the Azure Bot Service and Bot Framework SDK and tools to enable developers to build rich conversational experiences. Additionally, developers can use Azure Cognitive Services like Language Understanding (LUIS), QnA Maker, and Speech service to add the abilities for chatbots to understand and speak with their end users.

Common scenarios for conversational AI or chatbot solutions include:

- Informational Q&A chatbot
- Customer service or support chatbot
- IT help desk or HR chatbot
- Sales or e-commerce chatbot
- Speech-enabled devices

> [!NOTE]
> Microsoft offers Power Virtual Agents, built on top of the Bot Framework, for developers who want to build a chatbot with a primarily no-code or low-code experience. In this scenario, developers don't host the bot themselves and don't control the natural language or other AI models with Cognitive Services.

## AI agents checklist

Azure Bot Service and Microsoft Bot Framework have the following characteristics:

- Bot Framework is an open-source offering that provides an SDK to help you design, build, and test your bot. This SDK is available in C#, JavaScript, Python, and Java. It also offers a free visual authoring canvas in Bot Framework Composer and a testing tool in Bot Framework Emulator.
- Azure Bot Service is a dedicated service within Azure that allows you to host or publish your bot in Azure and connect to popular channels.

For more information about Azure Bot Service and Bot Framework, see:

- [Azure Bot Service and Bot Framework overview](/azure/bot-service/bot-service-overview-introduction)
- [Principles of bot design](/azure/bot-service/bot-service-design-principles)

One of the easiest ways to get started is to use QnA Maker, part of Azure Cognitive Services, which can intelligently convert an FAQ document or website into a Q&A experience in minutes. To use QnA Maker, see:

- [Tutorial: Use QnA Maker in your bot to answer questions](/azure/bot-service/bot-builder-tutorial-add-qna)
- [Try out the QnA Maker service](https://www.qnamaker.ai/)

To download and use Bot Framework SDK and tools for bot development, see:

- [Latest versions of Bot Framework SDK and tools](/azure/bot-service/what-is-new)
- [Create your first bot](/composer/quickstart-create-bot)
- [Create a bot with the Bot Framework SDK for .NET](/azure/bot-service/dotnet/bot-builder-dotnet-sdk-quickstart)

To learn how to add Cognitive Services to make your bot even more intelligent, see:

- [A Developer's Guide to Building AI Applications (e-book)](https://www.oreilly.com/library/view/a-developers-guide/9781492080619/)
- [Cognitive Services documentation](/azure/cognitive-services/)

To learn how to build your own Virtual Assistant with Bot Framework solution accelerators, and select a common set of skills such as calendar, e-mail, point of interest, and to-do, see the [Bot Framework Solutions Documentation](https://microsoft.github.io/botframework-solutions/index).

## Next steps

Explore other AI solution categories:

- [Machine learning](./machine-learning.md)
- [Knowledge mining](./knowledge-mining.md)
