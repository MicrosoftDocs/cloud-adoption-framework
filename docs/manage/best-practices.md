---
title: Introduction to operational management
description: Use the Cloud Adoption Framework for Azure to understand the various transitions that must be made to enable operational management in the cloud.
author: martinekuan
ms.author: martinek
ms.date: 10/17/2019
ms.topic: conceptual
ms.custom: internal
---

# Establish operational management practices in the cloud

Cloud adoption is a catalyst for enabling business value. However, real business value is realized through ongoing, stable operations of the technology assets deployed to the cloud. This section of the Cloud Adoption Framework guides you through various transitions into operational management in the cloud.

## Cloud operations

Both of these best practices build toward a future-state methodology for operations management, as illustrated in the following diagram:

![Manage methodology of the Cloud Adoption Framework](../_images/manage/caf-manage.png)

**Business alignment:** In the Manage methodology, all workloads are classified by criticality and business value. That classification can then be measured through an impact analysis, which calculates the lost value associated with performance degradation or business interruptions. Using that tangible revenue impact, cloud operations teams can work with the business to establish a commitment that balances cost and performance.

**Cloud operations disciplines:** After the business is aligned, it's much easier to track and report on the proper disciplines of cloud operations for each workload. Making decisions along each discipline can then be converted to commitment terms that can be easily understood by the business. This collaborative approach makes the business stakeholder a partner in finding the right balance between cost and performance.

- **Inventory and visibility:** At a minimum, operations management requires a means of inventorying assets and creating visibility into the run state of each asset.
- **Operational compliance:** Regular management of configuration, sizing, cost, and performance of assets is key to maintaining performance expectations.
- **Protect and recover:** Minimizing operational interruptions and expediting recovery help the business avoid performance losses and adverse revenue impacts. Detection and recovery are essential aspects of this discipline.
- **Platform operations:** All IT environments contain a set of commonly used platforms. Those platforms could include data stores such as SQL Server or Azure HDInsight. Other common platforms could include container solutions such as Azure Kubernetes Service (AKS). Regardless of the platform, platform operations maturity focuses on customizing operations based on how the common platforms are deployed, configured, and used by workloads.
- **Workload operations:** At the highest level of operational maturity, cloud operations teams can tune operations for critical workloads. For those workloads, available data can assist in automating the remediation, sizing, or protection of workloads based on their utilization.

Additional guidance, such as the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/), can help you make detailed architectural decisions about each workload, within the previously described disciplines.

This section of the Cloud Adoption Framework will build on each of the preceding topics to help promote mature cloud operations within your organization.
