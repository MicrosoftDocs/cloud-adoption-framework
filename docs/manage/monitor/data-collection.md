---
title: Collect monitoring data in the cloud
description: Learn to observe the health and availability of your cloud solution to collect the right monitoring data.
author: Zimmergren
ms.author: tozimmergren
ms.reviewer: tozimmergren
ms.date: 06/20/2023
ms.topic: conceptual
s.custom: think-tank, engagement-fy23, UpdateFrequency2
products: azure-monitor
---

# Collect the right monitoring data

Observing the health and availability of your cloud solution helps build an understanding of the signals you expect in your systems so you can determine what data you should collect.

This article is part of a series in [the cloud monitoring guide](./index.md).

## Data collection considerations

Ask yourself these questions to establish criteria for a monitoring configuration:

- **Service composition**: What's the composition of the services? Are those dependencies monitored today? If so, are multiple tools involved, and is there an opportunity to consolidate without introducing additional risk?

- **Define predictable failure states**: These signals are the symptoms of the _failure_, not the cause. The monitoring tools use metrics and logs for advanced diagnostics and root cause analysis.

- **Service SLA**: What's the Service Level Agreement (SLA) of the service, and how will you measure and report it?

- **Service dashboard design**: What should the service dashboard look like when reviewing incidents? What should the dashboard look like for the service owner and the team supporting the service?

- **Resource metrics**: What resource metrics are produced by the solution you need to monitor?

- **Log search**: How will the service owner, support teams, and other personnel search the logs?

- **Stakeholder involvement**: Include the monitoring service owner, manager of IT operations, and other stakeholders during the planning phase. Continue to engage them throughout your monitoring solutions' development and release cycles.

How you answer those questions, and the criteria for alerting, determines how you'll use the monitoring platform.

### Evaluate required monitoring signals

Whether you're deploying new workloads with a new monitoring solution, or migrating from an existing monitoring platform or a set of monitoring tools, evaluating the required monitoring signals is essential. Carefully designing the required signals help drive the expected outcomes and reduces noise.

Consider the following:

- **Actionable**: Remember, monitoring data needs to be actionable to reduce noise and false positives.
- **Optimized**: Optimize the data collected to give you a holistic view of the overall health of the service.
- **Incident instrumentation**: The instrumentation that's defined to identify actual incidents should be as simple, predictable, and reliable as possible.

## Develop a monitoring configuration

Typically, the owner of a monitoring service and their team adhere to a standard set of activities to create a monitoring configuration. These activities encompass the planning stages, testing and validating in a nonproduction environment, and deploying into production.

To develop monitoring configurations, the team draws upon known failure modes, test results from simulated failures, and the experience of various individuals within the organization, such as the service desk, operations personnel, engineers, and developers.

These configurations are designed under the assumption that the service already exists, is undergoing migration to the cloud, and hasn't been restructured.
To ensure that service-level quality results are achieved, monitoring the health and availability of these services early in the development process is essential. If monitoring the service or application's design is only considered an afterthought, the results are likely to be less successful.

To drive quicker resolution of the incident, consider the following recommendations:

- **Individual component dashboards**: Define a dashboard for each service component to help quickly identify any known issues in any given area of your applications and infrastructure.

- **Use metrics**: Utilize the metrics signals that are built into the various components to help diagnose and identify resolutions or workarounds if you can't identify a root cause.

- **Enable dashboard customizations**: Design your dashboards so you can easily drill down into the data from the monitoring dashboards. Make sure you support customizing the views dynamically, allowing for easy filtering and troubleshooting.

Embracing this guiding set of principles can help give you near-real-time insights and better management of your service.

## Next steps

> [!div class="nextstepaction"]
> [Response strategy](./response.md)
