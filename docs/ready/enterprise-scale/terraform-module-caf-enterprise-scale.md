---
title: Terraform module for Cloud Adoption Framework enterprise-scale
description: Learn how to use the Terraform module for Cloud Adoption Framework enterprise-scale to deploy Azure landing zones.
author: krowlandson
ms.author: brblanch
ms.date: 10/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Use Terraform to build enterprise-scale landing zones

Azure provides native services for building your enterprise-scale landing zones. Other third-party tools can also help with this effort. One such tool that customers and partners often use to deploy landing zones is Terraform by HashiCorp.

The [caf-enterprise-scale][caf-enterprise-scale] module provides an opinionated approach for deploying the recommended platform resources needed to manage [Azure landing zones][msdocs-alz-architecture] at scale, using Terraform.

These resources are aligned to the enterprise scale [reference architecture][es-ref-arch]:

![Overview of the enterprise scale reference architecture][img-es-ref-arch]
*Figure 1: Overview of the enterprise scale reference architecture.*

The module can be configured to deploy different sets of resources as required, each aligned to the critical design areas of enterprise-scale:

| Resource category | Enterprise-scale critical design areas |
| --- | --- |
| Core resources | [Management Group and Subscription organization][es-hierarchy]</br>[Security governance and compliance][es-security]</br>[Business continuity and disaster recovery][es-bcdr] |
| Management resources | [Management and monitoring][es-management] |
| Connectivity resources | [Network topology and connectivity][es-connectivity] |
| Identity resources | [Identity and access management][es-identity] |

By packaging these capabilities into a single Terraform module, it becomes easier to build and enforce consistency across the Azure platform when operating at scale.

## Use standard modules

Reuse of components is a fundamental principle of infrastructure as code. Modules are instrumental in defining standards and consistency across resource deployment within and across environments. This module is published to the official [Terraform Registry][tf-reg-azure] and is verified by HashiCorp.

Deploying the module from the Terraform Registry provides strict version control, whilst ensuring you always have access to the latest version. This provides both an accelerated delivery of enterprise-scale in your environment, and a tested upgrade path to the latest version of enterprise-scale.

## Benefits of using the module

1. Managed and extensible core resource hierarchy for *subscription* organization using *management groups*.
1. Scalable security governance and compliance using *Azure Policy* and *Access Control (IAM)*, with an extensive library of custom definitions ready to assign.
1. Enforcement of policy across *subscriptions* through *management group* inheritance.
1. Managed resources for *management* and *connectivity* landing zones, providing: 
    1. Assured *policy compliance* through tight integration of *resources* managed by the module and corresponding *policy assignments*.
    1. Integration between resources to reduce management overhead and provide an improved end-user experience, such as automatic creation of virtual network links for *Azure Private DNS*.

## Capabilities

Resources deployed by the module are split logically into the following capabilities:

- [Core Resources](#core-resources)
- [Management Resources](#management-resources)
- [Connectivity Resources](#connectivity-resources)
- [Identity Resources](#identity-resources)

These resources can be deployed to multiple Subscriptions by setting the [Provider Configuration][wiki_provider_configuration] on the module block.

The following sections outline the different resource types deployed and managed by this module, depending on the configuration options specified.

### Core resources

The core capability of this module deploys the foundations of the [Cloud Adoption Framework enterprise-scale landing zone architecture][msdocs-alz-architecture], with a focus on the central [resource hierarchy and governance][es-hierarchy]:

![Enterprise-scale Core Landing Zones Architecture][img-tf-core]

The following resource types are deployed and managed by this module when using the core resources capability:

|     | Azure Resource | Terraform Resource |
| --- | -------------- | ------------------ |
| Management Groups | [`Microsoft.Management/managementGroups`][arm_management_group] | [`azurerm_management_group`][azurerm_management_group] |
| Management Group Subscriptions | [`Microsoft.Management/managementGroups/subscriptions`][arm_management_group_subscriptions] | [`azurerm_management_group`][azurerm_management_group] |
| Policy Assignments | [`Microsoft.Authorization/policyAssignments`][arm_policy_assignment] | [`azurerm_management_group_policy_assignment`][azurerm_management_group_policy_assignment] |
| Policy Definitions | [`Microsoft.Authorization/policyDefinitions`][arm_policy_definition] | [`azurerm_policy_definition`][azurerm_policy_definition] |
| Policy Set Definitions | [`Microsoft.Authorization/policySetDefinitions`][arm_policy_set_definition] | [`azurerm_policy_set_definition`][azurerm_policy_set_definition] |
| Role Assignments | [`Microsoft.Authorization/roleAssignments`][arm_role_assignment] | [`azurerm_role_assignment`][azurerm_role_assignment] |
| Role Definitions | [`Microsoft.Authorization/roleDefinitions`][arm_role_definition] | [`azurerm_role_definition`][azurerm_role_definition] |

The exact number of resources created depends on the module configuration, but you can expect upwards of `180` resources to be created by this module for a default installation based on the example below.

> [!TIP]
> None of these resources are deployed at the Subscription scope, however Terraform still requires a Subscription to establish an authenticated session with Azure.

### Management resources

The module provides an option to enable deployment of [Management and monitoring][es-management] resources into the current Subscription context.
This brings the benefit of being able to manage the full lifecycle of these resources using Terraform, with native integration into the corresponding Policy Assignments to ensure full policy compliance.

![Enterprise-scale Management Landing Zone Architecture][img-tf-management]

The following resource types are deployed and managed by this module when the Management resources capability is enabled:

|     | Azure Resource | Terraform Resource |
| --- | -------------- | ------------------ |
| Resource Groups | [`Microsoft.Resources/resourceGroups`][arm_resource_group] | [`azurerm_resource_group`][azurerm_resource_group] |
| Log Analytics Workspace | [`Microsoft.OperationalInsights/workspaces`][arm_log_analytics_workspace] | [`azurerm_log_analytics_workspace`][azurerm_log_analytics_workspace] |
| Log Analytics Solutions | [`Microsoft.OperationsManagement/solutions`][arm_log_analytics_solution] | [`azurerm_log_analytics_solution`][azurerm_log_analytics_solution] |
| Automation Account | [`Microsoft.Automation/automationAccounts`][arm_automation_account] | [`azurerm_automation_account`][azurerm_automation_account] |
| Log Analytics Linked Service | [`Microsoft.OperationalInsights/workspaces /linkedServices`][arm_log_analytics_linked_service] | [`azurerm_log_analytics_linked_service`][azurerm_log_analytics_linked_service] |

Please refer to the [Deploy Management Resources][wiki_deploy_management_resources] page on our Wiki for more information about how to use this capability.

### Connectivity resources

The module provides an option to enable deployment of [Network topology and connectivity][es-connectivity] resources into the current Subscription context.
This is currently limited to the Hub & Spoke network topology, but the addition of Virtual WAN capabilities is on our roadmap (date TBC).

![Enterprise-scale Connectivity Landing Zone Architecture][img-tf-connectivity]

> [!TIP]
> The module currently only configures the networking hub, and dependent resources for the `connectivity` Subscription.
> Although we provide an option to enable outbound Virtual Network Peering (*from hub to spoke*), users will still need to initiate peering from spoke to hub.
> This is due to limitations in how the azurerm provider targets a specific Subscription for deployment.

The following resource types are deployed and managed by this module when the Connectivity resources capability is enabled:

|     | Azure Resource | Terraform Resource |
| --- | -------------- | ------------------ |
| Resource Groups | [`Microsoft.Resources/resourceGroups`][arm_resource_group] | [`azurerm_resource_group`][azurerm_resource_group] |
| Virtual Networks | [`Microsoft.Network/virtualNetworks`][arm_virtual_network] | [`azurerm_virtual_network`][azurerm_virtual_network] |
| Subnets | [`Microsoft.Network/virtualNetworks/subnets`][arm_subnet] | [`azurerm_subnet`][azurerm_subnet] |
| Virtual Network Gateways | [`Microsoft.Network/virtualNetworkGateways`][arm_virtual_network_gateway] | [`azurerm_virtual_network_gateway`][azurerm_virtual_network_gateway] |
| Azure Firewalls | [`Microsoft.Network/azureFirewalls`][arm_firewall] | [`azurerm_firewall`][azurerm_firewall] |
| Public IP Addresses | [`Microsoft.Network/publicIPAddresses`][arm_public_ip] | [`azurerm_public_ip`][azurerm_public_ip] |
| DDoS Protection Plans | [`Microsoft.Network/ddosProtectionPlans`][arm_ddos_protection_plan] | [`azurerm_network_ddos_protection_plan`][azurerm_network_ddos_protection_plan] |
| DNS Zones (pending) | [`Microsoft.Network/dnsZones`][arm_dns_zone] | [`azurerm_dns_zone`][azurerm_dns_zone] |
| Virtual Network Peerings (pending) | [`Microsoft.Network/virtualNetworks/virtualNetworkPeerings`][arm_virtual_network_peering] | [`azurerm_virtual_network_peering`][azurerm_virtual_network_peering] |

Please refer to the [Deploy Connectivity Resources][wiki_deploy_connectivity_resources] page on our Wiki for more information about how to use this capability.

### Identity resources

The module provides an option to enable deployment of [Identity and access management][es-identity] resources into the current Subscription context.

![Enterprise-scale Identity Landing Zone Architecture][img-tf-identity]

No additional resources are deployed by this capability, however policy settings relating to the `identity` Management Group can now be easily updated via the `configure_identity_resources` input variable.

Please refer to the [Deploy Identity Resources][wiki_deploy_identity_resources] page on our Wiki for more information about how to use this capability.

## Customize and deploy

To simplify getting started with this module, it has been published to the [Terraform Registry][tf-reg-azure]. This allows you to consume it directly from the registry as a re-usable module and can benefit from updates as they get released.

The only dependencies for this module are as follows:

- Terraform (*recommended version 0.15.0 and later*)
- AzureRM provider (*recommended version 2.77.0 and later*)

> [!IMPORTANT]
> There are known issues with some Terraform and AzureRM provider version combinations.
> Some of these are due to new bugs being introduced which have since been remediated, whilst others are transient errors which can typically be resolved by re-running your deployment.
> We generally recommend pinning to specific versions, and testing thoroughly before upgrading. 
> As each new version of the module is released, the project team plan to rebase the module to ensure compatibility with the latest Terraform and AzureRM provider versions.

### Simple example

The following is a simple starting configuration for your `main.tf` root module:

> [!TIP]
> Although the module has only one mandatory variable `root_parent_id`, we also recommend setting `root_id`.
> Changing the `root_id` value will initiate a full redeployment of all resources managed by the module, including downstream dependencies.

> [!IMPORTANT]
> To get the latest features, ensure the module version is set to the latest and don't forget to run `terraform init -upgrade` if upgrading to a later version of the module.
> </br>
> </br>
> ![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/Azure/terraform-azurerm-caf-enterprise-scale?style=flat&logo=github)

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
# This is used to populate the root_parent_id variable with the
# current Tenant ID used as the ID for the "Tenant Root Group"
# Management Group.

data "azurerm_client_config" "core" {}

# Use variables to customise the deployment

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

This example code will deploy the minimum recommended [management group and subscription organization][es-hierarchy] from the enterprise-scale reference architecture. You can then start to customize your deployment once you've got this up and running.

> [!TIP]
> If you are new to Terraform, refer to this [tutorial on HashiCorp Learn][tf-install], covering installation and use of Terraform, and the [AzureRM provider guides][azurerm-auth] for information on how to configure the provider and authenticate with Azure.
> We also provide additional guidance on how to configure the provider for [deploying to multiple Subscriptions][wiki_provider_configuration] on our Wiki.

## Next steps

The Terraform module for Cloud Adoption Framework enterprise-scale provides an accelerated path to building out your enterprise-scale landing zones. It also provides a great deal of flexibility to expand and customize your deployment whilst retaining a simplified approach to managing the configuration of each landing zone.

To find out more, review the module on Terraform Registry, and explore the [module documentation on GitHub][gh-wiki] where we will post more examples and tutorials covering how to customize your deployment.

> [!div class="nextstepaction"]
[Review the module on Terraform Registry][caf-enterprise-scale]

<!-- Image references -->

[img-es-ref-arch]:     ./media/ns-arch-cust-inline.png "Overview of the enterprise scale reference architecture."
[img-tf-core]:         ./media/terraform-caf-enterprise-scale-overview.png "Overview of the enterprise scale reference architecture covered by core resources."
[img-tf-connectivity]: ./media/terraform-caf-enterprise-scale-connectivity.png "Overview of the enterprise scale reference architecture covered by connectivity resources."
[img-tf-identity]:     ./media/terraform-caf-enterprise-scale-identity.png "Overview of the enterprise scale reference architecture covered by identity resources."
[img-tf-management]:   ./media/terraform-caf-enterprise-scale-management.png "Overview of the enterprise scale reference architecture covered by management resources."

<!-- Common links -->

[caf-enterprise-scale]: https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest "See the Terraform Module for Cloud Adoption Framework Enterprise-scale on Terraform Registry."

[msdocs-alz-architecture]: https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-conceptual-architecture "Azure landing zones conceptual architecture."

[es-hierarchy]:    ./management-group-and-subscription-organization "Management group and subscription organization for enterprise-scale on the Cloud Adoption Framework."
[es-security]:     ./security-governance-and-compliance "Security governance and compliance for enterprise-scale on the Cloud Adoption Framework."
[es-bcdr]:         ./business-continuity-and-disaster-recovery "Business continuity and disaster recovery for enterprise-scale on the Cloud Adoption Framework."
[es-management]:   ./management-and-monitoring "Management and monitoring for enterprise-scale on the Cloud Adoption Framework."
[es-connectivity]: ./network-topology-and-connectivity "Network topology and connectivity for enterprise-scale on the Cloud Adoption Framework."
[es-identity]:     ./identity-and-access-management "Identity and access management for enterprise-scale on the Cloud Adoption Framework."
[es-ref-arch]:     ./architecture#high-level-architecture "Enterprise-scale reference architecture."

[gh-wiki]: https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki "Module documentation on the GitHub Wiki."

[wiki_provider_configuration]:        https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BUser-Guide%5D-Provider-Configuration "Provider configuration guide on the GitHub Wiki."
[wiki_deploy_management_resources]:   https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Deploy-Management-Resources "Wiki - Deploy Management Resources"
[wiki_deploy_connectivity_resources]: https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Deploy-Connectivity-Resources "Wiki - Deploy Connectivity Resources"
[wiki_deploy_identity_resources]:     https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Deploy-Identity-Resources "Wiki - Deploy Identity Resources"

[tf-reg-azure]: https://registry.terraform.io/modules/Azure "Search Azure modules on the Terraform Registry."
[tf-install]:   https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/azure-get-started "See how to install Terraform."
[azurerm-auth]: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure "See how to authenticate to Azure when using the azurerm provider."

[arm_management_group]:               https://docs.microsoft.com/en-us/azure/templates/microsoft.management/managementgroups
[arm_management_group_subscriptions]: https://docs.microsoft.com/en-us/azure/templates/microsoft.management/managementgroups/subscriptions
[arm_policy_assignment]:              https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/policyassignments
[arm_policy_definition]:              https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/policydefinitions
[arm_policy_set_definition]:          https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/policysetdefinitions
[arm_role_assignment]:                https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/roleassignments
[arm_role_definition]:                https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/roledefinitions
[arm_resource_group]:                 https://docs.microsoft.com/en-us/azure/templates/microsoft.resources/resourcegroups
[arm_log_analytics_workspace]:        https://docs.microsoft.com/en-us/azure/templates/microsoft.operationalinsights/workspaces
[arm_log_analytics_solution]:         https://docs.microsoft.com/en-us/azure/templates/microsoft.operationsmanagement/solutions
[arm_automation_account]:             https://docs.microsoft.com/en-us/azure/templates/microsoft.automation/automationaccounts
[arm_log_analytics_linked_service]:   https://docs.microsoft.com/en-us/azure/templates/microsoft.operationalinsights/workspaces/linkedservices
[arm_virtual_network]:                https://docs.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworks
[arm_subnet]:                         https://docs.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworks/subnets
[arm_virtual_network_gateway]:        https://docs.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworkgateways
[arm_firewall]:                       https://docs.microsoft.com/en-us/azure/templates/microsoft.network/azurefirewalls
[arm_public_ip]:                      https://docs.microsoft.com/en-us/azure/templates/microsoft.network/publicipaddresses
[arm_ddos_protection_plan]:           https://docs.microsoft.com/en-us/azure/templates/microsoft.network/ddosprotectionplans
[arm_dns_zone]:                       https://docs.microsoft.com/en-us/azure/templates/microsoft.network/dnszones
[arm_virtual_network_peering]:        https://docs.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworks/virtualnetworkpeerings

[azurerm_management_group]:                   https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group
[azurerm_management_group_policy_assignment]: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment
[azurerm_policy_assignment]:                  https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_assignment
[azurerm_policy_definition]:                  https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition
[azurerm_policy_set_definition]:              https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition
[azurerm_role_assignment]:                    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
[azurerm_role_definition]:                    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition
[azurerm_resource_group]:                     https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
[azurerm_log_analytics_workspace]:            https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
[azurerm_log_analytics_solution]:             https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution
[azurerm_automation_account]:                 https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account
[azurerm_log_analytics_linked_service]:       https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_linked_service
[azurerm_virtual_network]:                    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
[azurerm_subnet]:                             https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
[azurerm_virtual_network_gateway]:            https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway
[azurerm_firewall]:                           https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall
[azurerm_public_ip]:                          https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
[azurerm_network_ddos_protection_plan]:       https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_ddos_protection_plan
[azurerm_dns_zone]:                           https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone
[azurerm_virtual_network_peering]:            https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering
