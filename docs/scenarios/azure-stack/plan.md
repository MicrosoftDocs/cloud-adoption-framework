---
title: Plan your Azure Stack Hub migration
description: Plan your Azure Stack Hub migration.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: plan
ms.custom: internal
---

# Plan your Azure Stack Hub migration

This article assumes that you've reviewed how to [integrate Azure Stack into your cloud strategy](./index.md) and that your journey aligns with the examples in that article.

Before you move directly into your organization's migration efforts, it's important to set expectations appropriately about Azure and Azure Stack Hub. Doing so can help avoid pitfalls or setbacks later in the project. The key to a successful implementation is a good understanding of when to use Azure and when to use Azure Stack Hub.

## Digital estate alignment

Alignment of your organization's digital estate starts with a few simple questions to ask when you complete your [digital estate rationalization](../../digital-estate/index.md).

- What is the motivation, such as regulatory requirements, data gravity, or compliance needs, to keep applications and data on-premises?
- Which specific regulatory or compliance requirements affect the decision to stay in the datacenter?
- How will data privacy affect data migration?
- Is migration defined as a modernization journey?
- If so, have you defined the next steps and the goals required after the migration?
- What are the service-level agreement, recovery point objective, recovery time objective, and availability requirements?

For some workloads, your answers to these questions will fuel conversations about the value of Azure versus Azure Stack Hub for that workload.

## Assessment best practices

By applying the best practice for [assessing a digital estate with Azure Migrate](../../plan/contoso-migration-assessment.md), you can accelerate the assessment and alignment of the workloads and assets in your digital estate. This best practice provides insight into your full IT portfolio. It also helps identify technical requirements for capacity, scale, and configuration to guide your migration.

By using proper assessment data, your cloud adoption team can make wiser choices and establish clearer priorities when they evaluate options for public or private cloud platforms in Azure.

## Planning best practices

The following resources can help your team understand the differences between Azure and Azure Stack Hub:

- [Azure Stack overview and roadmap](https://azure.microsoft.com/resources/videos/ignite-2018-azure-stack-overview-and-roadmap/)
- [Azure Stack capacity planning](/azure/azure-stack/capacity-planning)
- [Azure Stack Hub datacenter integration walkthrough](/azure-stack/operator/azure-stack-customer-journey)
- [Azure Stack virtual machine features](/azure-stack/user/azure-stack-vm-considerations?view=azs-1910)

When you understand the best platform for each workload, you can integrate your decisions into a [cloud adoption plan](../../plan/template.md) to manage public and private cloud migrations as one aligned effort.

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Ready your cloud environment for Azure Stack Hub migration](./ready.md)
- [Assess workloads for Azure Stack Hub](./migrate-assess.md)
- [Deploy workloads to Azure Stack Hub](./migrate-deploy.md)
- [Govern Azure Stack Hub](./govern.md)
- [Manage Azure Stack Hub](./manage.md)
