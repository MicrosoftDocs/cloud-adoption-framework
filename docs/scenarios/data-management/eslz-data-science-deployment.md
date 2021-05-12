---
title: Enterprise Scale Analytics and AI Data Science Deployment
description: Enterprise Scale Analytics and AI Architecture Data Science Deployment
author:  xigyenge
ms.author:  xigyenge # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data Science Deployment

## Real Time Streaming Scenario

For streaming/real-time use cases, deployments should be tested on ACIs before deploying them onto any other platform like AKS, Functions or App Services for Containers. Simple input and output tests should be performed in order to make sure that the response of the services is as expected.

As a next step models can be deployed to the desired service. The only deployment compute target today that is GA and is recommended for production workloads is an AKS cluster. This even more holds true, if GPU or FPGA support is required. There is currently no other native deployment option available in Azure Machine Learning that supports these hardware requirements. In order to minimize the management overhead, it is advised to deploy central AKS clusters as shared resource and attach them to the respective workspaces. An additional test AKS instance should also be hosted if stress tests should be performed before moving a model onto the production AKS.

## Batch Scenario

Not all use cases require a deployment on an AKS cluster. In particular, if large amounts of data only need to be scored on a regular basis or based on an event, like data being dropped in a particular storage account.

For these kind of scenarios, Azure Machine Learning pipelines in combination with Azure Machine Learning compute clusters should be used for deployment. Execution of these pipelines should be orchestrated from Data Factory.

## Identifying the right compute resources

Before deploying a model in Azure Machine Learning to an AKS or ACI, the user needs to specify the resources (CPU, RAM, GPU) that should be allocated for the respective model. Defining these parameters can be a complex and tedious process. Stress tests with different configurations need to be performed to identify a good set of parameters.

This process can be extremely simplified with the Model Profiling feature in Azure Machine Learning. This is a long running job, that tests different combinations of resource allocations and identifies an optimal combination based on the identified latency and RTT. This information can then be used for the actual model deployment on AKS.

To safely update models in Azure Machine Learning, teams should leverage the controlled rollout feature (preview) in order to minimize the downtime and keep the model REST endpoint consistent.
