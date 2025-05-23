---
title: Migrate workloads for modern application platforms
description: Reduce cloud platform dependency and potentially reduce infrastructure footprint by migrating multiple web applications to a container solution
author: Zimmergren
ms.author: pnp
ms.date: 10/23/2023
ms.topic: conceptual
ms.custom: e2e-aks, UpdateFrequency2
---

# Migrate workloads to modern application platforms

There's a clear and growing trend of migrating existing workloads from on-premises datacenters to a Kubernetes cluster in Azure. This approach has the potential to reduce the post-migration infrastructure footprint. More importantly, migrating to containers allows for greater portability in the portfolio, allowing workloads to be more easily moved between public and private clouds. This trend is most commonly experienced when organizations have many web applications.

Most modern application platform options require a re-architecture or redeployment of the application. Azure Kubernetes Service (AKS) orchestration capabilities allow for ease of migration for Kubernetes solutions. But, when you integrate container migration into a standardized migration process, there might be more efficient processes. Azure Migrate includes many tools and features to accelerate migration. The Azure Migrate: App Containerization tool is the easiest way to migrate to containers during a standard migration process.

## One Migrate approach

You can migrate to AKS to accelerate containers in the cloud as a part of the [Cloud Adoption Framework's One Migrate scenario](../index.md). Typically, migration to Azure uses Azure Migrate and partner tools to assess workloads, migrate workloads, and release workloads to the cloud. You can apply this three-step process to AKS migration, but you might need a few other tools to help with the migration steps.

## Assess workloads

As a first step to assessing a group of workloads, you need to reference your [cloud adoption plan](../../plan/template.md) and [initial portfolio assessment](../../migrate/assess/index.md). When evaluating workloads for containerization during migration, you need to review the plan for key information about the operating system and programming language for the application to determine the most appropriate containerization path.

### Streamlined migration candidates

The container migration tools in Azure Migrate can accelerate the migration of specific applications to AKS. Evaluate your workloads against the following list to identify Kubernetes migration candidates, and check back often as this list grows:

- [Java web applications, running on Apache Tomcat](/azure/migrate/tutorial-app-containerization-java-kubernetes)
- [ASP.NET applications](/azure/migrate/tutorial-app-containerization-aspnet-kubernetes)

Use the Azure Migrate: App Containerization tool to migrate the application. The first step of that tool is discovery, which aids in assessing and evaluating compatibility.

### Containerization then migration candidates

The remaining workloads can't be migrated until they have been validated as functional and performant while operating within a container. Work with application owners to allocate time to perform containerization, validate results, and build image-building pipelines for the work. Note unique dependencies like Windows-specific requirements such as group-managed service accounts, local file system usage, cache implementation details, singleton implementations, and dependencies such as databases.

While a centralized team can lead the containerization efforts across an org, considering that it is more of a project management function and technical requirements gathering and oversight process, application owners need to be highly involved.

## Migrate tasks

As mentioned in the assessment task, many of your applications can be migrated using the Azure Migrate: App Containerization tool. In this step of the repeatable migration process, we discuss how you would complete the tasks associated with migrating the workloads to the cloud.

### Streamlined migration

For any workloads that are compatible with the Azure Migrate: App Containerization tool, the tool itself will automate the migration steps by building the container image, deploying an AKS cluster, and deploying the application to the container.

### Migrate containers and workloads

When migrating containers and workloads via a more manual process, validating the container image, deploying the cluster, and deploying the application are more involved. First, ensure your target Kubernetes version is within the supported window for AKS. Using an older version might be outside the supported range and would require upgrading to be supported by AKS. For more information, see [AKS-supported Kubernetes versions](/azure/aks/supported-kubernetes-versions). Where possible, always migrate to the same version of Kubernetes. That means either doing an in-place upgrade in the existing system or planning a post-migration upgrade based on your priorities.

As with any migration, decide what maintenance window is agreeable and be transparent to all interested stakeholders about how the migration is proceeding. Track and dashboard the migration where appropriate. If a downtime migration can't be negotiated, allow for extra planning, cost, and complications around a no-downtime migration. If it's found that a downtime migration is required when one wasn't expected, communicate that change to your stakeholders. Perform impact analysis on that change to ensure risks are documented and agreed upon.

All migrations, even downtime migrations, might need to modify the existing application with added flexibility to support the migration. Ensure application teams are fully involved in planning workload migrations as early as possible. For example, more DNS, connection string, and settings switching capabilities might need to be deployed in the current workload before the migration can be completed.

Currently, you need to use one of several open-source tools to complete the replication of your container and workloads to Azure.

If you're coming from an existing Kubernetes platform (AKS engine, ACS, or another Kubernetes implementation), consider using some open-source tooling to help with the migration. In these cases, you already have a workload that functions in Kubernetes, and rehosting in AKS is simpler. Validate all capabilities that exist in AKS before performing any migration.

## Next step: Innovate using modern application platform solutions

The following articles guide you at specific points in the cloud adoption journey and help you succeed in the cloud adoption scenario.

- [Innovate using modern application platform solutions](./innovate.md)
- [Govern modern application platform solutions](./govern.md)
- [Manage modern application platform solutions](./manage.md)
