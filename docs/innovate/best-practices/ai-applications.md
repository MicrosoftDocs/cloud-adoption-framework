---
title: What are AI applications
description: What is cognitive search?
author: JanetCThomas
ms.author: janet
ms.date: 07/02/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# What are AI applications?

On Azure, you can build intelligent apps faster using the tools and technologies of your choice and AI that’s already built-in.

- **Easily build and deploy anywhere**: Use your team’s existing skill sets and tools you know and love to build intelligent apps and deploy without a change in code. Build once, deploy anywhere: in the cloud, on premises, and to edge devices, with the confidence of global distribution to more data centers than any other provider.

- **Create an impact using an open platform**: Choose your favorite technologies, including open source. Azure supports a range of deployment options, popular stacks and languages, and a comprehensive set of data engines. Capitalize on this flexibility, plus the performance, scale, and security delivered by Microsoft technologies to build apps for any scenario.

- **Develop apps with built-in intelligence**: Building intelligent apps using Azure is easy, because no other platform brings analytics and native AI to your data wherever it lives and in the languages you use. Take advantage of a rich set of [cognitive APIs](https://azure.microsoft.com/services/cognitive-services/) to easily build new experiences into your apps for human-like intelligence.

## What are Azure Cognitive Services?

Azure Cognitive Services can simplify infusing AI into your applications and utilize the latest breakthroughs in AI using a few simple lines of code. They bring the ability to create applications that see, hear, speak, understand and even begin to bring reason into your business processes. Azure Cognitive Services provide the AI intelligence in a form that is easy to use and incorporate into your application.

Azure Cognitive Services are APIs, SDKs, and services available to help developers build intelligent applications without having direct AI or data science skills or knowledge. Azure Cognitive Services enable developers to easily add cognitive features into their applications. The goal of Azure Cognitive Services is to help developers create applications that can see, hear, speak, understand, and even begin to reason. The catalog of services within Azure Cognitive Services can be categorized into five main pillars - Vision, Speech, Language, Web Search, and Decision.

### Vision APIs

|Service Name|Service Description|
|:-----------|:------------------|
|[Computer Vision](https://docs.microsoft.com/azure/cognitive-services/computer-vision/ "Computer Vision")|The Computer Vision service provides you with access to advanced algorithms for processing images and returning information.|
|[Custom Vision Service](https://docs.microsoft.com/azure/cognitive-services/Custom-Vision-Service/home "Custom Vision Service")|The Custom Vision Service allows you to build custom image classifiers.|
|[Face](https://docs.microsoft.com/azure/cognitive-services/face/ "Face")| The Face service provides access to advanced face algorithms, enabling face attribute detection and recognition.|
|[Form Recognizer](https://docs.microsoft.com/azure/cognitive-services/form-recognizer/ "Form Recognizer") (Preview)|Form Recognizer identifies and extracts key-value pairs and table data from form documents; then outputs structured data including the relationships in the original file.|
|[Ink Recognizer](https://docs.microsoft.com/azure/cognitive-services/ink-recognizer/ "Ink Recognizer") (Preview)|Ink Recognizer allows you to recognize and analyze digital ink stroke data, shapes and handwritten content, and output a document structure with all recognized entities.|
|[Video Indexer](https://docs.microsoft.com/azure/cognitive-services/video-indexer/video-indexer-overview "Video Indexer")|Video Indexer enables you to extract insights from your video.|

### Speech APIs

|Service Name|Service Description|
|:-----------|:------------------|
|[Speech service](https://docs.microsoft.com/azure/cognitive-services/speech-service/ "Speech service")|Speech service adds speech-enabled features to applications.|
|[Speaker Recognition API](https://docs.microsoft.com/azure/cognitive-services/speaker-recognition/home "Speaker Recognition API") (Preview)|The Speaker Recognition API provides algorithms for speaker identification and verification.|
|[Bing Speech](https://docs.microsoft.com/azure/cognitive-services/speech/home "Bing Speech") (Retiring)|The Bing Speech API provides you with an easy way to create speech-enabled features in your applications.|
|[Translator Speech](https://docs.microsoft.com/azure/cognitive-services/translator-speech/ "Translator Speech") (Retiring)|Translator Speech is a machine translation service.|

### Language APIs

|Service Name|Service Description|
|:-----------|:------------------|
|[Language Understanding LUIS](https://docs.microsoft.com/azure/cognitive-services/luis/ "Language Understanding")|Language Understanding service  (LUIS) allows your application to understand what a person wants in their own words.|
|[QnA Maker](https://docs.microsoft.com/azure/cognitive-services/qnamaker/index "QnA Maker")|QnA Maker allows you to build a question and answer service from your semi-structured content.|
|[Text Analytics](https://docs.microsoft.com/azure/cognitive-services/text-analytics/ "Text Analytics")|Text Analytics provides natural language processing over raw text for sentiment analysis, key phrase extraction and language detection.|
|[Translator](https://docs.microsoft.com/azure/cognitive-services/translator/ "Translator")|Translator provides machine-based text translation in near real-time.|

### Decision APIs

|Service Name|Service Description|
|:-----------|:------------------|
|[Anomaly Detector](https://docs.microsoft.com/azure/cognitive-services/anomaly-detector/ "Anomaly Detector") (Preview)|Anomaly Detector allows you to monitor and detect abnormalities in your time series data.|
|[Content Moderator](https://docs.microsoft.com/azure/cognitive-services/content-moderator/overview "Content Moderator")|Content Moderator provides monitoring for possible offensive, undesirable, and risky content.|
|[Personalizer](https://docs.microsoft.com/azure/cognitive-services/personalizer/ "Personalizer")|Personalizer allows you to choose the best experience to show to your users, learning from their real-time behavior.|

### Supported cultural languages

Cognitive Services supports a wide range of cultural languages at the service level. You can find the language availability for each API in the [supported languages list](https://docs.microsoft.com/azure/cognitive-services/language-support).

### Securing resources

Azure Cognitive Services provides a layered security model, including [authentication](https://docs.microsoft.com/azure/cognitive-services/authentication) via Azure Active Directory credentials, a valid resource key, and [Azure Virtual Networks](https://docs.microsoft.com/azure/cognitive-services/cognitive-services-virtual-networks).

### Container support

Cognitive Services provides containers for deployment in the Azure cloud or on-premises. Learn more about [Cognitive Services Containers](https://docs.microsoft.com/azure/cognitive-services/cognitive-services-container-support).

### Certifications and compliance

Cognitive Services has been awarded certifications such as CSA STAR Certification, FedRAMP Moderate, and HIPAA BAA.

You can [download](https://gallery.technet.microsoft.com/Overview-of-Azure-c1be3942) certifications for your own audits and security reviews.

To understand privacy and data management, go to the [Trust Center](https://servicetrust.microsoft.com/).

## How are Cognitive Services and Azure Machine Learning (AML) similar?

Both have the end-goal of applying AI to enhance business operations, though how each provides this in the respective offerings is different.
Generally, the audiences are different:

- Cognitive Services are for developers without machine-learning experience.
- Azure Machine Learning is tailored for data scientists.

## How is a Cognitive Service different from machine learning?

A Cognitive Service provides a trained model for you. This brings data and an algorithm together, available from a REST API(s) or SDK. You can implement this service within minutes, depending on your scenario. A Cognitive Service provides answers to general problems such as key phrases in text or item identification in images.

Machine learning is a process that generally requires a longer period of time to implement successfully. This time is spent on data collection, cleaning, transformation, algorithm selection, model training, and deployment to get to the same level of functionality provided by a Cognitive Service. With machine learning, it is possible to provide answers to highly specialized and/or specific problems. Machine learning problems require familiarity with the specific subject matter and data of the problem under consideration, as well as expertise

## Next steps

- Learn more about [Cognitive Services](https://docs.microsoft.com/azure/cognitive-services/)
- Find [best practices for AI architectures](https://docs.microsoft.com/azure/architecture/solution-ideas/articles/ai-at-the-edge)
