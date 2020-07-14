---
title: "Data Democratization"
description: Enable business with data innovation and a centralized repository of data that becomes the single source of truth.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/22/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Data Democratization

By enabling a business with data innovation and a modern data estate, this allows the entire business from your IT stakeholder to your data professional to take action over this now centralized repository of data that becomes the single source of truth.

Many companies today have long had analytical data warehouses in place in their datacenters to support decision making in different parts of their business. Sales, marketing and finance departments in particular are heavy users of such systems producing standard reports and dashboards. They also employ business analysts to perform ad hoc query and analysis on data in data marts designed for multi-dimensional analysis using self-service business intelligence (BI) tools.  

Azure Synapse Analytics is a single service for seamless collaboration and accelerated time to insight.

**Data warehousing**: *Database admins* support the management of data lakes and data warehouses while intelligently optimizing workloads and automatically securing data.

**Data integration**: *Data engineers* use a code-free environment to easily connect multiple sources and types of data.

**Big data & machine learning**: *Data scientists* build proofs of concept rapidly and provision resources as needed, while working in the language of their choice (T-SQL, Python, Scala, .NET, SparkSQL).

**Management & security**: *IT pros* protect and manage data more efficiently, enfore privacy requirements, and secure access to cloud and hybrid configurations.

**Business intelligence**: *Business analysts* securely access datasets, build dashboards, and share data withing and outside their organization.

An example of a classic data warehouse architecture is shown in Figure 1 where known structured data is extracted from core transaction processing systems, copied into a staging area from where it is cleaned, transformed, and integrated into production tables in a data warehouse. It is often the case that several years of historical transaction data are incrementally built up here to provide the data needed to understand changes in sales, customer purchasing behavior, and customer segmentation over time and to provide year-on-year financial reporting and analysis to help with decision making. From there, subsets of data are extracted into data marts to analyze activity associated with a specific business process to support decision making in a specific part of the business.

![The classic data warehouse: the main data sources to a data warehouse have been transactional application databases](../../_images/analytics/the-classic-data-warehouse.png)

For a business to run efficiently, all types of data are needed for different skills and roles. You need raw data that has been cleansed for data scientists to build machine-learning models. You need cleaned and structured data for a data warehouse to provide reliable performance to business applications and dashboards. Most importantly, you need to be able to go from raw data to insights in minutes, not days. This is a capability only Azure Synapse can deliver on. Azure Synapse is the only analytics service in the world that has a native, built-in Business Intelligence tool with Power BI, to fully enable to capability to go from raw data to a dashboard serving insights in minutes, and all using one service within one single interface.

## Next steps

<!-- TODO: More detail needed here. -->

Cloud data team
