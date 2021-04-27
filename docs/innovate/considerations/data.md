---
title: Democratize data for minimum viable products
description: Create a minimum viable product to start your development. Learn about data democratization—the process of getting data to test hypotheses and drive innovation.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom:
 - internal
 - seo-caf-innovate
keywords: What is data democratization, data democratization, democratize data, minimum viable product, data centralization
---

# Democratize data with digital invention

Coal, oil, and human potential were the three most consequential assets during the industrial revolution. These assets built companies, shifted markets, and ultimately changed nations. In the digital economy, there are three equally important assets for innovation—data, devices, and human potential. Data is the new oil.

In every company there is data that can be used to find and meet customer needs. Unfortunately, the process of mining that data to drive innovation can be costly and time-consuming, so needs aren't discovered and solutions aren't created. Data democratization can solve this problem.

What is data democratization? It is the process of getting data into the hands of those who need it, including the innovators. When data is democratized, experts around the company can use it to form and test hypotheses. In many cases, cloud adoption teams can [build with customer empathy](./build.md) using only data, to rapidly meet customer needs.

## Ways to democratize data

There are various ways to democratize data, but most include methods of collecting, centralizing, governing, and sharing the data. The following sections describe some of these methods. When you build a solution to a customer hypothesis, you should assess whether to democratize data, to what extent, and how to do it.

![Process for democratizing data, shows these processes: Govern, Centralize, Collect, and Share data.](../../_images/innovate/democratize-data.png)

### Share data

When you build with customer empathy, customer needs guide the solution. If the need is data, the solution enables the customer to interrogate, analyze, and report on the data directly, with no support from IT staff.

Many successful innovations start as a minimum viable product (MVP) that delivers data to the customer. An MVP has just enough features to be usable and to show the product's potential. The purpose of starting with a minimal product is to get feedback on the product idea quickly. In this concierge model, an employee is the data consumer. That employee uses data to aid the customer. Each time the customer engages manual support, a hypothesis can be tested and validated. This approach is often a cost effective means of testing a customer-focused hypothesis before you invest heavily in integrated solutions.

The primary tools for sharing data directly with data consumers include self-service reporting, using tools like [Power BI](/power-bi/), or data embedded within other experiences.

> [!NOTE]
> Before you share data, make sure you've read the following sections. Sharing data might require governance to provide protection for the data. Also, if the data spans multiple clouds it may require centralization. If data reside within applications, you must collect it in order to share it.

### Govern data

Sometimes sharing data can quickly produce a minimum viable product to use in customer conversations. However, to turn that shared data into useful and actionable knowledge, more is generally required.

After a hypothesis has been validated through data sharing, the next phase of development is typically data governance.

Data governance is a broad topic that can require its own dedicated framework, a matter that's outside the scope of the [Cloud Adoption Framework](../../index.yml). 

There are several aspects of data governance to consider as soon as you validate the customer hypothesis. For example:

- **Is the shared data sensitive?** [Data should be classified](../../govern/policy-compliance/data-classification.md) before being shared publicly to protect the interests of customers and the company.
- **If the data is sensitive, has it been secured?** Protection of sensitive data is a must for democratized data. The example workload discussed in [securing data solutions](/azure/architecture/data-guide/scenarios/securing-data-solutions) provides some references for securing data.
- **Is the data cataloged?** Identifying the nature of the shared data aids in long-term data management. Tools for documenting data, like [Azure Data Catalog](https://azure.microsoft.com/services/data-catalog/), make this process much easier in the cloud. Guidance regarding the [annotation of data](/azure/data-catalog/data-catalog-how-to-annotate) and the [documentation of data sources](/azure/data-catalog/data-catalog-how-to-documentation) can accelerate the process.

When democratization of data is important to a customer-focused hypothesis, make sure the governance of shared data is in the release plan. This protects customers, data consumers, and the company.

### Centralize data

When data is centralized, it can be available across your organization to accommodate meaningful reporting, increasing your return on investment. But when data is dispersed, sharing and innovation are slow and costly. The cloud provides new opportunities to centralize dispersed data. The cloud supports data centralization and accelerates testing of hypotheses.

> [!CAUTION]
> If centralizing data takes resources away from innovation, it may slow innovation rather than speed it up. In such cases, we suggest that you postpone centralization until the customer hypotheses have been validated.

When you centralize, you need an appropriate data store for the centralized data. It's a good practice to establish a data warehouse in the cloud. This scalable option provides a central location for all your data. This type of solution is available in online analytical processing (OLAP) or big data options.

The reference architectures for [OLAP](/azure/architecture/data-guide/relational-data/online-analytical-processing) and [big data](/azure/architecture/data-guide/big-data/) solutions can help you choose the most appropriate centralization solution in Azure. If a hybrid solution is required, the reference architecture for [extending on-premises data](/azure/architecture/data-guide/scenarios/hybrid-on-premises-and-cloud) can also help accelerate solution development.

### Collect data

> [!IMPORTANT]
> For some customer needs and solutions, a simple approach may be enough. The cloud architect should challenge the team to find fast, low-cost solutions to validate the customer hypothesis, especially during early development. This section discusses cases that may suggest better solutions for centralizing data.

The two primary forms of data collection are *integration* and *ingestion*.

- **Integration** refers to moving data to the central data store from an existing data store—a common approach when the data is in a different cloud than the data store. Typically, data that is moved is also transformed to be more usable and relevant.
- **Ingestion** refers to moving data to the central data store from a source other than a data store. Such data is found in a variety of existing sources, such as: applications, APIs, data streams, IoT devices, blockchains, application caches, and flat files.

You can often use pay-per-use cloud tools to implement data collection techniques, which reduces costs. Tools like [Azure Database Migration Service](https://azure.microsoft.com/services/database-migration/) and [Azure Data Factory](https://azure.microsoft.com/services/data-factory/) are examples. The reference architecture for [Data Factory with an OLAP data store](/azure/architecture/data-guide/relational-data/etl) is a data collection example solution.

You can integrate these various forms of data into a central data store on an OLAP or big data solution. However, for early iterations of the build-measure-learn cycle, an online transaction processing (OLTP) solution might be enough to validate a customer hypothesis. After the customer hypothesis is validated at scale, a more suitable platform might be required. The reference architecture on [OLTP data stores](/azure/architecture/data-guide/relational-data/online-transaction-processing) can help you determine which data store is most appropriate for your solution.

**Data virtualization** is a data democratization technique that leaves data in place and allows applications to use it in a convenient form. When appropriate tools are available, virtualization may have some of these advantages:

- Quicker to implement
- Quicker access
- Fresher data
- Reduced storage duplication
- Better security
- Easier governance

SQL Server 2017 and Azure SQL Data Warehouse both support [PolyBase](/sql/relational-databases/polybase/polybase-guide), which is the approach to data virtualization most commonly used in Azure.

## Next steps

With a strategy for democratizing data in place, you'll next want to evaluate approaches to application development.

> [!div class="nextstepaction"]
> [Application development for innovative apps](./apps.md)
