---
title: Observability in cloud monitoring
description: Gain an understanding of how observability helps drive maturity in monitoring and help you understand the behavior of your services running in the cloud.
author: Zimmergren
ms.author: tozimmergren
ms.date: 06/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
products: azure-monitor
ms.custom: UpdateFrequency2
---

# Observability in cloud monitoring

This article helps organizations implement a consistent monitoring strategy quicker by ensuring _observability_ is established in the [Azure landing zone](../../ready/landing-zone/index.md) (that is, in every minimum viable product) for each monitoring solution. As a planner, you develop a monitoring plan for a service and include some monitoring objectives. One desirable goal is for the monitoring consumers within the IT organization to reach comfort or confidence with the solution you're planning for them as soon as possible. The other objective is to continuously evaluate the Service Level Objectives (SLOs) and corresponding Service Level Indicators (SLIs) for that service and strive to optimize through planning iterations. This is necessary so IT can reach SLO targets, make the service more reliable and cost-effectively, and better meet the needs and expectations of the business.

We call this _adoption_.

While observability and monitoring complement each other, there is a notable distinction. Monitoring collects information and informs you that it detected an issue based on you configuring it to monitor for those conditions. You're monitoring for known or predictable failures. Observability is focused on combing through all the data collected by your monitoring tool(s) and looking for opportunities to understand the behavior of those systems. You use that knowledge to tune monitoring further to detect these symptoms or conditions.

This article aims to take the [monitoring strategy](../../strategy/monitoring-strategy.md) recommendations and create a monitoring plan to support the goal of modernizing and evolving your organization's IT operations strategy. The second goal is to drive operational maturity by being observant and constantly iterating to improve how you monitor those services.

> [!NOTE]
> In this article, a _monitoring solution_ is the unit of production doing the monitoring of a service in the cloud, and a _monitoring target_ is the service or thing that is being monitored. A monitoring solution encompasses all monitoring aspects: the tool, the monitoring data, alerts, the type of response, recovery actions, the type of visualization, role-based access, and more.

## Terminology

Before we go into details on observability, we need to highlight several monitoring-related terms we'll be using:

- [Observability](https://en.wikipedia.org/wiki/Observability) Observability is a crucial aspect of _assessing the state of an internal system by employing the data it generates_. An effective observability solution carefully analyzes the system's output data, comprehensively evaluating its health.

- **Asset:** Digital assets such as content in file shares, hardware, and software assets also called _targets_.

- **Focus:** Your scope in pursuit of objectives: narrow, broad, a single component, component class, component grouping, service.

- **Aspect:** Perspectives from stakeholders, such as the users, the business, and the service owner.

- **Coverage:** An indicator of visibility and a goal; to ensure all relevant assets are included in the monitoring scope.

- **Manageability:** The extent to which a digital asset can be controlled, self-heals, related to change risk and action groups that diagnose or remediate.

- **Data source:** The primary location monitoring data comes from an Azure Storage account, Azure Active Directory, or custom sources.

- **Frequency:** Continuous vs. occasional monitoring.

## Why observability is important

Observability _first_ drives the monitoring consumer to understand what is considered or perceived as the _normal_ operation of a service. In other words, you seek _total visibility_, a fundamental monitoring principle, as soon as possible. Once initial observability is achieved, you build upon that initial level of visibility to develop actionable alerts, create useful dashboards, and evaluate AIOps solutions. This allows you to get comfortable with the underlying metric and log monitoring data.

> [!NOTE]
> This is the opposite of the approach used in the past when teams worked to define all of the monitoring requirements first on paper before building, testing, and deploying.

Whether the plan (objective) targets an Azure resource type such as Key Vault, an entire resource group, or even Microsoft 365 Exchange Online, the first step is to _establish observability_.

This approach also simplifies your plans. In all cases, total visibility means achieving and sustaining sufficient visibility across three dimensions or aspects:

- Monitoring-in-depth
- Monitoring in breadth
- Monitoring across the health model

![Three-sided cube example](../../strategy/media/monitoring-strategy/three-sided-cube.png)

Being observant isn't just an IT focus; remember, the goal is to ensure end users can consume and Service Level Objectives (SLOs) are met. You can't monitor what you don't understand or know, so you won't be able to deliver the level of service availability promised to the business.

Before the advent of cloud computing, Microsoft emphasized failure mode analysis during application design and development. Failure mode analysis helped developers consider how and when logic or other critical errors could occur in their code. And when the issue occurs, expose the condition in a meaningful way. Exposing these conditions allows the monitoring tool to detect and act on and provides developers, operators, or system engineers with helpful information to help better understand the application's behavior and make data-driven decisions. Today, the [Cloud Adoption Framework](/azure/architecture/resiliency/failure-mode-analysis) recommends you follow that process as part of the architecture and design phases to build recovery of the Azure services in your design.

The bottom line is that it's observability you want early and in your minimum viable product.

## Monitoring systems and observability

Infrastructure and application monitoring is complicated; it always has been and remains so, even with the introduction of cloud computing. Business transformation applies technology to achieve current and help shape its future strategy. The cloud has further influenced the complicated nature of monitoring.

This is demonstrated in the following ways:

- Business (digital) transformation efforts shift toward hyper-exploitation of cloud technology.

- Monitoring becomes embedded into Azure resources and resource groups versus separate tooling you manage on-premises.

- Cloud-native monitoring architectures such as Azure Monitor are similar to security incident and event management (SIEM) tools. Azure Monitor is expansive, log-driven, and orders of magnitude more flexible.

For architects, diagnostics form the core of their exploitation of more cost-effective cloud-native monitoring structures that let IT manage services holistically across the different cloud models.

Architects must, like operators, understand what diagnostic information an infrastructure component or application emits. Combining multivariate, dynamical, time-series, eventful, stateful, and telemetric log streams into valuable intelligence depends on the following:

- The knowledge and experience of the developer or system engineer who deeply understands the monitoring target.

- Actual support and troubleshooting experience using the data to find or locate the causes of trouble.

- Review past incidents to find non-technology reasons that can be auto-remediated later.

- Guidance in documentation, software, training, or consulting by the software or hardware vendor.

If you're familiar with System Center Operations Manager, Microsoft and its partners provide _management packs._  Management packs are technology-specific; for example, if you import a SQL management pack Operations Manager automatically discovers and targets servers hosting SQL Server and begins monitoring them. Here, observability is more or less predefined by the product engineers at Microsoft and dozens of industries. With Operations Manager, you don't need to worry about north-south and east-west dependencies, so observing the health of SQL is part of the larger IT service with networking, virtualization, and applications included. Owing to a common schema based on the familiar four-part _health model_, Operations Manager is designed for on-premises infrastructure. Infrastructure service architectures tend to be **fixed** in components and architectural design patterns relative to cloud services.

In the cloud, you have enormous flexibility in the types of services to choose from. Monitoring includes how they change over time and can be dynamic, global, and resilient. As a cloud architect, you're not constrained by fixed, on-premises thinking. Operations Manager can participate, but its strength is traditional on-premises infrastructure and applications. In contrast, Azure Monitor's architecture is much more flexible in supporting all three cloud models. To reach your observability goals with Azure Monitor, you have more freedom to decide on resources, where to place them geographically, and how to collect, analyze, and act on telemetry.

With Azure Monitor, you can take advantage of existing workbooks included in [Insights](/azure/azure-monitor/monitor-reference), which provides functionality similar to a management pack in Operations Manager. Otherwise, you need to review the Azure documentation for each Azure service to understand how you can monitor and detect known failures or symptoms that indicate potential failures.

<!-- docutune:ignore "Observe discipline" -->

## Monitoring disciplines

The following figure shows the Monitor discipline, discussed in [monitoring strategy](../../strategy/monitoring-strategy.md). Later in this section, we discuss how Microsoft Azure plays a central role here.

![Monitoring disciplines](./media/observability/monitoring-and-control-disciplines.png)

## Observability and response

**Observability** is a _qualitative indicator that a monitoring solution helps the monitoring consumer achieve a satisfactory level of control of a defined service_, where monitoring provides service consumers with a suitable range of monitoring _capabilities_ and _perspectives_.

**Response** is the organization's ability to quickly ascertain the _significance_ of observed monitoring data (detected events, telemetric patterns, correlated information, and more) such that for negative events it can rapidly restore or remediate. For positive events or informational events, it can help to maintain service agreements, improve reliability, and reduce support costs. Events dynamically occur in the system or service, where monitoring solutions provide alerting, control loop automation, and raise incidents, problems, or changes in an external IT service management (ITSM) system. Realize that many events can't or shouldn't be automatically remediated.

**Utility:** In this sense, observability (and response) is about the operational use or value of the monitoring service. Azure Monitor provides Microsoft's perspective of our service resources and delivers similar capabilities as an on-premises monitoring system.

**Responsibility:** Both the service consumer and service provider share the need to learn and improve based on hard data. As such, you need to understand the cloud provider's responsibility vs. the customer/consumer's responsibility. For each Azure resource, you get perspectives based on logs or metrics; this data can be represented in resource-specific dashboards or custom visualizations based on your requirements and shared with the necessary personas in the organization.

## The art of being observant

Observability relies on what is being monitored and how. In Azure, there are multiple sources, each delivering a different perspective of how something behaves. Azure includes numerous tools to help analyze the various aspects of this data. Observing the health and performance of Azure services and non-Azure resources is the primary way you'll use Azure Monitor and its features. In Azure, Microsoft has an extensive catalog of services, and virtual machines are not the primary focus. In Azure, we provide the perspective of the _service provider_ through different platform logs:

- [Service health](/azure/service-health/service-health-overview) reported by Azure about service incidents and planned maintenance.
- The [Azure Monitor activity log](/azure/azure-monitor/essentials/activity-log) reports subscription-level events across all the resources deployed in the subscription.
- [Azure Resource Health](/azure/service-health/resource-health-overview) reports on your resources' current and past health.
- [Azure Advisor](/azure/advisor/advisor-overview) to receive recommended solutions based on best practices to optimize your Azure deployments.

All other perspectives, based on metrics and logs, are delivered through the various features of Azure Monitor. Or, depending on the Azure resource, you can view its platform metrics directly from that resource in the portal.

Observability is a term meant to set the expectation that Azure Monitor gives you total visibility of the health, performance, and other aspects of Azure services in depth and breadth. But, there are other activities or focuses than service and component monitoring. Being observant shouldn't be considered something that only specific roles perform on an as-needed basis, as required by their role or function, or in support of a process. It's similar to astronomy. Observation isn't once and done; you'll want to monitor objects in space occasionally, over set time intervals, or continuously. Some things, such as black holes, are difficult to observe. The kind of monitoring needed depends on the consumer. For example, amateur astronomers observe occasionally, while astrophysicists value the long-term measurement and continuous monitoring of radio emissions.

Proper planning allows you to create a medium to complex service in Azure in a few hours versus weeks or longer on-premises. If you did, you'd arrange a combination of more than a dozen Azure resources (service components) across regions. You'll govern and manage these resources using Azure Resource Manager, and from using resource group monitoring in Azure, you'll get a picture of the service. Once in production, the service is dynamic, scalable, and flexible. Consumption starts to ramp up and scale out. Capacity responds to demand. Events will occur, and service consumers can observe monitoring data, look at trends, and establish their significance.

The service can change in different, unpredictable ways over time. Hence we refer to this behavior as dynamic. Managers of cloud services observing the service over time need to take into account that:

- Resources move across locations or geography
- Resources are added, deleted, or modified
- Consumption varies

As a monitoring service provider, your job is to facilitate monitoring solutions that provide value listed in the following order of priority: 1) to the service, 2) to stakeholders, and 3) to the primary consumers.

Your value stream needs to consider service observability much earlier and in the following ways:

- It monitors in sufficient depth and breadth.
- It provides coverage across the health model (availability, capacity/performance, security, compliance).
- It monitors utility, meaning functionality delivered by the service meets agreed-upon requirements, including the end-user experience.

In the monitoring strategy, we recommend establishing a monitoring plan that starts with what is minimally viable or most important to monitor and observe. Depending on the resource or system, this can be based on recommendations from Microsoft, other reputable sources, and your internal developers or system engineers. Establish initial visibility of the _consumption_, _performance_, _security_, and _availability_ of the resources in your Azure resource groups and your Azure Active Directory tenant. Through observation, you learn how to interpret the data and learn what's significant in order to fine-tune and optimize how the service is monitored. Value is achieved when incremental, and there's a co-creation of value here in that the consumers are working with the monitoring team (or, in some cases, the service provider) on co-creation of value.

Observability evolves gradually, starting with a minimally viable monitoring plan, and the effort to integrate tools and processes is underway. As you get comfortable with the data (that is, metrics, logs, and transactions), you're able to understand the behavior and signs of symptoms or issues from those resources or applications. By getting familiar with the data, you build trust in working with Azure Monitor and the data. Through observability, you gain confidence and you're able to realize the cause and find answers that can help:

- Reduce monitoring blind spots by ensuring coverage of all needed monitoring components.
- Improve monitoring of resources and services to help identify the issue in the future. Focus on issues or symptoms that are predictable and reliable.
- Evaluate whether this wasn't anticipated, and what can be done to improve the infrastructure, application, and more.
- Rule out the infrastructure or application as the source, and determine whether a specific browser, browser version or client operating system is the potential issue.
- Identify and document or implement workarounds that can be used to minimize any performance or availability issues with the application, infrastructure, and more.
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

You create a monitoring plan to describe the goals and objectives, requirements, and other essential details. Then work to solicit an agreement between all of the relevant stakeholders in the organization. A monitoring plan should explain how to develop and operate one or more monitoring solutions. Begin developing your monitoring plans early during the strategy and planning phases of the project.

While creating the plan, it's essential to remember the five disciplines of modern monitoring: monitor, measure, respond, learn, and improve.

The following provides a recommended outline and are considered to be the primary considerations for an individual plan for services or when standardizing cloud service features such as Azure resource types or Microsoft 365 services. The essence of the plan is to define the line of visibility between service providers (who will field solutions) and consumers (who will operate or derive value).

The schedule of when (and how) is also vital for the work management approach (for example, DevOps vs. waterfall).

### Business perspective

A comprehensive monitoring plan needs to consider what the business needs with and from monitoring, including a user-centric focus. While defining the plan, it's essential to document and share the business requirements, and the following suggests the scope of this part of the plan.

- Stakeholders and consumers
- Business value streams and processes
- End-user perspective and utility
- Measurement and reporting requirements
- Identified risks and compliance control frameworks
- Access and control requirements
- Risk to the business

### Service perspective

A comprehensive monitoring plan needs to take into consideration what the service owners need with and from monitoring. While defining the plan, it's important to document and share their requirements, and the following suggests the scope of this part of the plan.

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

- **Strategy:** Plans can also map back to monitoring and IT strategy to trace the monitoring objectives back to the mission or business. It depends on whether the workload is cloud-native.

- **Targets:** In the plan, describe and analyze the target assets or services under consideration. If needed, map all the components to be monitored, including service dependencies. Identify coverage gaps and determine who owns each part of the service.

- **Solution:** For the monitoring solution, identify the consumers, stakeholders, suppliers, partners, access, and instrumentation. Also, monitoring aspects, focus, response, reports, and dashboards (availability, security, user experience, and more).

### Lean and agile considerations

- **Minimum viable product:** Let the plan define the minimum viable product, that is, what is initially needed to go live, then continue to evolve the monitoring solution to maximize value. For example, later, you might define a future task to build other log-based workbooks, pinning to Azure dashboards and expanding stakeholder access to the Azure portal.

- **Start where you are and get value fast:**  Rapidly and radically experiment and exploit with SaaS because it's easy and valuable.

- **Know the guardrails:** Cloud is new and uncertain, so let experts guide you so that you don't add risk (for example, exposing sensitive monitoring data).

- **Microsoft 365 depends on Azure:**  Any good plan considers your Azure tenant with Microsoft 365 as a significant player. Microsoft 365 depends on Azure AD and Azure Monitor provides Microsoft 365 integration with endpoint management.

- **Observability wins:** Focus on total visibility before alerting, as alerting is now a cost.

- **Log architecture:** Emitters, telemetry, signals, AI, and prepackaged solutions such as the Intelligent Security Graph. Focus more on a SIEM approach, how to amass disparate logs into log solutions such as Azure Monitor Logs.

- **Moving data:** Much more monitoring focuses on emitter-to-dashboard and where data goes over the internet and across your cloud regions, ExpressRoute connections, and VPNs.

- **Activity monitoring:** Audit, sign-in, and activity logs are now easy for service owners and security to slice and dice.

## Next steps

> [!div class="nextstepaction"]
> [Service Level Objectives](./service-level-objectives.md)
