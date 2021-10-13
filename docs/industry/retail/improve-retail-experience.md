---
title: Improve the retail experience with retail recommender solution accelerator
description: Improve the retail experience by using the retail recommender solution in Azure. This article shows you how to build out the solution accelerator.
author: mpvenables
ms.author: brblanch
ms.date: 09/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-retail
---

# Improve retail experience with a Retail Recommender Solution Accelerator

In the retail world, digital channels have rapidly become the driving force towards creating improved customer engagement. Retailers are being pushed to reimagine the way they communicate value proposition, sharing updates on their product lines. They are being forced to move towards the perspective of the purchasing consumer—aiming to better understand what customers are looking for. Retailers are seeking fresh ways to strengthen the connection between shoppers and products—increasing their attach rate, and creating additive value beyond the products in shopping carts.

Onsite shopping typically leads to impulse buying, as shoppers have a variety of products displayed before them. Impulse buying doesn't typically occur in the online shopping experience. Shoppers look for specific products, add to their basket, and proceed to checkout.

The Retail Recommender Solution Accelerator helps retailers highlight associated products that might be of interest to a shopper. Its purpose is to create a personalized online shopping experience. Using AI and advanced data analytics cloud technologies, the Retail Recommender Solution Accelerator presents shoppers with relevant content and products in the following ways:

- A shopper visits a retailer online commercial page, which prompts the user with personalized selections, based on purchase history.
- When the shopper adds items to the cart, the site offers more recommendations, based on what products would be purchased with these items.
- As the shopper moves around the retailer's site, the site offers new recommendations based on what the shopper looks at.

## Retail Recommender Solution Accelerator

The Retail Recommender Solution Accelerator is ready-to-deploy code that levers analytics capabilities within Azure Synapse to evaluate your shoppers' past purchasing and browsing habits—delivering a tailored browsing experience with personalized product recommendations.

Exceeding customer expectations in the retail sector is the most important lever to improve your business. Deeper insights can drive your organization's revenue, and increase retention. Machine learning helps you to evaluate how operational decisions factor into business outcomes.

## Connect your data and understand your customer, however they buy

Unlock innovation—and remove data silos in your organization. Earn repeat customers by delivering an improved, more customized omnichannel customer experience with unified data strategy. Gain a holistic view of customer information and sales data, in addition to macroeconomic influences, financial transactions, and supply—everything that enables your organization to automate workflows, plan for future sales, and proactively manage risk.

Accelerate your existing business growth with ready-to-deploy code that you can quickly implement into your infrastructure—and overcome the challenge of optimizing the capture, visualization, and levering of your customers' data.

## Retail Recommender Solution Accelerator overview

- **Reward your loyal customers** with meaningful product recommendations
- **Drive end-to-end analytics** across the supply chain
- **Build better in-store and online experiences**
- **Enable deeper insights—and a more customized customer experience**
- **Use machine learning to make personalized recommendations** that are meaningful to your loyalty customers

![Data complexity and siloed decision-making](./media/data-complexity-siloed-decision-making.png)


## Transform customer experience with real time shopping recommendations

The Retail Recommender Solution Accelerator uses machine learning and a filtering model that connects what the customer looks at with data from what other users have in real time to provide a recommendation. For example, if other customers viewed phones and headsets, and you view phones, you are more likely to view a headset as well—an that particular customer view will become your recommendation. The system will then construct a matrix of similar data to inform your future recommendations.

Here is what the Retail Recommender Solution Accelerator model looks like:

![Retail Recommender Solution Accelerator model](./media/retail-recommender-solution-model.png)

### How does real-time personalization work for your company?

- Customer lands on page, sees personalized items based on their purchase history.
- Customer selects or switches user.
- Landing page refreshes, customer sees personalized items in real-time based on their purchase history
- Customer enters product detail page, sees suggested products based on purchase and browsing history.
- Customer puts items in cart, sees additional recommendations based on items they’ve put in the cart.
- Customer returns to the landing page, and sees recommended add-on products

![Retail Recommender Solution Accelerator details](./media/retail-recommender-solution-details.png)

## Get started with the Retail Recommender Solution Accelerator MVP

Launch the [Retail Recommender Solution Accelerator](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator) with the resources needed to quickly build a Retail Recommender Solution based on the comprehensive Azure Analytics Platform.

### Create your personalized MVP

- **Deploy resources**. Create a resource group you can use as a container to begin deploying the resources to Azure.

- **Prepare data**. Configure your development environment for Azure Machine Learning. Notebook VM is a highly-compatible, preconfigured way to get up and running quickly.

- **Train data with custom scripts**. The scripting process is outlined in a series of Jupyter Notebooks. Review them sequentially to walk you through training, scoring, and making predictions using Azure Machine Learning.

Create your MVP in less than a day With demo data, or in 2-5 weeks with your custom data and a prep session.

Here is a high-level diagram of operations through Azure Data Lake Storage Gen2 (enterprise-scale data lake), Azure Synapse, Azure Synapse Analytics, Azure Cognitive Search, Azure Machine Learning Service, Azure API Management, and Azure Machine Learning services.

![Retail Recommender Solution Accelerator architecture](./media/retail-recommender-solution-accelerator-architecture.png)

## Azure and analytics platform prerequisites

Working knowledge of Azure, Azure Cosmos DB, Azure Machine Learning, and Azure Kubernetes.

[Read the full Tractor Supply Company story](https://corporate.tractorsupply.com/newsroom/news-releases/news-releases-details/2020/Tractor-Supply-Company-To-Expand-Relationship-With-Microsoft/default.aspx).


Read more about:

- [Azure Synapse Analytics](/azure/synapse-analytics/)
- [Azure Kubernetes Service](/azure/aks/)
- [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-ml)
- [Azure Synapse content on Microsoft Learn](/learn/browse/?terms=synapse)
- [Azure Kubernetes on Microsoft Learn](/learn/browse/?terms=kubernetes)
- [Data scientist learning path on Microsoft Learn](/learn/browse/?roles=data-scientist)

**Starbucks turns to technology to brew up a more personal connection with its customers:** Starbucks has been using reinforcement learning technology, a type of machine learning in which a system learns to make decisions in complex, unpredictable environments based on external feedback, to provide a more personalized experience for customers who use the Starbucks mobile application.

For comprehensive technical guidance, including a deployment guide, see the [Retail Recommender Solution Accelerator GitHub page](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator).

## Customer examples

Tractor Supply Company

Tractor Supply Company, the largest rural lifestyle retailer in the United States, announced the selection of Microsoft as its preferred and strategic cloud provider to support technology architecture and modernization for the company's e-commerce website and enterprise analytics platform. [Read the full Tractor Supply Company customer story.](https://corporate.tractorsupply.com/newsroom/news-releases/news-releases-details/2020/Tractor-Supply-Company-To-Expand-Relationship-With-Microsoft/default.aspx)

Starbucks

Starbucks has been using reinforcement learning technology, a type of machine learning in which a system learns to make decisions in complex, unpredictable environments based upon external feedback, to provide a more personalized experience for customers who use the Starbucks mobile application. [Read the full Starbucks customer story.](https://news.microsoft.com/transform/starbucks-turns-to-technology-to-brew-up-a-more-personal-connection-with-its-customers/)

[Read the full Starbucks story](https://news.microsoft.com/transform/starbucks-turns-to-technology-to-brew-up-a-more-personal-connection-with-its-customers/).

## Next steps

To take a tour of our live demo, see [`Synapse/AI-Retail-Recommender`](https://synapsefornextgenretail.azurewebsites.net/).

To use the Azure DevOps template to help deploy in your own environment, see the [`Retail Recommender` Azure DevOps template](https://azuredevopsdemogenerator.azurewebsites.net/) and follow these steps:

1. Sign in to the generator.
1. Navigate to Cloud Adoption Framework.
1. Select the **Retail Recommender** template.
1. Deploy to your Azure DevOps environment.

The following articles will help you succeed in your cloud adoption journey.

- [Governance in the retail industry](./govern.md)
- [Management in the retail industry](./manage.md)
