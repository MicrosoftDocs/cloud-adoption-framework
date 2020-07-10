---
title: "Conversational AI"
description: For Conversational AI, Azure offers the Azure Bot Service and Bot Framework SDK and tools enabling developers to build rich conversational experiences.
author: JanetCThomas
ms.author: janet
ms.date: 06/24/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Conversational AI

Microsoft's Azure AI platform aims to empower developers to innovate and accelerate their projects. Specifically for conversational AI, Azure offers the Azure Bot Service and Bot Framework SDK and tools enabling developers to build rich conversational experiences. Additionally, developers can use Azure Cognitive Services (domain-specific AI services available as APIs) like language understanding, QnA Maker, and speech to add the abilities for your chatbot to understand and speak with your end users.

Common scenarios for conversational AI or chatbot solutions include:

- Informational Q&A chatbot
- Customer service or support chatbot
- IT help desk or HR chatbot
- E-commerce or sales chatbot
- Speech-enabled devices

> [!NOTE]
> Microsoft offers Power Virtual Agents, built on top of the Bot Framework, for developers who want to build a chatbot with a primarily no-code or low-code experience. Additionally, developers neither host the bot themselves nor control the natural language or other AI models with Cognitive Services.

## Checklist

Familiarize yourself with Azure Bot Service and Microsoft Bot Framework.

- Bot Framework is open-source offering that provides an SDK (available in C#, JavaScript, Python, and Java) to help you design, build, and test your bot. It also offers a free visual authoring canvas in Bot Framework Composer and a testing tool in Bot Framework Emulator.
- Azure Bot Service is a dedicated service within Azure that allows you to host or publish your bot in Azure and connect to popular channels.

- [Learn about Azure Bot Service and Bot Framework overview](https://docs.microsoft.com/azure/bot-service/bot-service-overview-introduction?view=azure-bot-service-4.0)
- [Principles of bot design](https://docs.microsoft.com/azure/bot-service/bot-service-design-principles?view=azure-bot-service-4.0)
- [Find the latest versions of Bot Framework SDK and tools](https://docs.microsoft.com/azure/bot-service/what-is-new?view=azure-bot-service-4.0)

One of the simplest ways to get started is to use QnA Maker, part of Azure Cognitive Services, which can intelligently convert an FAQ document or website into a Q&A experience in minutes.

- [Learn how to create a bot with Q&A abilities quickly with QnA Maker](https://docs.microsoft.com/azure/bot-service/bot-builder-tutorial-add-qna?view=azure-bot-service-4.0&tabs=csharp)
- [Test out the QnA Maker service directly](https://www.qnamaker.ai/)

Download and use Bot Framework SDK and tools for bot development

- [5-minute quickstarts for Bot Framework Composer](https://docs.microsoft.com/composer/)
- [Build and test bots with Bot Framework SDK (C#, JavaScript, Python)](https://docs.microsoft.com/azure/bot-service/dotnet/bot-builder-dotnet-sdk-quickstart?view=azure-bot-service-4.0)

Learn how to add Cognitive Services to make your bot even more intelligent.

- [A developer's guide to building AI applications](https://www.oreilly.com/library/view/a-developers-guide/9781492080619/) (e-book)
- [Learn more about Cognitive Services](https://docs.microsoft.com/azure/cognitive-services/)

Learn how to build your own Virtual Assistant with Bot Framework solution accelerators, and select a common set of skills (for example, calendar, e-mail, point of interest, to-do).

- [Bot Framework Virtual Assistant solution](https://microsoft.github.io/botframework-solutions/index)

## Next step

[Knowledge mining](./knowledge-mining.md)
