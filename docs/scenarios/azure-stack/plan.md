---
title: "Plan for Azure Stack Hub migration"
description: Plan for Azure Stack Hub migration
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
---

# Plan for Azure Stack Hub migration

This article assumes that you've reviewed how to [integrate Azure Stack into your cloud strategy](./index.md) and that your journey aligns with the examples in that article.

Before moving directly into migration efforts, its important to set expectations appropriately about Azure and Azure Stack Hub. Doing so helps avoid pitfalls or setbacks later in a project. The key to a successful implementation is a good understanding of when to use Azure and when to use Azure Stack Hub.

## Digital estate alignment

This starts with a few simple questions to be asked when completing your [digital estate rationalization](../../digital-estate/index.md).

- What is the motivation to keep applications and data on-premises, such as regulatory requirements, data gravity, or compliance needs?
- Which specific regulatory or compliance requirements impact the decision to stay in the datacenter?
- How will data privacy impact data migration?
- Is migration defined as a modernization journey?
- If so, have you defined the next steps and the goals required after the migration?
- What are the SLA, RPO, RTO, and availability requirements?

For some workloads, this information will fuel conversations about the value of Azure versus Azure Stack Hub for that workload.

## Assessment best practices

The best practice for [assessing a digital estate with Azure Migrate](../../plan/contoso-migration-assessment.md) can accelerate the assessment and alignment of the workloads and assets in your digital estate. That best practice provides insight into your full IT portfolio. It also helps identify technical requirements for capacity, scale, and configuration to guide your migration.

With proper assessment data, the team can make wiser choices and establish clearer priorities when evaluating options for public or private cloud platforms in Azure.

## Planning best practices

The following resources can help understand the differences between Azure and Azure Stack Hub:

- [Azure Stack overview and roadmap](https://azure.microsoft.com/resources/videos/ignite-2018-azure-stack-overview-and-roadmap/)
- [Azure Stack capacity planning](https://docs.microsoft.com/azure/azure-stack/capacity-planning)
- [Azure Stack Hub datacenter integration walkthrough](https://docs.microsoft.com/azure-stack/operator/azure-stack-customer-journey)
- [Azure Stack VM features](https://docs.microsoft.com/azure-stack/user/azure-stack-vm-considerations?view=azs-1910)

Once you have an understanding of the best platform for each workload, you can integrate those decisions into a [cloud adoption plan](../../plan/template.md) to manage public and private cloud migrations as one aligned effort.

## Next step: Prepare your environment for Azure Stack Hub migrations

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey. The first article on [environmental readiness](./ready.md) is the suggested next step.

- [Environmental readiness](./ready.md)
- [Assess workloads for Azure Stack Hub](./migrate-assess.md)
- [Deploy workloads to Azure Stack Hub](./migrate-deploy.md)
- [Govern Azure Stack Hub](./govern.md)
- [Manage Azure Stack Hub](./manage.md)
