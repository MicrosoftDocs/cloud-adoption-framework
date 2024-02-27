---
title: Workload classification before migration
description: Classify your workloads during a pre-migration assessment.
author: Zimmergren
ms.author: tozimmergren
ms.date: 12/05/2023
ms.topic: conceptual
---

# Workload classification before migration

During each iteration of any migration process, one or more workloads are migrated. Before migration activities, it's important to classify each workload. Classification helps clarify governance, security, operations, and cloud-scale analytics requirements.

You should already have planned for tagging requirements as outlined in the [Define your tagging strategy](../../ready/azure-best-practices/resource-tagging.md) article.

During the migration assessment of a workload, you should validate the data sensitivity and mission criticality of each workload.  You can capture this in the tool you're using to track resources for migration, and make sure that during the migration they're tagged appropriately.

These assessment data points can help other teams understand which workloads might require other attention or support.

## Data sensitivity

[Data classification](../../govern/policy-compliance/data-classification.md) measures the impact that a data leak would have on the business or customers. The governance and security teams use data sensitivity or data classification as an indicator of security risks. During assessment, the cloud adoption team should evaluate the data classification for each workload targeted for migration and share that classification with supporting teams. Workloads that deal strictly in "public data" might not have any influence on supporting teams. As data becomes highly confidential, both governance and security teams likely have a vested interest in participating in the workload assessment.

Work with your security and governance teams as early as possible to define the following items:

- A clear process for sharing any workloads on the backlog with sensitive data.
- An understanding of the governance requirements and security baseline that's required for various different levels of data sensitivity.
- Any influence data sensitivity can have on subscription design, management group hierarchies, or landing zone requirements.
- Any requirements for testing data classification, which can include specific tooling or defined scope of classification.

## Mission criticality

[Workload criticality](../../manage/considerations/criticality.md) is a measure of how significantly the business is affected during an outage. This data point helps operations management and security teams evaluate risks involving outages and breaches. During assessment, the cloud adoption team should evaluate mission criticality for each workload targeted for migration and share that classification with supporting teams. "Low" or "unsupported" workloads are likely to have little influence on the supporting teams. However, as workloads approach "mission critical" or "unit critical" classifications, their operational dependencies become more visible.

Work with your security and operations teams as early as possible to define the following items:

- A clear process for sharing any workloads on the backlog with support requirements.
- An understanding of the operations management and resource consistency requirements for various criticality levels.
- Any influence criticality might have on subscription design, management group hierarchies, or landing zone requirements.
- Any requirements for documenting criticality, which might include specific traffic or usage reports, financial analyses, or other tools.

## Organization-specific considerations

In addition to data and mission criticality, consider the classifications specific to your organization.  For example, many organizations with different development teams classify workloads by the project team who supports them, or by the line of business they support.

As you examine dependencies between workloads, you can also classify workloads into fleets based on shared dependencies.

## Guide on capturing classifications

You can use the Govern guidance on [data classification](../../govern/policy-compliance/data-classification.md) to apply the data classification labels to specific workloads in your migration tracking tools. 

You should also do the same with Criticality, using the guidance for [business criticality in cloud management](../../manage/considerations/criticality.md#criticality-scale). You can use the operations management workbook or other tools for planning.

## Next steps

> [!div class="nextstepaction"]
> [Evaluate workload readiness](./evaluate.md)
