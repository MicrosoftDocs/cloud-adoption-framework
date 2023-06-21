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

Learn how organizations implement a consistent monitoring strategy quicker by establishing _observability_ for each monitoring solution.

While observability and monitoring complement each other, there is a notable distinction:

- **Monitoring**: Collects information and informs you that it detected an issue based on you configuring it to monitor for those conditions. You're monitoring for known or predictable failures.
- **Observability**: The ability to understand what's happening inside a system by looking at the output data. An _observability solution_ helps you analyze this data to assess the system's health and find ways to fix problems in your IT infrastructure.

The sections below aim to drive operational maturity by being observant and constantly iterating to improve how you monitor your services.

## Why observability is important

Observability first drives the monitoring consumer to understand what is considered a service's _normal_ operation. In other words, you seek _total visibility_ as soon as possible.

Once you achieve initial observability, you build upon that initial level of visibility to develop actionable alerts, create useful dashboards, and evaluate [AIOps solutions](/azure/azure-monitor/logs/aiops-machine-learning). These insights let you get comfortable with the underlying metric and log monitoring data.

> [!NOTE]
> This is the opposite of the approach used in the past when teams worked to define all of the monitoring requirements first on paper before building, testing, and deploying.

Whether your monitoring plan targets an application, the cloud infrastructure, or the Azure Platform, the first step is to _establish observability_.

This approach also simplifies your plans. In all cases, total visibility means achieving and sustaining sufficient visibility across three dimensions or aspects:

- Monitoring-in-depth
- Monitoring in breadth
- Monitoring across the health model

![Three-sided cube example](../../strategy/media/monitoring-strategy/three-sided-cube.png)

Observability is more than just a focus for your IT teams. An essential goal is to ensure end users can use the systems and that your [Service Level Objectives](./service-level-objectives.md) (SLO) are met.

## Monitoring systems and observability

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

Microsoft and its partners provide management packs for System Center Operations Manager. Management packs are technology-specific; for example, if you import a SQL management pack, Operations Manager automatically discovers and targets servers hosting SQL Server and begins monitoring them. Here, _observability is more or less predefined_. Operations Manager is primarily designed for on-premises infrastructure, which tend to be **fixed** in components and architectural design patterns relative to cloud services.

In the cloud, you have enormous **flexibility** in the types of services to choose from. Monitoring includes how services change over time, and can be dynamic, global, and resilient. With Azure Monitor, you can take advantage of existing workbooks included in [Azure Monitor Insights](/azure/azure-monitor/insights/insights-overview) providing functionality similar to a management pack in Operations Manager.

<!-- docutune:ignore "Observe discipline" -->

## The art of being observant

Observability relies on what and how something is being monitored.

In Azure, there are multiple monitoring data sources, each delivering a different perspective of how something behaves. Azure includes numerous tools to help analyze the various aspects of this data. In Azure, Microsoft provide the perspective of the _service provider_ through different platform logs.

Here are a few examples:

|Log source|Description|
|---|---|
|[Service health](/azure/service-health/service-health-portal-update)|Service incidents and planned maintenance reported by Microsoft.|
|[Azure Monitor activity log](/azure/azure-monitor/essentials/activity-log)|Reports subscription-level events across all the resources deployed in the subscription.|
|[Azure Resource Health](/azure/service-health/resource-health-overview)|Reports on your resources' current and past health.|
|[Azure Advisor](/azure/advisor/advisor-overview)|Use Azure Advisor to receive recommended solutions based on best practices to optimize your Azure deployments.|

Additional perspectives, based on metrics and logs, are delivered through the various features of Azure Monitor. In some cases you can also view services' platform metrics directly from that resource in the portal.

Services in Azure can change in different, unpredictable ways over time. Hence we refer to this behavior as dynamic. Managers of cloud services observing the service over time need to take into account the following:

- **Resource relocation**: Resources can migrate or move across locations or geography.
- **Resource changes**: Resources are added, deleted, or modified.
- **Consumption**: Consumption varies for different services and implementations. Be mindful to monitor the cost, consumption, and the projected spend.

Observability evolves gradually, starting with a minimally viable monitoring plan, and the effort to integrate tools and processes is underway. As you get comfortable with the data (metrics, logs, and transactions), you can understand the behavior and signs of symptoms or issues from those resources or applications. By getting familiar with the data, you build trust in working with Azure Monitor and the data.

Through observability, you gain confidence, and you're able to realize the cause and find answers that can help:

- Reduce monitoring blind spots by ensuring coverage of all needed monitoring components.
- Improve monitoring of resources and services to help identify the issue in the future. Focus on issues or symptoms that are predictable and reliable.
- Evaluate whether this wasn't anticipated and how to improve the infrastructure, application, and more.
- Rule out the infrastructure or application as the source, and determine whether a specific browser, browser version or client operating system is the potential issue.
- Identify and document or implement workarounds to minimize any performance or availability issues with the application, infrastructure, and more.
- Adapt to the dynamic and complex nature of an application. Continue learning its normal behavior patterns to narrow in on the unusual ones.
- Tune the type of data collected, aggregated, and alerted on to minimize storage cost for data you never analyze, alert on, or visualize.

At first, you no longer need to worry about the infrastructure or application, as in an on-premises world. You're now free to monitor or obtain monitoring data to support the needs of those responsible for managing and operating the workload.

Like any application or infrastructure service, a diverse list of stakeholders and roles need access to the monitoring features, data, and reports. Start with the core system engineers, operations, or service providers responsible for supporting the workload before extending access to other stakeholders.

## Fixed versus dynamic approach

On-premises monitoring of services in the datacenter is traditionally undertaken with a product such as System Center Operations Manager. Operations Manager's approach is firmly rooted in infrastructure and servers, with agents and operating systems. Application monitoring, whether containerized or not, is up-stack and dependent on infrastructure monitoring of servers down-stack. Vertically, you see the solution coverage from the bottom up, starting with networking and, at the top, user-experience monitoring.

The long history of IaaS monitoring reveals that _observability can be predefined_, or if you wish, _pre-engineered_. An IaaS-based service is one where the product engineers can author Operations Manager management packs, customizing the monitoring solution for most of the supported use cases.

Thus in the need to control infrastructure services by monitoring solutions, customers seek more of a fixed approach in most cases.

A fixed approach can't occur in the cloud given the near-infinite arrangement and combinations of resources both in space and in time. Each service can be unique. Service observability in Azure must be built depending on the flexible nature of the service. That is, dynamic, global, resilient, user-centric, and more. Or it is based on a set of architectural templates that might not exist yet.

Observability is first and paramount for holistically seeing how all components are working together _before_ establishing event significance (such as alerts, digests, or workbooks).

Again, cloud service monitoring is much more flexible and dynamic with a faster speed of change.

## Monitoring plan

You create a monitoring plan to describe the goals and objectives, requirements, and other essential details. Then work to solicit an agreement between all of the relevant stakeholders in the organization. A monitoring plan should explain how to develop and operate one or more monitoring solutions. Begin creating your monitoring plans early during the strategy and planning phases of the project.

While creating the plan, it's essential to remember the five disciplines of modern monitoring: monitor, measure, respond, learn, and improve.

The following provides a recommended outline and are considered to be the primary considerations for an individual plan for services or when standardizing cloud service features such as Azure resource types or Microsoft 365 services. The essence of the plan is to define the line of visibility between service providers (who will field solutions) and consumers (who will operate or derive value).

The schedule of when (and how) is also vital for the work management approach (for example, DevOps vs. waterfall).

### Business perspective

A comprehensive monitoring plan must consider what the business needs with and from monitoring, including a user-centric focus. While defining the plan, it's essential to document and share the business requirements, and the following suggests the scope of this part of the plan.

- Stakeholders and consumers
- Business value streams and processes
- End-user perspective and utility
- Measurement and reporting requirements
- Identified risks and compliance control frameworks
- Access and control requirements
- Risk to the business

### Service perspective

A comprehensive monitoring plan must consider what the service owners need with and from monitoring. While defining the plan, it's essential to document and share their requirements, and the following suggests the scope of this part of the plan.

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

This section of the plan represents the monitoring solution using information from the business and service perspective.

- User stories and scenarios
- Technical targets (for example, networking)
- Component dependency mapping
- Types (for example, cloud-native, hybrid, on-premises)
- Observational
- Responsive
- Measurement
- Tuning and optimization

### Key considerations

Summarize the plan to ensure it communicates and informs all relevant consumers, stakeholders, and management levels.

- **Production stages:** The monitoring solution should be ready for value when the service goes live, so planning can include lab or preproduction configuration (in another subscription dedicated to supporting this) for experimenting and testing your assumptions. In the cloud, a production tenant is usually safe based on the overall governance.

- **Strategy:** Plans can also map back to monitoring and IT strategy to trace the monitoring objectives to the mission or business. It depends on whether the workload is cloud-native.

- **Targets:** In the plan, describe and analyze the target assets or services under consideration. If needed, map all the components to monitor, including service dependencies. Identify coverage gaps and determine who owns each part of the service.

- **Solution:** For the monitoring solution, identify the consumers, stakeholders, suppliers, partners, access, and instrumentation. Also, monitoring aspects, scope, response, reports, and dashboards (availability, security, user experience, and more).

### Lean and agile considerations

- **Minimum viable product:** Let the plan define the minimum viable product, that is, what is initially needed to go live, then continue to evolve the monitoring solution to maximize value. For example, later, you might define a future task to build other log-based workbooks, pinning to Azure dashboards and expanding stakeholder access to the Azure portal.

- **Start where you are and get value fast:**  Rapidly and radically experiment and exploit with SaaS because it's easy and valuable.

- **Know the guardrails:** Cloud is new and uncertain, so let experts guide you so you don't add risk (for example, exposing sensitive monitoring data).

- **Microsoft 365 depends on Azure:**  Any good plan considers your Azure tenant with Microsoft 365 as a significant player. Microsoft 365 depends on Azure AD and Azure Monitor provides Microsoft 365 integration with endpoint management.

- **Observability wins:** Focus on total visibility before alerting, as alerting is now a cost.

- **Log architecture:** Emitters, telemetry, signals, AI, and prepackaged solutions such as the Intelligent Security Graph. Focus more on a SIEM approach, how to amass disparate logs into log solutions such as Azure Monitor Logs.

- **Moving data:** Much more monitoring focuses on emitter-to-dashboard and where data goes over the internet and across your cloud regions, ExpressRoute connections, and VPNs.

- **Activity monitoring:** Audit, sign-in, and activity logs are now easy for service owners and security to slice and dice.

## Next steps

> [!div class="nextstepaction"]
> [Service Level Objectives](./service-level-objectives.md)
