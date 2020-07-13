---
title: What is conversational AI?
description: What is cognitive search?
author: JanetCThomas
ms.author: janet
ms.date: 07/02/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

<!-- cSpell:ignore Twilio -->

# What is conversational AI?

Users are engaging more and more with conversational interfaces, which can present a more natural experience where humans express their needs through natural language and quickly complete tasks. For a lot of companies, conversational AI applications are becoming a competitive differentiator. Many organizations are strategically making bots available within the same messaging platforms in which their customers spend time.

Organizations around the world are transforming their businesses with conversational AI, which can promote more efficient and natural interactions with both their customers and their employees. Here are a few common use cases:

- Customer support
- Enterprise assistant
- Call center optimization
- In-car voice assistant

## Building a bot

Azure Bot Service and Bot Framework offer an integrated set of tools and services to facilitate this process. Choose your favorite development environment or command line tools to create your bot. SDKs exist for C#, JavaScript, TypeScript and Python (the SDK for Java is under development). We provide tools for various stages of bot development to help you design and build bots.

![Tools for various stages of bot development](../../_images/ai-bot-dev-tools.png)

<!-- docsTest:ignore "natural language understanding" -->

### Plan

As with any type of software, having a thorough understanding of the goals, processes and user needs is important to the process of creating a successful bot. Before writing code, review the bot [design guidelines](https://docs.microsoft.com/azure/bot-service/bot-service-design-principles?view=azure-bot-service-4.0) for best practices and identify the needs for your bot. You can create a simple bot or include more sophisticated capabilities such as speech, natural language understanding, and question answering.

While designing your bot in the Plan phase consider:

- Defining bot personas:
  - What should your bot look like?
    - What should it be named?
    - What is your bot's personality? Do they have a gender?
    - How should your bot handle difficult situations and questions?
- Designing conversation flow:
  - What is the type of conversations you can expect for your use cases?
- Defining an evaluation plan:
  - How would you measure success?
  - What measurements do you want to use to improve your service?

To learn more about designing your bot review [principles of bot design](https://docs.microsoft.com/azure/bot-service/bot-service-design-principles?view=azure-bot-service-4.0).

### Build

Your bot is a web service that implements a conversational interface and communicates with the Bot Framework Service to send and receive messages and events. Bot Framework Service is one of the components of the Azure Bot Service and Bot Framework. You can create bots in any number of environments and languages. You can start your bot development in the [Azure portal](https://docs.microsoft.com/azure/bot-service/bot-service-quickstart?view=azure-bot-service-4.0), or use [C#, JavaScript, or Python](https://docs.microsoft.com/azure/bot-service/dotnet/bot-builder-dotnet-sdk-quickstart?view=azure-bot-service-4.0) templates for local development. You also have access to a variety of [samples](https://github.com/microsoft/botbuilder-samples) that showcase many of the capabilities available through the SDK. These are great for developers looking for a more feature rich starting point.

As part of the Azure Bot Service and Bot Framework, we offer additional components you can use to extend the functionality of your bot:

| Feature | Description | Link |
| --- | --- | --- |
| Add natural language processing | Enable your bot to understand natural language, understand spelling errors, use speech, and recognize the user's intent | How to use [LUIS](https://docs.microsoft.com/azure/bot-service/bot-builder-howto-v4-luis?view=azure-bot-service-4.0) |
| Answer questions | Add a knowledge base to answer questions users ask in a more natural, conversational way | How to use [QnA Maker](https://docs.microsoft.com/azure/bot-service/bot-builder-howto-qna?view=azure-bot-service-4.0) |
| Manage multiple models | If using more than one model, such as for LUIS and QnA Maker, intelligently determine when to use which one during your bots conversation | [Dispatch](https://docs.microsoft.com/azure/bot-service/bot-builder-tutorial-dispatch?view=azure-bot-service-4.0) tool |
| Add cards and buttons | Enhance the user experience with media other than text, such as graphics, menus, and cards | How to [add cards](https://docs.microsoft.com/azure/bot-service/bot-builder-howto-add-media-attachments?view=azure-bot-service-4.0) |

> [!NOTE]
> The table above is not a comprehensive list. Please review the full documentation on [Azure.com](https://docs.microsoft.com/azure/bot-service/?view=azure-bot-service-4.0)

### Test

Bots are complex applications, with a lot of different parts working together. Like any other complex application, this can lead to some interesting bugs or cause your bot to behave differently than expected. Before publishing, test your bot. We provide several ways to test bots before they're released for use:

- Test your bot locally with the [emulator](https://docs.microsoft.com/azure/bot-service/bot-service-debug-emulator?view=azure-bot-service-4.0). The Bot Framework Emulator is a stand-alone application that not only provides a chat interface but also debugging and interrogation tools to help understand how and why your bot does what it does. The emulator can be run locally alongside your in-development bot application.
- Test your bot on the [web](https://docs.microsoft.com/azure/bot-service/bot-service-manage-test-webchat?view=azure-bot-service-4.0). Once configured through the Azure portal your bot can also be reached through a web chat interface. The web chat interface is a great way to grant access to your bot to testers and other people who do not have direct access to the running code.
- [Unit test your bot](https://docs.microsoft.com/azure/bot-service/unit-test-bots) your bot with the July update of Bot Framework SDK.

### Publish

When you're ready to make your bot available on the web, [publish it to Azure](https://docs.microsoft.com/azure/bot-service/bot-builder-howto-deploy-azure?view=azure-bot-service-4.0) or to your own web service or datacenter. Having an address on the public internet is the first step to bringing your bot to life on your site or inside chat channels.

### Connect

Connect your bot to channels such as Facebook, messenger, Kik, Skype, Slack, Microsoft Teams, Telegram, text/SMS, twilio, Cortana, and Skype. Bot Framework does most of the work necessary to send and receive messages from all of these different platforms. Your bot application receives a unified, normalized stream of messages regardless of the number and type of channels it is connected to. For information on adding channels, see [Channels](https://docs.microsoft.com/azure/bot-service/bot-service-manage-channels?view=azure-bot-service-4.0) topic.

### Evaluate

Use the data collected in Azure portal to identify opportunities to improve the capabilities and performance of your bot. You can get service-level and instrumentation data like traffic, latency, and integrations. Analytics also provides conversation-level reporting on user, message, and channel data. For more information, see [How to gather analytics](https://docs.microsoft.com/azure/bot-service/bot-service-manage-analytics?view=azure-bot-service-4.0).

### Patterns for common use cases

There are common patterns used for implementation of a conversational AI application:

- Knowledge base: a knowledge bot can be designed to provide information about virtually any topic. For example, one knowledge bot might answer questions about events such as, "what bot events are there at this conference?", "when is the next reggae show?" Another might answer IT-related questions such as "how do I update my operating system?". Yet another might answer questions about contacts such as "who is john doe?" Or "what is jane doe's email address?"

The design elements to knowledge bots is available in [Design knowledge bots](https://docs.microsoft.com/azure/bot-service/bot-service-design-pattern-knowledge-base?view=azure-bot-service-4.0)

- Handoff to human: regardless of how much AI a bot possesses, there may still be times when it needs to hand off the conversation to a human being. In such cases the bot should recognize when it needs to hand off and provide the user with a smooth transition.

The patterns to hand off are available in [Transition conversations from bot to human](https://docs.microsoft.com/azure/bot-service/bot-service-design-pattern-handoff-human?view=azure-bot-service-4.0)

- Embed a bot in an application: although bots most commonly exist outside of applications, they can also be integrated with applications. For example, you could embed a [knowledge bot](https://docs.microsoft.com/azure/bot-service/bot-service-design-pattern-knowledge-base?view=azure-bot-service-4.0) within an application to help users find information or you could embed a bot within a help desk application to act as the first responder to incoming user requests. The bot could independently resolve simple issues and [hand off](https://docs.microsoft.com/azure/bot-service/bot-service-design-pattern-handoff-human?view=azure-bot-service-4.0) more complex issues to a human agent.

The ways to integrate your bot within an application are available in [Embed a bot in an application](https://docs.microsoft.com/azure/bot-service/bot-service-design-pattern-embed-app?view=azure-bot-service-4.0)

- Embed a bot in a website: like embedding bots in applications, bots can also be embedded within a website to enable multiple modes of communication across channels.

The ways to integrate your bot within a website are available in [Embed a bot in a website](https://docs.microsoft.com/azure/bot-service/bot-service-design-pattern-embed-web-site?view=azure-bot-service-4.0)

## Next steps

- Review machine learning whitepapers and e-books about [Azure Bot Service](https://azure.microsoft.com/resources/whitepapers/search/?service=bot-service)
- Review [AI + Machine Learning architectures](https://docs.microsoft.com/azure/architecture/browse/)
- [Building intelligent applications with cognitive APIs (e-book)](https://azure.microsoft.com/resources/building-intelligent-apps-with-cognitive-apis/)
- [FAQ chatbot architecture](https://azure.microsoft.com/resources/faq-chatbot-architecture/)
