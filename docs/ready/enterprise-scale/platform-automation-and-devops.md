---
title: Platform automation and DevOps
description: Platform automation and DevOps
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Platform automation and DevOps

![Platform automation and DevOps](./media/DevOps.png)
_Figure 1: Platform automation and DevOps._

## Planning for a DevOps approach

Many traditional IT operating models aren't compatible with the cloud, and customers must undergo operational and organizational transformation to deliver against enterprise migration targets. It's highly recommended to use a DevOps approach for both application and central teams.

**Design considerations:**

- Where central teams are concerned, CI/CD pipelines should be used to manage policy definitions, role definitions, policy assignments, management group hierarchies, and subscriptions. These pipelines help ensure that multiple subscriptions can be operationally managed while still conforming to a desired state.

- The blanket app of a DevOps model won't instantly establish capable DevOps teams.

- Investing in engineering capabilities and resources is critical.

- The customer can arrange internal and external DevOps roles and functions from a variety of sources that align with their organization's strategy.

- For some legacy apps, the associated app team may not have engineering resources required to align with a DevOps strategy.

<!-- cSpell:ignore PlatformOps SecOps NetOps AppDevOps AppDataOps AppSecOps -->

**Design recommendations:**

Establish a cross-functional DevOps platform team to build, manage, and maintain your enterprise-scale architecture. This team should include members from your Central IT, security, compliance, and business units teams to ensure that a wide spectrum of your enterprise is represented. The list below presents a recommended set of DevOps roles for a central platform team:

- **PlatformOps** (platform operations) for:

  - Subscription provisioning and delegation of required network, identity and access management, and policies

  - Platform management and monitoring (holistic)

  - Cost management (holistic)

  - Platform-as-code (managing templates, scripts, and other assets)

  - Responsible for overall operations on Microsoft Azure within the Azure Active Directory tenant (managing service principals, Graph API registration, and define roles)

- **SecOps** (security operations)

  - Role-based access control (RBAC) (holistic)

  - Key management (for central services, simple mail-transfer protocol and domain controller)

  - Policy management and enforcement (holistic)

  - Security monitoring and audit (holistic)

- **NetOps** (network operations)

- Network management (holistic)

- Allow app owners to create and manage app resources through a DevOps model. The list below presents a recommended DevOps role for application teams:

- **AppDevOps**

  - App migration or transformation

  - App management and monitoring

  - RBAC (app resources)

  - Security monitoring and audit (app resources)

  - Cost management (app resources)

  - Network management (app resources)

  - In some instances, customers may wish to break AppDevOps into more granular roles such as AppDataOps for database management like traditional database administrator roles or AppSecOps, where more security sensitive apps are concerned.

- Provide a central app DevOps function to support apps that don't have existing DevOps capabilities or a business case to establish one (for example, legacy apps with minimal development capabilities)

- Use a policy-driven approach with clear RBAC boundaries to centrally enforce consistency and security across application teams. This ensures a least privilege approach is taken by using a combination of RBAC assignments and Azure Policy, and that workloads are compliant with Azure Policy assignments at all times.

- To accelerate Azure adoption, the central platform team should establish a common set of templates and libraries for application teams to draw upon.
For example, horizontal (cross-function) guidance can help to support migrations through subject matter expertise and to ensure alignment with the overall target enterprise-scale architecture.

- Do not restrict application teams to use central artifacts or approaches as it hinders agility. Consistent baseline configurations can be enforced through a policy-driven infrastructure approach and RBAC assignments. This ensures app (business unit) teams are flexible enough to innovate while still able to draw from a predefined set of templates.

- Do not force application teams to use a central process or provisioning pipeline for the instantiation or management of app resources. This ensures existing teams that already rely on a DevOps pipeline for app delivery can still use the same tools they have been using. Remember that you can still use Azure Policy to maintain guard rails, independent of how resources are deployed in Azure.

## Define central and federated responsibilities

The distribution of roles, responsibilities, and trust between Central IT teams and apps teams is paramount to the operational transformation customers must undergo when adopting the cloud at scale.

**Design considerations:**

Central teams strive to maintain full control while app owners seek to maximize agility. The balance between these goals can greatly influence the success of the migration

**Design recommendations:**

The list below presents a recommended distribution of responsibilities between Central IT and application teams striving to empower migration/transformation activities with minimal central dependencies while still supporting the centralized governance of security and operability across the entire estate.

- **App functions**

  - App migration and/or transformation

  - App management and monitoring (app resources)

  - Key management (app keys)

  - RBAC (app resources)

  - Security monitoring and audit (app resources)

  - Cost management (app resources)

  - Network management (app resources)

- **Central functions**

  - Architecture governance

  - Subscription management

  - **Platform as code** (management of templates, scripts, and other assets)

  - Policy management and enforcement (holistic)

  - Platform management and monitoring (holistic)

  - RBAC (holistic)

  - Key management (central services)

  - Network management (networks, network virtual appliance, and more)

  - Security monitoring and audit (holistic)

  - Cost management (holistic)

An Azure DevOps model that's based on these recommendations provides the desired control for central teams and the migration agility required by application teams.
