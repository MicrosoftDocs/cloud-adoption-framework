---
title: Decisions that affect migration
description: Use the Cloud Adoption Framework for Azure to make appropriate decisions and choose execution activities that will support a successful migration.
author: martinekuan
ms.author: martinek
ms.date: 02/25/2020
ms.topic: conceptual
ms.custom: internal
---

# Decisions that affect migration

During migration, several factors affect decisions and execution activities. This article explains the central theme of those decisions and explores a few questions that carry through the discussions of migration principles in this section of the Cloud Adoption Framework guidance.

## Business outcomes

The objective or goal of any adoption effort can have a significant impact on the suggested approach to execution.

- **Migration.** Urgent business drivers, speed of adoption, or cost savings are examples of operational outcomes. These outcomes are central to efforts that drive business value from transitive change in IT or operations models. The Migrate methodology of the Cloud Adoption Framework focuses heavily on migration focused business outcomes.
- **Application innovation.** Improving customer experience and growing market share are examples of incremental outcomes. The outcomes result from a collection of incremental changes focused on the needs and desires of current customers.
- **Data-driven innovation.** New products or services, especially ones that come from the power of data, are examples of disruptive outcomes. These outcomes are the result of experimentation and predictions that use data to disrupt status quo in the market.

No business would pursue just one of these outcomes. Without operations, there are no customers, and vice versa. Cloud adoption is no different. Companies commonly work to achieve these outcomes, but trying to focus on all of them simultaneously can spread your efforts too thin and slow progress on work that could most benefit your business needs.

This prerequisite isn't a demand for you to pick one of these three goals, but instead to help your cloud strategy team and your cloud adoption team establish a set of operational priorities that will guide execution for the next three to six months. These priorities are set by ranking each of the three itemized options from most significant to least significant, as they relate to the efforts this team can contribute to in the next one or two quarters.

### Act on migration outcomes

If operational outcomes rank highest in the list, this section of the Cloud Adoption Framework will suit your team well. In this section, it's assumed that you need to prioritize speed and cost savings as primary key performance indicators (KPIs), in which case a migration model to adoption would be well aligned with the outcomes. A migration-focused model is heavily predicated on lift and shift migration of infrastructure as a service (IaaS) assets to deplete a datacenter and to produce cost savings. In such a model, modernization may occur but is a secondary focus until the primary migration mission is realized.

### Act on application innovations

If market share and customer experience are your primary drivers, this section may not be the best section of the Cloud Adoption Framework to guide your teams' efforts. Application innovation requires a plan that focuses on the modernization and transition of workloads, regardless of the underlying infrastructure. In such a case, the guidance in this section can be informative but may not be the best approach to guide core decisions.

### Act on data innovations

If data, experimentation, research and development (R&D), or new products are your priority for the next six months or so, this section may not be the best section of the Cloud Adoption Framework to guide your teams' efforts. Any data innovation effort could benefit from guidance regarding the migration of existing source data. However, the broader focus of that effort would be on the ingress and integration of additional data sources. Extending that guidance with predictions and new experiences is much more important than the migration of IaaS assets.

## Effort

Migration effort can vary widely depending on the size and complexities of the workloads involved. A smaller workload migration involving a few hundred virtual machines (VMs) is a tactical process, potentially being implemented using automated tools such as [Azure Migrate](/azure/migrate/migrate-services-overview). Conversely, a large enterprise migration of tens of thousands of workloads requires a highly strategic process and can involve extensive refactoring, rebuilding, and replacing of existing applications integrating platform as a service (PaaS) and software as a service (SaaS) capabilities. [Identifying and balancing the scope](../../../strategy/balance-the-portfolio.md) of your planned migrations is critical.

Before making any decisions that could have a long-term impact on the current migration program, it's vital that you create consensus on the following decisions.

### Effort type

In any migration of significant scale (more than 250 VMs), assets are migrated using a variety of transition options, discussed in the five Rs of rationalization: *rehost*, *refactor*, *rearchitect*, *rebuild*, and *replace*.

Some workloads are modernized through a *rebuild* or *rearchitect* process, creating more modern applications with new features and technical capabilities. Other assets go through a *refactor* process, for instance a move to containers or other more modern hosting and operational approaches that don't necessarily affect the solutions code base. Commonly, virtual machines and other assets that are more well established go through a *rehost* process, transitioning those assets from the datacenter to the cloud. Some workloads could potentially be migrated to the cloud, but instead should be *replaced* using service-based (SaaS-based) cloud services that meet the same business need&mdash;for example, by using Microsoft 365 as an alternative to migrating Exchange Server instances.

In the majority of scenarios, some business event creates a forcing function that causes a high percentage of assets to temporarily migrate using the *rehost* process, followed by a more significant secondary transition using one of the other migration strategies after they're in the cloud. This process is commonly known as a *cloud transition*.

During the process of [rationalizing the digital estate](../../../digital-estate/calculate.md), these types of decisions are applied to each asset to migrate. However, the prerequisite needed at this time is to make a baseline assumption. Of the five migration strategies, which best aligns with the business objectives or business outcomes driving this migration effort? This decision serves as a guiding assumption throughout the migration effort.

### Effort scale

Scale of the migration is the next important prerequisite decision. The processes needed to migrate 1,000 assets are different from the processes required to move 10,000 assets. Before beginning any migration effort, it's important to answer the following questions:

- **How many assets support the migrating workloads today?** Assets include data structures, applications, VMs, and necessary IT appliances. Choose a relatively small workload for your first migration candidate.
- **Of those assets, how many are planned for migration?** It's common for some assets to be terminated during a migration process, due to lack of sustained end-user dependency.
- **What are the top-down estimates of the scale of migratable assets?** For the workloads included for migration, estimate the number of supporting assets such as applications, virtual machines, data sources, and IT appliances. See the [Digital estate](../../../digital-estate/index.md) section of the Cloud Adoption Framework for guidance on identifying relevant assets.

### Effort timing

Often, migrations are driven by a compelling business event that is time sensitive. For instance, one common driver is the termination or renewal of a third-party hosting contract. Although there are many potential business events necessitating a migration, they share a common factor: an end date. It's important to understand the timing of any approaching business events, so activities and velocity can be planned and validated properly.

## Recap

Before proceeding, document the following assumptions and share them with the cloud strategy team and the cloud adoption teams:

- Business outcomes.
- Roles, documented and refined for the *Assess*, *Migrate*, *Optimize*, and *Secure and manage* migration processes.
- Definition of done, documented and refined separately for these migration processes.
- Effort type.
- Effort scale.
- Effort timing.

## Next steps

After the process is understood among the team, it's time to review technical prerequisites. The [migration environment planning checklist](./planning-checklist.md) helps to ensure that the technical foundation is ready for migration.

Once the process is understood among the team, its time to review technical prerequisites the [migration planning checklist](./planning-checklist.md) will help ensure the technical foundation is ready for migration.

> [!div class="nextstepaction"]
> [Review the migration planning checklist](./planning-checklist.md)
