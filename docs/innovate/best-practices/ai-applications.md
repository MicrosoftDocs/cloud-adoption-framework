---
title: What are AI applications?
description: What are AI applications? Learn how you can integrate AI applications and capabilities with your applications using Azure Cognitive Services.
author: v-hanki
ms.author: janet
ms.date: 01/26/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: think-tank, seo-caf-innovate
keywords: ai applications, what are ai applications, speech recognition apis, computer vision apis, decision logic apis
---

<!-- docutune:ignore "computer vision APIs" -->

# What are AI applications?

AI applications are things like speech recognition APIs, computer vision APIs, decision logic APIs, and other kinds of intelligent systems that mimic human reason. These are essential functions of many software products in the market today, since AI applications can communicate with end users in a more natural manner and make for a better user experience. Azure can help you and your team save time by being able to roll out AI applications anywhere.

In Azure, you can build intelligent applications faster by using the tools and technologies of your choice and built-in AI.

- **Easily build and deploy anywhere:** Use your team's existing skill set and the tools you know to build intelligent applications and deploy them without a change in code. You can build once and then deploy in the cloud, on-premises, and to edge devices. You can be confident of global distribution to more datacenters than with any other provider.
- **Create an impact by using an open platform:** Choose your favorite technologies, which can be open source. Azure supports a range of deployment options, popular stacks and languages, and a comprehensive set of data engines. Capitalize on this flexibility, plus the performance, scale, and security delivered by Microsoft technologies to build applications for any scenario.
- **Develop applications with built-in intelligence:** Building intelligent applications using Azure is easy, because no other platform brings analytics and native AI to your data wherever it lives and in the languages you use. You can take advantage of a rich set of [cognitive APIs](https://azure.microsoft.com/services/cognitive-services/) to easily build new experiences into your applications for human-like intelligence.

## What is Azure Cognitive Services?

Azure Cognitive Services can simplify how you integrate AI capabilities and breakthroughs into your applications with a few simple lines of code. It supports you to create applications that see, hear, speak, understand, and even start to reason between your business processes. Cognitive Services provides AI intelligence in a form that's easy to use and incorporate into your applications.

Cognitive Services is made up of APIs, SDKs, and services available to help developers build intelligent applications without having direct AI or data science skills or knowledge. Cognitive Services enables developers to easily add cognitive features into their applications. The catalog of services within Cognitive Services can be categorized into five main parts: vision, speech, language, web search, and decision.

### Computer Vision APIs

| Service name | Service description |
| --- | --- |
| [Computer Vision](/azure/cognitive-services/computer-vision/) | Computer Vision APIs provides you with access to advanced algorithms for processing images and returning information. |
| [Custom Vision](/azure/cognitive-services/custom-vision-service/overview) | Custom Vision allows you to build custom image classifiers. |
| [Face](/azure/cognitive-services/face/) | The Face service provides access to advanced face algorithms that detect and recognize facial attributes. |
| [Form Recognizer](/azure/cognitive-services/form-recognizer/) (preview) | Form Recognizer identifies and extracts key-value pairs and table data from form documents. It then outputs structured data, which includes the relationships, in the original file. |
| [Video Indexer](/azure/media-services/video-indexer/video-indexer-overview) | Video Indexer enables you to extract insights from your videos. |

### Speech recognition APIs

| Service name | Service description |
| --- | --- |
| [Speech](/azure/cognitive-services/speech-service/) | Speech service adds speech-enabled features to applications. |
| [Speaker Recognition](/azure/cognitive-services/speech-service/speaker-recognition-overview) (preview) | The Speaker Recognition API provides algorithms for Speaker Identification and verification. |
| [Bing Speech](/azure/cognitive-services/speech-service/how-to-migrate-from-bing-speech) (retired) | You can migrate existing Bing Speech API applications to the Speech service. |
| [Translator Speech](/azure/cognitive-services/speech-service/how-to-migrate-from-translator-speech-api) (retired) | You can migrate existing Bing Translator Speech API applications to the Speech service. |

### Language APIs

| Service name | Service description |
|--|--|
| [Language Understanding (LUIS)](/azure/cognitive-services/luis/) | The Language Understanding service (LUIS) allows your application to understand what a person wants in their own words. |
| [QnA Maker](/azure/cognitive-services/qnamaker/) | QnA Maker allows you to build a question-and-answer service from your semistructured content. |
| [Text Analytics](/azure/cognitive-services/text-analytics/) | Text Analytics provides natural language processing over raw text for sentiment analysis, key phrase extraction, and language detection. |
| [Translator](/azure/cognitive-services/translator/) | Translator provides machine-based text translation in near real time. |

### Decision logic APIs

| Service name | Service description |
| --- | --- |
| [Anomaly Detector](/azure/cognitive-services/anomaly-detector/) (preview) | Anomaly Detector allows you to monitor and detect abnormalities in your time series data. |
| [Content Moderator](/azure/cognitive-services/content-moderator/overview) | Content Moderator provides monitoring for possible offensive, undesirable, and risky content. |
| [Personalizer](/azure/cognitive-services/personalizer/) | Personalizer allows you to learn from users' real-time behavior in order to choose the most tailored experience for them. |

### Supported cultural languages

Cognitive Services supports a wide range of cultural languages at the service level. You can find the language availability for each API in the [supported languages list](/azure/cognitive-services/language-support).

### Secure resources

Cognitive Services provides a layered security model, which includes [authentication](/azure/cognitive-services/authentication) via Azure Active Directory credentials, a valid resource key, and [Azure Virtual Network](/azure/cognitive-services/cognitive-services-virtual-networks).

### Container support

Cognitive Services provides containers for deployment in the cloud or on-premises. Learn more about [Cognitive Services containers](/azure/cognitive-services/cognitive-services-container-support).

<!-- docutune:casing "HIPAA BAA" "CSA STAR" -->

### Certifications and compliance

Cognitive Services has been awarded certifications such as CSA STAR certification, FedRAMP Moderate, and HIPAA BAA.

You can [download](https://gallery.technet.microsoft.com/Overview-of-Azure-c1be3942) certifications for your own audits and security reviews.

To understand privacy and data management, go to the [Microsoft Trust Center](https://servicetrust.microsoft.com/).

## How are Cognitive Services and Azure Machine Learning similar?

Cognitive Services and Azure Machine Learning have the common goal of applying AI to enhance business operations. How each one provides this capability in the respective offerings is different. Generally, the audiences are different:

- Cognitive Services is for developers without machine learning experience.
- Machine learning is tailored for data scientists.

## How is a cognitive service different from machine learning?

A cognitive service provides a trained model for you. This model brings data and an algorithm together and is available from a REST API or SDK. You can implement this service within minutes depending on your scenario. A cognitive service provides answers to general problems such as key phrases in text or item identification in images.

Machine learning is a process that generally requires a longer period of time to implement successfully. This time is spent on data collection, cleaning, transformation, algorithm selection, model training, and deployment to get to the same level of functionality provided by a cognitive service. With machine learning, it's possible to provide answers to highly specialized or specific problems. Machine learning problems require familiarity with the specific subject matter and data of the problem under consideration and expertise.

## Next steps

- Learn more about [Cognitive Services](/azure/cognitive-services/).
- Find [best practices for AI architectures](/azure/architecture/solution-ideas/articles/ai-at-the-edge).
