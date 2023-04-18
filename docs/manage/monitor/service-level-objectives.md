---
title: Cloud monitoring service level objectives
description: Gain an understanding how service level objectives helps measure and quantify a given level of service to the consumers of your services hosted in Azure.
author: mgoedtel
ms.author: magoedte
ms.date: 04/07/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
---

# Cloud monitoring guide: Service Level Objectives

Before the emergence of cloud computing, the business relied on services delivered by their IT organization hosted on-premises. While the business expects value in services delivered, that value might not have been realized because IT didn't fully understand the complexity of those services. This creates undesirable outcomes in monitoring, measuring, and delivering the minimum level of service quality.

This article reviews the fundamental principles of service level objectives, and how to approach implementing and applying them.

## Overview

:::image type="content" source="media/service-level-objectives/sla-foundation-with-objectives-and-indicators.png" alt-text="Service Level Agreement foundation building blocks" border="false":::

Service level objectives (SLOs) are measurable goals set on a small number of key customer-centric service level indicators (SLIs). They measure your customer's experience of a business or infrastructure workload running natively in the cloud or in a hybrid scenario, and determine whether you, as the businesses service provider, are meeting the promises made to them in a formally negotiated service level agreement (SLA) or informal agreement between all parties. SLO/SLIs should be defined early in the design of any cloud business or infrastructure workload. In Azure, service level management is more lightweight, as the interfaces and functionality are predefined, and metrics are predefined by Microsoft. Consumers need to manage their service delivery expectations when utilizing cloud workloads.

Upholding SLOs should be the main business goal with the commitment from all teams involved in the service delivery lifecycle. You don't have to make all your SLOs binding, and not all SLOs have to be agreed to or placed in service agreements. Not all SLOs need a corresponding service requirement, for example many cloud services obviate the need to create or trace requirements.

As a service broker, you rely on Microsoft's commitment to reliability of services as defined in our service level agreements for Microsoft 365 and Azure services. This allows you to focus on your responsibilities in the service chain such as synthetic monitoring, network connectivity, and security and compliance.

## Purpose

SLOs serve many important purposes in the development and operations of cloud workloads, including:

- Give near real-time (NRT) view of the health of a service as experienced by a customer.
- Drive automated notification of service issues to customers, significantly reducing time to notify (TTN).
- Act as a primary signal for deployment operations, driving automated rollback if issues occur thus exposing fewer customers to potential issues.
- Provide validation that changes achieved the expected customer experience improvement.
- Help teams understand whether to build features or work on reliability.
- Enable objective, customer focused discussions about service health.
- Speed mitigation and root cause analysis (RCA) of customer issues by directing focus to the responsible service.
- Act as important input into architectural decisions when services take dependencies.
- Provide shared understanding of health measures, which builds trust between teams.
- Expose the same SLIs we use to run our business to our customers so they can run theirs.
- Enable a horizontal single pane of glass for the services & its dependencies and breakdown silos.

By using SLOs to drive your engineering process, DevOps and IT can get an early understanding of the *health* of the application or infrastructure service they build or migrate in Azure. This can then be used to drive both the human and the automated decisions that need to be made about the reliability of these services. It is this transformation in engineering practice that will have the biggest impact on the reliability of those services in the near term.

## Terminology

Below are the definitions for each of these terms, as well as a brief description. Some of these definitions are taken from Google's [SRE Handbook](https://landing.google.com/sre/sre-book/chapters/service-level-objectives/).

- **Service level agreement (SLA) or service agreement** is normally a binding commitment between a service provider and a customer. It is an explicit or implicit contract with your users that includes consequences of meeting (or missing) the SLOs they contain. Particular aspects of the service are quality, availability, and responsibilities that are agreed between the service provider and the service consumer.

- **Monitoring** is the practice of collecting quantitative real-time data about services and systems. Monitoring strategy relies on Metrics, Logs and Event Traces.

- **Metrics** measure relevant service behavior and can be aggregated into service level indicators (SLIs), which are processed and aggregated to measure the current operational state of a service and quantify its behavior. In some cases, SLIs directly indicate an issue with a service (for example, high failure rate). In other cases, they indicate a potentially troubling trend (for example, memory growth). SLIs are the main and real-time indicators of the current health of a service.

- **Logs** starts with the code and reports information about an individual execution of a code path, or discreet event. This information can be used to help troubleshoot and work towards identification of root cause issues that impact the customer experience and service reliability that are measured by SLIs/SLOs.

- **Service level objective (SLO)** is a target value for the service level, as measured by service level indicators (SLIs), that sets expectation about how well a service performs. SLOs specifically track end to end customer experience. To set good SLOs, you start with talking to your customers to define their desired experience and then instrument the service code to measure that experience (collect relevant SLIs) and set the target of how you meet customer expectations or not.

- **Service level indicator (SLI)** is a metric that quantifies the quality or reliability of the service. At a minimum, there are four common SLIs to evaluate - availability, latency, throughput, and error rate.

- **Availability** generally refers to the measurable or observable percentage of time that a system is operational and functional. You measure availability as a customer facing target for continuity of experience, which is in turn affected by one or more reliability issues (and other failure modes related to configuration changes, updates applied, etc.).

- **Error budget** is the percentage of remaining buffer you have in terms of your SLO. Error budgets are the tool DevOps and IT uses to balance service reliability with the pace of innovation.

## Approach

:::image type="content" source="media/service-level-objectives/slo-sli-logical-steps.png" alt-text="Workflow representing phases to create a Service Level Objective" border="false":::

Before you start implementing an SLO and SLI based monitoring practice, let's walk through the implementation steps outlined in this article.

- **Training** - Understand what is an SLO, why it is important to measure service reliability, and how to monitor your services to measure customer experience.

- **Perform service mapping exercise** - A service map is a graphical display of a service that illustrates the various components upon which successful delivery of that service relies. These components generally include hardware, cloud services features and functions, software, and configurable settings or roles, as well as customers and other services. A Microsoft-developed best practice as part of the [Microsoft Operations Framework (MOF)](/previous-versions/tn-archive/cc506049(v=technet.10)), a service map is a communications tool that illustrates the *what* of a service (its components and their relationships) as a basis for managing the *how* of a service (how the service is delivered and controlled to ensure expected availability, capacity, security, and manageability).

- **Identify monitoring data to collect** - Understand the Azure resources and the metric and log data to collect, allowing you to measure, obtain a baseline, and achieve visibility into service reliability from customer perspective.

- **Define SLO and corresponding SLIs** - Understand and document what you want to measure and how you'll measure it from customer point of view.

- **Develop SLO agreements** - SLO should be well understood by the IT and DevOps teams, and organizational leaders. Draft an SLO agreement that describes the SLIs, their success criteria, and specify where and how you record success or failure. Once the draft agreement is considered ready, meet with all stakeholders to review and approve the agreement. It might require a few iterations until all stakeholders are in alignment.

- **Iterate to improve** - Evaluate performance of the service level indicators defined to identify opportunities to improve as you continue learning the behavior of the underlying service components.

## How do you define SLOs?

The objective of an SLO is to obtain clear signals that accurately measure quality from the customer's perspective. Each service team creates a small set of Service Level Objectives (SLOs) that define the allowable range for the most important measurable metrics of the service, as experienced by the service consumer. An SLO is numeric goal that is defined for a metric emitted by a service. Metrics associated with this goal can be monitored to determine whether the service is healthy.

For example, here is a simplified example of an SLO for an internal time tracking web-based application - *Requests in the last 5 minutes are served in under 1000 milliseconds at the 99th percentile.*

The metrics are aggregations of time series data, called Service Level Indicators (SLIs). Where the SLIs are gathered matters a lot. In the above example, if the customer interacts with the service using an API, then measuring system latency and time to process requests are accurate SLIs. However, if the customer interacts with the service using a web portal, then the total time to service the request should also include the JavaScript performance of the web page.

The focus for service owners is to determine:

- **Which** scenarios are critical indicators of service health from the perspective of the customer,

- **Where** to gather the SLIs so that they are as close to the customer experience as possible, and

- **What** the SLOs should be for these SLIs.

SLOs can be defined with a gradual approach to drive achievement or it's prescribed directly by the business. You use the SLOs defined by a service to make architectural decisions about the how you're building them. Therefore, it is important to carefully choose which scenarios to measure and what time frame to measure them over.

To summarize, an SLO is composed of the following values:

- An SLI. For example, the proportion of sufficiently fast requests, as measured from the load balancer, are less than 400 ms.
- A duration. The time period in which a metric is measured.
- A target. For example, a target percentage of fast requests to total requests (such as 90%) that you expect to meet for a given duration.

### Two types of SLOs

If you look across the industry, there are two types of SLOs:

- **Service-centric SLOs** - These SLOs are tactical goals that teams define to gradually improve the quality of their service over time. They are designed to be pragmatic goals that are achievable in an engineering milestone.

   For example, if a service is currently achieving 99.7% availability, the team could set a goal to reach 99.9% availability in the next quarter.

- **Customer-centric SLOs** - These SLOs define the ideal future state or goal at which point further investments in quality would be deemed unnecessary, because you are fully meeting the customers expectations.

For example, if your customer expects that a business or infrastructure service you operate provides 99.99% availability, and the service currently only achieves 99.8% availability, the customer-centric SLO is still 99.99%.

**Defining proper SLOs takes time.** The first step is to talk to your customers and understand what your users want from the service in order to derive a small selection of indicators and document it. Learn the scenarios and tolerances for how they use your service, and what your service needs to deliver for them to successfully run their business. This is commonly an iterative experience, with their expectation ranging from *I want 100% availability under all conditions, with no impact to our revenue stream*, through managing wildly variant expectations between customer segments.

Monitoring approaches that look only at service (or service instance) health are vulnerable to missing customer experience issues at both ends of the spectrum; service health does not always correlate to quality of the customer experience. This is because there are different behavior characteristics between an Azure PaaS and SaaS service, the configuration of those Azure services, how and where (that is, which region) their resources are deployed, and the addition of your custom code/logic which adds further complexity.

When defining an SLO, it's important remember that your cloud provider(s) are a dependency on your SLA. Account for their service level agreements specified for each one of their services. For Azure, you can find them [here](https://azure.microsoft.com/support/legal/sla/), and Microsoft 365 [here](/office365/servicedescriptions/office-365-platform-service-description/service-level-agreement).

## How do you define SLIs?

A SLI specification is a formal statement of your users' expectations about one particular dimension of reliability for your service, like latency or availability.

Start simple by selecting the right metrics to measure and collect, and don't over complicate it by collecting too many metrics that aren't meaningful. Ensure that the SLIs you define have a direct relationship to the customer experience. This is why it is important to understand the perspective of the users in order to start with only a few indicators.

If your service is resource constrained in some way, such as memory or CPU, then its saturation can also be a great SLI. However, saturation should not be used as an SLO since it does not directly correspond to a poor user experience (a service can have high memory utilization but users are unaffected).

We recommend that you create no more than three indicators. More than three indicators rarely add significant value. Often, excessive numbers of indicators could mean you are including symptoms of primary indicators.<sup>1</sup> Traffic and saturation should be additional to those three main indicators, as those describe service load and support on interpretation of other service indicators.

<sup>1</sup>Laine Campbell, C. M. (2017). Database Reliability Engineering . O'Reilly Media, Inc.

## How do you implement SLOs?

The SLIs that matter most are the ones which most clearly represent an impact on your service from the perspective of your customers. For many services this includes latency, throughput, error rate, and availability. If your service has any special considerations that impact the customer experience, then SLIs for those areas should be measured as well. For example, the end to end processing latency for a messaging service is a direct indicator of the customer experience and should be covered by an SLI.

## Examples

Human resources is interested in modernizing their internal time tracking web-based application and host it in the Azure cloud, with the help of enterprise IT. They want the service to continue reaching all users in the organization, so they are interested in the following:

- Usage reports and how many users are using the service over time.
- Regular health monitoring such as availability, performance, security and compliance (service warranty).
- Cost, such as how the service itself costs in the billing each month.
- Cybersecurity, in terms of controlling access to resources and data by following a [Zero Trust security strategy](/security/zero-trust/).

As we see from these examples above, the SLO/SLI categories and examples are necessary to define early in the design of the service. That's not any different at all from the on-premises services you've been building.  

## SLO Tables/SLI categories

The following examples are by no means an exhaustive list. While reliability and maintainability SLOs are hallmarks of systems for decades, you can define SLOs that include measures for cybersecurity, quality and user experience, and cost.

### Services

Typical high level measures of a service or system usually codified in service agreements. Most modern agreements measure availability as the key SLO, and use simple downtime measures based on key workload items or units of production, such as authentication tokens, mailbox, or storage account.

|Category|Description|Example|
|-|-|-|
|Availability|Simple downtime or Mean Time Between Maintenance or operational availability (MTBM/(MTBM+MDT))|99.99% over a monthly period|
|Capacity|Ensure adequate, maximum or optimum business and service performance, throughput, storage, people, bandwidth, demand, resources and service functions. Includes labor and time limits to serve as triggers.|% Utilization (CPU, storage, memory, latency, throughput, scaling)|
|Security|Active threats and vulnerabilities (internal and external) that could or is causing harm to the business, assets, and data.|Detection of [HAFNIUM Threat](https://www.microsoft.com/security/blog/2021/03/02/hafnium-targeting-exchange-servers/)|
|Compliance|Updates, servicing levels, hardening compliance, desired configuration drift|99.5% serviced updates on all assets|
|Continuity|Ability to survive and recover from large disasters and external events.|Time (reconstitution)|
|Quality of Service (QoS)|Characteristics of the users actual experience over time.|[Teams call quality](https://support.microsoft.com/office/monitor-call-and-meeting-quality-in-teams-7bb1747c-d91a-4fbb-84f6-ad3f48e73511) - received packet loss < 2%|

### Reliability

Reliability, the classic SLO, implies the degree of the dependability, durability, quality over time, of systems, services, resources or components to failure and failovers, with management effort applied to address failure (such as building in more redundancy or adding a content delivery network) in order to increase operating time or availability. It could also mean the accuracy, fidelity, integrity and trustworthiness of data used to measure SLOs as well. It can mean the classic *probability* that a system will perform its intended function under specified conditions such as under temperature stress. Resilience also includes built-in design factors or features that provide adaptability such as scaling, cool down, load-balancing, recovery, unpredictable demand, degraded performance under severe stress as well as design for continuity in larger disasters (normally a separate SLO).

|Category|Description|Example|
|-|-|-|
|Failure Rate|Number of failures over the total operating hours|5 failures in 973 hrs our .00514|
|Mean Time Between Failure (MTBF)|MTBF is the inverse of failure rate|194.6 hours|

### Maintainability

Combine support SLOs for IT service management processes such as incident and problem management, along with reliability SLOs, so that availability measurement can be achieved.

|Category|Description|Example|
|-|-|-|
|Service Incident Performance|By category or product or priority.|Time and cost measures for each phase of the incident lifecycle.|
|Security Incident Performance|By category or product or priority.|Time and cost measures for each phase of the incident lifecycle.|
|Component Mean Time To Repair (MTTR)|From event detection through restoration or remediation.|
|Mean Time Between Maintenance (MTBM)|Mean or average time between all maintenance actions including preventative actions where normal production work occurs.|See Maintenance Delay Time|
|Maintenance Delay Time (MDT)|Total time from detection to recovery, including logistics and administrative delay.|Time to replace hardware to include ordering, shipment and installation.|

### Customer experience

|Category|Description|Example|
|-|-|-|
|Throughput|The amount, rate, or speed of workload or productive load placed on a system over time.|Transactions per unit of time.|
|Error rate|The number of like or total errors as a percentage.|% Security events|
|Latency|A measure of time or delay from input to output, movement of work through a process, or from application to user.|Average seconds.|

### Others

|Category|Description|Example|
|-|-|-|
|Cost|Measure expenditure, billing, invoices by service, component, or time.|Capital Expense or operating expense|
|Coverage|% of components, systems, and services under management (compliance)|Compliance|
|Feed reliability|Failures of heartbeat, connectors, changes, etc.|Tracking changes in mission-critical company data.|
|Productivity|Effectiveness to productively accomplish tasks|Labor, time by employee, analyst productivity.|

## Considerations

- **Ensure Access.** Ensure managers and other personas in the organization are granted access to the visualizations available in [Azure Monitor](/azure/azure-monitor/overview#visualizing-monitoring-data) or from other Azure services, especially Azure SaaS and PaaS, to avoid duplicating them.

- **Ensure monitoring coverage or *total asset visibility*.** Ensure agents, emitted logs, plus tables and queries for all assets that need to be managed and secured, and identify "blind spots" or gaps in coverage to ensure realism in SLOs.

- **Get the right data in front of the right consumers.** Ensure consumers of SLOs and SLIs are able to interpret the underlying data itself in order to build trust and guide decisions using the information gained from data.

- **Make Reasonable Promises.** When setting SLOs as *targets* especially when cost management is important, ensure actual system performance is not overly performing nor under-delivering, or adjust the target to manage customer expectations.

- **Account for unforeseen external events.** Develop continuity plans and risk assessments to account for events not under your control, such as weather, power outages, or disasters.

- **Account for Change.** Ensure SLOs account for alterations to service or changes to technical reliability, throughput, quality as well as maintainability - such as reductions in support staff.

- **Provide a balanced set of SLOs.** Ensure a range of SLOs that provide a balanced or *360-degree* perspective on the service or system, as well as the focus on reliability.

## Next steps

> [!div class="nextstepaction"]
> [Collect the right data](./data-collection.md)
