---
title: Migration deployment checklist
description: Get an overview of the articles that explain the various activities that may be involved in migrating a workload in Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 03/04/2024
ms.topic: conceptual

---

# Migration deployment checklist

In this phase of the adoption journey, you begin the technical execution of the migration. You use the workload architecture and assessment materials from the previous phase to begin deployment and remediation of issues. You begin replicating servers to Azure and preparing them for migration, and begin executing your technical tests.

This phase can be the most technical demanding. It's important to make sure you complete your remediation activities and perform detailed testing. You should have a clear understanding of how the services operate together. By the end of this, you should have high confidence that your workload is ready to operate in Azure, and are ready to plan for the release.

## Checklist

The table below gives an overview of the activities documented in this phase, along with the roles responsible for execution.

|Activity|Summary|Responsible roles|
|---|---|---|
|[Deploy supporting services](./deploy-supporting-services.md)|Guidance for how to plan for and deploy non-server resources for your workload.|<li>Migration Engineers.|
|[Remediate assets](./remediate.md)|Guidance to help build your remediation plan based on assets.|<li>Migration Architect.<br><li>Migration Engineer.<br><li>Project Manager.|
|[Replicate assets](./replicate.md)|Guidance for replicating source servers to the cloud.|<li>Migration Engineers.|
|[Prepare for management](./prepare-for-management.md)|Guidance on planning for an implementing management as part of the migration.|<li>Cloud Operations Manager.<br><li>Migration Engineer.<br><li>Workload Architects.|
|[Migration testing](./migration-testing.md)|Guidance on how to perform technical migration testing prior to performing business testing.|<li>Project Manager.<br><li>Workload Architects.<br><li>Migration Engineers.|

## Next steps

> [!div class="nextstepaction"]
> [Deploy supporting services](./deploy-supporting-services.md)
