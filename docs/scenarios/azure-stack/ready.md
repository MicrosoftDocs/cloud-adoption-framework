---
title: "Ready your cloud environment for Azure Stack Hub migration"
description: Ready your cloud environment for Azure Stack Hub migration
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Ready your cloud environment for Azure Stack Hub migration

This article assumes that you've decided to [integrate Azure Stack into your cloud strategy](./index.md) and you've developed a [plan for Azure Stack Hub migration](./plan.md).

Assess infrastructure dependencies that must be addressed first:

- Identity
- Connectivity
- Security
- Encryption

## Hybrid environment configuration

If you're developing a hybrid environment, with parts of your IT portfolio in Azure's public cloud and other parts of the portfolio in you Azure Stack Hub private cloud, then you'll first want to configure a few basic things in the public cloud. The guidance in the [ready methodology](../../ready/index.md) will help you establish landing zones in the public cloud.

**Landing zone and cloud platform connections:** During that process, ensure that you have a stable network connection between you current datacenter and Azure. Once the network connection is established, test the latency, bandwidth, and reliability of the connection to Azure.

**Governance and operations:** When migrating to both clouds, you will need to make a few early decisions that will impact the environment. Best practices build on cloud-native operations and governance tools that run in the public cloud. This approach reduces the cost of running expensive systems in your datacenter, or consuming capacity on the Azure Stack Hub. When migrating to either form of Azure cloud, you will need to decide to follow the best practice or continue using existing systems for operations, governance, and change management.

## Private cloud environment

If you choose to only use the private cloud version of Azure, Azure Stack Hub, you will need to consider the same decision points.

**On-premises governance and operations:** The best practice still suggests using the cloud-native operations and governance tools found in the public cloud version of Azure. It is important to evaluate those best practices early and determine if the best practice is applicable to your scenario.

**Landing zone and cloud platform connections:** If your workload migrations will be deployed to Azure Stack Hub, it will be important to document and test the latency, bandwidth, and reliability of the network routes between end users and your Azure Stack appliance.

## Next step: Assess workloads before migration

The following articles provide guidance found at specific points throughout the cloud adoption journey. The first article on assessing workloads goes deeper than the assessment during the planning process to ensure you're ready to migrate each workload.

- [Assess workloads for Azure Stack Hub](./migrate-assess.md)
- [Deploy workloads to Azure Stack Hub](./migrate-deploy.md)
- [Govern Azure Stack Hub](./govern.md)
- [Manage Azure Stack Hub](./manage.md)
