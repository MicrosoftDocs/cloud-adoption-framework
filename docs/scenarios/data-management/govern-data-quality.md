---
title: Data Quality
description: Learn about data quality
author: mboswell
ms.author: mboswell
ms.date: 02/16/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data quality

Data Quality is a management function of cloud-scale analytics. It resides in the data management landing zone and is a core part of governance.

## Data quality considerations

Data quality is the responsibility of every individual who creates and consumes data products. Those creating should adhere to the global and domain rules. Those consuming should report data inconsistencies to the owning data domain via a feedback loop.

It should start at the top of the organization as it affects all the data provided to the board. The board should have an insight as to the quality of data provided to them.

Being pro-active will still require you to have data quality experts who can go back and clean buckets of data, which appear and require remediation. Avoid pushing this to a central team and instead target the data domain, with the specific data knowledge, to cleanse the data.

### Data quality metrics

Data quality metrics are key to assessing and increasing the quality of your data products. At a global and domain level you need to decide upon your quality metrics. As a start we would recommend the following:

|Metrics  |Metrics Definitions  |
|---------|---------|
| Completeness = % of (non-nulls + non-blanks) | Measures data availability, fields in the dataset that aren't empty, and default values were changed. For example, if a record includes 01/01/1900 as a data of birth, it's highly likely that the field was never populated.|
| Uniqueness = % of non-duplicate values | Measures distinct values in a given column compared to the number of rows in the table. For example, given four distinct color values (red, blue, yellow, and green) in a table with five rows, that field is 80% (or 4/5) unique. |
| Consistency = % of data having patterns | Measures compliance within a given column to its expected data type or format. For example, an email field containing formatted email addresses, or a name field with numeric values. |
| Validity= % of reference matching | Measures successful data matching to its domain reference set. For example, given a country field (complying with Taxonomy values) in a transactional records system, the country value of 'US of A' isn't valid. |
| Accuracy= % of unaltered values | Measures successful reproduction of the intended values across multiple systems. For example, given an invoice itemizes a SKU and Extended Price that differs from the original order, the invoice line item isn't accurate. |
|Linkage = % of well-integrated data | Measures successful association to its companion reference details in another system. For example, given an invoice itemizes an incorrect SKU or Product Description, the invoice line item isn't linkable. |

### Data profiling

Data profiling examines data products registered, in the data catalog, and collects statistics and information about that data. These should be stored, in your metadata repository, against the data product to provide summary and trend views about the data quality over time.

Data profiles helps users answer questions about data products, including:

- Can it be used to solve my business problem?
- Does the data conform to particular standards or patterns?
- What are some of the anomalies of the data source?
- What are possible challenges of integrating this data into my application?

Users should be able to view the data product profile using a reporting dashboard within their data marketplace.

:::image type="content" source="images/data-quality-profile.png" alt-text="Example of data quality profile score report":::

The above picture gives an idea of the items that you might want to report on:

- Completeness – Indicates the percentage of data that isn't blank or null
- Uniqueness – Indicates the percentage of data that doesn't have duplicates
- Consistency – Indicates data where data integrity is maintained

## Data quality recommendations

To implement data quality you need to both human and computational power:

- Solutions that include algorithms, rules, data profiling and metrics.
- Domain experts who can step in when there's a requirement to train an algorithm due to a high number of errors passing through the compute layer.
- Validate early. Traditional solutions have extracted, transformed and loaded data before any data quality has been applied. By this time the data product is already being consumed and errors being surfaced to downstream data products. Instead, as data is ingested from source, data quality checks should be implemented near the sources and before downstream consumers use the data products. If there's batch ingestion from the data lake, these checks should be done when moving data from raw to enriched.

:::image type="content" source="images/adls-dq.png" alt-text="Diagram of how to implement data quality during ingestion.":::

- Before data is moved to enriched layer, its schema and columns are checked against the metadata registered in the data catalog.

- If the data contains errors, the load will be aborted, and data application team should be notified of the failure.

- If the schema and column checks pass, the data is loaded into the enriched layers with conformed data types.

- Before you move into the enriched layer, a data quality process checks for compliance against the algorithms and rules.

> [!TIP]
> Data Quality rules should be defined at both a global and domain level. This allows the business to define it's standards for all data products which are created and allows data domains to create additional rules related to there domain.

[!INCLUDE [data-quality-solutions](includes/data-quality-solutions.md)]

## Data Quality Summary

Fixing data quality, when you are in trouble. can have serious consequences for a business. It can lead to business units interpret data products in different ways. This misinterpretation can prove costly to the business bases decisions upon data products with lower data quality. Fixing data products, with missing attributes, can be an expensive task and could require full reloads of data from # of periods.

Validate data quality early and put processes in to proactively address poor data quality. For example a data product can't be released to production until it achieves X amount of completeness.

Tooling is a free choice but it should include expectations (rules), data metrics, profiling and the ability to secure the expectations so that you can implement global and domain based expectations.

## Next steps

0 [What is Data Lifecycle Management?](govern-lifecycle.md)