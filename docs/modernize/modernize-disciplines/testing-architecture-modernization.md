---
title: Testing and architecture
description: Understand how testing and architecture fit into the modernization phase of your cloud adoption journey.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/19/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: seo-caf-modernize
keywords: testing, architecture, modernization, application, platform
---


# Testing and architecture

Testing comes in various flavors and not all workloads and architecture support all kinds of testing.  

If your application needs some [hybrid portability capabilities](/azure/cloud-adoption-framework/scenarios/hybrid/migrate), we can help you understand what's needed on a workload-by-workload basis with a [Well-Architected Review](https://azure.microsoft.com/blog/introducing-the-microsoft-azure-wellarchitected-framework/). Verify that your app works and that the platform can handle the load.

## Release testing

Release testing verifies your app's functionality. Use [Azure Test Plans](/azure/devops/test/track-test-status?view=azure-devops&preserve-view=true) to  develop and operate test plans during manual or automated test execution. This option works well when a workload is highly valuable and needs lots of exploratory or manual user experience studies. For more information, see [Testing your application and Azure environment](/azure/architecture/framework/devops/release-engineering-testing).

## Platform testing

Platform monitoring/testing verifies your platform's load capacity. Use [Azure Monitor with Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/monitor-aks) to test health and performance. Combine these efforts with alerts and targeted load testing.

Use [Load testing](https://azure.microsoft.com/services/load-testing/) to determine which traffic levels your app can stretch to before it might need a [Well-Architected Review](https://azure.microsoft.com/blog/introducing-the-microsoft-azure-wellarchitected-framework/) or more.
