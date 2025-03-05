---
title: What's new in the Microsoft Cloud Adoption Framework
description: Learn about recent updates to the Microsoft Cloud Adoption Framework for Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/04/2025
ms.topic: conceptual
ms.custom: UpdateFrequency.5, historical
---

# What's new in the Microsoft Cloud Adoption Framework for Azure

We build the Microsoft Cloud Adoption Framework collaboratively with our customers, partners, and internal Microsoft Teams. We release new and updated content for the framework as it becomes available. These new releases pose an opportunity for you to test, validate, and refine the Cloud Adoption Framework guidance along with us.

Partner with us in our ongoing effort to develop the Cloud Adoption Framework.

## February 2025

### New articles

- [Network topology and connectivity for Oracle Database@Azure - Application connectivity design](../scenarios/oracle-iaas/application-connectivity-design.md): Learn how to establish direct connectivity between database and application virtual machines (VMs) in Oracle IaaS environments. Explore the importance of secure and efficient network configurations to ensure seamless communication and optimal performance.
- [Network topology and connectivity for Oracle Database@Azure - BCDR connectivity design](../scenarios/oracle-iaas/business-continuity-disaster-recovery-connectivity-design.md): Explore comprehensive guidance on designing network connectivity for high availability and disaster recovery of Oracle Exadata Database@Azure deployments. Learn about redundancy strategies both within a single region and across multiple regions, emphasizing the use of Azure and OCI networking, availability zones, and Data Guard configurations.
- [Network topology and connectivity for Oracle Database@Azure - Core network design](../scenarios/oracle-iaas/core-network-design.md): Find essential guidance on designing the core network for Oracle Exadata Database@Azure, including key networking concepts, like the unique architecture of Oracle Database@Azure, and design considerations such as availability zone selection, subnet sizing, and network security group configuration.
- [Network topology and connectivity for Oracle Database@Azure - Migration connectivity design](../scenarios/oracle-iaas/migration-connectivity-design.md): Learn how to design connectivity solutions for Oracle Infrastructure as a Service (IaaS) migration scenarios. Explore best practices for ensuring secure, reliable, and efficient network architectures to facilitate the migration process.
- [Resource organization for Oracle Database@Azure](../scenarios/oracle-iaas/oracle-resource-organization-oracle-database-azure.md): Learn best practices for naming and tagging conventions, security and isolation architectures, and subscription design. Explore how to use a multiple subscription architecture to isolate different environments such as production, development, and testing.

### Updated articles

- [Inventory and visibility considerations](../ready/landing-zone/design-area/management-platform.md): We added information on application teams and their responsibilities for inventory and visibility, including the use of Azure Monitor Agent and Log Analytics workspaces.
- [Management and monitoring for Azure VMware Solution](../scenarios/azure-vmware/eslz-management-and-monitoring.md): We added references to Azure Monitor baselines alerts (AMBA).
- [Monitor a cloud environment](../manage/monitor/monitoring.md): We restructured the table providing listed guidance on monitoring for Azure services to be more consistent and easier to read.
- [Plan for inbound and outbound internet connectivity](../ready/azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md): We made updates to include guidance on ensuring that Management NIC is enabled with all Azure Firewall deployments.
- [Resource organization considerations for Azure Virtual Desktop](../scenarios/azure-virtual-desktop/eslz-resource-organization.md): We added guidance on naming and tagging standards and introduced sections on the scope of management settings, components, naming standards, and resource tags.

We made updates to these articles to reflect the latest guidance on migrating to virtual network flow logs due to the upcoming retirement of NSG flow logs:

- [Plan for landing zone network segmentation](../ready/azure-best-practices/plan-for-landing-zone-network-segmentation.md)
- [Plan for traffic inspection](../ready/azure-best-practices/plan-for-traffic-inspection.md)

#### Oracle updates

- [Manage and monitor Oracle workloads on Azure Virtual Machines landing zone accelerator](../scenarios/oracle-iaas/oracle-manage-monitor-iaas.md): We made updates to refresh the content and improve clarity. This article provides guidance on managing and monitoring Oracle workloads on Azure Virtual Machines, including best practices for performance optimization, security, and compliance.
- [Security guidelines for Oracle Database@Azure](../scenarios/oracle-iaas/oracle-security-overview-odaa.md): We added detailed descriptions of the integration between Azure and Oracle Cloud Infrastructure (OCI) for managing Oracle Exadata Database@Azure resources. We also added design considerations such as: The need for network security groups (NSGs) and network address translation (NAT) configurations; Guidelines for storing and managing encryption keys and database backups; Recommendations for the deployment and management of non-Microsoft and Oracle agents.

## January 2025

### New articles

- [Capacity Planning for Oracle Database@Azure Using Exadata Database Service](../scenarios/oracle-iaas/oracle-capacity-planning-oracle-database-azure.md): Learn how to plan for capacity when migrating Oracle Database to Azure using Exadata Database Service. Explore key considerations for capacity planning, including workload analysis, performance tuning, and resource allocation. Recommendations include planning for sufficient IP address ranges, scaling infrastructure based on workload requirements, and understanding storage configuration impacts.

#### Strategy methodology refresh

This month, we made significant updates to the Strategy methodology. The Strategy methodology provides guidance on how to develop a cloud adoption strategy that aligns with your organization's goals and objectives. The methodology includes the following articles:

- [Develop a cloud adoption strategy](../strategy/index.md): Learn how to develop a cloud adoption strategy to migrate or innovate in the cloud, in alignment with your business goals.
- [Assess your cloud adoption strategy](../strategy/assessment.md): Learn about the importance of assessing your cloud adoption strategy and how to evaluate your current state, define your future state, and identify gaps and opportunities.
- [Determine your motivations](../strategy/motivations.md): Learn how to identify your motivations for adopting cloud technologies and how to classify them based on your organization's goals and objectives.
- [Define your mission and objectives](../strategy/mission-objectives.md): Find recommendations for defining your mission and objectives to provide direction and purpose for your cloud adoption.
- [Define your strategy team](../strategy/define-your-team.md): Learn about the key roles and responsibilities of a cloud strategy team and how to build a cross-functional team to drive your cloud adoption strategy.
- [Prepare your organization](../strategy/prepare-organizational-alignment.md): Learn how to align your cloud adoption strategy with your organization's goals and objectives.
  - [Inform your cloud adoption strategy](../strategy/inform/index.md): Learn about the importance of informing your cloud adoption strategy and how to gather information, assess your current state, and define your future state.
  - [Cost efficiency considerations](../strategy/inform/cost-efficiency.md): Learn about the importance of financial efficiency and how to optimize costs in your cloud adoption strategy.
  - [AI considerations](../strategy/inform/ai.md): Learn about considerations for integrating AI into your cloud adoption strategy. Use analytics, machine learning, and automation to optimize operations.
  - [Resiliency considerations](../strategy/inform/resiliency.md): Explore guidance on improving your infrastructure5's ability to maintain functionality and availability despite disruptions or failures.
  - [Security considerations](../strategy/inform/security.md): Learn how to design your cloud infrastructure with security in mind to protect your data and applications from unauthorized access and data breaches.
  - [Sustainability considerations](../strategy/inform/sustainability.md): Explore how to incorporate sustainability into your cloud strategy. Use Azure to drive your sustainability efforts.

### Updated articles

- [Define your naming convention](../ready/azure-best-practices/resource-naming.md): We reviewed this article for freshness and accuracy, introducing more consistent terminology for workload, application, and project names. We also added guidance on the Azure Naming Tool and the importance of understanding naming rules and restrictions.
- [DNS for on-premises and Azure resources](../ready/azure-best-practices/dns-for-on-premises-and-azure-resources.md): Explore new design considerations and recommendations emphasizing the use of Azure DNS Private Resolver with Azure Private DNS zones and detailed guidance on deploying DNS infrastructure.
- [Governance disciplines for SAP on Azure](../scenarios/sap/eslz-security-governance-and-compliance.md): Explore new guidance for using Microsoft Defender for Endpoint on Linux and Windows for SAP hosts and new sections on the Microsoft Sentinel solution for SAP. We also added enhanced recommendations for secure authentication with Microsoft Entra ID and links to more detailed design considerations and identity management sections.
- [Identity and access management for SAP on Azure](../scenarios/sap/eslz-identity-and-access-management.md): Learn about securing Network File System (NFS) communication and Remote Function Call (RFC) connections, as well as SAP user governance and provisioning. Explore new recommendations for implementing single sign-on (SSO) with various SAP applications using Microsoft Entra ID.
- [Monitor a cloud environment](../manage/monitor/monitoring.md): We added a new reference table providing links to monitoring guidance for various Azure services and resources. This table helps you quickly find the monitoring guidance you need for your specific Azure resources.
- [Network topology and connectivity for Azure Arc-enabled servers](../scenarios/hybrid/arc-enabled-servers/eslz-arc-servers-connectivity.md): Explore new guidance on Azure Arc Gateway including instructions for defining agent connectivity methods.
- [Organize your Azure resources effectively](../ready/azure-setup-guide/organize-resources.md): Find updated links for management group design, subscription considerations, and tagging strategy. Updates emphasize the importance of applying critical settings at higher levels and project-specific requirements at lower levels, and include additional details on naming conventions and resource tagging to enhance resource identification and management.
- [Review product migration scenarios](../migrate/scenarios.md): Explore the new Google Cloud Platform scenario for migrating virtual machines to Azure.

#### AI Adoption updates

- [AI Governance for PaaS workloads](../scenarios/ai/platform/governance.md): Learn how to control the models you allow across Azure and deployed in Azure AI Foundry.
- [Secure AI](../scenarios/ai/secure.md): Learn how to conduct red team testing on generative AI and nongenerative AI models.

#### Oracle updates

- [Business continuity and disaster recovery considerations for Oracle Database@Azure](../scenarios/oracle-iaas/oracle-disaster-recovery-oracle-database-azure.md): We added new design considerations and recommendations for multiple-zone and multiregional BCDR architectures, extended BCDR scenarios, backup recommendations, and introduced additional best practices for maintaining data resilience and automating failover operations.
- [Identity and access management for Oracle Database@Azure](../scenarios/oracle-iaas/oracle-iam-odaa.md): Explore new sections covering considerations for private offers, default group creation, custom group names, federation with non-Microsoft identity providers, and enhanced RBAC permissions.
- [Migration Planning for Oracle on Azure](../scenarios/oracle-iaas/oracle-migration-planning.md):  We introduced new sections on Oracle Database@Azure migration, online and offline migration paths, and an ExpressRoute-based migration duration reference table.

#### Azure Landing Zone updates

- [Deploy Azure landing zones by using Terraform](../ready/landing-zone/deploy-landing-zones-with-terraform.md): Explore new guidance on various network architectures, including multiple-region virtual WAN with Azure Firewall, multiple-region hub and spoke virtual network, and single-region virtual WAN with Azure Firewall. Explore how to use Azure Verified Modules for Platform Landing Zones Terraform for infrastructure as code deployments.
- [Migrate Azure landing zone custom policies to Azure built-in policies](../ready/landing-zone/design-area/migrate-azure-landing-zone-policies.md): Find refreshed migration guidance detailing the use of Azure Verified Modules for Platform Landing Zones, and updated references to Terraform and Bicep module resources.
- [What is an Azure landing zone](../ready/landing-zone/index.md): We updated guidance on the use of Bicep and Terraform for deploying platform landing zones and added a more detailed description of the Azure Platform Landing Zones Portal Accelerator.

## December 2024

### New articles

- [Authorization for cloud-scale analytics in Azure](../scenarios/cloud-scale-analytics/secure-authorization.md): Find guidance on managing data access and role-based access control (RBAC) for cloud-scale analytics. Learn how to use Microsoft Entra ID for centralized identity management, implementing RBAC and Access Control Lists (ACLs) for data services, and best practices for securing Azure Databases, Azure Data Lake Storage, and Azure Databricks.

#### Azure HPC

This month, we refactored the Azure high-performance computing (HPC) scenario to provide refreshed guidance on compute, identity and access management, network topology and connectivity, and storage for HPC workloads in Azure. Explore the new content to see how you can apply these recommendations in your organization:

- [Compute Large-Scale HPC Application Workloads in Azure Virtual Machines](../scenarios/azure-hpc/compute.md)
- [Identity and Access Management for Azure HPC](../scenarios/azure-hpc/identity-access-management.md)
- [Network Topology and Connectivity for Azure HPC](../scenarios/azure-hpc/network-topology-connectivity.md)
- [Storage for Azure HPC Workloads](../scenarios/azure-hpc/storage.md)
- [Azure HPC landing zone accelerator](../scenarios/azure-hpc/azure-hpc-landing-zone-accelerator.md)

### Updated articles

- [Enterprise-Scale Example Architectures for Connectivity to Azure VMware Solution](../scenarios/azure-vmware/example-architectures.md): We made changes to clarify various architectural considerations and requirements including traffic inspection requirements and recommended solution designs for different scenarios. We enhanced the description of key networking scenario points and added a new section on enabling Azure VMware Solution to on-premises traffic inspection with Azure Firewall.

We made security updates to the following Cloud Scale Analytics articles:

- [Common Data Model](../scenarios/cloud-scale-analytics/architectures/common-industry-data-models.md)
- [Network topology and connectivity for connecting to environments privately](../scenarios/cloud-scale-analytics/architectures/connect-to-environments-privately.md)
- [Cloud-scale analytics data applications (source-aligned)](../scenarios/cloud-scale-analytics/architectures/data-application-source-aligned.md)
- [Data contracts](../scenarios/cloud-scale-analytics/architectures/data-contracts.md)
- [Data domains](../scenarios/cloud-scale-analytics/architectures/data-domains.md)
- [Cloud-scale analytics data products in Azure](../scenarios/cloud-scale-analytics/architectures/data-landing-zone-data-products.md)
- [Data landing zones](../scenarios/cloud-scale-analytics/architectures/data-landing-zone.md)
- [Data management landing zone overview](../scenarios/cloud-scale-analytics/architectures/data-management-landing-zone.md)
- [Getting started checklist](../scenarios/cloud-scale-analytics/architectures/data-mesh-checklist.md)
- [Data marketplace](../scenarios/cloud-scale-analytics/architectures/data-mesh-data-marketplace.md)
- [Manage master data in data mesh](../scenarios/cloud-scale-analytics/architectures/data-mesh-master-data-management.md)
- [A financial institution scenario for data mesh](../scenarios/cloud-scale-analytics/architectures/data-mesh-scenario.md)
- [Data application reference patterns](../scenarios/cloud-scale-analytics/architectures/data-reference-patterns.md)
- [Operationalize data mesh for AI/ML domain driven feature engineering](../scenarios/cloud-scale-analytics/architectures/operationalize-data-mesh-for-ai-ml.md)
- [Adatum Corporation scenario for cloud-scale analytics in Azure](../scenarios/cloud-scale-analytics/architectures/reference-architecture-adatum.md)
- [Lamna Healthcare scenario for cloud-scale analytics in Azure](../scenarios/cloud-scale-analytics/architectures/reference-architecture-lamna.md)
- [Multiple data zones for cloud-scale analytics in Azure](../scenarios/cloud-scale-analytics/architectures/reference-architecture-multizone.md)
- [Scale cloud-scale analytics in Azure](../scenarios/cloud-scale-analytics/architectures/scale-architectures.md)
- [Data agnostic ingestion engine](../scenarios/cloud-scale-analytics/best-practices/automated-ingestion-pattern.md)
- [The ingest process with cloud-scale analytics in Azure](../scenarios/cloud-scale-analytics/best-practices/data-ingestion.md)
- [Business continuity and disaster recovery for cloud-scale analytics](../scenarios/cloud-scale-analytics/eslz-business-continuity-and-disaster-recovery.md)
- [Identity and access management for cloud-scale analytics](../scenarios/cloud-scale-analytics/eslz-identity-and-access-management.md)
- [Cross-region data landing zone connectivity](../scenarios/cloud-scale-analytics/eslz-network-considerations-cross-region.md)
- [Single-region data landing zone connectivity](../scenarios/cloud-scale-analytics/eslz-network-considerations-single-region.md)
- [Network topology and connectivity for cloud-scale analytics landing zones](../scenarios/cloud-scale-analytics/eslz-network-topology-and-connectivity.md)
- [Policies in cloud-scale analytics](../scenarios/cloud-scale-analytics/eslz-policies.md)
- [Security, governance, and compliance for enterprise-scale cloud-scale analytics](../scenarios/cloud-scale-analytics/eslz-security-governance-and-compliance.md)
- [Data governance processes](../scenarios/cloud-scale-analytics/govern-components.md)
- [Data quality](../scenarios/cloud-scale-analytics/govern-data-quality.md)
- [Data lifecycle management](../scenarios/cloud-scale-analytics/govern-lifecycle.md)
- [Data lineage](../scenarios/cloud-scale-analytics/govern-lineage.md)
- [Manage master data](../scenarios/cloud-scale-analytics/govern-master-data.md)
- [Metadata standards](../scenarios/cloud-scale-analytics/govern-metadata-standards.md)
- [Requirements for governing data](../scenarios/cloud-scale-analytics/govern-requirements.md)
- [Understand the roles and teams for cloud-scale analytics in Azure](../scenarios/cloud-scale-analytics/organize-roles-teams.md)
- [Understand teams and functions for cloud-scale analytics in Azure](../scenarios/cloud-scale-analytics/organize-team-functions.md)
- [Introduction to cloud-scale analytics](../scenarios/cloud-scale-analytics/overview-cloud-scale-analytics.md)
- [Develop a plan for cloud-scale analytics](../scenarios/cloud-scale-analytics/plan.md)
- [Review your environment for Azure landing zones for cloud-scale analytics](../scenarios/cloud-scale-analytics/ready.md)
- [Authentication for cloud-scale analytics in Azure](../scenarios/cloud-scale-analytics/secure-authentication.md)
- [Data privacy for cloud-scale analytics in Azure](../scenarios/cloud-scale-analytics/secure-data-privacy.md)
- [Integrate cloud-scale analytics into your cloud adoption strategy](../scenarios/cloud-scale-analytics/strategy.md)

## November 2024

### New articles

- [Monitor a cloud environment](../manage/monitor/monitoring.md): This month, we retired outdated content on cloud monitoring and introduced a new overview that provides comprehensive guidance in a simplified format. Explore the importance of monitoring, the key components of a monitoring strategy, and the tools and services you can use to monitor your cloud environment effectively.
- [Well-architected considerations for AI workloads on Azure infrastructure (IaaS)](../scenarios/ai/infrastructure/well-architected.md): Explore the importance of well-architected AI solutions and how to apply the Azure Well-Architected Framework to your AI workloads. Find guidance on reliability, security, cost optimization, operational excellence, and performance efficiency.

#### Secure methodology refresh

This month, we made significant updates to the Secure methodology. The Secure methodology provides guidance on how to secure your cloud environment and protect your data. The methodology includes the following articles:

- [Secure overview](../secure/overview.md): Learn about the Secure methodology and how to apply it to secure your cloud environment. Explore the key components of the Secure methodology, including security principles, security controls, and security best practices.
- [Security teams, roles, and functions](../secure/teams-roles.md): Learn about the key security teams, roles, and functions that are essential for securing your cloud environment.
- [Integrate security into your cloud adoption strategy](../secure/strategy.md): Explore key considerations for integrating security into your cloud adoption strategy.
- [Plan for a secure cloud adoption](../secure/plan.md): Learn about the key considerations for planning a secure cloud adoption and the tools and services you can use to plan for a secure cloud adoption.
- [Prepare your secure cloud estate](../secure/ready.md): Find guidance on the key considerations for preparing your secure cloud estate and the tools and services you can use to prepare your cloud estate securely.
- [Perform your cloud adoption securely](../secure/adopt.md): Explore the importance of security in cloud adoption and the key considerations for securely adopting cloud services.
- [Securely govern your cloud estate](../secure/govern.md): Find guidance on the key considerations for securely governing your cloud estate and the tools and services you can use to securely govern your cloud environment.
- [Manage your cloud estate with enhanced security](../secure/manage.md): Explore the importance of managing your cloud estate with enhanced security and the key considerations for managing your cloud estate securely.

#### SAP and Power Platform

We introduced new articles that provide guidance on integrating SAP and Power Platform. Learn how to extend an SAP landing zone to support Power Platform, understand the architecture workflow, and explore the fundamentals of SAP and Power Platform integration.

- [SAP and Microsoft Power Platform architecture workflow](../scenarios/sap/sap-power-platform-architecture-workflow.md): Find guidance on how to design, deploy, and manage an integrated SAP and Power Platform solution. Explore the key components of the architecture, including SAP systems, Azure services, and Power Platform components.
- [Extend an SAP landing zone to support Microsoft Power Platform](../scenarios/sap/sap-power-platform-extend-landing-zone.md): Learn how to extend an SAP landing zone to support Power Platform.
- [SAP and Power Platform fundamentals](../scenarios/sap/sap-power-platform-fundamental.md): Explore the fundamentals of integrating SAP and Power Platform. Learn about the benefits of integrating SAP and Power Platform, the key components of the integration, and the architecture considerations for a successful integration.

### Updated articles

- [Azure API Management landing zone accelerator](../scenarios/app-platform/api-management/landing-zone-accelerator.md): Find new guidance on generative AI gateway scenarios and how to use them in your API Management landing zone as well as new architecture examples.
- [Introduction to Oracle on Azure adoption scenarios](../scenarios/oracle-iaas/index.md): Explore new guidance on multi-region design for Oracle workloads on Azure, enhancing availability, scalability, and disaster recovery.

## October 2024

### New articles

#### Azure VMware Solution and Global Reach

- [Establish Cross-Tenant Network Connectivity for Azure VMware Solution SDDCs](../scenarios/azure-vmware/cross-tenant-network-connectivity.md): Learn how to establish cross-tenant network connectivity for Azure VMware Solution software-defined datacenters (SDDCs) using Azure Virtual WAN and network virtual appliances (NVAs). Explore connectivity options between SDDCs, Azure, and on-premises environments.
- [Use a Dual-Region Azure VMware Solution Design That Has Virtual WAN and Global Reach](../scenarios/azure-vmware/dual-region-virtual-wan-global-reach.md): Learn best practices for deploying Azure VMware Solution in two regions by focusing on secure connectivity, traffic flows, and high availability using Azure Virtual WAN and Global Reach.
- [Use a Dual-Region Azure VMware Solution Design That Doesn't Have Global Reach](../scenarios/azure-vmware/dual-region-virtual-wan-without-global-reach.md): Explore recommendations for network connectivity, traffic flows, high availability, and the configuration of various components like Virtual WAN hubs, Azure Firewalls, and routing intents.
- [Secure Virtual WAN for Azure VMware Solution in a Single Region or in Dual Regions](../scenarios/azure-vmware/introduction-virtual-wan-azure-vmware-solution.md): Learn how to design secure Virtual WAN topologies for Azure VMware Solution in both single and dual-region scenarios. Learn about routing intent for traffic inspection and explore design considerations for deployments with and without Azure ExpressRoute Global Reach.
- [Use a Single-Region Azure VMware Solution Design That Has Virtual WAN and Global Reach](../scenarios/azure-vmware/single-region-virtual-wan-global-reach.md): Explore best practices for configuring a secure Virtual WAN with routing intent and Azure ExpressRoute Global Reach for a single-region Azure VMware Solution. Find guidance on network connectivity, traffic flows, and the configuration of security solutions in the Virtual WAN hub.
- [Use a Single-Region Azure VMware Solution Design That Doesn't Have Global Reach](../scenarios/azure-vmware/single-region-virtual-wan-without-global-reach.md): See recommendations for configuring a single-region Azure VMware Solution with secure Virtual WAN and routing intent without using Azure ExpressRoute Global Reach. Find guidance on network connectivity, traffic flows, and security considerations for Azure VMware Solution private clouds, on-premises sites, and Azure-native resources.

#### New CAF Scenario: AI Adoption on Azure

- [Establish an AI Center of Excellence](../scenarios/ai/center-of-excellence.md): Learn how to create and manage an AI Center of Excellence (AI CoE) to drive AI adoption within an organization. Find guidance on the importance of an AI CoE, defining its functions, building a cross-functional team, structuring operations, and ensuring ongoing monitoring and evolution of AI initiatives.
- [Recommendations for organizations governing AI workloads in Azure](../scenarios/ai/govern.md): Learn best practices and recommendations for integrating AI risk management into broader risk management strategies, assessing organizational AI risks, documenting and enforcing AI governance policies, and monitoring AI risks.
- [Recommendations for managing AI](../scenarios/ai/manage.md): Learn best practices for managing AI workloads in Azure, including AI operations, deployment, endpoint sharing, model management, cost management, data management, and business continuity. Explore the need for structured practices, continuous monitoring, and adherence to governance standards to ensure effective and reliable AI system management.
- [Recommendations for organizations planning AI adoption](../scenarios/ai/plan.md): See guidance on integrating AI into an organization, including assessing and acquiring AI skills, accessing AI resources, prioritizing AI use cases, creating AI proofs of concept, implementing responsible AI practices, and estimating delivery timelines.
- [Recommendations for organizations building AI workloads in Azure](../scenarios/ai/ready.md): Explore guidance on establishing reliability, governance, networking, and foundational infrastructure for AI workloads in Azure. Learn best practices for ensuring availability, managing costs, securing networks, and creating scalable environments.
- [Recommendations for organizations securing AI workloads in Azure](../scenarios/ai/secure.md): Review guidelines on assessing AI security risks, implementing security controls for AI resources and data, and maintaining these controls through continuous monitoring and updates. Learn about the importance of protecting the confidentiality, integrity, and availability of AI models and data to prevent breaches and ensure compliance.
- [Recommendations for organizations developing an AI adoption strategy](../scenarios/ai/strategy.md): Learn the latest guidance on identifying AI use cases, defining technology and data strategies, and ensuring responsible AI practices to effectively adopt AI within an organization.

##### AI workloads on Azure infrastructure (IaaS)

- [Compute recommendations](../scenarios/ai/infrastructure/compute.md): Learn how to select virtual machines, images, and orchestration solutions to optimize AI workloads on Azure. See recommendations for training and inferencing AI models, managing costs, and using containers for scalable AI solutions.
- [Implementation options](../scenarios/ai/infrastructure/cycle-cloud.md): See recommendations for deploying AI workloads using Azure CycleCloud and Slurm. This article covers cluster creation, dynamic management, and infrastructure control, offering guidelines and architecture for efficient AI operations on Azure IaaS.
- [Governance recommendations](../scenarios/ai/infrastructure/governance.md): Explore guidelines for managing resources, controlling costs, ensuring security, and maintaining operational consistency for AI workloads on Azure.
- [Management recommendations](../scenarios/ai/infrastructure/management.md): Learn strategies for effectively managing AI workloads on Azure by emphasizing continuous monitoring, optimizing practices, and establishing robust backup and disaster recovery plans.
- [Networking recommendations](../scenarios/ai/infrastructure/networking.md): Learn about how to network to optimize bandwidth, minimize latency, and implement high-performance networking for AI workloads on Azure. Explore strategies for resource placement, using proximity placement groups, and utilizing GPU-optimized VMs and InfiniBand for efficient data processing.
- [Security recommendations](../scenarios/ai/infrastructure/security.md): Find guidance on securing Azure services, networks, data, access, and operating systems for AI workloads. Learn how to prioritize encryption, network security, access control, and incident response preparation.
- [Storage recommendations](../scenarios/ai/infrastructure/storage.md): Learn how to use different storage options like Azure Managed Lustre, Azure NetApp Files, and local NVMe/SSD-based storage for active data, transferring inactive data to Azure Blob Storage, implementing checkpointing for model training, automating data migration to lower-cost storage tiers, ensuring data consistency, and enabling data versioning for reproducibility.

##### AI workloads and Azure AI platform services (PaaS)

- [AI architecture guidance to build AI workloads on Azure](../scenarios/ai/platform/architectures.md): This set of articles provides architecture guidance for building AI workloads on Azure using platform-as-a-service (PaaS) solutions, including references and guides for both generative and nongenerative AI architectures, as well as recommendations for AI resource selection, networking, governance, management, and security.
- [Governance recommendations](../scenarios/ai/platform/governance.md): Find recommendations and best practices for managing, including AI model governance, cost control, platform policies, security measures, operational management, regulatory compliance, and data governance.
- [Management recommendations](../scenarios/ai/platform/management.md): Learn best practices for deployment, model monitoring, operations, data management, and business continuity to ensure effective and secure AI operations.
- [Networking recommendations](../scenarios/ai/platform/networking.md): Explore networking recommendations, including how to configure and secure virtual networks, manage connectivity, and implement strategies to protect sensitive AI resources and ensure data integrity and privacy.
- [Resource selection recommendations](../scenarios/ai/platform/resource-selection.md): Find guidance on choosing the right Azure AI platform, compute resources, data sources, and processing tools for both generative and nongenerative AI applications.
- [Security recommendations](../scenarios/ai/platform/security.md): Learn security recommendations covering topics such as securing AI resources, models, access, and execution to protect against potential threats and maintain data integrity and compliance.

### Updated articles

- We made updates to the Azure Landing Zone architecture diagram to reflect guidance for multi-region deployments:

  - [Azure landing zones for modern application platforms](../scenarios/app-platform/ready.md)
  - [Review your environment or Azure landing zone for an SAP enterprise-scale migration](../scenarios/sap/ready.md)

- We refreshed the cloud-scale analytics documentation. These updates include modifications to reflect the latest product naming and guidance and to improve clarity and readability. Explore the following articles to learn more:

  - [Development lifecycle](../ready/considerations/development-strategy-development-lifecycle.md)
  - [What is a data mesh?](../scenarios/cloud-scale-analytics/architectures/what-is-data-mesh.md)
  - [Key considerations for Azure Data Lake Storage](../scenarios/cloud-scale-analytics/best-practices/data-lake-key-considerations.md)
  - [Azure Data Lake Storage](../scenarios/cloud-scale-analytics/best-practices/data-lake-overview.md)
  - [Data lake zones and containers](../scenarios/cloud-scale-analytics/best-practices/data-lake-zones.md)
  - [Data quality](../scenarios/cloud-scale-analytics/govern-data-quality.md)
  - [Metadata standards](../scenarios/cloud-scale-analytics/govern-metadata-standards.md)
  - [Requirements for governing data](../scenarios/cloud-scale-analytics/govern-requirements.md)
  - [Cloud-scale analytics for regulated industries - Microsoft Cloud Adoption Framework for Azure](../scenarios/cloud-scale-analytics/index.md)
  - [Introduction to cloud-scale analytics for regulated industries](../scenarios/cloud-scale-analytics/overview-cloud-scale-analytics.md)
  - [Data privacy for cloud-scale analytics in Azure](../scenarios/cloud-scale-analytics/secure-data-privacy.md)
  - [Azure Well-Architected Framework for data workloads](../scenarios/cloud-scale-analytics/well-architected-framework.md)

- [Enterprise-scale support for Azure Virtual Desktop](../scenarios/azure-virtual-desktop/enterprise-scale-landing-zone.md): We made updates to the baseline architecture and guidance for Azure Virtual Desktop in the enterprise-scale landing zone.
- [Inventory and visibility in Azure](../manage/azure-management-guide/inventory.md): We made updates to the guidance for Azure Monitor Agent.
- [Operational compliance considerations](../ready/landing-zone/design-area/management-operational-compliance.md): We reviewed the Azure Update Manager guidance and refreshed the architecture diagram.

## September 2024

### Updated articles

- [SAP on Azure landing zone accelerator](../scenarios/sap/enterprise-scale-landing-zone.md): We added guidance on best practices for zone resiliency.

We reviewed and made updates to the following articles to reflect the latest product naming and guidance:

- [Data catalog](../scenarios/cloud-scale-analytics/govern-data-catalog.md)
- [Data lineage](../scenarios/cloud-scale-analytics/govern-lineage.md)
- [Data quality](../scenarios/cloud-scale-analytics/govern-data-quality.md)
- [Manage master data](../scenarios/cloud-scale-analytics/govern-master-data.md)
- [Metadata standards](../scenarios/cloud-scale-analytics/govern-metadata-standards.md)

We made updates to the following articles for clarity and accessibility:

- [Adopt responsible and trusted AI principles](../strategy/responsible-ai.md)
- [Business commitment in cloud management](../manage/considerations/commitment.md)
- [Migrate Oracle workloads to Azure](../scenarios/oracle-iaas/oracle-migration-planning.md)
- [Network connectivity for Azure Arc-enabled servers](../scenarios/hybrid/arc-enabled-servers/eslz-arc-servers-connectivity.md)
- [Security governance and compliance for Citrix on Azure](../scenarios/azure-virtual-desktop/landing-zone-citrix/citrix-security-governance-compliance.md)
- [Security guidelines for Oracle Database@Azure](../scenarios/oracle-iaas/oracle-security-overview-odaa.md)

## August 2024

### Updated articles

- [Responsible and trusted AI adoption](../strategy/responsible-ai.md): Explore new guidance about how to develop AI responsibly and build safer systems with Azure AI Content Safety. Learn about the importance of responsible AI and the features of the Responsible AI dashboard for Azure Machine Learning.
- [Landing zone identity and access management](../ready/landing-zone/design-area/identity-access-landing-zones.md): Find new guidance about built-in and custom RBAC roles, least-privelage access, and conditions.
- [Business commitment in cloud management](../manage/considerations/commitment.md): We updated the service-level agreement references to service-level objective references.
- [Security guidelines for Oracle Database@Azure](../scenarios/oracle-iaas/oracle-security-overview-odaa.md): Explore new updates about network security group rules and Oracle Data Safe.
- [Business continuity and disaster recovery for an SAP migration](../scenarios/sap/eslz-business-continuity-and-disaster-recovery.md): Learn about the benefits of using Azure Backup to back up databases that have SAP HANA System Replication enabled.

We made updates to the following articles for clarity:
- [Network considerations for Azure VMware Solution dual-region deployments](../scenarios/azure-vmware/eslz-dual-region-network-topology.md)
- [What is a data product?](../scenarios/cloud-scale-analytics/architectures/what-is-data-product.md)
- [Cloud adoption scenarios](../scenarios/index.md)
- [Oracle on Azure IaaS landing zone accelerator](../scenarios/oracle-iaas/oracle-landing-zone-accelerator.md)
- [Security governance and compliance for Citrix on Azure](../scenarios/azure-virtual-desktop/landing-zone-citrix/citrix-security-governance-compliance.md)

## July 2024

### New articles

This month, we introduced new articles that have guidance for Red Hat Enterprise Linux (RHEL) on Azure. We also added new articles and made major updates to existing articles for Oracle on Azure IaaS and Oracle Database@Azure. Take a look at the new and updated content to see how you can apply these recommendations in your organization.

#### Red Hat Enterprise Linux on Azure

- [Azure RHEL landing zone accelerator](../scenarios/app-platform/azure-red-hat-enterprise-linux/landing-zone-accelerator.md): Learn how to use the RHEL landing zone accelerator to create a consistent, repeatable, and secure environment deployment. Use the architectural guidance and reference implementation recommendations to accelerate the migration and deployment of RHEL-based workloads to Microsoft Azure.
- [Identity and access management (IAM) for RHEL](../scenarios/app-platform/azure-red-hat-enterprise-linux/identity-access-management.md): Discover IAM considerations for your RHEL landing zone accelerator deployment. Learn how to carefully design your hybrid cloud IAM implementation to ensure smooth integration and management of your instance landscape in the Azure cloud.
- [Business continuity and disaster recovery for RHEL](../scenarios/app-platform/azure-red-hat-enterprise-linux/business-continuity-disaster-recovery.md): Learn how to improve business continuity and disaster recovery for your RHEL on Azure environment. Explore recommendations that you can use to support RHEL workloads and to deploy RHEL platform-management components.
- [Network topology and connectivity for RHEL](../scenarios/app-platform/azure-red-hat-enterprise-linux/network-topology-connectivity.md): Learn how to implement design considerations and recommendations for network topology and connectivity in RHEL on Azure infrastructure. See how you can deploy various RHEL platform components and roles on virtual machines (VMs) with specific sizing and redundancy as needed.
- [Resource organization for RHEL](../scenarios/app-platform/azure-red-hat-enterprise-linux/resource-organization.md): Learn key tactics for how to choose management groups and subscriptions that will help to ensure that you effectively govern and manage resources for your RHEL deployment.
- [Security for RHEL](../scenarios/app-platform/azure-red-hat-enterprise-linux/security.md): See how you can design your security to target multiple areas to protect your RHEL systems. Learn how to create a secure and resilient cloud environment by implementing a strategic approach that applies both Azure and Red Hat security mechanisms.
- [Management and monitoring for RHEL](../scenarios/app-platform/azure-red-hat-enterprise-linux/management-monitoring.md): Learn about best practices for effective management and monitoring in your RHEL on Azure infrastructure.
- [Governance and compliance for RHEL](../scenarios/app-platform/azure-red-hat-enterprise-linux/governance-compliance.md): Learn about design considerations and recommendations for governance and compliance in an RHEL on Azure infrastructure. Discover key tactics for establishing efficient and effective governance and compliance in a cloud environment.
- [Platform automation for RHEL](../scenarios/app-platform/azure-red-hat-enterprise-linux/platform-automation-devops.md): Learn about the tools, features, and services you can use to automate various tasks and manage the RHEL lifecycle within your Azure environment. Discover how to implement automation to improve the efficiency and reliability of your RHEL on Azure infrastructure.

#### Oracle

- [Oracle on Azure IaaS landing zone accelerator](../scenarios/oracle-iaas/oracle-landing-zone-accelerator.md): Learn how you can use the Oracle on Azure IaaS landing zone accelerator to automate the deployment of an environment capable of hosting Oracle on Azure IaaS Virtual Machines. See how the landing zone accelerator can be adapted to produce an architecture that fits your scenario and puts your organization on a path to sustainable scale.
- [Manage and monitor Oracle Database@Azure](../scenarios/oracle-iaas/oracle-manage-monitor-oracle-database-azure.md): Explore best practices for management and monitoring Oracle Exadata Database Service on a Dedicated Infrastructure with Oracle Database@Azure. Learn about key design considerations for health and metrics monitoring.
- [Business continuity and disaster recovery for Oracle Database@Azure](../scenarios/oracle-iaas/oracle-disaster-recovery-oracle-database-azure.md): Learn about business continuity and disaster recovery for Oracle Database@Azure and how to build a resilient architecture for your workload environment. Discover how you can design your architecture to meet the recovery time objective (RTO) and recovery point objective (RPO) of your solution.
- [Business continuity and disaster recovery for Oracle on Azure Virtual Machines landing zone accelerator](../scenarios/oracle-iaas/oracle-disaster-recovery-iaas.md): Find significant updates that reflect new guidance including the deprecation of availability sets and new recommendations for Virtual Machine Scale Sets flexible orchestration.

### Updated articles

- [Configure hybrid networking for Citrix on Azure](../scenarios/azure-virtual-desktop/landing-zone-citrix/citrix-network-topology-connectivity.md): Find new guidance and additional recommendations for large scale deployments of Azure and Citrix Cloud environments in a single region.
- [Networking for Azure Virtual Desktop](../scenarios/azure-virtual-desktop/eslz-network-topology-and-connectivity.md): Explore the new reference architecture for a hub and spoke topology with hybrid connectivity scenario.
- [Business continuity and disaster recovery for Azure Virtual Desktop](../scenarios/azure-virtual-desktop/eslz-business-continuity-and-disaster-recovery.md): Learn about new resources for checking the zone resilience of your resources.

We made updates to the following articles to provide the latest guidance on networking:

- [Define network encryption requirements](../ready/azure-best-practices/define-network-encryption-requirements.md)
- [Plan for landing zone network segmentation](../ready/azure-best-practices/plan-for-landing-zone-network-segmentation.md)
- [Plan for traffic inspection](../ready/azure-best-practices/plan-for-traffic-inspection.md)

These files were updated to include considerations for [Azure Arc-enabled VMware vSphere](/azure/azure-arc/vmware-vsphere/overview) and [Azure Arc-enabled System Center Virtual Machine Manager](/azure/azure-arc/system-center-virtual-machine-manager/overview):

- [Hybrid and multicloud migration](../scenarios/hybrid/migrate.md)
- [Ready methodology for hybrid and multicloud strategy](../scenarios/hybrid/ready.md)

## June 2024

### New articles

- [Establish common subscription vending product lines](../ready/landing-zone/design-area/subscription-vending-product-lines.md): Give application teams the flexibility to deliver their workloads and services effectively by offering different subscription vending product lines. Implement subscription vending in your Azure landing zones to establish consistent scaling, security, and governance of Azure environments.

### Updated articles

- [Ready methodology for hybrid and multicloud strategy](../scenarios/hybrid/ready.md): We updated this article to include Azure Arc-enabled VMware vSphere and Azure Arc-enabled System Center Virtual Machine Manager.
- [How to select a strategy for relocating cloud workloads](../relocate/select.md): We updated the guidance on service and data-relocation automation methods.
- [Security, governance, and compliance disciplines for Azure VMware Solution](../scenarios/azure-vmware/eslz-security-governance-and-compliance.md): We updated this article to replace references to MMA, which is planned for deprecation. New guidance points to the Azure Monitor Agent.

We updated these articles to provide the latest guidance on Azure carbon optimization:

- [Sustainability considerations in cloud management](../manage/considerations/sustainability.md)
- [Sustainability considerations in your cloud strategy](../strategy/inform/sustainability.md)

#### Hybrid/Azure Arc retirement

We retired several articles in the Hybrid/Azure Arc scenario in the best practices area. The content was outdated and no longer relevant to the Cloud Adoption Framework.

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

- [Resource consistency decision guide](../decision-guides/resource-consistency/index.md)
- [Get started: Document foundational alignment decisions](../get-started/cloud-concepts.md)
- [Innovate methodology and maturity modeling](../innovate/best-practices/ci-cd.md)
- [Operational compliance in Azure](../manage/azure-management-guide/operational-compliance.md)
- [Understand the functions of a central IT team](../organize/central-it.md)
- [Track costs across business units, environments, or projects](../ready/azure-best-practices/track-costs.md)
- [Azure governance design area](../ready/landing-zone/design-area/governance.md)
- [Inventory and visibility considerations](../ready/landing-zone/design-area/management-platform.md)  
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
- [Zero Trust configuration for multitenant defense organizations](../scenarios/defense/identity/multi-tenant/zero-trust-configuration.md): Review a new multitenant architecture diagram and information about Microsoft Entra ID Protection.
- [The Azure Well-Architected Framework for HPC](../scenarios/azure-hpc/well-architected-framework.md): Explore updates related to ExpressRoute.

## March 2024

### Updated articles

- [Azure governance design area](../ready/landing-zone/design-area/governance.md): Explore a new section for third-party tooling, including guidance for AzAdvertizer and Azure Governance Visualizer. 
- [Tools and templates](../resources/tools-templates.md): Find information about governance for AzAdvertizer.
- [Resource consistency decision guide](../decision-guides/resource-consistency/index.md): Check out our expanded information about basic grouping for resource groups.
- [Select Azure regions](../ready/azure-setup-guide/regions.md): We added guidance about how to plan Azure resource group deployments.  
- [Transition an existing Azure environment to the Azure landing zone conceptual architecture](../ready/enterprise-scale/transition.md): Find tip to help you reduce the impact of regional outages.
- [Security guidelines for Oracle on Azure Virtual Machines landing zone accelerator](../scenarios/oracle-iaas/oracle-security-guideline-landing-zone.md): Review new use cases for centralized identity management. These use cases include using Azure Key Vault to store credentials and using hardened operating system images.
- [Storage for Azure HPC](../scenarios/azure-hpc/storage.md): Find new data to help you compare Azure Managed Lustre with Blob Storage, Azure Files, and Azure NetApp Files.
- [Network topology and connectivity for an SAP migration](../scenarios/sap/eslz-network-topology-and-connectivity.md): Explore design recommendations for Azure ExpressRoute.

<!-- docutune:ignoreNextStep -->
