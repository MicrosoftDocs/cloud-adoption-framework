---
title: "Workload operations - Cloud Management and Operations"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Workload operations - Cloud Management and Operations
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/07/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Workload operations in cloud management

Some workloads are critical to the success of the business. For those workloads, a management baseline isn't sufficient to meet the required business commitments to cloud management. Platform operations may not even be sufficient to meet business commitments. This highly important subset of workloads requires a specialized focus on the way the workload functions and how it is supported.

In return, the investment in workload operations can lead to improved performance, decreased risk of business interruption, and faster recovery when system failures occur. This article will guide an approach to investing in the continued operations of these high priority workloads to drive improved business commitments.

## When to invest in workload operations

Pareto principle (also known as the 80/20 rule) states that 80% of the effects comes from 20% of the causes. When IT portfolios are allowed to grow organically over time, this rule can commonly be seen in a review of the IT portfolio. Depending on the effect requiring investment, the cause can vary but the principle general holds true:

- 80% of system failures tend to be the result of 20% of the common errors or bugs
- 80% of business value tends to come from 20% of the workloads in a portfolio
- 80% of the effort to migrate to the cloud comes from 20% of the workloads being moved
- 80% of cloud management efforts will support 20% of the service incidents or trouble tickets
- 80% of business impact from outage will come from 20% of the systems affected by an outage

Workload operations should only be applied when the cloud adoption strategy, business outcomes, and operational metrics are each well understood. This is a paradigm shift from the classic view of IT. Traditionally, IT assumed that all workloads experienced the same degree of support and required similar levels of priority.

Before investing in deep workload operations, both IT and the business should understand the business justifications and the expectations of increased investment in cloud management.

## Start with the data

Workload operations begin with a deep understanding of workload performance and support requirements. Before investing in workload operations, the team must have rich data regarding: workload dependencies, application performance, database diagnostics, virtual machine telemetry, and incident history.

This data seeds the insights that drive workload operations decisions.

## Continued observation

Initial data and ongoing telemetry can help formulate and test theories regarding the performance of a workload. But, ongoing workload operations are rooted in a continued and expanded observation of workload performance, with a heavy focus on application and data performance.

### Testing automation

At the application level, the first requirements of workload operations, is an investment in deep testing. For any application supported through workload operations, a test plan should be established and regularly executed to deliver functional and scale testing across the applications.

Regular test telemetry will provide immediate validation of various hypotheses regarding the operation of the workload. Improving operational and architectural patterns can be executed and tested, the delta in those results provides clear impact analysis to guide continued investments.

### Understand releases

Clear understanding of release cycles and release pipelines is an important element of workload operations.

An understanding of cycles can prepare for potential interruptions and allow the team to proactively address any releases that could produce an adverse affect on operations. This understanding also allows the cloud management team to partner with adoption teams to continuously improve the quality of the product and address bugs which could impact stability.

More importantly, an understanding of release pipelines can significantly improve RTO of a workload. In many scenarios, the fastest and most accurate path to the recovery of an application, is a release pipeline. For application layers which only change when a new release happens, it may be wise to invest more heavily in pipeline optimization, than recovery of the application from traditional back up processes.

While a deployment pipeline can be the fastest path to recovery, it can also be the fastest path to remediation. When an application has a fast, efficient, and reliable release pipeline, the cloud management team has an option to automate deployment to a new host as a form of automated remediation.

There may be many other faster, more effective mechanisms for remediation and recovery. However, when use of an existing pipeline can meet business commitments and capitalize on existing DevOps investments, it may be a viable alternative.

### Clearly communicate changes to the workload

Change to any workload is among the biggest risks to workload operations. For any workload in the workload operations level of cloud management, the cloud management team should be closely aligned with the cloud adoption teams to understand changes coming from each release. This investment in proactive understanding will have a direct impact on operational stability.

## Improve outcomes

Ongoing operations are generally improved in one of two ways. The data and communication investments in a workload will yield suggestions for improvements along one of two paths: Automated remediation or Improved system design

### Technical debt resolution

The best workload operations plans will still require remediation. As the cloud management team seeks to stay connected to understand adoption efforts and releases, likewise the team should be regularly sharing remediation requirements to ensure technical debt and bugs are a continued priority for development teams.

### Automate remediation

Applying pareto's principle, 80% of negative business impact likely comes from 20% of the service incidents. When those incidents can't be addressed in normal development cycles, investments in remediation automation can significantly reduce business interruptions.

### Improved system design

In either case (technical debt resolution or automated remediation), system flaws are the common cause of most system outages. Adhering to a few design principles can have the greatest impact on overall workload operations.

1. Scalability: The ability of a system to handle increased load.
2. Availability: The proportion of time that a system is functional and working.
3. Resiliency: The ability of a system to recover from failures and continue to function.
4. Management: Operations processes that keep a system running in production.
5. Security: Protecting applications and data from threats.

The [Azure Architecture Framework](https://docs.microsoft.com/azure/architecture/guide/pillars) provides an approach to evaluating specific workloads for adherence to these pillars, in an effort to improve overall operations. These pillars can be applied to both platform operations and workload operations.

## Next steps

With a full understanding of the Manage methodology within the Cloud Adoption Framework, you are now armed to implement cloud management principles. See the [landing page for the Manage phase](../index.md) of the adoption lifecycle for guidance on making this methodology actionable within your operations environment.

> [!div class="nextstepaction"]
> [Apply this methodology](../index.md)
