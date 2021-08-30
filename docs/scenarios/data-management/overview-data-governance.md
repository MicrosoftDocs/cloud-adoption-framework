---
title: What is data governance for Azure?
description: Learn about data governance for Azure.
author: mboswell
ms.author: mboswell
ms.date: 06/22/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# What is data governance?

Data governance is how you ensure data that's used in your business operations, reports, and analysis is discoverable, accurate, trusted, and can be protected.

There are many reasons why data governance is needed. These reasons include the need to govern data to maintain its quality and the need to protect it. To support this protection, you must discover data in your organization by cataloging, scanning, and classifying your data.

- Data governance is needed to improve data quality, so that data is trusted.
- Data quality is important because when companies work with inferior data, it negatively impacts their downstream insights, analysis, and recommendations.
- Data quality requires that the data is complete, unique, valid, timely, accurate, and consistent.
- Data quality problems can affect business operations. Poor data quality can cause process errors, process delays, unplanned operational costs, and inaccurate decisions.
- Data must be governed across a distributed computing environment.

## Trusted data

For many companies, the expectation in the boardroom is that data and AI will drive competitive advantage. As a result, executives are eager to sponsor AI initiatives in their determination to become data-driven. For AI to become effective, the data it's using must be trusted. Otherwise, decision accuracy might be compromised, decisions might be delayed, or actions might be missed, which can affect on the bottom line. Companies don't want the quality of their data to be "garbage in, garbage out". It might seem simple to fix data quality, until you look at the effect that digital transformation has had on data.

For many companies, the introduction of digital transformation has resulted in a more complex operating environment. The environment spans the edge, multiple clouds, and datacenters. This can mean that both operational and analytical systems are running in the cloud and the datacenter. Examples of operational transaction processing systems that run in the cloud include Microsoft Dynamics, Workday, SalesForce, ServiceNow, and Marketo. Analytical systems that run in the cloud might include data warehouses, graph databases, data lakes used by data scientists, and real-time IoT streaming analytic applications. The result is that companies have a hybrid environment with data in multiple data stores, spread across their digital landscape.

:::image type="content" source="./images/distributed-data-estate.png" alt-text="Diagram of distributed data estate":::

These data stores include data stored in edge databases, relational or NoSQL database management systems, files, cloud storage, Hadoop systems, and scalable message queuing systems, like Kafka.

The other effect of digital transformation is there are many new data sources that organizations want to analyze. These data sources go beyond the traditional data found in data warehouses. These sources include machine generated data like clickstream data in web server log files, human generated data from social networks, inbound email, and open government data. Unstructured content might also be located in various documents in multiple locations.

With data spread out across a hybrid multicloud and a distributed-data landscape, organizations struggle to find where their data is, to govern it. The ungoverned data can have a considerable effect on the business. Poor data quality impacts business operations because data errors cause process errors and delays. Poor data quality also affects business decision making and the ability to remain compliant. To help track and govern data activity, data governance must include:

- Data discovery

- Data quality

- Policy creation

- Data sharing

- Metadata

### The need to protect data

The other major driver for data governance is data protection. Data protection can help you be compliant with regulatory legislation. It can help you prevent data breaches. Data privacy, and the growing number of data breaches, has made data protection a top priority in the boardroom. These breaches highlight the risk to sensitive data, such as personally identifiable customer data. The consequences of data privacy violation or a data security breach are many, and can include:

- Loss or serious damage to brand image

- Loss of customer confidence and market share

- Fall in share price, which impacts stakeholder return on investment and executive salary

- Major financial penalties because of audit or compliance failure

- Legal action

- The "domino effect" of the breach, for example, customers might fall victim to identity theft

In most cases, publicly quoted companies must declare these breaches.

If breaches occur, customers are more likely to blame the company first, rather than the hacker. The customer might boycott the company for several months or might never return.

Failure to comply with regulatory legislation on data privacy might result in significant financial penalties. Governing your data will help you avoid such risks.

## Next steps

[Strategy for data management and analytics adoption in Azure](./strategy.md)
