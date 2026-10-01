---
title: What's New in Microsoft's Cloud Adoption Framework
description: Learn about recent updates to Microsoft's Cloud Adoption Framework.
author: stephen-sumner
ms.author: pnp
ms.date: 08/27/2026
ai-usage: ai-assisted
ms.update-cycle: 180-days
ms.topic: concept-article
ms.custom: UpdateFrequency.5, historical
---

# What's new in Microsoft's Cloud Adoption Framework

Microsoft continuously updates the Cloud Adoption Framework with new guidance, enhanced content, and refined recommendations based on customer experiences and evolving cloud practices. This article lists announcements and information as the framework evolves.

## October 2026

**"Application landing zones" are now called "Workload landing zones"**: We've updated Cloud Adoption Framework guidance to use the term workload landing zone instead of application landing zone. This update applies across the framework, including articles, diagrams, and supporting content.

The new terminology more accurately reflects the purpose of these environments. A workload landing zone hosts and operates a workload that supports a business outcome. Workloads can include applications, data platforms, AI and machine learning solutions, infrastructure automation, and other Azure resources. Custom applications remain an important workload type, but they represent only one category of workload.

As part of this update, we also removed the distinction between application landing zones, data landing zones, and data management landing zones. These categories often created unnecessary complexity because the resources deployed to them are all workload resources. Azure landing zone now use a simpler model that distinguishes between platform resources, which reside in the platform landing zone, and workload resources, which reside in one or more workload landing zones.

This change does not affect the architecture, scope, or intent of the guidance. It aligns Cloud Adoption Framework terminology more closely with the Azure Well-Architected Framework, which is organized around workload design principles.

**Deleted articles**: We removed Cloud Adoption Framework architecture articles covering the following services:

- Azure Kubernetes Service (AKS)
- Azure Red Hat OpenShift (ARO)
- Azure Red Hat Enterprise Linux (RHEL)

Only the Cloud Adoption Framework articles were removed. Associated workload landing zone accelerator repositories remain available:

- [Azure Kubernetes Service workload landing zone accelerator](https://github.com/Azure/AKS-Landing-Zone-Accelerator)
- [Azure Red Hat Openshift workload landing zone accelerator](https://github.com/Azure/ARO-Landing-Zone-Accelerator)

Cloud Adoption Framework focuses on helping decision makers define cloud strategy, establish governance, plan investments, and design operating models. Detailed workload architecture guidance is available through the [Azure Architecture Center](/azure/architecture/) and the [Well-Architected Framework](/azure/well-architected/), which remain the primary sources for architecture guidance.

## September 2026

This update highlights recent additions to Azure landing zone and Azure VMware Solution guidance, scenario deprecations, and roadmap items across the Cloud Adoption Framework.

### Azure landing zone

We updated the Azure landing zone guidance to provide a clearer explanation of what an Azure landing zone is and how organizations can implement one. The update includes four new conceptual diagrams, available for download, that illustrate key components, recommended practices, and integration patterns.

Learn more in [What's an Azure landing zone?](/azure/cloud-adoption-framework/ready/landing-zone)

### Azure VMware Solution adoption

We published new guidance to help decision makers evaluate and plan for Azure VMware Solution adoption. The guidance provides an overview of key adoption considerations and covers planning, architecture (Azure landing zone updates), governance, operational standards, and migration.

Learn more at [**aka.ms/cafavs**](/azure/cloud-adoption-framework/azure-vmware-solution/strategy).

### Deprecations

We deprecated several scenarios that will be removed from the Cloud Adoption Framework in the coming months. To retain a copy of this guidance, see the individual articles for instructions.

| Last available date | Scenarios to be removed |
| --- | --- |
| September 30, 2026 | Modern app platform |
| October 30, 2026 | [Azure Virtual Desktop](/azure/cloud-adoption-framework/scenarios/azure-virtual-desktop/)<br>[SAP on Azure](/azure/cloud-adoption-framework/scenarios/sap/strategy)<br>[Hybrid and multicloud](/azure/cloud-adoption-framework/scenarios/hybrid/strategy)<br>[Oracle on Azure](/azure/cloud-adoption-framework/scenarios/oracle-on-azure/) |

The Cloud Adoption Framework remains focused on helping decision makers make better and faster cloud adoption decisions for their organization. For workload architecture, implementation guidance, and product-specific recommendations, use the Azure Architecture Center, Microsoft Well-Architected Framework, and product documentation.

### Roadmap

The following items reflect areas of active investment and might change over time.

**New sovereignty guidance**: We're developing new guidance on sovereignty in Azure. The guidance will provide information about sovereignty-related concepts, considerations, and deployment models across Azure environments.

**Application landing zone terminology update.** We will be updating references to *application landing zones* to use the term *workload landing zones*. This change does not alter the scope or intent of the term or guidance. The updated terminology better reflects what the guidance describes: the environment used to host and operate workloads. It also aligns more closely with Azure terminology and related guidance, such as the Microsoft Well-Architected Framework, which commonly refers to workloads.

**Updated Azure landing zone guidance (CAF Ready).** We are working on a new version of Azure landing zone guidance.

## June 2026

**Azure landing zone**: It was announced that Azure Migrate product team now owns the **platform landing zone accelerator**. See this [blog](https://techcommunity.microsoft.com/blog/azuregovernanceandmanagementblog/azure-landing-zone-alz-enters-its-next-chapter/4533520) for details. This ownership change affects only the ownership of the accelerator assets and has no impact on users or the guidance in the Cloud Adoption Framework.

An *Azure landing zone* is the proven architecture for governing and scaling a multi-subscription Azure environment. An *Azure landing zone* consists of two components:

- **Platform landing zone** (typically one per Microsoft Entra tenant)
- **Application (workload) landing zones** (multiple per workload)

To implement a platform landing zone, decision makers use the Cloud Adoption Framework to help make the right architecture decisions for their organization. The decisions serve as an input to their platform landing zone design.

When organizations are ready to implement their platform landing zone, they have two general options:

- [**Platform landing zone accelerator**](/azure/architecture/landing-zones/landing-zone-deploy#choose-a-platform-landing-zone-approach): Microsoft-provided infrastructure-as-code deployment options (now owned by the Azure Migrate team).

- **Custom build**: Built internally or with support from Microsoft or Microsoft partners.

The Azure Migrate team now owns the first implementation option, the **platform landing zone accelerator**. This change affects only the ownership of the **platform landing zone accelerator** and its related assets. It doesn't affect users, functionality, or guidance. It also doesn't affect the *Azure landing zone* guidance, design recommendations, or best practices in the Cloud Adoption Framework.

The Cloud Adoption Framework remains the source of proven *Azure landing zone* guidance. Decision makers should continue to use the Cloud Adoption Framework to make architecture and design decisions for their Azure landing zone.

We are working on updates to improve the Cloud Adoption Framework guidance. Stay tuned for those improvements.

## May 2026

**Deleted articles**: We deleted articles for the following workload landing zone accelerators. The process removed only the articles in the Cloud Adoption Framework. The repositories in GitHub with the deployable assets are still available. Use the following links to access GitHub:

- [Azure Integration Services GitHub repo](https://github.com/Azure/Integration-Services-Landing-Zone-Accelerator)
- [Azure API Management](https://github.com/Azure/apim-landing-zone-accelerator)
- [Azure App Service](https://github.com/Azure/appservice-landing-zone-accelerator)
- [Azure Container Apps](https://github.com/Azure/aca-landing-zone-accelerator)

**Rationale:** The Cloud Adoption Framework is a roadmap for decision makers. It helps them make the best architecture, investment, and policy decisions for their organization. Workload design guidance is provided through the Azure Architecture Center and the Microsoft Well-Architected Framework, which remain the primary sources for alternative architecture guidance.

## April 2026

### Deprecation notice

**Articles for select workload landing zone accelerator are deprecated.** Azure Integration Services, Azure Kubernetes Services, Azure API Management, Azure App Service, and Azure Container Apps guidance was deprecated.

## March 2026

### New guidance

[**Unify your data platform for AI and analytics**](./data/executive-strategy-unify-data-platform.md): CAF has new guidance on how to unify your data platform with Microsoft Fabric. This guidance helps decision makers organize operating models around data domains, define clear data ownership and accountability, and establish standards for secure and governed data products. It also explains how high-quality data products support AI and analytics across the organization.

### Deprecation notice

**Cloud-scale analytics guidance is deprecated.** We replaced this guidance with [Unify your data platform for AI and analytics](./data/executive-strategy-unify-data-platform.md). The deprecation and deletion date was April 30, 2026.

## December 2025

### New guidance

[AI agent adoption guidance for organizations](ai-agents/index.md): Discover how to adopt AI agents effectively by using a step-by-step framework for planning, governance, integration, and measurement that maximizes business impact.

### Updated articles

- [Security control mapping with Azure landing zone](ready/control-mapping/security-control-mapping.md): Improved clarity and readability throughout the article, simplified terminology for the Microsoft Cloud Security Benchmark, and updated implementation guidance to reference Azure Verified Modules for Terraform and Bicep deployments.

- [Azure landing zone frequently asked questions (FAQs)](ready/enterprise-scale/faq.md): Broadened sovereign landing zone guidance to apply to all organizations that have sovereignty needs rather than only government organizations.

- [Encryption and key management in Azure](ready/landing-zone/design-area/encryption-and-keys.md): Added guidance about choosing the right Azure Key Vault key management solution. Enhanced Key Vault recommendations by clarifying when to use Azure Key Vault Managed HSM for centralized scenarios and explaining the benefits of multiple key vaults.

- [Azure workload management and monitoring](ready/landing-zone/design-area/management-workloads.md): Added guidance about using Azure service groups to organize workload resources across subscriptions and resource groups. Introduced health models in Azure Monitor (preview) to define and track resource health.

- [Migrate Azure landing zone custom policies to Azure built-in policies](ready/landing-zone/design-area/migrate-azure-landing-zone-policies.md): Simplified the policy migration guidance by consolidating references to Azure Verified Modules for Terraform and Bicep update guides and removing redundant step-by-step instructions.

- [Overview of network topology and connectivity for Azure](ready/landing-zone/design-area/network-topology-and-connectivity.md): Improved readability by adding better formatting to the Connectivity, Corp, and Online management group descriptions. Added a tip that simplifies understanding the Corp (internal-facing) and Online (public-facing) management groups.

- [Subscription considerations and recommendations](ready/landing-zone/design-area/resource-org-subscriptions.md): Enhanced platform subscription guidance to include a separate dedicated security subscription and emphasized not combining platform responsibilities into a single subscription. Added recommendations for quota management using quota groups and automation. Introduced an operational excellence section that includes Azure Service Health guidance.

- [Update Azure landing zone custom policies](ready/landing-zone/design-area/update-custom-policies.md): Simplified policy update guidance by consolidating Bicep update instructions and updating references to Azure Verified Modules for Terraform and Bicep.

- [Independent software vendor (ISV) considerations for Azure landing zone](ready/landing-zone/isv-landing-zone.md): Added a recommendation for ISVs to include a separate Security management group under the Platform management group. Noted that the Security management group is planned for future updates.

- [Platform landing zone implementation options](ready/landing-zone/implementation-options.md): Restructured the article to focus specifically on platform landing zone implementation and simplified guidance to two main approaches. It includes the recommended infrastructure as code (IaC) accelerator with a detailed four-phase approach, and the portal-based accelerator. Replaced multiple implementation variants with improved options and enhanced Azure Verified Modules guidance for both Bicep and Terraform.

- [What is an Azure landing zone?](ready/landing-zone/index.md): Restructured deployment guidance to emphasize the IaC accelerator as the recommended approach. Enhanced workload landing zone descriptions with subscription vending details and clarified the *landing zone P1 subscription* purpose.

- [Manage your cloud estate with enhanced security](secure/manage.md): Added guidance to review Microsoft Secure Future Initiative requirements and integrate them into security assessments.

- [Assess your workloads for cloud migration](plan/assess-workloads-for-cloud-migration.md): Replaced AppCAT references with the GitHub Copilot app modernization tool and detailed its capabilities, including dependency capture, code revision, containerization, deployment file generation, and AI-assisted coding.

- [Security teams, roles, and functions](secure/teams-roles.md): Added a new section about minimum viable security teams for small organizations and enhanced explanations about how security roles transform with cloud adoption and modern development practices.

## November 2025

### Updated articles

- [Govern Azure platform as a service (PaaS) solutions for AI](scenarios/ai/platform/governance.md): Improved explanations of key concepts like provisioned throughput units (PTUs), retrieval-augmented generation (RAG), and role-based access control (RBAC) by adding definitions and practical examples. Reorganized content into clearer steps and added concrete examples, such as using a generative AI gateway to manage costs and implementing version control for training datasets.

- [Business continuity and disaster recovery for Azure Virtual Desktop](scenarios/azure-virtual-desktop/eslz-business-continuity-and-disaster-recovery.md): Clarified the active-active host pool section by explaining the two-region setup with user assignment and failover procedures. Added guidance about FSLogix profile storage behavior in the active-passive scenario.

- [Manage your cloud estate with enhanced security](secure/manage.md): Improved formatting consistency and clarity. Enhanced the business continuity and disaster recovery recommendation by clarifying the distinction between disaster recovery planning and resilient architecture design with more precise, actionable language.

- [Prepare your secure cloud estate](secure/ready.md): Improved terminology and formatting. Changed *resiliency* to *reliability* throughout the availability section to align with Well-Architected Framework terminology. Clarified the distinction between resilience patterns and recoverability mechanisms in the design recommendation. Standardized spacing between bullet points for better readability.
