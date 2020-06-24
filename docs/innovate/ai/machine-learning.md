---
title: "Machine Learning"
description: These checklists and resources can help you plan your application development and deployment.
author: JanetCThomas
ms.author: janet
ms.date: 06/24/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Machine Learning

Infusing AI into an application can be difficult and time-consuming. Until recently, you needed both a deep understanding of machine learning and months of development to acquire data, train models, and deploy them at scale. Even then, success was not guaranteed. The path was filled with blockers, gotchas, and pitfalls causing teams to fail to realize value from their AI investments.  

Microsoft Azure Cognitive Services remove these challenges and are designed to be productive, enterprise ready, and trusted. They make it possible for you to build on the latest breakthroughs in AI without building and deploying your own models; instead you can deploy AI models using just a few simple lines of code so that even without a large data science team, you can quickly create applications that see, hear, speak, understand, and even begin to reason. The Cognitive Services portfolio is growing fast, and services are currently grouped into five categories: Vision, Speech, Language, Decision, and Web Search.

Common scenarios for conversational AI or chatbot solutions include:

- Predictive Maintenance  
- Inventory Management
- Fraud Detection
- Demand Forecasting
- Intelligent Recommendations
- Sales Forecasting

As you get started, the checklist and resources below will help you plan your application development and deployment.

- Are you familiar with the multitude of capabilities and services offered within Azure Cognitive Services, and which ones in particular you will be using?
- Determine whether or not you have custom data with which you want to train and customize these models. There are Cognitive Services that are customizable.
- There are several ways to use Azure Cognitive Services. Explore the quickstart tutorials for getting up and running for both SDK and REST APIs. Note: The Cognitive Services SDKs are available for many popular dev languages, including C#, Python, Java, JavaScript and Go.
- Determine if you will need to deploy these Cognitive Services in containers.

## Checklist

**Get started by first familiarize yourself with Azure Machine Learning**, then choose which experience to begin with. You can follow along steps to use a Jupyter notebook with Python, the visual drag and drop experience, automated ML.

- [Azure Machine Learning product page](https://azure.microsoft.com/services/machine-learning/#documentation)
- [Create your first ML experiment with a Jupyter notebook with Python](https://docs.microsoft.com/azure/machine-learning/tutorial-1st-experiment-sdk-setup)
- [Visual Drag and drop experiments](https://docs.microsoft.com/azure/machine-learning/tutorial-designer-automobile-price-train-score)
- [Use the automated ML UI](https://docs.microsoft.com/azure/machine-learning/tutorial-first-experiment-automated-ml)
- [Configure your dev environment](https://docs.microsoft.com/azure/machine-learning/how-to-configure-environment)

**Experiment with more advanced tutorials** to predict taxi fees, classify images, and build a pipeline for batch scoring

- [Use AutomatedML to Predict taxi fees](https://docs.microsoft.com/azure/machine-learning/tutorial-auto-train-models)
- [Classify images with scikit-learn](https://docs.microsoft.com/azure/machine-learning/tutorial-train-models-with-aml)
- [Build an Azure Machine Learning pipeline for batch scoring](https://docs.microsoft.com/azure/machine-learning/tutorial-pipeline-batch-scoring-classification)

**Follow along with video tutorials** to learn more about the benefits of Azure Machine Learning, including no-code model building, MLOps, ONNX Runtime, model interpretability and transparency and more.

- [What's new with AML](https://channel9.msdn.com/Shows/AI-Show/Allup-Azure-ML)
- [Use automated machine learning to build models](https://aka.ms/automlvideo)
- [Build zero-code models with Azure Machine Learning designer](https://aka.ms/studioanddesigner)
- [MLOps for managing the end-to-end lifecycle](https://aka.ms/mlopsvideo)
- [Incorporating ONNX Runtime into your models](https://www.youtube.com/watch?v=qy7X2JGLUC4)
- [Model interpretability and transparency](https://aka.ms/azuremlinterpret)
- [Building models with R](https://aka.ms/Rmodels)

**[Review reference architectures for AI solutions](https://docs.microsoft.com/azure/architecture/browse/#ai--machine-learning)**

## Next step

[AI applications](./ai-applications.md)
