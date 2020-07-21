---
title: What are AI applications?
description: What is cognitive search?
author: v-hanki
ms.author: janet
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

<!-- cSpell:ignore Personalizer -->

# What are AI applications?

In Azure, you can build intelligent applications faster using the tools and technologies of your choice and AI that's already built-in.

- **Easily build and deploy anywhere:** Use your team's existing skill set and tools you know and love to build intelligent applications and deploy without a change in code. Build once, deploy anywhere: in the cloud, on-premises, and to edge devices, with the confidence of global distribution to more datacenters than any other provider.

- **Create an impact using an open platform:** Choose your favorite technologies, including open source. Azure supports a range of deployment options, popular stacks and languages, and a comprehensive set of data engines. Capitalize on this flexibility, plus the performance, scale, and security delivered by Microsoft technologies to build applications for any scenario.

- **Develop applications with built-in intelligence:** Building intelligent applications using Azure is easy, because no other platform brings analytics and native AI to your data wherever it lives and in the languages you use. Take advantage of a rich set of [cognitive APIs](https://azure.microsoft.com/services/cognitive-services/) to easily build new experiences into your applications for human-like intelligence.

## What are Azure Cognitive Services?

Azure Cognitive Services can simplify infusing AI into your applications and use the latest breakthroughs in AI using a few simple lines of code. They bring the ability to create applications that see, hear, speak, understand and even begin to bring reason into your business processes. Azure Cognitive Services provide the AI intelligence in a form that is easy to use and incorporate into your application.

Azure Cognitive Services are APIs, SDKs, and services available to help developers build intelligent applications without having direct AI or data science skills or knowledge. Azure Cognitive Services enable developers to easily add cognitive features into their applications. The goal of Azure Cognitive Services is to help developers create applications that can see, hear, speak, understand, and even begin to reason. The catalog of services within Azure Cognitive Services can be categorized into five main pillars: vision, speech, language, web search, and decision.

### Vision APIs

| Service name | Service description |
| --- | --- |
| [Computer Vision](https://docs.microsoft.com/azure/cognitive-services/computer-vision/) | The Computer Vision service provides you with access to advanced algorithms for processing images and returning information. |
| [Custom Vision](https://docs.microsoft.com/azure/cognitive-services/custom-vision-service/home) | The Custom Vision service allows you to build custom image classifiers. |
| [Face](https://docs.microsoft.com/azure/cognitive-services/face/) | The Face service provides access to advanced face algorithms, enabling face attribute detection and recognition. |
| [Form Recognizer](https://docs.microsoft.com/azure/cognitive-services/form-recognizer/) (preview) | Form Recognizer identifies and extracts key-value pairs and table data from form documents; then outputs structured data including the relationships in the original file. |
| [Ink Recognizer](https://docs.microsoft.com/azure/cognitive-services/ink-recognizer/) (preview) | Ink Recognizer allows you to recognize and analyze digital ink stroke data, shapes and handwritten content, and output a document structure with all recognized entities. |
| [Video Indexer](https://docs.microsoft.com/azure/cognitive-services/video-indexer/video-indexer-overview) | Video Indexer enables you to extract insights from your videos. |

### Speech APIs

| Service name | Service description |
| --- | --- |
| [Speech](https://docs.microsoft.com/azure/cognitive-services/speech-service/) | Speech service adds speech-enabled features to applications. |
| [Speaker Recognition](https://docs.microsoft.com/azure/cognitive-services/speaker-recognition/home "Speaker Recognition API") (preview) | The Speaker Recognition API provides algorithms for Speaker Identification and verification. |
| [Bing Speech](https://docs.microsoft.com/azure/cognitive-services/speech/home) (retiring) | The Bing Speech API provides you with an easy way to create speech-enabled features in your applications. |
| [Translator speech](https://docs.microsoft.com/azure/cognitive-services/translator-speech/) (retiring) | Translator speech is a machine translation service. |

### Language APIs

| Service name | Service description |
| --- | -- |
| [Language Understanding (LUIS)](https://docs.microsoft.com/azure/cognitive-services/luis/) | The Language Understanding service (LUIS) allows your application to understand what a person wants in their own words. |
| [QnA Maker](https://docs.microsoft.com/azure/cognitive-services/qnamaker/index "QnA Maker") | QnA Maker allows you to build a question and answer service from your semi-structured content. |
| [Text Analytics](https://docs.microsoft.com/azure/cognitive-services/text-analytics/) | Text Analytics provides natural language processing over raw text for sentiment analysis, key phrase extraction and language detection. |
| [Translator](https://docs.microsoft.com/azure/cognitive-services/translator/) | Translator provides machine-based text translation in near real-time. |

### Decision APIs

| Service name | Service description |
| --- | --- |
| [Anomaly Detector](https://docs.microsoft.com/azure/cognitive-services/anomaly-detector/) (preview) | Anomaly Detector allows you to monitor and detect abnormalities in your time series data. |
| [Content Moderator](https://docs.microsoft.com/azure/cognitive-services/content-moderator/overview "Content Moderator") | Content Moderator provides monitoring for possible offensive, undesirable, and risky content. |
| [Personalizer](https://docs.microsoft.com/azure/cognitive-services/personalizer/) | Personalizer allows you to choose the best experience to show to your users, learning from their real-time behavior. |

### Supported cultural languages

Cognitive Services supports a wide range of cultural languages at the service level. You can find the language availability for each API in the [supported languages list](https://docs.microsoft.com/azure/cognitive-services/language-support).

### Securing resources

Azure Cognitive Services provides a layered security model, including [authentication](https://docs.microsoft.com/azure/cognitive-services/authentication) via Azure Active Directory credentials, a valid resource key, and [Azure Virtual Network](https://docs.microsoft.com/azure/cognitive-services/cognitive-services-virtual-networks).

### Container support

Cognitive Services provides containers for deployment in the Azure cloud or on-premises. Learn more about [Cognitive Services containers](https://docs.microsoft.com/azure/cognitive-services/cognitive-services-container-support).

<!-- docsTest:ignore "HIPAA BAA" "CSA STAR" -->

### Certifications and compliance

Cognitive Services has been awarded certifications such as CSA STAR certification, FedRAMP Moderate, and HIPAA BAA.

You can [download](https://gallery.technet.microsoft.com/Overview-of-Azure-c1be3942) certifications for your own audits and security reviews.

To understand privacy and data management, go to the [Microsoft Trust Center](https://servicetrust.microsoft.com/).

## How are Cognitive Services and Azure Machine Learning similar?

Both have the end-goal of applying AI to enhance business operations, though how each provides this in the respective offerings is different. Generally, the audiences are different:

- Cognitive Services are for developers without machine-learning experience.
- Azure Machine Learning is tailored for data scientists.

## How is a cognitive service different from machine learning?

A cognitive service provides a trained model for you. This brings data and an algorithm together, available from a REST API or SDK. You can implement this service within minutes, depending on your scenario. A cognitive service provides answers to general problems such as key phrases in text or item identification in images.

Machine learning is a process that generally requires a longer period of time to implement successfully. This time is spent on data collection, cleaning, transformation, algorithm selection, model training, and deployment to get to the same level of functionality provided by a cognitive service. With machine learning, it is possible to provide answers to highly specialized and/or specific problems. Machine learning problems require familiarity with the specific subject matter and data of the problem under consideration, as well as expertise

## Next steps

- Learn more about [Cognitive Services](https://docs.microsoft.com/azure/cognitive-services/)
- Find [best practices for AI architectures](https://docs.microsoft.com/azure/architecture/solution-ideas/articles/ai-at-the-edge)
