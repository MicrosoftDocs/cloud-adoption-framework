---
title: Platform automation and DevOps design area
description: Design area guidance for platform automation and DevOps
author: DominicAllen
ms.author: doalle
ms.date: 12/6/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Design area: Platform automation and DevOps

Platform automation and DevOps evaluate opportunities to modernize your approach to environmental deployment with infrastructure as code options.

## Design area review

**Involved roles or functions:** Platform automation and DevOps might require support from one of the following functions or roles to make decisions: [cloud platform](../../../organize/cloud-platform.md), and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md)

**Scope:** The goal of Platform automation and DevOps is to evaluate your maturity with infrastructure as code and approach to DevOps deployment.

## Design area overview

The scale, agility, and flexibility part of cloud technologies leads to opportunities for new ways of working and modern approaches to service delivery.

Many traditional IT operating models aren't compatible with the cloud, and must undergo operational transformation to deliver against enterprise migration targets. You can evaluate using DevOps processes and tools for application and central teams.

### DevOps

DevOps is the union of people, processes, and technology that continues to provide value to development (dev) and operations (ops).
This approach encourages team collaboration that creates repeatable processes to help organizations operate efficiently, and at scale.

In the context of a cloud environment, DevOps processes will encourage the concepts of continuous integration and continuous deployment (CI/CD), which fosters a culture of refinement and improvement.

The decisions you make when reviewing cloud operating models might influence how you use DevOps functions. These decisions might also reach across technical teams with the capability for infrastructure as code.

### Platform automation

Platform automation focuses on tools and techniques that enable the streamlining of tasks. These tasks might have been performed manually using automation tools such as Azure DevOps Services, or GitHub.

By automating tasks, the effort to complete them reduces the risk of human-error that might come from issues resulting from the task.
This automation then enables the tasks to be completed quicker and more often, supporting the concepts of (CI/CD).

Platform automation is directly applicable to the outcomes associated with implementing an Azure landing zone, and supports the concept of building repeatable, scalable environments.

Automated processes and tools enable deployment activities to be configured as 'stages' in a pipeline. This sequence of tasks is completed in a prescribed order, which include built-in tests and checks to ensure successful completion.

The ability to make changes at scale through a prescribed automated process might provide direct benefits to the organization's ability to expand beyond the baseline configuration, which comes from security, governance and management.

### Platform automation and DevOps design considerations

- Concerning central teams, consider using pipelines for continuous integration and continuous deployment
- Pipelines might be used to manage policy and role definitions, policy assignments, management group hierarchies, and subscriptions. These pipelines help ensure that you can operationally manage multiple subscriptions and conform to a desired state.

- The blanket application of a DevOps model won't instantly establish capable DevOps teams.

- Investing in engineering capabilities and resources is critical.

- You can arrange internal and external DevOps roles and functions from different kinds of sources that align with your organization's strategy.

- For some legacy applications, the associated application team might not have engineering resources required to align with a DevOps strategy.

### Define central and federated responsibilities considerations

The distribution of roles, responsibilities, and trust between central IT teams and applications teams is paramount to the operational transformation involved when adopting the cloud at scale.

Central teams strive to maintain full control, while application owners seek to maximize agility. The balance between these goals can greatly influence the success of the migration.

## Recommendations for platform automation and DevOps

The Azure DevOps Services model that's based on these recommendations provide the control for central teams and the migration agility required by application teams.

### Platform automation and DevOps - design recommendations

Establish a cross-functional DevOps platform team to build, manage, and maintain your environments. This team might include members from your central IT team, security, compliance, and business units to ensure that a wide spectrum of your enterprise is represented. The following list presents a recommended set of DevOps roles for a central platform team:

| Function | Responsibilities|
|--|--|
|**PlatformOps** (platform operations)|Subscription provisioning and delegation of required network, identity and access management, policies <br> Platform management and monitoring (holistic) <br> Cost management (holistic) <br> Platform-as-code (managing templates, scripts, and other assets) <br> Responsible for overall operations on Microsoft Azure within the Azure Active Directory tenant (managing service principals, registering the Microsoft Graph API, and defining roles) |
|**SecOps** (security operations)|Azure role-based access control (Azure RBAC) (holistic) <br> Key management (for central services, simple mail-transfer protocol, and domain controller) <br> Policy management and enforcement (holistic) <br> Security monitoring and audit (holistic) |
|**NetOps** (network operations)| Network management (holistic) |
|**AppDevOps**| Allow application owners to create and manage application resources through a DevOps model <br> Application migration or transformation <br> Application management and monitoring <br> Azure RBAC (application resources) <br> Security monitoring and audit (application resources) <br> Cost management (application resources) <br> Network management (application resources) |

-Sometimes, you might want to break AppDevOps into more granular roles, such as AppDataOps for database management, or AppSecOps for more security-sensitive applications.

- Provide a central application DevOps function to support applications that don't have existing DevOps capabilities, or a business case to establish one (for example, legacy applications with minimal development capabilities).

- Use a policy-driven approach with clear Azure RBAC boundaries to centrally enforce consistency and security across application teams. This ensures that a good approach is taken by using a combination of Azure RBAC and Azure Policy, and ensures that workloads are compliant with Azure Policy assignments.

- To accelerate Azure adoption, the central platform team might establish a common set of templates and libraries for application teams. For example, horizontal (cross-function) guidance can help support migrations through subject matter expertise, which ensures alignment with the overall target enterprise-scale architecture.

- Don't restrict application teams to the use of central artifacts as it might hinder their agility. You can enforce consistent baseline configurations through a policy-driven infrastructure approach with Azure RBAC. This ensures that application (business unit) teams are flexible enough to innovate, while still able to draw from a predefined set of templates.

- Don't force application teams to use a central process or provisioning pipeline for the instantiation or management of application resources. Existing teams that already rely on a DevOps pipeline for application delivery can still use their existing tools. Remember, you can still use Azure Policy to maintain guardrails independent of how resources are deployed in Azure.

### Define central and federated responsibilities recommendations

The distribution of roles, responsibilities, and trust between central IT and applications teams is paramount to the operational transformation involved when adopting the cloud at scale.

The following table presents a recommended distribution of responsibilities between the central IT team and application teams. You're striving to empower migration and transformation activities with minimal central dependencies. At the same time, you want to support the centralized governance of security and operability across the entire estate.

| Function | Responsibilities|
|--|--|
|**Application functions**|Application migration and transformation <br> Application management and monitoring (application resources) <br> Key management (application keys) <br> Azure RBAC (application resources) <br> Security monitoring and audit (application resources) <br> Cost management (application resources) <br> Network management (application resources) |
|**Central functions**| Architecture governance <br> Subscription management <br> Platform as code (management of templates, scripts, and other assets) <br> Policy management and enforcement (holistic) <br> Platform management and monitoring (holistic) <br> Azure RBAC (holistic) <br> Key management (central services) <br> Network management (including networks and network virtual appliances) <br> Security monitoring and audit (holistic) <br> Cost management (holistic)   |

## Platform automation and DevOps in the Azure landing zone accelerator

![Diagram of platform automation and DevOps.](../../enterprise-scale/media/devops.png)

The Azure landing zone accelerator can help integrate continuous integration and continuous deployment (CI/CD) pipelines into the environment using GitHub with GitHub Actions. The portal process guides you through the steps to set up the integration.

By integrating CI/CD pipelines into the environment, platform resources can be managed as code in a repository.
