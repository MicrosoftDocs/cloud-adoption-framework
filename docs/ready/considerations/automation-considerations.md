---
title: Automation considerations
description: Describes the different considerations and recomentation when automating deployment of Azure Landing Zone and platform services
author: MariusStorhaug
ms.author: MariusStorhaug
ms.date: 04/27/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Automation considerations

<!--
Describe why a platform team should consider automating platform deployment/configuration for an evolving platform.
Describe how parts of the platform can be automated in different ways. with their opportunities and trade-offs.
-->

Cloud Infrastructure is software defined, where you can provision, configure and manage your cloud infrastructure using
different approaches and tools. As teams evolve and grow they shift from using portals and manual steps,
to using code and automation to provision, configure and manage the infrastructure and services they own.

With transitioning to a code and automation approach, teams can start seeing some clear benefits such as:
- Shorter time to provision and change infrastructure and services, by streamlining the process of describing a change to having the infrastructure provisioning provisioned to production.
- Automation enables teams to quickly establish an entire infrastructure by operating a set of code artifacts. You may do this for all environments, from development through to production, going through QA, staging, and the like. automation could help streamline the whole software development lifecycle.
- Consistancy and reliability of the provisioning and configuration of the cloud infrastructure
  - This is one of the IaC benefits that is derived from the aforementioned ‘configuration drift’ issue that tends to cause mismatched development, test, and/or deployment environments due to ad-hoc configuration changes and updates. These issues can further jeopardize the deployment process and lead to security-based risks during app and service development, which can be especially vulnerable to the projects that are required to meet strict regulatory compliance standards. IaC benefits businesses as it obviates drift by provisioning the same environment every time, enabling improved infrastructure consistency at all times.
- Accuracy and consistency
  - Manual processes often lead to mistakes due to human error and poor communication. Manual infrastructure management will, in most cases, lead to discrepancies. automation deals with this issue by ensuring the configuration files are the single source of truth. This makes sure that the same configurations will be carried out without inconsistencies.
- Improved Security by having the deployment process, documentation, infrastructure declaration scripts and more available for inspection.
- Increased accountability by having trach on who did what and when through audit logs and version control.
  - If implemented right, the IaC-based infrastructure can improve the overall security of your computing architecture and the data stored within it. It takes care of misconfigured IaC files throughout the development process, while it also transforms the run-time security issues into build-time governance, but does so only if it is:
    - Automated
    - Delivered as code
    - Implemented within a continuous and consistent workflow
    - Increased Workflow Transparency & Structural Arrangement
    - Companies that successfully implement Infrastructure as Code and DevOps approach can enjoy one of the most underrated IaC benefits that is – workflow transparency. Instead of everything being thrown around in a diffuse manner across the Graphical User Interface, the structural arrangement of your workloads are much more organized and transparent, allowing for a more streamlined workflow and increased consistency.

- As cloud infrastrucutre and services are software-defined and can be managed through code and development principles, consider embracing a modern change management processes to submit, review and implement changes.
    By treating 'Everything-as-code' and using version control on the codebase
- With a new approach, there are new

## Operation models

### NoOps

- Vision of getting to NoOps, automated deployment of apps, configuration and infra where human intervention is heavily reduced.
  - Extreme Automation
  - To put this into context, let’s take a step back and talk about how we got here. The traditional method for software development is the waterfall methodology, which uses a linear approach that outlines all the stages in the software development process ahead of time. It’s characterized by rigidity, fixed requirements, with development and operations teams each in their own silo.
  - As our workflows evolved, Agile methodology hit the scene. By focusing on flexibility, iteration, and interdisciplinary collaboration involving all stakeholders, Agile revolutionized how we build software.
  - Then came DevOps, the next evolution of Agile for software development. DevOpswidens Agile's principles to include systems and operations by encouraging close cooperation between development and operations teams during the entire SDLC. It solves the problems with previous methodologies by evolving and improving products at a faster pace, resulting in a 25 -30% increase in capacity creation, a 50-75% reduction in time to market, and a greater than 50% reduction in failure rates.

NoOps (no operations) is the concept that an IT environment can become so automated and abstracted from the underlying infrastructure that there is no need for a dedicated team to manage software in-house.
Traditionally in the enterprise, an application development team is in charge of gathering business requirements for a software program and writing code. The development team tests their program in an isolated development environment for quality assurance (QA) and -- if requirements are met -- releases the code to an operations team who deploys and maintains the program from that point on. In a NoOps scenario, maintenance and other tasks performed by the operations team would be automated.
Forrester coined the term NoOps, which they define as "the goal of completely automating the deployment, monitoring and management of applications and the infrastructure on which they run." According to Forrester Senior Analyst Glenn O’Donnell, who co-authored the report "Augment DevOps with NoOps," it is more likely that although some operations positions will become unnecessary, others will simply evolve from a technical orientation toward a more business-oriented focus.
The two main drivers behind NoOps are increasing IT automation and cloud computing. At its most extreme, a NoOps organization is one that has no operations employees at all, however various other systems can be referred to as "NoOps" as well. For example, Platform-as-a-Service (PaaS) vendors such as AppFog and Heroku describe their offerings as NoOps platforms.
NoOps can be contrasted with DevOps, a concept in which the line between development and operations teams is blurred and members of each group assume some of the responsibilities of the other team.

>
> Why should a human have to look at a screen to see if the server is patched? We believe that’s a waste of a valuable human."
> –Gerry Miller, Founder & CEO, Cloudticity

The highest progression of DevOps is known as NoOps, a term originally coined by Forrester in 2011. NoOps is an ideal state where both application development and infrastructure are fully automated, allowing developers to move even faster and more securely.

First is CI/CD, Continuous Integration and Continuous Delivery.
Then came DevOps, the next evolution of Agile for software development. DevOps widens Agile's principles to include systems and operations by encouraging close cooperation between development and operations teams during the entire SDLC. It solves the problems with previous methodologies by evolving and improving products at a faster pace, resulting in a 25 -30% increase in capacity creation, a 50-75% reduction in time to market, and a greater than 50% reduction in failure rates.
The second practice is Infrastructure as Code (IaC). Rather than relying on operations administrators to configure and manage hardware, today’s companies can automate this entire process in a cloud environment.

Cloud offers highly elastic infrastructure; since users pay based on the amount of resources they use, developers often find themselves spinning up and shutting down virtual machines (VMs) on a regular basis, sometimes multiple times within the span of a single day. Because of this elasticity, experimentation is of relatively low risk and low cost to companies, allowing them to be more innovative and test more features in the cloud.
Here’s where things get interesting: rather than provisioning infrastructure individually, DevOps teams simply write code that can continuously create identical environments, which they can then use to test and push out application code in the CI/CD pipeline and to deliver stable environments quickly and at scale.
This ultimately amounts to high-performing DevOps. CI/CD allows us to automatically deploy apps, while IaC enables automatic infrastructure deployment. However, this system still requires operations engineers for compliance management, approvals, and QA.


### DevOps

Getting to DevOps, automated deployment of infra where human intervention is required for compliance, management, approvals and quality assurance:

Simply put, DevOps teams use CI/CD to deliver software with less risk, to improve developer productivity, to deliver products that users require, and to release new features on a more frequent basis. In fact, research shows that the highest performing DevOps teams use tactics like CI/CD to make on-demand deployments multiple times per day, reduce change lead times to under one hour, restore services in under one hour, and minimize change failure rates to between 0-15%.


  - Everything-As-Code
    - Why?
      - Speed and efficiency
      - Consistency
      - Aligned with DevOps
      - Simplify edit, copy/reuse and distribute
      - Single source of truth.
    - Support for DevOps
      - With the setup of the infrastructure written as code, you can apply the same CI/CD pipeline steps that IT professionals use for application code, such as version control and automated testing. An organization could decide to use automation alongside containers that remove the application from the infrastructure at the level of the operating system. Because the hardware and operating system infrastructure are provisioned automatically, and the application is enclosed on top of it, such technologies are relevant for various deployment goals, including staging, testing and production.
    - Version control
      - When infrastructure is expressed as code, it may be checked into, source controlled, code-reviewed and versioned using current software engineering operations. Modifications to infrastructure can be carried out using available CI/CD tools.
    - Code Your Way Through To The Single Source Of Truth
      - One of the most commonly used rules of thumb involves deploying code to describe your infrastructure wherever and whenever possible. Most of the time, codifying both traditional and cloud infrastructures is plausible and recommended. Codifying physical/virtual server management is possible via Terraform, YAML, Python, and CloudFormation; network management is most commonly performed through Puppet/Chef modules, while container management is usually done via Docker. When it comes to infrastructure specifications, we recommend establishing these configuration files as your “single source of truth.”

    - Coinsider reducing access to the platform resources to the automation.
    - AdHoc access to your team members to do triage.
      - Implement "dirty" code, increasing technical debt that eventually needs to be cleaned and brought back to a state that follows teams guidelines.
      - Create a process for bringing changes back to production (SRE)
    - Limit deploymet untill approved for production
    - Codifying platform and processes
      - Capture a process, routine or algorithm in a textual format
      - May be declarative or imperative.
      - Desired state vs Steps to take
    - Types of codification
      - Config management - System definition enforcement
      - Process/deployment management - Process definition enforcement - CI/CD
      - Provisioning and lifecycle management - Continiously declare desired state of infrastructure
      - Security and governence management - Declare security requirements and declare default infrastructure/configuration - Policy as Code - Define infrastructure to lower burden on infra team. i.e.
        - Automate deployment of resources from design to eleviate tedious tasks on platform team.

### ClickOps

Whilst “ClickOps” is an effective and simple method of learning to navigate the cloud console and familiarizing yourself with the CSP’s offerings.
ClickOps is used as a term to describe the process of how clicking in portals, management console, and wizards to provision, configure and manage resources and services.
Teams which are working though establishing and evolving their practicess to use more codification and automation of their infrastructure typically see the following patterns:

- Time consuming to document
- Slow and error-prone to execute changes
- Difficult to test and verify
- Difficult to roll back to previous state
- Difficult to replicate exactly to other environments
- No versioning control, so if the process change over time, its hard to know what changed when


- Progressing away from ClickOps and the error-prone process of deploying things manually to more control:
  -  [Azure landing zone accelerator (with AzOps)](../../ready/landing-zone/index.md#azure-landing-zone-accelerator)

#### Evolving from ClickOps to DevOps to NoOps

Required tools and time to learn and grow with tooling.

- Automation:
  - Security scanning
  - Threat assessment and detection (deploy this automation into the platform)

- Testing
  - Static code analysis
  - Linting
  - Choose your tools wisely

Change management:
- Use PR to automate and have documentation for changes
- Seperation of concerns - Define what is provided to teams when a LZ is deployed.

Understand what is automated up front in the platform.


Enter Extreme-Automation.

IaC is an essential DevOps practice that eliminates the friction from the numerous steps of the software development lifecycle and increases collaboration between development and operations teams.

- Infrastructure as code, continuous integration, continuous deployment, TDD, BDD and containerization are accepted practices in current development and especially in cloud native development. Faced independently, they lead us to automate the development life cycle processes and to enable the DevOps culture. Under this context, constant human intervention is still necessary to preserve automation. The effect for organizations that have not been born agile and are in the midst of a digital transformation is to gravitate to the state they wish to abandon due to attrition of agents of change that by definition are a minority.
- Under digital transformation context, it is essential has development team focused most of its time on delivering value. Infrastructure vision is not enough, a platform vision is needed.
- The first step is to define everything as code. This implies a Big-Bang approach where the only input is the credentials of the script that bootstraps the platform. From the bootstrap, everything must be created as code, including the credentials that must be injected to the different services. The accesses for administrators and developers must be guaranteed automatically using SSO technologies and distributed user directories like OpenID, Oauth2 and SAML. Access to services such as databases should never be direct to people, it should always be through authenticated applications or servers. A good example of this pattern is Azure AD Managed Service Identity. The automation scripts must also consider the state recovery from persistence sources as design since its creation and the initial state should consider the minimum to operate the application. The goal is to have the ability to destroy the system and recreate it to its latest state without human intervention and additionally create as many tenants and Phoenix ​​environments from the initial state as necessary. This is extreme immutability.
- For extreme immutability to be viable, infrastructure as code is not enough, infrastructure must be confronted as software. To achieve this, automation must be treated in the same way that applications are treated. Version control and continuous integration must exist. Unit, functional and vulnerability tests should be automated. In the case of infrastructure, doing this is complex and many times the solution is again to take advantage of the extreme immutability and create Phoenix environments to execute the validations before consolidate changes in the productive environment. Techniques such as Chaos Monkey are fundamental. An interesting example is the Sonobuoy project for Kubernetes.


### Scribbles

Deployment vs lifecycle management
Configuration drift / lifecycle management.
Not only deploy resources, but also change existing resources.

Describe how parts of the platform can be automated in different ways. with their opportunities and trade-offs.
- Azure Landing Zone Accelerators:
  - ALZ-Bicep- [Azure/ALZ-Bicep | GitHub Repo](https://github.com/Azure/ALZ-Bicep)
  - Terraform [Azure/terraform-azurerm-caf-enterprise-scale | GitHub Repo](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest)
- Managing missing components not yet covered in the accelerators:
  - IaC
  - Policy-as-Code
    - Managing exemtions
- Deployment layering


## Platform automation design considerations

<!--
    Discuss different approaches to automation of the platform deployment and configuration (day 2 ops).
    Configuration changes on the platform can have huge implications on workloads running on it.
    Establishing a '4 eyes principle' could limit errors and mistakes when deploying or reconfiguring the platform.
    Different solutions to consider as teams transition from a 'ClickOps' approach where changes happen in the portal.
    Tools that can push and pull configuration to and from Azure, allowing a dual mode of 'ClickOps' and 'DevOps'.
    Use of CI/CD to enable a 'fail fast' approach where validation happens before deployment.
    Consider an approach of treating 'Everything as Code' including but not limited to:
    What is being deployed and configured
    Details on how the automation does what it does (i.e. deployment logic as code, yml pipelines vs Release pipelines)
    How to handle rollback of changes
    - Infrastructure as Code
    - Azure Policy
    - Azure Automation
    - Functions
-->


## Platform automation design recommendation

- Follow an **Everything as Code** approach for full transparency and configuration control of the Azure platform, documentation, deployment and testing process.
- Use version control to manage all the code repositories, including Infrastructure-, Policy-, Configuration-, and Documentation-as-Code.


## Read more

- [Adopt policy-driven guardrails - Cloud Adoption Framework | Microsoft Docs](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance)
- [Fundamentals of Bicep - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/fundamentals-bicep/)
- [Intermediate Bicep - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/intermediate-bicep/)
- [Advanced Bicep - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/advanced-bicep/)
- [Deploy Azure resources by using Bicep and GitHub Actions - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/bicep-github-actions/)
- [Deploy Azure resources by using Bicep and Azure Pipelines - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/bicep-azure-pipelines/)
- [Control and govern your Azure environment by deploying your infrastructure as code - Learn | Microsoft Docs](https://docs.microsoft.com/learn/modules/control-govern-azure-environment-deploying-infrastructure-code/)
