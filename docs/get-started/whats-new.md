---
title: What's new in the Microsoft Cloud Adoption Framework
description: Learn about recent updates to the Microsoft Cloud Adoption Framework for Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 10/06/2023
ms.topic: conceptual
ms.custom: UpdateFrequency.5, historical
---

# What's new in the Microsoft Cloud Adoption Framework for Azure

We build the Microsoft Cloud Adoption Framework collaboratively with our customers, partners, and internal Microsoft Teams. We release new and updated content for the framework as it becomes available. These new releases pose an opportunity for you to test, validate, and refine the Cloud Adoption Framework guidance along with us.

Partner with us in our ongoing effort to develop the Cloud Adoption Framework.

## September 2023

### Plan for IP addressing

Article updated with relevant information about IPv4 exhaustion, and IPAM (IP Address Management) tools.

- [Plan for IP addressing](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-ip-addressing).

### Guidance for documenting and deploying alerts

To support the imminent general availability of Azure Monitor baseline alerts for the Azure landing zone, we have created some Cloud Architecture Framework documentation about baseline alerts. Find out what baseline alerts are and where to go for more information about how to enhance your Azure platform by using Azure Monitor alerts.

-   [Monitor Azure platform landing zone components](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-monitor)

-   [Inventory and visibility considerations](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-platform)

### Azure VMware Solution network design guides

-   [Azure VMware Solution network design guide](/azure/cloud-adoption-framework/scenarios/azure-vmware/network-design-guide-intro)

-   [Azure VMware Solution network design guide: Inbound internet connectivity](/azure/cloud-adoption-framework/scenarios/azure-vmware/network-design-guide-internet-inbound-connectivity)

-   [Azure VMware Solution network design guide: Networking basics](/azure/cloud-adoption-framework/scenarios/azure-vmware/azure-vmware-solution-network-basics)

-   [Azure VMware Solution network design guide: Outbound internet connectivity](/azure/cloud-adoption-framework/scenarios/azure-vmware/network-design-guide-internet-outbound-connectivity)

-   [Azure VMware Solution network design guide: Connectivity with on-premises sites](/azure/cloud-adoption-framework/scenarios/azure-vmware/on-premises-connectivity)

-   [Azure VMware Solution network design guide: Connectivity with Azure virtual networks](/azure/cloud-adoption-framework/scenarios/azure-vmware/virtual-network-connectivity)

## July 2023

### Landing zone regions

This article explains how landing zones use Azure regions. It also explains how to add a region to an existing landing zone, and some considerations when you migrate your Azure estate to a different region.

- [Landing zone regions](/azure/cloud-adoption-framework/ready/considerations/regions)

### Enhanced migration guidance

- [Readying your landing zone for migration](/azure/cloud-adoption-framework/migrate/azure-migration-guide/ready-alz)

### New best practices for SAP LZA security on Azure 

-   [SAP data integration example architecture](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-data-example-architecture)

-   [Data integration security for SAP on Azure](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-data-integration-security)

-   [SQL Server database security for SAP on Azure](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-database-security)

-   [Security operations for SAP on Azure](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-security-operations)

-   [Microsoft Sentinel for SAP on Azure](/azure/cloud-adoption-framework/scenarios/sap/sap-lza-sentinel-for-sap)

## June 2023

### Updated machine learning inference during deployment

-   [Machine learning inference during deployment](/azure/cloud-adoption-framework/innovate/best-practices/ml-deployment-inference)

### New landing zone sandbox environments

-   [Landing zone sandbox environments](/azure/cloud-adoption-framework/ready/considerations/sandbox-environments)

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

Learn about the platform-level SLAs for various high-availability deployment options. See the [storage types](/azure/cloud-adoption-framework/scenarios/sap/eslz-business-continuity-and-disaster-recovery#storage-for-sap-workloads) that are available for an HA and DR setup for SAP workloads on Azure. Learn about their configuration details and about non-Azure Storage service options.

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

## December 2022

### Cloud adoption scenario for defense

The cloud adoption scenario for defense provides universal guidance to help mission owners accelerate digital transformation. The guidance is impartial to country/region and collects best practices from our experience working with defense organizations around the world. Mission owners face unique challenges that are uncommon in other sectors. The defense scenario provides recommendations to help navigate those challenges so mission owners can focus on meeting mission objectives.

We invite you to [explore the defense scenario](../scenarios/defense/index.md) and return to this content regularly throughout your journey. The content highlights critical areas of focus but also refers you to other documentation for deeper technical insight. The result should be a secure, scalable, and governed environment that is tailored to mission needs.

### HPC landing zone accelerator

High-performance computing (HPC) on Azure is the complete set of Azure resources (compute, networking, and storage) integrated with workload orchestration services. HPC on Azure supports applications that provide advanced analytics, graphic-intensive visualizations, and scalable rendering. HPC can run complex simulations for organizations in multiple industries such as manufacturing, energy, and finance.

The HPC landing zone accelerator modernizes HPC workloads on Azure by offering global regulatory compliance, next-generation machine-learning tools, and a framework for architectural best practices. The landing zone accelerator also provides industry-specific architecture references and automation solutions that help you start your HPC journey on Azure.

Use the following links to get started with HPC on Azure:

- [Introduction to the Azure HPC scenario](../scenarios/azure-hpc/index.md)
- [Azure HPC landing zone accelerator](../scenarios/azure-hpc/azure-hpc-landing-zone-accelerator.md)
- [Azure Well-Architected Framework for HPC](../scenarios/azure-hpc/well-architected-framework.md)

## October 2022

### Azure Arc-enabled SQL Managed Instance

Azure Arc-enabled SQL Managed Instance is a data service that you can create on the infrastructure of your choice. Azure Arc-enabled SQL Managed Instance is nearly 100 percent compatible with the latest version of the SQL Server Database Engine. Customers who use SQL Server can migrate their applications to Azure Arc data services, while maintaining data sovereignty, with minimal changes to applications and databases. SQL Managed Instance includes built-in management capabilities that drastically reduce management overhead.

Use the articles in the following table to learn more about Azure Arc-enabled SQL Managed Instance.

| Article | Description |
|-----------------------------|----------------------------------------------------------------------------------------------|
| [Identity and access management for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-identity-access-management.md) | Learn how to improve identity and access management for Azure Arc-enabled SQL Managed Instance deployments. |
| [Network connectivity for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-network-connectivity.md) | Understand the design considerations and recommendations for network connectivity in Azure Arc-enabled SQL Managed Instance. |
| [Storage disciplines for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-storage-disciplines.md) | Learn design considerations and recommendations for storage disciplines with Azure Arc-enabled SQL Managed Instance. |
| [Resource organization for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-resource-organization.md) | Learn how to organize resources when working with Azure Arc-enabled SQL Managed Instance. |
| [Governance and security for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-governance-disciplines.md) | Adopt best practices for governance, security, and compliance on Azure Arc-enabled SQL Managed Instance. |
| [Management and monitoring for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-management-disciplines.md) | Learn about design considerations and recommendations for the management and monitoring of Azure Arc-enabled SQL Managed Instance. |
| [Deploy a sandbox for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/enterprise-scale-landing-zone-sandbox.md) | Learn how to deploy Azure Arc-enabled data services to an Azure landing zone in a sandbox subscription to accelerate your adoption of hybrid or multicloud architectures. |
| [Business continuity and disaster recovery for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-business-continuity-disaster-recovery.md) | Learn how to implement business continuity and disaster recovery for Azure Arc-enabled SQL Managed Instance. |
| [Upgradeability disciplines for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-upgradeability-disciplines.md) | Learn how to implement upgradeability disciplines for Azure Arc-enabled SQL Managed Instance. |
| [Cost governance for Azure Arc-enabled SQL Managed Instance](../scenarios/hybrid/arc-enabled-data-service-sql-managed-instance/eslz-arc-data-service-sql-managed-instance-cost-governance.md) | Learn design considerations and recommendations on cost governance for Azure Arc-enabled SQL Managed Instance. |

<!-- docutune:ignoreNextStep -->
