---
title: What's new in the Microsoft Cloud Adoption Framework
description: Learn about recent updates to the Microsoft Cloud Adoption Framework for Azure.
author: JanetCThomas
ms.author: janet
ms.date: 01/13/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

# What's new in the Microsoft Cloud Adoption Framework for Azure

Here are the recent changes we've made to the Cloud Adoption Framework.

This framework is collaboratively built with customers, partners, and internal Microsoft teams. We release new and updated content as it becomes available. New releases enable you to test, validate, and refine this guidance along with us.

Partner with us in our ongoing effort to develop the Cloud Adoption Framework.

## March 2022

### Low-code application platform guidance
This update provides guidance to help you prepare for adoption of low-code development. We've added content that includes best practices for adopting and securing Power Platform.

- [Power Platform adoption best practices](/power-platform/guidance/adoption/methodology?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Power Apps overview](/powerapps/powerapps-overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Power Automate workflows](/power-automate/getting-started?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Automate tasks with robotic process automation](/power-automate/desktop-flows/introduction?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Intelligent low-code apps](/ai-builder/overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json&branch=main)
- [Securing Power Platform](/power-platform/admin/security/overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)

This is the first set of content in our plan to include Power Platform in the Cloud Adoption Framework.

### Independent software vendor (ISV) considerations for Azure landing zones

The new [ISV considerations for Azure landing zones](../ready/landing-zone/isv-landing-zone.md) article describe how to build an Azure environment with multiple subscriptions. Each landing zone accounts for scale, security, governance, networking, and identity, and is based on feedback and lessons learned from many customers.

## February 2022

### New videos added to the Cloud Adoption Framework security topics

These videos can help you understand how security plays a part in your cloud adoption journey.

| Article | Description of video |
|--|--|
| [Security in the Microsoft Cloud Adoption Framework for Azure](../secure/index.md) | Watch the video to learn about the Secure methodology and how it helps guide continuing security improvements over time. |
| [Risk management insights](../secure/risk-insights.md) | Watch the video to learn about security alignment and how you can manage risk within your organization. |
| [Security integration](../secure/security-integration.md) | Watch the video to learn about integrating security across all areas of your business. |
| [Business resilience](../secure/business-resilience.md) | Watch the video to learn how to build and maintain your business's resilience to security attacks. |
| [Access control](../secure/access-control.md) | Watch the video to learn how you can develop an access control strategy that meets your specific needs. |
| [Security operations](../secure/security-operations.md) | Watch the video to learn about SecOps and its critical role in reducing risk for your organization. |
| [Asset protection](../secure/asset-protection.md) | Watch the video to learn about the history of asset protection and how to keep both old and new assets secure. |
| [Security governance](../secure/security-governance.md) | Watch the video to learn about security governance. |
| [Innovation security](../secure/innovation-security.md) | Watch the video to learn about the DevSecOps method for secure and rapid innovation. |

## January 2022

### Unified management and operations with Azure Arc-enabled servers landing zone accelerator

This release of the Cloud Adoption Framework provides considerations to help you prepare for an enterprise-scale deployment of Azure Arc-enabled servers.

This scenario focuses on enabling a few targeted outcomes:

- Mature your hybrid practices with Azure Arc-enabled servers management and operations.
- Establish appropriate Azure Arc-enabled servers governance across all on-premises and multicloud assets to move forward with confidence.
- Minimize technical debt by considering well-architected principles across all Azure Arc-enabled servers workloads.
- Automate all three of the above with the codebase for Azure Arc-enabled servers landing zone accelerator.
- Quickly access skilling resources in documentation or learning modules for the various Azure services required across this scenario.

Get started with this scenario using the following links:

| Article | Description |
|--|--|
| [Identity and access management](../scenarios/hybrid/arc-enabled-servers/eslz-identity-and-access-management.md) | Best practices for right access controls design to secure hybrid resources as they are centrally managed from Azure using Azure Arc. |
| [Network topology and connectivity](../scenarios/hybrid/arc-enabled-servers/eslz-arc-servers-connectivity.md) | Design considerations when working with Azure Arc-enabled servers and how to securely connect them to your Enterprise Scale Landing Zone. |
| [Resource organization](../scenarios/hybrid/arc-enabled-servers/eslz-resource-organization.md) | Best practices for resource consistency and tagging strategy, that includes your hybrid and multicloud resources. |
| [Governance and security disciplines](../scenarios/hybrid/arc-enabled-servers/eslz-security-governance-and-compliance.md) | The [Cloud Adoption Framework's Enterprise Scale Landing Zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/) includes patterns for standardizing the deployment of [Azure Policy](/azure/governance/policy/overview) and [role-based access controls (RBAC)](../ready/azure-setup-guide/manage-access.md) through structured use of management groups to segment resources into logical groupings. These patterns can be extended using technologies such as Azure Arc. |
| [Management disciplines](../scenarios/hybrid/arc-enabled-servers/eslz-management-and-monitoring-arc-server.md) | Similar to governance techniques, Azure Management services can also be extended out to other environments, such as on-premises and other cloud platforms through Azure Arc. Enterprise Scale provides guidance on how operationally maintain Azure Arc-enabled servers on Azure enterprise estate, with centralized management and monitoring at the platform level. |
| [Automation disciplines](../scenarios/hybrid/arc-enabled-servers/eslz-automation-arc-server.md) | Azure Arc enables organizations to manage their digital state hosted outside of Azure with the same level of experience and automation as a native Azure resource. As part of your Enterprise Scale Landing Zone implementation you should plan for agent onboarding, lifecycle management, and expansion of the Azure control plane capabilities via Azure Arc with as much automation as possible. |
| [Cost governance](../scenarios/hybrid/arc-enabled-servers/eslz-cost-governance.md) | Keep track of ungoverned and unmonitored resources that prevent you from to increase accountability with budgets, cost allocation, and chargebacks. |
| [Start with Azure Arc-enabled servers landing zone accelerator sandbox](../scenarios/hybrid/arc-enabled-servers/enterprise-scale-landing-zone-sandbox.md) | Get started with a fully automated Azure Arc-enabled servers sandbox deployment. |
| [Introduction to Azure Arc-enabled servers landing zone accelerator for hybrid](../scenarios/hybrid/enterprise-scale-landing-zone.md) | Learn how to accelerate adoption of hybrid or multicloud architectures. |

### Launch of Cloud Adoption Strategy Evaluator in the Microsoft Cloud Adoption Framework

We've launched the [Cloud Adoption Strategy Evaluator](/assessments/?id=8fefc6d5-97ac-42b3-8e97-d82701e55bab&mode=pre-assessment), a new assessment built around the principles of cloud economics—which evaluates your cloud adoption strategy, and provides recommendations to help build a robust business case that supports your organization's unique cloud journey.

## December 2021

### Updates to Azure landing zone content in the Ready methodology

We've refined the flow for finding the right landing zone implementation, and have added additional content for all design areas.

We've consolidated guidance into a comprehensive set across environment and compliance design areas, making it easier to find the right information. We've created a clearer flow for organizations to work through during the design phase, before deploying a landing zone. Read more about [Azure landing zone design areas](../ready/landing-zone/design-areas.md).

Finally, we've added an example alignment scenario to the Align on-ramp: [Scenario: Transition existing Azure environments to the Azure landing zone conceptual architecture](../ready/landing-zone/align-scenarios.md).

## October 2021

### Microsoft Azure VMware Solution scenario

This release of the Cloud Adoption Framework provides considerations for [migrating VMware resources from on-premises datacenters to dedicated Azure cloud environments](../scenarios/azure-vmware/index.md).

This scenario focuses on enabling specific, targeted outcomes to:

- Accelerate migration and lower your TCO, reducing the time and complexity of migrating your existing VMware workloads to Azure, as well as maintaining operational consistency, avoiding downtime with live bulk virtual machine migration.

- Gain reliability and scale with automated provisioning for your VMware workloads on global Azure infrastructure.

- Optimize your licensing costs on Azure with price benefits for Windows and SQL Server.

- Modernize your applications running on VMware through integration with Azure-native management, security, and services.

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

The critical design area of [network topology and connectivity](../ready/azure-best-practices/define-an-azure-network-topology.md) includes new articles that simplify rationalizing individual components of your network design. Those design aspects now include guidance on [connecting to multicloud providers](../ready/azure-best-practices/connectivity-to-other-providers.md) like Oracle Cloud Infrastructure. We've also released the new enterprise-scale Terraform module to demonstrate Microsoft's continued investment in open-source approaches to Azure landing zone configuration. Lastly, we've updated guidance on how enterprises can [optimize management groups and organize subscriptions](../ready/landing-zone/design-area/resource-org.md) in Azure to meet cloud governance requirements.

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

<!-- docutune:ignoreNextStep -->


*******************test commit***************