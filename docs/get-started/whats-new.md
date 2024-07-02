---
title: What's new in the Microsoft Cloud Adoption Framework
description: Learn about recent updates to the Microsoft Cloud Adoption Framework for Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 07/02/2024
ms.topic: conceptual
ms.custom: UpdateFrequency.5, historical
---

# What's new in the Microsoft Cloud Adoption Framework for Azure

We build the Microsoft Cloud Adoption Framework collaboratively with our customers, partners, and internal Microsoft Teams. We release new and updated content for the framework as it becomes available. These new releases pose an opportunity for you to test, validate, and refine the Cloud Adoption Framework guidance along with us.

Partner with us in our ongoing effort to develop the Cloud Adoption Framework.

## June 2024

### New articles

- [Establish common subscription vending product lines](../ready/landing-zone/design-area/subscription-vending-product-lines.md): Give application teams the flexibility to deliver their workloads and services effectively by offering different subscription vending product lines. Implement subscription vending in your Azure landing zones to establish consistent scaling, security, and governance of Azure environments.

### Updated articles

- [Ready methodology for hybrid and multicloud strategy](../scenarios/hybrid/ready.md): We updated this article to include Azure Arc-enabled VMware vSphere and Azure Arc-enabled System Center Virtual Machine Manager.
- [How to select a strategy for relocating cloud workloads](../relocate/select.md): We updated the guidance on service and data-relocation automation methods.

We updated these articles to provide the latest guidance on Azure Carbon Optimization:

- [Sustainability considerations in cloud management](../manage/considerations/sustainability.md)
- [Sustainability outcomes and benefits for business](../strategy/business-outcomes/sustainability.md)

## May 2024

### New articles

This month, we introduced a new article related to Azure Virtual Network Manager that has recommendations for networking topologies in Azure landing zones. We also added new articles that have guidance on Oracle Database@Azure. Take a look at the new content to see how you can apply these recommendations in your organization.

#### Azure Virtual Network Manager

- [Azure Virtual Network Manager in Azure landing zones](../ready/azure-best-practices/azure-virtual-network-manager.md): Use Azure's Virtual Network Manager to implement landing zone design principles for application migrations, modernization, and innovation at scale. Learn more about two recommended networking topologies: Azure Virtual WAN and traditional hub-and-spoke. The Virtual Network Manager allows for the expansion and implementation of networking changes as business requirements evolve. See how these changes can be made without disrupting deployed Azure resources.

#### Oracle Database@Azure

Explore new articles on Oracle Database@Azure.

- [Introduction to the Oracle on Azure adoption scenario](../scenarios/oracle-iaas/index.md): Learn how to set up and manage Oracle workloads within your Azure landing zone. Learn about specific architectural strategies and implementations for Oracle database systems on Azure.
- [Identity and access management for Oracle Database@Azure](../scenarios/oracle-iaas/oracle-iam-odaa.md): Learn key tactics for proper identity and access management for Oracle Database@Azure. Deploy your initial Oracle Database@Azure instance to create specific groups within Microsoft Entra ID and in the corresponding tenant. Learn how to use Microsoft Entra administrator groups and how to establish other groups and roles to enhance the granularity of access permissions.
- [Network topology and connectivity for Oracle on Azure Virtual Machines](../scenarios/oracle-iaas/oracle-network-topology-iaas.md): Learn about network topology and connectivity considerations for running Oracle on Azure Virtual Machines. Explore the importance of security for Oracle workloads, and receive a high-level network design with various recommendations.
- [Network topology and connectivity for Oracle Database@Azure](../scenarios/oracle-iaas/oracle-network-topology-odaa.md): Learn how to set up network topologies and connectivity for Oracle Database@Azure. Explore options for physical placement, learn about the use of virtual machine clusters, and learn the importance of private subnets. See how to configure network security groups and why you should use Azure Firewall to protect your Oracle Database@Azure instance.
- [Security guidelines for Oracle Database@Azure](../scenarios/oracle-iaas/oracle-security-overview-odaa.md): Receive design considerations and recommendations for implementing security measures for Oracle Database@Azure. See the importance of a defense-in-depth strategy, which layers multiple defense mechanisms for comprehensive security. This strategy includes strong authentication and authorization frameworks, network security, and encryption of data.

### Updated articles

#### Azure Blueprint deprecation

We made updates to reflect the deprecation of Azure Blueprint.

- [Govern antipatterns](../antipatterns/govern-antipatterns.md)
- [Resource consistency decision guide](../decision-guides/resource-consistency/index.md)
- [Get started: Document foundational alignment decisions](../get-started/cloud-concepts.md)
- [Get started: Secure the enterprise environment](../get-started/security.md)
- [Innovate methodology and maturity modeling](../innovate/best-practices/ci-cd.md)
- [Operational compliance in Azure](../manage/azure-management-guide/operational-compliance.md)
- [Understand the functions of a central IT team](../organize/central-it.md)
- [Function of cloud infrastructure and endpoint security](../organize/cloud-security-infrastructure-endpoint.md)
- [Function of cloud security posture management](../organize/cloud-security-posture-management.md)  
- [Track costs across business units, environments, or projects](../ready/azure-best-practices/track-costs.md)
- [Azure governance design area](../ready/landing-zone/design-area/governance.md)
- [Inventory and visibility considerations](../ready/landing-zone/design-area/management-platform.md)  
- [Azure enterprise scaffold](../resources/migration-with-enterprise-scaffold.md)
- [Tools and templates](../resources/tools-templates.md)
- [Data domains](../scenarios/cloud-scale-analytics/architectures/data-domains.md)
- [Self-serve data platforms](../scenarios/cloud-scale-analytics/architectures/self-serve-data-platforms.md)
- [Ready methodology for hybrid and multicloud strategy](../scenarios/hybrid/ready.md)
- [Balance competing priorities](../strategy/balance-competing-priorities.md)

#### Oracle Database@Azure updates

We updated articles to include guidance on Oracle Database@Azure.

- [Capacity planning for Oracle on Azure](../scenarios/oracle-iaas/oracle-capacity-planning.md)  
- [Plan for Oracle on Azure adoption](../scenarios/oracle-iaas/oracle-landing-zone-plan.md)  
- [Strategic impact of Oracle on Azure](../scenarios/oracle-iaas/oracle-landing-zone-strategy.md)  
- [Migration planning for Oracle on Azure](../scenarios/oracle-iaas/oracle-migration-planning.md)

#### Azure landing zone multiregion updates

We updated articles to provide recommendations for multiregion deployments in Azure landing zones.

- [Define an Azure network topology](../ready/azure-best-practices/define-an-azure-network-topology.md)
- [Resource naming and tagging decision guide](../ready/azure-best-practices/resource-naming-and-tagging-decision-guide.md)
- [Define your tagging strategy](../ready/azure-best-practices/resource-tagging.md)
- [Traditional Azure networking topology](../ready/azure-best-practices/traditional-azure-networking-topology.md)
- [Landing zone regions](../ready/considerations/regions.md)
- [Hybrid identity with Active Directory and Microsoft Entra ID in Azure landing zones](../ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity.md)
- [Management groups](../ready/landing-zone/design-area/resource-org-management-groups.md)  
- [Subscription considerations and recommendations](../ready/landing-zone/design-area/resource-org-subscriptions.md)
- [Resource organization design area overview](../ready/landing-zone/design-area/resource-org.md)  

#### DevOps updates

- [DevOps considerations](../ready/considerations/devops-principles-and-practices.md): The DevOps technologies list was updated to include bootstrapping and infrastructure as code (IaC) tools.

## April 2024

### New articles

This month, we completely refreshed articles related to the Migrate and Govern methodologies in the Cloud Adoption Framework. We also added a few articles about Azure landing zones in the Ready methodology. Take a look to make sure you're applying the relevant recommendations.

#### Migrate methodology refresh

Explore dozens of new and updated articles to guide you through the migration process.

- **Prepare to migrate your workload**
    - [Migrate overview](../migrate/index.md): Learn about the Migrate methodology and how to apply it as you move your workloads to Azure.
    - [Migration preparation checklist](../migrate/prepare/index.md): Follow the checklist to plan for migration and to ensure that you have the right resources and tools in place.
    - [Prepare your landing zone for migration](../migrate/prepare/ready-azure-landing-zone.md): Make sure you understand what you need to do after an Azure landing zone deployment to ensure that the technical environment supports migrations.
    - [Prepare tools and initial migration backlog](../migrate/prepare/tools-backlog.md): Prepare the tools and initial migration backlog that you need to support a migration to Azure.
    - [Select Azure regions for a migration](../migrate/prepare/select-regions-migration.md): Choose the Azure regions that best meet your requirements for a migration.
    - [Align roles and responsibilities](../migrate/prepare/roles-responsibilities.md): Ensure clarity and coverage of essential functions for the migration to Azure by aligning roles and responsibilities across the departments in your organization.
    - [Get support resources and improve skills for migration projects](../migrate/prepare/skills-support.md): Make sure that your team has the right skills and resources to support a migration to Azure. 
    

- **Assess your readiness** 
    - [Migration assessment checklist](../migrate/assess/index.md): Follow the checklist to assess your workload's readiness for migration to the cloud.
    - [Classify workloads for a migration](../migrate/assess/classify.md): Conduct a premigration assessment to classify your workloads based on the data sensitivity.
    - [Evaluate workload readiness](../migrate/assess/evaluate.md): Understand how to adjust your workload to prepare it for migration to the cloud. Learn how to validate all assets and associated dependencies.
    - [Design workload architecture before migration](../migrate/assess/architect.md): Use the Cloud Adoption Framework to define the cloud architecture of a workload before you begin migration.
    

- **Prepare for deployment**
    - [Migration deployment checklist](../migrate/deploy/index.md): Follow the checklist to prepare for the deploy phase of migrating a workload to Azure.
    - [Deploy supporting services for migration projects](../migrate/deploy/deploy-supporting-services.md): Deploy the supporting services that your workloads need as you migrate them to Azure.
    - [Remediate assets prior to migration](../migrate/deploy/remediate.md): Before the migration, remediate assets that you determine to be incompatible with your chosen cloud provider prior.
    - [Replicate assets in a cloud migration](../migrate/deploy/replicate.md): Make sure that you understand the role of replication in the migration process and how to plan for the prerequisites and risks of replication activities. 
    - [Prepare for management activities](../migrate/deploy/prepare-for-management.md): Prepare to carry out management activities after a workload migration is complete. 
    - [Test your migration deployment in Azure](../migrate/deploy/migration-test.md): Perform migration testing in Azure to ensure that your architecture works with the replicated or staged resources.
    
 
- **Complete a migration to Azure**
    - [Migration release checklist](../migrate/release/index.md): Follow the checklist to release a workload to production after a migration to Azure.
    - [Change communication](../migrate/release/change-communication.md): Communicate changes to your organization before, during, and after a migration to Azure.
    - [Perform business testing during a migration](../migrate/release/business-test.md): Perform business testing during a migration to ensure that your workloads are functioning as expected.
    - [Complete the migration to Azure](../migrate/release/complete-migration.md): Complete final steps in the migration to Azure.
    - [Optimize cost after migration](../migrate/release/optimize-cost-after-migration.md): Optimize costs to ensure that you're getting the most value from your cloud resources.
    - [Build a growth mindset by conducting retrospectives](../migrate/release/retrospective.md): Use retrospectives to build a growth mindset in your team and to improve your migration process.
     
- **Explore relevant migration scenarios**
    - [Review product migration scenarios](../migrate/scenarios.md): Review the migration scenarios that are available for your product.


#### Govern methodology refresh

We overhauled our collection of articles in the Govern methodology, making the concepts easier to consume and understand as you set up cloud governance in your organization.

- [Govern overview](../govern/index.md): Learn about the Govern methodology and follow the checklist to apply the methodology in your organization.
- [Improve landing zone governance](../ready/considerations/landing-zone-governance.md): Improve the governance of your landing zones by following the best practices in this article.
- [Build a cloud governance team](../govern/build-cloud-governance-team.md): Create a team that works to ensure the success of cloud governance in your organization.
- [Assess cloud risks](../govern/assess-cloud-risks.md): Assess, prioritize, and document cloud risks.
- [Document cloud governance policies](../govern/document-cloud-governance-policies.md): Define and document what should or shouldn't be done in your cloud environment.
- [Enforce cloud governance policies](../govern/enforce-cloud-governance-policies.md): Apply controls and procedures to align cloud use to the cloud governance policies.
- [Monitor cloud governance](../govern/monitor-cloud-governance.md): Measure how well your cloud environment complies with your cloud governance policies.

#### Ready methodology

Find new articles about Azure landing zones in the Ready methodology.

- [Keep your Azure landing zone up to date](../ready/landing-zone/design-area/keep-azure-landing-zone-up-to-date.md): Make sure that your Azure landing zones are current to maintain improved security, avoid platform configuration drift, and stay optimized for new feature releases.
- [Migrate Azure landing zone custom policies to Azure built-in policies](../ready/landing-zone/design-area/migrate-azure-landing-zone-policies.md): Migrate your deprecated Azure landing zone custom policies to Azure built-in policies.
- [Update Azure landing zone custom policies](../ready/landing-zone/design-area/update-custom-policies.md): Update your Azure landing zone custom policies to ensure that they're current and compliant with the latest Azure policies.

### Updated articles

- [Cloud adoption scenarios](../scenarios/index.md): Extensive revisions help you find scenarios that are relevant to your organization's cloud adoption journey.
- [Abbreviation recommendations for Azure resources](../ready/azure-best-practices/resource-abbreviations.md): Find updates about the data-collection and alert-processing rules.
- [Zero trust configuration for multitenant defense organizations](../scenarios/defense/identity/multi-tenant/zero-trust-configuration.md): Review a new multitenant architecture diagram and information about Microsoft Entra ID Protection.
- [The Azure Well-Architected Framework for HPC](../scenarios/azure-hpc/well-architected-framework.md): Explore updates related to ExpressRoute.
- [Manufacturing HPC storage in Azure](../scenarios/azure-hpc/manufacturing/storage.md): Learn about updates related to Azure Managed Lustre.


## March 2024

### Updated articles

- [Azure governance design area](../ready/landing-zone/design-area/governance.md): Explore a new section for third-party tooling, including guidance for AzAdvertizer and Azure Governance Visualizer. 
- [Tools and templates](../resources/tools-templates.md): Find information about governance for AzAdvertizer.
- [Resource consistency decision guide](../decision-guides/resource-consistency/index.md): Check out our expanded information about basic grouping for resource groups.
- [Select Azure regions](../ready/azure-setup-guide/regions.md): We added guidance about how to plan Azure resource group deployments.  
- [Transition an existing Azure environment to the Azure landing zone conceptual architecture](../ready/enterprise-scale/transition.md): Find tip to help you reduce the impact of regional outages.
- [Security guidelines for Oracle on Azure Virtual Machines landing zone accelerator](../scenarios/oracle-iaas/oracle-security-guideline-landing-zone.md): Review new use cases for centralized identity management. These use cases include using Azure Key Vault to store credentials and using hardened operating system images.
- [Storage for Azure HPC in the finance sector](../scenarios/azure-hpc/finance/storage.md): Find new data to help you compare Azure Managed Lustre with Blob Storage, Azure Files, and Azure NetApp Files.
- [Network topology and connectivity for an SAP migration](../scenarios/sap/eslz-network-topology-and-connectivity.md): Explore design recommendations for Azure ExpressRoute.

## February 2024

### New articles

- [Application identity and access management](../ready/landing-zone/design-area/identity-access-application-access.md): Learn about recommendations that application owners and developers can use to design the identity and access management for cloud-native applications.  

### Updated articles

- [Hybrid identity with Active Directory and Microsoft Entra ID in Azure landing zones](../ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity.md): We updated this article to include information about how to design and implement Microsoft Entra ID and hybrid identity for Azure landing zones. Microsoft Entra ID is a cloud-based identity and access management service that provides robust capabilities to manage users and groups. You can use it as a standalone identity solution or integrate it with a Microsoft Entra Domain Services infrastructure or an on-premises Active Directory Domain Services (AD DS) infrastructure.
- [Landing zone identity and access management](../ready/landing-zone/design-area/identity-access-landing-zones.md): Find out about considerations and recommendations for implementing identity and access control within Azure application and platform landing zones. This article has extensive new content.
- [Azure identity and access management design area](../ready/landing-zone/design-area/identity-access.md): Learn about the identity and access management design area, which provides best practices to establish the foundation of your public cloud architecture. This article has extensive new content.
- [Cloud adoption journey](../adopt/cloud-adoption.md): Learn about various types of cloud adoption journeys, including when to retire, replace, rearchitect, rebuild, rehost, or replatform your solution.
- [Azure migration tools decision guide](../migrate/azure-migration-guide/migration-tools-decision-guide.md): We added information about tools for application migration, modernization, replatforming, and rehosting.
- [Azure workload management and monitoring](../ready/landing-zone/design-area/management-workloads.md): Find new guidance about sovereign workloads.

## January 2024

### New articles

- [Define a sovereignty strategy](../strategy/define-sovereignty-strategy.md): Organizations that use cloud services can find guidance for meeting the sovereignty requirements for their countries/regions. We also updated several articles with sovereignty considerations, which you'll find under the "Updated articles" section for this month.

- [Advanced Azure Policy management](../ready/policy-management/enterprise-policy-as-code.md): Find out how to manage Azure Policy at scale by using the Enterprise Policy as Code (EPAC) open-source project and integrating IaC into your environment.

### Updated articles

- [Plan for IP addressing](../ready/azure-best-practices/plan-for-ip-addressing.md): We added information about IPv6 considerations. Find recommendations to help you plan for IPv6 and implement it in your existing Azure networks.

- [Network topology and connectivity for Azure Arc-enabled servers](../scenarios/hybrid/arc-enabled-servers/eslz-arc-servers-connectivity.md): Find updates about how to overcome the management challenges involved in using Private Link.

- New sovereignty considerations can be found in the following updated articles:
  - [Select Azure regions for a migration](../migrate/azure-best-practices/multiple-regions.md)
  - [Azure migration tools decision guide](../migrate/azure-migration-guide/migration-tools-decision-guide.md)
  - [Select Azure regions](../ready/azure-setup-guide/regions.md)
  - [Security design in Azure](../ready/landing-zone/design-area/security.md)

- We also added information about application migration tools and strategies. Find updates in these articles:

  - [Cloud adoption journey](../adopt/cloud-adoption.md): Learn about rearchitecting or rebuilding applications that can't be replaced by SaaS or low-code solutions.
  - [Migration tools decision guide](../migrate/azure-migration-guide/migration-tools-decision-guide.md): Explore tools for application migration and modernization and tools for replatforming or rehosting.

## December 2023

### New articles

Find new guidance about Azure landing zones:

- [Manage application development environments in Azure landing zones](../ready/landing-zone/design-area/management-application-environments.md)
- [Modify an Azure landing zone architecture to meet requirements across multiple locations](../ready/landing-zone/landing-zone-multinational.md)
- [Incorporate Zero Trust practices in your landing zone](../ready/landing-zone/design-area/security-zero-trust.md)

### Updated articles

In the following articles, find updated guidance about workload discovery processes that help you understand the many dimensions involved in migrating a workload. You can use that information to help you effectively migrate cloud workloads to another region.

- [Evaluate a cloud workload for relocation](../relocate/evaluate.md)
- [Migrate a cloud workload to another region](../relocate/migrate.md)
- [How to initiate a cloud relocation project](../relocate/initiate.md)

In [Centralized security operations with external identities for multitenant defense organizations](../scenarios/defense/identity/multi-tenant/security-operations.md), we updated our guidance for centralized security operations. 

In [Identity and access management for Azure Virtual Desktop](../scenarios/azure-virtual-desktop/eslz-identity-and-access-management.md), we added updates for Azure Virtual Desktop design considerations and supported identity scenarios.

## November 2023

### Sovereignty requirements

This new article describes how to meet digital sovereignty requirements when you adopt cloud computing. The Azure landing zone FAQ has been updated with material that corresponds to the sovereignty considerations article.

- [Sovereignty considerations for Azure landing zones](../ready/landing-zone/sovereign-landing-zone.md)

- [Azure landing zone FAQ](../ready/enterprise-scale/faq.md)

## October 2023

### HPC baseline computing

HPC baseline computing updates and new articles describe the benefits of Azure HPC OnDemand Platform (AzHop), compare the features of Azure Batch and Azure CycleCloud, and provide a large-scale HPC architecture for the finance industry.

- [Azure landing zone for HPC](../scenarios/azure-hpc/ready.md)

- [Finance HPC Azure identity and access management](../scenarios/azure-hpc/finance/identity-access-management.md)
- [Run large-scale HPC application workloads for the finance industry on Azure virtual machines](../scenarios/azure-hpc/finance/compute.md)
- [Big compute in the manufacturing industry](../scenarios/azure-hpc/manufacturing/compute.md)

### Brownfield alignment scenarios

This series starts with an introduction that describes recommendations for transitioning an existing Azure environment into an Azure landing zone conceptual architecture. It includes considerations for moving resources and subscriptions. There are four distinct articles that describe transitioning scenarios based on the existing Azure environment. The final article provides guidance about maintaining a cloud environment over time.

- [Transition an existing Azure environment to the Azure landing zone conceptual architecture](../ready/enterprise-scale/transition.md)
- [Scenario: Transition a single subscription with no management groups to the Azure landing zone conceptual architecture](../ready/landing-zone/align-scenario-single-subscription.md)
- [Scenario: Transition management groups to the Azure landing zone conceptual architecture](../ready/landing-zone/align-scenario-multiple-management-groups.md)
- [Scenario: Transition a regional organization environment to the Azure landing zone conceptual architecture](../ready/landing-zone/align-scenario-regional-org.md)
- [Scenario: Transition an environment by duplicating a landing zone management group](../ready/landing-zone/align-approach-duplicate-brownfield-audit-only.md)
- [Journey toward the target architecture](../ready/landing-zone/landing-zone-journey.md)

### Updated CAF Azure regions decision guide

Learn how to [select Azure regions for your cloud footprint](../ready/azure-setup-guide/regions.md) by considering the characteristics of each region, like availability zones, region pairs, available services, and nonfunctional requirements, like region proximity and capacity. We’ve also provided new guidance about operating across multiple Azure regions. As part of this change, we simplified the [guidance about selecting Azure regions for migrations](../migrate/azure-best-practices/multiple-regions.md).

### Network topology and connectivity for Azure Virtual Desktop

The [updates to the Network topology and connectivity for Azure Virtual Desktop article](../scenarios/azure-virtual-desktop/eslz-network-topology-and-connectivity.md) describe two new scenarios to help you understand how to manage network topology and connectivity at scale in Azure Virtual Desktop. The first scenario describes a hub-and-spoke architecture with hybrid connectivity over managed networks. The second scenario describes a hub-and-spoke architecture with public networks. Both scenarios use Remote Desktop Protocol Shortpath (RDP Shortpath).

## September 2023

### Plan for IP addressing

This article was updated with relevant information about IPv4 exhaustion and IPAM (IP address management) tools.

- [Plan for IP addressing](../ready/azure-best-practices/plan-for-ip-addressing.md).

### Guidance for documenting and deploying alerts

To support the imminent general availability of Azure Monitor baseline alerts for an Azure landing zone, we have created Cloud Architecture Framework documentation about baseline alerts. Find out what baseline alerts are and where to go for more information about how to enhance your Azure platform by using Azure Monitor alerts.

-   [Monitor Azure platform landing zone components](../ready/landing-zone/design-area/management-monitor.md)

-   [Inventory and visibility considerations](../ready/landing-zone/design-area/management-platform.md)

### Azure VMware Solution network design guides

These guides describe the Microsoft-recommended approach to help you design network connectivity for Azure VMware Solution private clouds. They explore four design areas: connectivity with on-premises sites, connectivity with Azure virtual networks, inbound internet connectivity, and outbound internet connectivity. Each design area is covered in a dedicated article, which presents architectural options, including their pros and cons. There are also two articles that cover the basics of Azure VMware Solution networking and guidance on how to prioritize requirements and related design areas.

- [Azure VMware Solution network design guide](../scenarios/azure-vmware/network-design-guide-intro.md)

- [Azure VMware Solution network design guide: Inbound internet connectivity](../scenarios/azure-vmware/network-design-guide-internet-inbound-connectivity.md)

- [Azure VMware Solution network design guide: Networking basics](../scenarios/azure-vmware/azure-vmware-solution-network-basics.md)

- [Azure VMware Solution network design guide: Outbound internet connectivity](../scenarios/azure-vmware/network-design-guide-internet-outbound-connectivity.md)

- [Azure VMware Solution network design guide: Connectivity with on-premises sites](../scenarios/azure-vmware/on-premises-connectivity.md)

- [Azure VMware Solution network design guide: Connectivity with Azure virtual networks](../scenarios/azure-vmware/virtual-network-connectivity.md)

## July 2023

### Landing zone regions

This article explains how landing zones use Azure regions. It also explains how to add a region to an existing landing zone and considerations for migrating your Azure estate to a different region.

- [Landing zone regions](../ready/considerations/regions.md)

### Enhanced migration guidance

This article describes how to ensure that configurations are in place when you migrate your landing zone. It explores tasks, such as preparing your identity, enabling hybrid Domain Name System (DNS) services, and enabling subscription vending.

- [Readying your landing zone for migration](../migrate/azure-migration-guide/ready-alz.md)

### New best practices for SAP landing zone accelerator security on Azure

This series provides guidance for your SAP environment in Azure. You can find best practices for security operations to secure your SAP environment in Azure, security recommendations for SAP on Azure that runs on a SQL Server database, and guidance about the flow of SAP data from source SAP systems to downstream targets. Learn how to use Azure Synapse Analytics to build a modern data platform to ingest, process, store, serve, and visualize data from various sources.

- [SAP data integration example architecture](../scenarios/sap/sap-lza-data-example-architecture.md)

- [Data integration security for SAP on Azure](../scenarios/sap/sap-lza-data-integration-security.md)

- [SQL Server database security for SAP on Azure](../scenarios/sap/sap-lza-database-security.md)

- [Security operations for SAP on Azure](../scenarios/sap/sap-lza-security-operations.md)

- [Microsoft Sentinel for SAP on Azure](../scenarios/sap/sap-lza-sentinel-for-sap.md)

<!-- docutune:ignoreNextStep -->
