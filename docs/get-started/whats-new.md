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

## June 2022

### Security best practices for infrastructure and development

Security best practices for infrastructure and development is comprehensive guidance for the full cloud security development lifecycle across strategy, architecture, implementation, operations, and governance. These best practices complement the Microsoft Cloud Adoption Framework for Azure, Microsoft tools, security guides, and technical documentation with a focus on infrastructure and development. They also align with the Azure Security Benchmark recommendations.

Each topic provides top-level basic guidance, followed by recommended tools, materials, and a recommended best practice approach.

| Article | Description |
|--|--|
|[Infrastructure and development security best practices](../secure/best-practices/file.md#section-name) |This module includes infrastructure and development security best practices  to help improve the security of your organization's workloads, data, and services on Azure. We present guidance in two sections covering infrastructure security and development security. Both sections cover the full lifecycle of strategy, architecture, implementation, operations, and governance. This guidance supplements Microsoft tools and security guides including the Microsoft Cloud Adoption Framework for Azure, Azure Security Benchmark (ASB), and other supporting technical documentation. |
| [Infrastructure security best practices](../secure/best-practices/file.md#section-name) |This section outlines the interrelationship of development security's dependency on infrastructure security, with a continuous improvement approach that progresses towards a "north star" end state across security strategy, architecture, implementation, and operations. |
| [Infrastructure security strategy](../secure/best-practices/file.md#section-name) | This section addresses how to reduce business risk from attacks and build in confidentiality, integrity, and availability assurances into all information systems and data. |
| [Infrastructure security architecture](../secure/best-practices/file.md#section-name) | This section describes best practices related to the ideal end state and key components of infrastructure security, including Azure landing zones, Zero Trust principles, and additional Azure Security Benchmark security recommendations. |
| [Infrastructure security implementation, operations, and governance](../secure/best-practices/file.md#section-name) | This section covers strategies across implementation, operations, and governance security, including IaC approaches, native security controls, ALZ accelerators, operational role responsibility assignments, security governance best practices, cloud workload protection, and cloud security posture management.|
| [Development security strategy](../secure/best-practices/file.md#section-name) | This section outlines best practices related to development security strategy including innovation security, Shift Left strategies, and the technical strategies to protect applications, code, and the underlying infrastructure, platform, or device. |
| [Development security architecture](../secure/best-practices/file.md#section-name) | This section describes best practices related to the ideal end state and key components of development security, including IaC deployment consistency, and integrated process for security development.
| [Development security implementation and operations](../secure/best-practices/file.md#section-name) | This section covers implementation and operations aspects of development security, incuding comprehensive repository toolsets, continuous, incremental governance improvements, and DevSecOps controls. |

## May 2022

### Unified management and operations with Azure Arc-enabled Kubernetes landing zone accelerator

This release of the Cloud Adoption Framework provides considerations to help you prepare for an enterprise-scale deployment of Azure Arc-enabled Kubernetes.

This scenario focuses on enabling a few targeted outcomes:

- Mature your hybrid practices with Azure Arc-enabled Kubernetes management and operations.
- Establish appropriate Azure Arc-enabled Kubernetes governance across all on-premises and multicloud assets to move forward with confidence.
- Minimize technical debt by considering well-architected principles across all Azure Arc-enabled Kubernetes workloads.
- Automate all three of the above with the codebase for Azure Arc-enabled Kubernetes landing zone accelerator.
- Quickly access skilling resources in documentation or learning modules for the various Azure services required across this scenario.

Get started with this scenario using the following links:

| Article | Description |
|--|--|
| [Identity and access management](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-identity-access-management.md) | Best practices for right access controls design to secure hybrid resources as they are centrally managed from Azure using Azure Arc. |
| [Network topology and connectivity](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-network-connectivity.md) | Design considerations when working with Azure Arc-enabled Kubernetes and how to securely connect them to your Enterprise Scale Landing Zone. |
| [Resource organization](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-resource-organization.md) | Best practices for resource consistency and tagging strategy, that includes your hybrid and multicloud resources. |
| [Governance and security disciplines](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-governance-disciplines.md) | The [Cloud Adoption Framework's Enterprise Scale Landing Zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/) includes patterns for standardizing the deployment of [Azure Policy](/azure/governance/policy/overview) and [role-based access controls (RBAC)](../ready/azure-setup-guide/manage-access.md) through structured use of management groups to segment resources into logical groupings. These patterns can be extended using technologies such as Azure Arc. |
| [Management disciplines](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-management-disciplines.md) | Similar to governance techniques, Azure Management services can also be extended out to other environments, such as on-premises and other cloud platforms through Azure Arc. Enterprise Scale provides guidance on how operationally maintain Azure Arc-enabled Kubernetes on Azure enterprise estate, with centralized management and monitoring at the platform level. |
| [Automation disciplines](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-automation-disciplines.md) | Azure Arc enables organizations to manage their digital state hosted outside of Azure with the same level of experience and automation as a native Azure resource. As part of your Enterprise Scale Landing Zone implementation you should plan for agent onboarding, lifecycle management, and expansion of the Azure control plane capabilities via Azure Arc with as much automation as possible. |
| [Extensions management](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-extensions-management.md) | Azure Arc-enabled Kubernetes as being split into two categories: extensions for Azure Arc-enabled infrastructure services and extensions for Azure Arc-enabled services. As part of your Enterprise Scale Landing Zone implementation you should keep these two categories in mind as you design your deployment of Azure Arc-enabled Kubernetes. |
| [CI/CD and GitOps disciplines](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-cicd-gitops-disciplines.md) | As a cloud-native construct, Kubernetes requires a cloud-native approach for deployment and operations. With GitOps, you declare the desired state of your application-based deployments in files that are stored in Git repositories. As part of your Enterprise Scale Landing Zone implementation you should plan on how and when GitOps practices using Azure Arc-enabled Kubernetes applies in your organization and who are the people who will be using it.|
| [Services observability](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-services-observability.md) | Observability is an application characteristic that refers to how well a system’s internal state or status can be understood from its external outputs. As part of your Enterprise Scale Landing Zone implementation you should plan when to implement the Azure Arc-enabled Kubernetes cluster extensions for observability use-cases; Open Service Mesh and Self-hosted API Management gateway. |
| [Cost governance](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-cost-governance.md) | Keep track of ungoverned and unmonitored resources that prevent you from to increase accountability with budgets, cost allocation, and chargebacks. |
| [Start with Azure Arc-enabled Kubernetes landing zone accelerator sandbox](../scenarios/hybrid/arc-enabled-kubernetes/enterprise-scale-landing-zone-sandbox.md) | Get started with a fully automated Azure Arc-enabled Kubernetes sandbox deployment. |
| [Introduction to Azure Arc-enabled Kubernetes landing zone accelerator for hybrid](../scenarios/hybrid/enterprise-scale-landing-zone.md) | Learn how to accelerate adoption of hybrid or multicloud architectures. |

### App Service landing zone accelerator

The new App Service landing zone accelerator provides recommendations and considerations for that can help accelerate adoption of App Service. The architectural approach can be used in greenfield scenarios as design guidelines and in brownfield scenarios as an assessment. The scenario covers both multi-tenanted App Service as well as App Service Environment deployments. The reference implementation covers an architecture using an internal App Service Environment v3 for line of business applications.

Get started with this landing zone accelerator using the following links:

- [Identity and access management](../scenarios/app-platform/app-services/identity-and-access-management.md)
- [Network topology and connectivity](../scenarios/app-platform/app-services/network-topology-and-connectivity.md)
- [Security](../scenarios/app-platform/app-services/security.md)
- [Management](../scenarios/app-platform/app-services/management.md)
- [Governance](../scenarios/app-platform/app-services/governance.md)
- [Platform automation and DevOps](../scenarios/app-platform/app-services/platform-automation-and-devops.md)

### API Management landing zone accelerator

The API Management landing zone accelerator provides recommendations and considerations that can help accelerate adoption of API Management. The architectural approach can be used in greenfield scenarios as design guidelines and in brownfield scenarios as an assessment. The reference implementation covers an architecture where customers hope to host both internal and external facing APIs on an internal API Management instance with an Application Gateway as the web application firewall in a single region deployment.

Get started with this landing zone accelerator using the following links:

- [Identity and access management](../scenarios/app-platform/api-management/identity-and-access-management.md)
- [Network topology and connectivity](../scenarios/app-platform/api-management/network-topology-and-connectivity.md)
- [Security](../scenarios/app-platform/api-management/security.md)
- [Management](../scenarios/app-platform/api-management/management.md)
- [Governance](../scenarios/app-platform/api-management/governance.md)
- [Platform automation and DevOps](../scenarios/app-platform/api-management/platform-automation-and-devops.md)

## April 2022

### Cloud-scale analytics 

This release provides a considerable update to the Data Management and Analytics scenario. Based on feedback and lessons learned from many customers, we've renamed the scenario "cloud-scale analytics" and updated all the topics in this scenario.  Here's some links to the highlights. 

| Article | Description |
|--|--|
| [Cloud-scale analytics](../scenarios/cloud-scale-analytics/index.md) | An overview of how this cloud-scale analytics scenario can help your organization build modern data platforms. |
| [Govern](../scenarios/cloud-scale-analytics/govern.md), [secure](../scenarios/cloud-scale-analytics/secure.md), and [organize](../scenarios/cloud-scale-analytics/organize.md) | Updated guidance about how to govern and secure your analytics estate, and organize your people and teams. |
| [Managing your analytics estate](../scenarios/cloud-scale-analytics/manage.md) | New guidance helps you learn how DevOps combined with observability is key to providing an agile and scalable platform. |
| [Architectural guidance](../scenarios/cloud-scale-analytics/architectures/overview-architectures.md) | Review data architectures for cloud-scale analytics.|
| [Data product](../scenarios/cloud-scale-analytics/architectures/data-landing-zone-data-products.md) | New information about cloud-scale analytics data products in Azure. |
| [Data standardization](../scenarios/cloud-scale-analytics/architectures/data-standardization.md) | Consider your data formats to ensure processing pipeline efficiency and to optimize costs. |
| [Data mesh](../scenarios/cloud-scale-analytics/architectures/what-is-data-mesh.md) | Learn what data mesh is and get guidance on scaling analytics adoptions beyond a single platform and a single implementation team. |
| [Data lake zones](../scenarios/cloud-scale-analytics/best-practices/data-lake-zones.md) | New guidance to help you plan your data structure before you land it into a data lake. |


## March 2022

### Low-code application platform guidance

This update provides guidance to help you prepare for adoption of low-code development. We've added content that includes best practices for adopting and innovating with Power Platform.

- [Power Platform adoption best practices](/power-platform/guidance/adoption/methodology?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Power Apps overview](/powerapps/powerapps-overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Power Automate workflows](/power-automate/getting-started?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Automate tasks with robotic process automation](/power-automate/desktop-flows/introduction?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Intelligent low-code apps](/ai-builder/overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json&branch=main)

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

### Cloud-scale analytics scenario

This release of the Cloud Adoption Framework provides considerations to help you prepare for [cloud-scale analytics](../scenarios/data-management/index.md).

This scenario focuses on enabling a few targeted outcomes:

- Mature your analytics, AI and machine learning, and IoT capabilities in the cloud.
- Establish appropriate data governance across all data initiatives to move forward with confidence.
- Minimize technical debt by considering well-architected principles across all data workloads.
- Automate all three of the above with the codebase for enterprise-scale for analytics.
- Quickly access skilling resources in documentation or learning modules for the various Azure services required across this scenario.

Get started with this scenario using the following links:

| Article | Description |
|--|--|
| [Introduction to the cloud-scale analytics](../scenarios/data-management/index.md) | In this article we introduce the principles of the cloud-scale analytics.|
| [Data governance](../scenarios/data-management/govern.md) | This guidance reviews how data governance ensures data that's used by your business is discoverable, accurate, trusted, and can be protected. |
| [Build an initial strategy](../scenarios/data-management/strategy.md) | In this article, review considerations for cloud-scale analytics that will have an impact on your cloud adoption strategy.
| [Define a plan](../scenarios/data-management/plan.md) | Establish a clear plan for rationalizing data, skilling people, and tips for ensuring success.
| [Azure landing zones for cloud-scale analytics](../scenarios/data-management/ready.md) | This guidance provides an overview of the data management landing zone. A data management landing zone is responsible for the governance of the platform and enables communication to ingest data sources from Azure, third-party clouds, and on-premises.
| [Govern your data estate](../scenarios/data-management/govern.md) | This article reviews a data governance solution to surround the specific data entities and data subject areas with people, processes, policies, and technology.
| [Secure your data estate](../scenarios/data-management/secure.md) | Best practices to improve security of your entire data estate.
| [Organize people and teams](../scenarios/data-management/organize.md) |Learn about how to organize data operations team members for the cloud-scale analytics in Azure.
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

We expanded and revised the modern application platform content in this release. Commonly, customers need to provide their developers with a consistent application platform. This article series outlines how you can use orchestrated containers to manage pools of workloads in one or more centralized clusters, thus providing that consistent application platform. The articles in this series for [modern application platform](../scenarios/app-platform/index.md) combine technical and non-technical considerations required to prepare for Kubernetes and container integration into centralized operations and your broader cloud strategy.

## April 2021

### Cloud service controls

To help you implement cloud governance at a pace that sustains a high level of innovation, and implements the right level of control for your environment, we've added a new article, [Implement cloud service controls](../govern/cloud-service-controls.md). It focuses on a proven process to help governance teams implement granular controls across the Azure platform, while accelerating the development capabilities for cloud adoption teams. The process can be implemented by enterprises of any size, at any stage of their cloud journey. This guidance outlines the different stages of the process, from taking the enterprise requirements for cloud control for security, operations, and cost management, through the stages of development and release of controls.

### Azure Storage migration overview

To help you plan your Azure Storage migration, we've provided guidance in a new article, [Azure Storage migration overview](/azure/storage/common/storage-migration-overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json), for two migration scenarios:

- Migration of unstructured data, such as files and objects.
- Migration of block-based devices, such as disks and storage area networks.

<!-- docutune:ignoreNextStep -->