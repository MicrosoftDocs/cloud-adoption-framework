---
title: 'Evaluate modernization options'
description: ..............
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/01/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: internal
---
<!--minimum: One article     maximum: Four articles
Primary Deliverable: CAF/Modernize/Evaluate-Modernization-Options.md​
Potential additional deliverables: 
- modernization-economics.md (slides 26-28)
- modernization-examples.md (slides 29-30)
- complex-evaluations.md (slides 36-37)
Unknown deliverables:​
The Evaluate Cloud Modernization process might need to be broken down into additional articles to keep read times under 10 minutes.
-->
# Evaluate modernization options

As the cloud modernizes IT, companies are being forced to transform themselves. Those that make the transformation survive.

How many purchases did you make at Amazon in the last month? And how many at a brick and mortar retailer? When you were walking to that brick and mortar retailer, how many businesses did you notice that were closed, or had been replaced by someone new?

Digital transformation is an economic imperative. A transformation strategy drives innovation and growth. Organizations that harness data, the cloud, and AI are driving innovation and growth and outperforming their peers.

Modernization allows your organization to focus on making innovative services and applications available to the company and spend less time managing core infrastructure like server patching, networking setup, firewall configuration, and many other server-related tasks now included with Azure PaaS.

## Technical indicators

Evaluate the following technical indicators, which will help you determine whether a set of workloads is a good candidate for modernization.

- **Can you modernize the workload?** You can't modernize a workload with commercial off the shelf solutions (COTS), where you buy a product and run it on servers that can't be modernized, unless the vendor who sold you that product has already done that modernization. These indicators are easy to weed out.
- **Is the business actively investing in maturing these workloads?** This would include workloads that don't create a competitive advantage, or workloads built with the support of a consulting firm that's no longer making changes and is running through its life cycle. If your business isn't actively investing in it, should you put in more investment?
- **Will these modernized workloads need to operate in hybrid or multi-cloud environment?**

## Financial indicators

Evaluate the following financial indicators, which will help you determine whether a set of workloads is a good candidate for modernization.

- **Can you quantify the business value of modernizing these workloads?** Consider whether the business values will lead to revenue and whether you've forecasted that revenue. If the values lead to cost savings, have you forecasted that cost savings? For instance, if you save a little bit of admin time, unfortunately, you can only often times realize that revenue savings if you let go of some of your people. So that's a little bit of a soft cost that's hard to quantify.
- **Have you compared the hosting costs of these workloads in a migrated vs modernized approach?** A lot of times people don't think about that and some modernization efforts can actually increase your cost.
- **Are these workloads considered business-critical?** If outages of a workload truly are business critical and downtime costs you money in the 1,000,000 per hour, the cost of runtime doesn't matter as much. If it's truly business-critical, then it's probably a good candidate for modernization.

In previous modernization articles, we talked about the [modernization motivations](envision-cloud-modernization.md) and mapping different workload categories to those motivations. Some workloads are going to get mapped to multiple modernization motivations, so it's important to look for. Evaluate modernization paths, dependencies, and compatibility of your current state to establish realistic expectations.

## Modernization economics
<!--(slides 26-28)-->



### Motivation

Let's evaluate from both the technical and a financial perspective.

So when you're thinking about modernizing things, there's a couple of different strategies that would drive this type of motion. Motivators tend to be more around generating new income, generating new operating income, in particular by modernizing and getting more usage of...

With the technology that they have out there and maybe even creating market differentiators and realistically to justify any kind of modernization effort, you wanna see some operating income coming from this, not just operating margin.

We've put the types of modernization into the following three groups to show....:

- Operating margin: Automating ongoing administrative work, like patching, networking, firewall configuration, with the SASS service or pass services that we have.

- Motivators: generating new income (operating income and margin), modernizing and getting more usage of the technology, creating market differentiators
produces some significant...

- Infrastructure: Operating margin: reduce administrative work, patching, firewall administration
Apps and data, getting to market faster, drive innovations, improve delivery time by 50%

## Modernization examples

Here we show you some examples modernization
### Migrating your app to Azure IaaS and Azure SQL Database Managed Instance (MI)

This example is for a common web application running on a database. You could modernize only your SQL database instance, keep the web layer running as is and put it into IAS servers and migrate, or you could choose to modernize your data layer as you go and move from SQL Server on-premises to SQL database managed instances in the cloud. This is ultimately a migration effort, as we haven't changed any of the underlying infrastructure to create capabilities or opportunities to capitalize on cloud benefits.

:::image type="content" source="../_images/modernize/example-azure-iaas-azure-sql-db-mi.png" alt-text="Diagram showing flow of migrating to Azure App Service and Azure SQL DB MI.":::

### Migrating your app to Azure App Service and AzureSQL Database MI

You can modernize both web and data layers. Modernize the data layer by moving it to the database manager instances. We modernize the app by going from a bunch of IAS servers or just VMS over to Azure App Service.

:::image type="content" source="../_images/modernize/example-azure-app-service-azure-sql-database-mi.png" alt-text="Diagram showing flow of migrating to Azure App Service and Azure SQL DB MI.":::

A different approach would be to modernize your app layer, like we just mentioned, but maybe you're working with some open source data layers and you want to go to something like Azure Database for MySQL, PostgreSQL, or MariaDB.

:::image type="content" source="../_images/modernize/example-app-service-azure-db.png" alt-text="Diagram showing flow of migrating your app to App Service and Azure Database for MySQL and so on.":::
