---
title: Deploy machine learning models in production environments
description: Understand how your AI model makes predictions while it's being deployed in production.
author: DonnaForlin
ms.author: krbock
ms.date: 06/20/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: think-tank
---

# Deploy machine learning models in production environments

This article describes best practices for deploying machine learning models in production environments by using Azure Machine Learning. Deploying machine learning models in production is important for organizations that use AI to enhance their operations. It can be a complex process, but this article helps you understand the steps.

## Architectural considerations

- **Choose the right deployment method.** Each deployment method has advantages and disadvantages. It's important to choose the one that best suits your organization's needs. There are two main deployment methods:

  - **Real-time** (online) inference processes input data as it's received, often with a low latency requirement. Low latency is important for applications that require immediate responses, such as fraud detection, speech recognition, or recommendation systems. Real-time inference is more complex and expensive to implement than batch inference because it requires a faster and more reliable infrastructure. The underlying compute for real-time inference usually runs continuously to service requests faster.

  - **Batch** (offline) inference processes a large batch of input data at once rather than processing each input data point individually in real time. Batch inference is well suited for large data volume scenarios that need efficient processing but response time isn't critical. For example, you might use batch inference to process a large dataset of images, and the machine learning model makes predictions on all the images at once. Batch inference is less expensive and more efficient than real-time inference. The underlying compute for batch inference usually runs only during the batch job.

  Azure Machine Learning uses endpoints to deploy models in real time and batch scenarios. Endpoints provide a unified interface to invoke and manage model deployments across compute types. Managed online endpoints serve, scale, secure, and monitor your machine learning models for inference.

  For more information, see the following section in this article, [Deployment methods](#deployment-methods).

- **Ensure consistency.** It's important to deploy your model consistently across environments, such as development, staging, and production. Use containerization or virtualization technologies, such as [Azure Machine Learning environments](/azure/machine-learning/concept-environments), to provide consistency and to encapsulate your environment.

- **Monitor performance.** After your model deploys into production, you should track metrics, such as accuracy, latency, and throughput, and set up alerts to notify you when performance falls below acceptable levels. Use Application Insights and the [built-in monitoring capabilities of managed endpoints](/azure/machine-learning/how-to-monitor-online-endpoints) to view metrics and create alerts.  

- **Implement security measures.** Implement security measures to protect your data and systems. You can set up authentication and access controls, encrypt data in transit and at rest, use network security, and monitor for suspicious activity.

- **Create a plan for updates.** Machine learning models need updates as new data and new algorithms become available. It's important to have a process to test and validate the updated model before deploying it in production. Blue/green deployment is a common strategy that updates machine learning models in production. With blue/green deployment, you can update a model to a new environment, test it, and then switch to the new model after it's been validated. Blue/green deployment ensures that potential issues with the updated model don't affect your customers. For more information, see [Native blue/green deployment](/azure/machine-learning/concept-endpoints-online#native-bluegreen-deployment).

## Deployment methods

Consider the following questions to evaluate your model, compare the two deployment methods, and select the method that suits your model:

- How often should predictions be generated?
- How soon do you need the results?
- Are the predictions stored or used immediately?
- Should predictions be generated individually, in small batches, or in large batches?
- Is latency expected from the model?
- How much compute power does the model need to run?
- Are there operational implications and costs to maintain the model?
- How is the prediction triggered? Is it event-based or scheduled?

See the following decision tree to determine which deployment model best fits your use case:

[![A diagram of the real-time inference and batch inference decision tree.](./media/inference-decision-tree-v2.png)](./media/inference-decision-tree-v2.png#lightbox)

### Batch inference

Batch inference (offline inference) is a simple process that enables models to run in timed intervals or based on triggers. With batch inference, business applications can store predictions.

Consider the following best practices for batch inference:

- **Execute batch operations by using API.** Use [Azure Machine Learning batch endpoints](/azure/machine-learning/concept-endpoints) to create a durable HTTPS endpoint that triggers a batch-scoring job for scheduled or event-based data pipelines. The API can integrate with any data orchestration platform if the platform supports REST API invocation. For more information, see the Batch integration bullet point in this section or [Deploy models for scoring in batch endpoints](/azure/machine-learning/how-to-use-batch-endpoint).

- **Compute options.** Batch inference processes don't usually run continuously, so it's beneficial to automatically start, stop, and scale reusable clusters that can handle a range of workloads. Different models often require different environments. Your solution needs to deploy a specific environment and remove it when inference is complete. Automation makes the compute available for the next model. Use [low-priority virtual machines](/azure/machine-learning/how-to-use-low-priority-batch) for your compute nodes to reduce cost.

  > [!IMPORTANT]
  > The size of the compute nodes is important. If the nodes are too small, the batch inference job takes longer. If the nodes are too large, the job is more expensive. Test and monitor compute nodes to determine the right size for your model.

- **Consider scalability needs.** For improved performance, Azure Machine Learning supports features that enable scalable processing. The number of compute nodes and maximum concurrency parameters are defined during the batch endpoint deployment in Azure Machine Learning. You can override the parameters for each job, which provides customers runtime flexibility and out-of-the-box parallelism. These features work with tabular and file-based inference.

- **Batch inference challenges.** Batch inference is a simpler way to use and deploy your model in production, but it does present its own set of challenges:

  - Depending on the frequency that the inference runs, the prediction that's generated might be irrelevant by the time it's accessed.  

  - Deploying to many regions and designing the solution for high availability aren't critical concerns in a batch inference scenario because the model isn't deployed regionally. But the data store might need to be deployed with a high-availability strategy in many locations. The deployment should follow the application high-availability design and strategy.

  - Data that's generated during a batch inference might partially fail. For example, if a scheduled pipeline triggers a batch inference job and the pipeline fails, the data that's generated by the batch inference job might be incomplete. Partial restarts are a common problem with batch inference. One solution is to use a staging area for the data, and only move the data to the final destination after the batch inference job is successfully complete. Another solution is to maintain a record, or transaction, of each file that’s processed, and compare that record to the input file list to avoid duplication. This method incorporates logic in the scoring script. This solution is more complex, but you can customize the failure logic if the batch inference job fails.

- **Security requirements.** Use authentication and authorization to control access to the batch endpoint for enhanced security.  
  - A batch endpoint with ingress protection only accepts scoring requests from hosts inside a virtual network. It doesn't accept scoring requests from the public internet. A batch endpoint that's created in a private link-enabled workspace has ingress protection. For more information, see [Network isolation in batch endpoints](/azure/machine-learning/how-to-secure-batch-endpoint).
  - Use Azure Active Directory (Azure AD) tokens for authentication.
  - Use SSL encryption on the endpoint, which is enabled by default for Azure Machine Learning endpoint invocation.
  - Batch endpoints ensure that only authorized users can invoke batch deployments, but individuals can use other credentials to read the underlying data. For a reference of the data stores and the credentials to access them, see the [data access table](/azure/machine-learning/how-to-access-data-batch-endpoints-jobs#security-considerations-when-reading-data).

- **Batch integration.** Azure Machine Learning batch endpoints use an open API. Batch inference can integrate with other Azure services, such as Azure Data Factory, Azure Databricks, and Azure Synapse Analytics to form part of a larger data pipeline. For example, you can use:

  1. Data Factory to orchestrate the batch inference process.
  1. Azure Databricks to prepare the data for batch inference.
  1. Azure Machine Learning to run the batch inference process.
  1. Azure Synapse Analytics to store the subsequent predictions.

  Batch endpoints support Azure AD for authorization. The request to the API requires proper authentication. Azure services, such as Data Factory, support using a service principal or a managed identity to authenticate against batch endpoints. For more information, see [Run batch endpoints from Data Factory](/azure/machine-learning/how-to-use-batch-azure-data-factory).  

  Understanding how data moves through the stages of your data pipelines play a significant role in the approach to batch input and output processing. You can access Azure data services directly through the batch endpoint scoring script by using SDKs, but using Azure Machine Learning registered datastores is more simple, secure, and auditable. For third-party data sources, use a data processing engine, such as Data Factory, Azure Databricks, or Azure Synapse Analytics, to prepare the data for batch inference and apply post-inference processing.  

- **MLflow.** Use the open-source framework, [MLflow](/azure/machine-learning/concept-mlflow), during model development. Azure Machine Learning supports no-code deployment of models that you create and log with MLflow. When you [deploy your MLflow model to a batch endpoint](/azure/machine-learning/how-to-mlflow-batch), you don't need to indicate a scoring script or an environment.

### Real-time inference

Real-time inference (interactive inference) is a process that enables you to trigger model inference at any time and provides an immediate response. Use this process to analyze streaming data or interactive application data.

Consider the following best practices for real-time inference:

- **Compute options.** The best method to implement real-time inference is to deploy the model in an online endpoint to a managed online endpoint or a Kubernetes online endpoint. Managed online endpoints deploy your machine learning models immediately by using CPU or GPU machines in Azure. This method is scalable and fully managed. Kubernetes online endpoints deploys models and serves online endpoints on your fully configured and managed Kubernetes cluster. For more information, see the [Managed online endpoints vs Kubernetes online endpoints](/azure/machine-learning/concept-endpoints#managed-online-endpoints-vs-kubernetes-online-endpoints).  
- **Multiregional deployment and high availability.** Regional deployment and high-availability architectures are examples of real-time inference scenarios because latency and model performance are critical. To reduce latency in multiregional deployments, locate the model as close as possible to the consumption point. For the model and the supporting infrastructure, follow the business' high-availability and disaster recovery principles and strategy.

- **Real-time inference challenges.** Latency and performance requirements make real-time inference architecture more complex for your model. A simple real-time system takes input via the HTTP request and returns a prediction.  However a complex system might need to respond in 100 milliseconds or less, during which it needs to retrieve other data, perform feature engineering, perform inference, validate and store the model results, run any required business logic, and return the results to the system or application.
  - Where possible, offload feature engineering to a low latency data store, caching service, or dedicated Feature Store.  A Feature Store is a centralized repository that enables data scientists to find and share features.  A Feature Store can ensure that the same code that is used to compute the feature values is also used for model training and inference.

- **Security requirements.** Use authentication and authorization to control access to the online endpoint for enhanced security.  
  - An online endpoint with ingress protection only accepts scoring requests from hosts inside a virtual network but not from the public internet. An online endpoint that is created in a private-link enabled workspace has ingress protection.  For more information about this topic, see [Use network isolation for managed online endpoints](/azure/machine-learning/how-to-secure-online-endpoint).
  - Use Azure AD tokens for control-plane authentication.  For data plane operations, [key-based and token-based](/azure/machine-learning/how-to-authenticate-online-endpoint) approaches are supported with the latter preferred due to having expiration on tokens.  Use Azure role-based access controls (Azure RBAC) to restrict access to retrieve the key or token for an online endpoint.
  - Use SSL encryption on the endpoint, which is enabled by default for Azure machine learning endpoint invocation.

- **Real-time integration.** Integrating real time inference with other Azure services can be simplified, given the availability of SDKs for different languages and the ability to invoke the endpoint using a REST API.  The online endpoint can be invoked as part of an application's code.  

- **MLflow.** If possible, use [MLflow with Azure Machine Learning](/azure/machine-learning/concept-mlflow) during model development.  Azure Machine Learning supports no-code deployment of models created and logged with MLflow.  When you [deploy your MLflow model to an online endpoint](/azure/machine-learning/how-to-deploy-mlflow-models-online-endpoints), you don't need to indicate a scoring script or an environment.

- **Safe rollout.** Updates to machine learning models should be deployed in a phased manner to ensure that the model is performing as expected.  Use the Azure Machine Learning Online Endpoints safe rollout feature to deploy a model to an endpoint, perform testing against the model,  and gradually increase the traffic to the new model.  Take advantage of the mirrored traffic to mirror a percentage of live traffic to the new model for extra validation. Traffic mirroring (also called shadowing) doesn't change the results returned to clients, as requests still flow 100% to the original model.  For more information about this topic, see the [Safe rollout](/azure/machine-learning/how-to-safely-rollout-online-endpoints).

## Other considerations

### ONNX

Use the [Open Neural Network Exchange (ONNX)](https://onnx.ai/) to optimize the inference of your machine learning models. It can be a challenge to fully utilize hardware capabilities when you optimize models, particularly when you use different platforms (for example, cloud/edge, CPU/GPU). You can train a new model or convert an existing model from another format to ONNX.

### Many-models scenario

A singular model might not capture the complex nature of real-world problems. For example, supermarkets have demographics, brands, SKUs, and other features that vary between regions, which makes it a challenge for a single-sales prediction model. Similarly, regional variations can pose a challenge for a smart-meter predictive maintenance model. You can use many models to capture regional data or store-level relationships to provide higher accuracy than a single model. The many-models approach assumes that enough data is available for this level of granularity.

A many-models scenario has three stages: data source, model training, and many models.

[![A diagram that shows the stages of the many-models scenario.](./media/many-models-scenario.png)](./media/many-models-scenario.png#lightbox)

**Data source.** It's important to segment data without too many cardinalities in the data source stage. The product ID or barcode shouldn't be factored into the main partition, as doing so produces too many segments and could inhibit meaningful models. The brand, SKU, or locality could be more fitting features. It's also important to homogenize the data by removing anomalies that would skew data distribution.

**Model training.** Several experiments run parallel to each data partition in the model training stage. Many models experimentation is a typically iterative process where models from the experiments are evaluated to determine the best one.

**Many models.** The best models for each segment or category are registered in the model registry. Assign meaningful names to the models, which make them more discoverable for inference. Use tagging where necessary to group the model into specific categories.

### Batch inference for many models

During batch inference for many models, predictions are typically scheduled, recurring, and they can handle large volumes of data running at the same time. Unlike in a single-model scenario, many models inference occurs at the same time, and it's important to select the correct ones.

Many models for batch inference is achieved by using multiple deployments against a single Managed Endpoint.  Batch inference for specific models is achieved by invoking the deployment name during the REST or SDK call.  For an example of how to deploy multiple models to a single batch endpoint, see [Deploy multiple models to one deployment](https://github.com/Azure/azureml-examples/blob/main/sdk/python/endpoints/batch/deploy-models/mnist-classifier/mnist-batch.ipynb)

### Real-time inference for many models

Multiple models can be deployed into a single Managed Online Endpoint, which can be invoked via a REST API or SDK.  When creating the deployments, register the multiple models as a single "registered model" on Azure by including them in the same directory and passing that directory as the path of the model.  The models are then loaded into a dictionary keyed on their names. When a REST request is received, the desired model is retrieved from the JSON payload, and the relevant model is used to score the payload.  

Models that are loaded in a multi-model deployment using this technique must share the same Python version with no conflicting dependencies.  They libraries must be able to be simultaneously imported, even if they don't have the same dependencies in a strict sense.

For an example of how to deploy multiple models to a single endpoint, see [Deploy multiple models to one deployment](https://github.com/Azure/azureml-examples/blob/main/sdk/python/endpoints/online/custom-container/online-endpoints-custom-container-multimodel.ipynb).

## Next steps

Explore the following resources to learn more about inference in Azure Machine Learning:

- [What are Azure Machine Learning endpoints?](/azure/machine-learning/concept-endpoints)
- [Secure an Azure Machine Learning inferencing environment with virtual networks](/azure/machine-learning/how-to-secure-inferencing-vnet)
- [What are Azure Machine Learning pipelines?](/azure/machine-learning/concept-ml-pipelines)
- [How-to Guide - Deploy and score a machine learning model by using an online endpoint](/azure/machine-learning/how-to-deploy-online-endpoints)
- [How-to Guide - Use batch endpoints for batch scoring](/azure/machine-learning/how-to-use-batch-endpoint)
- [Tutorial - Deploy a model as an online endpoint](/azure/machine-learning/tutorial-deploy-model)
- [What is Responsible AI?]( /azure/machine-learning/concept-responsible-ai)
- [ONNX and Azure Machine Learning](/azure/machine-learning/concept-onnx)
