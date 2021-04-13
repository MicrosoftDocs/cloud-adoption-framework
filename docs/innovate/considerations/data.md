---
title: Democratize data with digital invention
description: Learn about democratization, the process of getting data into the right hands to test hypotheses and drive innovation.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: internal
---

# Democratize data with digital invention

Coal, oil, and human potential were the three most consequential assets during the industrial revolution. These assets built companies, shifted markets, and ultimately changed nations. In the digital economy, there are three equally important assets: data, devices, and human potential. Each of these assets holds great innovation potential. For any innovation effort in the modern era, data is the new oil.

Across every company today, there are pockets of data that could be used to find and meet customer needs more effectively. Unfortunately, the process of mining that data to drive innovation has long been costly and time-consuming. Many of the most valuable solutions to customer needs go unmet because the right people can't access the data they need.

Democratization of data is the process of getting this data into the right hands to drive innovation. This process can take several forms, but they generally include solutions for ingested or integrated raw data, centralization of data, sharing data, and securing data. When these methods are successful, experts around the company can use the data to test hypotheses. In many cases, cloud adoption teams can [build with customer empathy](./build.md) using only data, and rapidly addressing existing customer needs.

## Process of democratizing data

The following phases will guide the decisions and approaches required to adopt a solution that democratizes data. Not every phase will necessarily be required to build a specific solution. However, you should evaluate each phase when you're building a solution to a customer hypothesis. Each provides a unique approach to the creation of innovative solutions.

![Process for democratizing data](../../_images/innovate/democratize-data.png)

### Share data

When you [build with customer empathy](./build.md), all processes elevate customer need over a technical solution. Because democratizing data is no exception, we start by sharing data. To democratize data, it must include a solution that shares data with a data consumer. The data consumer could be a direct customer or a proxy who makes decisions for customers. Approved data consumers can analyze, interrogate, and report on centralized data, with no support from IT staff.

Many successful innovations have been launched as a minimum viable product (MVP) that deliver manual, data-driven processes on behalf of the customer. In this concierge model, an employee is the data consumer. That employee uses data to aid the customer. Each time the customer engages manual support, a hypothesis can be tested and validated. This approach is often a cost effective means of testing a customer-focused hypothesis before you invest heavily in integrated solutions.

The primary tools for sharing data directly with data consumers include self-service reporting or data embedded within other experiences, using tools like [Power BI](/power-bi).

> [!NOTE]
> Before you share data, make sure you've read the following sections. Sharing data might require governance to provide protection for the shared data. Also, that data might be spread across multiple clouds and could require centralization. Much of the data might even reside within applications, which will require data collection before you can share it.

### Govern data

Sharing data can quickly produce an MVP that you can use in customer conversations. However, to turn that shared data into useful and actionable knowledge, a bit more is generally required. After a hypothesis has been validated through data sharing, the next phase of development is typically data governance.

Data governance is a broad topic that could require its own dedicated framework. That degree of granularity is outside the scope of the [Cloud Adoption Framework](../../index.yml). However, there are several aspects of data governance that you should consider as soon as the customer hypothesis is validated. For example:

- **Is the shared data sensitive?** [Data should be classified](../../govern/policy-compliance/data-classification.md) before being shared publicly to protect the interests of customers and the company.
- **If the data is sensitive, has it been secured?** Protection of sensitive data should be a requirement for any democratized data. The example workload focused on [securing data solutions](/azure/architecture/data-guide/scenarios/securing-data-solutions) provides a few references for securing data.
- **Is the data cataloged?** Capturing details about the data being shared will aid in long-term 'data management and analytics'. Tools for documenting data, like Azure Data Catalog, can make this process much easier in the cloud. Guidance regarding the [annotation of data](/azure/data-catalog/data-catalog-how-to-annotate) and the [documentation of data sources](/azure/data-catalog/data-catalog-how-to-documentation) can help accelerate the process.

When democratization of data is important to a customer-focused hypothesis, make sure the governance of shared data is somewhere in the release plan. This will help protect customers, data consumers, and the company.

### Centralize data

When data is disrupted across an IT environment, opportunities to innovate can be extremely constrained, expensive, and time-consuming. The cloud provides new opportunities to centralize data across data silos. When centralization of multiple data sources is required to [build with customer empathy](./build.md), the cloud can accelerate the testing of hypotheses.

> [!CAUTION]
> Centralization of data represents a risk point in any innovation process. When data centralization is a [technical spike](./build.md#reduce-complexity-and-delay-technical-spikes), and not a source of customer value, we suggest that you delay centralization until the customer hypotheses have been validated.

If centralization of data is required, you should first define the appropriate data store for the centralized data. It's a good practice to establish a data warehouse in the cloud. This scalable option provides a central location for all your data. This type of solution is available in online analytical processing (OLAP) or big data options.

The reference architectures for [OLAP](/azure/architecture/data-guide/relational-data/online-analytical-processing) and [big data](/azure/architecture/data-guide/big-data) solutions can help you choose the most relevant solution in Azure. If a hybrid solution is required, the reference architecture for [extending on-premises data](/azure/architecture/data-guide/scenarios/hybrid-on-premises-and-cloud) can also help accelerate solution development.

> [!IMPORTANT]
> Depending on the customer need and the aligned solution, a simpler approach may be sufficient. The cloud architect should challenge the team to consider lower cost solutions that could result in faster validation of the customer hypothesis, especially during early development. The following section on collecting data covers some scenarios that might suggest a different solution for your situation.

### Collect data

When you need data to be centralized to address a customer need, it's very likely that you'll also have to collect the data from various sources and move it into the centralized data store. The two primary forms of data collection are *integration* and *ingestion*.

**Integration:** Data that resides in an existing data store can be integrated into the centralized data store by using traditional data movement techniques. This is especially common for scenarios that involve multicloud data storage. These techniques involve extracting the data from the existing data store and then loading it into the central data store. At some point in this process, the data is typically transformed to be more usable and relevant in the central store.

Cloud-based tools have turned these techniques into pay-per-use tools, reducing the barrier to entry for data collection and centralization. Tools like Azure Database Migration Service and Azure Data Factory are two examples. The reference architecture for [Data Factory with an OLAP data store](/azure/architecture/data-guide/relational-data/etl) is an example of one such solution.

**Ingestion:** Some data doesn't reside in an existing data store. When this transient data is a primary source of innovation, you'll want to consider alternative approaches. Transient data can be found in a variety of existing sources like applications, APIs, data streams, IoT devices, a blockchain, an application cache, in media content, or even in flat files.

You can integrate these various forms of data into a central data store on an OLAP or big data solution. However, for early iterations of the build-measure-learn cycle, an online transactional processing (OLTP) solution might be more than sufficient to validate a customer hypothesis. OLTP solutions aren't the best option for any reporting scenario. However, when you're [building with customer empathy](./build.md), it's more important to focus on customer needs than on technical tooling decisions. After the customer hypothesis is validated at scale, a more suitable platform might be required. The reference architecture on [OLTP data stores](/azure/architecture/data-guide/relational-data/online-transaction-processing) can help you determine which data store is most appropriate for your solution.

**Virtualize:** Integration and ingestion of data can sometimes slow innovation. When a solution for data virtualization is already available, it might represent a more reasonable approach. Ingestion and integration can both duplicate storage and development requirements, add data latency, increase attack surface area, trigger quality issues, and increase governance efforts. Data virtualization is a more contemporary alternative that leaves the original data in a single location and creates pass-through or cached queries of the source data.

SQL Server 2017 and Azure SQL Data Warehouse both support [PolyBase](/sql/relational-databases/polybase/polybase-guide), which is the approach to data virtualization most commonly used in Azure.

## Next steps

With a strategy for democratizing data in place, you'll next want to evaluate approaches to [engaging customers through applications](./apps.md).

> [!div class="nextstepaction"]
> [Engaging customers through applications](./apps.md)
