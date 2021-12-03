---
title: Cloud monitoring and response
description: Gain an understanding of the response discipline in observability and recommended approaches to acting on significant events detected.
author: MGoedtel
ms.author: brblanch
ms.date: 12/02/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank
---

# Cloud monitoring guide: Response

In the [Observability](observability.md) article we discussed the five disciplines of monitoring. In this next article, we focus on the response discipline. Response is the result of defining one or more *actions* based on data-driven decisions from monitoring that let service consumers:

* Act smart, based on the good use of well-tuned monitoring data.
* Leverage monitoring throughout incident/problem activities.
* Automate investigation, diagnosis, resolution, recovery, and remediation.

## Overview

The principle of *significance* applies here, as a sort of process flow decision or policy for action, which is also useful to tune and optimize alerts, notifications and reports digests. Cloud monitoring can now do much more than notify humans that something is wrong, and we need monitoring to play a critical role for a wide range of scenarios:

* Dynamic control of service/system behavior to avoid and eliminate incidents.
* Inform or provide routine signaling or telemetry for dynamic processes, compliance, automatic scaling, and visualizations.
* Help the IT organization act on and manage change.

A *current event* can be any occurrence that is worth watching, worth knowing about that could be significant to raise an *alert.*  Cloud services emit diagnostic and security *logs* that can now be more easily ingested, combined, correlated, and queried. As a result you can decide what mitigation action to take, from raising an alert, creating a bug in DevOps, to also retaining past events for future predictive analyses.

## Alerting

There is less need for alerts to serve the basic reactive function of notifying humans when something is wrong, and triggering work ticketing systems. Focus less on integrating monitoring with IT Service Management (ITSM) systems for Incident Management, and seize new opportunities that let cloud automation replace more expensive service management processes, thereby eliminating incidents.

Alerting helps proactively ensure that the service/system remains healthy, responsive, and secure. It's an important part of any service that makes performance, availability, and privacy guarantees to the business where the data might need to be acted on immediately. Escalating an alert isn’t important to observability, and today it shouldn’t be considered the first line of defense.

A more primitive role of monitoring was to raise alerts for reactionary response, as follows:

|Detected condition |Action |
|----|----|
Cluster is down, database is full, high CPU, privacy breach, security threat, etc.|Alert and notify, or raise an incident record. |

We consider this approach outdated and not in alignment with modern service management or cloud operations recommended practices. This approach closely follows the traditional ITIL Incident Management path, which doesn't match the goals of the cloud efficiency through agility, minimum cost, optimization, and so forth.

A modern approach might have a frequency of detected conditions that are much more informative and automated, for example:

|Detected condition |Primitive action |Modern action |
|-----|-----|-----|
|CPU > 95%, security threat, telemetric signaling, threshold| Alert and notify, webhook, push notification, playbook, auto-scale |Query logs to identify the offending component and trigger automation to correct the problem with the offending component. |

## Cloud monitoring

Compared to monitoring platforms and related tooling that were available in the past, cloud computing offers:  

- Much more flexibility to devise response options.

- Easier ways to develop and enable automated responses.

- Cloud protocols or API methods more easily integrate with work management systems, including DevOps.

And consider the following modes for the range of automated action, whether that be for investigation, enrichment, routing, assignment, remediation, recovery or resolution:

|Orchesration method|Description|
|-|-|
|**Fully Automated**|Actions are performed automatically. To use full automation it should be proven to be reliable, efficient, that it's durable to where its usefulness isn't short lived, and safe. Full automation frees up your resources so they can focus more on your strategic initiatives.|
|**Semi-automated**|Approval is required for any remediation action.|
|**Manual**|An operator selects an automation example or playbook from a curated library.|

Alerting usually depends on the instrumented data based on security events, performance metrics, availability information, and logs. Data-driven actions are the result of analyzing holistic, end-to-end perspectives of each monitored resource by aggregating and processing different types of collected data types, to determine the impact and what responsive action to take.

## Cost efficiency

As with the other observability disciplines, the team needs to understand and realize what the cost implications are and how the types of responses defined in support of modern incident management help control costs. While the overarching goal is to reduce Mean Time to Recovery (MTTR) by quickly responding and resolving an issue, you need to always evaluate the potential cost and impact to the IT or business revenue stream.

Every reported incident has a cost. If the organization invests in orchestration to automate a response, you should evaluate what the cost benefit is, as well as what the cost impact is by increasing consumption from the cloud service to utilize those services or features that enable automation.

## Automation

Cloud automation offers significant advantages for security and health monitoring. Speed, flexibility, and precision are three archetypes that cloud automation brings to responsive operations. Often we call this orchestration, and the Microsoft cloud offers several services.

For example:

1. An identity-driven threat is detected from one or more logs, raising an alert.
2. Automation is immediately triggered to gather more information and correlate more logs - to enrich the alert.
3. An operator takes action, by selection the right automation from a library, such as disabling a user.

And later, the example or use case can be fully automated.

The role of automation then provides a sort of *playbook* that reduces costs and saves time:

* No security incident was needed to follow through lengthy investigation and diagnosis, resolution and recovery.
* The detection-to-correction cycle could be in seconds or minutes versus hours.

Next, your team need to build a list or library of automation examples that can be flexibly put to use - either from raw material found on public web sites or curated internally and stored in a source control repository.

## Agile work management

Traditional monitoring was tied to your ITSM system, notably for Incident Management. This is no longer as useful in the cloud, for the reasons that we cited above, but is still important for traditional incident-significant service disruption events.

Agile and DevOps is now needed:

* You'll need a repository or source control of automation playbooks, scripts and documentation for example
* You manage a library of cloud automation using Agile work management methods.

You then get two things:

* Monitoring solutions in production can then call or get the latest from the repository when needed, or

* DevOps Work Management pushes the latest updates from the repository to the cloud service where the library is kept.

This is a derivative of incident management in DevOps, and to learn more see [DevOps Incident Management: A Guide With Best Practices](https://www.xplg.com/devops-incident-management-best-practices/).

There are many services in Azure that help you monitor and diagnose the infrastructure, platform, and software-layers that are managed by Microsoft and can't be controlled by you, the customer. These services automatically generate logs that record status or an event, and compliment the diagnostic or other telemetry you collect from the different resources in Azure.

It's important to understand how you can structure all that data that has been gathered to meet your analysis requirements, and when combined with data from each part of the service and data generated from other dependencies that might not be in the same region, subscription, or resource group. This information requires careful correlation to ensure that data is combined accurately.

Use this exercise to determine how the monitoring data can be used to identify potential failures, resource bottlenecks, under or over utilization, and so forth. Then evaluate if they are the right conditions to use orchestration as the first response, escalate to IT Operations, or follow a workflow in the DevOps Operate phase.

Under certain circumstances, some alerts can be informational to inform you that:

* A VM was automatically shut down to minimize waste and control costs based on a schedule or low utilization detected.
* IaaS or PaaS resources are idle for a long period of time or not provisioned based on Azure Advisor recommendations.

In the first example, orchestration was used based on a native scheduling feature, and by the monitoring platform detecting the utilization condition. Instead of the alert notifying or escalating as the only action, it informs you of the action performed and why. In the second example, orchestration can be used, based on business logic or ITSM process workflow, to manage those infrastructure-related activities. Much faster response and actions are needed today, and with the cloud *alerting* is less for humans than it is for an automated response, or just an ongoing orchestration as part of an automated value stream.

Keep in mind that learning is key.

## Successful alerting strategy

*You can't fix what you don't know is broken.*

Alerting on what matters is critical. It's underpinned by collecting and measuring the right metrics and logs. You also need a monitoring tool capable of storing, aggregating, visualizing, analyzing, and initiating an automated response when conditions are met. You can improve the observability of your services and applications only if you fully understand its composition. You map that composition into a detailed monitoring configuration to be applied by the monitoring platform. This configuration includes the predictable failure states (the symptoms, not the cause of the failure) that make sense to alert for.

Consider the following principles for determining whether a symptom is an appropriate candidate for alerting:

- **Does it matter?** Is the issue symptomatic of a real problem or issue influencing the overall health of the application? For example, do you care whether the CPU utilization is high on the resource? Or that a particular SQL query running on a SQL database instance on that resource is consuming high CPU utilization over a sustained period? Because the CPU utilization condition is a real issue, you should alert on it. But you don't need to notify the team, because it doesn't help point to what is causing the condition in the first place. Alerting and notifying on the SQL query process utilization issue is both relevant and actionable.

- **Is it urgent?** Is the issue real, and does it need urgent attention? If so, the responsible team should be immediately notified.

- **Are your customers affected?** Are users of the service or application affected as a result of the issue?

- **Are other dependent systems affected?** Are there alerts from dependencies that are interrelated, and that can possibly be correlated to avoid notifying different teams all working on the same problem?

Ask these questions when you're initially developing a monitoring configuration. Test and validate the assumptions in a nonproduction environment, and then deploy into production. Monitoring configurations are derived from known failure modes, test results of simulated failures, and experience from different members of the team.

After the release of your monitoring configuration, you can learn a lot about what's working and what's not. Consider high alert volume, issues unnoticed by monitoring but noticed by end users or the cloud provider (through their tools), and what were the best actions to have taken as part of this evaluation. Identify changes to implement to improve service delivery, as part of an ongoing, continuous monitoring improvement process. It's not just about evaluating alert noise or missed alerts, but also the effectiveness of how you're monitoring the workload. It's about the effectiveness of your alert policies, process, and overall culture to determine whether you're improving.

Both System Center Operations Manager and Azure Monitor support alerts based on static or even dynamic thresholds, and actions set up on top of them. Examples include alerts for email, SMS, and voice calls for simple notifications. Both of these services also support IT service management (ITSM) integration, to automate the creation of incident records and escalate to the correct support team, or any other alert management system that uses a webhook.

When possible, you can use any of the following Azure services or service-related features to automate recovery actions, or any combination thereof. These include:

* Azure Automation
* Azure Logic Apps
* Azure Functions
* Azure Kubernetes Service using the Kubernetes container orchestration engine supporting containerized microservices
* Azure or autoscaling in the case of elastic workloads

While notifying the responsible teams is the most common action for alerting, automating corrective actions might also be appropriate. This automation can help streamline the entire incident management process, and automating these recovery tasks can also reduce the risk of human error.
