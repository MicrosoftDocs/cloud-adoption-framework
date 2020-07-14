---
title: "MLOps with Azure Machine Learning"
description: Use the Cloud Adoption Framework for Azure to understand the various transitions that must be made to enable operational management in the cloud.
author: v-hanki
ms.author: janet
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# MLOps with Azure Machine Learning

Machine Learning Operations (MLOps) is based on DevOps principles and practices that increase the efficiency of workflows. For example, continuous integration, delivery, and deployment. MLOps applies these principles to the machine learning process, with the goal of:

- Faster experimentation and development of models
- Faster deployment of models into production
- Quality assurance

Azure Machine Learning provides the following MLOps capabilities:

- **Create reproducible ML pipelines**. Machine Learning pipelines allow you to define repeatable and reusable steps for your data preparation, training, and scoring processes.
- **Create reusable software environments** for training and deploying models.
- **Register, package, and deploy models from anywhere**. You can also track associated metadata required to use the model.
- **Capture the governance data for the end-to-end ML lifecycle**. The logged information can include who is publishing models, why changes were made, and when models were deployed or used in production.
- **Notify and alert on events in the ML lifecycle**. For example, experiment completion, model registration, model deployment, and data drift detection.
- **Monitor ML applications for operational and ML-related issues**. Compare model inputs between training and inference, explore model-specific metrics, and provide monitoring and alerts on your ML infrastructure.
- **Automate the end-to-end ML lifecycle with Azure Machine Learning and Azure Pipelines**. Using pipelines allows you to frequently update models, test new models, and continuously roll out new ML models alongside your other applications and services.

## Best practices for MLOps with Azure Machine Learning

Models differ from code because they have an organic shelf life and will deteriorate unless maintained. Once deployed, they can add real business value, and this gets easier when data scientists are given the tools to adopt standard engineering practices.

"By unifying our tech stack and bringing our engineers in Big Data and online software together with data scientists, we got our development time down from months to just a few weeks." *Naeem Khedarun Principal Software Engineer, ASOS*

With MLOps on Azure you can quickly realize the value of your models and retain that value over time.

- Create reproducible models and reusable training pipelines.
- Simplify model packaging, validation, and deployment for quality control, A/B testing, and more.
- Explain and observe model behavior and automate the retraining process.

MLOps improves the quality and consistency of your machine learning solutions. To learn more about how to use Azure Machine Learning to manage the lifecycle of your models, see [MLOps: Model management, deployment, and monitoring with Azure Machine Learning](https://docs.microsoft.com/azure/machine-learning/concept-model-management-and-deployment).

## Next steps

Learn more by reading and exploring the following resources:

- [MLOps: Model management, deployment, and monitoring with Azure Machine Learning](https://docs.microsoft.com/azure/machine-learning/concept-model-management-and-deployment)
- How and where to [deploy models with Azure Machine Learning](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-and-where)
- Tutorial: [Deploy an image classification model in ACI](https://docs.microsoft.com/azure/machine-learning/tutorial-deploy-models-with-aml)
- [End-to-end MLOps examples repo](https://github.com/microsoft/MLOps)
- [CI/CD of ML models with Azure Pipelines](https://docs.microsoft.com/azure/devops/pipelines/targets/azure-machine-learning?view=azure-devops&tabs=yaml)
- Create clients that [consume a deployed model](https://docs.microsoft.com/azure/machine-learning/how-to-consume-web-service)
- [Machine learning at scale](https://docs.microsoft.com/azure/architecture/data-guide/big-data/machine-learning-at-scale)
- [Azure AI reference architectures and best practices repo](https://github.com/microsoft/AI)
