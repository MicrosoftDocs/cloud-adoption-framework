---
title: Application development environments in Azure landing zones
description: Learn about managing your organization's application environments in Azure landing zone.
author: brsteph
ms.author: brsteph
ms.date: 10/10/2023
ms.topic: conceptual
ms.custom: internal
---

# Application development environments in Azure landing zones

Development teams want limited interference with the ability to iterate quickly, while cloud governance and platform teams need to solve for organizational risk, compliance, and security at scale. Azure landing zone's [design principles](/../design-principles) present two key principles, policy-driven governance and subscription democratization. These principles provide foundational guardrails and describe how to delegate controls to application teams. The applications teams use [Azure Well-Architected Framework](/azure/well-architected) guidance to design their workload. They deploy and manage their own landing zone resources, and the platform team controls the resources?? by using Azure policies.

A key part of this approach is to provide sandbox resources for _semi-governed_ resources, so application teams can explore technologies and capabilities.

This article describes how cloud platform teams can provide guardrails to manage application environments in Azure. It also explains how an organization fits various application development environments into this framework. A key aspect is placing environment subscriptions in appropriate management groups.

When application owners use [subscription vending](subscription-vending.md) or other subscription creation processes, they must know how to request subscriptions for multiple development environments.

This article describes the Azure landing zone, including the management groups, policies, and shared platform architecture, and the workload or application landing zone.

> [!NOTE]
> This guidance is only for workload landing zones. For testing and environment segregation for the Azure landing zone platform itself, see [Testing approach for Azure landing zones](../../enterprise-scale/testing-approach.md), which describes the canary approach.

![Diagram that shows an example of an optimal management group hierarchy.](./media/sub-organization.png)  

This article references the following phased environments:

Environment | Description | Management group
---|---|---|
**Sandbox** |  The environment that's used for rapid innovation of prototypes but not production-bound configurations. | _Sandbox_ management group.
**Development** |  The environment that's used to build potential release candidates. | Archetype management group, like _Corp_ or _Online_.
**Test** | The environment that's used to perform testing, including unit testing, user acceptance testing, and quality assurance testing. | Archetype management group, like _Corp_ or _Online_.
**Production** | The environment that's used to deliver value to workload customers. | Archetype management group, like _Corp_ or _Online_.

However, any number and classification of environments can be used in practice.

> [!TIP]
> For more information, see the videos [Handling dev/test/prod for application workloads](https://youtu.be/8ECcvTxkrJA) and [How many subscriptions should I use in Azure?](https://youtu.be/R-5oeguxFpo)

## Environments, subscriptions, and management groups

It's critical that you properly organize your subscriptions when you adopt Azure landing zone practices. As a prerequisite to this section, see [Resource organization design area](resource-org.md).

Ideally, each application environment should have its own subscription.  This method provides security and policy controls that keep the environments isolated, and it keeps potential problems contained to one environment.

Separate subscriptions have the same policies on the archetype level. If needed, application owners can assign subscription-specific policies to enforce application and environment-specific behavior.

Some applications architectures require that services are shared among environments. If that's the case, you can use a single subscription for multiple environments. It's recommended that workload owners work with cloud platform teams to determine if a single subscription for multiple environments is needed.

Use a single subscription for multiple application environments if:

- The environments can't be isolated in their own subscriptions.

- The environments have the same teams assigned to functional roles, such as network operators.
- The environments can use the same policies.

If an application or service workload needs to be in a single subscription, and you need to make changes to the policies that apply to each environment, you can:

- Create a new _archetype-aligned_ management group beneath the landing zones management group. For more information, see the section in this article, [Management group hierarchy](#management-group-hierarchy).

- Use sandbox subscriptions for development activities. Sandboxes have a less-restrictive policy set.
- Use policies that are applied at the subscription level instead of the management group level. You can add tags in the policy definitions to help filter and apply policies to the correct environment. You can also assign policies to or exclude them from specific resource groups.
  - You can assign policies during the subscription creation process as part of [subscription vending](subscription-vending.md).
  
  - For policies that you implement to help control costs, apply the policy definition at a subscription level where required. Or you can require that the landing zone owner be responsible for costs, which provides true autonomy. For more information, see [Platform automation and DevOps](platform-automation-devops.md).

> [!WARNING]
> Unlike policies and controls at the management group level, subscription-based policies and tags can be changed by individuals with elevated permissions to the subscription. So, administrators with appropriate roles can bypass these controls by excluding policies, modifying policies, or changing the tags on resources.
>
>As a result, you shouldn't apply tags in the definitions of policies that are security-focused. In addition, don't assign permissions as _always active_ for the following actions:
>
>- `Microsoft.Authorization/policyAssignments/*`
>- `Microsoft.Authorization/policyDefinitions/*`
>- `Microsoft.Authorization/policyExemptions/*`
>- `Microsoft.Authorization/policySetDefinitions/*`
>
>You can control these actions by using privileged identity management.

### Management group hierarchy

Avoid complicated management group hierarchies. They require frequent amendment, don't scale efficiently, and don't add value. To avoid these problems, Azure landing zone management groups are workload archetype-aligned. For more information, see [Management group and subscription organization](resource-org.md).

_Archetype-aligned_ means that management groups are only created for specific workload archetypes. For example, in the conceptual architecture, the _landing zones_ management group has _corp_ and _online_ child management groups. These child management groups align with distinct archetype patterns for the workloads that they hold. The child management groups focus on hybrid connectivity (VPN/Azure ExpressRoute) requirements, such as internal only versus public-facing applications and services.

Excluding sandbox environments, various application environments should use the same archetype for deployment. Even if environments are divided across several subscriptions, they're held within the same management group (_Corp_ or _Online_), depending on the management group archetype and the requirements.

You can use [sandbox subscriptions](../../considerations/sandbox-environments.md) for unstructured development, such as personal labs or for a workload that doesn't have an archetype. An application or service workload team uses a sandbox management group to test various Azure services to determine what works best for their requirements. After they decide on services, they can provision a landing zone (in the correct workload archetype-aligned management group in the _landing zones_ management group hierarchy) for the team.

The sandbox environments can be used for specific applications, or a workload team can use them for experimentation.

For more information, see:

- [Management groups](resource-org-management-groups.md).
- [Resource organization design area](resource-org.md).
- [Tailor the Azure landing zone architecture to meet requirements](../../landing-zone/tailoring-alz.md).

#### Environment-based management group challenges

Management groups for environments within archetypes can add management overhead and provide minimal value.

:::image type="content" source="./media/management-groups.png" alt-text="Diagram of an example of an optimal management group hierarchy for Azure landing zone architecture." lightbox="./media/management-groups.png":::

The _landing zone_ management group should have universal polices that enforce guardrails for both Corp and Online. Corp and Online have unique polices that enforce company guidelines related to public and private-facing workloads.

Many organizations create separate management groups for workload Software Development Lifecycle (SDLC) environments to assign environmental policies and controls. In practice, this method creates more challenges for workload teams than it solves. SDLC environments shouldn't have different policies, so we don't recommend separate management groups.

Application owners can change the topology or resource configuration of a workload to align to policies in various SDLC environments that it goes through. This method increases risk. Rules that are specific to each environment can result in a poor development experience for developer and quality assurance teams. Problems can also arise if an application has one set of guardrail policies that work in one environment, and the application is exposed to a different set of policies later in its promotion cycle. You might have to make adjustments to an application if controls change.

To prevent this extra work, create consistent policies throughout the promotion of code in SDLC environments. You shouldn't create policies for each environment, but instead provide a consistent set for all non-sandbox development environments.

For example, imagine an organization defines a policy that storage accounts need to be configured with specific firewall rules to prevent ingress from public networks. Instead, the storage accounts use private endpoints inside of the Azure landing zone networks for communication. If the development environment doesn't have such a policy, testing the workload doesn't find a misconfiguration of the storage account that allows public access. The test deployments work in the development environment and are iterated on. When the solution is promoted to another environment that has the storage account policy, the deployment fails because of the enforced policy.

As a result, the application development team must rework their deployment and architecture, after already investing significant effort. This is one example of how different policies in various environments can create issues.

> [!NOTE]
> The following equation demonstrates why a separate management group for each environment and/or workload doesn't scale well: _N workloads x Z management groups = total management groups_.
>
>If an organization has 30 workloads that each require a management group and a child management group for _dev/test/production_, the organization is left with:
>
> N = number of workloads/apps = 30
>
> Z = number of management groups for the workload and environments (1 for the workload + 3 for the environments) = 4
>
> N (30) x Z (4) = 120 total management groups

Sometimes, application owners might need policies to apply differently to multiple environments. For example, application owners might require backup configurations for production environments but not for other environments.

Some policies can be enabled as audit policies at the management group level, with individual application teams confirming how to address. This doesn't prevent deployments, but it does create awareness and allow for application teams to manage their unique needs. They can then create sub-level policies or incorporate these requirements into their infrastructure as code deployment modules.

In this shared responsibility model, the platform team audits practices, and the application team owns the implementation. This model can help improve the agility of deployments.

Platform operators must work with each application or service workload team (landing zone owners) to understand their requirements. Then the platform operators can provide subscriptions based on the application requirements and plans. The platform operators might also decide to designate _product lines_ for different types of workloads so that they can build subscription creation processes and tooling based on common requirements from application or service workload teams.

### Scenario: Virtual machine (VM) based workloads

Workloads made up of Azure VMs are often used as early workloads in Azure landing zones. You might deploy these workloads in Azure or migrate them from existing datacenters.

Instead of deploying VMs to multiple environments in a single subscription, you can:

- Establish subscriptions for each application environment, and place them all in the same archetype management group.

- Deploy a virtual network for each application environment in the appropriate subscription.  Virtual network size can be based on the size of the application environment.
- Deploy the virtual machines to their appropriate subscription.  Virtual machines can use different skus and different availability configurations between environment, if appropriate.

The different application environment resources would be protected by different access controls.  As a result, when the application developers set up deployment pipelines, each pipeline's identity can be limited to the environment.  This better protects the environments from accidental deployments.

### Scenario: Application Services

A good example is a workload that has challenges with environmental subscriptions that uses [Azure App Service](/azure/app-service/overview). When application developers use Azure App Service, a [best practice](/azure/app-service/deploy-best-practices#use-deployment-slots) is to use [deployment slots](/azure/app-service/deploy-staging-slots) to help them manage changes and updates to the web app.

However, this feature can only be used on the same app on an App Service Plan, which can only live within a single subscription. If the platform operators mandate that the application owners use separate subscriptions for "dev/test/production", the platform operators might make the application  deployment lifecycle harder to manage.

In this example, a single subscription for the application or service workload might be the best fit by using Azure role-based access control (RBAC) with [Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) at the Resource Group scope for increased security.

## Next steps

Continue to explore the resource organization design area.

- Review [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)

Continue to learn about development and testing in Azure Landing Zones, and how management groups play a part.

- Review the [testing approach for enterprise-scale](../../enterprise-scale/testing-approach.md)
- Review how to use [Sandbox subscriptions](../../considerations/sandbox-environments.md) isolated development
