---
title: Workload classification before migration
description: Classify your workloads during a pre-migration assessment.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/03/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Workload classification before migration

During each iteration of any migration process, one or more workloads will be migrated and promoted to production. Prior to either of those migration activities, it is important to classify each workload. Classification helps clarify governance, security, operations, and data management and analytics requirements.

The following guidance builds on the suggested tagging requirements outlined in [Define your tagging strategy](../../../ready/azure-best-practices/resource-tagging.md) by adding important [operations](../../../manage/considerations/criticality.md#criticality-scale) and [governance](../../../govern/guides/complex/prescriptive-guidance.md#resource-tagging) elements.

In this article, we specifically suggest adding criticality and data sensitivity to your existing tagging standards. Each of these data points will help other teams understand which workloads may require additional attention or support.

## Data sensitivity

As outlined in the article on [data classification](../../../govern/policy-compliance/data-classification.md), data classification measures the impact that a data leak would have on the business or customers. The governance and security teams use data sensitivity or data classification as an indicator of security risks. During assessment, the cloud adoption team should evaluate the data classification for each workload targeted for migration and share that classification with supporting teams. Workloads that deal strictly in "public data" may not have any impact on supporting teams. However, as data moves further towards the "highly confidential" end of the spectrum, both governance and security teams will likely have a vested interest in participating in the assessment of the workload.

Work with your security and governance teams as early as possible to define the following items:

- A clear process for sharing any workloads on the backlog with sensitive data.
- An understanding of the governance requirements and security baseline required for various different levels of data sensitivity.
- Any impact data sensitivity may have on subscription design, management group hierarchies, or landing zone requirements.
- Any requirements for testing data classification, which may include specific tooling or defined scope of classification.

## Mission criticality

As outlined in the article on [workload criticality](../../../manage/considerations/criticality.md), the criticality of a workload is a measure of how significantly the business will be affected during an outage. This data point helps operations management and security teams evaluate risks regarding outages and breaches. During assessment, the cloud adoption team should evaluate mission criticality for each workload targeted for migration and share that classification with supporting teams. "Low" or "unsupported" workloads are likely to have little impact on the supporting teams. However, as workloads approach "mission critical" or "unit critical" classifications, their operational dependencies become more apparent.

Work with your security and operations teams as early as possible to define the following items:

- A clear process for sharing any workloads on the backlog with support requirements.
- An understanding of the operations management and resource consistency requirements for various different levels of criticality.
- Any impact criticality may have on subscription design, management group hierarchies, or landing zone requirements.
- Any requirements for documenting criticality, which might include specific traffic or usage reports, financial analyses, or other tools.

## Next steps

Once workloads are properly classified, it's much easier to [align business priorities](./business-priorities.md).

> [!div class="nextstepaction"]
> [Align business priorities](./business-priorities.md)
