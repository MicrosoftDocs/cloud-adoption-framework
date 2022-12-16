---
title: Collect monitoring data in the cloud
description: Learn to observe the health and availability of your cloud solution to collect the right monitoring data.
author: MGoedtel
ms.author: martinek
ms.reviewer: tozimmergren
ms.date: 11/15/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, engagement-fy23
---

# Cloud monitoring guide: Collect the right data

This article describes some considerations for collecting monitoring data in a cloud application.

To observe the health and availability of your cloud solution, you must configure the monitoring tools to collect a level of signals based on predictable failure states. These signals are the symptoms of the failure, not the cause. The monitoring tools use metrics and logs for advanced diagnostics and root cause analysis.

Plan for monitoring and migration carefully. Start by including the monitoring service owner, manager of operations, and other related personnel during the planning phase, and continue engaging them throughout the development and release cycle. Their focus will be to develop a monitoring configuration on the following criteria:

- What is the composition of the service? Are those dependencies monitored today? If so, are there multiple tools involved? Is there an opportunity to consolidate without introducing risks?
- What is the SLA of the service, and how will I measure and report it?
- What should the service dashboard look like when an incident is raised? What should the dashboard look like for the service owner and the team supporting the service?
- What metrics does the resource produce that I need to monitor?
- How will the service owner, support teams, and other personnel search the logs?

How you answer those questions, and the criteria for alerting, determines how you'll use the monitoring platform. If you're migrating from an existing monitoring platform or set of monitoring tools, use the migration to reevaluate the signals you collect. This is especially true now that there are several cost factors to consider when you migrate or integrate with a cloud-based monitoring platform like [Azure Monitor](/azure/azure-monitor/overview). Remember, monitoring data needs to be actionable. You need to have optimized data collected to give you "a 10,000-foot view" of the overall health of the service. The instrumentation that's defined to identify actual incidents should be as simple, predictable, and reliable as possible.

## Develop a monitoring configuration

The monitoring service owner and the team typically follow a standard set of activities to develop a monitoring configuration. These activities start at the initial planning stages, continue through testing and validating in a nonproduction environment, and extend to deploying into production. Monitoring configurations are derived from known failure modes, test results of simulated failures, and the experience of several people in the organization (the service desk, operations, engineers, and developers). Such configurations assume that the service already exists, is being migrated to the cloud, and hasn't been rearchitected.

For service-level quality results, monitor the health and availability of these services early in the development process. If you monitor the design of that service or application as an afterthought, your results will be less successful.

To drive quicker resolution of the incident, consider the following recommendations:

- Define a dashboard for each service component.
- Use metrics to help guide further diagnosis and to identify a resolution or workaround of the issue if a root cause can't be uncovered.
- Use dashboard drill-down capabilities, or support customizing the view to refine it.
- If you need verbose logs, metrics should have helped target the search criteria. If the metrics didn't help, improve them for the following incident.

Embracing this guiding set of principles can help give you near-real-time insights and better management of your service.

## Next steps

> [!div class="nextstepaction"]
> [Response strategy](./response.md)
