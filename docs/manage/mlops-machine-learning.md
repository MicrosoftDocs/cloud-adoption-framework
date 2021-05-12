---
title: MLOps with Azure Machine Learning
description: Learn about MLOps principles and practices that increase workflow efficiencies like continuous integration, delivery, and deployment.
author: v-hanki
ms.author: janet
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank
---

# MLOps with Azure Machine Learning

*MLOps (machine learning operations)* is based on DevOps principles and practices that increase workflow efficiencies like continuous integration, delivery, and deployment. MLOps applies these principles to the machine learning process in order to:

- Experiment and develop models more quickly.
- Deploy models to production more quickly.
- Practice and refine quality assurance.

Azure Machine Learning provides the following MLOps capabilities:

- **Create reproducible pipelines.** Machine Learning pipelines enable you to define repeatable and reusable steps for your data preparation, training, and scoring processes.
- **Create reusable software environments** for training and deploying models.
- **Register, package, and deploy models from anywhere.** You can track the associated metadata required to use the model.
- **Capture the governance data for the end-to-end lifecycle.** The logged information can include who is publishing models, why changes were made, and when models were deployed or used in production.
- **Notify and alert on events in the lifecycle.** For example, you can get alerts for experiment completion, model registration, model deployment, and data drift detection.
- **Monitor applications for operational and machine learning-related issues.** Compare model inputs between training and inference, explore model-specific metrics, and provide monitoring and alerts on your machine learning infrastructure.
- **Automate the end-to-end machine learning lifecycle with Azure Machine Learning and Azure Pipelines.** With pipelines, you can frequently update models, test new models, and continuously roll out new machine learning models alongside your other applications and services.

## Best practices for MLOps with Azure Machine Learning

Models differ from code because they have an organic shelf life and will deteriorate unless maintained. After they're deployed, they can add real business value, and this gets easier when data scientists are given the tools to adopt standard engineering practices.

MLOps with Azure helps you:

- Create reproducible models and reusable training pipelines.
- Simplify model packaging, validation, and deployment for quality control and a/B testing.
- Explain and observe model behavior, and automate the retraining process.

MLOps improves the quality and consistency of your machine learning solutions. To learn more about how to use Azure Machine Learning to manage the lifecycle of your models, see [MLOps: model management, deployment, and monitoring with Azure Machine Learning](/azure/machine-learning/concept-model-management-and-deployment).

## Next steps

Learn more by reading and exploring the following resources:

- [MLOps: model management, deployment, and monitoring with Azure Machine Learning](/azure/machine-learning/concept-model-management-and-deployment)
- How and where to [deploy models with Azure Machine Learning](/azure/machine-learning/how-to-deploy-and-where)
- Tutorial: [deploy an image classification model in Azure Container Instances](/azure/machine-learning/tutorial-deploy-models-with-aml)
- [End-to-end MLOps examples repo](https://github.com/microsoft/MLOps)
- [CI/CD of machine learning models with Azure Pipelines](/azure/devops/pipelines/targets/azure-machine-learning)
- Create clients that [consume a deployed model](/azure/machine-learning/how-to-consume-web-service)
- [Machine learning at scale](/azure/architecture/data-guide/big-data/machine-learning-at-scale)
- [Azure AI reference architectures and best practices repo](https://github.com/microsoft/AI)
