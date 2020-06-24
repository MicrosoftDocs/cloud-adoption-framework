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

Microsoft’s Azure AI platform aims to empower developers to innovate and accelerate their projects.  Specifically for Conversational AI, Azure offers the Azure Bot Service and Bot Framework SDK & tools enabling developers to build rich conversational experiences. Additionally, developers can utilize Azure Cognitive Services (domain-specific AI services available as APIs) like Language Understanding, QnA maker, and Speech to add the abilities for your chatbot to understand and speak with your end-users.  
 
Common scenarios for conversational AI or chatbot solutions include:

- Informational Q&A chatbot
- Customer Service or support chatbot
- IT Helpdesk/ HR chatbot
- e-commerce/ sales chatbot
- Speech-enabled devices

Note: We offer Power Virtual Agents, built on top of the Bot Framework, for developers who want to build a chatbot with a primarily no-code/low-code experience. Additionally, developers neither host the bot themselves, control the natural language or other AI models themselves with Cognitive Services.

## Checklist

Familiarize yourself with Azure Bot Service and Microsoft Bot Framework.

- Bot Framework is open source offering comprised of an SDK (available in C#, JS, Python, and Java) to help you design, build and test your bot. It also offers a free visual authoring canvas in BF Composer, and an testing tool in BF Emulator.
- Azure Bot Service is a dedicated service within Azure that allows you to host or publish your bot in Azure and connect to popular channels.

- [Learn about Azure Bot Service and Bot Framework Overview](https://docs.microsoft.com/azure/bot-service/bot-service-overview-introduction?view=azure-bot-service-4.0)
- [Principles of bot design](https://docs.microsoft.com/azure/bot-service/bot-service-design-principles?view=azure-bot-service-4.0)
- [Find the latest versions of Bot Framework SDK & Tools](https://docs.microsoft.com/azure/bot-service/what-is-new?view=azure-bot-service-4.0)

One of the simplest ways to get started is to utilize QnA Maker, an Azure Cognitive Service which can intelligently convert an FAQ document or website into a Q&A experience in minutes.

- [Learn how to create a bot with Q&A abilities quickly with QnA Maker](https://docs.microsoft.com/azure/bot-service/bot-builder-tutorial-add-qna?view=azure-bot-service-4.0&tabs=csharp)
- [Test out the QnA Maker service directly](https://www.qnamaker.ai/)

Download and use Bot Framework SDK and Tools for bot development

- [5 minute Quickstart with Bot Framework Composer](https://docs.microsoft.com/en-us/composer/)
- [Build and test bots with Bot Framework SDK (C#, JS, Python)](https://docs.microsoft.com/azure/bot-service/dotnet/bot-builder-dotnet-sdk-quickstart?view=azure-bot-service-4.0)

Learn how to add cognitive services to make your bot even more intelligent.

- [A Developer's Guide to building AI applications](https://www.oreilly.com/library/view/a-developers-guide/9781492080619/) (e-Book)
- [Learn more about Cognitive Services](https://docs.microsoft.com/azure/cognitive-services/)

Learn how to build your own virtual assistant with Bot Framework solution accelerators, and select a common set of skills (e.g. Calendar, e-mail, Point of interest, To-do).

- [Bot Framework Virtual Assistant solution](https://microsoft.github.io/botframework-solutions/index)

## Next step

[Knowledge mining](./knowledge-mining.md)