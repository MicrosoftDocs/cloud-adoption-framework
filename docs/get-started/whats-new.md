---
title: What's new in the Microsoft Cloud Adoption Framework
description: Learn about recent updates to the Microsoft Cloud Adoption Framework for Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 11/30/2023
ms.topic: conceptual
ms.custom: UpdateFrequency.5, historical
---

# What's new in the Microsoft Cloud Adoption Framework for Azure

We build the Microsoft Cloud Adoption Framework collaboratively with our customers, partners, and internal Microsoft Teams. We release new and updated content for the framework as it becomes available. These new releases pose an opportunity for you to test, validate, and refine the Cloud Adoption Framework guidance along with us.

Partner with us in our ongoing effort to develop the Cloud Adoption Framework.

## January 2024

During the month of January, we added two articles and updated an article. 

### New articles

In [Define a sovereignty strategy](/azure/cloud-adoption-framework/strategy/define-sovereignty-strategy), organizations that use cloud services can find guidance for meeting the sovereignty requirements for their countries/regions. We added information about sovereignty requirements in the following articles:
- [Select Azure regions for a migration](/azure/cloud-adoption-framework/migrate/azure-best-practices/multiple-regions)
- [Azure migration tools decision guide](/azure/cloud-adoption-framework/migrate/azure-migration-guide/migration-tools-decision-guide)
- [Select Azure regions](/azure/cloud-adoption-framework/ready/azure-setup-guide/regions)
- [Security design in Azure](/azure/cloud-adoption-framework/ready/landing-zone/design-area/security)

In [Advanced Azure Policy management](/azure/cloud-adoption-framework/ready/policy-management/enterprise-policy-as-code), find out how to manage Azure Policy at scale by using the Enterprise Policy as Code (EPAC) open-source project and integrating IaC into your environment.

### Updated article

In [Plan for IP addressing](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-ip-addressing), we added information about IPv6 considerations. Find recommendations to help you plan for IPv6 and implement it in your existing Azure networks.

## December 2023

In December, we added new articles about landing zones and updated articles related to workload migration.

### New articles

- Find out how cloud platform teams can set up guardrails to [Manage application development environments in Azure landing zones](../ready/landing-zone/design-area/management-application-environments.md) and align various application development environments with their framework. 

- Organizations in many industries are subject to regulatory requirements, including data residency, data security, and data sovereignty requirements. Some organizations need to comply with conflicting regulations across multiple geographic locations. In our new article, learn how to [Modify an Azure landing zone architecture to meet requirements across multiple locations](../ready/landing-zone/landing-zone-multinational.md).

### Updated articles

In the following articles, find updated guidance about workload discovery processes that help you understand the many dimensions involved in migrating a workload. You can use that information to help you effectively migrate cloud workloads to another region.

- [Evaluate a cloud workload for relocation](../relocate/evaluate.md)
- [Migrate a cloud workload to another region](../relocate/migrate.md)

## November 2023

### Sovereignty requirements

This new article describes how to meet digital sovereignty requirements when you adopt cloud computing. The Azure landing zone FAQ has been updated with material that corresponds to the sovereignty considerations article.

- [Sovereignty considerations for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/sovereign-landing-zone)

- [Azure landing zone FAQ](/azure/cloud-adoption-framework/ready/enterprise-scale/faq)

## October 2023

### HPC baseline computing

HPC baseline computing updates and new articles describe the benefits of Azure HPC OnDemand Platform (AzHop), compare the features of Azure Batch and Azure CycleCloud, and provide a large-scale HPC architecture for the finance industry.

- [Azure landing zone for HPC](/azure/cloud-adoption-framework/scenarios/azure-hpc/ready)

- [Finance HPC Azure identity and access management](/azure/cloud-adoption-framework/scenarios/azure-hpc/finance/identity-access-management)
- [Run large-scale HPC application workloads for the finance industry on Azure virtual machines](/azure/cloud-adoption-framework/scenarios/azure-hpc/finance/compute)
- [Big compute in the manufacturing industry](/azure/cloud-adoption-framework/scenarios/azure-hpc/manufacturing/compute)

### Brownfield alignment scenarios

This series starts with an introduction that describes recommendations for transitioning an existing Azure environment into an Azure landing zone conceptual architecture. It includes considerations for moving resources and subscriptions. There are four distinct articles that describe transitioning scenarios based on the existing Azure environment. The final article provides guidance about maintaining a cloud environment over time.

- [Transition an existing Azure environment to the Azure landing zone conceptual architecture](/azure/cloud-adoption-framework/ready/enterprise-scale/transition)

- [Scenario: Transition a single subscription with no management groups to the Azure landing zone conceptual architecture](/azure/cloud-adoption-framework/ready/landing-zone/align-scenario-single-subscription)
- [Scenario: Transition management groups to the Azure landing zone conceptual architecture](/azure/cloud-adoption-framework/ready/landing-zone/align-scenario-multiple-management-groups)
- [Scenario: Transition a regional organization environment to the Azure landing zone conceptual architecture](/azure/cloud-adoption-framework/ready/landing-zone/align-scenario-regional-org)
- [Scenario: Transition an environment by duplicating a landing zone management group](/azure/cloud-adoption-framework/ready/landing-zone/align-approach-duplicate-brownfield-audit-only)
- [Journey toward the target architecture](/azure/cloud-adoption-framework/ready/landing-zone/landing-zone-journey)

### Updated CAF Azure regions decision guide

Learn how to [select Azure regions for your cloud footprint](/azure/cloud-adoption-framework/ready/azure-setup-guide/regions) by considering the characteristics of each region, like availability zones, region pairs, available services, and nonfunctional requirements, like region proximity and capacity. We’ve also provided new guidance about operating across multiple Azure regions. As part of this change, we simplified the [guidance about selecting Azure regions for migrations](/azure/cloud-adoption-framework/migrate/azure-best-practices/multiple-regions).

### Network topology and connectivity for Azure Virtual Desktop

The [updates to the Network topology and connectivity for Azure Virtual Desktop article](/azure/cloud-adoption-framework/scenarios/wvd/eslz-network-topology-and-connectivity) describe two new scenarios to help you understand how to manage network topology and connectivity at scale in Azure Virtual Desktop. The first scenario describes a hub-and-spoke architecture with hybrid connectivity over managed networks. The second scenario describes a hub-and-spoke architecture with public networks. Both scenarios use Remote Desktop Protocol Shortpath (RDP Shortpath).

## September 2023

### Plan for IP addressing

This article was updated with relevant information about IPv4 exhaustion and IPAM (IP address management) tools.

- [Plan for IP addressing](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-ip-addressing).

### Guidance for documenting and deploying alerts

To support the imminent general availability of Azure Monitor baseline alerts for an Azure landing zone, we have created Cloud Architecture Framework documentation about baseline alerts. Find out what baseline alerts are and where to go for more information about how to enhance your Azure platform by using Azure Monitor alerts.

-   [Monitor Azure platform landing zone components](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-monitor)

-   [Inventory and visibility considerations](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-platform)

### Azure VMware Solution network design guides

These guides describe the Microsoft-recommended approach to help you design network connectivity for Azure VMware Solution private clouds. They explore four design areas: connectivity with on-premises sites, connectivity with Azure virtual networks, inbound internet connectivity, and outbound internet connectivity. Each design area is covered in a dedicated article, which presents architectural options, including their pros and cons. There are also two articles that cover the basics of Azure VMware Solution networking and guidance on how to prioritize requirements and related design areas.

-   [Azure VMware Solution network design guide](/azure/cloud-adoption-framework/scenarios/azure-vmware/network-design-guide-intro)

-   [Azure VMware Solution network design guide: Inbound internet connectivity](/azure/cloud-adoption-framework/scenarios/azure-vmware/network-design-guide-internet-inbound-connectivity)

-   [Azure VMware Solution network design guide: Networking basics](/azure/cloud-adoption-framework/scenarios/azure-vmware/azure-vmware-solution-network-basics)

-   [Azure VMware Solution network design guide: Outbound internet connectivity](/azure/cloud-adoption-framework/scenarios/azure-vmware/network-design-guide-internet-outbound-connectivity)

-   [Azure VMware Solution network design guide: Connectivity with on-premises sites](/azure/cloud-adoption-framework/scenarios/azure-vmware/on-premises-connectivity)

-   [Azure VMware Solution network design guide: Connectivity with Azure virtual networks](/azure/cloud-adoption-framework/scenarios/azure-vmware/virtual-network-connectivity)

## July 2023

### Landing zone regions

This article explains how landing zones use Azure regions. It also explains how to add a region to an existing landing zone and considerations for migrating your Azure estate to a different region.

- [Landing zone regions](/azure/cloud-adoption-framework/ready/considerations/regions)

### Enhanced migration guidance

This article describes how to ensure that configurations are in place when you migrate your landing zone. It explores tasks, such as preparing your identity, enabling hybrid Domain Name System (DNS) services, and enabling subscription vending.

- [Readying your landing zone for migration](/azure/cloud-adoption-framework/migrate/azure-migration-guide/ready-alz)

### New best practices for SAP landing zone accelerator security on Azure

This series provides guidance for your SAP environment in Azure. You can find best practices for security operations to secure your SAP environment in Azure, security recommendations for SAP on Azure that runs on a SQL Server database, and guidance about the flow of SAP data from source SAP systems to downstream targets. Learn how to use Azure Synapse Analytics to build a modern data platform to ingest, process, store, serve, and visualize data from various sources.

- [SAP data integration example architecture](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-data-example-architecture)

- [Data integration security for SAP on Azure](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-data-integration-security)

- [SQL Server database security for SAP on Azure](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-database-security)

- [Security operations for SAP on Azure](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-security-operations)

- [Microsoft Sentinel for SAP on Azure](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-sentinel-for-sap)

## June 2023

### Updated machine learning inference during deployment

Learn about the [best practices for deploying machine learning models in production environments](/azure/cloud-adoption-framework/innovate/best-practices/ml-deployment-inference) by using Azure Machine Learning. Explore architectural considerations and deployment methods (real time and batch inference). Learn how to ensure consistency, monitor performance, implement security measures, and create a plan for updates.

### New landing zone sandbox environments

This article describes how to use a sandbox environment, including configuring networking, enabling audit logging, assigning a budget, and setting an expiration date.

- [Landing zone sandbox environments](/azure/cloud-adoption-framework/ready/considerations/sandbox-environments)

## April 2023

### Network topology and connectivity for Azure VMware Solution

When you use a VMware software-defined datacenter (SDDC) with an Azure cloud ecosystem, you have a unique set of design considerations to follow for both cloud-native and hybrid scenarios. This article provides [key considerations and best practices](/azure/cloud-adoption-framework/scenarios/azure-vmware/eslz-network-topology-connectivity) for networking and connectivity to, from, and within Azure and Azure VMware Solution deployments.

### Network considerations for Azure VMware Solution dual-region deployments

Learn how to configure network connectivity when Azure VMware Solution private clouds are deployed in two Azure regions for disaster resiliency. If there are partial or complete regional outages, the [network topology in this article](/azure/cloud-adoption-framework/scenarios/azure-vmware/eslz-dual-region-network-topology) allows unaffected components (private clouds, Azure-native resources, and on-premises sites) to maintain connectivity with each other and with the internet.

## March 2023

### Multiple Azure Active Directory tenant articles

The following articles provide guidance about how to design and implement an Azure environment to accommodate multiple tenants.

| Article | Description |
|---------|-------------|
| [Automate Azure landing zones across multiple tenants](/azure/cloud-adoption-framework/ready/landing-zone/design-area/multi-tenant/automation) | Learn about the automation approaches you can use to successfully operate and maintain Azure landing zone deployments at scale across multiple tenants. |
| [Azure landing zones canary approach with multiple tenants](/azure/cloud-adoption-framework/ready/landing-zone/design-area/multi-tenant/canary) | Learn how to handle Azure landing zones canary environments when you have multiple tenants. |
| [Azure Lighthouse usage in Azure landing zones multitenant scenarios](/azure/cloud-adoption-framework/ready/landing-zone/design-area/multi-tenant/lighthouse) | [Azure Lighthouse](/azure/lighthouse/overview) enables multitenant management with scalability, increased automation, and enhanced governance across resources. You can use Azure Lighthouse in Azure landing zone scenarios in single-tenant or multitenant architectures. |
| [Azure landing zones and multiple Azure Active Directory tenants](/azure/cloud-adoption-framework/ready/landing-zone/design-area/multi-tenant/overview) | Learn how multiple Azure Active Directory tenants work within the context of Azure landing zones. Learn the benefits of using a single tenant. |
| [Scenarios for multiple Azure Active Directory tenants](/azure/cloud-adoption-framework/ready/landing-zone/design-area/multi-tenant/scenarios) | Learn about the most common scenarios for which you might need multiple Azure Active Directory tenants. |
| [Considerations and recommendations for multitenant Azure landing zone scenarios](/azure/cloud-adoption-framework/ready/landing-zone/design-area/multi-tenant/considerations-recommendations) | Learn about the limitations of operating within a single Azure Active Directory tenant. Learn key considerations and recommendations for Azure landing zones and Azure Active Directory multitenant scenarios. |

### Extend data in SAP applications

In this three-part series about SAP applications, learn how to [identify SAP data sources](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-identify-sap-data-sources), [choose the best SAP connector](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-choose-azure-connectors), and [optimize performance and troubleshooting](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-data-extraction-performance-troubleshooting). Enterprises use SAP applications as enterprise resource planning (ERP) systems, line of business (LOB) SaaS applications, enterprise data warehouses, business intelligence platforms, or integration platforms. Move SAP workloads to Azure to optimally integrate data into your Azure environment.

### SAP workload storage on Azure

Learn about the platform-level SLAs for various high-availability deployment options. See the [storage types](/azure/cloud-adoption-framework/scenarios/sap/eslz-business-continuity-and-disaster-recovery#storage-for-sap-workloads) that are available for an HA and DR setup for SAP workloads on Azure. Learn about their configuration details and about storage options outside of Azure.

### Automated Azure VMware Solution implementation options

You can implement Azure VMware Solution in multiple ways. The options can be categorized into two broad categories: deployment with connectivity to Azure, and deployment with no connection to Azure. You can automate each of these [deployment options](/azure/cloud-adoption-framework/scenarios/azure-vmware/eslz-platform-automation-and-devops#automated-azure-vmware-solution-implementation-options) by using Azure Bicep, Terraform, and PowerShell.

### Infrastructure as code (IaC)

Explore the benefits of using IaC tools, like Terraform and Azure Bicep, to [keep your Azure landing zone up to date](/azure/cloud-adoption-framework/manage/infrastructure-as-code-updates). IaC can help you reduce the amount of effort required for updates, reduce errors, and manage the update process.

## February 2023

### AI / machine learning strategies for data mesh

Data mesh is a data management methodology that can help you move from a centralized data lake or data warehouse to a domain-driven decentralization of analytics data. It doesn't provide explicit guidance about the approach organizations should take to build AI / machine learning models. This article describes how to [operationalize data mesh for AI / machine learning domain-driven feature engineering]( /azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/architectures/operationalize-data-mesh-for-ai-ml).

### Citrix on Azure landing zone accelerator

The [Citrix on Azure landing zone accelerator](/azure/cloud-adoption-framework/scenarios/wvd/landing-zone-citrix/citrix-enterprise-scale-landing-zone) adapts the Azure Cloud Adoption Framework to provision production-ready Citrix on Azure workloads at scale. It includes key Citrix design guidance and considerations that align with the [design areas](/azure/cloud-adoption-framework/ready/landing-zone/design-areas) of the Cloud Adoption Framework Azure landing zone architecture and best practices. Enterprise-scale design principles that are designed for modularity and scale help organizations with varied requirements start from a consistent foundation. The Citrix on Azure landing zone accelerator includes guidance that's specific to the deployment of Citrix on Azure to help you provide your employees with a consistent experience and access to applications and insights, whether they work in the office, on the road, or at home.

### Cloud Adoption Framework relocate

The new relocate guidance describes the process of moving a workload that's hosted on Azure to a different Azure region. The guidance describes five steps (initiate, evaluate, select, migrate, cutover) and explains how to pick the right relocation strategy for each workload that you want to move. For more information, see [Relocate overview](../relocate/index.md).

## January 2023

### Why update your Azure landing zones?

An Azure landing zone is a set of predefined Azure resources and configurations that provide a foundation for a cloud-based application or workload. It's important that your deployed landing zone environment is kept up to date so you can maintain improved security, avoid platform configuration drift, and stay optimized for new feature releases. Explore the benefits of [keeping your Azure landing zone updated, secure, and optimized](../govern/resource-consistency/keep-azure-landing-zone-up-to-date.md).

### Migrate Azure landing zone policies to Azure built-in policies

Azure landing zone custom policies and policy initiatives might be deprecated or superseded by Azure built-in policies over time. If so, they should be removed or migrated. Explore how to [migrate Azure landing zone custom policies and policy initiatives to Azure built-in policies](../govern/resource-consistency/migrate-azure-landing-zone-policies.md).

### Update Azure landing zone custom policies and policy initiatives

Azure landing zone custom policies and policy initiatives update to newer versions that can then incorporate into an Azure environment. Learn how to [update your Azure landing zone custom policies and policy initiatives when newer versions release](../govern/guides/standard/update-custom-policies.md).

### Azure App Service Cloud Adoption Framework design guidelines for the App Service landing zone accelerator

We're excited to announce updates to our Azure App Service Cloud Adoption Framework design guidelines for the App Service landing zone accelerator. These changes improve the security, governance, platform automation, operations management, identity and access management, and network topology and connectivity considerations for your App Service deployments.

| Article | Description |
|---|---|
| [Security considerations for the App Service landing zone accelerator](../scenarios/app-platform/app-services/security.md) | Security considerations are updated to include new guidance on implementing authentication and authorization, network security, application security, and data security for securing your App Service resources. |
| [Governance considerations for the App Service landing zone accelerator](../scenarios/app-platform/app-services/governance.md) | Governance considerations are updated to include new guidance on implementing deployment strategy, data management, monitoring, logging, cost management, resource management, and access control for enforcing compliance and governance standards. |
| [Platform automation and DevOps for the App Service landing zone accelerator](../scenarios/app-platform/app-services/platform-automation-and-devops.md) | Platform automation and DevOps for the landing zone accelerator is updated to include new guidance on implementing an infrastructure-as-code deployment strategy and Azure DevOps for automating the deployment and management of your App Service resources.
| [Operations management considerations for the App Service landing zone accelerator](../scenarios/app-platform/app-services/management.md) | Operations management considerations are updated to include new guidance on implementing scaling, monitoring, alerting, diagnostics, security, and compliance in your App Service resources. |
| [Identity and access management](../scenarios/app-platform/app-services/identity-and-access-management.md) | Identity and access management considerations for the App Service landing zone accelerator are updated to include new guidance on implementing security and control over network access to multitenant App Service and App Service Environment. |
| [Network topology and connectivity](../scenarios/app-platform/app-services/network-topology-and-connectivity.md) | Network topology and connectivity considerations for the App Service landing zone accelerator are updated to include new guidance on implementing security and control over network access to multitenant App Service and App Service Environment. |

We encourage you to review these updates and incorporate them into your App Service deployments. As always, we welcome your feedback and suggestions for future improvements.

<!-- docutune:ignoreNextStep -->
