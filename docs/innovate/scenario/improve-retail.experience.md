---
title: Improve retail experience with retail recommender
description: 
author: wayneme75
ms.author: brblanch
ms.date: 10/21/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: think-tank
---

# Improving Retail experience with a Retail Recommender Solution Accelerator

In the retail world digital channels have rapidly become the accelerator to driving improved customer engagement. Retailers are being pushed to re-imagine the way they communicate with, and share updates on their portfolio of products which they sell. They are having to get closer to the shopper to be in a position to better understand what they are looking for. Retailers are looking for ways to improve the connection between shopper and product ultimately improving the “attach” rate of products digital basket.
In person shopping typically leads to impulse buying as shoppers have all products on display, this is not generally true in the online shopping experience. Shoppers look for specific products, add to basket and checkout. The retail recommender solution is a way to help retailers highlight and expose associated products which a shopper would be interested in.
The purpose of this solution accelerator is to assist retail companies in creating a personalized online shopping experience that dynamically presents relevant content and products to consumers, by leveraging AI and advanced data analytics technology.

The below is the outline of a scenario for a retail organization: 
-	Shopper lands on a retailers online commercial page, the user is prompted with personalized items based on their purchase history. 
-	When a user adds items to their cart there are additional recommendations offered up based on what products would be usually purchased with these items
-	As shoppers move around the retailer’s site, new recommendations are offered based on what they are looking at.


# 
## Customer Examples  
<br>

<img src="../_images/innovate/../../../_images/innovate/tractor-supply-company.png" width=200>

Tractor Supply Company To Expand Relationship With Microsoft. The largest rural lifestyle retailer in the United States, announced the selection of Microsoft as its preferred and strategic cloud provider to support technology architecture and modernization for the Company’s Ecommerce website and enterprise analytics platform.  
“As Tractor Supply is committed to providing legendary service to our customers, this partnership with Microsoft to enhance our analytics platform will deliver insights that help us better understand our customers, while offering products and services that truly meet their needs,” said Rob Mills, Tractor Supply’s Executive Vice President, Chief Technology, Digital Commerce and Strategy Officer. “We believe that this collaboration with Microsoft will help us drive innovation and stay nimble when responding to market changes and our customers’ ever-evolving needs.”
  
Read the full story here: https://corporate.tractorsupply.com/newsroom/news-releases/news-releases-details/2020/Tractor-Supply-Company-To-Expand-Relationship-With-Microsoft/default.aspx
<br>  
<br>  

<img src="../_images/innovate/../../../_images/innovate/starbucks.png" width=80>  

Starbucks turns to technology to brew up a more personal connection with its customers. They have been using reinforcement learning technology — a type of machine learning in which a system learns to make decisions in complex, unpredictable environments based upon external feedback — to provide a more personalized experience for customers who use the Starbucks® mobile app.

Within the app, customers receive tailor-made order suggestions generated via a reinforcement learning platform that is built and hosted in Microsoft Azure. Through this technology and the work of Starbucks data scientists, 16 million active Starbucks® Rewards members now receive thoughtful recommendations from the app for food and drinks based on local store inventory, popular selections, weather, time of day, community preferences and previous orders.

“Everything we do in technology is centered around the customer connection in the store, the human connection, one person, one cup, one neighborhood at a time.” - Gerri Martin-Flickinger, Starbucks executive vice president and chief technology officer.

Read the full story here: 
https://news.microsoft.com/transform/starbucks-turns-to-technology-to-brew-up-a-more-personal-connection-with-its-customers/

# 
## Benefits of using the Solution Accelerator:
-	Easily launch using pre-built, pre-configured GitHub code and architecture.
-	Reduce development time with end-to-end unified analytics via Azure Synapse Analytics, Azure Machine Learning, and other Azure Big Data Services.
-	Quickly personalize customer experience with advanced analytics that track behavior. 
-	Get technical support from Azure experts and the Microsoft partner network.
-	Secure data with the advanced security and privacy features.

In the section that follows we will walk you through a step by step on building out a minimal viable product for the solution accelerator.  
Before you begin, we will need to ensure that you have access to the following:

## Prerequisites
1.	An Azure subscription
2.	Visual Studio 2017 or 2019
3.	PowerShell
4.	Azure command line interface (CLI)
5.	Postman (https://www.postman.com/downloads) 

Optional
1.	Visual Studio Code

## Azure and Analytics Platform  

The directions provided for this repository assume fundamental working knowledge of Azure, Cosmos DB, Azure Machine Learning Services, and Azure Kubernetes.
For additional training and support, please see:
1.	Azure Synapse Analytics (workspace preview)
2.	Azure Kubernetes Services
3.	Azure Machine Learning Services
4.	Azure Synapse Content on Microsoft Learn (https://docs.microsoft.com/en-us/learn/browse/?terms=synapse)
5.	Azure Kubernetes on Microsoft Learn (https://docs.microsoft.com/en-us/learn/browse/?terms=kubernetes) 
6.	Data Scientist learning path on Microsoft Learn (https://docs.microsoft.com/en-us/learn/browse/?roles=data-scientist) 

## Getting Started and Process Overview
1.	Clone this repository and navigate to the root of the directory
2.	Go to Deployment guide for the steps you need to take to deploy this solution
The architecture diagram below details what you will be building for this Solution Accelerator:  

![Retail Recommender Architecture](../_images/innovate/../../../_images/innovate/retailrecommender_architecture.png)  

- Utilizing Azure Data Lake Storage Gen2 for the enterprise-scale data lake  
- With the models trained, there are two main recommendation paths: user-based and item-based  
- Using External Tables in Azure Synapse Analytics to serve the generated user-based recommendations  
- Azure Cognitive Search is used to index the recommendations and allow for REST-based querying  
- Azure Machine Learning Service is used to deploy the item-based recommender to AKS as a Web Service  
- Using Azure API Management, the user-based and the item-based recommendations are in one unified API layer for the front-end to query  
- Clickstream data and user events are brought back into the data lake for retraining the models and refreshing the recommendations to help increase the accuracy of the recommendations over time  

## Resource Deployment
In the [Resource Deployment](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator/tree/main/Resource_Deployment)) folder you can find the PowerShell script to deploy the required resources into your Azure Subscription. You can do this in the Azure Portal

## Analytics Deployment
The [Analytics Deployment](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator/tree/main/Analytics_Deployment) folder contains the Notebooks needed to complete this solution accelerator. Once you have deployed all the required resources from the [ResourceDeployment.md](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator/blob/main/Resource_Deployment), run through the Notebooks following the instructions in Resource Deployment.  

## Application Frontend Web Application Deployment
The [Application Front-end](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator/tree/main/Application_Frontend_Deployment) folder contains the resources to deploy the front-end web application.  

## Application Backend API Deployment
The [Application Backend](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator/tree/main/Application_Backend_Deployment) folder contains the resources for product details and managing the list of products that are presented to the Portal. 

## ML Model Building
The [ML Model Building](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator/tree/main/ML_Model_Building) folder contains the resources for exploring how the model was constructed.


## Next Steps:

1. Take a tour of our Live Demo, [Synapse/AI-Retail-Recommender](https://synapsefornextgenretail.azurewebsites.net/)  
2. Use the Azure DevOps template to help deploy in your own environment - [Retail Recommender ADO Template](https://azuredevopsdemogenerator.azurewebsites.net/?name=retai). 
   1. Log in to the generator
   2. Navigate to Cloud Adoption Framework
   3. Select the Retail Recommender template
   4. Deploy to your Azure DevOps environment



