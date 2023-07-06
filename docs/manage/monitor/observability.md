---
title: Observability in cloud monitoring
description: Gain an understanding of how observability helps drive maturity in monitoring and help you understand the behavior of your services running in the cloud.
author: Zimmergren
ms.author: tozimmergren
ms.date: 06/20/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
products: azure-monitor
ms.custom: UpdateFrequency2
---

# Observability in cloud monitoring

This article is part of a series in [the cloud monitoring guide](./index.md).

The sections below aim to drive operational maturity by being observant and constantly iterating to improve how you monitor your services. Learn how organizations implement a consistent monitoring strategy quicker by establishing _observability_ for each monitoring solution.

## Defining observability

While observability and monitoring complement each other, there's a notable distinction:

- **Monitoring**: Collects information and informs you that it detected an issue based on you configuring it to monitor for those conditions. You're monitoring for known or predictable failures.
- **Observability**: The ability to understand what's happening inside a system by looking at the output data. An _observability solution_ helps you analyze this data to assess the system's health and find ways to fix problems in your IT infrastructure.

Observability first drives the monitoring consumer to understand what is considered a service's _normal_ operation. In other words, you seek _total visibility_ as soon as possible.

Once you achieve initial observability, you build upon that initial level of visibility to develop actionable alerts, create useful dashboards, and evaluate [AIOps solutions](/azure/azure-monitor/logs/aiops-machine-learning). These insights let you get comfortable with the underlying metric and log monitoring data.

> [!NOTE]
> This is the opposite of the approach used in the past when teams worked to define all of the monitoring requirements first on paper before building, testing, and deploying.

Whether your monitoring plan targets an application, the cloud infrastructure, or the Azure Platform, the first step is to _establish observability_.

This approach also simplifies your plans. In all cases, total visibility means achieving and sustaining sufficient visibility across three dimensions or aspects:

1. **Monitor in-depth**: Collect meaningful and relevant signals.
1. **Monitor end-to-end or breadth**: From the lowest layer of the stack up to the application.
1. **Monitor across the health model**: Focus on health aspects, such as availability, performance, security, and continuity.

![Three-sided cube example](../../strategy/media/monitoring-strategy/three-sided-cube.png)

Observability is more than just a focus for your IT teams. An essential goal is to ensure end users can use the systems and that your [Service Level Objectives](./service-level-objectives.md) (SLO) are met.

## Monitoring solutions and observability

Infrastructure and application monitoring can be complicated. Business transformation applies technology to achieve and help shape its strategies. The cloud has further influenced the complicated nature of monitoring.

This is demonstrated in the following ways:

- **Digital transformation shift**: Businesses' digital transformation efforts shift toward hyper-exploitation of cloud technology.
- **Built-in monitoring**: Monitoring becomes embedded into Azure resources and resource groups versus separate tooling you manage on-premises.
- **Expansive monitoring** Cloud-native architectures such as Azure Monitor are similar to security incident and event management (SIEM) tools. Azure Monitor is expansive, log-driven, and orders of magnitude more flexible than traditional on-premises tooling.

_Architects_ must, like _operators_, understand what diagnostic information an infrastructure component or application emits.

Combining multivariate, dynamic, time-series, eventful, stateful, and telemetric log streams into valuable intelligence depends on the following:

- **Team knowledge**: The knowledge and experience of the developer or system engineer who deeply understands the monitoring target.
- **Troubleshooting experience**: Support and troubleshooting experience in using data to find or locate the causes of trouble.
- **Learning from history**: Review past incidents to find non-technology reasons that can be auto-remediated later.
- **Documentation**: Guidance in documentation, software, training, or consulting by the software or hardware vendor.

Microsoft and its partners provide management packs for System Center Operations Manager. Management packs are technology-specific; for example, if you import a SQL management pack, Operations Manager automatically discovers and targets servers hosting SQL Server and begins monitoring them. Here, _observability is more or less predefined_. Operations Manager is primarily designed for on-premises infrastructure, which tends to be **fixed** in components and architectural design patterns relative to cloud services.

In the cloud, you have enormous **flexibility** in the types of services to choose from. Monitoring includes how services change over time, and can be dynamic, global, and resilient. With Azure Monitor, you can take advantage of existing workbooks included in [Azure Monitor Insights](/azure/azure-monitor/insights/insights-overview) providing functionality similar to a management pack in Operations Manager.

## The art of being observant

Observability relies on what and how something is being monitored.

In Azure, there are multiple monitoring data sources, each delivering a different perspective of how something behaves. Azure includes numerous tools to help analyze the various aspects of this data.

### Observe the platform

In Azure, Microsoft provides the perspective of the _service provider_ through different _platform logs_.

Services in Azure can change in different, unpredictable ways over time. We refer to this behavior as dynamic. Managers of cloud services observing the service over time also need to take into account the following:

- **Resource relocation**: Resources can migrate or move across locations or geography.
- **Resource changes**: Resources are added, deleted, or modified.
- **Consumption**: Consumption varies for different services and implementations. Be mindful to monitor the cost, consumption, and the projected spend.

Here are a few examples of tools that enable your platform observability:

|Log source|Description|
|---|---|
|[Service health](/azure/service-health/service-health-portal-update)|Service incidents and planned maintenance reported by Microsoft.|
|[Azure Resource Health](/azure/service-health/resource-health-overview)|Reports on your resources' current and past health.|
|[Azure Monitor activity log](/azure/azure-monitor/essentials/activity-log)|Reports subscription-level events across all the resources deployed in the subscription.|
|[Azure Monitor Change Analysis](/azure/azure-monitor/change/change-analysis)|Reports on changes to your Azure applications and reduces mean time to repair (MTTR).|
|[Azure resource logs](/azure/azure-monitor/essentials/resource-logs)|Previously known as _diagnostic logs_, resource logs reports on operations performed within an Azure resource, on the data plane.|
|[Azure Active Directory reports (AzureAD) logs](/azure/azure-monitor/essentials/platform-logs-overview)|Reports on the history of sign-in activity and the audit trail of changes in Azure AD for a given tenant.|
|[Azure Advisor](/azure/advisor/advisor-overview)|Use Azure Advisor to receive recommended solutions based on best practices to optimize your Azure deployments.|

Observability evolves gradually, starting with a minimally viable monitoring plan, and the effort to integrate tools and processes is underway. As you get comfortable with the data (metrics, logs, and transactions), you can understand the behavior and signs of symptoms or issues from those resources or applications. By getting familiar with the data, you build trust in working with Azure Monitor and the data.

### Gaining confidence from observability

With proper observability, you gain confidence, and you're able to realize the cause and find answers that can help. The more you learn about your data, the more evolved your processes becomes and your teams gain insights.

To set the scene, here are a few ways to gain confidence from  observability:

- **Increase predictability**: Improved monitoring of resources and services helps identify issues proactively, making them predictable and manageable in the future.

- **Early detection of anomalies**: Observability allows for the timely detection of abnormalities or deviations from expected behavior, reducing the impact of potential issues.

- **Root cause identification**: Detailed observability data helps identify the root causes of problems, enabling faster resolution and preventing recurrence.

- **Enhance troubleshooting efficiency**: With observability, teams can quickly diagnose and troubleshoot complex issues by analyzing relevant data and correlating events.

- **Improve system reliability**: By identifying bottlenecks, performance issues, and potential failure points, observability helps in optimizing system performance and enhancing overall reliability.

- **Improve customer experience**: Observability enables a better understanding of how system performance affects end-users, allowing for proactive measures to enhance customer satisfaction.

- **Facilitate collaboration**: Observability platforms provide shared visibility and data access, promoting cooperation between different teams, such as developers, operations, and support.

- **Regulatory compliance**: Observability aids in meeting regulatory requirements by providing traceability, audit logs, and ensuring adherence to security and privacy standards.

- **Faster time to resolution**: By providing rich data and insights, observability accelerates the time to diagnose and resolve issues, minimizing downtime and service disruptions.

- **Proactive capacity management**: Observability data helps predict resource demands, identify capacity gaps, and proactively adjust resources to maintain optimal performance.

- **Risk mitigation**: With observability, you can identify potential risks early, enabling proactive mitigation measures and reducing the likelihood of severe impacts.

- **Continuous monitoring and learning**: Observability allows for ongoing monitoring and learning, helping teams adapt to changing environments, requirements, and user behavior.

- **Performance optimization**: By analyzing observability data, teams can identify and optimize performance bottlenecks, enhancing system efficiency.

- **Prioritization of efforts**: Observability insights enable teams to prioritize tasks and allocate resources based on the criticality and impact of identified issues.

- **Confidence in change management**: Observability provides visibility into the impact of changes, ensuring that new deployments or updates don't introduce unforeseen issues.

- **Improved incident response**: With observability, incident response teams can quickly gather relevant information, understand the context, and initiate appropriate actions.

## Monitoring plan

You create a monitoring plan to describe the goals and objectives, requirements, and other essential details. Then work to solicit an agreement between all of the relevant stakeholders in the organization.

A monitoring plan should explain how to develop and operate one or more monitoring solutions. Begin creating your monitoring plans early during the strategy and planning phases of the project.

While creating the plan, it's essential to remember the five disciplines of modern monitoring, as outlined in the [cloud monitoring strategy documentation](/azure/cloud-adoption-framework/strategy/monitoring-strategy#consider-maturity): **monitor**, **measure**, **respond**, **learn**, and **improve**.

The following provides an initial recommended outline for a monitoring plan, and are considered to be the primary considerations for an individual plan for services or when standardizing cloud service features such as Azure resource types or Microsoft 365 services.

The essence of the plan is to define the line of visibility between service providers (who will field solutions) and consumers (who will operate or derive value).

### Business perspective

A comprehensive monitoring plan must consider what the business needs with and from monitoring, including a user-centric focus. While defining the plan, it's essential to document and share the business requirements, and the following _suggests the scope_ of this part of the plan.

- Stakeholders and consumers
- Business value streams and processes
- End-user perspective and utility
- Measurement and reporting requirements
- Identified risks and compliance control frameworks
- Access and control requirements
- Risk to the business

### Service perspective

A comprehensive monitoring plan must consider what the service owners need with and from monitoring. While defining the plan, it's essential to document and share their requirements, and the following _suggests the scope_ of this part of the plan.

- Stakeholders and consumers
- Roles and accountability
- Definition of the service
- Access and control requirements
- Architectural considerations?
- Supplier and partner underpinning contracts
- Service agreements (SLAs, OLAs)
- Identify service warranty coverage
- Measurement and reporting requirements
- Risks

### Technology perspective

This section of the plan represents the monitoring solution using information from the business and service perspective. The following _suggests the scope_ of this part of the plan.

- User stories and scenarios
- Technical targets (for example, networking)
- Component dependency mapping
- Types (for example, cloud-native, hybrid, on-premises)
- Observational
- Responsive
- Measurement
- Tuning and optimization

### Considerations

Summarize the plan to ensure it communicates and informs all relevant consumers, stakeholders, and management levels. For a successful monitoring plan, consider these points:

#### Key considerations

- **Production stages:** The monitoring solution should be ready when the service goes live. Planning can include test or preproduction configuration in another subscription dedicated to help experiment and test your assumptions.

- **Strategy:** Plans can also map back to monitoring and IT strategy to trace the monitoring objectives to the mission or business.

- **Targets:** In the plan, describe and analyze the target assets or services under consideration. If needed, map all the components to monitor, including service dependencies. Identify coverage gaps and determine who owns each part of the service.

- **Solution:** For the monitoring solution, identify the consumers, stakeholders, suppliers, partners, access, and instrumentation. Also, monitoring aspects, scope, response, reports, and dashboards (availability, security, user experience, and more).

#### General considerations

In addition to the key considerations, seek to better understand how these points might influence your monitoring plan for your organization.

- **Minimum viable product (MVP):** Let the plan define what success looks like for the minimum viable product. In other words, what is initially needed to go live, and can we measure success on this? After you're live, you continue to evolve the monitoring solution to maximize value.

- **Secure your monitoring data:** Security is a crucial aspect for every organization and team today. Make sure you're educated and know the guardrails, or let experts guide you so you don't add risk to your monitoring solutions, for example, by exposing sensitive monitoring data in logs.

- **Consider Microsoft 365:**  Any good plan considers your Azure tenant with Microsoft 365 as a significant component. Microsoft 365 depends on Azure AD, and Azure Monitor provides Microsoft 365 integration with endpoint management.

- **Observability wins:** Focus on total visibility before focusing on alerting, as alerting both is a cost, and can quickly lead to alert fatigue.

- **Activity monitoring:** Audit, sign-in, and activity logs are now easy for service owners and security to slice and dice. Make sure your monitoring plan considers the activity monitoring, including the insights and dashboards you need to create for any relevant stakeholders.

## Next steps

> [!div class="nextstepaction"]
> [Service Level Objectives](./service-level-objectives.md)
