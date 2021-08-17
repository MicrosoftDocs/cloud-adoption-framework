---
title: Tools and templates
description: Find the tools and templates that are available in the Cloud Adoption Framework to help you accelerate your cloud adoption.
author: JanetCThomas
ms.author: janet
ms.date: 08/17/2021
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

# Tools and templates

The Cloud Adoption Framework includes tools that help you quickly implement technical change. Use these tools, templates, and assessments to accelerate cloud adoption. The following resources can help you in each phase of adoption. Some of the tools and templates can be used in multiple phases.

## Strategy

| Resource | Description |
|----------|-------------|
| [Cloud journey tracker](/assessments/?id=cloud-journey-tracker&mode=pre-assessment) | Identify your cloud adoption path based on the needs of your business. |
| [Strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) | Document decisions as you execute your cloud adoption strategy and plan. |

## Plan

| Resource | Description |
|----------|-------------|
| [Strategic migration assessment and readiness tool](/assessments/?mode=pre-assessment&id=Strategic-Migration-Assessment) | From business planning to training to security and governance, find out what you need to do to prepare for your Microsoft Azure migration with the strategic migration assessment and readiness tool (SMART). |
| [Cloud journey tracker](/assessments/?id=cloud-journey-tracker&mode=pre-assessment) | Identify your cloud adoption path based on the needs of your business. |
| [Strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) | Document decisions, as you execute your cloud adoption strategy and plan. |
| [Cloud adoption plan generator](../plan/template.md) | Standardize processes by deploying a backlog to [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards) using a template. |
| [Using the `Strategy-Plan-Ready-Govern` Azure DevOps template](https://azuredevopsdemogenerator.azurewebsites.net/?name=strategyplan) | Standardize processes by deploying a backlog to [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards) using a template. |

## Ready

| Resource | Description |
|----------|-------------|
| [Readiness checklist](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/ready/readiness-checklist.docx) | Use this checklist to prepare your environment for adoption. This preparation includes preparing your first migration landing zone, personalizing the blueprint, and expanding it. |
| [Naming and tagging conventions tracking template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/naming-and-tagging-conventions-tracking-template.xlsx) | Document decisions about naming and tagging standards to ensure consistency and reduce onboarding time. |
| [CAF Foundation blueprint](https://github.com/Microsoft/CloudAdoptionFramework/tree/master/ready/migration-landing-zone-governance) | Use a lightweight implementation of an initial governance foundation to provide practical experience with governance tools in Azure. |
| [CAF Migration landing zone blueprint](https://github.com/Microsoft/CloudAdoptionFramework/tree/master/ready/migration-landing-zone) | Provision and prepare to host workloads being migrated from an on-premises environment into Azure. For more information about this blueprint, see [Deploy a migration landing zone](../ready/landing-zone/migrate-landing-zone.md). |
| [Terraform modules](../ready/landing-zone/terraform-landing-zone.md) | Open-source code base for the Terraform version of the CAF Azure landing zones. |
| [Terraform registry](https://registry.terraform.io/search?q=aztfmod) | The Terraform registry website, filtered to list all of the Cloud Adoption Framework modules needed to create a landing zone via Terraform. |
| [Enterprise-scale landing zone](https://github.com/Azure/Enterprise-Scale/) | Open-source code base for the enterprise-scale implementation of the CAF Azure landing zones. |

## Govern

| Resource | Description |
|----------|-------------|
| [Governance benchmark assessment](https://cafbaseline.com) | Identify gaps between your current state and business priorities, and get the right resources to help you address those gaps. |
| [CAF Foundation blueprint](https://github.com/Microsoft/CloudAdoptionFramework/tree/master/ready/migration-landing-zone-governance) | Lightweight implementation of an initial governance foundation to provide practical experience with governance tools in Azure. |
| [Governance discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/govern/governance-discipline-template.docx) | Define the basic set of governance processes used to enforce each governance discipline. |
| [Cost Management discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/govern/cost-management-discipline-template.docx) | Define the policy statements and design guidance to mature the cloud governance in your organization. Focuses on cost management. |
| [Deployment Acceleration discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/govern/deployment-acceleration-discipline-template.docx) | Define the policy statements and design guidance to mature the cloud governance in your organization. Focuses on deployment acceleration. |
| [Identity Baseline discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/govern/identity-baseline-discipline-template.docx) | Define the policy statements and design guidance to mature the cloud governance in your organization. Focuses on identity requirements. |
| [Resource Consistency discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/govern/resource-consistency-discipline-template.docx) | Define the policy statements and design guidance to mature the cloud governance in your organization. Focuses on resource consistency. |
| [Security Baseline discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/govern/security-baseline-discipline-template.docx) | Define the policy statements and design guidance to mature the cloud governance in your organization. Focuses on the security baseline. |
| [Azure Security Benchmark](/security/benchmark/azure/overview) | The Azure Security Benchmark (ASB) provides prescriptive best practices and recommendations to help improve the security of workloads, data, and services on Azure. |
| [Azure governance visualizer](https://github.com/JulianHayward/Azure-MG-Sub-Governance-Reporting) | The Azure governance visualizer is a PowerShell script that iterates through an Azure tenant's management group hierarchy down to the subscription level. It captures data from the most relevant Azure governance capabilities such as Azure Policy, Azure role-based access control (Azure RBAC), and Azure Blueprints. From the collected data, the visualizer shows your hierarchy map, creates a tenant summary, and builds granular scope insights about your management groups and subscriptions. |

## Migrate

| Resource | Description |
|----------|-------------|
| [Datacenter migration discovery checklist](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/migrate/datacenter-migration-discovery-checklist.docx) | Review this checklist for information that helps identify workloads, servers, and other assets in your datacenter. Use this information to help plan your migration.
| [Migration templates](https://aka.ms/adopt/plan/generator) | In the Azure DevOps generator, we've built several templates that you can use to help streamline your projects. Templates have been created for [Azure Virtual Desktop](https://azuredevopsdemogenerator.azurewebsites.net/?name=wvdmigration), [server migration](https://azuredevopsdemogenerator.azurewebsites.net/?name=servermigration), [SQL migration](https://azuredevopsdemogenerator.azurewebsites.net/?name=sqlmigration), and [AKS deployments](https://azuredevopsdemogenerator.azurewebsites.net/?name=cafaks).

## Innovate

| Resource | Description |
|----------|-------------|
| [Deployment templates](https://aka.ms/adopt/plan/generator) | The Azure DevOps generator has project checklists to help you build your [knowledge mining](https://azuredevopsdemogenerator.azurewebsites.net/?name=kmine), [modern data warehouse](https://azuredevopsdemogenerator.azurewebsites.net/?name=moddw), and industry focused accelerators like the [retail recommender](https://azuredevopsdemogenerator.azurewebsites.net/?name=retai) using AI and [modern IoT](https://azuredevopsdemogenerator.azurewebsites.net/?name=modiot). The templates give you a structured approach and checklist to follow. Each template and work item has links to required content, assets, and code samples that can help you get started.
| [Solution Accelerators](https://aka.ms/adopt/plan/generator) | The Cloud Adoption Framework Solution Accelerators are intended to help you rapidly deploy applications and workloads to address business challenges. Today we have solution accelerators for, [Retail Recommendation](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator), [Demand Forecasting](https://github.com/microsoft/solution-accelerator-many-models), [Modern Finance](https://github.com/microsoft/Azure-Synapse-Solution-Accelerator-Financial-Analytics-Customer-Revenue-Growth-Factor) and  Workplace Intelligence for IT. |

## Manage

| Resource | Description |
|----------|-------------|
| [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review) | This online assessment aids in defining workload-specific architectures and operations options. |
| [Best practices source code](https://github.com/Microsoft/CloudAdoptionFramework/tree/master/manage/Automation-Best-Practices) | This deployable source code complements and accelerates adoption of best practices for Azure server management services. Use this source code to quickly enable operations management and establish an operations baseline. |
| [Operations management workbook](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) | Document decisions about operations management in the cloud, and facilitate conversations with the business to ensure alignment regarding SLAs, investment in resiliency, and budget allocation related to operations. |

## Organize

| Resource | Description |
|----------|-------------|
| [Cross-team responsible, accountable, consulted, and informed (RACI) diagram](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/organize/raci-template.xlsx) | Download and modify the RACI spreadsheet template to track organizational structure decisions over time. |

## Secure

| Resource | Description |
|----------|-------------|
| [Deploy STIG compliant Windows VM](/azure/azure-government/documentation-government-stig-windows-vm) | This quickstart shows how to deploy a STIG-compliant Windows virtual machine (Preview) on Azure or Azure Government using the corresponding portal.
| [Deploy STIG compliant Linux VM](/azure/azure-government/documentation-government-stig-linux-vm) | This quickstart shows how to deploy a STIG-compliant Linux virtual machine (Preview) on Azure or Azure Government using the corresponding portal.
