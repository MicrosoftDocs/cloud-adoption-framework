---
title: "Cloud monitoring strategy"
description: Gain an understanding of how to define an effective cloud monitoring strategy.
author: mgoedtel
ms.author: magoedte
ms.date: 04/27/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: operate
services: azure-monitor
---

# Cloud monitoring guide: Formulate a monitoring strategy

As you undergo your digital transformation to the cloud, its important that you plan and develop an effective cloud monitoring strategy with participation of developers, operations staff, and infrastructure engineers. The strategy should be growth-oriented, defined minimally, then refined iteratively; always aligned with business needs. Its outcome delivers an agile operations modality centered around the ability of the organization to proactively monitor complex distributed applications the business depends on.

## Where to start?

To ease your journey to the cloud, use the Strategy and Plan phases of the Cloud Adoption Framework. Monitoring influences and justifies the motivations, business outcomes, and initiatives. It needs to be included in the Strategy and Plan phases, your initiatives, and projects. For example, examine how the first adoption project establishes early operations management in Azure. Imagine what the cloud operating model needs to look like, including the role of monitoring. Monitoring is best served with a service-based approach, as an operations function, where monitoring is an advisory service and a provider of expertise to business and IT consumers.  

The following are important areas which strongly influence a sound monitoring strategy:

* Monitor the health of your applications, based on its components and their relationship with other dependencies. Start with the cloud service platform, resources, the network, and lastly the application by collecting metrics and logs where applicable. For the hybrid cloud model, include on-premises infrastructure and other systems the application relies on.

* Include measuring the end user's experience in your applications performance monitoring plan by mimicking your customer's typical interactions with the application.

* Align alerts with what is considered a relevant/practical incident (i.e. warnings and exceptions) and align severity with its significance following your incident priority/urgency escalation matrix. 

* Collect only the metrics and logs that are useful, measureable, and identifiable to the business and IT organization.

* Define an integration plan with existing ITSM solutions (i.e. Remedy, ServiceNow, etc.) for incident generation or upstream monitoring. Identify which alerts should be forwarded, if alert enrichment required to support specific filtering requirements, and how to configure.

* Understand who needs visibility, what they need to see, and how it should be visualized based on their roles and responsibilities.  

At the heart of operations management, your IT enterprise needs to establish centralized governance and strict delegation over approaches to build, operate, and manage IT services.   

## High level requirements

As an architect or strategic planner, you may need to formulate an early strategy for operations management, in which monitoring plays a major role. Consider these four outcomes:

1. You need to manage cloud production services when they go live into production, such as networking, applications, security and virtual infrastructure.

2. You need to apply limited resources to rationalize your existing monitoring tools, skills and expertise, and leverage cloud monitoring to reduce complexity.

3. You need make your monitoring solution processes more efficient, work faster and smoother, at scale and be able to change quickly too.

4. You need to account for how your organization will plan for and host monitoring based on cloud models, and reduce your requirements as the organization moves up stream from  IaaS to PaaS, and then to SaaS.  

## High level modeling

As the business determines what services will move, you will need to invest your resources carefully.  On-premises, you own all responsibilities for monitoring and are heavily invested.  The moves made toward SaaS services for example does not eliminate your responsibilities for monitoring.  You’ll be deciding who needs access, who gets alerts, and who needs access to analytics.  Azure Monitor and Azure Arc are SaaS services with the flexibility of addressing monitoring scenarios across all four cloud models, not just resources inside Azure.  
And you need to look beyond the cloud model below.  You’ll want to include Microsoft 365 in the equation, since you get significant monitoring for security and compliance on top of Azure Security Center including identities, endpoint management, and device monitoring outside the datacenter.

![Cloud models diagram](./media/monitoring-strategy/cloud-models.png)

## Agile solution releases

Ultimately, you’ll deliver monitoring configurations or solutions into production. As an IT Operations Manager or Monitoring Team Lead, consider a standard, simple taxonomy to improve communication with consumers, managers, and IT operations. An agile, DevOps style of approach ensures monitoring is embedded with the teams who will be building and operating cloud services. While traditional project management will work, it may not be fast enough nor embed itself in your operations teams.

Include in your strategy and operating model how you communicate monitoring plans, objectives, and configurations (the solutions). For example, how you might leverage Azure DevOps Boards:

|Agile term|What to include|Examples|
|----------|---------------|--------|
|Epics|Broad monitoring<br>Initiatives of the monitoring strategy|Consolidate Azure cloud monitoring<br> Hybrid cloud monitoring<br> Private cloud monitoring<br> Establish core monitoring service |
|Features|Individual monitoring<br> Plans and projects|Monitoring requirements<br> Monitoring consumers and providers<br> Objectives<br> Tools<br> Schedule|
|User stories and tasks |The end result is a<br> Monitoring configuration and/or solution|Network monitoring (e.g. Express Route)<br> Standardized IaaS VM monitoring (e.g. Azure Monitor for VMs, Application Insight, Azure Policy, settings, policies, reports, workspaces.)|

## Monitoring informs strategy 

Consider where early monitoring capability *informs strategy*. Many decisions depend on early monitoring data in order to build a capability roadmap that guides limited resources and adds confidence. Strategies also need real-world input from monitoring of service enablement.

Consider the role monitoring plays in strategies to incrementally protect and secure the digital estate:

* Activity logs and security monitoring are needed to measure directory usage and external sharing of sensitive content, to inform in an incremental approach to layer on protective features and achieve the right balance with privacy monitoring.

* Policies and baselines will inform the rationalization objective (migrate, lift and shift, re-architect) and improve confidence that data and information can be migrated from on-premises to cloud services.

Later in this guide, discover some common monitoring scenarios or use cases that will help accelerate adoption.

## Determine what you have

As a manageability expert, you may be working closely with a steering committee, the architect and strategic planners. You might be working to formulate monitoring strategy by assessing the current state of your systems management: the people, partnering, outsourcing, tooling, complexity, gaps and risks. An assessment will help you prioritize the set of found problems and select the key opportunities that improve the current situation. Determine, too, the services, systems, and data that are likely to remain on-premises as one important outcome. Ideally, management wants a roadmap of initiatives, but in direct proportion to the known planning horizon. Discussing unknowns, are just as important.

## Formulate a monitoring architecture

Define your current and future architecture of systems management that includes monitoring, to:

* Apply limited resources in consolidating your monitoring investment

* Decide on how monitoring will help exploit the future services your business needs: cloud monitoring of highly scaleable, resilient and globally aware cloud services.

* Align monitoring to the future services and resources that you will be monitoring in the cloud.

* Identify monitoring gaps in three dimensions* - depth, breadth and across the health model.

* Model the financial aspects, costs and support factors that support a cost-benefit analysis.

* Guide the hybrid decisions that you need to make.

*One principle of monitoring is called full visibility:  for a service, asset or component to be fully visible, 1) in-depth or north-south, 2) end-to-end, in breadth or east-west, and for its health aspects (availability, performance, security and continuity).

Some key questions include:

* How will you shape security logs and secure their access back to security and new privacy controls?

* Which services will be globally available and as such, can be globally monitored at the service edge?

* What about Express Route and monitoring solutions that tells us when it’s us or the cloud provider?

* What are the boundaries of security operations vs. health and performance:  how can we provide summaries of health and status to security operations as well as the converse of this back to service owners?

To assemble this architecture, here are several considerations:

* Consider a data flow approach starting from service assets and going up the stack - metrics and log data emitted by infrastructure, IOT devices, mobile devices, etc. are all of the items under management—to-monitoring tools (mid-tier) moving upward and outward (ITSM tools, global monitoring, Security Information and Event Management (SIEM), custom alert enrichment, etc.).

* Consider whether to continue with Systems Center.

* Consider economic cost.

* Consider how the business will leverage logs and metrics. Azure monitoring brings a significant volume of log and time-series data to the performance and health side of monitoring, similar to what security operations experiences. After all, logs and metrics are the two major data components of Azure Monitor’s architecture. The reason why this is important is:

   1. Since you can build large scale complex cloud services, your problem management costs are reduced to analyze, correlate and determine causes of problems in one place reducing the need to access resources directly, thereby improving security. 
   
   2. Like a SIEM, Azure Monitor is consolidating machine data directly from on-premises assets as well as Azure resources (including activity logs, tenant, and subscription data, and any log data from a REST client), and provides a simple query language to provide data analysis far beyond what was possible before. What makes Azure Monitor unique is that although it handles machine level data very well, Azure Monitor gives you pre-defined queries, context-sensitive metrics based on resource type<sup>1</sup>.

Consider your data flows and tools:

* Sources and types (telemetric, traces, stateful, time series).

* Tools and suites (rows): (Columns: availability, capacity, security, continuity and compliance).

* The role of global monitoring or the top-tier.

* The role of IT service management integration to trigger on significant events.

Consider Alerting and Notifications. The following table is an example of incident management priority model to standardize events, significance, and alerting used for notifications.

|Alert severity |Incident priority high|Incident priority medium |Incident priority low|
|---------------|----------------------|-------------------------|---------------------|
|High |0|1|2|
|Medium |1|2|3|
|Low |2|3|4|

## Formulate initiatives

As a monitoring expert or systems administrator, you’ve discovered that cloud monitoring is faster and easier to establish, leading to inexpensive demos or proofs-of-value. To overcome the tendency to stay in demo mode, you need to stay in constant touch with strategy and be able to execute on production-focused monitoring plans. Because strategy has plenty of uncertainty and unknowns, you won’t know all of the monitoring requirements in advance. Therefore, decide on the first set of adoption plans, based on what is minimally viable to the business and IT management. You may call this a core capability - that which is needed to begin the journey. Here are two example initiatives that help declare forward motion:

* Initiative 1: “To reduce the diversity and complexity of our current monitoring investment, we will invest in establishing a core capability leveraging Azure Monitor first, given the same skills and readiness applies to other areas of cloud monitoring.” 

* Initiative 2: “To decide on how we leverage our license plans for identity, access, and overall Information protection, we will help the Security and Privacy offices establish early activity monitoring of users and content as they migrate to the cloud, to clarify questions on classification labels, data loss prevention, encryption and retention policies.”

## Consider scale

Consider scale in your strategy and who will be defining and standardizing “monitoring as code.” Your organization should plan to build standardized solutions using a combination of tools such as Azure Resource Manager templates, Azure Policy, establish a source control for the scripts, code, and documentation in support of the agile solution methods and tooling you’ll want.

## Consider privacy and security

In Azure you’ll need to secure certain monitoring data emitted by resources and the control plane actions that are logged in Azure, known as activity logs.  Additionally, specialized logs that record user activity such as the Azure Active Directory sign in log, and if integrated, the Microsoft 365 Unified Audit Log, contain sensitive data that must be protected under privacy law.

Your monitoring strategy should include these components:

* Separate non-monitoring data from monitoring data

* Restrict access to resources

## Consider business continuity

* Disaster Recovery

* Resilience e.g. Geo-Redundancy

## Consider maturity

Maturity is an important consideration in your strategy. You can start minimally, too. The first monitoring solutions you’ll want are those that ensure observability, to include responsive processes, such as Incident and Problem Management. Here, you will be creating one or more Log Analytics workspaces, enabling agents, and setting up initial alerts. Over time, you gain confidence in Azure Monitor capabilities with the need to measure health indicators, so this involves deepening the focus on the collection of logs, using Insights, metrics, and defining the log search queries that drive the measurement and calculation of what is healthy/unhealthy. Learning includes getting monitoring data and Insights into the hands of managers, ensuring the right consumers have monitoring data they need. Learning cycles include continual tuning and optimizing monitoring solutions to adapt, to improve service and inform adoption plans.

<Graphic Image>

Monitoring is foundational for services you build in Azure. Your strategy can address these four disciplines of modern monitoring, to help you define minimum viable product and gain confidence in steps.  Moving your capability from reactive to proactive and scaling its reach to end users is but one goal.

* Observe: First, you should focus on establishing monitoring to observe the health and status of Azure services and resources. Configure basic monitoring and then automate with Azure Policy and ARM templates, to establish initial visibility of services and their warranty:  availability, performance or capacity, security and configuration compliance. Based on minimum viable setup of Azure Monitor for example, configure resources for monitoring and diagnostics, set up alerts, logs and insights. Include knowledge and readiness of monitoring consumers, defining and triggering from events, for service work such as incidents and problems. One indicator of maturity is how much can be automated to reduce unnecessary human costs to manually observe health and status. Knowing which services are healthy is just as important as being alerted on services that are unhealthy.

* Measure: Configure collection of metrics and logs from all resources to monitor for symptoms/conditions that are issues which indicate potential or actual impact to the availability of the service or impact of the consumers of the service/application (i.e. when using a feature in the app, is it showing response time latency, returning an error when I selected something, or unresponsive). Ensure services are meeting service agreements and measuring the utility of the service or application—the features, data and time saving that brings business results.

* Respond: Whether we remediate, auto-correct, or manually respond to events and process incidents, problems, changes, etc. (event management).  (monitor/control loop).

* Learn and Improve: Providers and consumers participating in Learning cycles  Implies consuming actual monitoring data, insights, reports and workbooks to continually improve the target service and to enact tuning and optimization of the monitoring configuration.  Change is important too, that the monitoring configuration is changing in tandem with service change (New, modified, retired…) and continues to match the actual service warranty.

To help you align monitoring plans to strategy, use the following table to categorize the different monitoring scenarios that will occur in more detail and it works with the five Rs of rationalization introduced earlier in the Plan phase. If you are leveraging Systems Center Operations Manager, you have hybrid and cloud options available to rationalize your investment.

|Type |Monitoring objective |Example objective |
|-----|---------------------|------------------|
| 1 | Only on-premises | System Center Operations Manager. Continue to monitor services, infrastructure, networking up the application layer in owned data centers with no cloud considerations. |
| 2 | On-premises to the cloud | Continue using System Center Operations Manager, and apply the O365 and Azure management packs. |
| 3 | On-premises to/with cloud (cooperative) where services run in both the cloud and on-premises | Establish initial monitoring with Azure Monitor. Connect Azure Monitor to System Center Operations Manager and alert sources, such as Zabbix or Nagios. Deploy Azure Monitor monitoring agents with multi-homing where System Center Operations Manager and Azure Monitor monitor cooperatively.|
| 4 | Hybrid migration | Monitor the migration, for example, Exchange to O365 Exchange Online. Exchange Online Service Health and Service Usage, Security and Compliance – all from O365. Gradually decommission monitoring Exchange on-prem with System Center Operations Manager until migration complete. |
| 5 | Hybrid forever | System Center Operations Manager, Azure AD, Azure Monitor, Azure Security Center, Intune, – a range of tools for a mixture of digital assets e.g., workstations.|
| 6 | Cloud native |Azure Monitor, Azure Security Center, O365, service workspaces, Azure Service Health, Azure Resource Health – etc. |
| 7 | Multi-cloud owned tenants (consolidate) | Centralize the monitoring of many tenants.  Deploy Azure Monitor, SIEM, Cloud Access Security Brokers (CAS-B, SIEM). |
| 8 | Multi-cloud ecosystem |Centralize the monitoring of different cloud providers:  Microsoft, Amazon, Google, Salesforce, Palo Alto, etc. |
| 9 | Provider > Consumer | Monitoring solutions and services as a cloud provider. |

## Formulate monitoring requirements

Above, your strategy reveals there may be much to do in the long run.  Ultimately your mindset extends outside the datacenter into the workplace, to devices and end points, out to the identity-as-security boundary, independent of where.  The new edge defined with cloud monitoring is a strong motivator in contrast with a datacenter and workplace mindset.

You can leverage Azure now to include gradual monitoring of all or some aspects of your on-premises resources, as they may gradually move to the cloud.  And you also want strategy to define your monitoring boundaries of responsibility in alignment with the business’ cloud adoption strategy, based on the cloud service model your business adopts.  Even for services based on IaaS, you’ll get metrics, logs, views and alerting capabilities through Azure Service Health and here, you’ll configure alerts from availability monitoring of your Azure resources with Resource Health.  With SaaS services, such as Microsoft 365, much is already provided, and you need to configure appropriate access to portals, dashboards, analytics, and alerts.  From a service perspective, a large service with distributed components such as Microsoft 365 Exchange Online have a number of objectives, not just the need to observe its health and status.

| Primary objective | Goal and outcome |
|-------------------|------------------|
|Health and status monitoring |Holistically observe, measure, learn, and improve the long-term warranty of the service or component, including service levels, in these aspects taken together:  availability, capacity, performance, security, and compliance.  A healthy system, service or component is online, performing well, secure and compliant.  Health Monitoring includes logs and is stateful with real time health states and metrics.  It also includes trending reports, insights and trends focused on "service usage.” |
| Utility monitoring | Observe, measure, learn, and improve the quality or qualitative aspects of how a system delivers value.  User Experience is one type of monitoring use case. |
| Security monitoring | Observe, measure, learn, and improve protection in support of cybersecurity strategy and functions such as security operations, identity and access, information protection, privacy, threat management and compliance.  Monitor using Azure Security Center and Azure Sentinel, as well as Microsoft 365. |
| Cost monitoring | Monitor usage and estimate costs using Azure Monitor and Azure Cost Management as a new primary objective.  The Cost Management APIs provide the ability to explore cost and usage data using multi-dimensional analysis. |

| Tertiary objectives | Goal and outcome |
|---------------------|------------------|
| Activity monitoring | Observe, measure, learn and improve usage, security and compliance from sources such as Azure activity logs, audit logs, and the Microsoft 365 unified audit log for subscription level events, actions on resources, user and administrator activity, content, data, and for your security and compliance needs in Azure and Microsoft 365. |
| Service usage | Service Owners want analytics and insights to measure, learn, and improve the usage of Azure and Microsoft 365 services (IaaS, PaaS, SaaS) with service usage reports, analytics and insights.  Ensure plans include who will need access to the admin portals, dashboards, insights and reports. | 
| Service and resource health | Observe the health of your cloud resources, as well as service outages and advisories from Microsoft, to stay informed about incidents and maintenance.  Include Resource Health in monitoring of the availability of your resources and alert on changes in availability. |
| Capacity and performance monitoring | In support of Health monitoring, your needs may require more depth and specialization. |
| Change and compliance monitoring | Observe, measure, learn and improve configuration management of resources which should now include security in the formulation, influenced by good use of Azure policy to standardize monitoring configurations, Azure Automation to enforce security hardening and logs to filter on key changes being made on resources. |
| Identity and access monitoring | Observe, measure, learn, and improve both the usage and security of Active Directory, Azure Active Directory, and identity management that integrates users, applications, devices, and other resources no matter where they are. |
| Information protection | Not only Azure Monitor, but Azure Information Protection (AIP) depending on the Plan, includes usage analytics critical to your development of a robust Information Protection strategy across Azure and Microsoft. |
| Privacy monitoring | Organizations face expanding privacy needs to include information protection of the digital estate, data classification, and data loss prevention to mitigate risks to privacy breaches and infractions.  Microsoft 365 Information Protection includes monitoring capabilities that can also be integrated with Azure Monitor. |
| Threat management and integrated threat protection | The cloud brings together the separate, traditional roles of security monitoring with health monitoring. Integrated Threat Protection for example involves monitoring to accelerate an optimal state of Zero Trust. Integrating Azure Advanced Threat Protection allows a migration from SCOM Active Directory to integrate your AD signals and detect advanced attacks in hybrid environments. |

## Establish minimum governance

As early as possible, define a strategy to clearly establish who will have what level of access in Azure to support their role and responsibility, such as:

* Access to different features in the Azure portal

* Ability to configure and manage policies

* Enable, deploy, configure Azure resources such as Log Analytics workspace(s), Azure Monitor agents, Azure Security Center, etc. 

* Access to view monitoring data submitted from resources scoped to a subset of resources in a resource group, across a resource group, across a subscription, etc.

* Govern the development and release of monitoring configurations

It is important to understand what each role will perform in order to build, maintain, and improve monitoring solutions in order plan an access control strategy and grant only the necessary rights they require to successfully perform their role.  A higher-level administrator, such as Global Admins, may establish policies for privileged delegation, both in Azure AD directory roles and in Azure with Azure role-based access control (RBAC).  You may want your System Administrators to be able to modify settings, add alerts, and set up report workspaces.  

First, identify the roles who will own and manage resource groups in Azure as part of your governance framework:

* Whether a Monitoring Team or one or more Administrators of Resources and Groups will have privileged access to the Monitoring Contributor role.

* The consumers who should be given the Monitoring Reader role, which enables access to features in Azure Monitor, as well as investigate issues within the Monitoring section that is included with each Azure resource.

* What managers require access to other Azure Reader roles such as Reports Reader.

Include security: Be sure to work with the Identity Management team to decide on recommendations for privileged identities and privileged access:

* Obtaining separate privileged user accounts in Azure Active Directory.

* Applying privileged accounts in groups, in Azure AD and in Azure ARM privileged directory roles.

* Security monitoring of privileged access in Azure Monitor and activity logs; establish readiness.

## Establish readiness

Early on, formulate a readiness plan to help your IT staff adopt new skills, practices, and techniques for cloud monitoring in Azure.  Consider, in this strategy that should include foundational needs as well as those specific to monitoring:

* The level of confidence needed with Azure’s services, architecture, and the control plane

* New kinds of automation technology, for example Azure Resource Manager templates, Automation runbook, Azure Logic Apps, Azure PowerShell, etc.

* Agile and DevOps practices to better manage monitoring code, such as ARM templates, PowerShell scripts used to install agents and Azure Policy code fragments used for monitoring.
