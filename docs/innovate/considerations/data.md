---
title: "Cloud innovation: Democratize data"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Introduction to Cloud innovation - Democratize data
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Democratize data

Coal, oil, and human potential were the three most consequential assets throughout the Industrial Revolution. These assets built companies, shifted markets, and ultimately changed nations. In the digital economy, there are three equally important assets: data, devices, and human potential. In each of these assets is great innovation potential. Within any innovation effort, data is the new oil.

Across every company today, there are pockets of data which could be leveraged to find and meet customer needs more quickly. Unfortunately, the process of mining that data to drive innovation has long been costly and time-consuming. Many of the most valuable solutions to customer needs go unmet because the right people can't access the data they need.

Democratization of data is the process of getting this data into the right hands to drive innovation. This process can take several shapes but generally includes solutions for ingested or integrated raw data, centralization of the data, sharing the data, and securing the data. When successful, experts around the company can leverage the data to test hypotheses. In many cases, cloud adoption teams can [build with customer empathy](./build.md) using only data, resulting in rapid impact for existing customer needs.

## Process of democratizing data

The following phases will guide the decisions and approaches required to adopt a solution which democratizes data. Each of the phases may not be required to build a specific solution. However, each should be evaluated when building a solution to a customer hypothesis. Each provides a unique approach to the creation of innovative solutions.

![Process for democratizing data](../../_images/innovate/democratize-data.png)

### Share data

When [building with customer empathy](./build.md), all processes focus on a customer need over a technical solution. Democratizing data is no exception, so we start with sharing data. To democratize data, it must include a solution that shares data with a data consumer. The consumer of the data could be a direct customer, or a proxy who makes decisions for customers. Approved data consumers have the ability to analyze, interrogate, and report on centralized data, with no support from IT staff.

Many successful innovations have been launched as MVPs which deliver manual, data-driven processes on behalf of the customer. In this concierge model, an employee is the data consumer. That employee uses data to aid the customer. Each time the customer engages the manual support, a hypothesis can be tested and validated. This approach is often a cost effective means of testing a customer-focused hypothesis before investing heavily in integrated solutions.

The primary tools for sharing data directly with data consumers, includes self-service reporting or data embedded within other experiences, using tools like [Power BI](https://docs.microsoft.com/power-bi).

> [!NOTE]
> Before sharing data, it is important to be aware of the following sections. Sharing data may require governance to provide protection for the shared data. Further that data may be spread across multiple clouds and could require centralization. Much of the data may even reside within applications which will require collection of the data before sharing it.

### Govern data

Sharing data can quickly produce an MVP which can be used in customer conversations. However, data alone is just data. To turn that shared data into actionable knowledge a bit more is often required. Once a hypothesis has been validated through data sharing, the next phase of development is often data governance.

Data governance is a broad topic that could require it's own dedicated framework. This is outside of the scope of the [Cloud Adoption Framework](../../index.md). However, there are a few aspects of data governance that should be considered, as soon as, the customer hypothesis is validated. The following are a few examples of those questions:

- **Is the shared data sensitive?** [Data should be classified](../../govern/policy-compliance/data-classification.md) prior to any public sharing to protect the interests of customers and the company.
- **If the data is sensitive, has it been secured?** Protection of sensitive data should be a requirement for any democratized data. The example workload focused on [securing data solutions](https://docs.microsoft.com/azure/architecture/data-guide/scenarios/securing-data-solutions.md) provides a few references for securing data.
- **Is the data cataloged?** Capturing details about the data being shared will aid in long-term data management. Tools for documenting data, like Azure Data Catalog, can make this process much easier in the cloud. Guidance regarding the [annotation of data](https://docs.microsoft.com/azure/data-catalog/data-catalog-how-to-annotate) and [documentation of data sources](https://docs.microsoft.com/azure/data-catalog/data-catalog-how-to-documentation) can help accelerate the process.

When democratization of data is important to a customer-focused hypothesis, governance of shared data should be somewhere on the release plan to protect customers, data consumers, and the company.

### Centralize data

When data is disrupted across an IT environment, opportunities to innovate can be extremely constrained, expensive, and time consuming. The cloud provides new opportunities to centralize data across various data silos. When centralization of multiple data sources is required to [build with customer empathy](./build.md) the cloud can accelerate the testing of hypotheses.

> [!CAUTION]
> Centralization of data is a common risk point in any innovation process. When data centralization is a [technical spike](./build.md#reduce-complexity-and-delay-technical-spikes), as opposed to a source of customer value, then it is suggested to delay centralization until the customer hypothesis have been validated.

If centralization of data is required the first step is to define the appropriate data store for the centralized data. The advised approach is to establish a data warehouse in the cloud. This scalable option will provide a central location for all data. This type of solution is available in Online Analytical Processing (OLAP) or Big Data options.

The reference architectures for [OLAP](https://docs.microsoft.com/azure/architecture/data-guide/relational-data/online-analytical-processing) and [Big Data](https://docs.microsoft.com/azure/architecture/data-guide/big-data) solutions can aid in choosing the most relevant solution in Azure. If a hybrid solution is required, the reference architecture for [extending on-premises data](https://docs.microsoft.com/azure/architecture/data-guide/scenarios/hybrid-on-premises-and-cloud) may also help accelerate solution development.

> [!IMPORTANT]
> Depending on the customer need and the aligned solution, a simpler solution may be sufficient. The Cloud Architect should challenge the team to consider lower cost solutions that could result in faster validation of the customer hypothesis, especially during early development. The section on collecting data below will outline a few scenarios that may prompt for a different solution.

### Collect data

When data needs to be centralized to deliver a customer need, it is very likely that the data will also need to be collected from various sources and moved into the centralized data store. There are two primary forms of data collection: Integration and Ingestion. Each provides a different means of collecting data.

**Integrate:** Existing data that resides in an existing data store, can be integrated into the centralized data store using traditional data movement techniques. This is especially common for scenarios that involve multicloud data storage. These techniques consist of extracting the data from the existing data store. Then loading the data into the central data store. At some point in this process, the data is often transformed to be more useable and relevant in the central store.

Cloud based tools have turn these techniques into pay-per-use tools, reducing the barrier to entry for data collection and centralization. Tools like Data Migration Service and Data Factory are two common examples in Azure. The reference architecture for [data factory with an OLAP data store](https://docs.microsoft.com/azure/architecture/data-guide/relational-data/etl) provides an example of such a solution.

**Ingest:** Some data isn't in any existing data store. When this transient data is a primary source of innovation, alternative approaches should be considered. Transient data can be found in a variety of existing sources, such as, applications, APIs, data streams, IoT devices, blockchain, application cache, media content, or even flat files.

These various forms of data could be integrated into a central data store on an OLAP or Big Data solution. However, for early iterations of Build - Measure - Learn cycles, an Online Transactional Processing (OLTP) solution may be more than sufficient to validate a customer hypothesis. OLTP solutions are not the highest quality solution for any reporting scenario. However, when [building with customer empathy](./build.md) focus on the customer need takes priority over technical tooling decisions. Once the customer hypothesis is validated at scale, a more suitable platform may be required. The reference architecture on [OLTP data stores](https://docs.microsoft.com/azure/architecture/data-guide/relational-data/online-transaction-processing) can aid in determining which data store is most appropriate for your solution.

**Virtualize:** Integration and ingestion of data can sometimes slow innovation. When a solution for data virtualization is already available, this may be a more relevant approach. Ingestion and Integration can both duplicate storage/development requirements, add data latency, increase attack surface area, inject quality issues, and increase governance efforts. Data virtualization is a more modern alternative that leaves the original data in a single location and creates pass-through or cached queries of the source data.

SQL Server 2017 and Azure SQL Data Warehouse both support [PolyBase](/sql/relational-databases/polybase/polybase-guide) which is the approach to data virtualization most commonly used in Azure.

## Next steps

With a strategy for democratizing data in place, the next step is to evaluate approaches to [engaging customers through apps](./apps.md).

> [!div class="nextstepaction"]
> [Engaging customers through apps](./apps.md)
