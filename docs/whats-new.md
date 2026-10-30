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

Microsoft regularly updates the Cloud Adoption Framework to reflect evolving cloud practices and customer needs. This article highlights recent updates and planned improvements to help you find relevant guidance and make informed cloud adoption decisions.

## November 2026

**Updated guidance**: We refined the AI adoption strategy article and simplified the unified data platform guidance to help decision makers evaluate options and make informed decisions.

- [AI adoption strategy](./ai/strategy.md)
- [Unified data platform](./data/executive-strategy-unified-data-platform.md)

**Deleted articles**: We removed product-specific Cloud Adoption Framework articles for the following technologies:

- SAP
- Oracle
- Azure Arc
- Azure Virtual Desktop

Associated GitHub repositories remain available. For service-specific guidance, refer to the relevant product documentation. This change reduces duplication and keeps the Cloud Adoption Framework focused on organizational cloud adoption decisions.

**Deprecated articles**: We deprecated the following guidance and plan to remove it from Microsoft Learn on November 30, 2026. If you need to retain this content, download the source files from GitHub or save a PDF before the removal date. See the linked articles for more information.

- [Organize](/azure/cloud-adoption-framework/organize/)
- [Ready antipatterns](/azure/cloud-adoption-framework/antipatterns/ready-antipatterns)
- [Tools and templates](/azure/cloud-adoption-framework/resources/tools-templates)

**Deprecated assessments**: We deprecated several Cloud Adoption Framework assessments and plan to remove them in January 2027. Removing these assessments will also delete saved progress and previous results. Export or save any information you want to retain before the removal date.

- Cloud Adoption Strategy Evaluator
- Cloud Governance
- Cloud Journey Tracker
- Developer Velocity Assessment
- Strategic Migration Assessment and Readiness Tool

For ongoing cloud adoption planning, consider using AI tools to explore current Cloud Adoption Framework guidance and evaluate options relevant to your organization. Review AI-generated recommendations against the published guidance before making decisions. See [Deprecated assessments](/assessments/browse/?searchterm=deprecated&page=1&pagesize=30)

**Roadmap**: We're working on the following improvements to help you find relevant guidance and make informed cloud adoption decisions. These plans reflect current priorities and might change.

- **Azure region selection**: Improve guidance for selecting Azure regions across your organization and understanding the implications for your platform landing zone.
- **Azure landing zone**: Update guidance to reflect current recommendations and support organizational platform architecture decisions.
- **Framework organization**: Simplify the framework structure to help you find guidance relevant to your cloud adoption decisions.
- **AI adoption and agents**: Refine guidance to help organizations make informed decisions about adopting AI and AI agents.

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
| October 30, 2026 | Azure Virtual Desktop<br>SAP on Azure<br>Hybrid and multicloud<br>Oracle on Azure |

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

[**Unified data platform for AI and analytics**](./data/executive-strategy-unified-data-platform.md): CAF has new guidance on how to unify your data platform with Microsoft Fabric. This guidance helps decision makers organize operating models around data domains, define clear data ownership and accountability, and establish standards for secure and governed data products. It also explains how high-quality data products support AI and analytics across the organization.