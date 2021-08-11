---
title: Building data management and analytics capabilities in Azure
description: Building data management and analytics capabilities
author: pratimdas
ms.author: prda
ms.date: 01/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Building data management and analytics capabilities

Now that you have your key projects mapped with business outcomes and calibrated with impact and complexity, and your baseline, you can start looking at building the capability to deliver them.

The first step would be to look at all capabilities you need, either at an organizational level holistically, or at a project level. Start by mapping what you have.

## Capabilities

:::image type="content" source="./images/capability-as-is.png" alt-text="Diagram of a table showing guidance on building capabilities" lightbox="./images/capability-as-is.png":::

As a next step, look at Azure native services, and start mapping what you need to deliver success.

:::image type="content" source="./images/capability-map-azure.png" alt-text="A table showing cloud-native capabilities for your data strategy" lightbox="./images/capability-map-azure.png":::

## Culture

To build a successful data strategy, you need a data-driven culture. One that fosters open, collaborative participation consistently. This is so the entire workforce can learn, communicate and improve the organization's business outcomes. It will also improve an employee's own ability to generate impact or influence, backed by data. Where you start on the journey will depend on your organization, your industry, and where you in the maturity curve. Let's look at what a maturity curve looks like:

### Level 0

Data is not exploited programmatically and consistently. The data focus within the company is from an application development perspective. On this level, we commonly see ad hoc analytics projects. Additionally, each application is highly specialized to the unique data and stakeholder needs. Each has significant code bases and engineering teams, with many being engineered outside of IT as well. Finally, use case enablement and analytics are very siloed.

### Level 1

Here, we see teams being formed, strategy being created, but analytics still is departmentalized. At this level, organizations tend to be good at traditional data capture and analytics. They may also have a level of commitment to cloud-based approaches; for example, they may already be accessing data from the cloud.

### Level 2

The innovation platform is almost ready, with workflows in place to deal with data quality, and the organization can answer a few 'why' questions. At this level, organizations are actively looking for an end-to-end data strategy with centrally governed data lake stores controlling data store sprawl and improving data discoverability. They are ready for smart and intelligent applications that bring compute to the centrally governed data lakes, reducing the need for federated copies of key data, reducing privacy risks as well as reducing compute costs. They are also ready for multitenantable, centrally hosted shared data services for common data computing tasks and recognize the value of this to enable the speed of insights from data science-driven intelligence services.

### Level 3

Some of the characteristics of this level are a holistic approach to data and projects related to data being deeply integrated with business outcomes. We would also see predictions being done using analytics platforms. At this level, organizations are unlocking digital innovation from both a data estate and application development perspective. They have the foundational data services including data lake(s) and shared data services in place. Multiple teams across the company are successfully delivering on critical business workloads, key business use cases, and measurable outcomes. Telemetry is being used to identify new shared data services. IT is a trusted advisor to teams across the company to help improve critical business processes through the end-to-end trusted and connected data strategy.

### Level 4

Here we see the entire company using a data-driven culture, frameworks and standards enterprise. We also see automation, centers of excellence around analytics or automation, and data-driven feedback loops in action. One of the outcomes of a data-driven culture, is the use of AI in a meaningful way, and here it's easy to define a maturity model as the one shown below.

:::image type="content" source="./images/data-strategy-maturity.png" alt-text="Diagram of maturity evolution of an organization." lightbox="./images/data-strategy-maturity.png":::

## Next steps

The following list of articles will take you to guidance to help you be successful in the cloud adoption scenario.

- [Review your environment or Azure landing zones](./ready.md)
- [Govern data management and analytics](./govern.md)
- [Secure data management and analytics](./secure.md)
