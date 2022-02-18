---
title: observability 
description: Learn about data mesh observability in azure
author: sudivate
ms.author: mboswell
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data Observability

## What is Data Observability?

Data Observability is the ability to understand the health of data and data systems by collecting and correlating events across the  areas like data, storage, compute and processing pipelines.  

## Why we need Data Observability?

Data Platforms are becoming complex across all foundational layers, including data ingestion, data storage and processing, data transformation and modeling, business intelligence and analytics, data discovery, and governance. Building and operating a resilient, scalable, and performant data platform requires adopting proven DevOps-inspired processes across teams that represent functional domains. Data Observability enables business owners, DevOps engineers, data architects, data engineers, and site reliability engineers to detect, predict, prevent, and resolve issues in an automated fashion and avoid eliminating downtime that would otherwise break production analytics and AI.

## Data Observability Areas

Here are some key areas of Data Observability on which most data platform operates:

1. [Data Platform Service Monitoring](#data-platform-service-monitoring)
1. [Data Pipeline Performance Monitoring](#data-pipeline-performance-monitoring)
1. [Data Quality Monitoring](#data-quality-monitoring)
1. [Data Lineage](#data-lineage)
1. [Data Discovery](#data-discovery)

End-to-end Data Observability involves not just capturing events and measuring metric across all these components but also correlating them to get a comprehensive visibility into the health and reliability of enterprise data environment.

Let's understand each component and how it contributes to achieve Data Observability.

### Data Platform Service Monitoring

Foundational infrastructure for an enterprise data platform can include a mix of both provider-managed and self-managed infrastructure for enabling storage and computing. DevOps engineers platform or Infrastructure engineers need to monitor this foundational infrastructure to identify and act on systems outages and performance bottles necks that affect modern data and analytics pipelines. Monitoring data from databases and networking layers can help in improving the processing throughput and minimizing network latency. Teams needs tools that they can use to capture metrics, notify, track, and remediate incidents and correlate with the data and analytics issues.

We recommend that teams start incorporating observability-as-code into their infrastructure-as-code layer to enable this kind of instrumentation out-of-box at the resource creations. Most Azure services offer out-of-box instrumentation on key resource metrics, including diagnostic data.

### Data Pipeline Performance Monitoring

Increasingly complex data pipelines with multiple stages and dependencies generate massive amounts of monitoring data that includes events, metrics and logs. Collecting and analyzing these monitoring data can help optimize the performance of the data pipelines. Data teams must investigate the state of these pipelines across multiple related data products and business domains. Getting notified on failure or running longer than expected will allow teams to remediate and minimize any downtime. Correlating this data with platform service monitoring data helps craft useful performance tuning recommendations like boosting CPU and memory for high load data pipelines.

### Data Quality Monitoring

Data quality is the degree to which data is accurate, complete, timely, and consistent with your business's requirements. Constantly inspecting data sets for quality is necessary to bring reliability and trust into the data applications powered by these data sets. Measuring Data Quality isn't new as DataOps has been implementing the process to improve data reliability and performance through automating Data quality tests (Unit, Functional, Integration), promoting faster and more efficient fault detection and analytics.

To adopt DevOps and SRE principles into data quality, teams must build repeatable, iterative processes and frameworks to catch data quality issues, track them in dashboards, and alert on any deviations. Such data quality can track TTD, TTR, and other data quality metrics.

Time to Detection (TTD) describes the length of time it takes for your data team to surface a data quality issue of any kind, from freshness anomalies to schema changes that break entire pipelines. Time to Resolution (TTR) refers to how quickly your team can resolve a data incident once alerted. Improving data quality is more than a technical challenge and involves significant organizational and cultural support.

The governance section on [Data quality](govern-data-quality.md) explores how to implement data quality within the scenario.

### Data Lineage

Data lineage is broadly understood as the lifecycle that spans the data's origin, and where it moves over time across the data estate. It's used for different kinds of backward-looking scenarios such as troubleshooting, tracing root causes in data pipelines, and debugging. Lineage is also used for data quality analysis, compliance, and "what if" scenarios often referred to as impact analysis. Lineage is represented visually to show data moving from source to destination including how the data was transformed.

The governance section on [Data Lineage](govern-lineage.md) explores how to implement data lineage within the scenario.

### Data Discovery

Data discovery is the first step for a data analytics or data governance workload for data consumers.  In an enterprise data lake platform, data consumers like data scientists and analysts find it difficult to locate the data that they need and evaluate its reliability. Data catalogs with accurate metadata make a difference by offering an index of data that enables locating available data, detecting its quality, understanding its structure and lineage, and getting access to it. Data catalogs that offer search capabilities on this metadata speed the process of data discovery.

The governance section on [Data Catalog](govern-data-catalog.md) explores how to implement data discovery within the scenario.

## How to set SLAs, SLIs and SLOs

Inspired from DevOps culture and to achieve data monitoring; teams can adopt the same culture of Site Reliability Engineering (SRE) by using Service Level Objectives (SLOs), Service Level Agreements (SLAs), and Service Level Indicators (SLIs) to reduce data downtime and ensure data reliability.

Service level agreements (SLAs) require well-defined service level indicators (SLIs), quantitative measures of service quality, and agreed-upon service level objectives (SLOs), the ideal values or ranges each indicator should meet.

Setting data SLAs requires active participation and collaboration among all the stakeholders that will be affected by SLA. These stakeholders can be data producers, data engineers, data analysts, data consumers, business analysts but not limited to.

For data application teams, setting reliability SLAs usually includes three steps: defining, measuring, and tracking.

### Service Level Agreement (SLA)

Start with what reliability means and agree upon the definition among all key stakeholders including data engineers, data consumers, and business leaders. Ensure every key stakeholder is involved and buy on the definition of reliability especially if the downstream consumers are from different teams or operate from the different geographical regions and time zone. The SLA needs to be carefully crafted if data consumers are external paid customers and usually involves legal team. For internal customers the SLA definition should include key agreed areas like data promise, data quality and process to handle data incidents if the promise isn't met.

***Contoso:** Contoso is a media company that runs enterprise data lake, which powers multiple data products across different business domains. The Data application team is responsible for delivering yesterday's sales data that powers the sales dashboard. When they miss the data delivery or deliver incomplete data, the data engineering team faces frustrated executive emails and must manually triage the broken pipeline that delivers data. To measure and improve on their deliverables, the data team sets an SLA with the Sales team using the template below*

#### Service Level Agreement - Data Team to Sales Team

| Agreement | Description |
|----|----|
| **Business Area** | The Data team promises to empower sales team to make data driven decisions|
|**Promise** | The Data promise to deliver yesterday's sales data that powers the sales dashboard.<br> This data can answer sales and conversion rates for all US regions.<br> Data pipelines will deliver data powering sales dashboard before 6:00 UTC|
|**Data Quality**| **Null Check:** Customer names can't be Null.<br> **Missing Value:** Customer region can't be missing.<br> **Freshness:** Sales date should include any transaction before 24:00 UTC|
|**Data Incident Management**|If the above promise of data delivery isn't met sales team can report the problem and we promise to resolve the problem with the TTR < 6 Hours|

### Service Level Indicators (SLI)

SLI should represent the agreed-upon state in the SLA. Start with identifying key metrics that can be traced and measured to achieve agreed SLA.

***Contoso:** Data team identified key metric from different areas to meet the above agreed SLA. They also built Dashboard and alerts if the key metrics deviate from the set baseline and automated actions to mitigate a few issues.*

|Metric|Purpose|
|------|-----|
|Spark cluster CPU and Memory usage|To measure any performance bottle neck in the underlying infrastructure used to run data pipelines|
|Pipeline total run time in mins| To measure if pipeline takes more time than expected to run|
|Pipeline failed and success rate| To measure data pipelines that failed or succeeded|
|Data quality Metrics (Downstream)| To ensure the data delivered by the data pipeline meets expectations|
|Data quality metric (Upstream)| To ensure that upstream decencies of raw data quality are met|
|Transformation Metadata is update succeeded| To ensure lineage from upstream to downstream holds metadata about transformations applied on it|
|Downstream data is indexed update in data catalog| To ensure the sales discover data sets that power their dashboard|
|Defined process to create incident and measure TTD and TTR| To measure TTD and ensure TTR < 6 hours|

### Service Level Objective (SLO)

After SLI is identified team can now craft SLO. SLO consists of SLI, the duration over which the SLI is measured, and the targeted success rate that is practically achievable. Defining the course and targeted success can be an overwhelming task initially, and the goal isn't to expect perfection but rather a steady improvement over multiple iterations.

***Contoso:** Data team delivers sales data 365 days across seven different US regions. If there are 210 data sets delivered every calendar year across all regions only 200 data sets are complete and met the SLA. This translates to 95.99% success for that month with acceptable error rate of 4%, which translates to 10 failed(incomplete) data sets. Data team creates a monitoring dashboard that tracks aggregated SLI to track this SLO over the period of 30 days. Both the data team and sales team are notified when target success rate isn't achieved.*

SLO can depend on:

- Data Product
- Data Category
- Data Source Regions
- Components of Data Observability (defined above)

## Data Observability Maturity Model

Data Observability is an essential aspect of the DataOps framework. Attaining the highly advanced stage of Data Observability should be the goal of every enterprise that wants to get the most value out of it. Therefore, it should be considered in parallel to improve your DataOps processes. Data Observability is more of a journey than a goal. The maturity model below can help assess the current state and decide on the next steps in the journey.

|**Stage**|Data Platform Service Monitoring|<p>Data Pipeline Performance Monitoring</p>|<p>Data Quality Monitoring</p>|Data Lineage|Data Discovery|
| :- | :- | :- | :- | :- | :- |
|<p></p><p></p><p></p><p>**Stage 5**</p><p>**Highly Advanced** </p>|<p>Data Collected across all the Data Observability Components from one or more data products, offers a unified view and correlated using machine learning to find anomalies.</p><p></p><p>Dashboards track SLO, SLA SLI across all the Data Observability components.</p><p></p><p>Data teams and business leaders speaks SRE language (SLO, SLA, SLI) and Dashboards tracks these   </p><p></p>|<p>Data pipeline performance metrics are tracked across multiple data products.</p><p></p><p></p><p>Root cause analysis is completed driven by system.</p><p></p>|<p>High Level of Data Trust is established, and data consumers can verify reliability of data. </p><p></p>|Data lineage is visually represented and used more than one scenario like tracing root cause analysis in pipeline failure, data quality analysis and compliance. |<p>Data consumers can easily discover available data that they need for their data products.</p><p></p>|
|<p></p><p></p><p>**Stage 4**</p><p>**Advanced**</p>|<p>Dashboards track SLO, SLA SLI across the most critical 3+ the Data Observability components.</p><p></p><p>Data platform monitoring data is now correlated to data pipeline performance monitoring with automation.  </p><p></p>|<p>Data Incident tools monitors and measure TTD and TTR metric on Incidents. </p><p></p>|Data Quality is achieved through framework that is reusable across multiple data products and tracked through dashboards.|Data lineage is now connected to data discoverability and includes data quality tags as well.|Data lineage is now connected to data discoverability and includes data quality tags as well.|
|<p></p><p></p><p></p><p>**Stage 3**</p><p>**Evolving** </p>|<p>Well defined SLO, SLI and SLA that covers most critical almost all components for Data Observability.</p><p></p><p>Data incidents are managed through specialized tools </p><p></p>|<p>Data platform monitoring data is now correlated to data pipeline performance monitoring and includes automation to some extent.</p><p></p>|<p>Data quality checks are well defined and mapped to custom metrics that are collected. </p><p></p>|<p>Data lineage is matured to gold enough metadata required for decision making.</p><p></p>|<p>Data discoverability is achieved with specialized Data catalogs tools </p><p></p>|
|<p></p><p></p><p></p><p>**Stage 2** </p><p>**Planning** </p>|<p>We have initial draft of SLO, SLA and SLI that covers most critical three or more components for Data Observability. </p><p></p><p>Data Platform Monitoring Data is centralized with unified view of entire Data environment.</p><p></p><p>Data Incident management is all manual, triaging done with some knowledge of where to look for.</p>|<p>Data pipelines performance metric's are defined and measured. </p><p></p>|<p>Data quality checks are mostly part of transformation with no standard metric defined, measured, and visualized.</p><p></p>|Data Linage isn't tracked or is limited to single data product. |Data discoverability is documented but lack sophisticated tools.|
|<p></p><p></p><p>**Stage 1**</p><p>**Learning** </p>|Monitor every critical platform service (Provider managed and self-managed in our Data landscape.  |<p>Notified on pipelines are success/fails. But we don't have any insights on why the pipeline failed or why it's taking longer time than expected to run.   </p><p></p>|<p>Few DQ tests that are run from the pipeline but don't monitor the metric on DQ. </p><p></p>|Data Lineage doesn't exist. |Data Discoverability doesn't exist. We point where the data is located through collaboration tool. |
