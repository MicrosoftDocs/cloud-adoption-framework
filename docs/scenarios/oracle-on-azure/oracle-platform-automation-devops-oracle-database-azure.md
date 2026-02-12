---
title: Platform Automation and DevOps for Oracle Exadata Database@Azure
description: Use infrastructure as code and Azure Verified Modules to deploy Oracle Exadata Database@Azure reliably and consistently across your Azure environments.
author: terrymandin
ms.author: temandin
ms.reviewer: guherk
ms.date: 07/15/2025
ms.topic: concept-article
ms.custom: e2e-oracle
---

# Platform automation and DevOps for Oracle Exadata Database@Azure

This article describes how to deploy Oracle Exadata Database@Azure infrastructure that uses consistent automation and DevOps practices. You need standardized deployment patterns to reduce errors and accelerate provisioning. The recommendations in this article help ensure that your Oracle Database@Azure deployments follow Azure best practices for reliability, security, and operational excellence.

Oracle Exadata Database@Azure combines Oracle database services with Azure infrastructure capabilities. This service runs on Oracle Cloud Infrastructure (OCI) hardware colocated in Azure datacenters. Oracle Database@Azure provides enterprise-grade database performance with Azure's native integration and management tools.

## Deploy with infrastructure as code

Infrastructure as code (IaC) provides consistent deployment patterns across Azure environments. IaC tools reduce manual errors and accelerate Oracle Database@Azure provisioning. You must choose the appropriate Terraform provider for your deployment scenario.

Multiple Terraform providers support Oracle Exadata Database@Azure infrastructure deployments. Each provider offers different capabilities and API coverage. Review the provider comparison table below to select the best option for your requirements.

| Provider | Description |
| --- | --- |
| [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) | The AzureRM provider manages resources in Microsoft Azure and supports creation, updating, and deletion of Azure services through Terraform configurations. |
| [azapi](https://registry.terraform.io/providers/Azure/azapi/latest/docs) | The AzAPI provider offers a thin layer on top of Azure Resource Manager REST APIs and supports management of any Azure resource type through any API version. To access the latest Azure functionalities that include previews, use this provider independently or with the AzureRM provider. |
| [azuread](https://registry.terraform.io/providers/hashicorp/azuread/latest) | The AzureAD provider manages users, groups, service principals, and applications in Microsoft Entra ID through the Microsoft Graph API. |
| [oci](https://registry.terraform.io/providers/oracle/oci/latest) | The OCI Terraform provider manages OCI resources through Terraform. This provider supports various OCI services and works with Terraform Cloud and OCI Resource Manager to automate deployment and operations. |

### Azure Arc integration with infrastructure as code

Azure Arc onboarding and management can be automated as part of your Oracle Exadata Database@Azure infrastructure deployment. Integration with Azure Arc enables unified governance and security monitoring while maintaining existing OCI database management capabilities.

For detailed network connectivity requirements and configuration guidance, see [Azure Arc connectivity design for Oracle Database@Azure](azure-arc-connectivity-design.md).

## Use Azure Verified Modules

Azure Verified Modules provide standardized deployment templates for Oracle Database@Azure infrastructure. These modules help ensure compliance with Azure best practices for reliability and security. Deploy Oracle Database@Azure infrastructure using the available Azure Verified Modules. [Azure Verified Modules](https://aka.ms/avm) provide prebuilt templates for Oracle Exadata Database@Azure infrastructure and clusters. These modules follow the [Azure Well-Architected Framework](/azure/well-architected/) principles to ensure reliable and secure deployments.

| Azure Verified Modules | Language | Module classification | Description |
| --- | --- | --- | --- |
| [avm-res-oracledatabase-cloudexadatainfrastructure](https://registry.terraform.io/modules/Azure/avm-res-oracledatabase-cloudexadatainfrastructure/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys Oracle Exadata Database@Azure infrastructure. |
| [avm-res-oracledatabase-cloudvmcluster](https://registry.terraform.io/modules/Azure/avm-res-oracledatabase-cloudvmcluster/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys Oracle Exadata Database@Azure virtual machine (VM) clusters. |
| [avm-res-network-virtualnetwork](https://registry.terraform.io/modules/Azure/avm-res-network-virtualnetwork/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys an Azure Virtual Network instance that has subnets. |
| [avm-res-operationalinsights-workspace](https://registry.terraform.io/modules/Azure/avm-res-operationalinsights-workspace/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys Log Analytics workspace for Azure Arc monitoring integration and diagnostics settings. |
| [avm-res-authorization-policyassignment](https://registry.terraform.io/modules/Azure/avm-res-authorization-policyassignment/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys Azure Policy assignments for Arc-enabled server governance and compliance management. |
| [avm-ptn-odaa](https://registry.terraform.io/modules/Azure/avm-ptn-odaa/azurerm/latest) | Terraform | [Pattern](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys a Virtual Network instance that has an Oracle delegated subnet, Exadata infrastructure, and an Exadata VM cluster. |

## Use Terraform templates from Oracle

Complete Oracle Exadata Database@Azure deployments require both Azure and OCI Terraform. Oracle templates integrate Azure and OCI modules into unified deployments. You must use Oracle templates to streamline the complete provisioning process. Oracle provides prebuilt templates that combine Azure and OCI resources for comprehensive Oracle Database@Azure deployments. These templates reduce deployment complexity and ensure proper integration between Azure and OCI components.

| Template | Description |
| --- | --- |
| [Terraform template to set up single sign-on (SSO) federation between OCI and Azure](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/tree/main/templates/az-oci-sso-federation) | Configure identity federation and SSO to the OCI cloud. |
| [Quickstart Oracle Exadata Database@Azure with Azure Verified Modules (AzAPI) and OCI landing zone modules](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/tree/main/templates/avm-oci-exadata-quickstart) | Deploy an Oracle Exadata Database@Azure infrastructure and cluster that include the following resources: <br><br> - An optional Azure resource group <br> - A Virtual Network instance that has a delegated subnet <br> - Oracle Exadata Infrastructure <br> - Oracle VM Cluster <br> - Oracle Database Home <br> - Oracle Container Database (CDB) <br> - Oracle Pluggable Database (PDB) |

For more information, see [Quickstart Oracle Database@Azure with Terraform or OpenTofu modules](https://docs.oracle.com/en/learn/dbazure-terraform/index.html).

## Handle idempotency

Oracle Exadata Database@Azure infrastructure and VM clusters deploy completely by using Azure Terraform providers or Azure Verified Modules. However, only some properties update by using Azure REST APIs and Azure Terraform providers or modules. When an interface isn't available, OCI Terraform is required to update the resource. For example, scaling operations are only available through OCI Terraform. Resource updates via OCI Terraform lead to Terraform idempotency problems when Azure Terraform runs again.

Idempotency problems occur when Azure and OCI Terraform providers attempt to manage the same resource properties. Configure the Terraform `ignore_changes` feature in your Azure Terraform code to avoid configuration drift. Take the following steps:

1. **Configure `ignore_changes` for properties that OCI Terraform manages.** The Terraform [ignore_changes](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#ignore_changes) feature prevents Azure Terraform from attempting updates on properties that OCI manages. This configuration prevents resource conflicts and ensures deployment stability.

1. **Identify properties that require OCI management.** Review the Oracle Database@Azure documentation to determine which properties you can update only through OCI Terraform. Common examples include scaling operations, database configurations, and performance tuning parameters.

Failure to use `ignore_changes` on Azure Terraform causes Terraform to attempt updates on properties that can't be updated. These attempts can cause unintended consequences:

- Terraform attempts to modify existing resources.
- Destruction and re-creation of infrastructure or clusters.

### Azure Arc considerations

Azure Arc integration introduces extra considerations for Oracle Exadata Database@Azure deployments. Arc-enabled server resources have their own life cycle and state management that can interact with Terraform deployments.

- **Log Analytics workspace integration:** Arc-enabled servers automatically configure data collection rules and workspace connections. Use separate Terraform configurations for workspace management versus Arc resource management to prevent cross-dependencies and state conflicts.

## Use the OCI Terraform provider to configure Exadata

OCI Terraform is required to configure Exadata after the infrastructure is deployed. To configure the Oracle components, use the [OCI Terraform provider](https://registry.terraform.io/providers/oracle/oci/latest). The following list provides some examples of Oracle components:

- Oracle Database Autonomous Recovery Service
- Oracle Cloud Infrastructure Network Security Groups
- Oracle Cloud Infrastructure Domain Name System (DNS) Zones
- Oracle CDB
- Oracle PDB
- Oracle Data Guard

## Azure resources

| Category | Tool | Description |
|----------|------|-------------|
| IaC | [Azure Verified Modules](https://aka.ms/avm) | Prebuilt Terraform templates for Oracle Exadata Database@Azure infrastructure that follow Azure best practices |
| IaC | [AzureRM Terraform provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest) | Native Azure resource management for Oracle Database@Azure deployments |
| IaC | [AzAPI Terraform provider](https://registry.terraform.io/providers/Azure/azapi/latest/docs) | Resource Manager REST API integration for the latest Oracle Database@Azure features |
| Configuration management | [OCI Terraform provider](https://registry.terraform.io/providers/oracle/oci/latest) | Configuration and management of Oracle components within Azure deployments |
| Diagnostic Logs for Oracle Exadata Database Service @ Azure| [Oracle Exadata Database Service@ Azure logs with Azure Monitor](/azure/oracle/oracle-db/oracle-exadata-database-dedicated-infrastructure-logs) | Oracle Exadata Database on dedicated infrastructure logs on Azure for Enhanced Observability |
| Hybrid management | [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) | Extends Azure management capabilities to Oracle Database@Azure infrastructure |
| Security monitoring | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Comprehensive security monitoring, vulnerability assessment, and threat protection for Arc-enabled Oracle Database@Azure infrastructure with optional integration to Microsoft Sentinel security information and event management (SIEM) |
| Security automation | [Defender workflow automation](/azure/defender-for-cloud/workflow-automations) | Automated security response and remediation workflows for threat detection and incident response on Oracle infrastructure |
| Vulnerability management | [Defender vulnerability assessment](/azure/defender-for-cloud/deploy-vulnerability-assessment-defender-vulnerability-management) | Automated vulnerability scanning and security recommendations for Arc-enabled Oracle Database@Azure VM cluster nodes |

## Related resource

- [Capacity planning for Oracle Database@Azure](oracle-capacity-planning-oracle-database-azure-autonomous-database.md)