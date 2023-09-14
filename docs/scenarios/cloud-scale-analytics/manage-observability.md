---
title: Data observability 
description: Learn about data mesh observability in Azure.
author: sudivate
ms.author: mboswell
ms.date: 03/18/2022
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data observability

Data observability is your ability to understand the health of your data and data systems by collecting and correlating events across areas like data, storage, compute and processing pipelines.  

Building and operating a resilient, scalable, and performant data platform requires adopting proven DevOps-inspired processes across teams that represent functional domains. Data observability enables business owners, DevOps engineers, data architects, data engineers, and site reliability engineers to automate issue detection, prediction, and prevention, and to avoid downtime that can break production analytics and AI.

## Key areas of data observability

Most data platforms operate on these key areas of data observability:

- [Data Platform Service Monitoring](#data-platform-service-monitoring)
- [Data Pipeline Performance Monitoring](#data-pipeline-performance-monitoring)
- [Data Quality Monitoring](#data-quality-monitoring)
- [Data Lineage](#data-lineage)
- [Data Discovery](#data-discovery)

End-to-end data observability involves not just capturing events and measuring metrics across all these components but also correlating those events and metrics. This provides a comprehensive view of your enterprise data environment's health and reliability.

This article describes each component and how it contributes to achieving data observability.

### Data platform service monitoring

Foundational infrastructure for an enterprise data platform can include a mix of both provider-managed and self-managed infrastructure to enable storage and computing. DevOps engineers or infrastructure engineers need to monitor this foundational infrastructure so they can identify and resolve system outages and performance bottlenecks that affect modern data and analytics pipelines.

Monitoring data from databases and networking layers can improve your processing throughput and minimize network latency. Teams needs tools that they can use to capture metrics, notify, track, and remediate incidents and correlate with the data and analytics issues.

We recommend that your teams incorporate observability-as-code into your infrastructure-as-code layer so monitoring instrumentation is enabled out-of-box as soon as they create a resource. Most Azure services offer out-of-box instrumentation for key resource metrics like diagnostic data.

### Data pipeline performance monitoring

Increasingly complex data pipelines containing multiple stages and dependencies now generate massive amounts of monitoring data. This data includes events, metrics, and logs. You can optimize your data pipeline performance by collecting and analyzing monitoring data.

Your data teams should track the state of your data pipelines across multiple related data products and business domains. When your team is notified early about failures or runtimes that are longer than expected, they can minimize and remediate downtime. Correlation of pipeline monitoring data and platform service monitoring can provide recommendations for performance tuning, such as boosting CPU and memory for your high load pipelines.

### Data quality monitoring

Data quality is the degree to which your data is accurate, complete, timely, and consistent with your organization's requirements. You need to constantly monitor your data sets for quality to ensure that the data applications they power remain reliable and trustworthy. DataOps has been consistently improving data reliability and performance by automating data quality tests (unit, functional, and integration). These improvements make faster and more efficient fault detection and data analytics possible.

To adopt DevOps and SRE principles into data quality, teams must build repeatable, iterative processes and frameworks to catch data quality issues, track those issues in dashboards, and set up alerts for any deviations.

Time to Detect (TTD), Time to Recovery (TTR), and other data quality metrics can be tracked from your data quality monitoring. TTD refers to the length of time it takes for your data team to detect a data quality issue of any kind, from freshness anomalies to schema changes that break entire pipelines. TTR refers the length of time it takes for your team to resolve a data incident once alerted. Improving your data quality is more than a technical challenge; it involves significant organizational and cultural support.

The governance section on [data quality](govern-data-quality.md) explores how you can implement data quality within your scenario.

### Data lineage

Data lineage is broadly understood as a continuous record that follows your data's origin, transformations, and movement over time across your data estate. Data lineage is used in retrospective tasks, including troubleshooting, debugging, and tracing root causes of pipeline issues. Lineage is also used for data quality analysis, compliance, and "what if" scenarios, which are often referred to as *impact analysis*.

Lineage is represented visually to show data moving from source to destination, including how the data is transformed over time.

The governance section on [data lineage](govern-lineage.md) explores how you can implement data lineage within your scenario.

### Data discovery

Data discovery is the first step for a data analytics or data governance workload for consumers. In an enterprise data lake platform, it's difficult for data consumers (like data scientists and analysts) to locate the data they need and evaluate its reliability. Data catalogs with accurate metadata make searches easier using data index that provides:

- locations of available data
- data quality detection
- data structure understanding
- data lineage understanding
- access to desired data

Data catalogs offering these search capabilities increase the speed of all data discovery processes.

The governance section on [data catalogs](govern-data-catalog.md) explores how you can implement data discovery within your scenario.

## Set SLAs, SLIs and SLOs

Your organization's teams can adopt DevOps-style Site Reliability Engineering (SRE) practices for data monitoring. Service level agreements (SLAs), service level indicators (SLIs), and service level objectives (SLOs) can help your organization reduce downtime and ensure your data's data reliability.

### Service level agreements (SLAs)

SLAs require well-defined SLIs, which are quantitative measures of service quality, and agreed-upon SLOs, which are the ideal values or ranges each SLI should meet.

Setting a data SLA requires the active participation and collaboration of all stakeholders that will be affected by an SLA. These stakeholders can include data producers, data engineers, data analysts, data consumers, business analysts, and others.

Setting reliability SLAs usually includes three steps: defining, measuring, and tracking.

Begin setting your SLA by defining what reliability means. All key stakeholders must agree on this definition. Ensure every key stakeholder is involved and buys in, especially if your downstream consumers come from different teams or different geographical regions and time zones.

Your SLA needs to be carefully crafted. Involve your legal team if data consumers are external paid customers. For internal customers, your SLA definition should includ key areas like data promise, data quality, and a process to handle data incidents if the promise isn't met.

### Example SLA

Suppose Contoso is a media company that runs an enterprise data lake, and this data lake powers multiple data products across different business domains. The Contoso's data application team is responsible for delivering the prior-day sales data that powers Contoso's sales dashboard. When they miss a data delivery or deliver incomplete data, the data engineering team faces emails from frustrated executives and has to manually triage the broken pipeline that's supposed to deliver sales data. To measure and improve on their deliverables, the data team sets an SLA with the Sales team as demonstrated in the following section.

#### Service Level Agreement - Data Team to Sales Team

| Agreement | Description |
|----|----|
| **Business area** | The data team promises to empower the sales team's ability to make data-driven decisions |
|**Promise** | The data team promises to deliver the prior-day sales data that powers the sales dashboard. This data can provide sales and conversion rates for all US regions. Data pipelines will deliver data to power the sales dashboard before 6:00 UTC|
|**Data quality**| **Null check:** Customer name can't be null. **Missing value:** Customer region can't be missing. **Freshness:** Sales date should include any transaction before 24:00 UTC|
|**Data incident management**|If the above promise of data delivery isn't met, the sales team can report the problem and the data team promises to resolve the problem with a TTR < 6 Hours|

### Service level indicators (SLIs)

SLIs should always meet or exceed the SLOs outlined in your SLA. When setting an SLI, begin by identifying key metrics you can track and measure to achieve your agreed-upon SLA.

#### SLI example

Suppose Contoso's data team identifies key metrics from different areas to meet the SLA outlined in the previous example. They also build a dashboard, set up alerts for if key metrics deviate from a set baseline, and automate actions to mitigate some issues.

|Metric|Purpose|
|------|-----|
|Spark cluster CPU and memory usage|To measure any performance bottle neck in the underlying infrastructure used to run data pipelines|
|Pipeline total run time in minutes| To measure if a pipeline takes more time than expected to run|
|Pipeline failure and success rates| To measure how many pipelines fail or succeed|
|Data quality metrics (downstream)| To ensure the data delivered by the data pipeline meets expectations|
|Data quality metrics (upstream)| To ensure that upstream decencies of raw data quality are met|
|Transformation metadata updates| To ensure that lineage from upstream to downstream contains metadata about all transformations applied to data|
|Downstream data indexing and updates| To ensure the sales team discovers all data sets that power their dashboard|
|Defined process for measuring TTD and TTR| To measure TTD and TTR and ensure TTR < 6 hours|

### Service level objectives (SLOs)

An SLO consists of an SLI, the duration over which that SLI is measured, and the targeted success rate that is practically achievable. Defining your direction and targeted success can be an overwhelming task initially. Don't expect perfection, but rather steady improvement over multiple iterations.

SLOs can depend on:

- Data product
- Data category
- Data source regions
- Data observability components

#### SLO example

Suppose Contoso's data team delivers sales data across seven different United States regions. 210 data sets are delivered every calendar year across all regions, and only 200 data sets are complete and meet the SLA. These successful deliveries translate to a 95.99% success rate for that year. The 10 failed (incomplete) data sets occured at an acceptable error rate of 4%.

The data team creates a monitoring dashboard that tracks aggregated SLIs to monitor this SLO over a period of 30 days. Both the data team and sales team get notified when target success rate isn't achieved.

## Data observability maturity model

Data observability is an essential part of the DataOps framework and should be considered parallel to your efforts to improve your organization's DataOps processes. The following maturity model can help you assess the current state of your data observability and decide on the next steps for your journey.

| Stage | Data platform service monitoring | Data pipeline performance monitoring | Data quality monitoring | Data lineage| Data discovery |
| :- | :- | :- | :- | :- | :- |
| **Stage 5 (Highly advanced)** | Data is collected across all the data observability components from one or more data products in a unified view and is correlated using machine learning to find any anomalies. Dashboards track SLO, SLI, and SLA across all data observability components. | Data pipeline performance metrics are tracked across multiple data products. Root cause analysis is completed and driven by the system. | A high Level of trust in data quality is established. Data consumers can verify the reliability of data. | Data lineage is visually represented and is used in multiple ways, such as tracing root causes of pipeline failure, data quality analysis, and compliance. | Data consumers can easily find available data that they need. |
| **Stage 4 (Advanced)** | Dashboards track SLO, SLI, and SLA across the most critical data observability components. Platform monitoring data and pipeline performance monitoring data are correlated using automation. | Data incident tools monitor and measure TTD and TTR metrics for any incidents. | Data quality is maintained through a framework that's usable across multiple data products and tracked using dashboards.| Data lineage includes data quality tags and is connected to data discoverability. | Data lineage is now connected to data discoverability and includes data quality tags as well. |
| **Stage 3 (Evolving)** | Well defined SLO, SLI, and SLA cover most critical almost all components for Data Observability. Data incidents are managed with specialized tools. | Platform monitoring data is correlated with data pipeline performance monitoring using some amount of automation. | Data quality checks are well defined and mapped to custom metrics. | Data lineage has matured to contain enough metadata needed for decision making. | Data discoverability is achieved using specialized data catalog tools. |
| **Stage 2 (Planning)** | An initial draft of SLO, SLI, and SLA covers the most critical components needed for data observability. Platform monitoring data is centralized and there is a unified view of the entire data environment. All data incident management is manual. | Data pipeline performance metrics are defined and measured. | Data quality checks exist, but no standard metric is defined, measured, and visualized. | Data lineage is limited to single data product or isn't tracked. | Data discoverability is achieved but no sophisticated tools are used. |
| **Stage 1 Learning** | Every critical platform service (provider-managed and self-managed) is monitoried in the data landscape. | Pipeline monitoring is minimal. Failures trigger alerts, but have no insights into any possible cause. | Data quality tests can be run from the pipeline, but no metric is measured or tracked. | Data lineage doesn't exist. | Data discoverability doesn't exist. |
