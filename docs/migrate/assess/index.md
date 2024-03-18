---
title: Migration assessment checklist
description: Learn how to assess the readiness of your workloads for migration to the cloud with the Cloud Adoption Framework for Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/04/2024
ms.topic: conceptual
---

# Migration assessment checklist

Many of your existing workloads are ideal candidates for cloud migration. Not every asset, though, is compatible with cloud platforms and not all workloads can benefit from hosting in the cloud. [Digital estate planning](/azure/cloud-adoption-framework/digital-estate/) allows you to generate an overall migration backlog of potential workloads to migrate. However, this planning effort is high level. It relies on assumptions made by the cloud strategy team and doesn't dig deeply into technical considerations.

As a result, before migrating a workload to the cloud it's critical to assess the individual assets associated with that workload for their migration suitability. Your cloud adoption team should evaluate technical compatibility, required architecture, performance/sizing expectations, and dependencies. Use this information to ensure the migrated workload can be deployed to the cloud effectively.

This phase guides you through evaluating the readiness and planning for the migrated state. Once complete, you can proceed to deploying the workload for migration.

If these steps aren't completed, migration activities during deployment might fail. They might also be deployed in an insecure and unmanaged fashion, or not operate as intended due to missing services. They also might have an unplanned cost impact. As a result, it's vital to complete these activities before you begin to deploy resources to Azure.

## Checklist

The table below gives an overview of the activities documented in this phase, along with the roles responsible for execution.

|Activity|Summary|Responsible roles|
|---|---|---|
|[Classify workloads](./classify.md)|Instructions for classifying data sensitivity and mission criticality, and for identifying your organization's specific classifications.|<li>Migration Architects.<br><li>Cloud Operations Manager.|
|[Evaluate workload readiness](./evaluate.md)|Instructions for assessment, common blockers, and common evaluation activities|<li>Migration Architect.|
|[Architect workloads](./architect.md)|Guidance for designing the architecture of the migrated workloads, supporting services, and building and refining initial cloud estimates.|<li>Migration Architect.<br><li>Workload Architect.<br><li>Landing Zone Architect.<br><li>Cloud Operations Manager.|

## Next steps

> [!div class="nextstepaction"]
> [Classify workloads](./classify.md)
