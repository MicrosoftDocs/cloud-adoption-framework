---
title: Cloud monitoring and response
description: Gain an understanding of the response discipline in observability and recommended approaches to acting on significant events detected.
author: Zimmergren
ms.author: tozimmergren
ms.reviewer: tozimmergren
ms.date: 04/21/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, engagement-fy23
products: azure-monitor
---

# Cloud monitoring and response

This article is part of a series in [the cloud monitoring guide](./index.md).

Response is the result of defining one or more _actions_ based on data-driven decisions from monitoring that let service consumers:

- **Make it actionable**: Use well-tuned monitoring configurations to create actionable signals.
- **Continuously monitor**: Apply monitoring throughout the incident and troubleshooting activities to further help diagnose problems.
- **Automate**: Configure automatic investigation, diagnosis, resolution, recovery, and remediation based on identified signals.

 The principle of _significance_ applies here. This helps with process flow or policy for action to tune and optimize alerts, notifications, and report digests. Cloud monitoring is much more than notifying humans that something is wrong. It is also about providing signals to systems and services to react.

Monitoring plays a critical role in a wide range of scenarios:

- **Enabling dynamic service behavior**: Dynamically control systems and services to react based on monitoring data and eliminate incidents automatically.
- **Continuously evaluate signals**: Constantly inform and provide telemetry for dynamic processes, compliance, automatic scaling, and visualizations.
- **Organizational actions**: Help the IT organization act on and manage change.

## Alerting

Automation replaces more expensive service management processes in the modern cloud landscape, eliminating more incidents. Alerts play a crucial role in awareness but must be actionable to avoid alert fatigue or noise.

Defining alerts helps proactively ensure that the services and systems remain healthy, responsive, reliable, and secure. Guaranteeing performance, upholding [Service Level Objectives](./service-level-objectives.md) (SLO), availability, and privacy needs a proper alerting strategy. Escalating alerts isn't crucial to observability, and today it shouldn't be considered the first line of defense. Instead, automation should play a critical role here.

Traditionally, monitoring meant raising an alert that someone could act on, implying an entirely reactive process. This approach must be revised following modern service management or cloud operations practices. This approach closely follows the traditional ITIL Incident Management path, which doesn't match the goals of cloud efficiency through agility, minimum cost, and optimization.

A modern approach might have a frequency of detected conditions that are much more informative and automated, for example:

|Detected condition |Primitive action |Modern action |
|-----|-----|-----|
|<li>Performance metric - high memory utilization.</li> <li> Security threat - detected suspicious network activity.</li> <li>Availability fault - Azure blob storage requests are failing.</li> | Alert and notify, webhook, push notification, playbook, auto-scale |Query logs to identify the offending component and trigger automation to correct the problem with the offending component. |

Here's a list of relevant resources for alerting and automation capabilities in Azure:

- [What are Azure Monitor Alerts?](/azure/azure-monitor/alerts/alerts-overview)
- [Integrate Azure Monitor with supported IT Service Management (ITSM) Integration products](/azure/azure-monitor/alerts/itsmc-overview).
- [Automate threat response in Microsoft Sentinel with automation rules](/azure/sentinel/automate-incident-handling-with-automation-rules)

## Modern cloud monitoring

Compared to monitoring platforms and related tools that were available in the past, cloud computing offers:

- Much more flexibility to devise response options.
- Easier ways to develop and enable automated responses.
- Cloud protocols or API methods more easily integrate with work management systems, including DevOps.

Consider the following modes for the range of automated action, whether that be for investigation, enrichment, routing, assignment, remediation, recovery, or resolution:

|Orchestration method|Description|
|-|-|
|**Fully Automated**|Actions are performed automatically. Full automation should be proven reliable, efficient, and durable to where its usefulness isn't short-lived and is safe. Full automation frees up your resources so they can focus more on your strategic initiatives.|
|**Semi-automated**|Approval is required for any remediation action.|
|**Manual**|An operator selects an automation example or playbook from a curated library.|

Alerting depends on the instrumented data based on security events, performance metrics, availability information, and logs. Data-driven actions result from analyzing holistic, end-to-end perspectives of each monitored resource by aggregating and processing different collected data types to determine the impact and what responsive action to take.

Expand your reading with these resources to learn more about automation based on metric alerts and security events:

- [Get started with autoscale in Azure](/azure/azure-monitor/autoscale/autoscale-get-started) using Azure Monitor.

## Cost efficiency

As with the other observability disciplines, the team needs to understand and realize the cost implications and how the types of responses defined in support of modern incident management help control costs. While the overarching goal is to reduce Mean Time to Recovery (MTTR) by quickly responding and resolving an issue, you must constantly evaluate the potential cost and impact on the IT or business revenue stream.

Every reported incident has a cost. Suppose the organization invests in orchestration to automate a response. In that case, you should evaluate the cost-benefit and impact of the cost by increasing consumption from the cloud service to utilize those services or features that enable automation.

## Automation

Cloud automation offers significant advantages for security and health monitoring. Speed, flexibility, and precision are three archetypes that cloud automation brings to responsive operations. Often this is called orchestration, and the Microsoft cloud offers several services.

For example:

1. An identity-driven threat is detected from one or more logs, raising an alert.
2. Automation is immediately triggered to gather more information and correlate more logs to enrich the alert.
3. An operator takes action by selecting the right automation from a library, such as disabling a user account.

The example or use case can be fully automated.

The role of automation then provides a sort of _playbook_ that reduces costs and saves time:

- No security incident was needed to follow through a lengthy investigation, diagnosis, resolution, and recovery.
- The detection-to-correction cycle could be in seconds or minutes versus hours.

Next, your team needs to build a list or library of automation examples that can be flexibly used - either from raw material on public websites or internally curated and stored in a source control repository.

Here's a list of suggested reading for more automation based on identity- or security events:

- [Automatically create incidents from Microsoft security alerts](/azure/sentinel/create-incidents-from-alerts) with Microsoft Sentinel.
- [Security Orchestration, Automation, and Response (SOAR) in Microsoft Sentinel](/azure/sentinel/automation)

### Informational alerts

Under certain circumstances, some alerts can be _informational_. We can use this to learn about how our systems behave. For example, you might want to get these informational alerts:

- **A VM was shut down**: A VM was automatically shut down to _minimize waste and control costs_ based on a schedule or low utilization detected.

  In this example, the orchestration was used based on a native scheduling feature and by the monitoring platform detecting the utilization condition. Instead of the alert notifying or escalating as the only action, it informs you of the action performed and why.

- **Idle resources**: IaaS or PaaS resources are idle for an extended period or not provisioned based on Azure Advisor recommendations.

  In this example, orchestration can be used to manage those infrastructure-related activities based on business logic or ITSM process workflow. Much faster responses and actions are needed today. With the cloud, _alerting_ is less for humans than for an automated response or an ongoing orchestration as part of an automated value stream.

Keep in mind that learning is key, and when designed right, informational alerts can give you many insights into your cloud ecosystem and health.

## Successful alerting strategy

_You can't fix what you don't know is broken._

Alerting on what matters is critical. It's underpinned by collecting and measuring the right metrics and logs. You also need a monitoring tool capable of storing, aggregating, visualizing, analyzing, and initiating an automated response when conditions are met. You can improve the observability of your services and applications only if you fully understand their composition. You map that composition into a detailed monitoring configuration to be applied by the monitoring platform. This configuration includes the predictable failure states (the symptoms, not the cause of the failure) that make sense to alert for.

Consider the following principles for determining whether a symptom is an appropriate candidate for alerting:

- **Actionable:** Does the issue matter? Does it reflect a real problem in your application's health? For example, you might want to send an alert when CPU utilization is too high over a sustained period for a resource or a SQL query is consistently causing performance issues, but you might not want to send an alert when the CPU spikes over a short period. Make things actionable to reduce false positives and avoid alert fatigue.

- **Urgency:** Does the issue need urgent attention? If so, the responsible team should be immediately notified.

- **Customer impact:** Are users of the service or application affected by the issue?

- **Impact on dependent systems:** Are there alerts from interrelated dependencies that can be correlated to avoid notifying different teams all working on the same problem?

With these initial considerations, you can start developing your monitoring configuration. You can test and validate the assumptions across environments. For example, continuously evaluate these considerations and questions in nonproduction as well as production environments. Continuous improvement is key to successful response on monitoring signals.

When continuously evaluating what's working, consider asking yourself these questions to help drive awareness of your monitoring response effectiveness:

- **Alert volume:** Do you get a high alert volume? Are there many non-actionable alerts that could've been avoided?
- **Unnoticed issues:** Do you get reports or tickets from users experiencing issues that were not caught by the monitoring configuration?
- **False positives:** Do you get alerts or signals that were incorrectly flagged?
- **Alert or event:** Do you really need to send an alert, or could some of the raised alerts just be events flagged in the system? If the signals show up when you query for it, as opposed to sending an alert, would that suffice to avoid alert fatigue and non-actionable notifications?

See the [monitoring platforms overview](./platform-overview.md) in this article series for a deeper understanding of the  capabilities across the Microsoft monitoring solutions.

## Next steps

> [!div class="nextstepaction"]
> [Skills readiness for cloud monitoring](./suggested-skills.md)
