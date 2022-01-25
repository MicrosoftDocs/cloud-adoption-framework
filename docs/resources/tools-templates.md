---
title: Tools and templates
description: Find the tools and templates that are available in the Cloud Adoption Framework to help you accelerate your cloud adoption.
author: JanetCThomas
ms.author: janet
ms.date: 01/13/2022
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

# Tools and templates

The Cloud Adoption Framework has tools, templates, and assessments that can help you quickly implement technical changes. Use this framework to accelerate your cloud adoption. The following resources can help you in each phase of adoption. These tools, templates, and assessments can be used in multiple phases.

## Strategy

| Resource | Description |
|----------|-------------|
| [Cloud Adoption Strategy Evaluator](/assessments/?mode=pre-assessment&id=8fefc6d5-97ac-42b3-8e97-d82701e55bab) | Assess your cloud adoption strategy, and get recommendations on building and advancing your cloud business case. |
| [Cloud Journey Tracker](/assessments/?id=cloud-journey-tracker&mode=pre-assessment) | Identify your cloud adoption path based on the needs of your business. |
| [Strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) | Document decisions, as you execute your cloud adoption strategy and plan. |

## Plan

| Resource | Description |
|----------|-------------|
| [Strategic migration assessment and readiness tool](/assessments/?mode=pre-assessment&id=Strategic-Migration-Assessment) | From business planning to training—to security and governance—prepare for your Microsoft Azure migration using the strategic migration assessment and readiness tool (SMART). |
| [Cloud Journey Tracker](/assessments/?id=cloud-journey-tracker&mode=pre-assessment) | Identify your cloud adoption path based on the needs of your business. |
| [Strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) | Document your decisions—as you execute your cloud adoption strategy and plan. |
| [Cloud adoption plan generator](../plan/template.md) | Standardize your processes—using a template to deploy a backlog to [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards). |
| [Using the `Strategy-Plan-Ready-Govern` Azure DevOps template](https://azuredevopsdemogenerator.azurewebsites.net/?name=strategyplan) | Standardize your processes—deploying a backlog to [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards) using a template. |

## Ready

| Resource | Description |
|----------|-------------|
| [Readiness checklist](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/ready/readiness-checklist.docx) | Use this checklist to prepare your environment for adoption. It includes preparations for your first migration landing zone, personalizing the blueprint, and expanding it. |
| [Azure Naming Tool](https://github.com/microsoft/CloudAdoptionFramework/tree/master/ready/AzNamingTool) | Develop your comprehensive Azure naming convention in minutes. |
| [Naming and tagging conventions tracking template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/naming-and-tagging-conventions-tracking-template.xlsx) | Document your decisions about naming and tagging standards to ensure consistency across resources, and reduce onboarding time. |
| [CAF Foundation blueprint](https://github.com/Microsoft/CloudAdoptionFramework/tree/master/ready/migration-landing-zone-governance) | Deploy your lightweight implementation of an initial governance foundation—providing practical experience with governance tools in Azure. |
| [CAF Migration landing zone blueprint](https://github.com/Microsoft/CloudAdoptionFramework/tree/master/ready/migration-landing-zone) | Provision—and prepare to host your workloads that are migrated from on-premises environments into Azure. Read more on how to [Deploy a migration landing zone](../ready/landing-zone/migrate-landing-zone.md) blueprint. |
| [Terraform modules](../ready/landing-zone/terraform-landing-zone.md) | Use the Terraform open-source code base to build your CAF Azure landing zone. |
| [Terraform registry](https://registry.terraform.io/search?q=aztfmod) | Create your landing zone via Terraform—filtering the Terraform registry website to list requisite Cloud Adoption Framework modules. |
| [Enterprise-scale landing zone](https://github.com/Azure/Enterprise-Scale/) | Deploy your open-source code base for the enterprise-scale implementation of the CAF Azure landing zone. |
| [Data management zone](https://github.com/Azure/data-management-zone) | Deploy a single Data Management Zone to your subscription. (We recommend deploying the Data Management Zone before the data landing zone).|
| [Data landing zone](https://github.com/Azure/data-landing-zone) | Expand your landing zone with data. Data landing zone shared services include data storage, ingestion services, and management services. |
| [Data management and landing zone Azure DevOps template](https://azuredevopsdemogenerator.azurewebsites.net/?name=dataanalytics) | Use this template to guide you through step-by-step decisions to build your data management and landing zone. |

## Govern

| Resource | Description |
|----------|-------------|
| [Governance benchmark assessment](https://cafbaseline.com) | Identify gaps between your current state and business priorities, and find resources to help you address what's missing. |
| [CAF Foundation blueprint](https://github.com/Microsoft/CloudAdoptionFramework/tree/master/ready/migration-landing-zone-governance) | Deploy your lightweight implementation of an initial governance foundation—providing practical experience with governance tools in Azure. |
| [Governance discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/govern/governance-discipline-template.docx) | Define your basic set of governance processes used to enforce each governance discipline. |
| [Cost Management discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/govern/cost-management-discipline-template.docx) | Define your policy statements and design guidance to mature the cloud governance in your organization. Focuses on cost management. |
| [Deployment Acceleration discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/govern/deployment-acceleration-discipline-template.docx) | Define your policy statements and design guidance to mature the cloud governance in your organization. Focuses on deployment acceleration. |
| [Identity Baseline discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/govern/identity-baseline-discipline-template.docx) | Define your policy statements and design guidance to mature the cloud governance in your organization. Focuses on identity requirements. |
| [Resource Consistency discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/govern/resource-consistency-discipline-template.docx) | Define your policy statements and design guidance to mature the cloud governance in your organization. Focuses on resource consistency. |
| [Security Baseline discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/govern/security-baseline-discipline-template.docx) | Define your policy statements and design guidance to mature the cloud governance in your organization. Focuses on the security baseline. |
| [Azure Security Benchmark](/security/benchmark/azure/overview) | The Azure Security Benchmark (ASB) provides prescriptive best practices and recommendations to help improve the security of workloads, data, and services on Azure. |
| [Azure governance visualizer](https://github.com/JulianHayward/Azure-MG-Sub-Governance-Reporting) | The Azure governance visualizer is a PowerShell script that iterates through Azure tenant's management group hierarchy down to the subscription level. It captures data from the most relevant Azure governance capabilities—such as Azure Policy, Azure role-based access control (Azure RBAC), and Azure Blueprints. From the collected data, the visualizer shows your hierarchy map, creates a tenant summary, and builds granular scope insights about your management groups and subscriptions. |
| [Microsoft Product Placemat for CMMC L3](https://aka.ms/cmmc/productplacemat) | The Microsoft Product Placemat for Cybersecurity Maturity Model Certification (CMMC) Level 3 (Preview), is an interactive view representing how Microsoft cloud products and services satisfy requirements for CMMC practices. |

## Migrate

| Resource | Description |
|----------|-------------|
| [Datacenter migration discovery checklist](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/migrate/datacenter-migration-discovery-checklist.docx) | Make use of this checklist to help you to identify workloads, servers, and other assets in your datacenter. Use this information to help plan your migration.
| [Migration templates](https://aka.ms/adopt/plan/generator) | In the Azure DevOps generator, we've built several templates that you can use to help streamline your projects. Templates include [Azure Virtual Desktop](https://azuredevopsdemogenerator.azurewebsites.net/?name=wvdmigration), [server migration](https://azuredevopsdemogenerator.azurewebsites.net/?name=servermigration), [SQL migration](https://azuredevopsdemogenerator.azurewebsites.net/?name=sqlmigration), and [AKS deployments](https://azuredevopsdemogenerator.azurewebsites.net/?name=cafaks).

## Innovate

| Resource | Description |
|----------|-------------|
| [Knowledge Mining](https://aka.ms/adopt/plan/generator) | The knowledge mining Azure DevOps project simplifies the process of accessing the latent insights contained within structured and unstructured data.
| [Modern Data Warehouse](https://aka.ms/adopt/plan/generator) | Build your modern data warehouse using this Azure DevOps project—with links to assets, code and learning material intended to help simplify your deployment. |
| [Retail Recommender](https://aka.ms/adopt/plan/generator) | This Solution Accelerator provides end-to-end guidance to enable personalized customer experiences for retail scenarios—leveraging Azure Synapse Analytics, Azure Machine Learning Services, and other Azure Big Data services. Read more in the [Retail Recommender with Azure Synapse](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator) GitHub repo. |
| [Modern IoT Azure](https://aka.ms/adopt/plan/generator) | Connected sensors, devices, and intelligent operations can transform businesses, and enable new business growth opportunities. Find the work items needed to plan and implement your IOT solution using the [Azure IoT Platform](https://azure.microsoft.com/overview/iot/?WT.mc_id=devops_userstory_service_iot-inproduct-devopsportal). |
| [Many Models](https://github.com/microsoft/solution-accelerator-many-models) | In the real world, many problems can be too complex to be solved by a single machine learning model. Whether predicting sales for individual stores, building a predictive maintenance model for hundreds of oil wells, or tailoring the customer experience to individual users, building a model for each instance can lead to improved results across machine learning problems. |
| [Demand Forecasting](https://github.com/microsoft/Azure-Synapse-Solution-Accelerator-Financial-Analytics-Customer-Revenue-Growth-Factor) | This accelerator was built to provide developers with the resources needed to build a solution that identifies the top factors for revenue growth from an e-commerce platform—using Azure Synapse Analytics, and Azure Machine Learning.|

## Manage

| Resource | Description |
|----------|-------------|
| [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review) | This online assessment helps you to define workload-specific architectures and options across your operations. |
| [Best practices source code](https://github.com/Microsoft/CloudAdoptionFramework/tree/master/manage/Automation-Best-Practices) | This deployable source code accelerates the adoption of best practices for Azure server management services. Use it to quickly enable operations management, and establish an operations baseline. |
| [Operations management workbook](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) | Document decisions about operations management in the cloud. Facilitate conversations with the business to ensure alignment regarding SLAs, investment in resiliency, and budget allocation related to operations. |

## Organize

| Resource | Description |
|----------|-------------|
| [Cross-team responsible, accountable, consulted, and informed (RACI) diagram](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/organize/raci-template.xlsx) | Download—and personalize the RACI spreadsheet template to track your decisions regarding organizational structure over time. |

## Secure

| Resource | Description |
|----------|-------------|
| [Deploy STIG-compliant Windows VM](/azure/azure-government/documentation-government-stig-windows-vm) | This quickstart shows how to deploy a STIG-compliant Windows virtual machine (Preview) on Azure or Azure Government, using the corresponding portal.
| [Deploy STIG-compliant Linux VM](/azure/azure-government/documentation-government-stig-linux-vm) | This quickstart shows how to deploy a STIG-compliant Linux virtual machine (Preview) on Azure or Azure Government, using the corresponding portal.
