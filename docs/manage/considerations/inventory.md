---
title: "Inventory and visibility - Cloud Management and Operations"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Inventory and visibility - Cloud Management and Operations
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Inventory and visibility in cloud management

Operational management has a clear dependency on data. Consistent management requires a clear understanding of what is managed (inventory) and how those managed workloads and assets change over time (visibility). Together clarity on inventory and visibility empowers the team to manage the environment effectively. All other operational management activities and processes build on these two areas of insights.

A few classic phrases on the important of measurements sets the tone for this article: Manage what matters. You can only manage what you can measure. If you can't measure it, it might not matter. The inventory and visibility discipline builds on these timeless phrases. Before establishing operational management processes, it's important to gather data and create the right level of visibility for the right teams.

## Common customer challenges

When inventory and visibility processes are not consistently applied, operational management teams suffer from a higher volume of business interruptions, longer time to recovery, and greater amounts of effort required to troubleshoot and triage issues. As changes impact higher priority applications and larger numbers of assets, each of these metrics grows even faster.

These challenges stem from a small number of questions that can only be answered through consistent data/telemetry:

- How does the current-state performance deviate from standard operational performance telemetry?
- What assets are causing the business interruptions at the workload level?
- Which assets must be remediated to return to acceptable performance of this workload/business process?
- When did the deviation start? What was the trigger?
- Which changes have been made to the underlying assets? By who?
- Were the changes intentional? Malicious?
- How did changes impact performance telemetry?

It is difficult, if not impossible to answer these questions without a rich, centralized source for logs and telemetry data. To enable cloud management, the baseline service must first start with definition of the processes to ensure consistent configuration required to centralize the data. Those processes should capture how configuration will enforce collection of data to support the components of inventory and visibility in the next section.

## Components of inventory and visibility

Creating visibility on any cloud platform requires a few key components:

1. Responsibility and visibility
2. Inventory
3. Central logging
4. Change tracking
5. Performance telemetry

### Responsibility and visibility

When establishing commitments for each workload, [management responsibility](./commitment.md#management-responsibility) is a key factor. Delegated responsibility creates a need for delegated visibility. The first step toward inventory and visibility is to ensure the responsible parties have access to the right data. Before implementing any cloud-native tools for visibility, ensure that each monitoring tool has been configured with proper access and scope for each operations team.

### Inventory

If no one knows that an asset exists, it's very difficult for the asset to be managed. Before an asset or workload can be managed, it must be inventoried and classified. The first technical step toward stable operations is a validation of inventory and classification of that inventory.

### Central logging

Centralized logging is critical to visibility required by day to day operations management teams. All assets deployed to the cloud should record logs to a central location. In Azure, that central location is log analytics. The centralization of logging drives reports regarding change management, service health, configuration, and most other aspects of IT operations.

Enforcing consistent use of central logging is the first step toward consistent repeatable operations. Enforcement can be accomplished through corporate policy. However, when possible enforcement should be automated to ensure consistency.

### Change tracking

Change is the one constant in a technology environment. Awareness and understanding of changes across multiple workloads is essential to reliable operations. Any cloud management solution should include a means of understanding the when, how, and why of technical change. Without those data points, remediation efforts are significantly hindered.

### Performance telemetry

Business commitments regarding cloud management are driven by data. To properly maintain commitments, the cloud operations team must first understand the telemetry regarding the stability, performance, and operations of the workload, and the assets which support the workload.

Ongoing health and operations of the network, DNS, operating systems, and other foundational aspects of the environment are critical data points that factor into the overall health of any workload.

## Processes

Perhaps more important than the features of the cloud management platform, cloud management processes will realize operations commitments with the business. Any cloud management methodology should include the following processes at minimum:

- Reactive monitoring: When deviations impact business operations, who addresses those deviations? What actions do they take to remediate the deviations.
- Proactive monitoring: When deviations are detected but business operations are not affected, how are those deviations addressed and by whom?
- Commitment reporting: How is adherence to the business committed communicated with business stakeholders?
- Budgetary reviews: What is the process for reviewing those commitments against budgeted costs? What is the process for adjusting the deployed solution or the commitments to create alignment?
- Escalation paths: What escalation paths are available when any of the above processes don't meet the needs of the business?

There a several more processes related to inventory and visibility. The list above is designed to provoke thought among the operations team. Answering these questions will develop some of the necessary processes. It will likely trigger new deeper questions as well.

## Responsibilities

When developing processes for operational monitoring, it is equally important to determine responsibilities for daily operation and regular support of each process.

In a central IT organization, IT would provide the operational expertise. The business would be consultative in nature, when remediating issues.
In a cloud center of excellence organization, business operations would provide the expertise and hold responsibility for management of these processes. IT would focus on the automation and support of teams, as they operate the environment.

But, these are the common responsibilities. Organizations often require a mixture of responsibilities to meet business commitments.

## Acting on inventory and visibility

Regardless of the cloud platform, the five components of inventory and visibility are used to drive most operational processes. All subsequent disciplines will build on the data being capture. The following articles in this series will outlines ways to act on that data and integrate other data sources.

### Sharing visibility

Data without action produces little return. Cloud management may expand beyond cloud-native tools and processes. To accommodate broader processes, a cloud management baseline may need to be enhanced to include reporting, IT Service Management integration, or data centralization. Cloud management may need to include one or more of the following during various phases of operational maturity.

### Reporting

Offline processes and communication about commitments to business stakeholders often require reporting. Self-service reporting or periodic reporting may be a necessary component of an enhanced management baseline.

### IT Service Management (ITSM) Integration

ITSM integration is often the first example of acting on inventory and visibility. When deviations from expected performance patterns arise, ITSM integration will use alerts from the cloud platform to trigger tickets in a separate service management tool to trigger remediation activities. Some operating models may require ITSM integration as an aspect of the enhanced management baseline.

### Data centralization

There are a variety of reasons why a business may require multiple tenants within a single cloud provider. In those scenarios, data centralization is a required component of the enhanced management baseline to provide visibility across each of those tenants or environments.

## Next steps

Operational compliance builds on inventory capabilities by applying management automation and controls. See how [operational compliance](./operational-compliance.md) maps to your processes.

> [!div class="nextstepaction"]
> [Plan for operational compliance](./operational-compliance.md)
