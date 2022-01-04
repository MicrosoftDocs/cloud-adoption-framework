---
title: What's new in the Microsoft Cloud Adoption Framework
description: Learn about recent updates to the Microsoft Cloud Adoption Framework for Azure.
author: JanetCThomas
ms.author: janet
ms.date: 01/03/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

# What's new in the Microsoft Cloud Adoption Framework for Azure

Here's a list of recent changes we've made to the Cloud Adoption Framework.

This Framework is collaboratively built with customers, partners, and internal Microsoft teams. We release new and updated content as it becomes available. New releases enable you to test, validate, and refine the Framework's guidance along with us.

Partner with us in our ongoing effort to develop the Cloud Adoption Framework.

## December 2021

### Updates to Azure landing zone content in the Ready methodology

We've refined decisions for each landing zone implementation option, and have added pointed guidance for each design area.

- We've clarified implementation decisions necessary within design areas—and have added expanded guidance in articles addressing:
  - [Plan for the Cloud Solution Provider service](../ready/landing-zone/design-area/azure-billing-cloud-solution-provider.md) and [Define Azure AD tenants](../ready/landing-zone/design-area/azure-ad-define.md) (Azure billing and Active Directory tenant),
  - [Identity and access management foundation](../ready/landing-zone/design-area/identity-access.md) (Identity and access management),
  - [Plan for IP addressing](../ready/azure-best-practices/plan-for-ip-addressing.md) (Network topology and connectivity),
  - [Management groups](../ready/landing-zone/design-area/resource-org-management-groups.md) design considerations and subscription considerations (Resource organization),
  - [Encryption and key management in Azure](../ready/landing-zone/design-area/encryption-and-keys.md) and [Service enablement framework](../ready/landing-zone/design-area/service-enablement-framework.md) (Security),
  - [Inventory and visibility considerations](../ready/landing-zone/design-area/management-platform.md), [Business continuity and disaster recovery](../ready/landing-zone/design-area/management-business-continuity-disaster-recovery.md), [Operational compliance considerations](../ready/landing-zone/design-area/management-operational-compliance.md), and [Workload management and monitoring](../ready/landing-zone/design-area/management-workloads.md) (Management),
  - [Design area: Azure governance](../ready/landing-zone/design-area/governance.md) (Governance),
  - [Design area: Platform automation and DevOps](../ready/landing-zone/design-area/platform-automation-devops.md) (Platform automation and DevOps).

Finally, we've added an example alignment scenario to the Align on-ramp—Transitioning existing Azure environments to the Azure landing zone conceptual architecture.

## October 2021

### Microsoft Azure VMware Solution scenario

This release of the Cloud Adoption Framework provides considerations for [migrating VMware resources from on-premises datacenters to dedicated Azure cloud environments](../scenarios/azure-vmware/index.md).

This scenario focuses on enabling specific, targeted outcomes to:

- Accelerate migration and lower your TCO, reducing the time and complexity of migrating your existing VMware workloads to Azure—and maintain operational consistency, avoiding downtime with live bulk virtual machine migration.

- Gain reliability and scale with automated provisioning for your VMware workloads on global Azure infrastructure.

- Optimize your licensing costs on Azure with price benefits for Windows and SQL Server.

- Modernize your applications running on VMware—through integration with Azure-native management, security, and services.

- Deploy unified hybrid management and operational controls with Azure Arc-enabled servers across Azure, VMware, and other cloud infrastructures.

## August 2021

### Data management and analytics scenario

This release of the Cloud Adoption Framework provides considerations to help you prepare for [data management and analytics in the cloud](../scenarios/data-management/index.md).

This scenario focuses on enabling a few targeted outcomes:

- Mature your analytics, AI and machine learning, and IoT capabilities in the cloud.
- Establish appropriate data governance across all data initiatives to move forward with confidence.
- Minimize technical debt by considering well-architected principles across all data workloads.
- Automate all three of the above with the codebase for enterprise-scale for analytics.
- Quickly access skilling resources in documentation or learning modules for the various Azure services required across this scenario.

Get started with this scenario using the following links:

| Article | Description |
|--|--|
| [Introduction to the data management and analytics scenario](../scenarios/data-management/index.md) | In this article we introduce the principles of the data management and analytics scenario.|
| [Data governance](../scenarios/data-management/overview-data-governance.md) | This guidance reviews how data governance ensures data that's used by your business is discoverable, accurate, trusted, and can be protected. |
| [Build an initial strategy](../scenarios/data-management/strategy.md) | In this article, review considerations for data management and analytics that will have an impact on your cloud adoption strategy.
| [Define a plan](../scenarios/data-management/plan.md) | Establish a clear plan for rationalizing data, skilling people, and tips for ensuring success.
| [Azure landing zones for data management and analytics](../scenarios/data-management/ready.md) | This guidance provides an overview of the data management landing zone. A data management landing zone is responsible for the governance of the platform and enables communication to ingest data sources from Azure, third-party clouds, and on-premises.
| [Enterprise-scale for analytics](../scenarios/data-management/enterprise-scale-landing-zone.md) | Automation to accelerate realization of this scenario.
| [Govern your data estate](../scenarios/data-management/govern.md) | This article reviews a data governance solution to surround the specific data entities and data subject areas with people, processes, policies, and technology.
| [Secure your data estate](../scenarios/data-management/secure.md) | Best practices to improve security of your entire data estate.
| [Organize people and teams](../scenarios/data-management/organize.md) |Learn about how to organize data operations team members for the data management and analytics scenario in Azure.
| [Azure Well-Architected Framework for data workloads](../scenarios/data-management/well-architected-framework.md) | In this article, we review how you can apply principals of the Azure Well-Architected Framework, to each of the data workloads within your data estate to minimize technical debt from the beginning.

### Strategic Migration Assessment and Readiness Tool (SMART)

We've added an article to help you use the [Strategic Migration Assessment and Readiness Tool (SMART)](../plan/smart-assessment.md). This assessment can help you find out what you need to do to prepare for your Azure migration.

## July 2021

This release of the Cloud Adoption Framework includes updates to the Azure landing zone content in the Ready methodology.

- [What is a landing zone?](../ready/landing-zone/index.md) now includes a conceptual architecture and Azure landing zone accelerator, intended to help customers plan their cloud environments and begin best practice implementation quickly and easily.
- [Journey to the target architecture](../ready/landing-zone/landing-zone-journey.md) includes new content that helps organizations determine which guidance is best suited to their current position on their cloud journey.
- Updated the [Azure landing zone design areas](../ready/landing-zone/design-areas.md) to help distinguish between considerations for implementation and considerations for operating a landing zone

## June 2021

We've added a new retail industry scenario in this release, designed to guide a retail company's cloud adoption journey from beginning to end.

| Article | Description |
|--|--|
| [Retail industry scenario](../industry/retail/index.md) | Review a summary of the retail scenario components, common challenges, and supporting guidance. |
| [Cloud adoption strategy for the retail industry](../industry/retail/strategy.md) | Learn about how the priorities of retailers are shifting, and the strategic impact of cloud adoption for the retail industry. |
| [Cloud adoption plan for the retail industry](../industry/retail/plan.md) | Use this guidance to develop a refined cloud adoption plan for the retail industry. |
| [Innovation in the retail industry](../industry/retail/innovate.md) | Learn how to innovate even faster and improve your retail outcomes by using the steps outlined in the Innovate methodology. |
| [Governance in the retail industry](../industry/retail/govern.md) | Use the Cloud Adoption Framework methodology to systematically and incrementally improve governance of your cloud portfolio across the five governance disciplines. This article refines the methodology for governance needs specific to the retail industry. |
| [Management in the retail industry](../industry/retail/manage.md) | Learn how to use the Manage methodology in the Cloud Adoption Framework for Azure to manage the cloud for the retail industry. |

## May 2021

### Cloud Adoption Framework Secure methodology

This release of the Cloud Adoption Framework introduces the new Secure methodology, which will centralize the theme of security best practices and provide end-to-end guidance for customers looking to adopt Microsoft guidance for their cloud environments. Security concerns have surged to the forefront of many top priorities lists recently, building on feedback requesting a more security-centric view, the [Secure methodology](../secure/index.md) will assist in defining the security aspect of the cloud journey.

### Azure Virtual Desktop adoption journey

As part of the ongoing series of adoption journeys, this release includes expanded guidance for [integrating Azure Virtual Desktop (formerly Windows Virtual Desktop) into your cloud adoption journey](../scenarios/wvd/index.md). This rich guidance shows how each methodology in the Cloud Adoption Framework helps provide structure and best practices to your implementation approach.

### Cloud economics updates

This release continues the refresh of the [Strategy methodology](../strategy/index.md) by integrating Microsoft's [cloud economics program](https://azure.microsoft.com/overview/cloud-economics/).

We've added new content that includes the financial and technical considerations to keep in mind as you develop your business case.

- [Financial considerations](../strategy/financial-considerations/index.md)
- [Technical considerations](../strategy/technical-considerations/index.md)
- [Build a digital transformation timeline](../strategy/digital-transformation-timeline.md)
- [Create a business case](../strategy/cloud-migration-business-case.md)
- [Share your strategy](../strategy/share-your-strategy.md)

### Modern application platform

We expanded and revised the modern application platform content in this release. Commonly, customers need to provide their developers with a consistent application platform. This article series outlines how you can use orchestrated containers to manage pools of workloads in one or more centralized clusters, thus providing that consistent application platform. The articles in this series for [modern application platform](../scenarios/aks/index.md) combine technical and non-technical considerations required to prepare for Kubernetes and container integration into centralized operations and your broader cloud strategy.

## April 2021

### Cloud service controls

To help you implement cloud governance at a pace that sustains a high level of innovation, and implements the right level of control for your environment, we've added a new article, [Implement cloud service controls](../govern/cloud-service-controls.md). It focuses on a proven process to help governance teams implement granular controls across the Azure platform, while accelerating the development capabilities for cloud adoption teams. The process can be implemented by enterprises of any size, at any stage of their cloud journey. This guidance outlines the different stages of the process, from taking the enterprise requirements for cloud control for security, operations, and cost management, through the stages of development and release of controls.

### Azure Storage migration overview

To help you plan your Azure Storage migration, we've provided guidance in a new article, [Azure Storage migration overview](/azure/storage/common/storage-migration-overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json), for two migration scenarios:

- Migration of unstructured data, such as files and objects.
- Migration of block-based devices, such as disks and storage area networks.

## March 2021

This release is the largest update of the framework yet, adding a number of new broad-reaching collections of guidance that span across the entire framework.

### Adoption journeys

Most notable in this release is the addition of adoption journeys, which provide a short, consumable overlay or lenses that rest on top of the deeper framework to accelerate engagement. These shorter guides demonstrate how to apply the guidance in the Cloud Adoption Framework, the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/), the [Azure Architecture Center](/azure/architecture/), [Microsoft Learn](/learn/), and other [Microsoft documentation](/) to the adoption of specific technology platforms. The following table provides links to the overview page for each of the new journeys:

| Journey | Description |
|--|--|
| [Hybrid&nbsp;and&nbsp;multicloud](../scenarios/hybrid/index.md) | Lifecycle guide to integrate hybrid, multicloud, and unified operations into your cloud adoption journey. |
| [Modern containers](../scenarios/aks/index.md) | Container modernization enables rapid innovation and workload portability. Learn how to integrate containers into your cloud adoption journey. |
| [SAP on Azure](../scenarios/sap/index.md) | As part of our One Migrate (migration scenarios) commitment, this journey bridges the gaps between the SAP migration process and other mainstream migration processes to deliver on full-scale adoption of SAP on Azure. |

### Cloud economics

Building on feedback and lessons learned, this is our first step to refresh the [Strategy methodology](../strategy/index.md) by integrating Microsoft's [cloud economics program](https://azure.microsoft.com/overview/cloud-economics/).

We've updated the introduction to each category of business outcomes with references to case studies on cloud economics, demonstrating how organizations achieve the related business objective. The refreshed introductions with illustrative case studies include:

- [Fiscal outcomes](../strategy/business-outcomes/fiscal-outcomes.md)
- [Agility outcomes](../strategy/business-outcomes/agility-outcomes.md)
- [Global reach outcomes](../strategy/business-outcomes/reach-outcomes.md)
- [Customer engagement outcomes](../strategy/business-outcomes/engagement-outcomes.md)
- [Performance outcomes](../strategy/business-outcomes/performance-outcomes.md)
- [Sustainability goals](../strategy/business-outcomes/sustainability.md)

### Enterprise-scale updates

The critical design area of [network topology and connectivity](../ready/azure-best-practices/define-an-azure-network-topology.md) includes new articles that simplify rationalizing individual components of your network design. Those design aspects now include guidance on [connecting to multicloud providers](../ready/azure-best-practices/connectivity-to-other-providers.md) like Oracle Cloud Infrastructure. We've also released the new enterprise-scale Terraform module to demonstrate Microsoft's continued investment in open-source approaches to Azure landing zone configuration. Lastly, we've updated guidance on how enterprises can [optimize management groups and organize subscriptions](../ready/enterprise-scale/management-group-and-subscription-organization.md) in Azure to meet cloud governance requirements.

### Antipatterns

Companies often miss important steps in their cloud adoption journey. The new [cloud adoption antipatterns](../antipatterns/antipatterns-to-avoid.md) guidance highlights common customer pain points, what skipped step led to that pain, and the fastest path to recovery. The antipatterns are distributed throughout each methodology, but a top 10 list is available in the getting started section of the framework.

### AI + machine learning

When planning an Azure Machine Learning deployment for an enterprise environment, there are common decision points that affect how you create the workspaces. We've published a new article, [Organize and set up Azure Machine Learning environments](../ready/azure-best-practices/ai-machine-learning-resource-organization.md), that highlights these decision areas and the benefits of each:

- **Team structure:** How your machine learning teams are organized and collaborate on a project's given use case and data segregation, or cost management requirements.
- **Environments:** The environments used as part of your development and release workflow to segregate development from production.
- **Region:** The location of your data and the intended audience for your machine learning solution.

We added a reference implementation example to help illustrate the deployment of Azure Machine Learning in a larger setting. It outlines how the organization 'Contoso' set up Azure Machine Learning given their organizational constraints, reporting, and budgeting requirements.

## January 2021

To help you accelerate adoption and innovation, we've added new information about using GitHub and updated best practices for machine learning. We've published a new article and video to help you choose the best landing zone.

| Article | Description |
|--|--|
| [How&nbsp;GitHub&nbsp;accelerates&nbsp;cloud&nbsp;adoption](../scenarios/github-velocity/index.md) | This article outlines the benefits of using GitHub to accelerate cloud adoption by taking advantage of open-source assets, collaborative development environments, automation and security features. |
| [Best practices for machine learning](../innovate/best-practices/machine-learning.md) | We've updated and expanded the best practice guidance for machine learning. Included in the best practices are: <br><br> <li> [How to approach machine learning operations](../innovate/best-practices/how-to-approach-mlops.md) and the [MLOps process](../innovate/best-practices/mlops-process.md) <li> [Machine learning security](../innovate/best-practices/ml-security.md) <li> [Machine learning inference and deployment](../innovate/best-practices/ml-deployment-inference.md) <li> [Determine compute instances for your model](../innovate/best-practices/dev-train-comp-instances-for-ml.md) <li> [Set up machine learning workspaces](../innovate/best-practices/set-up-ml-workspaces.md) <li> [Responsible and trusted AI](../innovate/best-practices/trusted-ai.md) |
| [Choose&nbsp;a&nbsp;landing&nbsp;zone&nbsp;option](../ready/landing-zone/choose-landing-zone-option.md) | Microsoft offers two implementation options for landing zones: *Start small and expand* and *Enterprise-scale*. Use this new article to review both options and choose the right approach for your organization. |

## December 2020

We've revised the naming and tagging strategy guidance, as well as adding guidance for Moodle migration scenarios.

| Article | Description |
|--|--|
| [Develop&nbsp;your&nbsp;naming&nbsp;and&nbsp;tagging&nbsp;strategy for Azure resources](../ready/azure-best-practices/naming-and-tagging.md) | We've refined the guidance for defining your naming and tagging strategy. In addition to the overview, we've separated this guidance into multiple articles that cover these topics: <br><br> <li> [Define your naming convention](../ready/azure-best-practices/resource-naming.md) <li> [Recommended abbreviations for various Azure resource types](../ready/azure-best-practices/resource-abbreviations.md) <li> [Define your tagging strategy](../ready/azure-best-practices/resource-tagging.md) |
| [Migrate a Moodle deployment to Azure](../scenarios/lamp/moodle/migration-overview.md) | Learn how to migrate a deployment of the Moodle open-source learning management system from an on-premises environment to Azure. Steps are provided for using either the Azure portal or the Azure CLI for your deployment. |

## October 2020

This month's updates include incremental improvements throughout the Cloud Adoption Framework and supporting web assets.

Our biggest investments have focused on building out Microsoft Learn modules to accelerate application of the Cloud Adoption Framework. This month, we released the modules listed below. Note that the Getting Started module provides our first guidance aligned with an industry vertical, by introducing a retail customer (Tailwind Traders) who we will follow through all of the core methodology modules to follow.

| Module | Description |
|--|--|
| [Overview module](/learn/modules/microsoft-cloud-adoption-framework-for-azure/) | Entry-level introduction to the framework. |
| [Getting Started module](/learn/modules/cloud-adoption-framework-getting-started/) | Introduction to the getting started guides to accelerate application of the proper methodologies for overcoming specific blockers. |
| [Azure landing zones](/learn/modules/cloud-adoption-framework-ready/) | Before building out your cloud environment, understand your operating requirements and choose the most appropriate Azure landing zone product to get you started. |
| [Create an enterprise-scale architecture](/learn/paths/enterprise-scale-architecture/) | Create landing zones at scale following a set of enterprise-scale design principles, reference architectures, and reference implementations. Four modules to create a single learning path to success. |

We've also expanded the business outcomes to share a number of common business motivations and approaches that continue to emerge in the post-COVID marketplace.

| Article | Description |
|--|--|
| [Examples of sustainability outcomes](../strategy/business-outcomes/sustainability.md) | Learn how cloud computing can help you reduce carbon emissions, use resources more efficiently, and shrink your environmental footprint. |
| [Measure business outcomes with objectives and key results (OKRs)](../strategy/business-outcomes/okr.md) | Learn how to use OKRs to measure business outcomes. |
| [Measure business outcomes with AppDynamics](../digital-estate/app-dynamics.md) | Understanding an application's performance and user experience is key to measuring business outcomes. See how AppDynamics can provide business insights for most use cases. |
| [Cost management update: Spot VMs](../govern/cost-management/best-practices.md#best-practice-reduce-nonproduction-costs) | Use of Spot VMs in nonproduction environments is a rapidly emerging practice to further reduce costs in those environments.existing environments. "I already have a working environment. How can I apply the design principles of enterprise-scale?" The new article on transitioning to enterprise-scale can help. |

| Article | Description |
|--|--|
| [Transition existing Azure environments to enterprise-scale](../ready/enterprise-scale/transition.md) | This article helps organizations to navigate the right path based on an existing Azure environment transitioning into enterprise-scale. |
| [Cloud Adoption Framework enterprise-scale landing zone architecture](../ready/enterprise-scale/architecture.md) | This article was updated to include a high-level diagram for an enterprise-scale landing zone architecture based on the hub and spoke network topology, and updates to describe and cross-reference the critical design areas for an enterprise-scale landing zone architecture. |

## August 25, 2020

This release provides better definition and decision criteria regarding landing zone implementations.

### Operating model

One of the most important considerations in landing zone design and implementation is your operating model. How you want to operate in the cloud will have a direct impact on the architecture and controls to implement. The following articles will help align your target operating model with a few models that are common in the cloud. Then map those to the most appropriate implementation to get started.

| Article | Description |
|--|--|
| [Compare common operating models](../operating-model/compare.md) | This article is the primary guide for comparing operating models and choosing a course of action. |
| [Understand cloud operating models](../operating-model/index.md) | Primer for making import decisions regarding your operating model. |
| [Define your operating model with CAF](../operating-model/define.md) | The Cloud Adoption Framework is an incremental guide to building out your environment and adopting the cloud within your chosen operating model. This article creates a frame of reference to understand how the various methodologies support the development of your operating model. |
| [Terms](../operating-model/terms.md) | Terms that are likely to come up when discussing your operating model with counterparts. These terms are not as commonly used by architects or technical specialists, but will prove important in those conversations. |

### Azure landing zones: Additional implementation options

The concept and implementations options behind Azure landing zones was built alongside the leading Microsoft partners. This release recognizes the existing intellectual property (IP) that those partners use to accelerate cloud adoption.

| Article | Description |
|--|--|
| [Partner landing zones](../ready/landing-zone/partner-landing-zone.md) | Review and compare Azure landing zone offers from your partner. |
| [Implementation options](../ready/landing-zone/implementation-options.md) | Updated to add partner landing zone options to the existing Azure landing zone implementation options. |
| [Enterprise-scale reference implementations](../ready/enterprise-scale/implementation.md) | Updated to add a hub-spoke reference implementation to enterprise-scale reference implementations. |

> [!NOTE]
> The new partner landing zone articles don't specify how a partner should define or implement a landing zone. Instead, it's designed to add structure to a complex conversation, so you can better understand the partner offer. This list of questions and minimum evaluation criteria can also be used to compare offers from potential partners. It's also being used by some partners to more clearly communicate the value of their Azure landing zone implementation options.

## July 17, 2020

This release adds a number of new scenarios to make cloud adoption more actionable.

**Migration scenarios:**

The new [migration scenarios overview page](../scenarios/index.md) builds on the Migrate methodology to demonstrate how Azure delivers on the One Migrate promise. It provides approaches to migrating multiple first and third-party scenarios to Azure. This includes new migration scenarios:

| Article | Description |
|--|--|
| [Azure Virtual Desktop](../scenarios/wvd/index.md) | This scenario enables productivity boosts and accelerates the migration of various workloads to support the end-user experience. |
| [Azure Stack](../scenarios/azure-stack/index.md) | Learn about deploying Azure in your datacenter using Azure Stack Hub. |

**Analytics in the Cloud Adoption Framework:**

Analytics solutions are now included in the Microsoft Cloud Adoption Framework. These new topics highlight best practices for enabling analytics solutions during your cloud adoption journey.

| Article | Description |
|--|--|
| [Analytics solution for Teradata, Netezza, Exadata](../migrate/azure-best-practices/analytics/analytics-solutions-overview.md) | Learn about migrating legacy on-premises environments including Teradata, Netezza, and Exadata to modern analytics solutions. |
| [High availability for Azure Synapse](../migrate/azure-best-practices/analytics/azure-synapse.md) | Learn about one of the key benefits of a modern cloud-based infrastructure, built-in high availability and disaster recovery. |
| [Schema migration data definition languages (DDL)](../migrate/azure-best-practices/analytics/schema-migration-ddl.md) | Learn about the database objects and associated processes when preparing to migrate existing data. |

**AI in the Cloud Adoption Framework:**

AI solutions and best practices are now integrated into the Microsoft Cloud Adoption Framework. These AI solutions can help accelerate innovation with predictions about customer's needs, automate business processes, discover information, find new ways to engage with customers, and deliver better experiences during your cloud adoption journey.

| Article | Description |
|--|--|
| [Responsible AI](../strategy/responsible-ai.md) | Learn about the AI principles you should consider when implementing AI solutions and learn how to establish a responsible AI strategy. |
| [Azure innovation guide: Innovate with AI](../innovate/innovation-guide/predict.md) | Learn about how you can innovate with AI and find the best solution based on your implementation needs. |
| [AI in the Cloud Adoption Framework](../innovate/ai/index.md) | Review a prescriptive framework that includes the tools, programs, and content (best practices, configuration templates, and architecture guidance) to simplify adoption of AI and cloud-native practices at scale. |
| [MLOps with Azure Machine Learning](../manage/mlops-machine-learning.md) | Learn about machine learning operations (MLOps) best practices. |
| [Innovate with AI](../innovate/best-practices/predict.md) | Learn about AI solutions (machine learning, AI applications and agents, knowledge mining) and best practices that can accelerate digital invention. |

<!-- docutune:ignoreNextStep -->
