---
title: Cloud monitoring and response
description: Gain an understanding of the response discipline in observability and recommended approaches to acting on significant events detected.
author: MGoedtel
ms.author: brblanch
ms.date: 11/11/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank
---

# Cloud monitoring guide: Response

In the [Observability](observability.md) we discussed the five disciplines of monitoring, and in this article we focus on the response discipline. Response is the result of defining one or more actions based on data-driven decisions by observing the monitoring data.  An alert triggering a notification or incident record used to be the primary outcome or action when your monitoring tool detected an issue or change that could potentially cause a system outages or significant incident. Escalating an alert isn’t important to observability, and today it shouldn’t be considered the first line of defense.

As part of monitoring, alerting was an action resulting from a detected condition, such as a node in the cluster is down, a database for an application is full, or an application process is consuming too many CPU cycles for an indefinite period. Based on defined escalation paths and the severity/impact of the condition, the alert would create an incident record in an ITSM system or send an e-mail notification to the operations or engineering team depending on your escalation path. We consider this approach outdated and not in alignment with modern service management or cloud operations recommended practices.

There are other responsive actions that can be used instead of following this traditional path. Under certain circumstances, some alerts can be informational to inform you that:

* A VM was automatically shutdown to minimize waste and control costs based on a schedule or low utilization detected.
* IaaS or PaaS resources are idle for a long period of time or not provisioned based on Azure Advisor recommendations.

In the first example, orchestration was used as a result of detecting the condition and then informing you that the action was performed and why. In the second example, orchestration can be used, based on business logic or ITSM process workflow, to manage those infrastructure-related activities. 

Orchestration should be the next step depending on the situation. Because many cloud resources at the infrastructure, platform, and software-layers are managed by the cloud provider and can’t be controlled by the customer, you are dependent on the cloud provider.

## Successful alerting strategy

*You can't fix what you don't know is broken.*

Alerting on what matters is critical. It's underpinned by collecting and measuring the right metrics and logs. You also need a monitoring tool capable of storing, aggregating, visualizing, analyzing, and initiating an automated response when conditions are met. You can improve the observability of your services and applications only if you fully understand its composition. You map that composition into a detailed monitoring configuration to be applied by the monitoring platform. This configuration includes the predictable failure states (the symptoms, not the cause of the failure) that make sense to alert for.

Consider the following principles for determining whether a symptom is an appropriate candidate for alerting:

- **Does it matter?** Is the issue symptomatic of a real problem or issue influencing the overall health of the application? For example, do you care whether the CPU utilization is high on the resource? Or that a particular SQL query running on a SQL database instance on that resource is consuming high CPU utilization over a sustained period? Because the CPU utilization condition is a real issue, you should alert on it. But you don't need to notify the team, because it doesn't help point to what is causing the condition in the first place. Alerting and notifying on the SQL query process utilization issue is both relevant and actionable.
- **Is it urgent?** Is the issue real, and does it need urgent attention? If so, the responsible team should be immediately notified.
- **Are your customers affected?** Are users of the service or application affected as a result of the issue?
- **Are other dependent systems affected?** Are there alerts from dependencies that are interrelated, and that can possibly be correlated to avoid notifying different teams all working on the same problem?

Ask these questions when you're initially developing a monitoring configuration. Test and validate the assumptions in a nonproduction environment, and then deploy into production. Monitoring configurations are derived from known failure modes, test results of simulated failures, and experience from different members of the team.

After the release of your monitoring configuration, you can learn a lot about what's working and what's not. Consider high alert volume, issues unnoticed by monitoring but noticed by end users, and what were the best actions to have taken as part of this evaluation. Identify changes to implement to improve service delivery, as part of an ongoing, continuous monitoring improvement process. It's not just about evaluating alert noise or missed alerts, but also the effectiveness of how you're monitoring the workload. It's about the effectiveness of your alert policies, process, and overall culture to determine whether you're improving.

Both System Center Operations Manager and Azure Monitor support alerts based on static or even dynamic thresholds and actions set up on top of them. Examples include alerts for email, SMS, and voice calls for simple notifications. Both of these services also support IT service management (ITSM) integration, to automate the creation of incident records and escalate to the correct support team, or any other alert management system that uses a webhook.

When possible, you can use any of several services to automate recovery actions. These include System Center Orchestrator, Azure Automation, Azure Logic Apps, or autoscaling in the case of elastic workloads. While notifying the responsible teams is the most common action for alerting, automating corrective actions might also be appropriate. This automation can help streamline the entire incident management process. Automating these recovery tasks can also reduce the risk of human error.


