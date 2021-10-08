---
title: Enterprise-scale FAQ
description: The Enterprise-scale FAQ provides answers to common questions asked about the Enterprise-scale architecture.
author: jtracey93
ms.author: jatracey
ms.date: 09/13/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Enterprise-scale FAQ

This article answers frequently asked questions about enterprise-scale architecture.

<!-- GENERAL -->

## What is the Azure landing zone accelerator?

The Azure landing zone accelerator is an Azure portal-based deployment experience. It deploys an opinionated implementation based on the [Azure landing zone conceptual architecture](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-conceptual-architecture).

## What is the Azure landing zone conceptual architecture?

The Azure landing zone conceptual architecture represents scale and maturity decisions. It's based on lessons learned and feedback from customers who have adopted Azure as part of their digital estate. This conceptual architecture can help your organization set a direction for designing and implementing a landing zone.

## What does a landing zone map to in Azure in the context of enterprise-scale architecture?

From an enterprise-scale point of view, landing zones are individual Azure subscriptions.

## How long does enterprise-scale architecture take to deploy?

Deployment time depends on the options you select during the implementation experience. It varies from around five minutes to 40 minutes, depending on the options selected.

For example:

- Conceptual architecture without any networking or connectivity options can take around five minutes to deploy.
- Conceptual architecture with the hub and spoke networking options, including VPN and ExpressRoute gateways, can take around 40 minutes to deploy.

## Why are there custom policy definitions as part of enterprise-scale architecture?

We work with and learn from our customers and partners. This collaboration helps us evolve and enhance the reference implementations to meet customer and partner requirements. As part of this interaction with customers and partners, we might notice policy definition gaps. In those cases, we create and test a definition to fill the gap and include it in enterprise-scale architecture for everyone to use.

We then work with the Azure Policy and associated engineering teams to convert the new custom policy definition into a built-in definition.

## What does policy-driven governance mean, and how does it work?

[Policy-driven governance](/azure/cloud-adoption-framework/ready/enterprise-scale/design-principles#policy-driven-governance) is one of the key design principles of enterprise-scale architecture.

Policy-driven governance means using Azure Policy to reduce the time you need for common and repeated operational tasks across your Azure tenant. Use many of the [Azure Policy effects](/azure/governance/policy/concepts/effects), such as `Append`, `Deny`, `DeployIfNotExists`, and `Modify`, to prevent non-compliance by either restricting non-compliant resources (as defined by the policy definition) from being created or updated or by deploying resources or modifying settings of a resource creation or update request to make them compliant. Some effects, such as `Audit`, `Disabled`, and `AuditIfNotExists`, don't prevent or take action; they only audit and report on non-compliance.

Some examples of policy-driven governance are:

- `Deny` effect: Prevents subnets from being created or updated to have no Network Security Groups associated with them.

- `DeployIfNotExists` effect: A new subscription (landing zone) is created and placed into a management group within your enterprise-scale deployment. Azure Policy ensures that Azure Defender (previously known as Azure Security Center Standard) is enabled on the subscription. It also configures the diagnostic settings for Activity Log to send logs to the Log Analytics workspace in the Management subscription.
  
   Instead of repeating code or manual activities when a new subscription is created, the `DeployIfNotExists` policy definition automatically deploys and configures them for you.

## Should we use Azure Policy to deploy workloads?

In short, **no**. Use Azure Policy to control, govern, and keep your workloads and landing zones compliant. It isn't designed to deploy entire workloads and other tooling. Use the Azure portal or infrastructure-as-code offerings (ARM Templates, Bicep, Terraform) to deploy and manage your workload and get the autonomy you need.

## What if we already have resources in our landing zones and later assign an Azure Policy definition that includes them in its scope?

Review the following documentation sections:

- [Transition existing Azure environments to enterprise-scale - "Policy" section](/azure/cloud-adoption-framework/ready/enterprise-scale/transition#policy)
- [Quickstart: Create a policy assignment to identify non-compliant resources - "Identify non-compliant resources"
 section](/azure/governance/policy/assign-policy-portal#identify-non-compliant-resources)

## Where can I see the policy definitions used by enterprise-scale landing zones reference implementation?

You can find a list of policy definitions here: [Policies included in enterprise-scale landing zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md)

We also add changes to our [What's New? wiki page](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new).

<!-- IMPLEMENTATION -->

## Why does enterprise-scale architecture require permission at tenant root '/' scope?

Management group creation, subscription creation, and placing subscriptions into management groups are APIs that operate at the tenant root "`/`" scope.

To establish the management group hierarchy and create subscriptions and place them into the defined management groups, the initial deployment must be invoked at the tenant root "`/`" scope. Once you deploy enterprise-scale architecture, you can remove the owner permission from the tenant root "`/`" scope. You are made an owner at the intermediate root management group (for example "Contoso") by the Azure platform.

For more information about tenant-level deployments in Azure, see [Deploy resources to tenant](/azure/azure-resource-manager/templates/deploy-to-tenant).

## The Azure landing zone accelerator portal-based deployment doesn't display all subscriptions in the drop-down lists?

When you deploy an Azure landing zone accelerator, the portal lists subscriptions to be selected for deployment from the platform subscriptions (management, connectivity, identity) and the landing zones (corp and online). When there are more than 50 subscriptions, the API can't display all of them in the drop-down lists.

Follow these steps as a workaround:

1. Select or enable your usual options in the Azure landing zone accelerator portal-based experience. In the subscription drop-downs, select any visible subscription as a placeholder so that you can see and select all options (some options don't appear until you select a subscription).
1. After you've gone through each page, go back to the **Basics** page, and then select **Edit parameters**.
1. Change the value for the specific `subscriptionId` parameter inputs with the actual subscription IDs you want to use.
1. Select **Save**.
1. Select **Review + create**, and then submit the deployment.

## Can we use and customize the ARM templates for enterprise-scale architecture and check them into our repository and deploy it from there?

All of the ARM templates for enterprise-scale architecture are developed and optimized for the Azure landing zone accelerator portal-based experience. We don't recommend or support customization of these templates because they're complex. To handle all of the options and variations we provide for the Azure landing zone accelerator portal-based experience, ARM template expressions would need numerous logical operators and conditions. ARM deployments (nested templates) need to deploy in a specific order to be successful.

Finally, taking the same templates for future operations requires you to redeploy to the entire tenant for any change, and also requires permanent owner role-based access control assignment on the tenant root "`/`" scope.

However, if you want to deploy and manage enterprise-scale architecture via infrastructure-as-code, see [What if we can't deploy using the Azure landing zone accelerator portal-based experience, but want to deploy via infrastructure-as-code?](#what-if-we-cant-deploy-by-using-the-azure-landing-zone-accelerator-portal-based-experience-but-can-deploy-via-infrastructure-as-code).

## What if we can't deploy by using the Azure landing zone accelerator portal-based experience, but can deploy via infrastructure-as-code?

The following implementation options are available when you use infrastructure-as-code:

- The [Azure landing zone accelerator](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-accelerator) portal-based experience can integrate and bootstrap a CI/CD pipeline using GitHub with [AzOps](https://github.com/Azure/AzOps) as documented at [Deploying Enterprise Scale](https://github.com/Azure/Enterprise-Scale/wiki/Deploying-Enterprise-Scale).
- The [Enterprise-scale Do-It-Yourself (DIY) ARM templates](https://github.com/Azure/Enterprise-Scale/tree/main/eslzArm#enterprise-scale-landing-zones-arm-templates) method
- The [Terraform Module for Cloud Adoption Framework Enterprise-scale](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale#terraform-module-for-cloud-adoption-framework-enterprise-scale)

<!--
>[!NOTE]
> The Bicep implementation option for Enterprise-scale is coming soon! -->

## If we already deployed enterprise-scale architecture without using infrastructure-as-code, do we have to delete everything and start again to use infrastructure-as-code?

If you used the Azure landing zone accelerator portal-based experience to deploy enterprise-scale architecture into your Azure tenant, see the guidance for the infrastructure-as-code tooling you want to use.

### ARM Templates

To use ARM templates to deploy, manage, and operate your enterprise-scale deployment, you don't have to delete everything and start again. You can configure and connect [AzOps](https://github.com/Azure/AzOps) tooling by using the [AzOps Accelerator](https://github.com/Azure/AzOps-Accelerator) and associated instructions, regardless of the stage of your Azure tenant.

Once configured, AzOps connects to your Azure tenant, scans it, and then pulls individual ARM templates into your repository in a structure that represents the [four Azure scopes](/azure/azure-resource-manager/management/overview#understand-scope).

To see a demo of AzOps being used, check out this YouTube video on the Microsoft DevRadio channel: [Enterprise-scale landing zones DevOps and automation step by step](https://www.youtube.com/watch?v=wWLxxj-uMsY)

### Bicep

The [AzOps](https://github.com/Azure/AzOps) tooling supports deploying Bicep files at the [four Azure scopes](/azure/azure-resource-manager/management/overview#understand-scope). Its pull process only stores the scan of your Azure tenants resources in ARM templates that use JSON.

<!-- Leave us feedback via [GitHub issues on the AzOps repository](https://github.com/Azure/AzOps/issues) if you want to see something added to AzOps. -->

### Terraform

Terraform builds its own [state](https://www.terraform.io/docs/language/state/index.html) file to track and configure resources. If you already deployed enterprise-scale architecture to your Azure tenant, [import](https://www.terraform.io/docs/cli/import/index.html) each resource into the state file to learn what it manages as part of your Terraform code. Then you can deploy, manage, and operate your enterprise-scale deployment via Terraform.

Terraform import is currently done on a per resource basis and can be time consuming and complex to do at scale. It's often easier to delete and redeploy via Terraform than to import everything that's been deployed by the Azure landing zone accelerator portal-based experience. Most customers know from the start that they want to use Terraform to manage their Azure tenant, so this scenario is uncommon.

To deploy enterprise-scale architecture by using Terraform, you might want to use the Terraform module we provide. It deploys everything that the Azure landing zone accelerator portal-based experience does. The module, [Terraform Module for Cloud Adoption Framework Enterprise-scale](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/0.0.4-preview), is available from the Terraform Registry page.

To see a demo of AzOps being used, check out this YouTube video on the Microsoft DevRadio channel: [Terraform Module for Cloud Adoption Framework Enterprise-scale Walkthrough](https://www.youtube.com/watch?v=5pJxM1O4bys)

## How do we handle "dev/test/production" workload landing zones in enterprise-scale architecture?

>[!NOTE]
> This is for workload landing zones only. For testing and environment segregation for the enterprise-scale platform itself, review the [testing approach for enterprise-scale](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach).

If an application or service workload requires segregation of "dev/test/production" landing zones, use a separate subscription for each landing zone in the workload. It's important to work with the application or service workload owners to determine if separate subscriptions is the best way for them to build, manage, operate, and deliver their workload. It shouldn't be mandatory for all workloads.

A good example is a workload that uses [Azure App Service](/azure/app-service/overview). When you use Azure App Service, a [best practice](/azure/app-service/deploy-best-practices#use-deployment-slots) is to use [deployment slots](/azure/app-service/deploy-staging-slots) to help you manage changes and updates to the web app. However, this feature can only be used on the same app on an App Service Plan, which can only live within a single subscription. By mandating that your application or service workload owners use separate subscriptions for "dev/test/production", you might make their deployment lifecycle harder to manage. In this example, a single subscription for the application or service workload might be the best fit by using Azure role-based access control (RBAC) with [Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) at the Resource Group scope for increased security.

We suggest working with each application or service workload team (landing zone owners) to understand their requirements. Then you can provide subscriptions based on their requirements and plans. You might also decide to designate "product lines" for different types of workloads so that you can build subscription creation processes and tooling based on common requirements from application or service workload teams.

### What about our management group hierarchy?

With enterprise-scale architecture, you want to avoid complicated and volatile management group hierarchies that require constant amendment, don't scale efficiently, and don't add value. That's why in enterprise-scale architecture, management groups are workload archetype-aligned. For more information, see [Management group and subscription organization](/azure/cloud-adoption-framework/ready/enterprise-scale/management-group-and-subscription-organization).

*Archetype-aligned* means that management groups are only created for differing workload archetypes. For example, in the conceptual architecture, the "landing zones" management group has "corp" and "online" child management groups. These child management groups align with distinct archetype patterns for the workloads they hold, focused around hybrid connectivity (VPN/ExpressRoute) requirements (internal only vs. public-facing applications/services). However, all environments ("dev/test/production"), whether split across separate subscriptions or in a single subscription, are held within the same single management group ("Corp" or "Online") depending on its archetype and requirements.

The following equation helps to highlight why management groups per environment and/or per workload doesn't scale well: *(N apps) x (N+3) = Total management groups*

So, if you have 30 different workloads that each require a management group and a child management group for "dev/test/production", you're left with:

> **30** (no. of workloads) X **4** (no. of management groups per workload) = **120** management groups

#### Example of a suboptimal management group hierarchy

![An example of a sub-optimal management group hierarchy for enterprise-scale architecture when handling dev/test/production landing zones.](./media/eslz-dev-test-prod-bad.png)

To summarize, there should be no difference in policies applied between "dev/test/production" environments if you develop and build them to production standard from the start. There's little value in changing the configuration of a workload as it's promoted through the different environments. Constant change results in a poor development experience for landing zone users and owners. You might also consider using "sandbox" subscriptions for true development purposes where a less restricted environment is required, such as when an application or service workload team is trying out different Azure services to see what works best for their requirements. Once the services are known, a landing zone (in the correct workload archetype aligned management group in the "landing zones" management group hierarchy) can be provisioned for the team.

A common challenge to this approach is that you might need some policies to apply differently, depending on the environment. You have a few options:

- Use tags in your policy definitions to help filter and apply them to the correct environment.
    >[!IMPORTANT]
    > Tags can be changed by users with appropriate Azure RBAC permissions, so for security focused policies, we don't advise using tags in policies. Users might change the tags on a resource and potentially bypass or apply another policy definition to the resources.
- Apply policies at a subscription level as required, ideally during the subscription creation process (as mentioned earlier).
- For policies that are implemented to help control costs (for example, to restrict certain VM SKUs from being used), apply the policy definition at a subscription level where required or make costs the responsibility of the landing zone owners, enabling true autonomy. (See [Platform automation and DevOps](/azure/cloud-adoption-framework/ready/enterprise-scale/platform-automation-and-devops#define-central-and-federated-responsibilities).)
- Use sandbox subscriptions for development activities. Sandboxes have a less restrictive policy set.

#### Example of an optimal management group hierarchy aligned to enterprise-scale architecture

:::image type="content" source="./media/eslz-dev-test-prod-good.png" alt-text="Screenshot that shows an example of a optimal management group hierarchy for enterprise-scale architecture when handling development, test, and production landing zones":::

*Some management groups have been removed for illustration clarity purposes.*

>[!NOTE]
> We discussed this topic in our enterprise-scale community call in August 2021. You can find the recording on [YouTube.](https://youtu.be/Zx_gHevekm0?t=1954)

## Why are we asked to specify Azure regions during the Azure landing zone accelerator deployment and what are they used for?

When you deploy enterprise-scale architecture by using the Azure landing zone accelerator portal-based experience, select an Azure region to deploy into. The first tab, **Deployment location**, determines where the deployment data is stored. For more information, see [Tenant deployments with ARM templates](/azure/azure-resource-manager/templates/deploy-to-tenant#deployment-location-and-name).

Management groups, Azure Policies, and Azure RBAC are all stored at either a tenant or management group level within enterprise-scale architecture, so these resources aren't "deployed" to a particular region. The metadata regarding their deployment is stored in the region selected on the **Deployment location** tab.

The region selector on the **Deployment location** tab is also used to select which Azure region the following resources are deployed to (if enabled):

- Log Analytics workspace (including selected solutions)
- Automation account
- Resource groups (for the other resources)

If you deploy a networking topology on the **Network topology and connectivity** tab, you'll need to select an Azure region to deploy the networking resources to. This region can be different from the region selected on the **Deployment location** tab. Depending on the topology you select, the networking resources that you deploy might include:

- Azure Virtual WAN (including Virtual WAN Hub)
- Azure Virtual Network
- VPN gateway
- ExpressRoute gateway
- Azure Firewall
- Azure DDoS Standard protection plan
- Azure Private DNS zones for Azure Private Link
- Resource groups (for these resources)

## How do we enable more Azure regions when we use enterprise-scale architecture?

Enterprise-scale architecture itself is region-agnostic. However, you're asked to specify Azure regions to deploy enterprise-scale architecture. For more information, see [Why are we asked to specify Azure regions during the Azure landing zone accelerator deployment and what are they used for](#why-are-we-asked-to-specify-azure-regions-during-the-azure-landing-zone-accelerator-deployment-and-what-are-they-used-for).

You might want to expand into or use more Azure regions once you've completed the initial deployment of enterprise-scale architecture. For example, if you enable disaster recovery for your virtual machines by using Azure Site Recovery, you might want to replicate them to a different Azure region. To add Azure regions within enterprise-scale architecture, consider the following areas and recommendations:

| Area | Recommendation |
| ---- | -------------- |
| Management groups | No action necessary. Management groups aren't tied to a region. |
| Azure Policy | Make changes here if you assigned policies to deny resource deployment to all regions by specifying a list of "allowed" Azure regions. These assignments must be updated to allow resource deployments to the new region you want to enable. |
| Role-based access control | No action necessary. Azure RBAC isn't tied to a region. |
| Logging | No action necessary. Keep sending and storing logs in the central Log Analytics Workspace in the Management subscription. See the recommendations in the enterprise-scale critical design area for [Management and monitoring](/azure/cloud-adoption-framework/ready/enterprise-scale/management-and-monitoring). |
| Networking | If you deployed a networking topology, [Virtual WAN](/azure/cloud-adoption-framework/ready/azure-best-practices/virtual-wan-network-topology), or [traditional hub and spoke](/azure/cloud-adoption-framework/ready/azure-best-practices/traditional-azure-networking-topology), expand the networking to the new Azure region. Create another networking hub by deploying the required networking resources into the existing Connectivity subscription in the new Azure region. From a DNS perspective, you might also want to deploy forwarders, if used, into the new Azure region. Use forwarders for spoke VNETs in the new region for resolution. Remember that Azure DNS Zones are global resources and not tied to a single Azure region, so nothing needs to be done to them. |
| Identity | If you deployed Active Directory Domain Services or Azure Active Directory Domain Services into your Identity subscription/spoke, expand the service into the new Azure region. |

>[!NOTE]
> You might be able to use [Availability Zones](/azure/availability-zones/az-overview#availability-zones) instead of deploying into an additional Azure region. Review and assess whether this is possible based on your requirements and whether [Availability Zones are supported](/azure/availability-zones/az-region) in your region and for the services you want to use.
