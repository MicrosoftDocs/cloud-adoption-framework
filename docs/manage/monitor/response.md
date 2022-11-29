---
title: Cloud monitoring and response
description: Gain an understanding of the response discipline in observability and recommended approaches to acting on significant events detected.
author: MGoedtel
ms.author: brblanch
ms.reviewer: tozimmergren
ms.date: 11/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, engagement-fy23
---

# Cloud monitoring guide: Response

In the [Observability](observability.md) article, you learned about the five monitoring principles. In this article, the focus is on the response discipline. Response is the result of defining one or more *actions* based on data-driven decisions from monitoring that let service consumers:

* Act smart, based on the good use of well-tuned monitoring data.
* Apply monitoring throughout incident/problem activities.
* Automate investigation, diagnosis, resolution, recovery, and remediation.

## Overview

The principle of *significance* applies here as a sort of process flow decision or policy for action, which is also valuable for tuning and optimizing alerts, notifications, and report digests. Cloud monitoring can now do much more than notify humans that something is wrong, and monitoring plays a critical role in a wide range of scenarios:

* Dynamic control of service/system behavior to avoid and eliminate incidents.
* Inform or provide routine signaling or telemetry for dynamic processes, compliance, automatic scaling, and visualizations.
* Help the IT organization act on and manage change.

A *current event* can be any event worth watching or knowing about that could be significant to raise an *alert.*  Cloud services emit diagnostic and security *logs* that can now be more easily ingested, combined, correlated, and queried. As a result, you can decide what mitigation action to take, from raising an alert or creating a bug in DevOps to retaining past events for future predictive analyses.

## Alerting

There's less need for alerts to serve the fundamental reactive function of notifying humans when something is wrong and triggering work ticketing systems. Focus less on integrating monitoring with IT Service Management (ITSM) systems for Incident Management, and seize new opportunities that let cloud automation replace more expensive service management processes, thereby eliminating incidents.

Alerting helps proactively ensure that the service/system remains healthy, responsive, and secure. It's an integral part of any service that guarantees performance, availability, and privacy to the business where you need to act on the data immediately. Escalating an alert isn't crucial to observability, and today it shouldn't be considered the first line of defense.

A more primitive role of monitoring was to raise alerts for a reactionary response, as follows:

|Detected condition |Action |
|----|----|
|<li>Cluster is down</li> <li>Database is full</li> <li>High CPU utilization</li> <li>Security threat</li> |Alert and notify, or raise an incident record. |

This approach is considered outdated and conflicting with modern service management or cloud operations recommended practices. This approach closely follows the traditional ITIL Incident Management path, which doesn't match the goals of cloud efficiency through agility, minimum cost, and optimization.

A modern approach might have a frequency of detected conditions that are much more informative and automated, for example:

|Detected condition |Primitive action |Modern action |
|-----|-----|-----|
|<li>Performance metric - high memory utilization.</li> <li> Security threat - detected suspicious network activity.</li> <li>Availability fault - Azure blob storage requests are failing.</li> | Alert and notify, webhook, push notification, playbook, auto-scale |Query logs to identify the offending component and trigger automation to correct the problem with the offending component. |

Here's a list of relevant resources for alerting and automation capabilities in Azure:

* [What are Azure Monitor Alerts?](/azure/azure-monitor/alerts/alerts-overview)
* [Integrate Azure Monitor with supported IT Service Management (ITSM) Integration products](/azure/azure-monitor/alerts/itsmc-overview).

## Cloud monitoring

Compared to monitoring platforms and related tools that were available in the past, cloud computing offers:

* Much more flexibility to devise response options.
* Easier ways to develop and enable automated responses.
* Cloud protocols or API methods more easily integrate with work management systems, including DevOps.

And consider the following modes for the range of automated action, whether that be for investigation, enrichment, routing, assignment, remediation, recovery, or resolution:

|Orchestration method|Description|
|-|-|
|**Fully Automated**|Actions are performed automatically. Full automation should be proven reliable, efficient, and durable to where its usefulness isn't short-lived, and is safe. Full automation frees up your resources so they can focus more on your strategic initiatives.|
|**Semi-automated**|Approval is required for any remediation action.|
|**Manual**|An operator selects an automation example or playbook from a curated library.|

Alerting depends on the instrumented data based on security events, performance metrics, availability information, and logs. Data-driven actions result from analyzing holistic, end-to-end perspectives of each monitored resource by aggregating and processing different collected data types to determine the impact and what responsive action to take.

Expand your reading with these resources to learn more about automation based on metric alerts and security events:

* [Get started with autoscale in Azure](/azure/azure-monitor/autoscale/autoscale-get-started) using Azure Monitor.

## Cost efficiency

As with the other observability disciplines, the team needs to understand and realize the cost implications and how the types of responses defined in support of modern incident management help control costs. While the overarching goal is to reduce Mean Time to Recovery (MTTR) by quickly responding and resolving an issue, you must constantly evaluate the potential cost and impact on the IT or business revenue stream.

Every reported incident has a cost. Suppose the organization invests in orchestration to automate a response. In that case, you should evaluate the cost-benefit and impact of the cost by increasing consumption from the cloud service to utilize those services or features that enable automation.

## Automation

Cloud automation offers significant advantages for security and health monitoring. Speed, flexibility, and precision are three archetypes that cloud automation bring to responsive operations. Often this is called orchestration, and the Microsoft cloud offers several services.

For example:

1. An identity-driven threat is detected from one or more logs, raising an alert.
2. Automation is immediately triggered to gather more information and correlate more logs - to enrich the alert.
3. An operator takes action by selecting the right automation from a library, such as disabling a user account.

And later, the example or use case can be fully automated.

The role of automation then provides a sort of *playbook* that reduces costs and saves time:

* No security incident was needed to follow through a lengthy investigation, diagnosis, resolution, and recovery.
* The detection-to-correction cycle could be in seconds or minutes versus hours.

Next, your team needs to build a list or library of automation examples that can be flexibly used - either from raw material found on public websites or internally curated and stored in a source control repository.

Here's a list of suggested reading for more automation based on identity- or security events:

* [Automatically create incidents from Microsoft security alerts](/azure/sentinel/create-incidents-from-alerts) with Microsoft Sentinel.
* [Security Orchestration, Automation, and Response (SOAR) in Microsoft Sentinel](/azure/sentinel/automation)

## Agile work management

Traditional monitoring was tied to your ITSM system, notably for Incident Management. This is no longer as useful in the cloud, for the reasons that were cited above, but it's still vital for traditional incident-significant service disruption events.

Agile and DevOps processes are now needed:

* You'll need a repository or source control of automation playbooks, scripts, and documentation, for example
* You manage a library of cloud automation using Agile work management methods.

You then get two things:

* Monitoring solutions in production can then call or get the latest from the repository when needed, or
* DevOps Work Management pushes the latest updates from the repository to the cloud service where the library is kept.

This is a derivative of incident management in DevOps, and to learn more, see [DevOps Incident Management: A Guide With Best Practices](https://www.xplg.com/devops-incident-management-best-practices/).

There are many services in Azure that help you monitor and diagnose the infrastructure, platform, and software layers managed by Microsoft and can't be controlled by you, the customer. These services automatically generate logs that record the status of an event and complement the diagnostic or any other telemetry you collect from the different resources in Azure.

It's important to understand how you can structure all that data that has been gathered to meet your analysis requirements, and when combined with data from each part of the service and data generated from other dependencies that might not be in the same region, subscription, or resource group. This information requires careful correlation to ensure that data is combined accurately.

Use this exercise to determine how the monitoring data can be used to identify potential failures, resource bottlenecks, under- or over-utilization, and more. Then evaluate if they're the right conditions to use orchestration as the first response, escalate to IT Operations, or follow a workflow in the DevOps Operate phase.

Under certain circumstances, some alerts can be informational to inform you that:

* A VM was automatically shut down to minimize waste and control costs based on a schedule or low utilization detected.
* IaaS or PaaS resources are idle for an extended period or not provisioned based on Azure Advisor recommendations.

In the first example, the orchestration was used based on a native scheduling feature and by the monitoring platform detecting the utilization condition. Instead of the alert notifying or escalating as the only action, it informs you of the action performed and why. In the second example, orchestration can be used to manage those infrastructure-related activities based on business logic or ITSM process workflow. Much faster responses and actions are needed today, and with the cloud *alerting* is less for humans than for an automated response or an ongoing orchestration as part of an automated value stream.

Keep in mind that learning is key.

## Successful alerting strategy

*You can't fix what you don't know is broken.*

Alerting on what matters is critical. It's underpinned by collecting and measuring the right metrics and logs. You also need a monitoring tool capable of storing, aggregating, visualizing, analyzing, and initiating an automated response when conditions are met. You can improve the observability of your services and applications only if you fully understand their composition. You map that composition into a detailed monitoring configuration to be applied by the monitoring platform. This configuration includes the predictable failure states (the symptoms, not the cause of the failure) that make sense to alert for.

Consider the following principles for determining whether a symptom is an appropriate candidate for alerting:

* **Does it matter?** Is the issue symptomatic of a real problem or issue influencing the application's overall health? For example, do you care whether the CPU utilization is high on the resource? Or that a particular SQL query running on a SQL database instance on that resource is consuming high CPU utilization over a sustained period? Because the CPU utilization condition is a real issue, you should trigger an alert. But you don't need to notify the team because it doesn't help point to what is causing the condition in the first place. However, alerting and reporting on the SQL query process utilization issue is relevant and actionable.

* **Is it urgent?** Is the issue real, and does it need urgent attention? If so, the responsible team should be immediately notified.

* **Are your customers affected?** Are users of the service or application affected by the issue?

* **Are other dependent systems affected?** Are there alerts from interrelated dependencies that can be correlated to avoid notifying different teams all working on the same problem?

Ask these questions when you're initially developing a monitoring configuration. Test and validate the assumptions in a nonproduction environment and then deploy them into production. Monitoring configurations are derived from known failure modes, test results of simulated failures, and experience from different team members.

After the release of your monitoring configuration, you can learn a lot about what's working and what's not. Consider high alert volume, issues unnoticed by monitoring but noticed by end users or the cloud provider (through their tools), and what were the best actions to have taken as part of this evaluation. Identify changes to implement to improve service delivery as part of an ongoing, continuous monitoring improvement process. It's not just about evaluating alert noise or missed alerts but also the effectiveness of how you're monitoring the workload. It's about the effectiveness of your alert policies, process, and overall culture to determine whether you're improving.

[Azure Monitor](/azure/azure-monitor/overview) support alerts based on static or even dynamic thresholds, and actions set up on top of them. Examples include alerts for email, SMS, and voice calls for simple notifications. Azure Monitor also [integrates with various IT service management (ITSM) solutions](/azure/azure-monitor/alerts/itsmc-overview) to automate the creation of incident records and escalate to the right support team or any other alert management system that uses a webhook.

If you are in a hybrid scenario or are migrating resources directly to the cloud, you can still utilize [System Center Operations Manager](/system-center/scom/welcome) (SCOM), which has similar capabilities for alert automation. However, for cloud-native workloads and the more modern monitoring needs, Azure Monitor usually covers the common use cases.

You can also, as an example, use the following Azure services or service-related features to help automate response and recovery actions:

* [Azure Automation](/azure/automation/overview).
* [Azure Logic Apps](/en-us/azure/logic-apps/logic-apps-overview).
* [Azure Functions](/azure/azure-functions/functions-overview).
* Azure Kubernetes Service using the [Kubernetes container orchestration](/azure/architecture/microservices/design/orchestration) engine supporting containerized microservices.
* [Security Orchestration, Automation, and Response (SOAR)](/azure/sentinel/automation) in Microsoft Sentinel.
* Further, learn more about [best practices for Autoscaling](/azure/architecture/best-practices/auto-scaling) various services in Azure.

While notifying the responsible teams is the most common action for alerting, automating corrective actions is often appropriate. This automation can help streamline the entire incident management process, and automating these recovery tasks can also reduce the risk of human error.
