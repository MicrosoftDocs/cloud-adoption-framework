---
title: Collect monitoring data in the cloud
description: Learn to observe the health and availability of your cloud solution to collect the right monitoring data.
author: Zimmergren
ms.author: tozimmergren
ms.reviewer: tozimmergren
ms.date: 04/12/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, engagement-fy23, UpdateFrequency2
products: azure-monitor
---

# Collect the right monitoring data

This article is part of a series in [the cloud monitoring guide](./index.md).

## Create a monitoring plan

Observing the health and availability of your cloud solution helps build an understanding of the signals you expect in your systems.

### Monitoring plan considerations

Ask yourself these questions to establish criteria for a monitoring configuration:

- **Service composition**: What's the composition of the services? Are those dependencies monitored today? If so, are there multiple tools involved, and is there an opportunity to consolidate without introduce additional risk?

- **Define predictable failure states**: These signals are the symptoms of the _failure_, not the cause. The monitoring tools use metrics and logs for advanced diagnostics and root cause analysis.

- **Service SLA**: What's the Service Level Agreement (SLA) of the service, and how will you measure and report it?

- **Service dashboard design**: What should the service dashboard look like when an incident is raised? What should the dashboard look like for the service owner, and for the team supporting the service?

- **Resource metrics**: What resource metrics are produced by the solution that you need to monitor?

- **Log search**: How will the service owner, support teams, and other personnel search the logs?

- **Stakeholder involvement**: Include the monitoring service owner, manager of IT operations, and other stakeholders during the planning phase. Continue to engage them throughout the development and release cycles of your monitoring solutions.

How you answer those questions, and the criteria for alerting, determines how you'll use the monitoring platform.

### Evaluate required monitoring signals

Whether you're deploying new workloads with a new monitoring solution, or migrating from an existing monitoring platform or a set of monitoring tools, evaluating the required monitoring signals is essential. Carefully designing the required signals help drive the expected outcomes and reduce the noise.

Consider the following:

- **Actionable**: Remember, monitoring data needs to be actionable to reduce noise and false positives.
- **Optimized**: Optimize the data collected to give you a holistic view of the overall health of the service.
- **Incident instrumentation**: The instrumentation that's defined to identify actual incidents should be as simple, predictable, and reliable as possible.

In this article, you will learn about considerations for collecting monitoring data in a cloud application.

## Develop a monitoring configuration

The monitoring service owner and the team typically follow a standard set of activities to develop a monitoring configuration. These activities start at the initial planning stages, continue through testing and validating in a nonproduction environment, and extend to deploying into production. Monitoring configurations are derived from known failure modes, test results of simulated failures, and the experience of several people in the organization (the service desk, operations, engineers, and developers). Such configurations assume that the service already exists, is being migrated to the cloud, and hasn't been rearchitected.

For service-level quality results, monitor the health and availability of these services early in the development process. If you monitor the design of that service or application as an afterthought, your results will be less successful.

To drive quicker resolution of the incident, consider the following recommendations:

- Define a dashboard for each service component.
- Use metrics to help guide further diagnosis and identify a resolution or workaround if you can't discover a root cause.
- Use dashboard drill-down capabilities, or support customizing the view to refine it.
- If you need verbose logs, metrics should have helped target the search criteria. If the metrics didn't help, improve them for the following incident.

Embracing this guiding set of principles can help give you near-real-time insights and better management of your service.

## Next steps

> [!div class="nextstepaction"]
> [Response strategy](./response.md)
