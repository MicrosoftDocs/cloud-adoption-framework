---
title: Inventory and visibility in Azure cloud management
description: Learn about what to manage (inventory) and how those managed workloads and assets change over time (visibility).
author: martinekuan
ms.author: martinek
ms.date: 10/17/2019
ms.topic: conceptual
ms.custom: internal
---

# Inventory and visibility in cloud management

Operational management has a clear dependency on data. Consistent management requires an understanding about what is managed (inventory) and how those managed workloads and assets change over time (visibility). Clear insights about inventory and visibility help empower the team to manage the environment effectively. All other operational management activities and processes build on these two areas.

A few classic phrases about the importance of measurements set the tone for this article:

- Manage what matters.
- You can only manage what you can measure.
- If you can't measure it, it might not matter.

The inventory and visibility discipline builds on these timeless phrases. Before you can effectively establish operational management processes, it's important to gather data and create the right level of visibility for the right teams.

## Common customer challenges

Unless inventory and visibility processes are consistently applied, operational management teams can suffer from a higher volume of business interruptions, longer time to recovery, and greater amounts of effort required to troubleshoot and triage issues. As changes adversely affect higher priority applications and larger numbers of assets, these metrics grow even faster.

These challenges stem from a few questions that can be answered only through consistent data and telemetry readings:

- How does the current-state performance deviate from standard operational performance telemetry?
- What assets are causing the business interruptions at the workload level?
- Which assets must be remediated to return to acceptable performance of this workload or business process?
- When did the deviation start? What was the trigger?
- Which changes have been made to the underlying assets? By whom?
- Were the changes intentional? Malicious?
- How did changes affect performance telemetry?

It's difficult, if not impossible, to answer these questions without a rich, centralized source for logs and telemetry data. To enable cloud management by ensuring the consistent configuration that's required to centralize the data, the baseline service must first start by defining the processes. Well-defined processes capture how a consistent configuration enforces data collection to support the components of inventory and visibility that are listed in the next section.

## Components of inventory and visibility

Creating visibility on any cloud platform requires a few key components:

- Responsibility and visibility
- Inventory
- Central logging
- Change tracking
- Performance telemetry

### Responsibility and visibility

When you establish commitments for each workload, [management responsibility](./commitment.md#choose-a-responsibility-model) is a key factor. Delegated responsibility creates a need for delegated visibility. The first step toward inventory and visibility is to ensure that the responsible parties have access to the right data. Before you implement any cloud-native tools for visibility, ensure that each monitoring tool has the proper access and scope for each operations team.

### Inventory

If no one knows that an asset exists, it's difficult to manage the asset. Before an asset or workload can be managed, it must be inventoried and classified. The first technical step toward stable operations is a validation of inventory and classification of inventory.

### Central logging

Centralized logging is critical to the visibility that's required day to day by the operations management teams. We recommend that all assets that are deployed to the cloud record logs to a central location. In Azure, the central location is Log Analytics. Central logging drives reports about change management, service health, configuration, and most other aspects of IT operations.

Enforcing the consistent use of central logging is the first step toward establishing repeatable operations. Enforcement can be accomplished through corporate policy. When possible, however, you should automate enforcement to ensure consistency.

### Change tracking

Change is the one constant in a technology environment. Awareness and understanding of changes across multiple workloads is essential to reliable operations. Your cloud management solution should include a means of understanding the 'when, how, and why' of technical change. Without those data points, remediation efforts are hindered.

### Performance telemetry

Data drives business commitments about cloud management. To properly maintain commitments, the cloud operations team must understand the telemetry about the stability, performance, and operations of the workload. The cloud operations team must also understand the assets that support the workload.

The ongoing health and operations of the network, DNS, operating systems, and other foundational aspects of the environment are critical data points that factor into the overall health of any workload.

<!-- docutune:ignore "cloud management methodology" "service management integration" -->

## Processes

Compared to the features of the cloud management platform, the cloud management processes might be more important in your considerations, as they realize operations commitments with the business. Your cloud management methodology should include, at a minimum, the following processes:

- **Reactive monitoring:** Who addresses the deviations that adversely affect business operations? What actions do they take to remediate the deviations?
- **Proactive monitoring:** When deviations are detected but business operations aren't affected, how are those deviations addressed, and by whom?
- **Commitment reporting:** How is adherence to the business commitment communicated to business stakeholders?
- **Budgetary reviews:** What is the process for reviewing those commitments against budgeted costs? What is the process for adjusting the deployed solution or the commitments to create alignment?
- **Escalation paths:** What escalation paths are available when any of the preceding processes fail to meet the needs of the business?

There are several more processes related to inventory and visibility. The preceding list is designed to provoke thought within the operations team. Answering the list of questions helps to develop some of the necessary processes and might likely trigger new, deeper questions.

## Responsibilities

When you're developing processes for operational monitoring, it's equally important to determine responsibilities for daily operation and regular support of each process.

- In a centralized IT organization, IT provides the operational expertise. The business is consultative in nature when issues require remediation.

- In a cloud center of excellence organization, business operations provide the expertise and hold responsibility for management of these processes. IT focuses on the automation and support of teams, as they operate the environment.

The preceding list items are examples of common responsibilities. Organizations often require a mixture of responsibilities to meet business commitments.

## Act on inventory and visibility

Regardless of the cloud platform, the five components of inventory and visibility are used to drive most operational processes. All subsequent disciplines build on the data that's being captured. The next articles in this series outline ways to act on that data and integrate other data sources.

### Share visibility

Data without action produces little return. Cloud management might expand beyond cloud-native tools and processes. To accommodate broader processes, a cloud management baseline might need to be enhanced to include reporting, IT service management integration, or data centralization. Cloud management might need to include one or more of the following principles during various phases of operational maturity.

### Report

Offline processes and communication about commitments to business stakeholders often require reporting. Self-service reporting or periodic reporting might be a necessary component of an enhanced management baseline.

### IT service management (ITSM) integration

ITSM integration is often the first example of acting on inventory and visibility. When deviations from expected performance patterns arise, ITSM integration uses alerts from the cloud platform to trigger tickets in a separate ITSM tool to trigger remediation activities. Some operating models might require ITSM integration as an aspect of the enhanced management baseline.

### Data centralization

There's various reasons why a business might require multiple tenants within a single cloud provider. In those scenarios, data centralization is a required component of the enhanced management baseline, because it can provide visibility across those tenants or environments.

## Next steps

Operational compliance builds on inventory capabilities by applying management automation and controls. See how [operational compliance](./operational-compliance.md) maps to your processes.

> [!div class="nextstepaction"]
> [Plan for operational compliance](./operational-compliance.md)
