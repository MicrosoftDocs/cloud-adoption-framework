---
title: Classify workloads for a migration
description: Learn how to classify your workloads based on the data sensitivity during a pre-migration assessment by using the Cloud Adoption Framework.
author: Zimmergren
ms.author: pnp
ms.date: 04/05/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Classify workloads for a migration

Each iteration of a migration process involves migrating one or more workloads. Before migration activities, it's important to classify each workload. Classification helps clarify governance, security, operations, and cloud-scale analytics requirements.

This article assumes that you have already [defined your tagging strategy](../../ready/azure-best-practices/resource-tagging.md).

During the migration assessment of a workload, you should verify the data sensitivity and mission criticality of each workload. You can capture this data in the tool that you use to track resources for migration. Ensure that resources are tagged appropriately during the migration.

These assessment data points can help other teams understand which workloads might require attention or support.

## Data sensitivity

Data classification is based on how a data leak affects a business or customers. Governance and security teams use data sensitivity or data classification as an indicator of security risks. During assessment, the cloud adoption team should evaluate the data classification for each workload that's targeted for migration and share that classification with supporting teams. Workloads that deal strictly in *public data* might not have any influence on supporting teams. As data becomes highly confidential, both governance and security teams likely have a vested interest in participating in the workload assessment.

Work with your security and governance teams as early as possible to define:

- A clear process for sharing any workloads in the backlog that have sensitive data.

- An understanding of the governance requirements and the security baseline that's required for different levels of data sensitivity.
- Any influence that data sensitivity might have on the subscription design, management group hierarchies, or landing zone requirements.
- Any requirements for testing data classification, which can include specific tooling or a defined scope of classification.

## Mission criticality

[Workload criticality](../../manage/protect.md#manage-reliability) is based on how significantly an outage affects a business. This data point helps operations management and security teams evaluate risks that involve outages and breaches. During assessment, the cloud adoption team should evaluate mission criticality for each workload that's targeted for migration and share that classification with supporting teams. *Low* or *unsupported* workloads are likely to have little influence on the supporting teams. However, as workloads approach *mission-critical* or *unit-critical* classifications, their operational dependencies become more visible.

Work with your security and operations teams as early as possible to define:

- A clear process for sharing any workloads in the backlog that have support requirements.

- An understanding of the operations management and resource consistency requirements for different criticality levels.
- Any influence that criticality might have on the subscription design, management group hierarchies, or landing zone requirements.
- Any requirements for documenting criticality, which might include specific traffic or usage reports, financial analyses, or other tools.

## Data sovereignty

If your organization is subject to sovereignty and regulatory compliance, you need to classify your workloads and data based on your sovereignty requirements. For more information, see [Examples of data sovereignty requirements](/industry/sovereignty/evaluate-sovereign-requirements).

## Organization-specific considerations

In addition to data and mission criticality, consider classifications that are specific to your organization. For example, many organizations with several development teams classify workloads by the project team who supports them, or by the line of business that they support.

## Capture classifications

To apply the data classification labels to specific workloads in your migration tracking tools.

You should also determine the criticality of workloads by using the guidance for [define reliability requirements](../../manage/protect.md#define-reliability-requirements).

## Next step

> [!div class="nextstepaction"]
> [Evaluate workload readiness](./evaluate.md)
