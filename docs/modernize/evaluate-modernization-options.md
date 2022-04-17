---
title: 'Evaluate modernization options'
description: Learn how to evaluate your technical and financial indicators to determine which workloads you want to modernize during cloud adoption.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/14/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: internal, seo-caf-modernize
keywords: evaluate, technical, financial indicators, workloads, modernize, cloud adoption framework
---
<!--Primary Deliverable: CAF/Modernize/Evaluate-Modernization-Options.md​
Economics, Examples, Evaluations-->
# Evaluate modernization options

As the cloud modernizes IT, companies are being forced to transform themselves. Those companies that have made the transformation are the ones surviving. Digital transformation is an economic imperative. Organizations that harness data, the cloud, and AI are driving innovation and growth and outperforming their peers.

A transformation strategy drives innovation and growth.

:::image type="content" source="../_images/modernize/cloud-adoption-outperforming-peers.png" alt-text="Graphic showing statistics about organization that harness data, the cloud, and AI outperforming their peers.":::

- **Infrastructure:** You can focus on making innovative services and applications available to the company and spend less time managing core infrastructure like server patching, networking setup, firewall configuration, and many other server-related tasks now included with Azure PaaS.
- **Apps:** Websites are up and running within minutes, app delivery time is improved by 50%, and there's not waiting for servers.
- **Data:** Insights from data is of strategic importance. Cloud accelerates advanced data analysis. You get away from managing core infrastructure and instead focus on making innovative services available to the company. By using sophisticated data analysis, you can make a personal connection with your customers that stands out in the vast sea of information that washes over us daily.

## Modernization economics

You'll want to consider various strategies for modernization, such as your operating margin, motivation, and infrastructure. Motivators tend to be more around generating new income, generating new operating income, in particular by modernizing and getting more usage of...

- **Operating margin:** Automating ongoing administrative work, like patching, networking, firewall configuration, with the SASS service or pass services that we have. With today's technology and market differentiators and to justify any kind of modernization effort, you want to see some operating income rather than just operating margin.
Generating income
- **Motivators:** generating new income (operating income and margin), modernizing and getting more usage of the technology, creating market differentiators
produces some significant...

- **Infrastructure:** reduce administrative work, patching, firewall administration
Apps and data, getting to market faster, drive innovations, improve delivery time by 50%

You'll want to evaluate your modernization options from both the technical and a financial perspective, which will help you determine whether a set of workloads is a good candidate for modernization.

## Technical indicators

Ask the following common technical questions of your organization when you're evaluating your modernization options.

- **Can you modernize the workload?** What if you have a workload with commercial off-the-shelf solutions (COTS), where you buy a product and run it on servers that can't be modernized, unless the vendor who sold you that product has already done that modernization? These indicators are easy to weed out.
- **Is the business actively investing in maturing these workloads?** Are you investing in workloads that don't create a competitive advantage? Are your workloads built with the support of a consulting firm that's no longer making changes and is running through its life cycle? If your business isn't actively investing in it, should you put in more investment?
- **Will these modernized workloads need to operate in hybrid or multi-cloud environment?** Do you want to manage, govern, and secure apps seamlessly across on-premises infrastructure with public, private, and hybrid cloud capabilities?

## Financial indicators

Ask the following common financial questions of your business when you're evaluating your modernization options.

- **Can you quantify the business value of modernizing these workloads?** Consider whether the business values will lead to revenue and whether you've forecasted that revenue. If the values lead to cost savings, have you forecasted that cost savings? For instance, if you save a little bit of admin time, unfortunately, you can only often times realize that revenue savings if you let go of some of your people. So that's a little bit of a soft cost that's hard to quantify.
- **Have you compared the hosting costs of these workloads in a migrated vs modernized approach?** A lot of times people don't think about that and some modernization efforts can actually increase your cost.
- **Are these workloads considered business-critical?** If outages of a workload truly are business critical and downtime costs you money in the 1,000,000 per hour, the cost of runtime doesn't matter as much. If it's truly business-critical, then it's probably a good candidate for modernization.

In previous modernization articles, we discussed the [modernization motivations](envision-cloud-modernization.md) and mapping different workload categories to those motivations. Some workloads are going to get mapped to multiple modernization motivations, so that's important to look for. To establish realistic expectations for modernization, evaluate modernization paths and dependencies, along with compatibility of your current state.

## Complex evaluations

IN PROGRESS/NEED CONTENT

### Enabling hybrid work

Are your workloads hybrid and portable, or are your workers hybrid?

**Hybrid workers:** Migration only
**Hybrid or portable workloads:** Modernize application platforms
**Don't know:** [Well Architected Review](/assessments/)

### Developer alignment

Doest the cost of modernization exceed your desired cost savings? Do you know what your break even point would be?

**Yes:** Migration only
**No:** Developer alignment
**Don't know:** [Well Architected Review](/assessments/)

## Modernization examples

Let's look at the following examples of modernization for a common web app running on a SQL database, web data layers, and open source data layers.

### Migrating your app to Azure IaaS and Azure SQL Database Managed Instance (MI)

This example is for a common web application running on a database. You could modernize only your SQL database instance, keep the web layer running as is and put it into IAS servers and migrate, or you could choose to modernize your data layer as you go and move from SQL Server on-premises to SQL database managed instances in the cloud. This is ultimately a migration effort, as we haven't changed any of the underlying infrastructure to create capabilities or opportunities to capitalize on cloud benefits.

### Migrating your app to Azure App Service and AzureSQL Database MI

You can modernize both web and data layers. Modernize the data layer by moving it to the database manager instances. We modernize the app by going from a bunch of IAS servers or just VMS over to Azure App Service.

:::image type="content" source="../_images/modernize/example-azure-app-service-azure-sql-database-mi.png" alt-text="Diagram showing flow of migrating to Azure App Service and Azure SQL DB MI.":::

### Migrating your app to App Service and Azure Database for MySQL/PostgreSQL/MariaDB

A different approach would be to modernize your app layer, like we just mentioned, but maybe you're working with some open source data layers and you want to go to something like Azure Database for MySQL, PostgreSQL, or MariaDB.

:::image type="content" source="../_images/modernize/example-app-service-azure-db.png" alt-text="Diagram showing flow of migrating your app to App Service and Azure Database for MySQL and so on.":::
