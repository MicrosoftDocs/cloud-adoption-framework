---
title: Building a plan for data management and analytics in Azure
description: Building a plan for data management and analytics
author: pratimdas
ms.author: brblanch
ms.date: 01/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Develop a plan for data management and analytics

[Cloud Adoption Framework's Plan methodology](../../plan/index.md) helps create an overall cloud adoption plan to guide the programs and teams involved in your cloud-based digital transformation. The Plan methodology also provides templates to create your backlog and plans to build necessary skills across your teams. The backlog and plans you create are all based on what you are trying to do in the cloud.

This article builds on the Plan methodology. It has specific guidance for data estate rationalization and skilling plans, specific to data management and analytics.

## Data estate rationalization

Much of the guidance in the Plan methodology focuses on the [five Rs of rationalizing your digital estate](../../digital-estate/5-rs-of-rationalization.md). This scenario narrows the primary focus of rationalization to the **data estate**, which is a subset of the overall digital estate. This plan will also look broader and deeper at the data estate than you might in other plans. Specifically, it must include plans for your overall analytics and [data governance](govern.md) required to support the desired maturity.

To properly rationalize your data estate, begin by aligning your business outcomes to each of your data initiatives. This alignment will aid in prioritization and a clear understanding of the value your can derive from each data initiative. Initiatives that represent little business value and present lesser complexity for migration, can easily be included in your cloud migration plan to deliver quick efficiency gains. Initiatives with the greatest business impact or technical complexity typically require richer planning to enable long-term innovation value.

:::image type="content" source="./images/strategic-initiative.png" alt-text=" Diagram of strategic initiative." lightbox="./images/strategic-initiative.png":::

Benchmarking your current estate and capability is critical to ensure you can track progress and measure success. With this data, you can quantify the exact investment needed for people, process, and technology. You can see where you are on the maturity model, and the gaps you need to bridge.

To help you get started, here's a table that shows the thought process:

|Category| Action areas | Current status focusing on five pillars of architecture |
|----------|--------------|-------------------------------------|
|**Preparation**| There are about eight to 10 areas here starting from strategy, charter, and ethics| ![Diagram of the current capability for preparation 1 3 2 0 0](images/pillar-1.png)|
| **Agility**| There might be five to 10 areas here, such as strategy around data lake, catalog, and Common Data Model, dependent on the organization. | ![2 0 1 0 1](images/pillar-2.png) |
| **Resilience**|10 to 20 areas are here starting from discovery, recovery, and anomaly detection. | ![Diagram of the current capability for agility 2 1 1 1 1](images/pillar-3.png) |

As shown in the table, use the maturity level to rate your current capability between zero through four and use the five pillars of architecture to guide those benchmarks.

Once the business outcomes that will drive your data strategy are clear, the next step is to build the capability to deliver them.

## Develop a skilling plan

Developing a skilling plan is part of building the capability to drive your data strategy. It's important to create a clear mapping of the product, services, or tools capabilities maturity assessment, along with your organization's people skills. The exercise assists with how to decide who will help deliver on the achieving the overall objectives.

:::image type="content" source="./images/who-can-transform.png" alt-text="Diagram of who can help transform." lightbox="./images/who-can-transform.png":::

This list isn't exhaustive and it might vary depending on the organization type or structure.

### Assess capability maturity

There must be an exercise in assessing the data analytics and AI capabilities required to deliver on a specific use case, holistically or at an organizational level. However, there has to be some guiding principles and processes to complete the assessment:

- Define current capabilities and ambition
- Identify risks and blockers to progress
- Clearly state benefits and key stakeholders
- Link benefits to stated business objectives
- Identify key dependencies

As a next step, look at Azure native services, and start mapping what you need to deliver success.

Along with the capability maturity assessment, culture is also another important aspect that is the key focus of this framework to make it successful.

## Prepare your plan with these tips

This section provides an overview of the critical tips that can improve your overall plan.

### Prepare for potential challenges and roadblocks early

It's challenging to harness the power of data in a secure and compliant manner. You might run into challenges like organizational silos, building a data-driven culture, and the use of multiple tools and technologies across the organization. Time-to-market is one of the most critical factors for all businesses. Organizations can have great ideas and data can be an enabler. But because of challenges, it might take weeks or months before you start gaining insights and ultimately deliver business value from data. It's important to prepare for potential challenges early. 

### Initial organization alignment: Center of Excellence

Center of Excellence can assist with:

- Driving adoption, standards, best practices, and innovation
- Funded team for full delivery and specialist skills provision
- Deep technical skills in key technologies
- Active participation and evangelizing in communities of practice

![Diagram of the strategy cycle.](images/strategy-cycle.png)

### Adopting Agile delivery method

Agile is the ability to create and respond to change. It's a way of dealing with, and ultimately succeeding in, an uncertain and turbulent environment.

Agility is about thinking through how to understand what's going on in your current environment, identify what uncertainty you're facing, and plan how to adapt as you go.

## Next step: Assess for data management and analytics

The following articles can guide your cloud adoption journey and help you succeed in the cloud adoption scenario.

- [Review your environment or Azure landing zones](ready.md)
- [Govern data management and analytics](govern.md)
- [Secure data management and analytics](secure.md)
