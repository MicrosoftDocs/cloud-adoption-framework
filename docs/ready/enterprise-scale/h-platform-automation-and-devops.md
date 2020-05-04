---
title: "Platform Automation and DevOps"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF enterprise-scale landing zone - Platform Automation and DevOps
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---


# H. Platform automation and devOps

[![Platform Automation and DevOps](./media/devops.png "Platform Automation and DevOps")](./media/devops.png)

Figure 10 – Platform Automation and DevOps

## 1. Planning for a DevOps approach

Many traditional IT operating models are unfortunately not compatible with the cloud, and ultimately customers must undergo a degree of operational and organizational transformation to deliver against enterprise migration targets. Ultimately, it is highly recommended for a DevOps approach to be employed for both application and central teams.

***Design considerations***

- Where central teams are concerned, CI/CD pipelines should be used to manage policy definitions, role-definitions, policy assignments, and template galleries. Such pipelines will help ensure multiple subscriptions can be operationally managed whilst still conforming to a desired state.

- The blanket application of a DevOps model will not miraculously establish capable DevOps teams.

    - Investment in engineering capabilities and resources is critical.

- The customer can resource DevOps roles and functions from a variety of sources aligned to their organization strategy, both internal and external.

- For some legacy applications, the associated application team may not have engineering resources required to align with a DevOps strategy.

***Design recommendations***

- Establish a cross-cutting central DevOps “Platform Team” to build, manage, and maintain the CAF enterprise-scale landing zone architecture.

- The list below presents a recommended set of DevOps roles for the central “Platform Team”.

- **Platform operations** (PlatformOps) to

    - Subscription provisioning and delegation of required network, IAM, and policies.

    - Platform management and monitoring (holistic).

    - Cost Management (holistic).

    - “Platform as Code” (management of templates, scripts and other assets).

    - Responsible for overall operations on Azure within the AAD tenant, such as managing service principles, Graph API registration, and role definitions.

- **Security operations** (SecOps)

    - Role-based access control (holistic).

    - Key management (for example, SMTP and Domain Controller for central services)

    - Policy management and enforcement (holistic)

    - Security monitoring and audit (holistic)

- **Network operations** (NetOps)

    - Network management (holistic)

- Allow application owners to create and manage application resources through a DevOps model.

- The list below presents a recommended DevOps role for application teams.

- **AppDevOps**

    - Application migration and/or transformation

    - Application management and monitoring

    - Role-based access control (app resources)

    - Security monitoring and audit (app resources)

    - Cost Management (app resources)

    - Network Management (app resources)

    - In some instances, customers may wish to break AppDevOps into more granular roles such as AppDataOps for database management like traditional DBA roles, or AppSecOps where more security sensitive applications are concerned; this is to be expected.

- Provide a central application DevOps function to support applications that do not have existing DevOps capabilities or a business case to establish one; e.g., legacy applications with minimal development capabilities.

- Leverage a policy-driven approach with clear RBAC boundaries to centrally enforce consistency and security across application teams.

- In the spirit of accelerating Azure adoption, the central “Platform Team” should be leveraged to establish a common set of templates and libraries for application teams to draw upon.

    - For example, horizontal (cross-function) guidance can help to support migrations through subject matter expertise and more importantly, ensure alignment with the overall target CAF enterprise-scale landing zone architecture.

<!-- -->

- Do not restrict application teams to use central artifacts or approaches as it hinders agility. Consistent baseline configurations are already enforced through the policy driven approach and RBAC.

- Do not force application teams to use a central process or provisioning pipeline for the instantiation or management of application resources.

## 2. Define central and federated responsibilities

The distribution of roles, responsibilities, and trust between central IT teams and applications teams is paramount to the operational transformation customers must undergo when adopting the cloud at scale.

***Design considerations***

- Central teams strive to maintain full control whilst application owners seek to maximize agility. The balance between these goals can greatly influence the success of the migration

***Design recommendations***

- The list below presents a recommended distribution of responsibilities between central IT and application teams, striving to empower migration/transformation activities with minimal central dependencies while still supporting the centralized governance of security and operability across the entire estate.

- **Application functions**

    - Application migration and/or transformation.

    - Application management and monitoring (app resources).

    - Key management (app keys).

    - Role based access control (app resources).

    - Security monitoring and audit (app resources).

    - Cost Management (app resources).

    - Network Management (app resources).

- **Central functions**

    - Architecture governance

    - Subscription management

    - “Platform as Code” (management of templates, scripts and other assets)

    - Policy management and enforcement (holistic)

    - Platform management and monitoring (holistic)

    - Role-based access control (holistic)

    - Key management (central services)

    - Network management (networks, NVAs, etc.)

    - Security monitoring and audit (holistic)

    - Cost management (holistic)

> Ultimately, if the design recommendations discussed within this guide are followed, a **DevOps model on Azure could provide both the desired control for central teams as well as the migration agility required by application teams, without compromise.**

## Next steps

Review the [implementation guide](./implementation-guide.md)

> [!div class="nextstepaction"]
> [Implementation Guide](./implementation-guide.md)
