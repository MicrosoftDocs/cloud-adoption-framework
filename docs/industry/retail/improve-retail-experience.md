---
title: Improve the retail experience with retail recommender
description: Improve the retail experience by using the retail recommender solution in Azure. This article shows you how to build out the solution accelerator.
author: wayneme75
ms.author: brblanch
ms.date: 05/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-retail
---

# Improve the retail experience with a retail recommender solution accelerator

In the retail world, digital channels have rapidly become the accelerator to driving improved customer engagement. Retailers are being pushed to reimagine the way they communicate with, and share updates on their portfolio of products that they sell. They are having to get closer to the shopper to be in a position to better understand what they are looking for. Retailers are looking for ways to improve the connection between shopper and product ultimately improving the *attach* rate of products digital basket.

In-person shopping typically leads to impulse buying as shoppers have all products on display. Impulse buying doesn't typically occur in the online shopping experience. Shoppers look for specific products, add to their basket, and checkout.

The retail recommender solution helps retailers highlight and expose associated products that might interest a shopper. The purpose of this solution accelerator is to create a personalized online shopping experience. Using AI and advanced data analytics technology, the retail recommender solution presents shoppers with relevant content and products in the following ways:

- A shopper visits a retailer online commercial page, which prompts the user with personalized selections, based on purchase history.
- When the shopper adds items to the cart, the site offers more recommendations, based on what products would be purchased with these items.
- As the shopper moves around the retailer's site, the site offers new recommendations based on what the shopper looks at.

## Benefits of using the solution accelerator

- Easily launch using pre-configured GitHub code and architecture.
- Reduce development time with unified analytics by using Azure Synapse Analytics, Azure Machine Learning, and other Azure services.
- Quickly personalize customer experience with advanced analytics that track behavior.
- Get technical support from Azure experts and the Microsoft partner network.
- Secure data with the advanced security and privacy features.

## Prerequisites

This article shows you how to build out a minimal product for the solution accelerator. Before you begin, set up the following prerequisites.

- An Azure account with an active subscription. [Create an account for free.](https://azure.microsoft.com/free/)
- [Visual Studio 2017 or Visual Studio 2019](https://azure.microsoft.com/downloads/). Ensure you select the **Azure development** workload during installation
- [Azure PowerShell](/powershell/azure/get-started-azureps).
- [Azure CLI](/cli/azure/install-azure-cli).
- [The Postman application](https://www.postman.com/downloads).
- [Visual Studio Code](https://code.visualstudio.com/) (optional).

## Azure and analytics platform

You need a basic working knowledge of Azure, Azure Cosmos DB, Azure Machine Learning, and Azure Kubernetes.

For information, see:

- [Azure Synapse Analytics](/azure/synapse-analytics/)
- [Azure Kubernetes Service](/azure/aks/)
- [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-ml)
- [Azure Synapse content on Microsoft Learn](/learn/browse/?terms=synapse)
- [Azure Kubernetes on Microsoft Learn](/learn/browse/?terms=kubernetes)
- [Data scientist learning path on Microsoft Learn](/learn/browse/?roles=data-scientist)

## Getting started and process overview

Clone the [solution accelerator](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator) repository. The `README` file contains the deployment guide. You can perform the following tasks:

- Use Azure Data Lake Storage Gen2 for the enterprise-scale data lake.
- With the models trained, use the two main recommendation paths: user-based and item-based.
- Use external tables in Azure Synapse Analytics to serve the generated user-based recommendations.
- Use Azure Cognitive Search to index the recommendations and allow for REST-based querying.
- Use Azure Machine Learning to deploy the item-based recommender to Azure Kubernetes Service as a web service.
- With Azure API Management, the front end queries the user-based and the item-based recommendations in one unified API layer.
- Clickstream data and user events are brought back into the data lake for retraining the models and refreshing the recommendations. This feedback increases the accuracy of the recommendations over time.

### Resource deployment

Use the PowerShell script in the [`Resource_Deployment`](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator/tree/main/Resource_Deployment) folder to deploy the required resources into your Azure subscription. You can run the script in Cloud Shell in the Azure portal.

### Analytics deployment

Use the notebooks in the [`Analytics_Deployment`](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator/tree/main/Analytics_Deployment) folder to complete this solution accelerator. After you deploy all the required resources from the [`Resource_Deployment`](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator/tree/main/Resource_Deployment) folder, follow the instructions in `Resource_Deployment` for the notebooks.

### Application front end web application deployment

The [`Application_Frontend_Deployment`](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator/tree/main/Application_Frontend_Deployment) folder contains the resources to deploy the front-end web application.

### Application back end API deployment

The [`Application_Backend_Deployment`](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator/tree/main/Application_Backend_Deployment) folder contains the resources for product details. Manage the products presented to the Azure portal.

### Machine learning model building

The [`ML_Model_Building`](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator/tree/main/ML_Model_Building) folder contains the resources for exploring how the model was constructed.

## Customer examples

### Tractor Supply Company

**Tractor Supply Company to expand its relationship with Microsoft:** Tractor Supply Company, the largest rural lifestyle retailer in the United States, announced the selection of Microsoft as its preferred and strategic cloud provider to support technology architecture and modernization for the company's e-commerce website and enterprise analytics platform.

"As Tractor Supply is committed to providing legendary service to our customers, this partnership with Microsoft to enhance our analytics platform will deliver insights that help us better understand our customers, while offering products and services that truly meet their needs," said Rob Mills, Tractor Supply's executive vice president and chief technology, digital commerce, and strategy officer. "We believe that this collaboration with Microsoft will help us drive innovation and stay nimble when responding to market changes and our customers' ever-evolving needs."

[Read the full Tractor Supply Company story.](https://corporate.tractorsupply.com/newsroom/news-releases/news-releases-details/2020/Tractor-Supply-Company-To-Expand-Relationship-With-Microsoft/default.aspx)

### Starbucks

**Starbucks turns to technology to brew up a more personal connection with its customers:** Starbucks has been using reinforcement learning technology, a type of machine learning in which a system learns to make decisions in complex, unpredictable environments based upon external feedback, to provide a more personalized experience for customers who use the Starbucks mobile application.

Within the application, customers receive tailor-made order suggestions generated by using a reinforcement learning platform that is built and hosted in Microsoft Azure. Through this technology and the work of Starbucks data scientists, 16 million active Starbucks Rewards members now receive thoughtful recommendations from the application for food and drinks based on local store inventory, popular selections, weather, time of day, community preferences, and previous orders.

"Everything we do in technology is centered around the customer connection in the store, the human connection, one person, one cup, one neighborhood at a time." - Gerri Martin-Flickinger, Starbucks executive vice president and chief technology officer.

[Read the full Starbucks story.](https://news.microsoft.com/transform/starbucks-turns-to-technology-to-brew-up-a-more-personal-connection-with-its-customers/)

## Next steps

To take a tour of our live demo, see [`Synapse/AI-Retail-Recommender`](https://synapsefornextgenretail.azurewebsites.net/).

To use the Azure DevOps template to help deploy in your own environment, see the [`Retail Recommender` Azure DevOps template](https://azuredevopsdemogenerator.azurewebsites.net/) and follow these steps:

1. Sign in to the generator.
1. Navigate to Cloud Adoption Framework.
1. Select the **Retail Recommender** template.
1. Deploy to your Azure DevOps environment.
