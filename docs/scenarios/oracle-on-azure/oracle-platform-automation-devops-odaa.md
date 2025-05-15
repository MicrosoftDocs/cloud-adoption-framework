---
title: Platform automation and DevOps for Oracle Database@Azure
description: Learn how to deploy Oracle Database@Azure using Platform automation and DevOps.
author: terrymandin
ms.author: temandin
ms.reviewer: guherk
ms.date: 04/11/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---
# Platform automation and DevOps for Oracle Database@Azure

This article builds on the guidance in [Platform automation and DevOps](/azure/cloud-adoption-framework/ready/landing-zone/design-area/platform-automation-devops). Use this information to review design considerations and recommendations for platform automation and devops that are specific to [Oracle Database@Azure](/azure/oracle/oracle-db/database-overview) deployments. Platform automation and DevOps requirements for Oracle Database@Azure vary depending on its implementation in Azure. This article provides information based on the most typical scenarios.

Oracle Database@Azure is an Oracle database service that runs on Oracle Cloud Infrastructure (OCI) and is colocated in Azure datacenters at Microsoft. This service applies the strengths of both Oracle and Azure to provide a robust, scalable, and high-performance database solution.

This documentation provides design considerations and recommendations for deploying Oracle Database@Azure.

## Considerations

- Terraform modules and providers are available to deploy Oracle Database@Azure Exadata infrastructure and to configure Federated identity with Oracle Cloud Infrastructure.

- There are multiple Terraform providers and options for deploying Oracle Database@Azure Exadata. In some cases, multiple providers provide the same Infrastructure as Code (IaC) capability. For example, an Oracle Database@Azure Exadata cluster can be deployed using [azapi](/azure/templates/oracle.database/cloudvmclusters?pivots=deployment-language-terraform) or [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/oracle_exadata_infrastructure). For a more detailed description of the provider options see [Announcing expanded Terraform support for Oracle Database@Azure](https://blogs.oracle.com/cloud-infrastructure/post/azurerm-avm-oracle-database-at-azure). Oracle Database@Azure related Terraform providers:

    | Provider | Description
    | - | - |
    | [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) | The AzureRM provider is used to manage resources in Microsoft Azure, enabling the creation, updating, and deletion of Azure services using Terraform configurations.
    | [azapi](https://registry.terraform.io/providers/hashicorp/azurerm/latest) | The AzAPI provider is a thin layer on top of the Azure ARM REST APIs, enabling management of any Azure resource type using any API version. It can be used independently or alongside the AzureRM provider to utilize the latest Azure functionalities including previews.
    | [azuread](https://registry.terraform.io/providers/hashicorp/azuread/latest) | The AzureAD provider is used to manage users, groups, service principals, and applications in Azure Active Directory using the Microsoft Graph API. 
    | [oci](https://registry.terraform.io/providers/oracle/oci/latest) | The Oracle Cloud Infrastructure (OCI) Terraform provider allows users to manage Oracle Cloud Infrastructure (OCI) resources using Terraform. It supports various OCI services and can be used with Terraform Cloud and OCI Resource Manager for automated deployment and operations.

- [Azure Verified Modules (AVM)](https://aka.ms/avm) are available for Oracle Database@Azure Exadata infrastructure and cluster. AVM modules are designed to streamline the deployment and management of Azure resources, ensuring compliance with Microsoft's well-architected framework (WAF), which emphasizes reliability and security by default. Available Azure Verified Modules:

    | Azure Verified Module (AVM) | Language | Module Class | Description
    | - | - | - | - |
    | [avm-res-oracledatabase-cloudexadatainfrastructure](https://registry.terraform.io/modules/Azure/avm-res-oracledatabase-cloudexadatainfrastructure/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys Oracle Exadata Database@Azure Infrastructure |
    | [avm-res-oracledatabase-cloudvmcluster](https://registry.terraform.io/modules/Azure/avm-res-oracledatabase-cloudvmcluster/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys Oracle Exadata Database@Azure VM Cluster |
    | [avm-res-network-virtualnetwork](https://registry.terraform.io/modules/Azure/avm-res-network-virtualnetwork/azurerm/latest) | Terraform | [Resource](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys an Azure Virtual Network with subnets. |
    | [avm-ptn-odaa](https://registry.terraform.io/modules/Azure/avm-ptn-odaa/azurerm/latest) | Terraform | [Pattern](https://azure.github.io/Azure-Verified-Modules/specs/shared/module-classifications/) | Deploys a Virtual Network with Oracle delegated subnet, Exadata infrastructure, and an Exadata VM cluster |

- To fully deploy Oracle Exadata Database@Azure or to federate identity, Azure and OCI Terraform code is required. Oracle Terraform [templates](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/tree/main/templates) are available to facilitate deployment. For more information, see: [QuickStart Oracle Database@Azure with Terraform or OpenTofu Modules](https://docs.oracle.com/en/learn/dbazure-terraform/index.html). 

- You can fully deploy Oracle Exadata Database@Azure infrastructure and VM clusters using Azure Terraform providers or AVM modules. However, only some properties can be updated using Azure REST APIs and Azure Terraform providers or modules. When an interface isn't available, OCI Terraform may be required to update the resource. For example, scaling operations are only available through OCI Terraform. Updating resources using OCI Terraform may lead to Terraform idempotency issues when Azure Terraform is run again.

## Design recommendations

- Deploy Oracle Database@Azure federation and infrastructure using Terraform Infrastructure as Code (IaC).

- To configure Identity Federation and single sign-On (SSO) to the OCI cloud use the [Terraform Template to setup SSO Federation between OCI & Azure](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/tree/main/templates/az-oci-sso-federation) Oracle Terraform template. 

- To ensure that Oracle Exadata Database@Azure infrastructure deployments adhere to Azure Well Architected Framework best practices for reliability and security, use [Azure Verified Modules (AVMs)](https://aka.ms/avm) for deployment. Oracle created a Terraform template to deploy the Exadata infrastructure, Exadata cluster, Azure Virtual Network with delegated subnet, and the database home and CDB/PDB. You can find the template here: [Quickstart OracleDB@Azure (Exadata) with Azure Verified Modules (AzAPI) and OCI LZ Modules](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/tree/main/templates/avm-oci-exadata-quickstart).


- Reach out to Oracle for assistance in deploying the following services using infrastructure as code:
  - Oracle Database Autonomous Recovery Service
  - Oracle Cloud Infrastructure Network Security Groups
  - Oracle Cloud Infrastructure Domain Name System (DNS) Zones
  - Container Database (CDB) 
  - Pluggable Database (PDB) 
  - Data Guard

- Idempotency issues can occur when using Oracle Terraform to update Oracle Exadata Database@Azure infrastructure properties that aren't updatable in Azure. To avoid idempotency issues use the Terraform [ignore_changes](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#ignore_changes) feature in your code.
 
> [!NOTE]
> Failing to use ```ignore_changes``` on Azure Terraform can cause Terraform to attempt updates on non updatable properties, which can lead to unintended consequences such as:
> - Terraform trying to modify existing resources
> - Destruction and recreation of infrastructure or clusters
> 
> To prevent these disruptions, configure ```ignore_changes``` for any properties that aren't manageable through Azure.

## Next step

> [!div class="nextstepaction"]
> [Capacity planning for Oracle Database@Azure](./Capacity planning for Oracle Database@Azure)
