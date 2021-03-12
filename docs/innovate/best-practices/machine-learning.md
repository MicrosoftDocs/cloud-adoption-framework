---
title: What is machine learning?
description: What is machine learning? Get started with Azure machine learning, MLOps and machine learning deployment tools.
author: v-hanki
ms.author: janet
ms.date: 01/26/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: think-tank, seo-caf-innovate
keywords: what is machine learning, azure machine learning, machine learning tools, mlops, automated machine learning
---

<!-- cSpell:ignore scikit RLlib Jupyter MLflow Kubeflow -->

# What is machine learning?

Machine learning is a data science technique that allows computers to use existing data to forecast future behaviors, outcomes, and trends. By using machine learning, computers learn without being explicitly programmed. Machine learning tools use AI systems which provide the ability to identify patterns and create associations from experience with the data.

Automated machine learning forecasts or predictions can make applications and devices smarter. For example, when you shop online, machine learning helps recommend other products you might want based on what you've bought. Or when your credit card is swiped, machine learning compares the transaction to a database of transactions and helps detect fraud. And when your robot vacuum cleaner vacuums a room, machine learning helps it decide whether the job is done.

## Machine learning tools to fit each task

Azure Machine Learning provides all the tools developers and data scientists need for their machine learning workflows, including:

- The [Azure Machine Learning designer (preview)](/azure/machine-learning/tutorial-designer-automobile-price-train-score): Drag-n-drop modules to build your experiments and then deploy pipelines
- Jupyter notebooks: Use our [example notebooks](https://github.com/Azure/MachineLearningNotebooks) or create your own notebooks to use our SDK for Python samples.
- R scripts or notebooks in which you use the [SDK for R](https://azure.github.io/azureml-sdk-for-r/reference/index.html) to write your own code, or use the R modules in the designer.
- The [many models solution accelerator (preview)](https://github.com/microsoft/solution-accelerator-many-models) builds on Azure Machine Learning and enables you to train, operate, and manage hundreds or even thousands of machine learning models.
- [Visual Studio Code extension](/azure/machine-learning/tutorial-setup-vscode-extension).
- [Machine learning CLI](/azure/machine-learning/reference-azure-machine-learning-cli).
- Open-source frameworks such as PyTorch, TensorFlow, and scikit-learn and many more
- [Reinforcement learning](/azure/machine-learning/how-to-use-reinforcement-learning) with Ray RLlib.

You can even use [MLflow to track metrics and deploy models](/azure/machine-learning/how-to-use-mlflow) or [kubeflow](https://www.kubeflow.org/docs/azure/) to build end-to-end workflow pipelines.

## Build machine learning models in Python or R

Start training on your local machine using the Azure Machine Learning [Python SDK](/python/api/overview/azure/ml/) or [R SDK](https://azure.github.io/azureml-sdk-for-r/reference/index.html). Then, you can scale out to the cloud. With many available [compute targets](/azure/machine-learning/how-to-set-up-training-targets), like Azure Machine Learning compute and [Azure Databricks](/azure/databricks/scenarios/what-is-azure-databricks), and with [advanced hyperparameter tuning services](/azure/machine-learning/how-to-tune-hyperparameters), you can build better models faster by using the power of the cloud. You can also [automate model training and tuning](/azure/machine-learning/tutorial-auto-train-models) using the SDK.

## Build machine learning models with no-code tools

For code-free or low-code training and deployment, try:

- Azure Machine Learning designer (preview)

  Use the designer to prep data, train, test, deploy, manage, and track machine learning models without writing any code. There is no programming required, you visually connect datasets and modules to construct your model. Try out the [designer tutorial](/azure/machine-learning/tutorial-designer-automobile-price-train-score).

  Learn more in the [Azure Machine Learning designer overview article](/azure/machine-learning/concept-designer).
- Automated machine learning (AutoML) UI

  Learn how to create [AutoML experiments](/azure/machine-learning/tutorial-first-experiment-automated-ml) in the easy-to-use interface.

## MLOps: Deploy and lifecycle management

Machine learning operations (MLOps) is based on [DevOps](https://azure.microsoft.com/overview/what-is-devops/) principles and practices that increase the efficiency of workflows. For example, continuous integration, delivery, and deployment. MLOps applies these principles to the machine learning process, with the goal of:

- Faster experimentation and development of models
- Faster deployment of models into production
- Quality assurance

When you have the right model, you can easily use it in a web service, on an IoT device, or from Power BI. For more information, see [Deploy models with Azure Machine Learning](/azure/machine-learning/how-to-deploy-and-where).

Then you can manage your deployed models by using the [Azure Machine Learning SDK for Python](/python/api/overview/azure/ml/), [Azure Machine Learning studio](https://ml.azure.com/), or the [Machine learning CLI](/azure/machine-learning/reference-azure-machine-learning-cli).

These models can be consumed and return predictions in [Real time](/azure/machine-learning/how-to-consume-web-service) or [asynchronously](/azure/machine-learning/tutorial-pipeline-batch-scoring-classification) on large quantities of data.

And with advanced [machine learning pipelines](/azure/machine-learning/concept-ml-pipelines), you can collaborate on each step from data preparation, model training and evaluation, through deployment. Pipelines allow you to:

- Automate the end-to-end machine learning process in the cloud
- Reuse components and only rerun steps when needed
- Use different compute resources in each step
- Run batch scoring tasks

If you want to use scripts to automate your machine learning workflow, the [Machine learning CLI](/azure/machine-learning/reference-azure-machine-learning-cli) provides command-line tools that perform common tasks, such as submitting a training run or deploying a model.

To get started using Azure Machine Learning, see [Next steps](/azure/machine-learning/overview-what-is-azure-ml#next-steps).

## Automated Machine Learning

Data scientists spend an inordinate amount of time iterating over models during the experimentation phase. The whole process of trying out different algorithms and hyperparameter combinations until an acceptable model is built is extremely taxing for data scientists, due to the monotonous and non-challenging nature of work. While this is an exercise that yields massive gains in terms of the model efficacy, it sometimes costs too much in terms of time and resources and thus may have a negative return on investment (ROI).

This is where automated machine learning (AutoML) comes in. It uses the concepts from the research paper on probabilistic matrix factorization and implements an automated pipeline of trying out intelligently-selected algorithms and hypermeter settings, based on the heuristics of the data presented, keeping into consideration the given problem or scenario. The result of this pipeline is a set of models that are best suited for the given problem and dataset.

For more information on AutoML, see [AutoML and MLOps with Azure Machine Learning](https://azure.microsoft.com/blog/automated-machine-learning-and-mlops-with-azure-machine-learning/).

## Responsible ML

Throughout the development and use of AI systems, trust must be at the core. Trust in the platform, process, and models. As AI and autonomous systems integrate more into the fabric of society, it's important to proactively make an effort to anticipate and mitigate the unintended consequences of these technologies.

- **Understand your models and build for fairness:** Explain model behavior and uncover features that have the most impact on predictions. Use built-in explainers for both glass-box and black-box models during model training and inference. Use interactive visualizations to compare models and perform what-if analysis to improve model accuracy. Test your models for fairness using state-of-the-art algorithms. Mitigate unfairness throughout the machine learning lifecycle, compare mitigated models, and make intentional fairness versus accuracy trade-offs as desired.
- **Protect data privacy and confidentiality:** Build models that preserve privacy using the latest innovations in differential privacy, which injects precise levels of statistical noise in data to limit the disclosure of sensitive information. Identify data leaks and intelligently limit repeat queries to manage exposure risk. Use encryption and confidential machine learning (coming soon) techniques specifically designed for machine learning to securely build models using confidential data.
- **Control and govern through every step of the machine learning process:** Access built-in capabilities to automatically track lineage and create an audit trial across the machine learning lifecycle. Obtain full visibility into the machine learning process by tracking datasets, models, experiments, code, and more. Use custom tags to implement model data sheets, document key model metadata, increase accountability, and ensure responsible process.

Learn more about how to implement [Responsible ML](/azure/machine-learning/concept-responsible-ml).

## Integration with other services

Azure Machine Learning works with other services on the Azure platform, and also integrates with open-source tools such as Git and MLflow.

- **Compute targets such as Azure Kubernetes Service, Azure Container Instances, Azure Databricks, Azure Data Lake Analytics, and Azure HDInsight:** For more information on compute targets, see [What are compute targets?](/azure/machine-learning/concept-compute-target).
- **Azure Event Grid:** For more information, see [Consume Azure Machine Learning events](/azure/machine-learning/how-to-use-event-grid).
- **Azure Monitor:** For more information, see [Monitoring Azure Machine Learning](/azure/machine-learning/monitor-azure-machine-learning).
- **Data stores such as Azure Storage accounts, Azure Data Lake Storage, Azure SQL Database, Azure Database for PostgreSQL, and Azure open datasets:** For more information, see [Access data in Azure Storage services](/azure/machine-learning/how-to-access-data) and [create datasets with Azure open datasets](/azure/machine-learning/how-to-create-register-datasets#create-datasets-with-azure-open-datasets).
- **Azure Virtual Network:** For more information, see [Secure experimentation and inference in a virtual network](/azure/machine-learning/how-to-network-security-overview).
- **Azure Pipelines:** For more information, see [Train and deploy machine learning models](/azure/devops/pipelines/targets/azure-machine-learning).
- **Git repository logs:** For more information, see [Git integration](/azure/machine-learning/concept-train-model-git-integration).
- **MLflow:** For more information, see [MLflow to track metrics and deploy models](/azure/machine-learning/how-to-use-mlflow).
- **Kubeflow:** For more information, see [Build end-to-end workflow pipelines](https://www.kubeflow.org/docs/azure/).
- **Secure communications:** Your Azure Storage account, compute targets, and other resources can be used securely inside a virtual network to train models and perform inference. For more information, see [Secure experimentation and inference in a virtual network](/azure/machine-learning/how-to-network-security-overview).

## Next steps

- Review machine learning white papers and e-books on [Machine Learning studio](https://azure.microsoft.com/resources/whitepapers/search/?service=machine-learning-studio) and [Machine Learning service](https://azure.microsoft.com/resources/whitepapers/search/?service=machine-learning-service).
- Review [AI + Machine Learning architectures](/azure/architecture/browse/).
