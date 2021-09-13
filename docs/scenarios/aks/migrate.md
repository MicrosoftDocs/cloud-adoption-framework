---
title: Migrate workloads for modern application platforms
description: Reduce cloud platform dependency and potentially reduce infrastructure footprint by migrating multiple web applications to a container solution
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Migrate workloads to modern application platforms

There's a clear and growing trend of migrating existing workloads from on-premises datacenters to a Kubernetes cluster in Azure. This approach has the potential of reducing the post-migration infrastructure footprint. More importantly, migrating to containers allows for greater portability in the portfolio, allowing workloads to be more easily moved between public and private cloud. This trend is most commonly experienced when organizations have a large collection of web applications.

Most modern application platform options require a rearchitecture or redeployment of the application. The orchestration capabilities of Azure Kubernetes Service (AKS) allows for ease of migration for Kubernetes solutions. But, when you integrate container migration into a standardized migration process, there might be more efficient processes. Azure Migrate includes many tools and features to accelerate migration. The Azure Migrate: App Containerization tool is the easiest way to migrate to containers during a standard migration process.

## One Migrate approach

You can migrate to AKS to accelerate containers in the cloud, as a part of the [Cloud Adoption Framework's One Migrate scenario](../index.md). Typically, migration to Azure uses Azure Migrate and partner tools to assess workloads, migrate workloads, and release workloads to the cloud. You can apply this three-step process to AKS migration, but you might need a few other tools to help with the migration steps.

## Assess workloads

As a first step to assessing a group of workloads, you will need to reference your [cloud adoption plan](../../plan/template.md) and [initial portfolio assessment](../../plan/contoso-migration-assessment.md). When evaluating workloads for containerization during migration, you'll need to review the plan for key information about the operating system and programing language for the application to determine the most appropriate containerization path.

### Streamlined migration candidates

The container migration tools in Azure Migrate can accelerate migration of specific applications to AKS. Evaluate your workloads against the following list to identify Kubernetes migration candidates, and check back often as this list grows:

- [Java web applications, running on Apache Tomcat](/azure/migrate/tutorial-containerize-java-kubernetes)
- [ASP.NET applications](/azure/migrate/tutorial-app-containerization-aspnet-kubernetes)

Use the Azure Migrate: App Containerization tool to migrate the application. The first step of that tools is discovery, which aids in assessment and evaluation of compatibility.

### Containerization then migration candidates

The remaining workloads cannot be migrated until they have been validated as functional and performant while operating within a container. Work with application owners to allocate time to perform containerization, validate results, and build image building pipelines for the work. Take note of unique dependencies such as Windows-specific requirements such as group managed service accounts, local file system usage, cache implementation details, singleton implementations, and dependencies such as databases.

While a centralized team can lead the containerization efforts across an org, consider that more of a project management function and technical requirements gathering and oversight process, application owners will need to be highly involved in this process.

## Migrate tasks

As mentioned in the assess task, many of your applications can be migrated using the Azure Migrate: App Containerization tool. In this step of the repeatable migration process, we'll discuss how you would complete the tasks associated with migrating the workloads to the cloud.

### Streamlined migration

For any workloads that are compatible with the Azure Migrate: App Containerization tool, the tool itself will automate the migration steps by building the container image, deploying an AKS cluster, and deploying the application to the container.

### Migrate containers and workloads

When migrating containers and workloads via a more manual process, the steps of validating the container image, deploying the cluster, and deploying the application are a bit more involved. To start, ensure the your target Kubernetes version is within the supported window for AKS. If using an older version, it might not be within the supported range and would require upgrading to be supported by AKS. For more information, see [AKS-supported Kubernetes versions](/azure/aks/supported-kubernetes-versions).

As with any migration, decide what maintenance window is agreeable and be clear to all interested stakeholders about how the migration is proceeding. Track and dashboard the migration where appropriate. If a downtime migration cannot be negotiated, then allow for extra planning, cost, and complications around a no-downtime migration. If it's found that a downtime migration is required when one wasn't expected, communicate that change to your stakeholders. Perform impact analysis on that change to ensure risks are documented and agreed upon.

All migrations (even downtime migrations), might need to modify the existing application with added flexibility to support the migration. Ensure application teams are fully involved in the planning of workload migrations as early as possible. For example more DNS, connection string, and settings switching capabilities might need to be deployed in the current workload before the migration can be completed.

Currently, you'll need to use one of several open-source tools to complete the replication of your container and workloads to Azure:

If you're coming from an existing Kubernetes platform (AKS engine, ACS, or another Kubernetes implementation), you might consider using some open-source tooling to help with the migration. In these cases you've already got a workload that functions in Kubernetes, and rehosting in AKS is much simpler. Validate all capabilities exist in AKS before performing any migration.

- [Velero](https://velero.io)
- [Azure kube CLI extension](https://github.com/yaron2/azure-kube-cli)
- [Reshifter](https://github.com/mhausenblas/reshifter)
- Migrating from [AKS engine](/azure-stack/user/azure-stack-kubernetes-aks-engine-overview) to AKS
- Migrating from [Azure container service](https://azure.microsoft.com/updates/azure-container-service-will-retire-on-january-31-2020/) to AKS
- Moving existing resources to a different region

When migrating, ensure your target Kubernetes version is within the supported window for AKS. If using an older version, it might not be within the supported range and require upgrading versions to be supported by AKS. For more information, see [AKS supported Kubernetes versions](/azure/aks/supported-kubernetes-versions). Where possible, always try to migrate to the same version of Kubernetes. That means either do an in-place upgrade in the existing system or plan a post-migration upgrade based on your priorities.

## Next step: Innovate using modern application platform solutions

The following articles will take you to guidance at specific points in the cloud adoption journey and help you be successful in the cloud adoption scenario.

- [Innovate using modern application platform solutions](./innovate.md)
- [Govern modern application platform solutions](./govern.md)
- [Manage modern application platform solutions](./manage.md)
