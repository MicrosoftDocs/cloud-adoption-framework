---
title: AI applications
description: Infusing AI into an application with Microsoft Azure Cognitive Services.
author: v-hanki
ms.author: janet
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: think-tank
---

# AI applications and agents

Infusing AI into an application can be difficult and time-consuming. Until recently, you needed both a deep understanding of machine learning and months of development to acquire data, train models, and deploy them at scale. Even then, success was not guaranteed. The path was filled with blockers, gotchas, and pitfalls causing teams to fail to realize value from their AI investments.

## AI applications

Microsoft Azure Cognitive Services remove these challenges and are designed to be productive, enterprise ready, and trusted. They make it possible for you to build on the latest breakthroughs in AI without building and deploying your own models; instead you can deploy AI models using just a few simple lines of code so that even without a large data science team, you can quickly create applications that see, hear, speak, understand, and even begin to reason.

Common scenarios for AI applications include:

- Sentiment analysis
- Object detection
- Translation
- Personalization
- Robotic process automation

As you get started, the checklist and resources below will help you plan your application development and deployment.

- Are you familiar with the multitude of capabilities and services offered within Azure Cognitive Services, and which ones in particular you will be using?
- Determine whether or not you have custom data with which you want to train and customize these models. There are Cognitive Services that are customizable.
- There are several ways to use Azure Cognitive Services. Explore the quickstart tutorials for getting up and running for both SDK and REST APIs. Note: the Cognitive Services SDKs are available for many popular dev languages, including C#, Python, Java, JavaScript and Go.
- Determine whether you will need to deploy these Cognitive Services in containers.

## AI applications checklist

To get started, first familiarize yourself with the various categories and services within Azure Cognitive Services. Visit the product pages to learn more and to interact with demos to learn more about the capabilities available, such as vision, speech, language, and decision. There is also an e-book that walks through common scenarios and how to build your first application with Cognitive Services.

- [Cognitive Services](/azure/cognitive-services/welcome)
- [Interactive demos across the product/service pages](https://azure.microsoft.com/services/cognitive-services/)
- [Building intelligent applications with cognitive APIs](https://azure.microsoft.com/resources/building-intelligent-apps-with-cognitive-apis/) (e-book)

Select the service you want to use across vision, language, speech, decision, or web search. Each category on the page offers a set of quick starts, tutorials, how-to guides, whether you want to use the REST API or SDKs.

<!-- docutune:casing "Intelligent Kiosk" -->

You can also download the Intelligent Kiosk to experience and demo these services.

- [Cognitive Services documentation](/azure/cognitive-services/)
- [Building intelligent applications with cognitive APIs](https://azure.microsoft.com/resources/building-intelligent-apps-with-cognitive-apis/) (e-book)
- [Install the Intelligent Kiosk to familiarize yourself with Cognitive Services capabilities](https://github.com/Microsoft/Cognitive-Samples-IntelligentKiosk)

Learn more about container support for Azure Cognitive Services.

- [Container support in Azure Cognitive Services](/azure/cognitive-services/cognitive-services-container-support)

Review reference architectures for AI solutions.

- [AI + Machine Learning](/azure/architecture/browse/#ai--machine-learning)

## AI agents

Microsoft's Azure AI platform aims to empower developers to innovate and accelerate their projects. Specifically for conversational AI, Azure offers the Azure Bot Service and Bot Framework SDK and tools enabling developers to build rich conversational experiences. Additionally, developers can use Azure Cognitive Services (domain-specific AI services available as APIs) like Language Understanding (LUIS), QnA Maker, and Speech service to add the abilities for your chatbot to understand and speak with your end users.

Common scenarios for conversational AI or chatbot solutions include:

- Informational Q&A chatbot
- Customer service or support chatbot
- IT help desk or HR chatbot
- e-commerce or sales chatbot
- Speech-enabled devices

> [!NOTE]
> We offer Power Virtual Agents, built on top of the Bot Framework, for developers who want to build a chatbot with a primarily no-code/low-code experience. Additionally, developers neither host the bot themselves, control the natural language or other AI models themselves with Cognitive Services.

## AI agents checklist

Familiarize yourself with Azure Bot Service and Microsoft Bot Framework.

- Bot Framework is an open-source offering that provides an SDK (available in C#, JavaScript, Python, and Java) to help you design, build, and test your bot. It also offers a free visual authoring canvas in Bot Framework Composer and a testing tool in Bot Framework Emulator.
- Azure Bot Service is a dedicated service within Azure that allows you to host or publish your bot in Azure and connect to popular channels.

- Read the [Azure Bot Service and Bot Framework overview](/azure/bot-service/bot-service-overview-introduction)
- Learn about [Principles of bot design](/azure/bot-service/bot-service-design-principles)
- Get the [latest versions of Bot Framework SDK and tools](/azure/bot-service/what-is-new)

One of the simplest ways to get started is to use QnA Maker, part of Azure Cognitive Services, which can intelligently convert an FAQ document or website into a Q&A experience in minutes.

- [Create a bot with Q&A abilities quickly with QnA Maker](/azure/bot-service/bot-builder-tutorial-add-qna)
- Test out the [QnA Maker service](https://www.qnamaker.ai/)

Download and use Bot Framework SDK and tools for bot development.

- [5 minute quickstart with Bot Framework Composer](/composer/)
- [Build and test bots with Bot Framework SDK (C#, JavaScript, Python)](/azure/bot-service/dotnet/bot-builder-dotnet-sdk-quickstart)

Learn how to add Cognitive Services to make your bot even more intelligent.

- [A developer's guide to building AI applications](https://www.oreilly.com/library/view/a-developers-guide/9781492080619/) (e-book)
- Learn more about [Cognitive Services](/azure/cognitive-services/)

Learn how to build your own Virtual Assistant with Bot Framework solution accelerators, and select a common set of skills such as calendar, e-mail, point of interest, and to-do.

- [Bot Framework Virtual Assistant solution](https://microsoft.github.io/botframework-solutions/index)

## Next steps

Explore other AI solution categories:

- [Machine learning](./machine-learning.md)
- [Knowledge mining](./knowledge-mining.md)
