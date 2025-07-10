---
title: Platform automation and DevOps for Oracle Database@Azure
description: Use Infrastructure as Code and Azure Verified Modules to deploy Oracle Database@Azure Exadata reliably and consistently across your Azure environments.
author: terrymandin
ms.author: temandin
ms.reviewer: guherk
ms.date: 07/15/2025
ms.custom: e2e-oracle
---

# Platform automation and DevOps for Oracle Database@Azure

This article helps you deploy Oracle Database@Azure Exadata infrastructure with consistent automation and DevOps practices. You need standardized deployment patterns to reduce errors and accelerate provisioning. The recommendations in this article ensure your Oracle Database@Azure deployments follow Azure best practices for reliability, security, and operational excellence.

Oracle Database@Azure Exadata combines Oracle database services with Azure infrastructure capabilities. This service runs on Oracle Cloud Infrastructure (OCI) hardware colocated in Azure datacenters. Oracle Database@Azure provides enterprise-grade database performance with Azure's native integration and management tools.

## Deploy with infrastructure as code

Infrastructure as Code provides consistent deployment patterns across Azure environments. IaC tools reduce manual errors and accelerate Oracle Database@Azure provisioning. You must Choose the appropriate Terraform provider for your deployment scenario. 

Multiple Terraform providers support Oracle Database@Azure Exadata infrastructure deployment. Each provider offers different capabilities and API coverage. Review the provider comparison table to select the best option for your infrastructure requirements.

| Provider | Description |
| - | - |
| [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) | The AzureRM provider manages resources in Microsoft Azure, and supports creation, updating, and deletion of Azure services through Terraform configurations. |
| [azapi](https://registry.terraform.io/providers/Azure/azapi/latest/docs) | The AzAPI provider offers a thin layer on top of Azure ARM REST APIs and supports management of any Azure resource type through any API version. Use this provider independently or with the AzureRM provider to access the latest Azure functionalities that include previews. |
| [azuread](https://registry.terraform.io/providers/hashicorp/azuread/latest) | The AzureAD provider manages users, groups, service principals, and applications in Azure Active Directory through the Microsoft Graph API. |
| [oci](https://registry.terraform.io/providers/oracle/oci/latest) | The Oracle Cloud Infrastructure (OCI) Terraform provider manages Oracle Cloud Infrastructure (OCI) resources through Terraform. This provider supports various OCI services and works with Terraform Cloud and OCI Resource Manager for automated deployment and operations. |

## Use Azure Verified Modules

Azure Verified Modules provide standardized deployment templates for Oracle Database@Azure infrastructure. These modules ensure compliance with Azure best practices for reliability and security. You must use Azure Verified Modules to accelerate deployment and maintain consistency across environments. Here's how:

1. **Deploy Oracle Database@Azure infrastructure using the available Azure Verified Modules.** [Azure Verified Modules (AVM)](https://aka.ms/avm) offer pre-built templates for Oracle Database@Azure Exadata infrastructure and clusters. These modules follow Microsoft's [Well-architected Framework (WAF)](https://aka.ms/waf) principles to ensure reliable and secure deployments.

| Azure Verified Module (AVM) | Language | Module Class | Description |
| - | - | - | - |
| [avm-res-oracledatabase-cloudexadatainfrastructure](https://registry.terraform.io/modules/Azure/avm-res-oracledatabase-cloudexadatainfrastructure/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys Oracle Database@Azure Exadata Infrastructure |
| [avm-res-oracledatabase-cloudvmcluster](https://registry.terraform.io/modules/Azure/avm-res-oracledatabase-cloudvmcluster/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys Oracle Database@Azure Exadata VM Cluster |
| [avm-res-network-virtualnetwork](https://registry.terraform.io/modules/Azure/avm-res-network-virtualnetwork/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys an Azure Virtual Network with subnets |
| [avm-ptn-odaa](https://registry.terraform.io/modules/Azure/avm-ptn-odaa/azurerm/latest) | Terraform | [Pattern](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys a Virtual Network with Oracle delegated subnet, Exadata infrastructure, and an Exadata Virtual Machine cluster |

## Use Terraform templates from Oracle

Complete Oracle Database@Azure Exadata deployments require both Azure and Oracle Cloud Infrastructure (OCI) Terraform. Oracle templates integrate Azure and OCI modules into unified deployments. You must use Oracle templates to streamline the complete provisioning process. Oracle provides pre-built templates that combine Azure and OCI resources for comprehensive Oracle Database@Azure deployments. These templates reduce deployment complexity and ensure proper integration between Azure and OCI components.

| Template | Description |
| - | - |
| [Terraform Template to setup SSO Federation between OCI & Azure](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/tree/main/templates/az-oci-sso-federation) | Configure Identity Federation and single sign-On (SSO) to the OCI cloud |
| [Quickstart OracleDB@Azure (Exadata) with Azure Verified Modules (AzAPI) and OCI LZ Modules](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/tree/main/templates/avm-oci-exadata-quickstart) | Deploy an Oracle Database@Azure Exadata infrastructure and cluster including an Azure Resource Group (Optional), Azure VNet with a delegated subnet, Oracle Exadata Infrastructure, Oracle VM Cluster, Oracle Database Home, Oracle Container Database and Oracle Pluggable Database |

For more information, see [QuickStart Oracle Database@Azure with Terraform or OpenTofu Modules](https://docs.oracle.com/en/learn/dbazure-terraform/index.html). 

## Handle idempotency

Oracle Database@Azure Exadata infrastructure and VM clusters deploy completely using Azure Terraform providers or AVM modules. However, only some properties update using Azure REST APIs and Azure Terraform providers or modules. When an interface isn't available, OCI Terraform is required to update the resource. For example, scaling operations are only available through OCI Terraform. Resource updates using OCI Terraform lead to Terraform idempotency issues when Azure Terraform runs again.

Idempotency issues occur when Azure and OCI Terraform providers attempt to manage the same resource properties. You must configure the Terraform `ignore_changes` feature in your Azure Terraform code to avoid configuration drift. Here's how:

1. **Configure `ignore_changes` for properties managed by OCI Terraform.** The Terraform [ignore_changes](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#ignore_changes) feature prevents Azure Terraform from attempting updates on properties managed by OCI. This configuration prevents resource conflicts and ensures deployment stability.

2. **Identify properties that require OCI management.** Review the Oracle Database@Azure documentation to determine which properties are only updatable through OCI Terraform. Common examples include scaling operations, database configurations, and performance tuning parameters.

Failure to use `ignore_changes` on Azure Terraform causes Terraform to attempt updates on non-updatable properties, which leads to unintended consequences such as:

- Terraform attempts to modify existing resources
- Destruction and recreation of infrastructure or clusters

## Use the Oracle Cloud Infrastructure (OCI) Terraform provider to configure Exadata

Oracle Cloud Infrastructure (OCI) Terraform is required to configure Exadata after the infrastructure is deployed. To configure the Oracle components, use the [Oracle Cloud Infrastructure (OCI) Terraform provider](https://registry.terraform.io/providers/oracle/oci/latest). Example Oracle components:

- Oracle Database Autonomous Recovery Service
- Oracle Cloud Infrastructure Network Security Groups
- Oracle Cloud Infrastructure Domain Name System (DNS) Zones
- Container Database (CDB) 
- Pluggable Database (PDB) 
- Data Guard

## Azure resources

| Category | Tool | Description |
|----------|------|-------------|
| Infrastructure as Code | [Azure Verified Modules](https://aka.ms/avm) | Pre-built Terraform templates for Oracle Database@Azure Exadata infrastructure that follow Azure best practices |
| Infrastructure as Code | [AzureRM Terraform Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest) | Native Azure resource management for Oracle Database@Azure deployments |
| Infrastructure as Code | [AzAPI Terraform Provider](https://registry.terraform.io/providers/Azure/azapi/latest/docs) | Azure ARM REST API integration for latest Oracle Database@Azure features |
| Configuration Management | [Oracle Cloud Infrastructure (OCI) Terraform Provider](https://registry.terraform.io/providers/oracle/oci/latest) | Configuration and management of Oracle components within Azure deployments |

## Next steps

> [!div class="nextstepaction"]
> [Capacity planning for Oracle Database@Azure](/azure/cloud-adoption-framework/scenarios/oracle-on-azure/oracle-capacity-planning-oracle-database-azure)
