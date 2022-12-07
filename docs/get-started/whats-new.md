---
title: What's new in the Microsoft Cloud Adoption Framework
description: Learn about recent updates to the Microsoft Cloud Adoption Framework for Azure.
author: martinekuan
ms.author: martinek
ms.date: 09/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

# What's new in the Microsoft Cloud Adoption Framework for Azure

We build the Microsoft Cloud Adoption Framework collaboratively with our customers, partners, and internal Microsoft Teams. We release new and updated content for the framework as it becomes available. These new releases pose an opportunity for you to test, validate, and refine the Cloud Adoption Framework guidance along with us.

Partner with us in our ongoing effort to develop the Cloud Adoption Framework.

## December 2022

### HPC landing zone accelerator

High-performance computing (HPC) on Azure is the complete set of compute, networking, and storage resources integrated with workload orchestration services for applications that provide advanced analytics, graphic-intensive visualizations, and scalable rendering. Industries such as manufacturing, energy, and finance typically use HPC for running complex simulations. 

The HPC landing zone accelerator includes modernizing HPC workloads in Azure by offering global regulatory compliance, next-generation machine-learning tools, and a well-architected framework for best practices, architecture references per industry along with automation solutions that will help bootstrap your HPC journey in Azure.

Use the following links to get started with the HPC scenario overview, landing zone accelerator, and well-architected framework for your HPC environment's cloud adoption journey:

- [Azure HPC scenario overview](../scenarios/azure-hpc/index.md)
- [HPC landing zone accelerator](../scenarios/azure-hpc/azure-hpc-landing-zone-accelerator.md)
- [Well-Architected Framework for HPC](../scenarios/azure-hpc/well-architected-framework.md)

## October 2022

### Azure Arc-enabled SQL Managed Instance

Azure Arc-enabled SQL Managed Instance is a data service that you can create on the infrastructure of your choice. Azure Arc-enabled SQL Managed Instance is nearly 100 percent compatible with the latest SQL Server database engine. Customers who use SQL Server can migrate their applications to Azure Arc data services, while maintaining data sovereignty, with minimal changes to applications and databases. SQL Managed Instance includes built-in management capabilities that drastically reduce management overhead.

Use the articles in the following table to learn more about Azure Arc-enabled SQL Managed Instance.

| Article | Description |
|-----------------------------|----------------------------------------------------------------------------------------------|
| [Identity and access management for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-identity-access-management.md) | Learn how to improve identity and access management for Azure Arc-enabled SQL Managed Instance deployments. |
| [Network connectivity for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-network-connectivity.md) | Understand the design considerations and recommendations for network connectivity in Azure Arc-enabled SQL Managed Instance. |
| [Storage disciplines for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-storage-disciplines.md) | Learn design considerations and recommendations for storage disciplines with Azure Arc-enabled SQL Managed Instance. |
| [Resource organization for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-resource-organization.md) | Learn how to organize resources when working with Azure Arc-enabled SQL Managed Instance. |
| [Governance and security for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-governance-disciplines.md) | Adopt best practices for governance, security, and compliance on Azure Arc-enabled SQL Managed Instance. |
| [Management and monitoring for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-management-disciplines.md) | Learn about design considerations and recommendations for the management and monitoring of  Azure Arc-enabled SQL Managed Instance. |
| [Deploy a sandbox for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/enterprise-scale-landing-zone-sandbox.md) | Learn how to deploy Azure Arc-enabled data services to an Azure landing zone in a sandbox subscription to accelerate your adoption of hybrid or multicloud architectures. |
| [Business continuity and disaster recovery for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-business-continuity-disaster-recovery.md) | Learn how to implement business continuity and disaster recovery for Azure Arc-enabled SQL Managed Instance. |
| [Upgradeability disciplines for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-upgradeability-disciplines.md) | Learn how to implement upgradeability disciplines for Azure Arc-enabled SQL Managed Instance. |
| [Cost governance for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-cost-governance.md) | Learn design considerations and recommendations on cost governance for Azure Arc-enabled SQL Managed Instance. |

## September 2022

### Security control mapping with Azure landing zones

Many organizations are required to comply with regulations that govern their industry or location before adopting cloud services. Our best-practice recommendation is to [map required compliance controls to Azure Security Benchmark](../ready/control-mapping/security-control-mapping.md), which provides a set of cloud-centric security controls based on widely used compliance control frameworks.

Mapping required controls to Azure Security Benchmark can greatly expedite a secure Azure onboarding experience. The article also provides guidance on how to build policies and initiatives for controls that aren't covered by Azure Security Benchmark.

## August 2022

### Azure Red Hat OpenShift landing zone accelerator

The Azure Red Hat OpenShift landing zone accelerator is a collection of templates, design recommendations, and implementation references to accelerate deployment of Azure Red Hat OpenShift clusters in your landing zone. This landing zone accelerator is open source. You can adapt the templates and recommendations to create an architecture that meets your needs. By following this guidance, your organization can lay the groundwork for scalability.

Use the following links to get started with this landing zone accelerator:

| Article | Description |
| ---- | --- |
| [Introduction](../scenarios/app-platform/azure-red-hat-openshift/landing-zone-accelerator.md) | Learn about the benefits of the landing zone accelerator approach for Azure Red Hat OpenShift. |
| [Identity and access management](../scenarios/app-platform/azure-red-hat-openshift/identity-access-management.md) | Create an identity and access management plan that meets your organization's requirements. |
| [Network topology and connectivity](../scenarios/app-platform/azure-red-hat-openshift/network-topology-connectivity.md) | Control network traffic and connectivity to your clusters. |
| [Resource organization considerations](../scenarios/app-platform/azure-red-hat-openshift/resource-organization.md) | Design your resource groups for proper resource governance and isolation. |
| [Security](../scenarios/app-platform/azure-red-hat-openshift/security.md) | Protect and secure your Azure Red Hat OpenShift deployments. |
| [Operations baseline guidance](../scenarios/app-platform/azure-red-hat-openshift/operations.md) | Achieve operational excellence with management and monitoring solutions. |
| [Platform automation and DevOps](../scenarios/app-platform/azure-red-hat-openshift/platform-automation-devops.md) | Get recommendations for automation and DevOps for your Azure Red Hat OpenShift platform. |

## July 2022

### Cloud-scale analytics tutorials

Cloud-scale analytics tutorials provide comprehensive guidance on setting up landing zones that host and run analytics workloads. Cloud-scale analytics builds upon Azure landing zones that supply the necessary infrastructure for applications and workloads. The landing zones meet security, governance, and compliance standards. Microsoft provides sample templates to get started. The tutorials walk through the steps for evaluating an example enterprise scenario and then show how to plan, set up, deploy, and operate landing zones.

Each tutorial builds upon the next and provides detailed guidance on the recommended approach.

| Article | Description |
| ---- | --- |
| [Tutorial: Evaluate an enterprise data scenario](../scenarios/cloud-scale-analytics/tutorials/tutorial-evaluate-scenario.md) | A tutorial using an example enterprise scenario that shows how Azure cloud-scale analytics provides a scalable, repeatable framework for building a modern data platform. |
| [Tutorial: Create a data landing zone](../scenarios/cloud-scale-analytics/tutorials/tutorial-create-data-landing-zone.md) | A tutorial that shows how to create a data landing zone by using the Deploy to Azure option in the Azure portal. |
| [Tutorial: Create a data product batch](../scenarios/cloud-scale-analytics/tutorials/tutorial-create-data-product-batch.md) | A tutorial that shows how to use the Deploy to Azure feature, a customized deployment template, to deploy resources for the data product batch in a data landing zone. |
| [Tutorial: Set up a data product batch](../scenarios/cloud-scale-analytics/tutorials/tutorial-set-up-data-product-batch.md) | A tutorial that shows how to set up already deployed data product services and use Azure Data Factory to integrate and orchestrate the data. The tutorial then shows how to use Microsoft Purview to discover, manage, and govern data assets. |
| [Tutorial: Clean up resources](../scenarios/cloud-scale-analytics/tutorials/cleanup-instructions.md) | A tutorial that shows how to use scripts to remove tutorial resources created in an Azure subscription when encountering deployment issues or to remove the tutorial resources in a subscription when finished with the tutorials. |

## June 2022

### Security best practices for infrastructure and development

Security best practices for infrastructure and development are a comprehensive guidance set for the full cloud security development lifecycle across strategy, architecture, implementation, operations, and governance. These best practices complement the Microsoft Cloud Adoption Framework for Azure, Microsoft tools, security guides, and technical documentation with a focus on infrastructure and development. They also align with the Azure Security Benchmark recommendations.

Each article provides top-level guidance, followed by recommended tools, materials, and a recommended best practice approach.

| Article | Description |
|--|--|
|[Introduction](../secure/security-best-practices-introduction.md) |An introduction to infrastructure security and development security that covers the full lifecycle of strategy, architecture, implementation, operations, and governance.|
| [Infrastructure security best practices overview](../secure/infrastructure-security-overview.md) |An outline of the interrelationship of development security's dependency on infrastructure security, with a continuous improvement approach that progresses towards a "north star" end-state across security strategy, architecture, implementation, and operations. |
| [Infrastructure security strategy](../secure/infrastructure-security-strategy.md) | Define a security strategy that reduces business risk from attacks. Take incremental steps to build confidentiality, integrity, and availability assurances into all information systems and data. |
| [Infrastructure security architecture](../secure/infrastructure-security-architecture.md) | Best practices related to the ideal end state and key components of infrastructure security, including Azure landing zones, Zero Trust principles, and additional Azure Security Benchmark security recommendations. |
| [Infrastructure security implementation](../secure/infrastructure-security-implementation.md) and [security operations and governance](../secure/infrastructure-security-operations-governance.md) | Learn about implementation, operations, and governance security, including IaC approaches, native security controls, ALZ accelerators, operational role responsibility assignments, security governance best practices, cloud workload protection, and cloud security posture management.|
| [Development security strategy](../secure/development-security-strategy-overview.md) | Best practices related to development security strategy including innovation security, Shift Left strategies, and the technical strategies to protect applications, code, and the underlying infrastructure, platform, or device. |
| [Development innovation security](../secure/development-innovation-security.md) | Develop an innovation security strategy that enables your organization to balance the protection of innovation data and processes with incremental and continuous improvements in the development lifecycle. Define an innovation minimum viable product (MVP) across development, security, and operations—integrating Shift Left security thinking within your DevOps lifecycle from the beginning. |
| [Securing DevOps strategy and process](../secure/devops-strategy-process-security.md) | Learn how to move towards a DevSecOps strategy end-state, balancing smaller, iterative improvements with innovation and the development lifecycle. Push rapid releases with elements of classic security and operations. Ensure your minimum viable product (MVP) balances the need for rapid releases—natively embedding guardrails across security, governance, and compliance—while balancing production, performance, and reliability. |
| [Development security architecture](../secure/development-security-architecture.md) | Best practices related to the ideal end state and key components of development security, including IaC deployment consistency, and integrated process for security development.
| [Development security implementation and operations](../secure/development-security-implementation-operations.md) | Learn about the implementation and operations aspects of development security, including comprehensive repository toolsets, continuous, incremental governance improvements, and DevSecOps controls. |

## May 2022

### Unified management and operations with Azure Arc-enabled Kubernetes landing zone accelerator

This Cloud Adoption Framework release provides considerations that help you prepare for enterprise-scale deployments of Azure Arc-enabled Kubernetes.

This scenario enables the following targeted outcomes:

- Mature your hybrid practices by implementing Azure Arc-enabled Kubernetes management and operations.
- Establish appropriate Azure Arc-enabled Kubernetes governance across all on-premises and multicloud assets.
- Minimize technical debt by considering well-architected principles across all your Azure Arc-enabled Kubernetes workloads.
- Use the codebase for Azure Arc-enabled Kubernetes landing zone accelerator to automate all three of the above.
- Quickly access skilling resources in documentation or learning modules for the various Azure services required across this scenario.

Use the following table of article links to get started with this scenario.

| Article | Description |
|--|--|
| [Identity and access management](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-identity-access-management.md) |Best practices for right access controls design to secure hybrid resources as they're centrally managed from Azure using Azure Arc. |
| [Network topology and connectivity](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-network-connectivity.md) |Design considerations when working with Azure Arc-enabled Kubernetes and how to securely connect them to your Enterprise Scale Landing Zone. |
| [Resource organization](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-resource-organization.md) |Best practices for resource consistency and tagging strategy that includes your hybrid and multicloud resources. |
| [Governance and security disciplines](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-governance-disciplines.md) |The [Cloud Adoption Framework's Enterprise Scale Landing Zone architecture](../ready/landing-zone/index.md) includes patterns for standardizing the deployment of [Azure Policy](/azure/governance/policy/overview) and [role-based access controls (RBAC)](../ready/azure-setup-guide/manage-access.md) through structured use of management groups to segment resources into logical groupings. These patterns can be extended using technologies such as Azure Arc. |
| [Management disciplines](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-management-disciplines.md) |Similar to governance techniques, Azure Management services can also be extended out to other environments, such as on-premises and other cloud platforms through Azure Arc. Enterprise Scale provides guidance on how operationally maintain Azure Arc-enabled Kubernetes on Azure enterprise estate, with centralized management and monitoring at the platform level. |
| [Automation disciplines](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-automation-disciplines.md) |Azure Arc enables organizations to manage their digital state hosted outside of Azure with the same level of experience and automation as a native Azure resource. As part of your Enterprise Scale Landing Zone implementation you should plan for agent onboarding, lifecycle management, and expansion of the Azure control plane capabilities via Azure Arc with as much automation as possible. |
| [Extensions management](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-extensions-management.md) |Azure Arc-enabled Kubernetes as being split into two categories: extensions for Azure Arc-enabled infrastructure services and extensions for Azure Arc-enabled services. As part of your Enterprise Scale Landing Zone implementation you should keep these two categories in mind as you design your deployment of Azure Arc-enabled Kubernetes. |
| [CI/CD and GitOps disciplines](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-cicd-gitops-disciplines.md) |As a cloud-native construct, Kubernetes requires a cloud-native approach for deployment and operations. With GitOps, you declare the desired state of your application-based deployments in files that are stored in Git repositories. As part of your Enterprise Scale Landing Zone implementation you should plan on how and when GitOps practices using Azure Arc-enabled Kubernetes applies in your organization and who are the people who will be using it.|
| [Services observability](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-services-observability.md) |Observability is an application characteristic that refers to how well a system’s internal state or status can be understood from its external outputs. As part of your Enterprise Scale Landing Zone implementation you should plan when to implement the Azure Arc-enabled Kubernetes cluster extensions for observability use-cases; Open Service Mesh and Self-hosted API Management gateway. |
| [Cost governance](../scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-cost-governance.md) |Keep track of ungoverned and unmonitored resources that prevent you from to increase accountability with budgets, cost allocation, and chargebacks. |
| [Start with Azure Arc-enabled Kubernetes landing zone accelerator sandbox](../scenarios/hybrid/arc-enabled-kubernetes/enterprise-scale-landing-zone-sandbox.md) |Get started with a fully automated Azure Arc-enabled Kubernetes sandbox deployment. |
| [Introduction to Azure Arc-enabled Kubernetes landing zone accelerator for hybrid](../scenarios/hybrid/enterprise-scale-landing-zone.md) |Learn how to accelerate adoption of hybrid or multicloud architectures. |

### App Service landing zone accelerator

The new App Service landing zone accelerator provides recommendations and considerations that help accelerate your App Service adoption. You can use its architectural approach as a set of design guidelines in greenfield scenarios and as an assessment in brownfield scenarios. This scenario covers both multi-tenanted App Service and App Service Environment deployments. Its reference implementation covers an architecture that uses an internal App Service Environment v3 for line of business applications.

Use the following links to get started with this landing zone accelerator: 

- [Identity and access management](../scenarios/app-platform/app-services/identity-and-access-management.md)
- [Network topology and connectivity](../scenarios/app-platform/app-services/network-topology-and-connectivity.md)
- [Security](../scenarios/app-platform/app-services/security.md)
- [Management](../scenarios/app-platform/app-services/management.md)
- [Governance](../scenarios/app-platform/app-services/governance.md)
- [Platform automation and DevOps](../scenarios/app-platform/app-services/platform-automation-and-devops.md)

### API Management landing zone accelerator

The API Management landing zone accelerator provides recommendations and considerations that help you accelerate your API Management adoption. You can use its architectural approach as design guidelines in greenfield scenarios and as an assessment in brownfield scenarios. Its reference implementation covers an architecture where customers hope to host both internal and external facing APIs on an internal API Management instance with an Application Gateway as the web application firewall in a single region deployment.

Use the following links to get started with this landing zone accelerator:

- [Identity and access management](../scenarios/app-platform/api-management/identity-and-access-management.md)
- [Network topology and connectivity](../scenarios/app-platform/api-management/network-topology-and-connectivity.md)
- [Security](../scenarios/app-platform/api-management/security.md)
- [Management](../scenarios/app-platform/api-management/management.md)
- [Governance](../scenarios/app-platform/api-management/governance.md)
- [Platform automation and DevOps](../scenarios/app-platform/api-management/platform-automation-and-devops.md)

## April 2022

### Cloud-scale analytics

This Cloud Adoption Framework release provides a considerable update to the Data Management and Analytics scenario. Based on feedback and lessons from many of our customers, we've renamed this scenario "cloud-scale analytics" and updated all the articles within it.  The following table provides links to the highlights. 

| Article | Description |
|--|--|
| [Cloud-scale analytics](../scenarios/cloud-scale-analytics/index.md) | An overview of how this cloud-scale analytics scenario can help your organization build modern data platforms. |
| [Govern](../scenarios/cloud-scale-analytics/govern.md), [secure](../scenarios/cloud-scale-analytics/secure.md), and [organize](../scenarios/cloud-scale-analytics/organize.md) | Updated guidance on how to govern and secure your analytics estate and organize your people and teams. |
| [Managing your analytics estate](../scenarios/cloud-scale-analytics/manage.md) | New guidance on how DevOps combined with observability is key to providing an agile and scalable platform. |
| [Architectural guidance](../scenarios/cloud-scale-analytics/architectures/overview-architectures.md) | Data architecture guidance for cloud-scale analytics.|
| [Data product](../scenarios/cloud-scale-analytics/architectures/data-landing-zone-data-products.md) | New information on cloud-scale analytics data products in Azure. |
| [Data standardization](../scenarios/cloud-scale-analytics/architectures/data-standardization.md) | Guidance on considering data formats to optimize costs and ensure processing pipeline efficiency. |
| [Data mesh](../scenarios/cloud-scale-analytics/architectures/what-is-data-mesh.md) | Information on data mesh, plus guidance for scaling analytics adoptions beyond a single platform and single implementation team. |
| [Data lake zones](../scenarios/cloud-scale-analytics/best-practices/data-lake-zones.md) | New guidance on planning data structure before landing the data into a data lake. |

## March 2022

### Low-code application platform guidance

This update provides guidance to help you prepare for low-code development adoption. We've added content that includes best practices for adopting and innovating with Power Platform. This is the first set of content in our plan to include Power Platform in the Cloud Adoption Framework.

- [Power Platform adoption best practices](/power-platform/guidance/adoption/methodology?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Power Apps overview](/powerapps/powerapps-overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Power Automate workflows](/power-automate/getting-started?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Automate tasks with robotic process automation](/power-automate/desktop-flows/introduction?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Intelligent low-code apps](/ai-builder/overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json&branch=main)

### Independent software vendor (ISV) considerations for Azure landing zones

The new [ISV considerations for Azure landing zones](../ready/landing-zone/isv-landing-zone.md) article describes how to build an Azure environment with multiple subscriptions. Each landing zone accounts for scale, security, governance, networking, and identity, and the considerations are based on feedback and lessons from many customers.

## February 2022

### New videos added to the Cloud Adoption Framework security articles

The following videos can help you understand the role of security in your cloud adoption journey.

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

This Cloud Adoption Framework release provides considerations that help you prepare for an enterprise-scale deployment of Azure Arc-enabled servers.

This scenario focuses on enabling the following targeted outcomes:

- Mature your hybrid practices with Azure Arc-enabled servers management and operations.
- Establish appropriate Azure Arc-enabled servers governance across all on-premises and multicloud assets to move forward with confidence.
- Minimize technical debt by considering well-architected principles across all Azure Arc-enabled servers workloads.
- Automate all three of the above with the codebase for Azure Arc-enabled servers landing zone accelerator.
- Quickly access skilling resources in documentation or learning modules for the various Azure services required across this scenario.

Use the following links to get started with this scenario.

| Article | Description |
|--|--|
| [Identity and access management](../scenarios/hybrid/arc-enabled-servers/eslz-identity-and-access-management.md) | Best practices for right access controls design to secure hybrid resources as they're centrally managed from Azure using Azure Arc. |
| [Network topology and connectivity](../scenarios/hybrid/arc-enabled-servers/eslz-arc-servers-connectivity.md) | Design considerations when working with Azure Arc-enabled servers and how to securely connect them to your Enterprise Scale Landing Zone. |
| [Resource organization](../scenarios/hybrid/arc-enabled-servers/eslz-resource-organization.md) | Best practices for resource consistency and tagging strategy that includes your hybrid and multicloud resources. |
| [Governance and security disciplines](../scenarios/hybrid/arc-enabled-servers/eslz-security-governance-and-compliance.md) | The [Cloud Adoption Framework's Enterprise Scale Landing Zone architecture](../ready/landing-zone/index.md) includes patterns for standardizing the deployment of [Azure Policy](/azure/governance/policy/overview) and [role-based access controls (RBAC)](../ready/azure-setup-guide/manage-access.md) through structured use of management groups to segment resources into logical groupings. These patterns can be extended using technologies such as Azure Arc. |
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

<!-- docutune:ignoreNextStep -->
