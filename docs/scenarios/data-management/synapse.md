---
title: Building a plan for Synapse'
description: Building a plan for 'Synapse
author: pratimdas
ms.author: prda # Microsoft employees only
ms.date: 01/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Tools and technology to power your data strategy

The right set of tools and technologies will be the backbone for your data products and services. Here are some of the key considerations to take.

Avoid getting stuck in a never-ending learning or design loop, otherwise known as analysis paralysis, or building PoC after PoC. Beyond a certain point, additional time spent in this cycle does not add equivalent value to your organization's business objectives.

## Think big, start small, and act fast

Even if you don't have 100 percent of the features from the get-go, it is more important to get started in delivering business value iteratively. Leave the rest to product innovation from vendors and the capability you going to build with each iteration. Growth mindset is cultivated best when we accomplish more with less. This balance is an art, it fosters creativity and innovation.

Simplification is key. At Microsoft, we have been innovating on behalf of our customers. We have many services for data procurement and many more for storage – depending on the volume, variety, velocity, and veracity. Similarly, an array of services for analytics, visualization, and data science. Despite the flexibility and options, we understand that simplicity is important. A holistic solution that you can get started with immediately makes it easy to see return of investment quicker. For example, we see [Azure Synapse Analytics](https://azure.microsoft.com/services/synapse-analytics/) as a category in its own right. It has ample integration options in your current estate, as well as ISV solutions.

In a nutshell, what we have created is a single integrated platform for BI, AI and Continuous Intelligence. This is wrapped under four foundational capabilities of: management, security, monitoring and a metastore. Underpinning this is a decoupled storage layer, data integration layer, analytics runtimes (either on-demand as serverless, or provisioned). The runtimes provide choice, such as SQL with T-SQL for batch and interactive processing, or Spark for big data, and support of most languages such as SQL, Python, .NET, Java, Scala and are all made available through a single interface called Synapse Analytics Studio.

![Azure Synapse Analytics for integrated data platform experience, BI, AI, and continuous intelligence as part of your data strategy](./images/datastratsynapse.png)

Figure 4: Azure Synapse Analytics for integrated data platform experience for BI, AI and continuous intelligence.

This principled approach will help you shift from an application-only approach to an application and data-led approach. This will help your organization build an end-to-end data strategy that can ensure repeatability and scalability across current and future use cases that impact business outcomes.

## Next step: Assess for 'data management and analytics'

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for 'data management and analytics'](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Assess for 'data management and analytics' migration](./migrate-assess.md)
- [Migrate 'data management and analytics'](./migrate-deploy.md)
- [Release 'data management and analytics' to production](./migrate-release.md)
- [Innovate with 'data management and analytics'](./innovate.md)
- [Govern 'data management and analytics'](./govern.md)
- [Manage 'data management and analytics'](./manage.md)
