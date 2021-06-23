---
title: "What is data governance?"
description: What is data governance?
author: mboswell
ms.author: mboswell
ms.date: 06/22/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# What is data governance?

Data governance is about ensuring that the data being used in your core business operations, reports and analyses is discoverable, accurately defined, and is totally trusted and can be protected.

There are many reasons why data governance is needed. These include the need to govern data to maintain its quality as well as the need to protect it. This entails the prerequisite need to discover data in your organization with cataloguing, scanning, and classifying your data to support this protection.

- Data governance is needed to improve data quality so that data is trusted.
- Data quality if of utmost importance because when companies work with inferior data, this negatively impacts their downstream insights, analyses, and recommendations.
- Data quality must entail the data is complete, unique, valid, timely, accurate, and consistent.
- Data quality problems can impact on business operations causing process errors, process
- delays, unplanned operational costs and inaccurate decisions.
- Data needs to be governed across a distributed computing environment

## Trusted Data

In many companies today, the expectation in the board room is that data and artificial intelligence (AI) will drive competitive advantage. Not surprisingly therefore, executives are eager to sponsor AI initiatives in their determination to become data driven. However, for AI to become effective, the data it is using must be trusted. Otherwise decision accuracy may be compromised, decisions may be delayed, or actions missed which impacts on the bottom line. Companies do not want 'garbage in, garbage out'. It might seem relatively straight forward to fix data quality until you look at the impact that digital transformation has had on data in the last few years.

For most companies, the introduction of digital transformation has resulted in a more complex operating environment in comparison to just having a single data centre. Today, most companies have created an operating environment that spans the edge, multiple clouds and the data centre. Surveys over the last couple of years have shown this with one2 last year showing 81% of companies surveyed had systems running in multiple public clouds and one or more private / dedicated clouds. That typically translates to meaning that both operational and analytical systems are running in the cloud and the data centre. Examples of operational transaction processing systems running in the cloud include Microsoft Dynamics, Workday, Salesforce, ServiceNow and Marketo. Analytical systems running in the cloud could include data warehouses, graph databases, data lakes being used by data scientists and real-time IoT streaming analytic applications. The result is that companies are now dealing with a hybrid environment with data in multiple different data stores that are scattered across all of this landscape similar to that shown in Figure 1.

:::image type="content" source="images/distributed-data-estate.png" alt-text="distributed data estate":::

*Figure 1: Distributed Data Estate*

This includes data stored in edge databases relational DBMSs, NoSQL DBMSs, Files, Cloud storage, Hadoop systems and scalable messaging queuing systems (e.g. Kafka).

The other major impact of digital transformation is that there are a lot of new data sources that business now wants to analyze beyond the traditional master data and transaction data found in data warehouses. This includes machine generated data such as clickstream data in web server log files, human generated data from social networks, inbound email, and open government data. Also, unstructured content in various documents is in multiple locations.

With data increasingly spreading out across a hybrid multi-cloud, distributed data landscape, it is not surprising that people are struggling to know where it is in order to govern it. Yet, the business impact from ungoverned data can be considerable. Poor data quality impacts business operations because data errors cause process errors and delays. Poor quality data also impacts business decision making and the ability to remain compliant. Data governance needs to therefore include data discovery, data quality, policy creation, data sharing, and metadata to help track and govern data activity.

### The need to protect data

The other major driver for data governance is data protection. This is needed primarily to remain compliant on data privacy with regulatory legislation such as the European Union General Data Protection Regulation (GDPR) or the California Consumer Privacy Act (CCPA) and to prevent data breaches. Data privacy as well as the growing number of data breaches has made data protection a top priority in the boardroom. These breaches highlight the risk to sensitive data such as personally identifiable customer data. The consequences of data privacy violation and / or a data security breach are numerous and include:

- Loss or serious damage to brand image
- Loss of customer confidence and market share
- Fall in share price which impacts stakeholder return on investment and executive salary
- Major financial penalties as a result of audit/compliance failure
- Legal action
- The 'Domino effect' of the breach, e.g. Customers may also fall victim to identity theft as

Also, in most cases, publicly quoted companies must declare these breaches.

If they happen, customers are more likely to blame the company first rather than the hacker
and may boycott the company for several months or may never return.

Failure to comply with regulatory legislation like GDPR and CCPA on data privacy may also result in several very significant financial penalties. No one wants any of this and so governing data to avoid such risks is well worth doing.
