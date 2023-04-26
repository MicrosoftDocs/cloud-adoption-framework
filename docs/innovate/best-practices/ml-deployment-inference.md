---
title: Machine learning inference during deployment
description: Understand how your AI model makes predictions while it's being deployed in production.
author: DonnaForlin
ms.author: martinek
ms.date: 01/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: think-tank
---

# Machine learning (ML) inference during deployment

Deploying machine learning models in production can be a complex process, but it's crucial for organizations that want to use artificial intelligence (AI) to enhance their operations. In this article, we'll explore some best practices for deploying ML models in a production environments using Azure Machine Learning.

## Best Practices

1. **Choose the Right Deployment Method:**
One of the first decisions you'll need to make is how to deploy your ML model. There are two main deployment methods to choose from; real-time, and  inference. Each method has its own advantages and disadvantages, so it's important to choose the one that best suits your organization's needs.

    - Real-time (or online) inference involves processing input data as it is received, often with a very low latency requirement. This is important for applications that require immediate responses, such as fraud detection, speech recognition, or recommendation systems. Real-time inference can be more complex and expensive to implement than batch inference because it requires a faster and more reliable infrastructure to process incoming requests and respond quickly.
    - Batch (or offline) processing involves processing a large batch of input data all at once, rather than processing each input data point individually in real time. Batch inference is well-suited for scenarios where a large volume of data needs to be processed efficiently and where the response time is not critical. For example, batch inference can be used for processing a large dataset of images, where predictions are made on all the images in the dataset at once. Batch inference is often less expensive and more efficient than real-time inference.

    For more details, [Deployment Methods](#deployment-methods)

2. **Ensure Consistency:**
Consistency is key when deploying ML models in production. It's important to ensure that your model is deployed consistently across different environments, such as development, staging, and production. This can be achieved through the use of containerization or virtualization technologies such as [Azure Machine Learning environments](https://learn.microsoft.com/en-us/azure/machine-learning/concept-environments?view=azureml-api-2) that enable you to encapsulate your environment.   

3. **Monitor Performance:**
Once your model is deployed in production, it's important to monitor its performance to ensure that it's working as expected. You should track metrics such as accuracy, latency, and throughput, and set up alerts to notify you when performance falls below acceptable levels.  Use the [built-in monitoring capabilities of managed endpoints](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-monitor-online-endpoints?view=azureml-api-2) and the integration with Azure Application Insights to view metrics and create alerts.  
[!IMPORTANT]
Does batch endpoints support monitoring?  If not, how do we monitor batch endpoints?

4. **Implement Security Measures:**
Deploying ML models in production can pose security risks, so it's important to implement security measures to protect your data and systems. This includes setting up authentication and access controls, encrypting data in transit and at rest, and monitoring for suspicious activity. 

5. **Have a Plan for Updates:**
ML models are not static, and they will need to be updated over time as new data or new algorithms become available. It's important to have a plan in place for updating your model, including a process for testing and validating the updated model before deploying it in production.  Blue/green deployment is a common strategy for updating ML models in production. This involves deploying the updated model to a new environment, testing it, and then switching over to the new model once it's been validated. This ensures that your customers are not impacted by any issues with the updated model.  See [blue/green deployments using AzureML online endpoints](https://learn.microsoft.com/en-us/azure/machine-learning/concept-endpoints?view=azureml-api-2#native-bluegreen-deployment)

Deploying machine learning models in production can be challenging, but following these best practices can help ensure a smooth and successful deployment. By choosing the right deployment method, ensuring consistency, monitoring performance, implementing security measures, and having a plan for updates, your organization can use AI to improve its operations and achieve its goals. 


## [Deployment Methods](#deployment-methods)

Consider the following questions to evaluate your model, compare the two processes, and select the one that suits your model:

- How often should predictions be generated?
- How soon are the results needed?
- Are the predictions stored or used immediately?
- Should predictions be generated individually, in small batches, or in large batches?
- Is latency to be expected from the model?
- How much compute power is needed to execute the model?
- Are there operational implications and costs to maintain the model?
- How is the prediction triggered?  Is it event-based or scheduled?

The following decision tree can help you to determine which deployment model best fits your use case:

[![A diagram of the real-time or batch inference decision tree.](./media/inference-decision-tree.png)](./media/inference-decision-tree.png#lightbox)

### Batch inference

Batch inference, sometimes called offline inference, is a simpler inference process that helps models to run in timed intervals or triggers, and business applications to store predictions.

Consider the following best practices for batch inference:

- **Triggered batch scoring:** Use [Azure Machine Learning batch endpoints](https://learn.microsoft.com/en-us/azure/machine-learning/concept-endpoints?view=azureml-api-2#what-are-batch-endpoints) to create a HTTPS endpoint that clients can call to trigger a batch scoring job from either scheduled or event-based automation. The automation could be part of a larger data processing pipeline (see [Batch Integration section below](#batch-integration), or it could be a simple script that runs on a schedule.  The script can be written in any language that supports HTTP requests, such as Python, C#, or Javascript.  Follow the How-to guide for [Use batch endpoints for batch scoring](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-use-batch-endpoint?view=azureml-api-2&tabs=azure-cli) and learn more about the process.  

- **Compute options for batch inference:** Since batch inference processes don't usually run continuously, it's recommended to automatically start, stop, and scale reusable clusters that can handle a range of workloads. Different models require different environments, and your solution needs to be able to deploy a specific environment and remove it when inference is over for the compute to be available for the next model. See the following decision tree to identify the right compute instance for your model:

[!IMPORTANT]
Updated diagram needed
  [![Diagram of the compute decision tree.](./media/compute-decision-tree.png)](./media/compute-decision-tree.png#lightbox)


[!IMPORTANT]
Sizing of the compute nodes used for batch inference is important.  If the nodes are too small, the inference job will take longer to complete.  If the nodes are too large, the job will be more expensive.  Testing and monitoring are essential to determine the right size for your model.


- **Implement batch inference:** Azure Machine Learning supports multiple features to enabling scalable processing for improved performance. The number of compute nodes and maximum concurrency parameters are defined during the batch endpoint deployment in Azure Machine Learning, which can by overridden per job to allow customers runtime flexibility and provide out-of-the-box parallelism that works with both tabular and file based inferencing.  If possible, use MLflow for batch inference using batch endpoints, as this means that you don't have to provide a scoring script or an environment for you deployment.

- **Batch inference challenges:** Whilst batch inference is a simpler way to use and deploy your model in production, it does present it's own set of challenges:

  - Depending on the frequency at which inference runs, the data produced could be irrelevant by the time it's accessed.  

  - A variation of the cold-start problem; results might not be available for new data. For example, if a new user creates and account and starts shopping with a retail recommendation system, product recommendations won't be available until after the next batch inference run. If this is an obstacle for your use case, consider real-time inference.

  - Deploying to many regions and high availability aren't critical concerns in a batch inference scenario. The model doesn't need to be deployed regionally, however the data store might need to be deployed with a high-availability strategy in many locations. This will normally follow the application HA design and strategy.

  - How to deal with data generated during a batch inference that partially fails.  For example, if a batch inference job is triggered by a scheduled pipeline, and the pipeline fails, the data generated by the batch inference job will be incomplete.  This is a common problem with batch inference, and there are a number of ways to deal with it.  One approach is to use a staging area for the data, and only move the data to the final destination once the batch inference job has completed successfully.  Another approach that incorporates logic in the scoring script is to maintain a record (transaction) of each file processed and compare the input file list to avoid duplication.  The latter approach is more complex, but it does provide the ability to customise the failure logic if the batch inference job fails.

- **Security requirements:** Use authentication and authorization to control access to the batch endpoint for enhanced security.  
  - A batch endpoint with ingress protection wil only accept scoring requests from hosts inside a virtual network but not from the public internet. A batch endpoint that is created in a private-link enabled workspace will have ingress protection. 
  - Use Azure Active Directory Tokens for authentication.
  - Use SSL encryption on the endpoint.  This enabled by default for Azure ML endpoint invocation
  - Data security considerations.  Whilst batch endpoints ensure that only authorized users are able to invoke batch deployments, other credentials may be used to read the underlying data.  Use the table contained in [Security considerations when reading data](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-access-data-batch-endpoints-jobs?view=azureml-api-2&tabs=cli#security-considerations-when-reading-data) article as a reference for the different data stores and the credentials that are used to access them.

- **[Batch Integration](#batch-integration):** Batch inference can be integrated with other Azure services, such as Azure Data Factory, Azure Databricks, and Azure Synapse Analytics to form part of a larger data pipeline. For example, you can use Azure Data Factory to orchestrate the batch inference process, Azure Databricks to prepare the data for batch inference, Azure Machine Learning to run the batch inference process, and finally Azure Synapse Analytics to store the subsequent predictions.  Batch endpoints support Azure Active Directory for authorization and the request made to the APIs require a proper authentication handling. Azure services such as Azure Data Factory support using a Service Principal or a Managed Identity to authenticate against Batch Endpoints.  The [Run batch endpoints from Azure Data Factory](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-use-batch-azure-data-factory?view=azureml-api-2) article contains more details.  

    Understanding how data moves through the stages of your data pipelines will play a signifcant role on the approach to batch input and output processing.  Whilst Azure data services can be accessed directly through the batch endpoint scoring script using different SDKs, it's recommended to use Azure Machine Learning registered datastores for simplicity, security, and auditability.  Where 3rd party data sources are involved, leverage a data processing engine such as Azure Data Factory, Azure Databricks, or Azure Synapse to prepare the data for batch inference and apply any post-inference processing.  

### Real-time inference

Real-time, or interactive, inference is an architecture where model inference can be triggered at any time, and an immediate response is expected. This pattern can be used to analyze streaming data, interactive application data, and more. This mode allows you to take advantage of your machine learning model in real time and resolves the cold-start problem outlined above in batch inference.

The following considerations and best practices are available if real-time inference is right for your model:

- **The challenges of real-time inference:** Latency and performance requirements make real-time inference architecture more complex for your model. A system might need to respond in 100 milliseconds or less, during which it needs to retrieve the data, perform inference, validate and store the model results, run any required business logic, and return the results to the system or application.

- **Compute options for real-time inference:** The best way to implement real-time inference is to deploy the model in an online endpoint to either a managed online endpoints or Kubernetes online endpoints.  Managed online endpoints help to deploy your ML models in a turnkey manner, leveraging CPU or GPU machines in Azure in a scalable, fully managed way.  Kubernetes online endpoint allows you to deploy models and serve online endpoints on your fully configured and managed Kubernetes cluster anywhere.  See the [Managed online endpoints vs Kubernetes online endpoints](https://learn.microsoft.com/en-us/azure/machine-learning/concept-endpoints?view=azureml-api-2#managed-online-endpoints-vs-kubernetes-online-endpoints) article for a detailed comparison. ,with CPUs or GPUs. container form to Docker or Azure Kubernetes Service (AKS) cluster and expose it as a web service with a REST API. This way, the model runs in its own isolated environment and can be managed like any other web service. Docker and AKS capabilities can then be used for management, monitoring, scaling, and more. The model can be deployed on-premises, in the cloud, or on the edge. The preceding compute decision outlines real-time inference.

- **Multiregional deployment and high availability:** Regional deployment and high availability architectures need to be considered in real-time inference scenarios, as latency and the model's performance will be critical to resolve. To reduce latency in multiregional deployments, it's recommended to locate the model as close as possible to the consumption point. The model and supporting infrastructure should follow the business' high availability and DR principles and strategy.

- **Security requirements:** Use authentication and authorization to control access to the online endpoint for enhanced security.  
  - An online endpoint with ingress protection wil only accept scoring requests from hosts inside a virtual network but not from the public internet. A batch endpoint that is created in a private-link enabled workspace will have ingress protection. 
  - Use Azure Active Directory Tokens for authentication.
  - Use SSL encryption on the endpoint.  This enabled by default for Azure ML endpoint invocation.

- **Real time Integration:** 

## Additional Considerations

### Many-models scenario

A singular model might not be able to capture the complex nature of real-world problems, such as predicting sales for a supermarket where demographics, brand, SKUs, and other features could cause customer behavior to vary significantly. Regions could cause developing predictive maintenance for smart meters to also vary significantly. Having many models for these scenarios to capture regional data or store-level relationships could produce higher accuracy than a single model. This approach assumes that enough data is available for this level of granularity.

At a high level, a many-models scenario occurs in three stages: data source, data science, and many models.

[![A diagram of a many-models scenario.](./media/many-models-scenario.png)](./media/many-models-scenario.png#lightbox)

**Data source:** It's important to segment data without too many cardinalities in the data source stage. The product ID or barcode shouldn't be factored into the main partition, as this will produce too many segments and could inhibit meaningful models. The brand, SKU, or locality could be more fitting features. It's also important to homogenize the data by removing anomalies that would skew data distribution.

**Data science:** Several experiments run parallel to each data partition in the data science stage. This is a typically iterative process where models from the experiments are evaluated to determine the best one.

**Many models:** The best models for each segment or category are registered in the model registry. Assign meaningful names to the models, which will make them more discoverable for inference. Use tagging where necessary to group the model into specific categories.

## Batch inference for many models

During batch inference for many models, predictions are typically scheduled, recurring, and they can handle large volumes of data running at the same time. Unlike in a single-model scenario, many models inference at the same time, and it's important to select the correct ones. The following diagram shows the reference pattern for many-models batch inference:

[![Diagram of the reference pattern for many-models batch inference.](./media/many-models-batch-inference.png)](./media/many-models-batch-inference.png#lightbox)

The core purpose of this pattern is to observe the model and run multiple models simultaneously to achieve a highly scalable inference solution that can handle large data volumes. To achieve hierarchical model inference, many models can be split into categories. Each category can have its own inference storage, like a data lake in Azure. When implementing this pattern, one needs to balance scaling the models horizontally and vertically, as this would impact the cost and performance. Running too many model instances might increase performance but impact the cost. Too few instances with high spec nodes might be more cost effective but could cause issues with scaling.

## Real-time inference for many models

Real-time many-models inference requires low latency and on-demand requests, typically via a REST endpoint. This is useful when external applications or services require a standard interface to interact with the model, typically via a REST interface with a JSON payload.

[![Diagram of many-models real-time inference.](./media/many-models-real-time-inference.png)](./media/many-models-real-time-inference.png#lightbox)

The core purpose of this pattern is to use the discovery service to identify a list of services and their metadata. This can be implemented as an Azure function and enables clients to obtain relevant service details of service, that can be invoked with a secure REST URI. A JSON payload be sent to the service, which would summon the relevant model and provide a JSON response back to the client.

Each service is stateless microservice that can handle multiple requests simultaneously and is limited to the physical virtual machine resource. The service can deploy multiple models if multiple groups are selected; homogeneous groupings like the category, SKU, and more are recommended for this. The mapping between the service request and model selected for a given service needs to be baked into the inference logic, typically via the score script. If the size of models is relatively small (a few megabytes), it's recommended to load them in memory for performance reasons; otherwise, each model can be loaded dynamically per request.

## Next steps

Explore the following resources to learn more about inference in Azure Machine Learning:

- [Build an Azure Machine Learning pipeline for batch scoring](/azure/machine-learning/tutorial-pipeline-batch-scoring-classification)
- [Run batch prediction using Azure Machine Learning designer](/azure/machine-learning/how-to-run-batch-predictions-designer)
- [Batch inference in Azure Machine Learning](https://techcommunity.microsoft.com/t5/azure-ai/batch-inference-in-azure-machine-learning/ba-p/1417010)
