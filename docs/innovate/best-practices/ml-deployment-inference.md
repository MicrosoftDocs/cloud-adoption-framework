---
title: Machine learning inference during deployment
description: When deploying your AI model during production, you need to understand how it will make predictions.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/07/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Machine learning inference during deployment

When deploying your AI model during production, you need to consider how it will make predictions. The two main processes for AI models are:

- **Batch inference:** An asynchronous process that bases its predictions on a batch of observations. The predictions are stored as files or in a database for end users or business applications.

- **Real-time (or interactive) inference**: Frees the model to make predictions any time and trigger an immediate response. This pattern can be used to analyze streaming and interactive application data.

Consider the following questions to evaluate your model, compare the two processes, and select the one that suits your model:

- How often should predictions be generated?
- How soon are the results needed?
- Should predictions be generated individually, in small batches, or in large batches?
- Is latency to be expected from the model?
- How much compute power is needed to execute the model?
- Are there operational implications and costs to maintain the model?

The decision tree below can help you to determine which deployment model is best fits your use case.

![A diagram of the real-time or batch inference decision tree.](media/inference-decision-tree.png)

## Batch inference

Batch inference, sometimes called offline inference, is a less complex inference process that helps models to run in timed intervals and business applications to store predictions.

Consider the following best practices for batch inference:

- **Trigger batch scoring:** Use Azure Machine Learning pipelines and the **ParallelRunStep** feature in Azure Machine Learning to set up a schedule or event-based automation. For further guidance, see [how to do batch inference using Azure Machine Learning ParallelRunStep](https://channel9.msdn.com/Shows/AI-Show/How-to-do-Batch-Inference-using-AML-ParallelRunStep).

- **Compute options for batch inference:** Since batch inference process don't run continuously, it's recommended to automatically start, stop, and scale reusable clusters that can handle a range of workloads. Different models require different environments, your solution needs to be able to deploy a specific environment and remove it when inference is over for the compute to be available for the next model. See the decision tree below to identify the right compute instance for your model.

![A diagram of the compute decision tree.](media/compute-decision-tree.png)

- **Implement batch inference:** Azure supports multiple features for batch inference. One feature is **ParallelRunStep** in Azure Machine Learning, which allows customers to gain insights from terabytes of structured or unstructured data stored in Azure. ParallelRunStep provides out-of-the-box parallelism and works within Azure Machine Learning pipelines.

- **Batch inference challenges:** While batch inference is a simpler way to use and deploy your model in production, it does present select challenges:

  - Depending on the frequency at which inference runs, the data produced could be irrelevant by the time it's accessed.
  
  - A variation of the cold-start problem; results might not be available for new data. For example, if a new user creates and account and starts shopping with a retail recommendation system, product recommendations won't be available until after the next batch inference run. If this is an obstacle for your use case, consider real-time inference.
  
  - Multiregional deployment and high availability aren't critical concerns in a batch inference scenario. The model doesn't need to be deployed regionally, and the data store might need to be deployed with a high-availability strategy in many locations. This will normally follow the application HA design and strategy.

**More information:**

- [Build an Azure Machine Learning pipeline for batch scoring](/azure/machine-learning/tutorial-pipeline-batch-scoring-classification)
- [Run batch prediction using Azure Machine Learning designer](/azure/machine-learning/how-to-run-batch-predictions-designer)
- [Batch inference in Azure Machine Learning](https://techcommunity.microsoft.com/t5/azure-ai/batch-inference-in-azure-machine-learning/ba-p/1417010#:~:text=%20Batch%20Inference%20in%20Azure%20Machine%20Learning%20,Learning%20Pipelines.%20ParallelRunStep%20is%20available%20through...%20More%20)

## Real-time inference

Real-time or interactive inference is architecture where model inference can be triggered any time, and an immediate response is expected. This pattern can be used to analyze streaming data, interactive application data, and more. This mode allows you to take advantage of your machine learning model in real time and resolves the cold-start problem outlined above in batch inference.

There are a number of considerations and best practices if real-time inference is the right model for your model:

- **Challenges of real-time inference:** Real-time inference is a more complex architecture for using your model due to latency and performance requirements. Typically a system may need to respond in 100 milliseconds or less and during that time, the system needs to retrieve the data, perform inference, validate and store the model results, run any business logic required, and return the results to the system or application.

- **Compute options for real-time inference:** The best way to implement real-time inference is to deploy the model in a container form to Docker or Kubernetes cluster and expose it as a web-service with rest API. In this way, the model will be executed in its own isolated environment and can be managed as any other web-services in the environment. Docker/Kubernetes capabilities can be used then for management, monitoring, scaling, and so on. This can then be deployed on premise, in the cloud or on the edge. See the Compute Decision Tree diagram for the compute decision tree for real-time inference.

- **Multiregional deployment and high availability**: In real-time inference scenarios, regional deployment and high availability architectures need to be considered as latency and performance of the model will be one of the critical issues to resolve. It is recommended that in multiregional deployments to locate the model as close as possible to the consumption point will reduce latency. It is recommended that the model and supporting infrastructure follows the business application HA and DR principles and strategy.

## Many-models scenario

Sometimes, a single model may not be able to capture the complex nature of real-world problems, such as predicting the sales of a supermarket, where the customers’ behavior may significantly vary depending on the demography, brand, SKUs, and other features.  Or, building predictive maintenance of smart meters, which may vary significantly depending on the regions.  In such cases, having many models to capture the regional based or store level relationship may yield in better accuracy than a single model.  However, this assumes that there is sufficient data available to model such level of granularity.

At a high level, we can think of a many-models scenario in three stages: data source, data science, and many models.

![A diagram of the many-models scenario.](media/many-models-scenario.png)

**Data source:** In the data source stage, it's important to group your data into various segments without having too many cardinalities.  Features like product ID or barcode shouldn't be considered the main partition, as this will result in too many segments and might not produce meaningful models. Features such as brand, SKU, or locality could be more fitting options.  It is also important to homogenize the data by removing anomalies that would skew data distribution.

**Data science:** In the data science stage, several experiments run parallel to each data partition. This is a typically iterative process where models generated by the experiments are evaluated to find the best model.  

**Many models:** The best models for each segment or category are registered in the model registry. It is recommended to give meaningful names to the models that would make it easier to identify for inference. It's recommended to use tagging where it's necessary to group the model into specific categories.  

## Batch inference for many models

In batch inference for many models, predictions typically occur in a recurring scheduled manner and can handle large volumes of data running in parallel. The interesting thing to note here, is that unlike the single model scenario, many models inference at the same time, it's therefore important that the correct models are selected.

The diagram below shows the reference pattern for many-models batch inference.

![A diagram of the reference pattern for many-models batch inference.](media/many-models-batch-inference.png)

The core part of the pattern is the ability to handle many observations per model, as well as being able to run multiple models simultaneously to achieve a highly scalable inference solution that can handle large volumes of data. Many models can also be split into multiple categories to achieve hierarchical model inference, with each category having its own inference storage, such as an Azure Data Lake.  When implementing this pattern, one needs to strike the right balance between the horizontal and vertical scaling of the models, as this would have implications on the cost and performance.  Running too many model instances in parallel, may increase the performance but will have an impact on the cost and likewise, too few instances with high spec nodes may be more cost effective, but may run into scaling issues.

## Real-time inference for many models

In the many models real-time inference requires relatively low latency, and on-demand request, typically via a REST endpoint.  This is useful when there are external applications or services that require a standard interface to interact with the model, typically via the REST interface with JSON payload.

![A diagram of many-models real-time inference.](media/many-models-real-time-inference.png)

The core part of this pattern is the ability to discover the list of services with associated metadata, through the service discovery service, this can be implemented as an Azure Function.  This enables the clients to identify and obtain relevant details of service, which can be invoked via a secure REST URI.  A JSON payload would send to the service, that would invoke the relevant model, and provide a JSON response back to the client.

Each service (AKS) is stateless microservice, therefore can handle multiple requests simultaneously, limiting to the physical VM resource constraint.  A service can deploy multiple models, depending on the choice of groupings.  It is recommended to use homogeneous grouping, such as category, SKU, etc.  The mapping between the service request and model selection for a given service needs to be baked into the inference logic, typically via the score script.  If the size of models is relatively small (few MB), it's recommended to load them in memory for performance reasons, otherwise each model can dynamically be loaded as per request.