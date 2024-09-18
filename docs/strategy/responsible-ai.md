---
title: Responsible and trusted AI adoption
description: Learn about the importance of responsible AI considerations when you adopt AI on Azure in your organization.
author: Zimmergren
ms.author: tozimmergren
ms.date: 09/19/2024
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Responsible and trusted AI adoption

The six key principles for responsible AI at Microsoft are fairness, reliability and safety, privacy and security, inclusiveness, transparency, and accountability. These principles are essential for creating responsible and trustworthy AI as it integrates into mainstream products and services throughout your AI adoption journey.

## The responsible AI principles

Microsoft is committed to [empowering responsible AI practices](https://www.microsoft.com/ai/responsible-ai).

Six key principles define responsible AI:

- **Fairness**: AI systems must treat everyone equally and provide the same recommendations to all individuals. Ensuring fairness in AI systems is essential to prevent discrimination based on personal characteristics.

- **Reliability and safety**: AI systems must operate reliably, safely, and consistently under various conditions to help build trust.

- **Privacy and security**: AI systems must respect privacy and maintain security by protecting private and confidential information, and resisting attacks and attempts to corrupt or compromise the system.

- **Inclusiveness**: AI systems must empower and engage everyone. Inclusive design practices enable AI system developers to understand and address potential exclusion barriers in a product or service. Inclusiveness fosters innovation and helps design experiences that benefit everyone.

- **Transparency**: AI systems must be transparent and understandable. Because AI systems can inform decisions that can deeply affect people's lives, it's crucial for individuals to understand how these decisions are made.

- **Accountability**: AI systems and their developers must be accountable and answerable.

Consider responsible AI principles at every phase of your AI adoption journey, from strategy and planning to implementation, and securing, managing, and governing your AI initiatives.

:::image type="content" source="./media/responsible-ai.png" alt-text="Diagram that shows how responsible AI is foundational to all AI work across methodologies in the Cloud Adoption Framework for Azure." border="false":::

This AI adoption guidance includes examples of how the Cloud Adoption Framework for Azure can help you implement responsible AI practices. The principles of responsible AI are integrated into the guidance and recommendations throughout this AI adoption journey.

## The importance of responsible AI

The following are key reasons why responsible AI is essential:

- **Unintended consequences**: Planning and oversight are crucial to reduce the risk of unforeseen effects that have ethical implications.

- **Evolving threats**: Novel threats emerge regularly as AI technology evolves. To help mitigate and stay ahead of these threats, adhere to the principles of responsible AI.

- **Bias**: Bias mitigation in AI can be challenging but is necessary to ensure that AI systems are fair and unbiased. Use the responsible AI principles to help guide you.

- **Sensitive technologies**: Specific technologies such as facial recognition can be considered a sensitive technology because of the risk to fundamental freedoms and human rights. Make sure to consider the implications of using such technologies to ensure that they're used responsibly.

## Azure facilitation

Microsoft Azure provides a range of tools, services, and resources to help you build responsible AI systems. Here are some examples:

### Build safer systems with Azure AI Content Safety

Use [Microsoft Azure AI Content Safety](/azure/ai-services/content-safety/) to detect harmful user-generated and AI-generated content in applications and services. Content Safety helps you analyze generated content in your AI applications, including text and images, to ensure that it's safe and appropriate for your users. Content Safety provides the following capabilities:

- [Prompt Shields, or jailbreak detection](/azure/ai-services/content-safety/concepts/jailbreak-detection), scans text and documents for the risk of a User input attack, or jailbreak, on an LLM model.

- [Groundedness detection](/azure/ai-services/content-safety/concepts/groundedness) detects if the text responses of an LLM are grounded in the source materials provided by the users.

- [Protected material detection](/azure/ai-services/content-safety/concepts/protected-material) detects if the text responses of an LLM contain protected material, such as copyrighted text, song lyrics, articles, web content, and more.

- [Custom categories (rapid)](/azure/ai-services/content-safety/concepts/custom-categories-rapid) define emerging harmful content patterns and scan text and images for matches.

- [Analyze Text API](/rest/api/contentsafety/text-operations/analyze-text) analyzes potentially harmful text content. It typically identifies categories like hate, self harm, sexual, or violent content.

- [Analyze Image API](/rest/api/contentsafety/image-operations/analyze-image) analyzes potential harmful image content. It typically identifies categories like hate, self harm, sexual, or violent content.

### Understand responsible use of AI with Azure AI services

Microsoft provides a list of transparency notes for AI-relevant Azure services. Use the following link to learn more about the guidelines on how to responsibly use AI in applications. Different services within the Azure AI service suite are represented. For more information, see [Responsible use of AI with Azure AI services](/azure/ai-services/responsible-use-of-ai-overview).

### Use the Responsible AI dashboard for Azure Machine Learning

If you build systems with Azure Machine Learning, you can use the [Responsible AI dashboard](/azure/machine-learning/concept-responsible-ai-dashboard) to assess your AI systems. The Responsible AI dashboard has a single interface to help you implement Responsible AI in practice. Some of the Responsible AI components include:

- **Data analysis**: Understand and explore your dataset distributions and statistics.

- **Model overview and fairness assessment**: Evaluate the performance of your model and your model's group fairness issues.

- **Error analysis**: View and understand how errors are distributed in your dataset.

- **Model interpretability**: Understand your model's predictions and how both overall and individual predictions are made.

- **Counterfactual what-if analysis**: Observe how changes in features can affect your model predictions.

- **Causal analysis**: Use historical data to view the causal effects of treatment features on real-world outcomes.

### Guidelines to develop AI responsibly

|Resource|Description|
|--------|-----------|
|[Hands-on tools for building effective human-AI experiences](https://www.microsoft.com/haxtoolkit/)|The HAX Toolkit is for teams that build user-facing AI products. It helps you conceptualize what the AI system does and how it behaves. Use the HAX Toolkit early in your design process.|
|[Conversational AI guidelines](https://www.microsoft.com/research/uploads/prod/2018/11/Bot_Guidelines_Nov_2018.pdf)|In order for people and society to realize the full potential of bots, they need to be designed in such a way that they earn the trust of others. These guidelines are aimed at helping you design a bot that builds trust in the company and service that the bot represents.|
|[Inclusive AI design guidelines](https://inclusive.microsoft.design/tools-and-activities/InPursuitofInclusiveAI.pdf)|These guidelines are intended to help you design AI that is inclusive and accessible to everyone.|
|[AI fairness checklist](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4t6dA)|Use the AI fairness checklist to determine whether your AI system is fair and unbiased.|
|[Responsible AI](/azure/machine-learning/concept-responsible-ai) in Machine Learning|Review these responsible AI resources if you build AI systems by using Machine Learning.|

## Next steps

> [!div class="nextstepaction"]
> [Skills relevant to strategy](./suggested-skills.md)
