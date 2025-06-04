---
title: Platform automation and DevOps for Oracle Database@Azure
description: Learn how to deploy Oracle Database@Azure using Platform automation and DevOps.
author: terrymandin
ms.author: temandin
ms.reviewer: guherk
ms.date: 04/11/2025
ms.custom: e2e-oracle
---
# Platform automation and DevOps for Oracle Database@Azure

This article builds on the guidance in [Platform automation and DevOps](/azure/cloud-adoption-framework/ready/landing-zone/design-area/platform-automation-devops). Use this information to review design considerations and recommendations for platform automation and devops that are specific to [Oracle Database@Azure](/azure/oracle/oracle-db/database-overview) deployments. Platform automation and DevOps requirements for Oracle Database@Azure vary depending on its implementation in Azure. This article provides information based on the most typical scenarios.

Oracle Database@Azure is an Oracle database service that runs on Oracle Cloud Infrastructure (OCI) and is colocated in Azure datacenters at Microsoft. This service applies the strengths of both Oracle and Azure to provide a robust, scalable, and high-performance database solution.

This documentation provides design considerations and recommendations for deploying Oracle Database@Azure.


## Deploy with Infrastructure as Code (IaC)

Terraform modules and providers are available to deploy Oracle Database@Azure Exadata infrastructure and to configure Federated identity with Oracle Cloud Infrastructure.

1. **Deploy Oracle Database@Azure using Infrastructure as Code (IaC).** There are multiple Terraform providers and options for deploying Oracle Database@Azure Exadata. In some cases, multiple providers provide the same Infrastructure as Code (IaC) capability. For example, an Oracle Database@Azure Exadata cluster can be deployed using [azapi](/azure/templates/oracle.database/cloudvmclusters?pivots=deployment-language-terraform) or [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/oracle_exadata_infrastructure). For a more detailed description of the provider options see [Announcing expanded Terraform support for Oracle Database@Azure](https://blogs.oracle.com/cloud-infrastructure/post/azurerm-avm-oracle-database-at-azure). Oracle Database@Azure Exadata related Terraform providers:

    | Provider | Description
    | - | - |
    | [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) | The AzureRM provider is used to manage resources in Microsoft Azure, enabling the creation, updating, and deletion of Azure services using Terraform configurations.
    | [azapi](https://registry.terraform.io/providers/Azure/azapi/latest/docs) | The AzAPI provider is a thin layer on top of the Azure ARM REST APIs, enabling management of any Azure resource type using any API version. It can be used independently or alongside the AzureRM provider to utilize the latest Azure functionalities including previews.
    | [azuread](https://registry.terraform.io/providers/hashicorp/azuread/latest) | The AzureAD provider is used to manage users, groups, service principals, and applications in Azure Active Directory using the Microsoft Graph API. 
    | [oci](https://registry.terraform.io/providers/oracle/oci/latest) | The Oracle Cloud Infrastructure (OCI) Terraform provider allows users to manage Oracle Cloud Infrastructure (OCI) resources using Terraform. It supports various OCI services and can be used with Terraform Cloud and OCI Resource Manager for automated deployment and operations.



## Use Azure Verified Modules

[Azure Verified Modules (AVM)](https://aka.ms/avm) are available for Oracle Database@Azure Exadata infrastructure and cluster. AVM modules are designed to streamline the deployment and management of Azure resources, ensuring compliance with Microsoft's [Well-architected Framework (WAF)](https://aka.ms/waf), which emphasize reliability and security by default. Oracle Database@Azure Exadata Azure Verified Modules.

1. **Deploy Azure Infrastructure using Azure Verified Modules.** To ensure that Oracle Exadata Database@Azure infrastructure deployments adhere to Azure Well Architected Framework best practices for reliability and security, use [Azure Verified Modules (AVMs)](https://aka.ms/avm) for deployment.  Oracle Database@Azure Exadata Azure Verified Modules: 

    | Azure Verified Module (AVM) | Language | Module Class | Description
    | - | - | - | - |
    | [avm-res-oracledatabase-cloudexadatainfrastructure](https://registry.terraform.io/modules/Azure/avm-res-oracledatabase-cloudexadatainfrastructure/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys Oracle Exadata Database@Azure Infrastructure |
    | [avm-res-oracledatabase-cloudvmcluster](https://registry.terraform.io/modules/Azure/avm-res-oracledatabase-cloudvmcluster/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys Oracle Exadata Database@Azure VM Cluster |
    | [avm-res-network-virtualnetwork](https://registry.terraform.io/modules/Azure/avm-res-network-virtualnetwork/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys an Azure Virtual Network with subnets. |
    | [avm-ptn-odaa](https://registry.terraform.io/modules/Azure/avm-ptn-odaa/azurerm/latest) | Terraform | [Pattern](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys a Virtual Network with Oracle delegated subnet, Exadata infrastructure, and an Exadata Virtual Machine cluster |



## Use Oracle Terraform Templates

To fully deploy Oracle Exadata Database@Azure, both Azure and Oracle Cloud Infrastructure (OCI) Terraform is required. 

1. **Use Oracle templates**. Oracle [templates](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/tree/main/templates) integrate modules from Azure and OCI into a unified deployment, streamlining the provisioning process. The most commonly used templates:

    | Template | Description |
    | - | - |
    | [Terraform Template to setup SSO Federation between OCI & Azure](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/tree/main/templates/az-oci-sso-federation) | Configure Identity Federation and single sign-On (SSO) to the OCI cloud |
    | [Quickstart OracleDB@Azure (Exadata) with Azure Verified Modules (AzAPI) and OCI LZ Modules](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/tree/main/templates/avm-oci-exadata-quickstart) | Deploy an Oracle Database@Azure Exadata infrastructure and cluster including an Azure Resource Group (Optional), Azure VNet with a delegated subnet for OracleDB@Azure (AVM), Oracle Exadata Infrastructure (AVM), Oracle VM Cluster (AVM), Oracle Database Home (OCI), Oracle Container Database (OCI) and Oracle Pluggable Database (OCI) |

    For more information, see: [QuickStart Oracle Database@Azure with Terraform or OpenTofu Modules](https://docs.oracle.com/en/learn/dbazure-terraform/index.html). 

## Handle Idempotency

Oracle Exadata Database@Azure infrastructure and VM clusters can be fully deployed using Azure Terraform providers or AVM modules. However, only some properties can be updated using Azure REST APIs and Azure Terraform providers or modules. When an interface isn't available, OCI Terraform may be required to update the resource. For example, scaling operations are only available through OCI Terraform. Updating resources using OCI Terraform may lead to Terraform idempotency issues when Azure Terraform is run again

1. **Use Terraform ```ignore_changes```.** To avoid idempotency issues, use the Terraform [ignore_changes](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#ignore_changes) feature in your Azure Terraform code.
 
  > [!NOTE]
  > Failing to use ```ignore_changes``` on Azure Terraform can cause Terraform to attempt updates on non updatable properties, which can lead to unintended consequences such as:
  > - Terraform trying to modify existing resources
  > - Destruction and recreation of infrastructure or clusters
  > 
  > To prevent these disruptions, configure ```ignore_changes``` for any properties that aren't manageable through Azure.

## Use the Oracle Cloud Infrastructure (OCI) Terraform provider to configure Exadata

Other Terraform is required to configure Exadata after the infrastructure is deployed.

1. **Configure Exadata with the Oracle Cloud Infrastructure (OCI) Terraform provider.** To configure the Oracle components, use the [Oracle Cloud Infrastructure (OCI) Terraform provider](https://registry.terraform.io/providers/oracle/oci/latest). Example Oracle components:

    - Oracle Database Autonomous Recovery Service
    - Oracle Cloud Infrastructure Network Security Groups
    - Oracle Cloud Infrastructure Domain Name System (DNS) Zones
    - Container Database (CDB) 
    - Pluggable Database (PDB) 
    - Data Guard

## Next steps

> [!div class="nextstepaction"]
> [Capacity planning for Oracle Database@Azure](./Capacity planning for Oracle Database@Azure)
