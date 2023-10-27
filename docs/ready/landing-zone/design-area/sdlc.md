---
title: Software Development Lifecycle in Azure Landing Zones
description: Learn about managing your software development lifecycle in your Azure Landing Zone.
author: brsteph
ms.author: brsteph
ms.date: 10/10/2023
ms.topic: conceptual
ms.custom: internal
---

# Software Development Lifecycle in Azure Landing Zones

Development teams want limited interference with the ability to iterate quickly, while cloud governance and platform teams need to solve for organizational risk and security at scale.  Azure landing zone design principles guide customers to adopt policy-driven governance, which provides foundational guard rails while also delegating many controls to application teams who deploy and manage their own landing zone resources.

A key part of this approach is to provide sandbox resources for "semi-governed" resources that allow for application teams to explore technologies and capabilities.

This guide provides guidance for how cloud platform teams can architect their landing zones to support application team innovation, and how an organization can apply their software development lifecycle (SDLC) to this framework.  A key aspect of this is placing environment subscriptions in appropriate management groups.

![Diagram of an example of an optimal management group hierarchy for Azure landing zone architecture when handling development, test, and production landing zones.](./media/sub-organization.png)  

For discussion, this guide makes reference to the following phased environments:

Environment | Description | Management Group
---|---|---|
**Sandbox** |  Environment used for rapid innovation of prototypes, but not production-bound configurations. | _Sandbox_ Management Group
**Development** |  Environment used to build potential release candidates. | Archetype management group, like _Corp_ or _Online_
**Test** | Environment used to perform testing.  Can include unit testing, user acceptance testing, and quality assurance testing. | Archetype management group, like _Corp_ or _Online_
**Production** | Environment used to deliver value to workload customers. | Archetype management group, like _Corp_ or _Online_

However, any number and classification of environments can be used in practice.

> [!TIP]
> Check out the following YouTube video where we discuss this topic: [Azure Landing Zones - Handling Dev/Test/Prod for Application Workloads](https://youtu.be/8ECcvTxkrJA)

## Environments, Subscriptions, and Management Groups

> [!NOTE]
> This is for workload landing zones only. For testing and environment segregation for the Azure landing zone platform itself, review the [testing approach for enterprise-scale](../enterprise-scale/testing-approach.md) (Canary approach).

It is not necessary to create a high degree of Azure management isolation for different software development phased environments.  It is possible for a single subscription to contain all of the environments, assuming two things are true:

- The environments have the same teams assigned to functional roles, such as network operators.
- The environments can use the same policies.

It is recommended that workload owners should work with the cloud platform teams to determine if a division at the subscription level is needed.

If an application or service workload requires segregation between environments beyond what can be done in a single subscription, it is then recommended to use a separate subscription for each landing zone in the workload.

### Management Group Hierarchy

With Azure landing zone architecture, you want to avoid complicated and volatile management group hierarchies that require constant amendment, don't scale efficiently, and don't add value. That's why in Azure landing zone architecture, management groups are workload archetype-aligned. For more information, see [Management group and subscription organization](../landing-zone/design-area/resource-org.md).

_Archetype-aligned_ means that management groups are only created for differing workload archetypes. For example, in the conceptual architecture, the "landing zones" management group has "corp" and "online" child management groups. These child management groups align with distinct archetype patterns for the workloads they hold, focused around hybrid connectivity (VPN/ExpressRoute) requirements (internal only vs. public-facing applications/services).

Different application environments, with the exception of sandbox environments (see below), should use the same archetype for deployment. Even if the environments are split across separate subscriptions, they are held within the same single management group ("Corp" or "Online") depending on its archetype and requirements.

[Sandbox subscriptions](../considerations/sandbox-environments.md) can be used for unstructured development, such as personal labs or for when an archetype for the workload has not been selected.  This is often used when an application or service workload team is trying out different Azure services to see what works best for their requirements. Once the services are known, a landing zone (in the correct workload archetype aligned management group in the "landing zones" management group hierarchy) can be provisioned for the team.

These sandbox environments can be tied to specific applications, or can be used for individual developers to lab and experiment.

You can read more about designing [management groups](./design-area/resource-org-management-groups.md) in the [Resource organization design area](./design-area/resource-org.md) for Azure landing zones.

#### Challenges with having Environment Based Management Groups

Building management groups for for environments within the archetypes creates additional management overhead, while providing very limited value.

![Diagram of an example of an optimal management group hierarchy for Azure landing zone architecture when handling development, test, and production landing zones.](./media/sub-organization.png)  

The _Landing Zone_ management group should have universal polices that enforce guardrails for both Corp and Online. Corp and Online have unique polices to enforce company guidelines around public and private facing workloads.

There's little value in changing the configuration of a workload as it's promoted through the different environments. Constant change results in a poor development experience for landing zone users and owners.  Deployment configuration and requirements should remain consistent throughout promotion of code through environments.

> [!NOTE]
> The following equation helps to highlight why management groups per environment and/or per workload doesn't scale well: _N workloads x Z management groups  = total management groups_.
>
>If you have 30 different workloads that each require a management group and a child management group for "dev/test/production", you're left with:
>
> N = number of workloads/apps = 30
>
> Z = number of management groups for workload and environments (1 per workload + 3 for envs) = 4
>
> N (30) x Z (4) = 120 total management groups

Sometimes, you might need some policies to apply differently, depending on the environment.  For example, you might require backup configurations for production, but not for development.

 You have a few options to address this at scale:

- Use tags in your policy definitions to help filter and apply them to the correct environment.

> [!IMPORTANT]
> Tags can be changed by users with appropriate Azure RBAC permissions, so for security focused policies, we don't advise using tags in policies. Users might change the tags on a resource and potentially bypass or apply another policy definition to the resources.

- Apply policies at a subscription level as required, ideally during the subscription creation process (as mentioned earlier).
- For policies that are implemented to help control costs (for example, to restrict certain VM SKUs from being used), apply the policy definition at a subscription level where required or make costs the responsibility of the landing zone owners, enabling true autonomy. (See [Platform automation and DevOps](../landing-zone/design-area/platform-automation-devops.md).)
- Use sandbox subscriptions for development activities. Sandboxes have a less restrictive policy set.

### Scenario: Application Services

A good example is a workload that uses [Azure App Service](/azure/app-service/overview). When you use Azure App Service, a [best practice](/azure/app-service/deploy-best-practices#use-deployment-slots) is to use [deployment slots](/azure/app-service/deploy-staging-slots) to help you manage changes and updates to the web app. However, this feature can only be used on the same app on an App Service Plan, which can only live within a single subscription. By mandating that your application or service workload owners use separate subscriptions for "dev/test/production", you might make their deployment lifecycle harder to manage. In this example, a single subscription for the application or service workload might be the best fit by using Azure role-based access control (RBAC) with [Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) at the Resource Group scope for increased security.

We suggest working with each application or service workload team (landing zone owners) to understand their requirements. Then you can provide subscriptions based on their requirements and plans. You might also decide to designate "product lines" for different types of workloads so that you can build subscription creation processes and tooling based on common requirements from application or service workload teams.

## Next steps

Continue to learn about development and testing in Azure Landing Zones, and how management groups play a part.

- Review the [testing approach for enterprise-scale](../enterprise-scale/testing-approach.md)
- Review the [Resource organization design area](./design-area/resource-org.md) to make decisions for management group and subscription creation
- Review how you can use [Sandbox subscriptions](../considerations/sandbox-environments.md) isolated development
