---
title: What's new in the Microsoft Cloud Adoption Framework
description: Learn about recent updates to the Microsoft Cloud Adoption Framework for Azure.
author: stephen-sumner
ms.author: pnp
ms.date: 08/07/2025
ms.update-cycle: 180-days
ms.topic: conceptual
ms.custom: UpdateFrequency.5, historical
---

# What's new in the Microsoft Cloud Adoption Framework for Azure

We build the Microsoft Cloud Adoption Framework collaboratively with our customers, partners, and internal Microsoft Teams. We release new and updated content for the framework as it becomes available. These new releases pose an opportunity for you to test, validate, and refine the Cloud Adoption Framework guidance along with us.

Partner with us in our ongoing effort to develop the Cloud Adoption Framework.

## July 2025

### Updated methodologies

- CAF Plan:
  1. [Prepare your organization for the cloud](../plan/prepare-organization-for-cloud.md): Learn how to prepare your organization for successful Azure cloud adoption by choosing and implementing appropriate cloud operations models that distribute responsibilities across governance, security, and operations teams. Discover guidance for how to select centralized, shared management, or decentralized approaches based on organizational size, maturity, and business requirements to ensure strategic alignment and operational effectiveness.
  2. [Prepare your people for the cloud](../plan/prepare-people-for-cloud.md): Learn how to equip your team with essential Azure skills through targeted training, expert support, and continuous learning programs to accelerate cloud adoption success and reduce implementation risks. Discover systematic approaches for how to assess skill gaps across Azure fundamentals, environment management, and cloud-native development while you establish sustainable learning cultures that maximize your cloud investment returns.
  3. Plan migration (if applicable)
     - [Discover your existing workload inventory](../plan/discover-existing-workload-inventory.md): Learn how to create a comprehensive workload inventory and prioritize assets for successful Azure cloud migration by using automated discovery tools and business value frameworks. Discover systematic approaches for identifying existing infrastructure, applications, and dependencies across all environments while gathering crucial business requirements to guide your cloud adoption strategy.
     - [Select your cloud migration strategies](../plan/select-cloud-migration-strategy.md): Learn how to select cloud migration strategies for your workloads by using the "8 Rs" framework (Retire, Retain, Rehost, Replatform, Refactor, Rearchitect, Rebuild, Replace). This guide helps you align business drivers with appropriate migration approaches, from decommissioning obsolete systems to building cloud-native solutions. Discover when to modernize during migration, how to communicate decisions effectively, and establish success metrics that validate business outcomes for each strategy.
     - [Assess your workloads for cloud migration](../plan/assess-workloads-for-cloud-migration.md): Learn about conducting thorough workload assessments for Azure migration. This guide covers architecture analysis, performance metrics collection, dependency mapping, and compliance validation. Discover automated assessment tools like Azure Migrate and AppCAT, risk management strategies, and systematic approaches to evaluate application code compatibility and database dependencies for successful migration planning.
  4. [Plan your Azure environment for cost estimation](../plan/estimate-total-cost-of-ownership.md): Learn how to create accurate Azure cost estimates by planning architectures, selecting appropriate services and tiers, and defining regional deployment strategies for your cloud environment. Discover systematic approaches for documenting architectural decisions, using cost estimation tools, validating assumptions through test deployments, and establishing cost baselines to support effective financial planning and governance.
  - [Template: Cloud adoption plan template for cloud-native startups](../plan/cloud-native-adoption-plan.md): Learn how to create a comprehensive cloud adoption plan for Azure-native startups by documenting operation models, training strategies, landing zone architecture, and workload requirements to accelerate your cloud journey. Use structured templates that cover responsibility assignments, continuous learning programs, resource hierarchy plans, and technical specifications to ensure successful cloud-native business development.
  - [Template: Cloud adoption plan template for migration](../plan/migration-adoption-plan.md): Learn how to create a comprehensive cloud adoption plan template for Azure migration by documenting your operation model, training strategies, platform architecture, and detailed workload requirements. Use structured frameworks to capture business and technical details, define responsibilities, plan Azure landing zone components, and establish success metrics for a successful cloud migration.
  - [Guide: Shared management cloud operations](../plan/shared-management-operating-model.md): Learn how to implement a shared management cloud operations model that scales Azure adoption through platform engineering by building reusable platform capabilities and establishing clear team responsibilities. Discover systematic approaches for creating modular platform services, enabling self-service infrastructure, coordinating multiple specialized teams, and applying product management practices to accelerate workload delivery across enterprise environments.

- CAF Migrate:
  1. [Plan your migration](../migrate/plan-migration.md): Learn how to create comprehensive migration plans that define workload sequences, data transfer paths, and rollback strategies for successful Azure cloud migrations. Explore detailed guidance for migration readiness assessment, dependency management, stakeholder engagement, and how to choose appropriate migration methods to ensure secure and efficient cloud adoption process.
  2. [Prepare workloads for the cloud](../migrate/prepare-workloads-cloud.md): Learn how to prepare workloads for successful Azure cloud migration by validating compatibility, resolving infrastructure problems, and conducting comprehensive tests in Azure environments. Explore step-by-step guidance for how to fix compatibility problems, validate network connectivity and authentication flows, performance tests, and create reusable infrastructure templates to ensure reliable cloud adoption.
  3. [Execute migration to the cloud](../migrate/execute-migration.md): Learn how to implement successful Azure cloud migration with structured guidance for both near-zero downtime and planned downtime approaches, which includes stakeholder preparation, environment setup, and data migration validation. Explore comprehensive migration implementation strategies that cover database replication, cutover procedures, fallback options, and post-migration support to ensure business continuity throughout your cloud migration process.
  4. [Optimize workloads after migration](../migrate/optimize-workloads-after-migration.md): Learn how to optimize workloads after Azure migration through performance fine-tuning, cost management, monitoring validation, and backup verification to ensure efficient cloud operations. Explore comprehensive post-migration strategies that include user feedback collection, hybrid dependency management, and regular architecture reviews to maximize your cloud investment and operational excellence.
  5. [Decommission source workloads after migration to the cloud](../migrate/decommission-source-workload.md): Learn how to safely decommission source workloads after successful Azure cloud migration by obtaining stakeholder approval, optimizing software licenses, and preserving data for compliance requirements. Explore step-by-step guidance about how to reduce operational costs, ensure regulatory compliance, and update documentation to complete your cloud migration life cycle.
  - [Guide: Migration wave planning](../migrate/migration-wave-planning.md): Learn how to organize workloads into structured migration waves for successful Azure cloud adoption by using an iterative approach that reduces risk and complexity while you build team experience. Explore comprehensive guidance for dependency management, workload prioritization frameworks, timeline plans, and wave implementation strategies to accelerate your cloud migration journey.

- CAF Modernize:
  1. [Prepare for cloud modernization](../modernize/prepare-organization-cloud-modernization.md): Learn how to prepare your organization for successful cloud modernization by defining modernization scope, assessing team skills and readiness gaps, and establishing cross-functional collaboration frameworks. Explore structured approaches to prioritize workloads by using business value and technical risk assessment matrices.
  2. [Plan your cloud modernization](../modernize/plan-cloud-modernization.md): Learn how to plan cloud modernization projects through structured approaches for choosing appropriate modernization strategies, establishing phased implementation timelines with governance frameworks, and implementing deployment strategies with comprehensive risk mitigation and stakeholder approval processes.
  3. [Execute modernizations in the cloud](../modernize/execute-cloud-modernization.md): Learn how to implement cloud modernization projects through stakeholder preparation, controlled development, comprehensive tests, and safe deployment strategies. This article covers how to develop modernizations in nonproduction environments, conduct thorough validation that includes performance and security tests, and deploy by using in-place or parallel approaches with progressive traffic routing and post-deployment stabilization.
  4. [Optimize workloads after cloud modernization](../modernize/optimize-after-cloud-modernization.md): Learn about optimizing Azure workloads after cloud modernization to maximize benefits and establish continuous improvement practices. This guide covers validating configurations by using Azure Advisor, establishing operational readiness through monitoring and cost controls, testing backup and recovery procedures, and measuring actual outcomes against modernization goals. Discover how to implement systematic feedback collection, automate optimization processes, and create ongoing modernization cycles to prevent legacy system drift and ensure long-term cloud success.
  - [Guide: Modernization guidance to replatform, refactor, and rearchitect](../modernize/modernization-cloud-replatform-refactor-rearchitect.md): Explore modernization guidance for cloud workloads by using three core strategies: replatform to move components to Azure PaaS services with minimal code changes, refactor application code for improved performance and cloud optimization, and rearchitect to redesign architecture for enhanced scalability and cloud-native capabilities. The guide provides categorized resources and architectural patterns for each modernization approach.

- CAF Cloud-native:
  - [Plan cloud-native solutions](../cloud-native/plan-cloud-native-solutions.md): Learn how to plan cloud-native Azure solutions through strategic business alignment, architectural design, and deployment preparation. This article covers how to define measurable business objectives and requirements, explore validated architecture patterns and Azure service selection, plan integrations with existing systems, and establish deployment strategies that include progressive exposure and rollback procedures to ensure successful delivery of new workloads or features.
  - [Build cloud-native solutions](../cloud-native/build-cloud-native-solutions.md): Learn how to build resilient cloud-native Azure solutions by using best practices for development, testing, CI/CD, and monitoring to create production-ready applications at scale. Explore guidance about how to apply Well-Architected Framework principles, implement comprehensive test strategies that include load tests with Azure Load Testing, and integrate Azure Monitor and Application Insights for observability.
  - [Deploy cloud-native solutions](../cloud-native/deploy-cloud-native-solutions.md): Learn how to deploy cloud-native solutions to Azure with comprehensive strategies for stakeholder preparation, CI/CD pipeline implementation, progressive rollout techniques, and post-deployment validation to ensure successful production deployments.
  - [Optimize cloud-native solutions after deployment](../cloud-native/optimize-cloud-native-solutions.md): Learn how to optimize Azure cloud-native solutions after deployment through service configuration tuning, operational validation, and continuous improvement practices. This article covers how to apply Azure Advisor recommendations, establish monitoring and cost controls, test backup procedures, and collect user feedback to ensure that solutions remain secure, cost-effective, and performant.

### New articles

- [Platform automation and DevOps for Oracle Exadata Database@Azure](../scenarios/oracle-on-azure/oracle-platform-automation-devops-oracle-database-azure.md): Learn how to deploy Oracle Exadata Database@Azure infrastructure by using infrastructure as code and Azure Verified Modules for reliable and consistent automation across your Azure environments. Discover comprehensive guidance for how to use Terraform providers, handle idempotency challenges, configure Oracle components with OCI Terraform, and implement standardized deployment patterns that follow Azure best practices for reliability and security.

### Updated articles

- [Optimize workloads after cloud modernization](../modernize/optimize-after-cloud-modernization.md): We updated links in the **Next steps** section that describe how to govern, secure, and manage Azure.
- [What is Microsoft Cloud Adoption Framework for Azure?](../overview.md): We updated the Cloud Adoption Framework overview to improve clarity and organization. The **Why use the Cloud Adoption Framework?** section was streamlined into a single paragraph. The **Who should use the Cloud Adoption Framework?** section was restructured from a bullet list format into a table format. In the **How to use the Cloud Adoption Framework?** section, we clarified the methodology terminology by changing **Sequential methodologies** to **Foundational methodologies** and **Continuous methodologies** to **Operational methodologies**, and updated the explanatory text to better describe how these methodologies work together throughout the Azure adoption journey.
- [Assess your workloads for cloud migration](../plan/assess-workloads-for-cloud-migration.md): We restructured this guidance with numbered procedures for workload assessment, dependency mapping, and risk management. We also consolidated architectural documentation and separated unsupported technology identification into its own section with automated tool recommendations.
- [Document your cloud adoption plan](../plan/document-cloud-adoption-plan.md): We updated the plan alignment guidance into clear subsections that have numbered steps. It expands the template selection guidance to include customization recommendations, breaks organizational standards alignment into separate mapping and compliance incorporation steps, and enhances the accountability documentation section with specific requirements for progress tracking, responsibility assignment, and stakeholder approval capture.
- [Select your cloud migration strategies](../plan/select-cloud-migration-strategy.md): We added a section about engaging workload teams to validate business drivers and migration strategies. It emphasizes early collaboration to ensure that migration plans align with technical realities and business priorities through communication, documentation requests, strategy validation, team support, and executive sponsorship.
- [Management groups](../ready/landing-zone/design-area/resource-org-management-groups.md): We updated the management group design guidance to clarify RBAC assignment best practices, reorganize workload structuring recommendations, simplify the architecture section, and remove the permissions guidance for the Azure landing zone accelerator.
- [Tailor the Azure landing zone architecture](../ready/landing-zone/tailoring-alz.md): We updated this guidance to reflect that the Security management group is now part of the default Azure landing zone architecture, updated color references in the application landing zone section, and improved diagram accessibility.
- [Understand cloud operations functions](../organize/cloud-operations.md): We restructured the content organization with clearer headings, added a comprehensive deliverables table, expanded the team preparation section, and included an Azure tools reference table.
- [Align responsibilities across teams](../organize/raci-alignment.md): We simplified the RACI matrix tables by removing the capability alignment rows and streamlining the table formatting for better readability.
- [Plan for Azure VMware Solution](../scenarios/azure-vmware/plan.md): We updated this guidance to improve clarity and accessibility, including restructuring adoption stages with clearer formatting and enhancing technical requirements descriptions.
- [Business continuity and disaster recovery for Oracle Database@Azure by using Exadata Database Service](../scenarios/oracle-on-azure/oracle-disaster-recovery-oracle-database-azure.md): We updated this backup configuration guidance to include the ARS long-term backup feature by using OCI object storage and improved the storage backup recommendations structure.
- [Use the Azure Kubernetes Services (AKS) landing zone accelerator to deploy scalable AKS clusters](../scenarios/app-platform/aks/landing-zone-accelerator.md): We restructured this guidance with numbered procedures for deploying AKS clusters, enhanced the platform foundation requirements, and added an Azure tools and resources reference table.
- [Govern AI](../scenarios/ai/govern.md): We restructured this article with numbered procedures for AI risk assessment and governance, enhanced the enforcement and monitoring sections, and improved clarity throughout this article.
- [Manage AI](../scenarios/ai/manage.md): We restructured this guidance with numbered procedures for AI operations management, expanded the business continuity section with specific backup and recovery strategies, and enhanced the data management recommendations.
- [Plan for AI adoption](../scenarios/ai/plan.md): We restructured this article with actionable numbered procedures for AI skills assessment, capability development, resource access planning, and proof-of-concept validation to help you create comprehensive AI adoption plans.
- [Get AI architecture guidance for Azure platform services (PaaS) for AI](../scenarios/ai/platform/architectures.md): We restructured this guidance with numbered procedures for selecting appropriate AI architectures, implementing operational frameworks, and adopting AI standards for both generative and nongenerative workloads by using Azure PaaS solutions.
- [Govern Azure platform services (PaaS) for AI](../scenarios/ai/platform/governance.md): We restructured this guidance with numbered procedures for governing AI platforms, models, costs, security, operations, regulatory compliance, and data by using Azure PaaS solutions to ensure responsible AI practices and organizational alignment.
- [Manage Azure platform services (PaaS) for AI](../scenarios/ai/platform/management.md): We enhanced this guidance with structured numbered procedures for AI deployment strategies, comprehensive model monitoring approaches, and operational best practices to ensure effective management of Azure AI platform services.
- [Configure secure networking for Azure AI platform services](../scenarios/ai/platform/networking.md): We organized the content with numbered procedures for virtual network configuration, connectivity management, and security implementation strategies to protect AI resources and ensure data integrity across Azure AI platform services.
- [Select Azure platform services (PaaS) for AI](../scenarios/ai/platform/resource-selection.md): We restructured this guidance with numbered procedures for choosing appropriate Azure AI platforms, compute resources, and data processing tools to support both generative and nongenerative AI applications effectively.
- [Secure Azure platform services (PaaS) for AI](../scenarios/ai/platform/security.md): We restructured content with numbered procedures and added a new **Secure AI data** section that covers data boundaries and RBAC.
- [AI ready](../scenarios/ai/ready.md): We reorganized the content from four sections to three focused areas and added numbered procedures for governance boundaries, secure connectivity, and AI reliability across regions.
- [Secure AI](../scenarios/ai/secure.md): We restructured content with numbered procedures and added a new **Secure AI data** section that covers data boundaries and RBAC.
- [AI strategy](../scenarios/ai/strategy.md): We added guidance about AI agents and Model Context Protocol (MCP) for interoperability, enhanced the AI decision tree diagram, and included a comprehensive example AI strategy table that demonstrates how to apply AI approaches across different use cases, from e-commerce to regulated industries.
- [Azure landing zone frequently asked questions (FAQ)](../ready/enterprise-scale/faq.md): We added a new **FAQ** section that clarifies that you can use the existing Azure landing zone architecture to deploy AI workloads without requiring a separate AI landing zone.
- [What is an Azure landing zone?](../ready/landing-zone/index.md): We added a new section about AI in Azure landing zones, moved the application landing zone accelerators section to appear earlier in this article, and added a reference to the FAQ in the **Next steps** section.

## June 2025

### Updated articles

- [Network topology and connectivity for Oracle Database@Azure - BCDR connectivity design](../scenarios/oracle-on-azure/business-continuity-disaster-recovery-connectivity-design.md): We replaced multiple complex topology options with a single, focused recommendation for global virtual network peering for cross-region connectivity. We also clarified cost terminology and streamlined the design considerations.
- [Network topology and connectivity for Oracle Database@Azure - Core network design](../scenarios/oracle-on-azure/core-network-design.md): We clarified patching processes, provided clearer network security group management recommendations, and added guidance about the five Oracle-delegated subnet limit for each region.
- [Network topology and connectivity for Oracle Database@Azure - Migration connectivity design](../scenarios/oracle-on-azure/migration-connectivity-design.md): We made updates to improve clarity and accuracy and refined the guidance about capacity planning and connectivity effects in the design considerations and recommendations sections.
- [Create and scale Azure subscriptions](../ready/azure-best-practices/initial-subscriptions.md): We added comprehensive subscription life cycle management guidance that includes new sections about subscription policies, governance, scaling strategies with automation and templates, and ongoing monitoring.
- [Define your naming convention](../ready/azure-best-practices/resource-naming.md): We made significant structural and content updates to explain the importance of naming conventions and understanding Azure resource names.
- [Define your tagging strategy](../ready/azure-best-practices/resource-tagging.md): We added a comprehensive resource tagging approach that includes new sections about how to define tagging requirements, implement consistent tagging by using Azure policies and security considerations, and apply foundational tagging categories.
- [Organize your Azure resources effectively](../ready/azure-setup-guide/organize-resources.md): We reorganized the content and added links to best practices for resource tagging strategies and organization.
- [Deploy Azure App Service at scale with landing zone accelerator](../scenarios/app-platform/app-services/landing-zone-accelerator.md): We added more detailed, process-oriented guidance and step-by-step recommendations for flexible implementation and customization. We also added a new architecture diagram that shows Azure Front Door and App Service Environment v3 integration.
- [Microsoft Cloud Adoption Framework for Azure](../overview.md): We streamlined this article to focus on why you should use the framework, who should use the framework, and how to use the framework. We also added a new section on cloud adoption scenarios.
- [Azure high-performance computing (HPC) landing zone accelerator](../scenarios/azure-hpc/azure-hpc-landing-zone-accelerator.md): We made updates to improve accuracy and added links to instructions about how to deploy the HPC landing zone accelerator.
- [Compute large-scale HPC application workloads in Azure Virtual Machines](../scenarios/azure-hpc/compute.md): We made updates to improve accuracy, updated version numbers, and added links. We also consolidated the **Next steps** section.
- [Azure landing zone for HPC](../scenarios/azure-hpc/ready.md): We updated links, made changes to improve accuracy, and updated AzHop references to Azure CycleCloud Workspace for Slurm.
- [Capacity planning for Oracle workloads on Azure Virtual Machines](../scenarios/oracle-on-azure/oracle-capacity-planning.md): We made changes to reflect the latest Azure capabilities and best practices for Oracle workload capacity planning, with specific emphasis on newer virtual machine (VM) series and storage technologies.
- [Manage modern application platform solutions for optimal performance and reliability](../scenarios/app-platform/manage.md): We made significant changes to this article to provide a more practical and comprehensive approach to managing modern application platforms. We also clarified the implementation guidance and added specific Azure tooling recommendations.
- [Select Azure regions](../ready/azure-setup-guide/regions.md): We updated the Azure region selection section with clearer decision-making criteria and reliability, capability, and cost considerations.
- [Azure setup guide overview](../ready/azure-setup-guide/index.md): We removed Azure portal integration and interactive elements and replaced the checklist format with a comprehensive table that describes each step in the Azure setup guide.
- [AI strategy](../scenarios/ai/strategy.md): We provided a more comprehensive and strategic approach to AI adoption by adding clearer implementation steps and enhanced guidance for data strategy and responsible AI practices.
- [Identity and access management recommendations for Azure Virtual Desktop](../scenarios/azure-virtual-desktop/eslz-identity-and-access-management.md): We added more comprehensive, actionable guidance for implementing identity and access management, including a new section for single sign-on and updated design considerations.
- [Storage considerations for AKS](../scenarios/app-platform/aks/storage.md): We made updates to streamline the content and improve technical accuracy. We also added sections for Azure Container Storage.
- [Enterprise-scale support for Citrix on Azure](../scenarios/azure-virtual-desktop/landing-zone-citrix/citrix-enterprise-scale-landing-zone.md): We reorganized the content in this article and made minor edits.
- [Establish an AI Center of Excellence](../scenarios/ai/center-of-excellence.md): We added specific steps, detailed role definitions, organizational integration recommendations, and maturity-based operational evolution to provide a more strategic approach to establishing and operating an AI Center of Excellence.
- [Select Azure platform as a service (PaaS) solutions for AI](../scenarios/ai/platform/resource-selection.md): We updated resource recommendations to include Azure AI Foundry Agent Service and streamlined the guidance to present Azure AI Foundry as the comprehensive solution and Azure OpenAI for specific model access needs.

## May 2025

### Updated articles

- [Prepare for cloud adoption](../ready/index.md): We refined the Azure Landing Zones concepts section to provide a more detailed summary of designing and deploying landing zones.
- [Abbreviation recommendations for Azure resources](../ready/azure-best-practices/resource-abbreviations.md): We updated abbreviations for Azure AI Foundry and Azure AI Foundry project with the updates to the resource provider.

#### Defense scenario retirement

We retired the articles that formerly made up the defense scenario. The content was outdated and no longer relevant to the Cloud Adoption Framework.

## April 2025

### Updated articles

- [Administer your Azure cloud estate](../manage/administer.md): We added guidance on managing workload relocations, including drivers, risks, costs, and projects.
- [Manage AI – Process to manage AI](../scenarios/ai/manage.md): We made updates to the "AI endpoint sharing" section, now the "Ai resource sharing" section.
- [Management recommendations for AI workloads on Azure](../scenarios/ai/platform/management.md): We added guidance for managing AI deployments, including finding the best region, using AI hubs, and managing multiple deployments.
- [Protect your Azure cloud estate](../manage/protect.md): We made updates for clarity and refreshed the content to reflect the latest Azure services and best practices for protecting your cloud estate.
- [Ready your Azure cloud operations](../manage/ready.md): We made significant updates for clarity and accuracy.
- [Resource selection recommendations for AI workloads on Azure](../scenarios/ai/platform/resource-selection.md): We made updates to separate and clarify the guidance on selecting nongenerative AI platforms to provide more details on the differences between Azure AI services and Azure Machine Learning.
- [Testing approach for Azure landing zones](../ready/enterprise-scale/testing-approach.md): We made significant updates to Azure Landing Zone canary guidance to improve the clarity and usability of the content based on customer feedback.
- [What is an Azure landing zone?](../ready/landing-zone/index.md): We added a conceptual architecture diagram to differentiate between platform and application landing zones.

## March 2025

### Manage methodology refresh

This month, we made significant updates to the Manage methodology. The Manage methodology provides guidance on how to manage your cloud environment and optimize your cloud operations. Some highlights of our updates to the methodology include:

- [Ready your Azure cloud operations](../manage/ready.md): Learn how to prepare your Azure cloud operations for success. Learn how to establish defined responsibilities and processes for every cloud management area.
- [Administer your Azure cloud estate](../manage/administer.md): Explore new guidance on managing resource sprawl and detailed steps to implement governance policies, organize resources, restrict deployment permissions, and conduct regular audits.
- [Monitor your Azure cloud estate](../manage/monitor.md): Find new guidance on how to monitor various aspects of your cloud estate, like service health, security, compliance, costs, data, code, and cloud resources. We also made updates to reflect new terms and resources.
- [Protect your Azure cloud estate](../manage/protect.md): Learn best practices for ensuring the reliability and security of Azure cloud operations, including how to maintain minimal downtime and establish robust security measures. Key sections include managing reliability through redundancy, replication, and recovery strategies, defining reliability requirements, and prioritizing workloads based on business impact.

### Updated articles

- [AI Plan - Process to plan for AI adoption](../scenarios/ai/plan.md): We made adjustments to the AI maturity level table, and modifications to various sections such as "Acquire AI skills," "Access AI resources," "Prioritize AI use cases," and "Create an AI proof of concept."
- [AI Strategy - Process to develop an AI strategy](../scenarios/ai/strategy.md): We reorganized and streamlined the AI technology strategy, extensibility tools for Microsoft 365 Copilot, and responsible AI strategy sections. New content was added to highlight the use of Microsoft Fabric and Azure services in various AI applications.
- [Secure AI – Process to secure AI](../scenarios/ai/secure.md): We made minor updates to align this article with the NIST Cybersecurity Framework and the Microsoft Security Reference Architecture.
- [Storage for Azure HPC Workloads](../scenarios/azure-hpc/storage.md): We made adjustments for clarity and details and considerations were added, including new sections on compute node distribution, design recommendations and HPC components.

## February 2025

### New articles

- [Network topology and connectivity for Oracle Database@Azure - Application connectivity design](../scenarios/oracle-on-azure/application-connectivity-design.md): Learn how to establish direct connectivity between database and application VMs in Oracle IaaS environments. Explore the importance of secure and efficient network configurations to ensure seamless communication and optimal performance.
- [Network topology and connectivity for Oracle Database@Azure - BCDR connectivity design](../scenarios/oracle-on-azure/business-continuity-disaster-recovery-connectivity-design.md): Explore comprehensive guidance on designing network connectivity for high availability and disaster recovery of Oracle Exadata Database@Azure deployments. Learn about redundancy strategies both within a single region and across multiple regions, emphasizing the use of Azure and OCI networking, availability zones, and Data Guard configurations.
- [Network topology and connectivity for Oracle Database@Azure - Core network design](../scenarios/oracle-on-azure/core-network-design.md): Find essential guidance on designing the core network for Oracle Exadata Database@Azure, including key networking concepts, like the unique architecture of Oracle Database@Azure, and design considerations such as availability zone selection, subnet sizing, and network security group configuration.
- [Network topology and connectivity for Oracle Database@Azure - Migration connectivity design](../scenarios/oracle-on-azure/migration-connectivity-design.md): Learn how to design connectivity solutions for Oracle Infrastructure as a Service (IaaS) migration scenarios. Explore best practices for ensuring secure, reliable, and efficient network architectures to facilitate the migration process.
- [Resource organization for Oracle Database@Azure](../scenarios/oracle-on-azure/oracle-resource-organization-oracle-database-azure.md): Learn best practices for naming and tagging conventions, security and isolation architectures, and subscription design. Explore how to use a multiple subscription architecture to isolate different environments such as production, development, and testing.

### Updated articles

- [Inventory and visibility considerations](../ready/landing-zone/design-area/management-platform.md): We added information on application teams and their responsibilities for inventory and visibility, including the use of Azure Monitor Agent and Log Analytics workspaces.
- [Management and monitoring for Azure VMware Solution](../scenarios/azure-vmware/eslz-management-and-monitoring.md): We added references to Azure Monitor baselines alerts (AMBA).
- [Plan for inbound and outbound internet connectivity](../ready/azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity.md): We made updates to include guidance on ensuring that Management NIC is enabled with all Azure Firewall deployments.
- [Resource organization considerations for Azure Virtual Desktop](../scenarios/azure-virtual-desktop/eslz-resource-organization.md): We added guidance on naming and tagging standards and introduced sections on the scope of management settings, components, naming standards, and resource tags.

We made updates to these articles to reflect the latest guidance on migrating to virtual network flow logs due to the upcoming retirement of NSG flow logs:

- [Plan for landing zone network segmentation](../ready/azure-best-practices/plan-for-landing-zone-network-segmentation.md)
- [Plan for traffic inspection](../ready/azure-best-practices/plan-for-traffic-inspection.md)

#### Oracle updates

- [Manage and monitor Oracle workloads on Azure Virtual Machines landing zone accelerator](../scenarios/oracle-on-azure/oracle-manage-monitor-iaas.md): We made updates to refresh the content and improve clarity. This article provides guidance on managing and monitoring Oracle workloads on Azure Virtual Machines, including best practices for performance optimization, security, and compliance.
- [Security guidelines for Oracle Database@Azure](../scenarios/oracle-on-azure/oracle-security-overview-odaa.md): We added detailed descriptions of the integration between Azure and Oracle Cloud Infrastructure (OCI) for managing Oracle Exadata Database@Azure resources. We also added design considerations such as: The need for network security groups (NSGs) and network address translation (NAT) configurations; Guidelines for storing and managing encryption keys and database backups; Recommendations for the deployment and management of non-Microsoft and Oracle agents.

## January 2025

### New articles

- [Capacity Planning for Oracle Database@Azure Using Exadata Database Service](../scenarios/oracle-on-azure/oracle-capacity-planning-oracle-database-azure.md): Learn how to plan for capacity when migrating Oracle Database to Azure using Exadata Database Service. Explore key considerations for capacity planning, including workload analysis, performance tuning, and resource allocation. Recommendations include planning for sufficient IP address ranges, scaling infrastructure based on workload requirements, and understanding storage configuration impacts.

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
- [Network topology and connectivity for Azure Arc-enabled servers](../scenarios/hybrid/arc-enabled-servers/eslz-arc-servers-connectivity.md): Explore new guidance on Azure Arc Gateway including instructions for defining agent connectivity methods.
- [Organize your Azure resources effectively](../ready/azure-setup-guide/organize-resources.md): Find updated links for management group design, subscription considerations, and tagging strategy. Updates emphasize the importance of applying critical settings at higher levels and project-specific requirements at lower levels, and include additional details on naming conventions and resource tagging to enhance resource identification and management.
- [Review product migration scenarios](../migrate/scenarios.md): Explore the new Google Cloud Platform scenario for migrating VMs to Azure.

#### AI Adoption updates

- [AI Governance for PaaS workloads](../scenarios/ai/platform/governance.md): Learn how to control the models you allow across Azure and deployed in Azure AI Foundry.
- [Secure AI](../scenarios/ai/secure.md): Learn how to conduct red team testing on generative AI and nongenerative AI models.

#### Oracle updates

- [Business continuity and disaster recovery considerations for Oracle Database@Azure](../scenarios/oracle-on-azure/oracle-disaster-recovery-oracle-database-azure.md): We added new design considerations and recommendations for multiple-zone and multiregional BCDR architectures, extended BCDR scenarios, backup recommendations, and introduced additional best practices for maintaining data resilience and automating failover operations.
- [Identity and access management for Oracle Database@Azure](../scenarios/oracle-on-azure/oracle-iam-odaa.md): Explore new sections covering considerations for private offers, default group creation, custom group names, federation with non-Microsoft identity providers, and enhanced RBAC permissions.
- [Migration Planning for Oracle on Azure](../scenarios/oracle-on-azure/oracle-migration-planning.md):  We introduced new sections on Oracle Database@Azure migration, online and offline migration paths, and an ExpressRoute-based migration duration reference table.

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
- [Introduction to Oracle on Azure adoption scenarios](../scenarios/oracle-on-azure/index.md): Explore new guidance on multi-region design for Oracle workloads on Azure, enhancing availability, scalability, and disaster recovery.

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

- [Compute recommendations](../scenarios/ai/infrastructure/compute.md): Learn how to select VMs, images, and orchestration solutions to optimize AI workloads on Azure. See recommendations for training and inferencing AI models, managing costs, and using containers for scalable AI solutions.
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
- [Migrate Oracle workloads to Azure](../scenarios/oracle-on-azure/oracle-migration-planning.md)
- [Network connectivity for Azure Arc-enabled servers](../scenarios/hybrid/arc-enabled-servers/eslz-arc-servers-connectivity.md)
- [Security governance and compliance for Citrix on Azure](../scenarios/azure-virtual-desktop/landing-zone-citrix/citrix-security-governance-compliance.md)
- [Security guidelines for Oracle Database@Azure](../scenarios/oracle-on-azure/oracle-security-overview-odaa.md)

## August 2024

### Updated articles

- [Responsible and trusted AI adoption](../strategy/responsible-ai.md): Explore new guidance about how to develop AI responsibly and build safer systems with Azure AI Content Safety. Learn about the importance of responsible AI and the features of the Responsible AI dashboard for Azure Machine Learning.
- [Landing zone identity and access management](../ready/landing-zone/design-area/identity-access-landing-zones.md): Find new guidance about built-in and custom RBAC roles, least-privelage access, and conditions.
- [Security guidelines for Oracle Database@Azure](../scenarios/oracle-on-azure/oracle-security-overview-odaa.md): Explore new updates about network security group rules and Oracle Data Safe.
- [Business continuity and disaster recovery for an SAP migration](../scenarios/sap/eslz-business-continuity-and-disaster-recovery.md): Learn about the benefits of using Azure Backup to back up databases that have SAP HANA System Replication enabled.

We made updates to the following articles for clarity:
- [Network considerations for Azure VMware Solution dual-region deployments](../scenarios/azure-vmware/eslz-dual-region-network-topology.md)
- [What is a data product?](../scenarios/cloud-scale-analytics/architectures/what-is-data-product.md)
- [Cloud adoption scenarios](../scenarios/index.md)
- [Oracle on Azure IaaS landing zone accelerator](../scenarios/oracle-on-azure/oracle-landing-zone-accelerator.md)
- [Security governance and compliance for Citrix on Azure](../scenarios/azure-virtual-desktop/landing-zone-citrix/citrix-security-governance-compliance.md)

<!-- docutune:ignoreNextStep -->
