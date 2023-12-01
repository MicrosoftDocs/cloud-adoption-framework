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

Development teams want limited interference with the ability to iterate quickly, while cloud governance and platform teams need to solve for organizational risk, compliance, and security at scale. Azure landing zone's [design principles](/azure/cloud-adoption-framework/ready/landing-zone/design-principles) guide customers to adopt policy-driven governance and Subscription democratization as two key principles. These provide foundational guard rails, while also delegating many controls to application teams. These applications teams design their workload using guidance from the [Azure Well-Architected Framework](/azure/well-architected/), then deploy and manage their own landing zone resources; whilst being controlled by Azure policies assigned by the platform team.

A key part of this approach is to provide sandbox resources for "semi-governed" resources that allow for application teams to explore technologies and capabilities.

This article provides guidance for how cloud platform teams can provide guardrails to manage application environments in Azure.  The article gives guidance on how an organization can fit different application development environments into this framework.  A key aspect is placing environment subscriptions in appropriate management groups.

When application owners use [Subscription Vending](subscription-vending.md) or other subscription creation processes, it is important for there to be clarity about how to request subscriptions for multiple development environments.

In this guide, we talk both about the Azure landing zone - the management groups, policies, and shared platform architecture - and the workload or application landing zone.

> [!NOTE]
> This is for workload landing zones only. For testing and environment segregation for the Azure landing zone platform itself, review the [testing approach for enterprise-scale](../../enterprise-scale/testing-approach.md) (Canary approach).

![Diagram of an example of an optimal management group hierarchy.](./media/sub-organization.png)  

For discussion, this guide makes reference to the following phased environments:

Environment | Description | Management Group
---|---|---|
**Sandbox** |  Environment used for rapid innovation of prototypes, but not production-bound configurations. | _Sandbox_ Management Group
**Development** |  Environment used to build potential release candidates. | Archetype management group, like _Corp_ or _Online_
**Test** | Environment used to perform testing.  Can include unit testing, user acceptance testing, and quality assurance testing. | Archetype management group, like _Corp_ or _Online_
**Production** | Environment used to deliver value to workload customers. | Archetype management group, like _Corp_ or _Online_

However, any number and classification of environments can be used in practice.

> [!TIP]
> Check out the following YouTube videos where we discuss this topic: [Azure Landing Zones - Handling Dev/Test/Prod for Application Workloads](https://youtu.be/8ECcvTxkrJA) & [Azure Landing Zones - How many subscriptions should I use in Azure?](https://youtu.be/R-5oeguxFpo)

## Environments, Subscriptions, and Management Groups

Ideally, each application environment should have its own subscription.  This provides security and policy controls to keep the environments isolated, and to prevent an issue in one environment from creating issues in others.

These separate subscriptions would still have the same policies between them from the archetype level.  If needed, subscription specific policies can be used by the application owners to enforce application and environment specific behavior.

Some applications architectures require services to be shared between environments.  If that is the case, you can use a single subscription for multiple environments.  It is recommended that workload owners should work with the cloud platform teams to determine if a single subscription for multiple environments is needed, and not assume.

Using a single subscription for multiple application environments works best when the following things are true:

- There is a clear reason for why the environments cannot be isolated in their own subscriptions.
- The environments have the same teams assigned to functional roles, such as network operators.
- The environments can use the same policies.

If an application or service workload needs to be in a single subscription,  and you need to make changes to the policies that apply to each environment, then there are a few options available.

- Consider if a new _archetype-aligned_ management group needs to be created beneath the landing zones management group.  You can see [Management Group Hierarchy](#management-group-hierarchy) for more information on this.
- Use sandbox subscriptions for development activities. Sandboxes have a less restrictive policy set.
- Use policies applied specifically at the subscription level instead of the management group.  These policies can use tags in their policy definitions to help filter and apply them to the correct environment.  They can also be assigned to or excluded from specific resource groups.
  - You can assign these policies during the subscription creation process as part of [Subscription Vending](subscription-vending.md).
  - For policies that are implemented to help control costs, apply the policy definition at a subscription level where required or make costs the responsibility of the landing zone owners, enabling true autonomy. (See [Platform automation and DevOps](platform-automation-devops.md).)

> [!WARNING]
> Unlike policies and controls at the management group level, subscription based policies and tags can be changed by individuals with elevated permissions to the subscription.  This means that administrators with appropriate roles can act to bypass these controls if used, by excluding policies, modifying them, or changing the tags on resources.  As a result, of policies are security focused, they should not use tags for the definitions.  In addition, permissions to the following actions should not be assigned as always active, and should be controlled through Privileged Identity Management: `Microsoft.Authorization/policyAssignments/*`, `Microsoft.Authorization/policyDefinitions/*`, `Microsoft.Authorization/policyExemptions/*`, `Microsoft.Authorization/policySetDefinitions/*`

### Management Group Hierarchy

Avoid complicated and volatile management group hierarchies as they require constant amendment, don't scale efficiently, and don't add value. These issues are why Azure landing zone management groups are workload archetype-aligned. For more information, see [Management group and subscription organization](resource-org.md).

_Archetype-aligned_ means that management groups are only created for differing workload archetypes. For example, in the conceptual architecture, the "landing zones" management group has "corp" and "online" child management groups. These child management groups align with distinct archetype patterns for the workloads they hold, focused around hybrid connectivity (VPN/ExpressRoute) requirements (internal only vs. public-facing applications/services).

Different application environments, except for sandbox environments, should use the same archetype for deployment. Even if the environments are split across separate subscriptions, they are held within the same single management group ("Corp" or "Online") depending on management group archetype and requirements.

[Sandbox subscriptions](../../considerations/sandbox-environments.md) can be used for unstructured development, such as personal labs or for when an archetype for the workload is not decided.  The Sandbox management group is often used when an application or service workload team is trying out different Azure services to see what works best for their requirements. Once the services are known, a landing zone (in the correct workload archetype aligned management group in the "landing zones" management group hierarchy) can be provisioned for the team.

These sandbox environments can be tied to specific applications, or a workload team can use them for experimentation.

Read more about designing [management groups](resource-org-management-groups.md) in the [Resource organization design area](resource-org.md) for Azure landing zones and also review [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz).

#### Challenges with having environment based management groups

Building management groups for for environments within the archetypes creates more management overhead, while providing little value.

![Diagram of an example of an optimal management group hierarchy for Azure landing zone architecture.](./media/management-groups.png)  

The _Landing Zone_ management group should have universal polices that enforce guardrails for both Corp and Online. Corp and Online have unique polices to enforce company guidelines around public and private facing workloads.

Many organizations think that they need to create management groups for different environments, and assign environmental policies and controls.  In practice, this creates more challenges than it solves.  Policies should not differ between environments, and so separate management groups for environments is not needed.

For application owners, there's little value in changing the configuration of a workload as it's promoted through the different environments. Constant change results in a poor development experience for developers.  If an application is built with one set of guardrail policies, but has a different one later in its promotion cycle, this can create issues.  Applications might have to be reworked due to changing controls.

To prevent this rework, deployment configuration and requirements should remain consistent throughout promotion of code through environments.  Platform teams should not build consistent policy guardrails, but instead provide a consistent set for all non-Sandbox development environments.

For example, it is common that organizations define a requirement that storage accounts need to be configured with specific firewall rules to prevent ingress from public networks, and instead use private endpoints inside of the Azure landing zone networks for communication.  This requirement is then enforced with a policy.

If such a policy doesn't exist for the development environment, then the deployment experience will be different.  Developers might build deployments that assume public access to the storage account is possible.  These deployments will work in the development environment, and so will be iterated on.  When the solution is promoted to another environment, the deployment would fail because of the enforced policy.

As a result, the application development team would need to go back and rework their deployment and architecture, after already having invested significant effort.  This is one example of how having different policies between environments can create issues.

> [!NOTE]
> The following equation demonstrates why management groups per environment and/or per workload don't scale well: _N workloads x Z management groups  = total management groups_.
>
>If an organization have 30 different workloads that each require a management group and a child management group for "dev/test/production", the organization is left with:
>
> N = number of workloads/apps = 30
>
> Z = number of management groups for workload and environments (1 per workload + 3 for envs) = 4
>
> N (30) x Z (4) = 120 total management groups

Sometimes, individual application owners might need some policies to apply differently to different environments.  For example, application owners might require backup configurations for production, but do not require it for other environments.

Some policies can be enabled as audit policies at the management group level, with individual application teams confirming how to address.  This doesn't prevent deployments, but it does create awareness and allow for application teams to manage their unique needs.  They can then create sub level policies or incorporate these requirements into their infrastructure as code deployment modules.

This type of shared responsibility model with the platform team auditing practices but the application team owning the implementation can help improve the agility of deployments.

Platform operators must work with each application or service workload team (landing zone owners) to understand their requirements. Then the platform operators can provide subscriptions based on the application requirements and plans. The platform operators might also decide to designate "product lines" for different types of workloads so that they can build subscription creation processes and tooling based on common requirements from application or service workload teams.

### Scenario: Application Services

A good example is a workload that uses [Azure App Service](/azure/app-service/overview). When application developers use Azure App Service, a [best practice](/azure/app-service/deploy-best-practices#use-deployment-slots) is to use [deployment slots](/azure/app-service/deploy-staging-slots) to help them manage changes and updates to the web app.

However, this feature can only be used on the same app on an App Service Plan, which can only live within a single subscription. If the platform operators mandate that the application owners use separate subscriptions for "dev/test/production", the platform operators might make the application  deployment lifecycle harder to manage.

In this example, a single subscription for the application or service workload might be the best fit by using Azure role-based access control (RBAC) with [Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) at the Resource Group scope for increased security.

## Next steps

Continue to learn about development and testing in Azure Landing Zones, and how management groups play a part.

- Review the [testing approach for enterprise-scale](../../enterprise-scale/testing-approach.md)
- Review [Tailor the Azure landing zone architecture to meet requirements](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)
- Review the [Resource organization design area](resource-org.md) to make decisions for management group and subscription creation
- Review how to use [Sandbox subscriptions](../../considerations/sandbox-environments.md) isolated development
