---
title: Operations management process
description: Establish an operational fitness review to support the ongoing operations management process
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2018
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal
---

# Establish operations management processes

As your enterprise begins to operate workloads in Azure, the next step is to establish a process for *operational management and fitness*. This process enumerates, implements, and iteratively reviews and optimizes the operational state for these workloads.

A process for operational fitness review ensures that the entire portfolio of workloads meet business commitments to performance, reliability, and cost. This process aligns the efforts of [Central IT](../organize/central-it.md), [Cloud Center of Excellence](../organize/cloud-center-of-excellence.md), and workload teams to deliver operational excellence at scale.

## Establish a core process for operational fitness review

Create a process for operational fitness review to fully understand the problems that result from running workloads in a production environment, and how to remediate and resolve those problems. This article outlines a high-level process for operational fitness review that your enterprise can use to achieve this goal.

## Operational fitness at Microsoft

From the outset, many teams across Microsoft have been involved in the development of the Azure platform. It's difficult to ensure quality and consistency for a project of such size and complexity. You need a robust process to enumerate and implement fundamental nonfunctional requirements on a regular basis.

The processes that Microsoft follows form the basis for the processes outlined in this article.

## Understand roles & operating models

Operations management is a broad discipline involving multiple roles across the company. Depending on the organizations operating model, those roles may operate in a matrixed environment with a number of hand offs between centralized and decentralized operations teams.

- **Central IT / CCoE:** This centralized technology function is responsible for the configuration, operations, governance, and security of all technology assets in the technology portfolio.
- **Cloud Operations:** A function within the centralized technology organization, this centralized operations function is responsible for the health and operations of the technology portfolio. It is their responsibility to ensure the process is run smoothly, that each adjacent role in the process has the tools they need, & that each of the subsequent roles is held accountable for expectations of this process.
- **Cloud Strategy:** Provides knowledge of the business to identify and prioritize commitments to maintain operational requirements of various workloads. This role also compares the mitigation cost to the business impact, and drives the final decision on remediation.
- **Workload Team:** Accountable for development and operations of discreet workloads which map to specific supporting applications, services, and infrastructure, whether on-premises or in the cloud. The role requires deep knowledge of the workload architecture.

Each organization's operating model determines the accountability and day-to-day activities of the roles above:

- **Centralized operations:** Central IT maintains full accountability for operations. Workload owners may have input to operations & configuration but they have no access to change production environments. Only Central IT and Cloud Operations can deliver operational change to improve operational fitness.
- **Decentralized operations:** Workload teams are fully accountable for operations, generally through a mature CI/CD pipeline and DevOps automation. In this model, there is no central support for configuration, operations, governance, or security. This approach to operations is out of scope for the Cloud Adoption Framework. This operating model should see the [Azure Well-Architected Framework](/azure/architecture/framework/) for operational guidance.
- **Enterprise operations:** Cloud Center of Excellence is accountable for operations. Cloud Operations and Workload Teams each share responsibility for specific aspects of operational fitness.

## Objective of the review

Operational fitness is evaluated across the portfolio using a few metrics: Reliability, Performance, and Cost. Together, these properties allow for rapid evaluation of the health and fitness of all assets in the portfolio. These metrics are evaluated across the three elevations of operations management.

![Elevations of operations](../_images/manage/beyond-the-baseline.png)

- **Operations baseline (or enhanced baseline):** Evaluates operational fitness across all deployed assets regardless of their function. This broad view of operations allows for sweeping changes and big impacts, but is limited by a lack of visibility into the architecture of individual workloads. All resources deployed in the cloud should be covered by an operations baseline with regular support from cloud operations. Some environments may require a higher degree of operational support to meet the needs of the enhanced baseline.
- **Platform operations:** Evaluates operational fitness of centralized technology platforms. This view of operations is more refined since it considers the architecture of the platform and how changes to the solution will impact operational fitness. Changes to central technology platforms can have a broad downstream impact on supported workloads. All mission-critical platforms should receive dedicated support from a central IT team.
- **Workload operations:** Evaluates operational fitness of an individual workload. This view of operations is most refined & should be considered when operational fitness improvements require changes to the architecture of a workload. Workload operations should adhere to the principles of the [Azure Well-Architected Framework](/azure/architecture/framework/). All mission-critical workloads with an active DevOps cycle should receive dedicated support from a workload team.

The objective of the operational fitness review is to regularly evaluate operational fitness at all levels. Identified improvements can then be applied at the appropriate level to inform the changes required to manage the overall portfolio.

## Process for operational fitness review

The key to maintaining the performance and continuity of an enterprise's portfolio is to implement a process for operational fitness review.

![An overview of the process for operational fitness review](../_images/manage/ofr-flow.png)

At a high level, the process has two phases. In the *prerequisites phase*, the requirements are established and mapped to supporting services. This phase occurs infrequently: perhaps annually or when new operations are introduced. The output of the prerequisites phase is used in the *flow phase*. The flow phase occurs more frequently, such as monthly.

### Prerequisites phase

The steps in this phase capture the requirements for conducting a regular review of the portfolio and any mission critical workloads.

1. **Identify critical business operations.** Identify the enterprise's mission-critical business operations based on agreed upon business commitments. Business operations are independent from any supporting service functionality. In other words, business operations represent the actual activities that the business needs to perform and that are supported by a set of IT services.

    The term *mission-critical* (or *business-critical*) reflects a severe impact on the business if the operation is impeded. For example, an online retailer might have a business operation, such as "enable a customer to add an item to a shopping cart" or "process a credit card payment." If either of these operations fails, a customer can't complete the transaction and the enterprise fails to realize sales.

1. **Map operations to services.** Map the critical business operations to the IT services (Baseline, Platform or Workload operations) that support them. Any technology platform or workload required to support a critical business function should also be identified to map operations and services to responsible teams.

1. **Analyze service dependencies.** Most business operations require orchestration among multiple supporting workloads and technology platforms. It's important to understand the dependencies between each set of supporting assets, and the flow of mission-critical transactions through these services.

    Also consider the dependencies between on-premises services and Azure services. In the shopping-cart example, the inventory stock-management service might be hosted on-premises and ingest data entered by employees from a physical warehouse. However, it might store data off-premises in an Azure service, such as [Azure Storage](/azure/storage/common/storage-introduction), or a database, such as [Azure Cosmos DB](/azure/cosmos-db/introduction).

An output from these activities is a set of *scorecard metrics* for operations management. The scorecard measures criteria such as Reliability, Performance, and Cost. Scorecard metrics express the operational criteria that you expect the service to meet.

The scorecard should be expressed in simple terms to facilitate meaningful discussion between the business owners, cloud operations, and workload teams. For example, a scorecard metric for reliability might be color-coded based on attainment of the agreed SLA. Green means meeting the defined SLA, yellow means failing to meet the defined criteria but actively implementing a planned remediation, and red means failing to meet the defined criteria with no plan or action.

It's important to emphasize that these metrics should directly reflect business commitments.

### Service-review phase

The service-review phase is the core of the operational fitness review. It involves these steps:

1. **Measure service metrics.** Use the scorecard metrics to monitor performance at each level of operations management, to ensure that the services meet the business commitments. Inventory & visibility services within the operations baseline is essential. If you can't monitor a set of resources with respect to the business commitments, consider the corresponding scorecard metrics to be red. In this case, the first step for remediation is to implement the appropriate service monitoring. For example, if the business expects a service to operate with 99.99 percent availability, but there is no production telemetry in place to measure availability, assume that you're not meeting the requirement.

2. **Plan remediation.** For each business commitment for which metrics fall below an acceptable threshold, determine the appropriate operations team to complete the required remediation. That team is responsible for calculating the cost of remediating the service to bring operations to an acceptable level. If the cost of remediating the issue is greater than the budget allocated to that service, Central IT/CCoE should review with the cloud strategy team to evaluate addition investments.

3. **Implement remediation.** After the cloud operations or workload team gain acceptance on a plan for remediation, implement it. Report the status of the implementation whenever you review scorecard metrics.

This process is iterative. The Central IT / CCoE team is accountable for managing the process & reporting on progress to the cloud strategy team. This team should meet regularly to review existing remediation projects, kick off the fundamental review of new workloads, and track the enterprise's overall scorecard. The team should also have the authority to hold remediation teams (Cloud operations or workload operations) accountable if they're behind schedule or fail to meet metrics.

## Review meeting

We recommend that your operational fitness be reviewed on a regular basis. Central IT / CCoE and Cloud operations team are required attendance in the review. Cloud strategy and workload operations teams are encouraged to attend but are operational. Example cadence, the core team might meet monthly to align on plans & hold various operations teams accountable. Quarterly, the cloud strategy and all workload teams could join to understand status and metrics.

Adapt the details of the process and meeting to fit your specific needs. We recommend the following considerations as a starting point:

- Centralized operations: Workload teams are unlikely to participate actively in the process, but should be included in any reports for visibility.
- De-centralized operations: Cloud operations team should share best practices used to improve operations of tech platforms with the workload teams. Workload teams should share changes to their respective workloads to identify improvements that could be applied to tech platforms and the operations baseline.

## Recommended resources

- [Azure Automanage](https://azure.microsoft.com/services/azure-automanage/). Azure Automanage automatically monitors operational fitness across the operations baseline & automates the application of various remediation strategies across the portfolio.
- [Azure Advisor](/azure/advisor/). Azure Advisor provides personalized recommendations based on your usage and configurations to help optimize your resources. By default this tool provides recommendations across a subscription to improve the operations baseline. It can also be used more granularly to identify improvements to tech platforms or individual workloads.
- [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/): Guidance to improve workload operations or to guide decentralized operations.
