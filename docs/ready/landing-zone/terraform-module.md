---
title: Azure landing zones Terraform module
description: Learn how to use the official Terraform module to deploy Azure landing zones.
author: krowlandson
ms.author: martinek
ms.date: 04/13/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, engagement-fy23, UpdateFrequency.5, devx-track-terraform
---

# Azure landing zones Terraform module

The [Azure landing zones Terraform module][caf-enterprise-scale] provides a rapid implementation of the platform resources that you need to manage [Azure landing zones][msdocs_alz_architecture] at scale by using Terraform.

> [!NOTE]
> This article describes one of two ways to implement landing zones on Azure by using Terraform. For guidance on choosing the right approach, see [this article](deploy-landing-zones-with-terraform.md).

## Prerequisites

If you're new to Terraform and you want information about installing and using it, see the [Install Terraform][tf_install] tutorial on HashiCorp Learn.

For information on how to set up the Terraform provider and authenticate with Azure, see the [AzureRM provider guides][azurerm_auth] on the Terraform website. To learn how to set up the provider for deploying across multiple subscriptions, see the [Provider Configuration][wiki_provider_configuration] wiki page.

## Importance of using standard modules

Reuse of components is a fundamental principle of infrastructure as code. Modules are instrumental in defining standards and consistency across resource deployment within and across environments.

The Azure landing zones Terraform module is published to the official [Terraform Registry][tf_reg_azure] and is verified by HashiCorp.

Deploying the module from the Terraform Registry provides:

- An accelerated delivery of Azure landing zones in your environment.
- A tested upgrade path to the latest version of the module, along with strict version control.

## Benefits of using the module

Benefits of using the Azure landing zones Terraform module include:

- A managed and extensible core resource hierarchy for subscription organization through management groups.
- Scalable security governance and compliance through Azure identity and access management (IAM) controls, with an extensive library of custom definitions ready to assign.
- Enforcement of policy across subscriptions through management group inheritance.
- Managed resources for management and connectivity landing zones. These resources provide:
  - Assured policy compliance through tight integration of resources managed by the module and corresponding policy assignments.
  - Integration between resources to reduce management overhead and provide an improved user experience, like automatic creation of virtual network links for Azure Private DNS.

> [!TIP]
> The template library is updated programmatically from the [Azure/Enterprise-Scale][gh-es] GitHub repository. To stay up to date with the latest archetype configuration, policies, and roles, make sure you're using the latest version of the module.

## Resource deployment

You can configure the module to deploy sets of resources that align with the following critical design areas in Azure landing zones. Customize these resources to meet the requirements of your organization.

| Resource category | Critical design area |
| --- | --- |
| Core resources | [Resource organization][alz_resourceorg]</br>[Security][alz_security]</br> [Governance][alz_governance] |
| Management resources | [Management and monitoring][alz_management] |
| Connectivity resources | [Network topology and connectivity][alz_connectivity] |
| Identity resources | [Identity and access management][alz_identity] |

Packaging these capabilities into a single Terraform module makes it easier to build and enforce consistency across the Azure platform when you're operating at scale.

These resources align with the [Azure landing zones conceptual architecture](index.md#azure-landing-zone-conceptual-architecture):

:::image type="content" source="../enterprise-scale/media/ns-arch-cust-expanded.svg" alt-text="Diagram of the Azure landing zone conceptual architecture." lightbox="../enterprise-scale/media/ns-arch-cust-expanded.svg":::

You can deploy these resources, by capability, across multiple subscriptions by using the [Provider Configuration][wiki_provider_configuration] on the module block.

The following sections outline the resource types and configuration options.

### Core resources

The core capability of this module deploys the foundations of the [conceptual architecture for Azure landing zones][msdocs_alz_architecture], with a focus on the central [resource organization][alz_resourceorg].

:::image type="content" source="media/terraform-caf-enterprise-scale-overview.png" alt-text="Diagram of the Azure landing zone conceptual architecture, focusing on the core resource hierarchy." lightbox="media/terraform-caf-enterprise-scale-overview.png":::

When you enable deployment of core resources (*enabled by default*), the module deploys and manages the following resource types:

| Resource | Azure resource type | Terraform resource type |
| --- | --- | --- |
| Management groups | [`Microsoft.Management/managementGroups`][arm_management_group] | [`azurerm_management_group`][azurerm_management_group] |
| Management group subscriptions | [`Microsoft.Management/managementGroups/subscriptions`][arm_management_group_subscriptions] | [`azurerm_management_group`][azurerm_management_group] |
| Policy assignments | [`Microsoft.Authorization/policyAssignments`][arm_policy_assignment] | [`azurerm_management_group_policy_assignment`][azurerm_management_group_policy_assignment] |
| Policy definitions | [`Microsoft.Authorization/policyDefinitions`][arm_policy_definition] | [`azurerm_policy_definition`][azurerm_policy_definition] |
| Policy set definitions | [`Microsoft.Authorization/policySetDefinitions`][arm_policy_set_definition] | [`azurerm_policy_set_definition`][azurerm_policy_set_definition] |
| Role assignments | [`Microsoft.Authorization/roleAssignments`][arm_role_assignment] | [`azurerm_role_assignment`][azurerm_role_assignment] |
| Role definitions | [`Microsoft.Authorization/roleDefinitions`][arm_role_definition] | [`azurerm_role_definition`][azurerm_role_definition] |

The exact number of resources that the module creates depends on the module configuration. For a [default configuration](#simple-example), you can expect the module to create approximately `180` resources.

> [!TIP]
> None of these resources are deployed at the subscription scope, but Terraform still requires a subscription to establish an authenticated session with Azure. For more information on authenticating with Azure, refer to the [Azure Provider: Authenticating to Azure][azurerm_auth] documentation.

### Management resources

The module provides an option to enable deployment of [management and monitoring][alz_management] resources from the [conceptual architecture for Azure landing zones][msdocs_alz_architecture] into the specified subscription, as described on the [Provider Configuration][wiki_provider_configuration] wiki page. The module also ensures that the specified subscription is placed in the right management group.

:::image type="content" source="media/terraform-caf-enterprise-scale-management.png" alt-text="Diagram of the Azure landing zone conceptual architecture, focusing on the management resources." lightbox="media/terraform-caf-enterprise-scale-management.png":::

When you enable deployment of management resources, the module deploys and manages the following resource types (*depending on configuration*):

| Resource | Azure resource type | Terraform resource type |
| --- | --- | --- |
| Resource groups | [`Microsoft.Resources/resourceGroups`][arm_resource_group] | [`azurerm_resource_group`][azurerm_resource_group] |
| Log Analytics workspace | [`Microsoft.OperationalInsights/workspaces`][arm_log_analytics_workspace] | [`azurerm_log_analytics_workspace`][azurerm_log_analytics_workspace] |
| Log Analytics solutions | [`Microsoft.OperationsManagement/solutions`][arm_log_analytics_solution] | [`azurerm_log_analytics_solution`][azurerm_log_analytics_solution] |
| Automation account | [`Microsoft.Automation/automationAccounts`][arm_automation_account] | [`azurerm_automation_account`][azurerm_automation_account] |
| Log Analytics linked service | [`Microsoft.OperationalInsights/workspaces /linkedServices`][arm_log_analytics_linked_service] | [`azurerm_log_analytics_linked_service`][azurerm_log_analytics_linked_service] |

In addition to deploying the above resources, the module provides native integration into the corresponding policy assignments to ensure full policy compliance.

For more information about how to use this capability, see the [Deploy Management Resources][wiki_deploy_management_resources] wiki page.

### Connectivity resources

The module provides an option to enable deployment of [network topology and connectivity][alz_connectivity] resources from the [conceptual architecture for Azure landing zones][msdocs_alz_architecture] into the current subscription context. It also ensures that the specified subscription is placed in the right management group.

This capability enables deployment of multiple hub networks based on any combination of [traditional Azure networking topology (hub and spoke)](#traditional-azure-networking-topology-hub-and-spoke), and [Virtual WAN network topology (Microsoft-managed)](#virtual-wan-network-topology-microsoft-managed).

The module can also create and link [DDoS Network Protection](#ddos-protection-plan) to Virtual Networks, and manage centralized public and private [DNS zones](#dns).
> [!NOTE]
> We don't currently recommend DDoS IP Protection in Azure Landing Zones and recommend using this option in specific circumstances. Review the product documentation [About Azure DDoS Protection SKU Comparison](/azure/ddos-protection/ddos-protection-sku-comparison)


#### Traditional Azure networking topology (hub and spoke)

The module can optionally deploy one or more hub networks based on the [traditional Azure networking topology (hub and spoke)](../azure-best-practices/traditional-azure-networking-topology.md).

:::image type="content" source="media/terraform-caf-enterprise-scale-connectivity.png" alt-text="Diagram of the Azure landing zone conceptual architecture, focusing on the connectivity resources using a traditional Azure networking topology (hub and spoke)." lightbox="media/terraform-caf-enterprise-scale-connectivity.png":::

> [!NOTE]
> The module currently configures only the networking hub and dependent resources for the connectivity subscription. Although there's an option to enable outbound virtual network peering from hub to spoke, users still need to initiate peering from spoke to hub. This is due to limitations in how the AzureRM provider targets a specific subscription for deployment.

When you deploy resources based on a traditional Azure networking topology (hub and spoke), the module deploys and manages the following resource types (*depending on configuration*):

| Resource | Azure resource type | Terraform resource type |
| --- | --- | --- |
| Resource groups | [`Microsoft.Resources/resourceGroups`][arm_resource_group] | [`azurerm_resource_group`][azurerm_resource_group] |
| Virtual networks | [`Microsoft.Network/virtualNetworks`][arm_virtual_network] | [`azurerm_virtual_network`][azurerm_virtual_network] |
| Subnets | [`Microsoft.Network/virtualNetworks/subnets`][arm_subnet] | [`azurerm_subnet`][azurerm_subnet] |
| Virtual network gateways | [`Microsoft.Network/virtualNetworkGateways`][arm_virtual_network_gateway] | [`azurerm_virtual_network_gateway`][azurerm_virtual_network_gateway] |
| Azure firewalls | [`Microsoft.Network/azureFirewalls`][arm_firewall] | [`azurerm_firewall`][azurerm_firewall] |
| Public IP addresses | [`Microsoft.Network/publicIPAddresses`][arm_public_ip] | [`azurerm_public_ip`][azurerm_public_ip] |
| Virtual network peerings | [`Microsoft.Network/virtualNetworks/virtualNetworkPeerings`][arm_virtual_network_peering] | [`azurerm_virtual_network_peering`][azurerm_virtual_network_peering] |

For more information about how to use this capability, see the [Deploy Connectivity Resources][wiki_deploy_connectivity_resources] wiki page.

#### Virtual WAN network topology (Microsoft-managed)

The module can optionally deploy one or more hub networks based on the [Virtual WAN network topology (Microsoft-managed)](../azure-best-practices/virtual-wan-network-topology.md).

:::image type="content" source="media/terraform-caf-enterprise-scale-virtual-wan.png" alt-text="Diagram of the Azure landing zone conceptual architecture, focusing on the connectivity resources using a Virtual WAN network topology (Microsoft-managed)." lightbox="media/terraform-caf-enterprise-scale-virtual-wan.png":::

> [!NOTE]
> Due to the different capabilities of Virtual WAN network resources over traditional, peering for Virtual WAN spokes is bi-directional when using this capability.

When you deploy resources based on a Virtual WAN network topology (Microsoft-managed), the module deploys and manages the following resource types (*depending on configuration*):

| Resource | Azure resource type | Terraform resource type |
| --- | -------------- | ------------------ |
| Resource Groups | [`Microsoft.Resources/resourceGroups`][arm_resource_group] | [`azurerm_resource_group`][azurerm_resource_group] |
| Virtual WANs | [`Microsoft.Network/virtualWans`][arm_virtual_wan] | [`azurerm_virtual_wan`][azurerm_virtual_wan] |
| Virtual Hubs | [`Microsoft.Network/virtualHubs`][arm_virtual_hub] | [`azurerm_virtual_hub`][azurerm_virtual_hub] |
| Express Route Gateways | [`Microsoft.Network/expressRouteGateways`][arm_express_route_gateway] | [`azurerm_express_route_gateway`][azurerm_express_route_gateway] |
| VPN Gateways | [`Microsoft.Network/vpnGateways`][arm_vpn_gateway] | [`azurerm_vpn_gateway`][azurerm_vpn_gateway] |
| Azure Firewalls | [`Microsoft.Network/azureFirewalls`][arm_firewall] | [`azurerm_firewall`][azurerm_firewall] |
| Azure Firewall Policies | [`Microsoft.Network/firewallPolicies`][arm_firewall_policy] | [`azurerm_firewall_policy`][azurerm_firewall_policy] |
| Virtual Hub Connections | [`Microsoft.Network/virtualHubs/hubVirtualNetworkConnections`][arm_virtual_hub_connection] | [`azurerm_virtual_hub_connection`][azurerm_virtual_hub_connection] |

For more information about how to use this capability, see the [Deploy Virtual WAN Resources][wiki_deploy_virtual_wan_resources] wiki page.

#### DDoS Protection plan

The module can optionally deploy [DDoS Network Protection][about_ddos_network_protection], and link Virtual Networks to the plan if needed.

> [!NOTE]
> Due to platform limitations, DDoS Protection plans can only be enabled for traditional virtual networks. Virtual Hub support is not currently available.

<!-- markdownlint-disable-next-line no-blanks-blockquote-->
> [!IMPORTANT]
> The Azure landing zones guidance recommends enabling DDoS Network Protection to increase protection of your Azure platform. To prevent unexpected costs in non-production and MVP deployments, this capability is disabled in the Azure landing zones Terraform module due to the cost associated with this resource.
>
> For production environments, we strongly recommend enabling this capability.

When you enable deployment of deployment of DDoS Protection plan resources, the module deploys and manages the following resource types (*depending on configuration*):

| Resource | Azure resource type | Terraform resource type |
| --- | --- | --- |
| Resource groups | [`Microsoft.Resources/resourceGroups`][arm_resource_group] | [`azurerm_resource_group`][azurerm_resource_group] |
| DDoS Protection plans | [`Microsoft.Network/ddosProtectionPlans`][arm_ddos_protection_plan] | [`azurerm_network_ddos_protection_plan`][azurerm_network_ddos_protection_plan] |

#### DNS

The module can optionally deploy [Private DNS zones to support Private Endpoints][about_dns_for_private_endpoint] and link them to hub and/or spoke Virtual Networks.
User-specified public and private DNS zones can also be deployed and linked as needed.

When you enable deployment of deployment of DNS resources, the module deploys and manages the following resource types (*depending on configuration*):

| Resource | Azure resource type | Terraform resource type |
| --- | -------------- | ------------------ |
| Resource Groups | [`Microsoft.Resources/resourceGroups`][arm_resource_group] | [`azurerm_resource_group`][azurerm_resource_group] |
| DNS Zones | [`Microsoft.Network/dnsZones`][arm_dns_zone] | [`azurerm_dns_zone`][azurerm_dns_zone] |
| Private DNS Zones | [`Microsoft.Network/privateDnsZones`][arm_private_dns_zone] | [`azurerm_private_dns_zone`][azurerm_private_dns_zone] |
| Private DNS Zone Virtual Network Link | [`Microsoft.Network/privatednszones/virtualnetworklinks`][arm_private_dns_zone_virtual_network_link] | [`azurerm_private_dns_zone_virtual_network_link`][azurerm_private_dns_zone_virtual_network_link] |

### Identity resources

The module provides an option to configure policies relating to the [identity and access management][alz_identity] landing zone. It also ensures that the specified subscription is placed in the right management group.

:::image type="content" source="media/terraform-caf-enterprise-scale-identity.png" alt-text="Diagram of the Azure landing zone conceptual architecture, focusing on the identity resources." lightbox="media/terraform-caf-enterprise-scale-identity.png":::

> [!NOTE]
> This capability doesn't deploy any resources. If you want to update policy settings related to the identity management group, use the `configure_identity_resources` input variable.

For more information about how to use this capability, see the [Deploy Identity Resources][wiki_deploy_identity_resources] wiki page.

## Getting started

Requirements for getting started with the module are documented on the [Getting Started][wiki_getting_started] Wiki page.

To simplify getting started, the module has been published to the [Terraform Registry][tf_reg_azure]. You can reference it directly within your code, as shown in the [simple example](#simple-example) later in this article. Running `terraform init` will automatically download the module and all dependencies.

You can view the latest module and provider dependencies on the [Dependencies][caf-es-dependencies] tab in the Terraform Registry.

> [!IMPORTANT]
> There are known issues with some Terraform and AzureRM provider version combinations. You can resolve some known issues by upgrading to the latest Terraform and AzureRM provider versions. Other known issues are transient errors that you can typically fix by rerunning your deployment.
>
> We generally recommend pinning to specific versions, and testing thoroughly before upgrading.
>
> We'll release new versions of the module when changes are needed. New releases will ensure compatibility with the latest Terraform and AzureRM provider versions. Please refer to our [Module releases][wiki_module_releases] guidance for more information.
>
> To get the latest features, ensure that the module version is set to the latest version. If you're upgrading to a later version of the module, run `terraform init -upgrade`.
>
> ![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/Azure/terraform-azurerm-caf-enterprise-scale?style=flat&logo=github)

## Simple example

This example code will deploy the minimum recommended [management group and subscription organization][arm_management_group_subscriptions] from the enterprise-scale reference architecture. After you have this simple example up and running, you can start to customize your deployment.

> [!TIP]
> Even though `root_parent_id` is the module's only mandatory variable, we also recommend setting `root_id`. Changing the `root_id` value will start a full redeployment of all resources that the module manages, including downstream dependencies.

The following code is a simple starting configuration for your `main.tf` root module:

```hcl
# Configure Terraform to set the required AzureRM provider
# version and features{} block.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.77.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Get the current client configuration from the AzureRM provider.
# This configuration is used to populate the root_parent_id variable with the
# current tenant ID used as the ID for the "Tenant Root Group"
# management group.

data "azurerm_client_config" "core" {}

# Use variables to customize the deployment

variable "root_id" {
  type    = string
  default = "es"
}

variable "root_name" {
  type    = string
  default = "Enterprise-Scale"
}

# Declare the Terraform Module for Cloud Adoption Framework
# Enterprise-scale and provide a base configuration.

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = ">= 1.0.0"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  root_parent_id = data.azurerm_client_config.core.tenant_id
  root_id        = var.root_id
  root_name      = var.root_name

}
```

## Next steps

The [Terraform module for Cloud Adoption Framework Enterprise-scale][caf-enterprise-scale] provides an accelerated path to building out your enterprise-scale landing zones. It also provides the flexibility to expand and customize your deployment while maintaining a simplified approach to managing the configuration of each landing zone.

To find out more, [review the module on the Terraform Registry][caf-enterprise-scale] and explore the [module documentation][gh-wiki] on GitHub. In the documentation, you'll find more examples and tutorials about how to customize your deployment.

Learn how to [deploy the Azure landing zones Terraform module][hcl-deploy-es] through HashiCorp Learn. From there, you can also discover how some parts of the module work.

<!-- Common links -->

[terraform]: https://www.terraform.io/ "Terraform by HashiCorp"

[hcl-deploy-es]: https://learn.hashicorp.com/tutorials/terraform/microsoft-caf-enterprise-scale "Deploy the Microsoft Cloud Adoption Framework Enterprise-Scale Module."

[caf-enterprise-scale]: https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest "See the Azure landing zones Terraform module on the Terraform Registry."
[caf-es-dependencies]: https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest?tab=dependencies "See dependencies for the Azure landing zones Terraform module on the Terraform Registry."

[msdocs_alz_architecture]: index.md#azure-landing-zone-conceptual-architecture "Conceptual architecture for Azure landing zones."

[alz_resourceorg]:  design-area/resource-org.md "Resource organization for Azure landing zones on the Cloud Adoption Framework."
[alz_security]:     design-area/security.md "Security for Azure landing zones on the Cloud Adoption Framework."
[alz_governance]:   design-area/governance.md "Governance for Azure landing zones on the Cloud Adoption Framework."
[alz_management]:   design-area/management.md "Management and monitoring for Azure landing zones on the Cloud Adoption Framework."
[alz_connectivity]: design-area/network-topology-and-connectivity.md "Network topology and connectivity for Azure landing zones on the Cloud Adoption Framework."
[alz_identity]:     design-area/identity-access.md "Identity and access management for Azure landing zones on the Cloud Adoption Framework."

[gh-es]: https://github.com/Azure/Enterprise-Scale "Azure/Enterprise-Scale GitHub repository."
[gh-wiki]: https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki "Module documentation on the GitHub wiki."

[wiki_provider_configuration]:        https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BUser-Guide%5D-Provider-Configuration "Provider configuration guide on the GitHub wiki."
[wiki_deploy_management_resources]:   https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Deploy-Management-Resources "Wiki: Deploy Management Resources"
[wiki_deploy_connectivity_resources]: https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Deploy-Connectivity-Resources "Wiki: Deploy Connectivity Resources"
[wiki_deploy_virtual_wan_resources]:  https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Deploy-Virtual-WAN-Resources "Wiki: Deploy Virtual WAN Resources"
[wiki_deploy_identity_resources]:     https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Deploy-Identity-Resources "Wiki: Deploy Identity Resources"
[wiki_module_releases]:               https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BUser-Guide%5D-Module-Releases "Wiki: Module Releases"
[wiki_getting_started]:               https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BUser-Guide%5D-Getting-Started "Wiki: Getting Started"

[tf_reg_azure]: https://registry.terraform.io/modules/Azure "Search Azure modules on the Terraform Registry."
[tf_install]:   https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/azure-get-started "Install Terraform."
[azurerm_auth]: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure "Authenticate to Azure when using the AzureRM provider."

[about_ddos_network_protection] : /azure/ddos-protection/ddos-protection-overview
[about_dns_for_private_endpoint]: /azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration

[arm_management_group]:                      /azure/templates/microsoft.management/managementgroups
[arm_management_group_subscriptions]:        /azure/templates/microsoft.management/managementgroups/subscriptions
[arm_policy_assignment]:                     /azure/templates/microsoft.authorization/policyassignments
[arm_policy_definition]:                     /azure/templates/microsoft.authorization/policydefinitions
[arm_policy_set_definition]:                 /azure/templates/microsoft.authorization/policysetdefinitions
[arm_role_assignment]:                       /azure/templates/microsoft.authorization/roleassignments
[arm_role_definition]:                       /azure/templates/microsoft.authorization/roledefinitions
[arm_resource_group]:                        /azure/templates/microsoft.resources/resourcegroups
[arm_log_analytics_workspace]:               /azure/templates/microsoft.operationalinsights/workspaces
[arm_log_analytics_solution]:                /azure/templates/microsoft.operationsmanagement/solutions
[arm_automation_account]:                    /azure/templates/microsoft.automation/automationaccounts
[arm_log_analytics_linked_service]:          /azure/templates/microsoft.operationalinsights/workspaces/linkedservices
[arm_virtual_network]:                       /azure/templates/microsoft.network/virtualnetworks
[arm_subnet]:                                /azure/templates/microsoft.network/virtualnetworks/subnets
[arm_virtual_network_gateway]:               /azure/templates/microsoft.network/virtualnetworkgateways
[arm_firewall]:                              /azure/templates/microsoft.network/azurefirewalls
[arm_public_ip]:                             /azure/templates/microsoft.network/publicipaddresses
[arm_ddos_protection_plan]:                  /azure/templates/microsoft.network/ddosprotectionplans
[arm_dns_zone]:                              /azure/templates/microsoft.network/dnszones
[arm_private_dns_zone]:                      /azure/templates/microsoft.network/privatednszones
[arm_private_dns_zone_virtual_network_link]: /azure/templates/microsoft.network/privatednszones/virtualnetworklinks
[arm_virtual_network_peering]:               /azure/templates/microsoft.network/virtualnetworks/virtualnetworkpeerings
[arm_virtual_wan]:                           /azure/templates/microsoft.network/virtualWans
[arm_virtual_hub]:                           /azure/templates/microsoft.network/virtualHubs
[arm_express_route_gateway]:                 /azure/templates/microsoft.network/expressRouteGateways
[arm_vpn_gateway]:                           /azure/templates/microsoft.network/vpnGateways
[arm_firewall_policy]:                       /azure/templates/microsoft.network/firewallPolicies
[arm_virtual_hub_connection]:                /azure/templates/microsoft.network/virtualHubs/hubVirtualNetworkConnections

[azurerm_management_group]:                      https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group
[azurerm_management_group_policy_assignment]:    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment
[azurerm_policy_assignment]:                     https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_assignment
[azurerm_policy_definition]:                     https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition
[azurerm_policy_set_definition]:                 https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition
[azurerm_role_assignment]:                       https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
[azurerm_role_definition]:                       https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition
[azurerm_resource_group]:                        https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
[azurerm_log_analytics_workspace]:               https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
[azurerm_log_analytics_solution]:                https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution
[azurerm_automation_account]:                    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account
[azurerm_log_analytics_linked_service]:          https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_linked_service
[azurerm_virtual_network]:                       https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
[azurerm_subnet]:                                https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
[azurerm_virtual_network_gateway]:               https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway
[azurerm_firewall]:                              https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall
[azurerm_public_ip]:                             https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
[azurerm_network_ddos_protection_plan]:          https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_ddos_protection_plan
[azurerm_dns_zone]:                              https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone
[azurerm_private_dns_zone]:                      https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone
[azurerm_private_dns_zone_virtual_network_link]: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link
[azurerm_virtual_network_peering]:               https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering
[azurerm_virtual_wan]:                           https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_wan
[azurerm_virtual_hub]:                           https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub
[azurerm_express_route_gateway]:                 https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_gateway
[azurerm_vpn_gateway]:                           https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_gateway
[azurerm_firewall_policy]:                       https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy
[azurerm_virtual_hub_connection]:                https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub_connection
