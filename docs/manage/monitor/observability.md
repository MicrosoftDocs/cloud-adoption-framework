---
title: Cloud monitoring observability
description: Gain an understanding of how observability helps drive maturity in monitoring and help you understand the behavior of your services running in the cloud.
author: mgoedtel
ms.author: magoedte
ms.date: 03/22/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
---

# Cloud monitoring guide: Observability

This article is intended to help organizations implement a consistent monitoring strategy quicker by ensuring *observability* is established in the Azure landing zone (that is, in every minimum viable product) for each monitoring solution.

As a planner, you formulate a monitoring plan for a service and include some monitoring objectives. One objective you want is for the monitoring consumer(s) to reach a level of comfort or confidence with the solution you are planning for them, as soon as possible. Then you can move on to other objectives, like building reports and custom dashboards.

We call this *adoption*.

The goal of this article is to take the [monitoring strategy](../../strategy/monitoring-strategy.md) recommendations, and create a monitoring plan to support the goal of modernizing and evolving your organizations IT operations strategy. The second goal is to drive operational maturity by being observant and constantly iterating to improve how you monitor those services.

> [!NOTE]
> In this article, a *monitoring solution* is the unit of production doing the monitoring of a service in the cloud, and a *monitoring target* is the service or thing that is being monitored. A solution encompasses all aspects of monitoring: the tool, the monitoring data, alerts, type of response, recovery actions, type of visualization, role-based access, and so on.

## Why observability is important

Simply, its observability *first* that drives the monitoring consumer to understand what is considered or perceived as *normal* operation of a service. In other words, you seek *total visibility*, a key monitoring principle, as soon as possible. Once initial observability is achieved, then you build upon that initial level of visibility to develop actionable alerts, create useful dashboards, and evaluate AIOps solutions. This allows you time to get comfortable with the underlying metric and log monitoring data.

> [!NOTE]
> This is the opposite of the approach used in the past, when teams worked to define all of the monitoring requirements first on paper, before build, test, and deploy.

Whether the plan (that is, objective) targets an Azure resource type such as Key Vault, an entire resource group, or even Microsoft 365 Exchange Online, the first step is to *establish observability*.

This approach also simplifies your plans. In all cases, total visibility means achieving and sustaining, sufficient visibility across three dimensions or aspects:

- Monitoring-in-depth
- Monitoring in breadth
- Monitoring across the health model

![Three-sided cube example](../../strategy/media/monitoring-strategy/three-sided-cube.png)

Being observant isn't just an IT focus; remember the goal is to ensure end users can consume and business expectations are met. You can't monitor what you don't understand or know, and as a result you won't able to deliver the level of service availability promised to the business. Before the advent of cloud computing, Microsoft emphasized failure mode analysis during application design and development. Failure mode analysis helped developers consider how and when logic or other critical errors could occur in their code. And when it does, expose the condition in a meaningful way to allow the monitoring tool not only detect it and act on it, but also provide developers, operators, or system engineers with useful information to help better understand the applications behavior and make data-driven decisions. Today, the [Cloud Adoption Framework](/azure/architecture/resiliency/failure-mode-analysis) recommends you follow that process as part of the architecture and design phases to build recovery of the Azure services in your design.

Bottom line, it's the observability you want, early, and in your minimum viable product.

## Monitoring systems and observability

Infrastructure and application monitoring is complicated, it always has been and remains so even with the introduction of cloud computing. Business transformation applies technology to achieve current, and help shape, its future strategy. The cloud has further influenced the complicated nature of monitoring.

This is demonstrated in the following ways:

- Business (digital) transformation efforts shift toward hyper-exploitation of cloud technology.

- Monitoring becomes embedded into Azure resources and resource groups versus separate tooling you manage on-premises.

- Cloud-native monitoring architectures are SIEM-like, such as Azure Monitor. So it's expansive, log-driven, and orders of magnitude more flexible.

For architects, diagnostics form the core of their exploitation of more cost effective cloud-native monitoring structures that let IT manage services holistically across the different cloud models.

Architects must, like operators, understand what diagnostic information an IT infrastructure component or application emits. Combining multivariate, dynamical, time-series, eventful, stateful, and telemetric log streams into valuable intelligence depends on the following:

- The knowledge and experience of the developer or system engineer, who have a deep understanding of the monitoring target.

- Actual support and troubleshooting experience using the data, to find trouble or locate the causes of trouble.

- Review of past incidents to find non-technology reasons, that later can be automated (auto remediation).

- Guidance in the form of documentation, software, training, or consulting by the software or hardware vendor.

If you are familiar with System Center Operations Manager, Microsoft and its partners provide *management packs.*  Management packs are technology-specific; for example, you import a SQL management pack Operations Manager automatically discovers and targets servers hosting SQL Server and begins monitoring them. Here, observability is more or less predefined by the product engineers at Microsoft and dozens of industries. With Operations Manager, you don't need to worry about north-south and east-west dependencies, so that observing the health of SQL is part of the larger IT service with networking, virtualization, and applications included. Owing to a common schema based on the familiar four-part *health model*, Operations Manager is designed for on-premises infrastructure. Infrastructure service architectures tend to be **fixed** in components and architectural patterns, relative to cloud services.

In the cloud, you have enormous flexibility in the types of services you can choose. Monitoring includes how they change over time, and they can be dynamic, global, and resilient. As a cloud architect, you are not constrained by fixed, on-premises thinking. Operations Manager can participate, but again, its strength is traditional on-premises infrastructure and applications. In contrast, Azure Monitor's architecture is much more flexible in supporting all three cloud models. To reach your observability goals in Azure Monitor, you have more freedom to decide on resources, where to place them geographically, and how to visualize the components working together.

With Azure Monitor, you can take advantage of existing workbooks that are included in [Insights](/azure/azure-monitor/monitor-reference), which provide similar functionality that a management pack in Operations Manager does. Otherwise, you need to review the Azure documentation for each of the Azure services in order to understand how you can monitor and detect for known failures or symptoms that indicate potential failure.

<!-- docutune:ignore "Observe discipline" -->

## Monitoring disciplines

The following figure shows the Observe discipline on the left, and later in this section we discuss how Microsoft Azure plays a central role here.

![Monitoring disciplines](./media/observability/monitoring-and-control-disciplines.png)

## Observability and response

**Observability** is a *qualitative indicator that a monitoring solution helps the monitoring consumer achieve the satisfactory level of control of a defined service*. Where monitoring provides service consumers with a suitable range of monitoring *capabilities* and *perspectives*.

**Response** is the organization's ability to quickly ascertain *significance* of observed monitoring data (detected events, telemetric patterns, correlated information, an so on) such that for negative events it can rapidly restore or remediate. For positive events or informational events, it can help to maintain service agreements, improve reliability, and reduce support costs. Events dynamically occur in the system or service, where monitoring solutions provide alerting, control loop automation, and raise incidents, problems, or changes in an external IT service management (ITSM) system. Realize that many events cannot or should not be automatically remediated.

**Utility:** In this sense, observability (and response) is about the operational use or utility of the monitoring solution. Azure Monitor provides Microsoft's perspective of our service resources, and gives you similar capabilities as an on-premises monitoring system. A monitoring solution needs visualizations, such as dashboards and workbooks, with role-based access.

**Responsibility:** Both the service consumer and service provider share in the need to learn and improve based on hard data. As such, you need to understand the cloud provider's responsibility vs. the customer/consumer's responsibility. For each Azure resource, you get perspectives based on logs or metrics, this data can be represented in resource-specific dashboards or custom visualizations based on your requirements, and shared with the necessary personas in the organization.

> [!NOTE]
> [Observability](https://en.wikipedia.org/wiki/Observability) is a property of a system, stemming from system control theory. It's a measure of how well the internal states of a system can be inferred from its system *external* outputs, along with [controllability](https://en.wikipedia.org/wiki/Controllability), another property of a system. In addition, a *dynamical system* also that over time, a state observer measures or estimates the health state of the system. But in modern service management terms, refer to the [Microsoft Operations Framework](/previous-versions/tn-archive/cc506049(v=technet.10)) (MOF) **Service Monitoring and Control**," and the Information Technology Infrastructure Library (ITIL) v3 **Monitor and control loop**.

Before we go into details on observability, we need to highlight several monitoring-related terms we'll be using:

- **Asset:** Digital assets such as content in file shares, hardware, and software assets that are also called *targets*.

- **Focus:** Your scope in pursuit of objectives: narrow, broad, a single component, component class, component grouping, service.

- **Aspect:** Perspectives from stakeholders, such as the users, the business, and the service owner.

- **Coverage:** An indicator of visibility and a goal; to ensure all relevant assets are included in the monitoring scope.

- **Manageability:** The extent that a digital asset can be controlled, self-heals, related to change risk and action groups that diagnose or auto remediate.

- **Data source:** The primary location monitoring data comes from, such as an Azure Storage account, Azure Active Directory, or custom sources.

- **Frequency:** Continuous vs. occasional monitoring.

## The art of being observant

Observability relies on what is being monitored and how. In Azure, there are multiple sources, and each delivers a different perspective of how something is behaving. Not to mention, Azure includes multiple tools to help analyze the different aspects of this data. Observing the health and performance of Azure services and non-Azure resources is the primary way you'll use Azure Monitor and its features. In Azure, Microsoft has an extensive catalog of services, and virtual machines are not the primary focus. In Azure, we provide the perspective of the *service provider* through different platform logs:

- Service health reported by Azure about service incidents and planned maintenance.
- The Azure activity log reports subscription-level events across all of the resources deployed in the subscription.
- Azure Resource Health reports on the current and past health of your resources.
- Azure Advisor to receive recommended solutions based on best practices to optimize your Azure deployments.

All other perspectives based on metrics and logs, are delivered through the various features of Azure Monitor. Or, depending on the Azure resource, you can view its platform metrics directly from that resource in the portal.

Observability is a term meant to set the expectation that Azure Monitor gives you total visibility of the health, performance, and other aspects of Azure services in depth and breadth. But, there are other activities or focus than service and component monitoring. Being observant shouldn't be considered something that only certain personas perform on an as-needed basis, as required by their role or function, or in support of a process. It's similar to astronomy. Observation isn't once and done, rather you'll want to monitor objects in space occasionally, over set time intervals or continuously. Some objects, such as black holes are difficult to observe. The kind of monitoring needed depends on the consumer. For example, amateur astronomers observe occasionally, while astrophysicists value the long-term measurement and continuous monitoring of radio emissions.

With proper planning, you can create a medium to complex service in Azure in a few hours, versus weeks or longer on-premises. If you did, you'd arrange a combination of more than a dozen Azure resources (service components) across regions. You'll govern and manage these resources using Azure Resource Manager and from using resource group monitoring in Azure, you'll get a picture of the service. Once in production, the service is dynamical and flexible. Consumption starts to ramp up and scale out. Capacity responds to demand. Events will occur, and service consumers can observe monitoring data, look at trends, and establish their significance.

The service can change in different, unpredictable ways over time. Hence we refer to this behavior as dynamical. Managers of cloud services observing the service over time needs to take into account that:

- Resources move across locations or geography
- Resources are added, deleted, or modified
- Consumption varies

As a monitoring service provider, your job is to facilitate monitoring solutions that provide value listed in the following order of priority: 1) to the service, 2) to stakeholders, and 3) to the primary consumers.

Your value stream needs to consider service observability much earlier and in the following ways:

- It monitors in sufficient depth and breadth.
- It provides coverage across the health model (availability, capacity/performance, security, conformance).
- It monitors utility also, what the service does, including the end-user experience.

In the monitoring strategy, we recommend establishing a monitoring plan that starts with what is minimally viable or most important to monitor and observe. This can be based on recommendations from Microsoft, other reputable sources, and your internal developers or system engineers depending on the resource or system. Establish initial visibility of the *consumption*, *performance*, *security*, and *availability* of the resources in your Azure resource groups and your Azure Active Directory tenant. Through observation, you learn how to interpret the data, and learn what's significant in order to fine-tune and optimize how the service is monitored. Value is achieved when incremental, and there is a co-creation of value here in that the consumers are working with the monitoring team (or in some cases the service provider) on co-creation of value.

Observability evolves gradually, starting with a minimally viable monitoring plan, and the effort to integrate tools and processes is underway. As you get comfortable with the data (that is, metrics, logs, and transactions), you are able to understand the behavior and signs of symptoms or issues from those resources or applications. By getting familiar with the data, you build trust in working with Azure Monitor and the data. Through observability, you gain confidence and you are able to realize the cause and find answers that can help:

- Reduce monitoring blind spots by ensuring coverage of all needed monitoring components.
- Improve monitoring of resources and services to help identify the issue in the future. Focus on issues or symptoms that are predictable and reliable.
- Evaluate whether this wasn't anticipated, what can be done to improve the infrastructure, application, and so on.
- Rule out the infrastructure or application as the source, and determine whether a specific browser, browser version, or client operating system is the potential issue.
- Identify, and document or implement, workarounds that can be used to minimize any performance or availability issues with the application, infrastructure, and so on.
- Adapt to the dynamical and complex nature of an application. Continue learning its normal behavior patterns in order to narrow in on the unusual ones.
- Tune the type of data collected, aggregated, and alerted on to minimize storage cost for data you never analyze, alert on, or visualize.

At first, you no longer need to worry about the infrastructure or application as was the case in an on-premises world; you are now free to monitor or obtain monitoring data to support the needs of those responsible for managing and operating the workload.

Like any application or infrastructure service, a diverse list of stakeholders and roles need access to the monitoring features, data and reports. Start with the core system engineers, operations, or service providers responsible for supporting the workload before extending access to other stakeholders.

## Fixed versus dynamical approach

On-premises monitoring of services in the datacenter is traditionally undertaken with a product such as System Center Operations Manager. Operations Manager's approach is firmly rooted in infrastructure and servers, with agents and operating systems. Application monitoring, whether containerized or not, is up-stack and dependent on infrastructure monitoring of servers down-stack. Vertically, you see the solution coverage from bottom-up, starting with networking and at the top, user-experience monitoring.

The long history of IaaS monitoring reveals that *observability can be predefined*, or if you wish, *pre-engineered*. An IaaS-based service is one where the product engineers can author Operations Manager management packs, in essence customizing the monitoring solution for most of the supported use cases.

Thus in the need to control infrastructure services by monitoring solutions, customers seek more of a fixed approach in most cases.

A fixed approach cannot occur in the cloud given the near infinite arrangement and combinations of resources both in space and in time. Each service can be unique. Service observability in Azure must be built depending on the flexible nature of the service (that is, dynamical, global, resilient, user-centric, and so on) or according to some set of architectural templates, which may not yet exist.

Observability is first and paramount for holistically seeing how all components are working together *before* establishing event significance (such as alerts, digests, or workbooks).

Again, cloud service monitoring is much more flexible and dynamical with faster speed of change.

## Monitoring plan

You create a monitoring plan to describe the goals and objectives, requirements, and other important details. Then work to solicit an agreement between all of the relevant stakeholders in the organization. A monitoring plan should explain how to develop and operate one or more monitoring solutions. Begin develop your monitoring plans early during the strategy and planning phases of the project.

While creating the plan, it's important to keep in mind the five disciplines of modern monitoring: observe, measure, respond, and learn, and improve.

The following provides a recommended outline and are considered to be the primary considerations for an individual plan for services or when standardizing cloud service features such as Azure resource types or Microsoft 365 services. The essence of the plan is to define the line of visibility between service provider (who will field solutions) and consumers (who will operate or derive value).

The schedule of when (and how) is also important to include for the work management approach (for example, DevOps vs. waterfall).

### Business perspective

A comprehensive monitoring plan needs to take into consideration what the business needs with and from monitoring, and this must include a user-centric focus. While defining the plan, it's important to document and share the business requirements, and the following suggests the scope of this part of the plan.

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
- Roles and accountability's
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
- Types (for example, cloud native, hybrid, on-premises)
- Observational
- Responsive
- Measurement
- Tuning and optimization

### Key considerations

Summarize the plan to ensure it communicates and informs all relevant consumers, stakeholders, and management levels.

- **Production stages:** The monitoring solution should be ready for value when the service goes live, so planning can include lab or preproduction configuration (that is, in another subscription dedicated to supporting this) for experimenting and testing your assumptions. In the cloud, a production tenant is usually safe based on the overall governance.

- **Strategy:** Plans can also map back to monitoring and IT strategy so that the monitoring objectives trace back to the mission or business. It depends on whether the workload is cloud-native.

- **Targets:** In the plan, describe and analyze the target assets or services under consideration. If needed, map all of the components to be monitored, including service dependencies. Identify coverage gaps and determine who owns each part of the service.

- **Solution:** For the monitoring solution, identify the consumers, stakeholders, suppliers, partners, access, and instrumentation. Also monitoring aspects, focus, response, and reports and dashboards (availability, security, user experience, and so on).

### Lean and agile considerations

- **Minimum viable product:** Let the plan define the minimum viable product, that is what is initially needed to go live, then continue to evolve the monitoring solution to maximize value. For example, you may define a future task later to build other log-based workbooks, pinning to Azure dashboards, and expanding stakeholder access to the Azure portal.

- **Start where you are and get value fast:**  Rapidly and radically experiment, exploit with SaaS out of the box, because it's easy and valuable.

- **Know the guardrails:** Cloud is new and uncertain, so let experts guide you so that you don't add risk (for example, exposing sensitive monitoring data).

- **Microsoft 365 depends on Azure:**  Any good plan considers your Azure tenant with Microsoft 365 as a major player. Microsoft 365 depends on Azure AD, and Azure Monitor provides Microsoft 365 integration with endpoint management.

- **Observability wins:** Focus on total visibility before alerting, as alerting is now a cost.

- **Log architecture:** Emitters, telemetry, signals, AI, and prepackaged solutions such as the Intelligent Security Graph. Focus more on a SIEM approach, how to amass disparate logs into log solutions such as Azure Monitor Logs.

- **Moving data:** Much more monitoring focus on emitter-to-dashboard and where data is going over the internet and across your cloud regions, ExpressRoute connections, and VPNs.

- **Activity monitoring:** Audit, sign-in, and activity logs are now easy to slice and dice for service owners and security.

## Next steps

> [!div class="nextstepaction"]
> [Collect the right data](./data-collection.md)
