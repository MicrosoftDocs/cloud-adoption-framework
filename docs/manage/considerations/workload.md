---
title: Workload operations in cloud management
description: Understand an approach to investing in the continued operations of these high priority workloads to drive improved business commitments.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal
---

# Workload operations in cloud management

Some workloads are critical to the success of the business. For those workloads, a management baseline is insufficient to meet the required business commitments to cloud management. Platform operations might not even be sufficient to meet business commitments. This highly important subset of workloads requires a specialized focus on the way the workload functions and how it's supported.

In return, the investment in workload operations can lead to improved performance, decreased risk of business interruption, and faster recovery when system failures occur. This article discusses an approach to investing in the continued operations of these high priority workloads to drive improved business commitments.

## When to invest in workload operations

The *Pareto principle* (also known as the *80/20 rule*) states that 80 percent of effects come from 20 percent of the causes. When IT portfolios are allowed to grow organically over time, this rule is often illustrated in a review of the IT portfolio. Depending on the effect that requires investment, the cause can vary but the general principle holds true:

- 80 percent of system failures tend to be the result of 20 percent of the common errors or bugs.
- 80 percent of business value tends to come from 20 percent of the workloads in a portfolio.
- 80 percent of the effort to migrate to the cloud comes from 20 percent of the workloads being moved.
- 80 percent of cloud management efforts will support 20 percent of the service incidents or trouble tickets.
- 80 percent of business impact from an outage will come from 20 percent of the systems affected by the outage.

Workload operations should be applied only when the cloud adoption strategy, business outcomes, and operational metrics are each well understood. This is a paradigm shift from the classic view of IT. Traditionally, IT assumed that all workloads experienced the same degree of support and required similar levels of priority.

Before they invest in deep workload operations, both IT and the business should understand the business justifications and the expectations of increased investment in cloud management.

## Start with the data

Workload operations begin with a deep understanding of workload performance and support requirements. Before the team invests in workload operations, it must have rich data about workload dependencies, application performance, database diagnostics, virtual machine telemetry, and incident history.

This data seeds the insights that drive workload operations decisions.

## Continued observation

Initial data and ongoing telemetry can help formulate and test theories about the performance of a workload. But ongoing workload operations are rooted in a continued and expanded observation of workload performance, with a heavy focus on application and data performance.

### Test the automation

At the application level, the first requirements of workload operations, is an investment in deep testing. For any application that's supported through workload operations, a test plan should be established and regularly executed to deliver functional and scale testing across the applications.

Regular test telemetry can provide immediate validation of various hypotheses about the operation of the workload. Improving operational and architectural patterns can be executed and tested. The resulting deltas provide a clear impact analysis to guide continued investments.

### Understand releases

A clear understanding of release cycles and release pipelines is an important element of workload operations.

An understanding of cycles can prepare for potential interruptions and allow the team to proactively address any releases that might produce an adverse effect on operations. This understanding also allows the cloud management team to partner with adoption teams to continuously improve the quality of the product and address any bugs that might affect stability.

More importantly, an understanding of release pipelines can significantly improve the recovery point objective (RPO) of a workload. In many scenarios, the fastest and most accurate path to the recovery of an application is a release pipeline. For application layers that change only when a new release happens, it might be wise to invest more heavily in pipeline optimization than on the recovery of the application from traditional back-up processes.

Although a deployment pipeline can be the fastest path to recovery, it can also be the fastest path to remediation. When an application has a fast, efficient, and reliable release pipeline, the cloud management team has an option to automate deployment to a new host as a form of automated remediation.

There might be many other faster, more effective mechanisms for remediation and recovery. However, when the use of an existing pipeline can meet business commitments and capitalize on existing DevOps investments, the existing pipeline might be a viable alternative.

### Clearly communicate changes to the workload

Change to any workload is among the biggest risks to workload operations. For any workload in the workload operations level of cloud management, the cloud management team should closely align with the cloud adoption teams to understand the changes coming from each release. This investment in proactive understanding will have a direct, positive impact on operational stability.

## Improve outcomes

The data and communication investments in a workload will yield suggestions for improvements to ongoing operations in one of three areas:

- Technical debt resolution
- Automated remediation
- Improved system design

### Technical debt resolution

The best workload operations plans still require remediation. As your cloud management team seeks to stay connected to understand adoption efforts and releases, the team likewise should regularly share remediation requirements to ensure that technical debt and bugs are a continued priority for your development teams.

### Automated remediation

By applying the Pareto principle, we can say that 80 percent of negative business impact likely comes from 20 percent of the service incidents. When those incidents can't be addressed in normal development cycles, investments in remediation automation can significantly reduce business interruptions.

### Improved system design

In the cases of technical debt resolution and automated remediation, system flaws are the common cause of most system outages. You can have the greatest impact on overall workload operations by adhering to a few design principles:

- **Scalability:** The ability of a system to handle increased load.
- **Availability:** The percentage of time that a system is functional and working.
- **Resiliency:** The ability of a system to recover from failures and continue to function.
- **Management:** Operations processes that keep a system running in production.
- **Security:** Protecting applications and data from threats.

To help improve overall operations, the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) provides an approach to evaluating specific workloads for adherence to these pillars. Apply the pillars to both platform operations and workload operations.

## Next steps

With a full understanding of the Manage methodology within the Cloud Adoption Framework, you are now armed to implement cloud management principles. Learn how to make this methodology actionable within your operations environment.

> [!div class="nextstepaction"]
> [Apply this methodology](../index.md)
