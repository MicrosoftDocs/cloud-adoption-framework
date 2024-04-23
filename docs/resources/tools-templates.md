---
title: Tools and templates
description: Find the tools and templates that are available in the Cloud Adoption Framework to help you accelerate your cloud adoption.
author: martinekuan
ms.author: martinek
ms.date: 03/28/2024
ms.topic: article
ms.subservice: caf-general
ms.custom: internal, UpdateFrequency5
---

# Tools and templates

The Cloud Adoption Framework for Azure has tools, templates, and assessments that can help you quickly implement technical changes. Use this framework to accelerate your cloud adoption. You can use the following resources in several cloud adoption phases.

## Strategy

| Resource | Description |
|----------|-------------|
| [Cloud Adoption Strategy Evaluator assessment](/assessments/8fefc6d5-97ac-42b3-8e97-d82701e55bab/) | Assess your cloud adoption strategy and get recommendations on building and advancing your cloud business case. |
| [Cloud Journey Tracker assessment](/assessments/cloud-journey-tracker/) | Identify your cloud adoption path based on the needs of your business. |
| [Strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/plan/cloud-adoption-framework-strategy-and-plan-template.docx) | Document decisions as you implement your cloud adoption strategy and plan. |

## Plan

| Resource | Description |
|----------|-------------|
| [Strategic Migration Assessment and Readiness Tool assessment](/assessments/Strategic-Migration-Assessment/) | Take the Strategic Migration Assessment and Readiness Tool (SMART) assessment to help you prepare for your Microsoft Azure migration in areas like business planning, training, security, and governance. |
| [Cloud Journey Tracker assessment](/assessments/cloud-journey-tracker/) | Identify your cloud adoption path based on the needs of your business. |
| [Strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/plan/cloud-adoption-framework-strategy-and-plan-template.docx) | Document your decisions as you implement your cloud adoption strategy and plan. |
| [Cloud adoption plan generator](../plan/template.md) | Standardize your processes. Use a template to deploy a backlog to [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards). |
| [Use the Strategy-Plan-Ready-Govern Azure DevOps template](https://azuredevopsdemogenerator.azurewebsites.net/?name=strategyplan) | Standardize your processes. Use a template to deploy a backlog to [Azure Boards](/azure/devops/boards/get-started/what-is-azure-boards). |

## Ready

| Resource | Description |
|----------|-------------|
| [Azure naming tool](https://github.com/mspnp/AzureNamingTool) | Develop your comprehensive Azure naming convention in minutes. |
| [Naming and tagging conventions tracking template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/ready/naming-and-tagging-conventions-tracking-template.xlsx) | Document your decisions about naming and tagging standards to ensure consistency across resources and reduce onboarding time. |
| [Terraform modules](../ready/landing-zone/deploy-landing-zones-with-terraform.md) | Use the Terraform open-source code base to build your CAF Azure landing zone. |
| [Terraform registry](https://registry.terraform.io/search?q=aztfmod) | Create your landing zone via Terraform - filtering the Terraform registry website to list requisite Cloud Adoption Framework modules. |
| [Enterprise-scale landing zone](https://github.com/Azure/Enterprise-Scale/) | Deploy your open-source code base for the enterprise-scale implementation of the CAF Azure landing zone. |
| [Data management zone](https://github.com/Azure/data-management-zone) | Deploy a single data management zone to your subscription. (We recommend deploying the data management zone before the data landing zone).|
| [Data landing zone](https://github.com/Azure/data-landing-zone) | Expand your landing zone with data. Data landing zone shared services include data storage, ingestion services, and management services. |
| [Data management and landing zone Azure DevOps template](https://azuredevopsdemogenerator.azurewebsites.net/?name=dataanalytics) | Use this template to build your data management and landing zone. |

## Govern

| Resource | Description |
|----------|-------------|
| [Governance benchmark assessment](/assessments/b1891add-7646-4d60-a875-32a4ab26327e/) | Identify gaps between your current state and business priorities and find resources to help you address what's missing. |
| [Governance discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/govern/governance-discipline-template.docx) | Define your basic set of governance processes used to enforce each governance discipline. |
| [Cost Management discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/govern/cost-management-discipline-template.docx) | Define your policy statements and design guidance to mature the cloud governance in your organization. Focuses on cost management. |
| [Deployment Acceleration discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/govern/deployment-acceleration-discipline-template.docx) | Define your policy statements and design guidance to increase the maturity of cloud governance in your organization. Focuses on deployment acceleration. |
| [Identity Baseline discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/govern/identity-baseline-discipline-template.docx) | Define your policy statements and design guidance to increase the maturity of cloud governance in your organization. Focuses on identity requirements. |
| [Resource Consistency discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/govern/resource-consistency-discipline-template.docx) | Define your policy statements and design guidance to increase the maturity of cloud governance in your organization. Focuses on resource consistency. |
| [Security Baseline discipline template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/govern/security-baseline-discipline-template.docx) | Define your policy statements and design guidance to increase maturity of the cloud governance in your organization. Focuses on the security baseline. |
| [Azure Security Benchmark](/security/benchmark/azure/overview) | The Azure Security Benchmark (ASB) provides prescriptive best practices and recommendations to help improve the security of workloads, data, and services on Azure. |
| [Azure Governance Visualizer](https://aka.ms/alz/azgovviz) | The Azure Governance Visualizer is a PowerShell script that iterates through Azure tenant's management group hierarchy down to the subscription level. It captures data from the most relevant Azure governance capabilities - such as Azure Policy, and Azure role-based access control (Azure RBAC). From the collected data, the visualizer shows your hierarchy map, creates a tenant summary, and builds granular scope insights about your management groups and subscriptions. |
| [Azure Governance Visualizer accelerator](https://aka.ms/alz/azgovviz/accelerator) | The Azure Governance Visualizer accelerator speeds up the adoption and deployment of the Azure Governance Visualizer script into your environment. |
| [Microsoft Product Placemat for CMMC L3](https://aka.ms/cmmc/productplacemat) | The Microsoft Product Placemat for CMMC Level 3 (Preview) is an interactive view representing how Microsoft cloud products and services satisfy requirements for cybersecurity maturity model certification practices. |
| [PSRule for Azure](https://aka.ms/ps-rule-azure) | PSRule for Azure is a set of tests and documentation to help you configure Azure solutions. These tests allow you to check your infrastructure as code (IaC) before or after deployment to Azure. PSRule for Azure includes tests that check how IaC is written and how Azure resources are configured. |
| [AzAdvertizer](https://www.azadvertizer.net) | Use AzAdvertizer to get Azure governance updates. For example, you can find insights about policy definitions, initiatives, aliases, security, and regulatory compliance controls in Azure Policy or Azure RBAC role definitions. You can also get insight into resource provider operations, Microsoft Entra role definitions and role actions, and first-party API permissions.

## Migrate

| Resource | Description |
|----------|-------------|
| [Datacenter migration discovery checklist](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/migrate/datacenter-migration-discovery-checklist.docx) | Use this checklist to identify workloads, servers, and other assets in your datacenter. Apply this information to help plan your migration.
| [Migration templates](https://aka.ms/adopt/plan/generator) | The Azure DevOps generator includes several templates that you can use to help streamline your projects. Templates include [Azure Virtual Desktop](https://azuredevopsdemogenerator.azurewebsites.net/?name=wvdmigration), [server migration](https://azuredevopsdemogenerator.azurewebsites.net/?name=servermigration), [SQL migration](https://azuredevopsdemogenerator.azurewebsites.net/?name=sqlmigration), and [Azure Kubernetes Service (AKS) deployments](https://azuredevopsdemogenerator.azurewebsites.net/?name=cafaks).

## Innovate

| Resource | Description |
|----------|-------------|
| [Knowledge mining](https://aka.ms/adopt/plan/generator) | The knowledge mining Azure DevOps project simplifies the process of accessing the latent insights in structured and unstructured data.
| [Modern data warehouse](https://aka.ms/adopt/plan/generator) | Build your modern data warehouse by using this Azure DevOps project with links to assets, code, and learning material to help simplify your deployment. |
| [Retail recommender](https://aka.ms/adopt/plan/generator) | Get end-to-end guidance to enable personalized customer experiences for retail scenarios by using Azure Synapse Analytics, Azure Machine Learning services, and other Azure big data services. For more information, see [Retail recommender solution accelerator](https://github.com/microsoft/Azure-Synapse-Retail-Recommender-Solution-Accelerator). |
| [Modern IoT Azure](https://aka.ms/adopt/plan/generator) | Transform existing businesses and provide new businesses with growth opportunities by using connected sensors, devices, and intelligent operations. Use the [Azure IoT platform](https://azure.microsoft.com/overview/iot/?WT.mc_id=devops_userstory_service_iot-inproduct-devopsportal) to find the work items that you need to plan and implement your IoT solution. |
| [Many models solution accelerator](https://github.com/microsoft/solution-accelerator-many-models) | In the real world, many problems are too complex to solve with a single machine learning model. You might predict sales for individual stores, build a predictive maintenance model for hundreds of oil wells, or tailor the customer experience to individual users. Build a model for each instance to improve results across machine learning problems. |
| [Demand forecasting solution accelerator](https://github.com/microsoft/Azure-Synapse-Solution-Accelerator-Financial-Analytics-Customer-Revenue-Growth-Factor) | Get resources to build a solution that identifies the top factors for revenue growth from an e-commerce platform. This approach uses Azure Synapse Analytics and Machine Learning.|

## Manage

| Resource | Description |
|----------|-------------|
| [Microsoft Azure Well-Architected Review assessment](/assessments/azure-architecture-review/) | Define workload-specific architectures and options across your operations. |
| [Best practices source code](https://github.com/microsoft/CloudAdoptionFramework/tree/main/manage/Automation-Best-Practices) | Accelerate the adoption of best practices for Azure server management services. Quickly enable operations management and establish an operations baseline. |
| [Operations management workbook](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/manage/opsmanagementworkbook.xlsx) | Document decisions about operations management in the cloud. Have conversations with the business to ensure alignment regarding service-level agreements (SLAs), investment in resiliency, and budget allocation related to operations. |

## Organize

| Resource | Description |
|----------|-------------|
| [Cross-team RACI diagram](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/organize/raci-template.xlsx) | Download and personalize the responsible, accountable, consulted, and informed (RACI) spreadsheet template to track your decisions regarding organizational structure over time. |

## Secure

| Resource | Description |
|----------|-------------|
| [Deploy a STIG-compliant Windows virtual machine (VM)](/azure/azure-government/documentation-government-stig-windows-vm) | Use a portal to deploy a Security Technical Implementation Guides (STIG)-compliant Windows VM (preview) on Azure or Azure Government.
| [Deploy a STIG-compliant Linux VM](/azure/azure-government/documentation-government-stig-linux-vm) | Use a portal to deploy a STIG-compliant Linux VM (preview) on Azure or Azure Government.
