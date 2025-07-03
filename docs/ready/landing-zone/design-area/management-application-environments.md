---
title: Manage application development environments in Azure landing zones
description: Learn how to manage your organization's application environments in Azure landing zones by placing subscriptions in the appropriate management groups.
author: brsteph
ms.author: pnp
ms.date: 02/27/2025
ms.topic: conceptual
ms.custom: internal
---

# Manage application development environments in Azure landing zones

This article describes how cloud platform teams can implement guardrails to manage application environments in Azure landing zones. It also explains how to align various application development environments with their framework. A key aspect in creating the proper environment is placing subscriptions in the appropriate management groups.

<!-- docutune:ignoredCasing "policy-driven governance" -->

## Set the foundation

Development teams require the ability to iterate quickly, and cloud governance and platform teams need to manage organizational risk, compliance, and security at scale. You can properly manage application environments by focusing on two key [Azure landing zone design principles](../design-principles.md): policy-driven governance and subscription democratization. These principles provide foundational guardrails and describe how to delegate controls to application teams. The application teams use [Azure Well-Architected Framework guidance](/azure/well-architected) to design their workload. They deploy and manage their own landing zone resources, and the platform team controls the resources by assigning Azure policies.

It's important to provide sandbox resources for *semi-governed* resources, so application teams can experiment with technologies and capabilities.

When application owners use [subscription vending](subscription-vending.md) or other subscription creation processes, they must know how to request subscriptions for multiple development environments.

This article describes the Azure landing zone, including the management groups, policies, and shared platform architecture, and the workload or application landing zone.

> [!NOTE]
> The guidance in this article is only for workload or application landing zones. For testing and environment segregation for the Azure landing zone platform itself, see [Testing approach for Azure landing zones](../../enterprise-scale/testing-approach.md), which describes the canary approach.

:::image type="content" source="./media/sub-organization.png" alt-text="Diagram that shows an example of an optimal management group hierarchy." lightbox="./media/sub-organization.png":::

In practice, you can use any number and type of phased environment. This article references the following phased environments.

Environment | Description | Management group
---|---|---
**Sandbox** |  The environment that's used for rapid innovation of prototypes but not production-bound configurations | Sandbox management group
**Development** |  The environment that's used to build potential release candidates | Archetype management group, like *corp* or *online*
**Test** | The environment that's used to perform testing, including unit testing, user acceptance testing, and quality assurance testing | Archetype management group, like *corp* or *online*
**Production** | The environment that's used to deliver value to customers | Archetype management group, like *corp* or *online*

For more information, see the videos [Handling development, testing, and production environments for application workloads](https://youtu.be/8ECcvTxkrJA) and [How many subscriptions should I use in Azure?](https://youtu.be/R-5oeguxFpo)

## Environments, subscriptions, and management groups

As a prerequisite to this section, see [Resource organization design area](resource-org.md).

You must properly organize your subscriptions when you adopt Azure landing zone practices. Ideally, each application environment should have its own subscription. This method provides security and policy controls that keep the environments isolated. It contains potential problems to one environment.

Separate subscriptions have the same policies on the archetype level. If needed, application owners can assign subscription-specific policies to enforce application and environment-specific behavior.

Some application architectures require that services are shared among environments. If that's the case, you can use a single subscription for multiple environments. We recommend that workload owners work with cloud platform teams to determine if a single subscription for multiple environments is needed.

Use a single subscription for multiple application environments if:

- The environments can't be isolated in their own subscriptions.

- The environments have the same teams assigned to functional roles, such as network operators.
- The environments can use the same policies.

If an application or service workload needs to be in a single subscription, and you need to make changes to the policies that apply to each environment, you can:

- Create a new *archetype-aligned* management group beneath the landing zones management group. For more information, see [Management group hierarchy](#management-group-hierarchy) in this article.

- Use sandbox subscriptions for development activities. Sandboxes have a less restrictive policy set.
- Use policies that are applied at the subscription level instead of the management group level. You can add tags in the policy definitions to help filter and apply policies to the correct environment. You can also assign policies to or exclude them from specific resource groups.
  
  You can assign policies during the subscription creation process as part of [subscription vending](subscription-vending.md).
  
  For policies that you implement to help control costs, apply the policy definition at a subscription level where required. Or you can make the landing zone owner responsible for costs, which provides true autonomy. For more information, see [Platform automation and DevOps](platform-automation-devops.md).

> [!WARNING]
> Unlike policies and controls at the management group level, subscription-based policies and tags can be changed by individuals with elevated permissions to the subscription. Administrators with appropriate roles can bypass these controls by excluding policies, modifying policies, or changing the tags on resources.
>
>As a result, you shouldn't apply tags in the definitions of security-focused policies. In addition, don't assign permissions as *always active* for the following actions:
>
>- `Microsoft.Authorization/policyAssignments/*`
>- `Microsoft.Authorization/policyDefinitions/*`
>- `Microsoft.Authorization/policyExemptions/*`
>- `Microsoft.Authorization/policySetDefinitions/*`
>
>You can control these actions by using Privileged Identity Management (PIM).

### Management group hierarchy

Avoid complicated management group hierarchies. They can require frequent amendment, scale inefficiently, and lack value. To avoid these potential problems, Azure landing zone management groups are workload archetype-aligned. For more information, see [Management group and subscription organization](resource-org.md).

*Archetype-aligned* means that management groups are only created for specific workload archetypes. For example, in the conceptual architecture, the *landing zones* management group has *corp* and *online* child management groups. These child management groups align with distinct archetype patterns for the workloads that they hold. The child management groups focus on hybrid connectivity (VPN/Azure ExpressRoute) requirements, such as internal only versus public-facing applications and services.

Excluding sandbox environments, various application environments should use the same archetype for deployment. Even if environments are divided across several subscriptions, they're held within the same single management group (_corp_ or *online*), based on the management group archetype and the requirements.

You can use [sandbox subscriptions](../../considerations/sandbox-environments.md) for unstructured development, such as personal labs or for a workload that doesn't have an archetype. An application or service workload team uses a sandbox management group to test various Azure services to determine what works best for their requirements. After they decide on services, they can provision a landing zone (in the correct workload archetype-aligned management group in the *landing zones* management group hierarchy) for the team.

The sandbox environments can be used for specific applications, or a workload team can use them for experimentation.

For more information, see:

- [Management groups](resource-org-management-groups.md).
- [Resource organization design area](resource-org.md).
- [Tailor the Azure landing zone architecture to meet requirements](../../landing-zone/tailoring-alz.md).

#### Environment-based management group challenges

Management groups for environments within archetypes can add management overhead and provide minimal value.

:::image type="content" source="./media/management-groups.png" alt-text="Diagram that shows an example of an optimal management group hierarchy for the Azure landing zone architecture." lightbox="./media/management-groups.png":::

The *landing zones* management group should have universal policies that enforce guardrails for both *corp* and *online* child management groups. *Corp* and *online* have unique policies that enforce company guidelines related to public and private-facing workloads.

Many organizations create separate management groups for workload software development lifecycle (SDLC) environments to assign environmental policies and controls. In practice, this method creates more challenges for workload teams than it solves. SDLC environments shouldn't have different policies, so we don't recommend separate management groups.

:::image type="content" source="./media/mg-environment-antipattern.svg" alt-text="Diagram that shows an example of a suboptimal management group hierarchy, with distinct management groups for different environments." lightbox="./media/mg-environment-antipattern.svg":::

Application owners can change the topology or resource configuration of a workload to align to policies in multiple SDLC environments that it's promoted through. This method increases risk. Rules that are specific to each environment can result in a poor development experience for developer and quality assurance teams. Problems can also arise if an application has one set of guardrail policies that work in one environment, and the application is exposed to a different set of policies later in its promotion cycle. You might have to make adjustments to an application if controls change.

To prevent this extra work, create consistent policies throughout the promotion of code in SDLC environments. You shouldn't create policies for each environment, but instead provide a consistent set for all development environments, excluding sandbox environments.

For example, imagine an organization defines a policy that requires storage accounts to be configured with specific firewall rules to prevent ingress from public networks. Instead, the storage accounts use private endpoints inside of the Azure landing zone networks for communication. If the development environment doesn't have such a policy, testing the workload doesn't find a misconfiguration of the storage account that allows public access. The test deployments work in the development environment and are iterated on. When the solution is promoted to another environment that has the storage account policy, the deployment fails because of the enforced policy.

As a result, the application development team must rework their deployment and architecture, after already investing significant effort. This example demonstrates how different policies in various environments can create problems.

> [!NOTE]
> The following equation demonstrates why a separate management group for each environment or workload doesn't scale well: *N workloads x Z management groups = total management groups*.
>
>If an organization has 30 workloads that each require a management group and a child management group for development, testing, and production environments, the organization is left with:
>
> N = the number of workloads/apps = 30
>
> Z = the number of management groups for the workload and environments (1 for the workload + 3 for the environments) = 4
>
> N (30) x Z (4) = 120 total management groups

Application owners might need policies to apply differently to multiple environments. For example, application owners might require backup configurations for production environments but not for other environments.

Some policies can be enabled as audit policies at the management group level. Application teams determine how to implement the control. This method doesn't prevent deployments, but it creates awareness and enables application teams to manage their unique needs. They can then create sublevel policies or incorporate these requirements into their infrastructure as code (IaC) deployment modules.

In this shared responsibility model, the platform team audits practices, and the application team manages the implementation. This model can improve the agility of deployments.

Platform operators must work with each application or service workload team (landing zone owners) to understand their requirements. The platform operators can provide subscriptions based on the application requirements and plans. The platform operators might also decide to designate *product lines* for various types of workloads so that they can build subscription creation processes and tooling based on common requirements from application or service workload teams.

### Scenario: Virtual machine (VM) based workloads

Early workloads in Azure landing zones are often made up of Azure VMs. You might deploy these workloads in Azure or migrate them from existing datacenters.

Instead of deploying VMs to multiple environments in a single subscription, you can:

- Establish subscriptions for each application environment, and place them all in the same archetype management group.

- Deploy a virtual network for each application environment in the appropriate subscription. You can determine the virtual network size based on the size of the application environment.
- Deploy the VMs to their appropriate subscription. VMs can use different SKUs and different availability configurations for each environment, if appropriate.

Various application environment resources are protected by different access controls. As a result, when application developers set up deployment pipelines, each pipeline's identity can be limited to the environment. This configuration helps to protect the environments from accidental deployments.

### Scenario: Azure App Service

A workload with environmental subscriptions that use [App Service](/azure/app-service/overview) can create challenges. For application developers, an [App Service best practice](/azure/app-service/deploy-best-practices#use-deployment-slots) is to use [deployment slots](/azure/app-service/deploy-staging-slots) to help manage changes and updates to a web app.

However, this feature can only be used with the app that's on the App Service plan, which can only live within a single subscription. If the platform operators mandate that the application owners use separate subscriptions for development, testing, and production environments, the application deployment lifecycle might be more difficult to manage.

For this example, the best option is a single subscription for the application or service workload. Application owners can use Azure role-based access control (RBAC) with [PIM](/entra/id-governance/privileged-identity-management/pim-configure) at the resource group level for increased security.

## Next steps

- [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)
- [Testing approach for Azure landing zones](../../enterprise-scale/testing-approach.md)
- [Landing zone sandbox environments](../../considerations/sandbox-environments.md)
