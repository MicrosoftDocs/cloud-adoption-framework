---
title: Ready your cloud environment for Azure Stack Hub migration
description: Ready your cloud environment for Azure Stack Hub migration.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Ready your cloud environment for Azure Stack Hub migration

This article assumes that you've decided to [integrate Azure Stack into your cloud strategy](./index.md) and you've developed a [plan for Azure Stack Hub migration](./plan.md).

Assess the infrastructure dependencies that must be addressed first:

- Identity
- Connectivity
- Security
- Encryption

## Hybrid environment configuration

In a hybrid environment, some parts of your IT portfolio are in the Azure public cloud and others are in your Azure Stack Hub private cloud. To develop such an environment, you'll first want to configure a few basic elements in the public cloud. To begin establishing landing zones in the public cloud, see [Ensure that your environment is prepared for cloud adoption](../../ready/index.md).

**Landing zone and cloud platform connections**: During the process, ensure that you have a stable network connection between your current datacenter and Azure. After you've established the network connection, test the latency, bandwidth, and reliability of the connection to Azure.

**Governance and operations**: When you migrate to both clouds, you need to make a few early decisions that will affect the environment. By applying best practices, you build on cloud-native operations and governance tools that run in the public cloud. This approach reduces the cost of running expensive systems in your datacenter or consuming capacity on your Azure Stack Hub deployment. When you migrate to either form of the cloud, you need to either follow best practices or continue using existing systems for operations, governance, and change management.

## Private cloud environment

If you choose to only use the private cloud version of Azure, an Azure Stack Hub deployment, you'll need to consider the same decision points:

**On-premises governance and operations**: The best practice still suggests using the cloud-native operations and governance tools found in the public cloud version of Azure. It's important to evaluate this best practice early and determine whether it's applicable to your scenario.

**Landing zone and cloud platform connections**: If your workload migrations will reside in your Azure Stack Hub deployment, it will be important to document and test the latency, bandwidth, and reliability of the network routes between end users and your Azure Stack appliance.

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Assess workloads for Azure Stack Hub](./migrate-assess.md)
- [Deploy workloads to Azure Stack Hub](./migrate-deploy.md)
- [Govern Azure Stack Hub](./govern.md)
- [Manage Azure Stack Hub](./manage.md)
