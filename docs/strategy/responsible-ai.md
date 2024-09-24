---
title: Adopt responsible and trusted AI principles
description: Learn about the importance of responsible AI principles when you adopt AI on Azure to ensure an ethical and effective implementation in your organization.
author: Zimmergren
ms.author: tozimmergren
ms.date: 09/23/2024
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Adopt responsible and trusted AI principles

The six key principles for responsible AI at Microsoft include fairness, reliability and safety, privacy and security, inclusiveness, transparency, and accountability. Use these principles to create responsible and trustworthy AI as you integrate it into mainstream products and services throughout your AI adoption journey.

## Responsible AI principles

Microsoft commits to [empowering responsible AI practices](https://www.microsoft.com/ai/responsible-ai).

Six key principles define responsible AI:

- **Fairness**: AI systems should treat everyone equally and provide the same recommendations to all individuals. Fairness in AI systems prevents discrimination based on personal characteristics.

- **Reliability and safety**: AI systems must operate reliably, safely, and consistently under various conditions to help build trust.

- **Privacy and security**: AI systems should respect privacy and maintain security by protecting private and confidential information. They should also resist attacks and attempts to corrupt or compromise the system.

- **Inclusiveness**: AI systems should empower and engage everyone. Inclusive design practices can help AI system developers understand and address potential exclusion barriers in a product or service. Inclusiveness fosters innovation and helps design experiences that benefit everyone.

- **Transparency**: AI systems should be transparent and understandable. AI systems can inform decisions that can deeply affect people's lives, so it's crucial for individuals to understand how the system makes these decisions.

- **Accountability**: AI systems and their developers should be accountable and answerable.

Incorporate responsible AI principles throughout your AI adoption journey, from strategy and planning to implementation. Ensure that you apply these principles when you secure, manage, and govern your AI initiatives.

:::image type="content" source="./media/responsible-ai.png" alt-text="Diagram that shows how responsible AI is foundational to all AI work across methodologies in the Cloud Adoption Framework for Azure." border="false":::

This AI adoption guidance includes examples of how you can use the Cloud Adoption Framework for Azure to implement responsible AI practices. The principles of responsible AI are integrated into the guidance and recommendations throughout this AI adoption journey.

## The importance of responsible AI

Responsible AI helps to mitigate the following risks:

- **Unintended consequences**: Plan and oversee your responsible AI implementation to reduce the risk of unforeseen effects that have ethical implications.

- **Evolving threats**: Novel threats emerge regularly as AI technology evolves. To help mitigate and stay ahead of these threats, adhere to the principles of responsible AI.

- **Bias**: Bias mitigation in AI can be challenging but is necessary to ensure that AI systems are fair and unbiased. Use the responsible AI principles to help guide you.

- **Sensitive technologies**: Technologies like facial recognition can be considered sensitive technology because of the risk to fundamental freedoms and human rights. Consider the implications of these technologies to ensure that you use them responsibly.

## Azure facilitation

Microsoft Azure provides a range of tools, services, and resources to help you build responsible AI systems.

### Use Microsoft Azure AI Content Safety to build safe systems

Use [Microsoft Azure AI Content Safety](/azure/ai-services/content-safety/) to detect harmful user-generated and AI-generated content in applications and services. Content Safety helps you analyze generated content in your AI applications, including text and images, to ensure that it's safe and appropriate for your users. Content Safety provides the following capabilities:

- [Prompt shields](/azure/ai-services/content-safety/concepts/jailbreak-detection) scans text and documents for the risk of a user input attack, or jailbreak, on a large language model (LLM).

- [Groundedness detection](/azure/ai-services/content-safety/concepts/groundedness) detects if the text responses of a language model are grounded in the source materials that the users provide.

- [Protected material detection](/azure/ai-services/content-safety/concepts/protected-material) detects if the text responses of a language model contain protected material, such as copyrighted text, song lyrics, articles, and web content.

- The [Custom Categories (rapid) API](/azure/ai-services/content-safety/concepts/custom-categories-rapid) defines emerging harmful content patterns and scans text and images for matches.

- The [Analyze Text API](/rest/api/contentsafety/text-operations/analyze-text) analyzes potentially harmful text content. It typically identifies categories like hate, self harm, and sexual or violent content.

- The [Analyze Image API](/rest/api/contentsafety/image-operations/analyze-image) analyzes potential harmful image content. It typically identifies categories like hate, self harm, and sexual or violent content.

### Use AI responsibly in Azure AI services

Microsoft provides a list of transparency notes for AI-relevant Azure services. The list includes services within the Azure AI services suite. For more information, see [Responsible use of AI with Azure AI services](/azure/ai-services/responsible-use-of-ai-overview).

### Use the Responsible AI dashboard for Azure Machine Learning

If you build systems with Azure Machine Learning, you can use the [Responsible AI dashboard](/azure/machine-learning/concept-responsible-ai-dashboard) to assess your AI systems. The Responsible AI dashboard provides a single interface to help you implement responsible AI principles. Some of the Responsible AI features include:

- **Data analysis**: Understand and explore your dataset distributions and statistics.

- **Model overview and fairness assessment**: Evaluate your model's performance and your model's group fairness problems.

- **Error analysis**: View and understand how errors are distributed in your dataset.

- **Model interpretability**: Understand your model's predictions and how your model makes individual and overall predictions.

- **Counterfactual what-if analysis**: Observe how changes in features can affect your model predictions.

- **Causal analysis**: Use historical data to view the causal effects of treatment features on real-world outcomes.

### Develop AI responsibly

|Resource|Description|
|--------|-----------|
|[Hands-on tools for building effective human-AI experiences (HAXs)](https://www.microsoft.com/en-us/haxtoolkit/)| Use the HAX Toolkit early in your design process to help you conceptualize what the AI system does and how it behaves. Use the HAX Toolkit for user-facing AI products.|
|[Conversational AI guidelines](https://www.microsoft.com/research/uploads/prod/2018/11/Bot_Guidelines_Nov_2018.pdf)|Design bots in a way that earns the trust of others to help people and society realize their full potential. Use these guidelines to create a bot that builds trust in the company and service that it represents. |
|[Inclusive AI design guidelines](https://inclusive.microsoft.design/tools-and-activities/InPursuitofInclusiveAI.pdf)|Use these guidelines to help you design AI that is inclusive and accessible to everyone.|
|[AI fairness checklist](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4t6dA)|Use the AI fairness checklist to determine whether your AI system is fair and unbiased.|
|[Responsible AI in Machine Learning](/azure/machine-learning/concept-responsible-ai) |Review these responsible AI resources if you use Machine Learning to build AI systems.|

## Next step

> [!div class="nextstepaction"]
> [Skills that you need to support the strategy phase of cloud adoption](./suggested-skills.md)
