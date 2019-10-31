---
title: "Cloud innovation: Predict and influence"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Introduction to Cloud innovation - Predict and influence
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Predict and influence

There are two classes of applications in the digital economy: Historical and Predictive. Many customer needs can be met solely by using historical data, including near real-time data. Most solutions focus on primarily on aggregating data, in the moment. They then process and share that data back to the customer, in the form of a digital or ambient experience.

As predictive modeling becomes more cost effective and readily available, customer demand forward-looking experiences that lead to better decisions and actions. However, that demand doesn't always have to lead to a predictive solution. In most scenarios, a historical view can provide enough data to empower the customer to make a decision on their own.

Unfortunately, customers have a myopic view that leads to decisions based on their immediate surroundings and sphere of influence. As options and decision grow in numbers and impact, that myopic view may not lead to the customer's need being met. At the same time, as a hypothesis is proven at scale, the company providing the solution can see across thousands or millions of customer decisions. It's possible to see patterns and the impacts of those patterns. Predictive capability is a wise investment, when an understanding of those patterns is required to make decisions which meet customer needs.

## Examples of predictions and influence

Use of data to make predictions can be seen in various applications and ambient experiences.

- **eCommerce:** Suggested items is an example of prediction. Based on what others have purchased together, the website can suggest products that may be worth adding to your cart.
- **Adjusted reality:** IoT offers more advance examples. One device on an assembly line detects a rise in a machines temperature. A cloud-based predictive model determines how to respond. Based on that prediction, another device is instructed to slow the assembly line until the machine can cool.
- **Consumer products:** Cell phones, smart homes, even your car all contain some degree of predictive capabilities by suggesting activities based on factors like location or time of day. When the prediction and the initial hypothesis are aligned, those predictions influence your behaviors. When both become very mature, the prediction leads to action, such as a self-driving car.

## Developing predictive capabilities

Solutions that consistently provide accurate predictive capabilities commonly include five core characteristics: data, insights, patterns, predictions, and interactions. Each is required to develop predictive capabilities. Like all great innovations, the development of predictive capabilities will require a [commitment to iteration](./index.md#commitment-to-iteration). In each iteration, one or more of the following characteristics would be matured to validate increasingly complex customer hypotheses.

![Steps to predictive capabilities](../../_images/innovate/predict-and-influence.png)

> [!CAUTION]
> If the customer hypothesis developed from the [build with customer empathy](./build.md) article includes predictive capabilities, this article may be applicable. But, predictive capabilities require significant investment of time and energy. When predictive capabilities are [technical spikes](./build.md#reduce-complexity-and-delay-technical-spikes), as opposed to a source of achievable customer value, then it is suggested to delay predictions until the customer hypothesis have been validated at scale.

## Data

The easiest of the characteristics above is data. Each of the prior disciplines for developing digital inventions will generate data. That data can all contribute to the development of predictions. For more guidance on ways to get data into a predictive solution, see the articles on [democratizing data](./data.md) or [interacting with devices](./devices.md).

A number of data sources can be used to deliver predictive capabilities:

## Insights

Subject matter experts leverage data about customer needs and behaviors to develop basic business insights from a study of the raw data. Those insights can pinpoint occurrences of the desired customer behaviors (or alternative undesirable results). During iterations on the predictions, these insights can aid in identifying potential correlations, which could have a causal effect on positive outcomes. For guidance on enabling subject matter experts to develop insights, see the article on [democratizing data](./data.md).

## Patterns

Human's inherently struggle with the detection of patterns across large volumes of data. Computers were designed for that purpose. Machine learning accelerates that purpose through the detection of patterns across a large amount of data, referred to as a machine learning model. Those patterns are then applied, through machine learning algorithms, to predict what will happen when a new set of data points is entered into the algorithms.

Using insights as a starting point, machine learning trains and applies predictive models to the data to capitalize on the patterns in the data. Through multiple iterations of training, testing, and adoption those models and algorithms can accurately predict future outcomes.

[Azure Machine Learning service](https://docs.microsoft.com/azure/machine-learning/service/overview-what-is-azure-ml) is the cloud-native tool in Azure for building and training models based on your data. This tool also includes a [workflow for accelerating the development of machine learning algorithms](https://docs.microsoft.com/azure/machine-learning/service/concept-azure-machine-learning-architecture). This workflow can be used to develop algorithms using the visual interface or Python.

For more robust machine learning models, [ML services in Azure HDInsight](https://docs.microsoft.com/azure/hdinsight/r-server/r-server-overview) provides a machine learning platform built on Apache Hadoop clusters. This approach allows for more granular control of the underlying clusters, storage, and compute nodes. Leveraging Azure HDInsight also provides more advance integration through tools like ScaleR and SparkR to create predictions based on integrated and ingested data, even working with data from a stream. The [flight delay prediction solution](https://docs.microsoft.com/azure/hdinsight/hdinsight-hadoop-r-scaler-sparkr) demonstrates each of these advanced capabilities to predict flight delays based on weather conditions. The HDInsight solution also allows for enterprise controls, such as data security, network access, and performance monitoring to operationalize patterns.

## Predictions

Once a pattern has been built and trained, it can be applied by using APIs, which can make predictions during the delivery of a digital experience. Most of these APIs are built from a well-trained model based on a pattern within your data. But, as more customers deploy common workloads to the cloud, cloud providers are able to provide common prediction APIs to allow for faster adoption of predictions.

[Azure Cognitive Services](https://docs.microsoft.com/azure/cognitive-services) is an example of a predictive API build by a cloud vendor. This service includes predictive APIs for content moderation, anomaly detection, or suggestions to personalize content. These APIs are ready to use based on common content patterns, which Microsoft has used to train models. Each of those APIs make predictions based on data you feed into the API.

[Azure Machine Learning service](https://docs.microsoft.com/azure/machine-learning) allows for the deployment of custom-built algorithms, which you can create and train solely based on your own data. Learn more about deploying predictions with Azure Machine Learning, [here](https://docs.microsoft.com/azure/machine-learning/service/how-to-deploy-and-where).

The article on [setting up HDInsight clusters](https://docs.microsoft.com/azure/hdinsight/hdinsight-hadoop-provision-linux-clusters) discusses the processes for exposing predictions developed for ML Services on Azure HDInsight.

## Interactions

Once a prediction is made available through an API, the prediction can be used influence customer behaviors. That influence comes in the form of interactions. An interaction with a machine learning algorithm happens within your other digital or ambient experiences. As data is collected via the application or experience, that data is run through the machine learning algorithms. When the algorithm predicts an outcome, that prediction can be shared back with the customer through the existing experience.

Learn more about the interactions within an [adjusted reality solution](./devices.md#adjusted-reality), for more details on creating an interaction within an ambient experience.

## Next steps

Based on the knowledge gained regarding the [Disciplines of invention](./invention.md) within the [innovate methodology](./index.md) you know have the technical tools required to [build with empathy](./build.md).

> [!div class="nextstepaction"]
> [Build with empathy](./build.md)
