---
title: Cloud Adoption Framework migration model
description: Learn about the Cloud Adoption Framework migration model. Understand the motivations behind migrations and learn why the process is incremental.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/28/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Cloud Adoption Framework migration model

This section of the Cloud Adoption Framework explains the principles behind its migration model. Wherever possible, this content attempts to maintain a vendor-neutral position. It guides you through the processes and activities that can be applied to any cloud migration, whatever your chosen cloud vendor.

## Understand migration motivations

Cloud migration is a portfolio management effort, cleverly disguised as a technical implementation. During the migration process, you'll decide to move some assets, invest in others, and retire obsolete or unused assets. Some assets will be optimized, refactored, or replaced entirely as part of this process. Each of these decisions should align with the motivations behind your cloud migration. The most successful migrations also go a step further and align these decisions with the business outcomes you want.

This model requires your organization to have already completed business readiness processes for cloud adoption. Make sure you've reviewed the [Plan methodology](../../plan/index.md) and the [Ready methodology](../../ready/index.md) guidance in the Cloud Adoption Framework. These methodologies determine the business drivers or other justification for a cloud migration. They also supply required organizational planning or training needed before executing a migration process at scale.

> [!NOTE]
> While business planning is important, a growth mindset is equally important. In parallel with broader business planning efforts by the cloud strategy team, it's suggested that the cloud adoption team begin migrating a first workload as a precursor to wider scale migration efforts. This initial migration will allow the team to gain practical experience with the business and technical issues involved in a migration.

## Envision an end state

It's important to establish a rough vision of your end state before starting your migration efforts. The following diagram shows an on-premises starting point of infrastructure, applications, and data. These elements define your *digital estate*. During the migration process, those assets are transitioned using a migration strategy described in the [five Rs of rationalization](../../digital-estate/5-rs-of-rationalization.md).

:::image type="content" source="../../_images/migrate/migration-options.png" alt-text="Diagram that shows cloud migration options.":::

Migration and modernization of workloads range from *rehost* migrations, to *refactoring*, to *rearchitecting*. Rehost migrations, or *lift and shift* migrations, use infrastructure as a service (IaaS) capabilities that don't require code and application changes. Refactoring migrations only require minimal changes. Rearchitecting migrations modify and extend code and application functionality to take advantage of cloud technologies.

Cloud-native strategies and platform as a service (PaaS) strategies *rebuild* on-premises workloads using Azure platform offerings and managed services. Your workloads might have equivalent fully managed software as a service (SaaS) cloud-based offerings. These workloads can often be fully *replaced* by these services as part of the migration process.

> [!NOTE]
> During the public preview of the Cloud Adoption Framework, this section of the framework emphasizes a rehost migration strategy. Although PaaS and SaaS solutions are discussed as alternatives when appropriate, the migration of virtual machine-based workloads using IaaS capabilities is the primary focus.
>
> Other sections and future iterations of this content will expand on other approaches. For a high-level discussion on expanding the scope of your migration to include more complicated migration strategies, see the article balancing the portfolio.

## Incremental migration

The Cloud Adoption Framework migration model is based on an incremental cloud transformation process. It assumes that your organization will start with an initial, limited-scope, cloud migration effort. We commonly refer to this migration effort as the first workload. This effort will expand iteratively to include more workloads as your operations teams refine and improve your migration processes.

Cloud migrations tools like [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) can migrate entire datacenters consisting of thousands of virtual machines (VMs). However, the business and existing IT operations often can't handle such a high pace of change. Many organizations break up a migration effort into multiple iterations. They move one workload, or one collection of workloads, per iteration.

The principles behind this incremental model are based on the execution of certain processes and prerequisites. These processes are referenced in the following infographic.

![An infographic that shows the Cloud Adoption Framework migration model.](../../_images/migrate/methodology.png)

The consistent application of these principles represents an end goal for your cloud migration processes. They shouldn't be viewed as a required starting point. As your migration efforts mature, refer to the guidance in this section to help define the best process to support your organizational needs.

## Next steps

Begin learning about this model by investigating the prerequisites to migration.

> [!div class="nextstepaction"]
> [Prerequisites to migration](./prerequisites/index.md)
