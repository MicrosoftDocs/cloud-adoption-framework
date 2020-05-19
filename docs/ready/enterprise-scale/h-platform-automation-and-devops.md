---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# H. Platform automation and DevOps

![Platform Automation and DevOps](./media/devops.png)

_Figure 10: Platform automation and DevOps._

## 1. Planning for a DevOps approach

Many traditional IT operating models are unfortunately not compatible with the cloud, and ultimately customers must undergo a degree of operational and organizational transformation to deliver against enterprise migration targets. Ultimately, it is highly recommended that a DevOps approach be employed for both application and central teams.

**Design considerations:**

- Where central teams are concerned, CI/CD pipelines should be used to manage policy definitions, role-definitions, policy assignments, and template galleries. Such pipelines will help ensure multiple subscriptions can be operationally managed whilst still conforming to a desired state.

- The blanket application of a DevOps model will not miraculously establish capable DevOps teams.

  - Investment in engineering capabilities and resources is critical.

- The customer can resource DevOps roles and functions from a variety of sources aligned to their organization strategy, both internal and external.

- For some legacy applications, the associated application team may not have engineering resources required to align with a DevOps strategy.

**Design recommendations:**

- Establish a cross functional DevOps **Platform Team** to build, manage and maintain your **Enterprise Scale** architecture.

  This team should include members from your Central IT, security, compliance, and business units teams to ensure a wide spectrum of your enterprise is represented.

  The list below presents a recommended set of DevOps roles for the central **Platform Team**.

- **Platformops** (platform operations) to

  - Subscription provisioning and delegation of required network, IAM, and policies.

  - Platform management and monitoring (holistic).

  - Cost management (holistic).

  - "Platform as code" (management of templates, scripts and other assets).

  - Responsible for overall operations on Azure within the Azure AD tenant, such as managing service principles, graph API registration, and role definitions.

- **Secops** (security operations)

  - Role-based access control (holistic).

  - Key management (for central services, for example smtp, domain controller).

  - Policy management and enforcement (holistic).

  - Security monitoring and audit (holistic).

- **Netops** (network operations)

  - Network management (holistic).

- Allow application owners to create and manage application resources through a DevOps model.

- The list below presents a recommended DevOps role for application teams.

- **Appdevops**

  - Application migration and/or transformation.

  - Application management and monitoring.

  - Role-based access control (app resources).

  - Security monitoring and audit (app resources).

  - Cost management (app resources).

  - Network management (app resources).

  - In some instances, customers may wish to break appdevops into more granular roles such as appdataops for database management like traditional dba roles, or appsecops where more security sensitive applications are concerned; this is to be expected.

- Provide a central application DevOps function to support applications which do not have existing DevOps capabilities or a business case to establish one, I.e. Legacy applications with minimal development capabilities.

- Use a policy-driven approach with clear RBAC boundaries to centrally enforce consistency and security across application teams.

  This ensures a least privilege approach is taken by using a combination of RBAC assignments and Azure Policy, and that workloads are compliant with Azure Policy assignments at all times.

- To accelerate Azure adoption, the central **Platform Team** should be leveraged to establish a common set of templates and libraries for application teams to draw upon.

  For example, horizontal (cross-function) guidance can help to support migrations through subject matter expertise and to ensure alignment with the overall target "enterprise-scale" architecture.

- Do **`NOT`** restrict application teams to use central artifacts or approaches as it hinders agility. Consistent baseline configurations can be enforced through a policy-driven infrastructure approach and RBAC assignments.

  This ensures application (business unit) teams are flexible enough to innovate while still able to draw from a pre defined set of templates.

- Do **`NOT`** force application teams to use a central process or provisioning pipeline for the instantiation or management of application resources.

  This ensures existing teams that already rely on a DevOps pipeline for application delivery can still use the same tools they have been using. Remember that you can still use Azure Policy to maintain guardrails, independent of **`HOW`** resources are deployed in Azure.

## 2. Define central and federated responsibilities

The distribution of roles, responsibilities, and trust between Central IT teams and applications teams is paramount to the operational transformation customers must undergo when adopting the cloud at scale.

**Design considerations:**

- Central teams strive to maintain full control whilst application owners seek to maximize agility. The balance between these goals can greatly influence the success of the migration

**Design recommendations:**

- The list below presents a recommended distribution of responsibilities between Central IT and application teams, striving to empower migration/transformation activities with minimal central dependencies, while still supporting the centralized governance of security and operability across the entire estate.

- **Application functions**

  - Application migration and/or transformation.

  - Application management and monitoring (app resources).

  - Key management (app keys).

  - Role-based access control (app resources).

  - Security monitoring and audit (app resources).

  - Cost management (app resources).

  - Network management (app resources).

- **Central functions**

  - Architecture governance.

  - Subscription management.

  - **Platform as code** (management of templates, scripts and other assets).

  - Policy management and enforcement (holistic).

  - Platform management and monitoring (holistic).

  - Role-based access control (holistic).

  - Key management (central services).

  - Network management (networks, NVAs, etc.).

  - Security monitoring and audit (holistic).

  - Cost management (holistic).

**A DevOps model on Azure based on these recommendations provides the desired control for central teams as well as the migration agility required by application teams, without compromise.**
