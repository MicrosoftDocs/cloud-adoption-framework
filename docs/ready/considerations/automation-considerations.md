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

## Overview

Cloud Infra is software defined, where you can provision, configure and manage your cloud infrastructure using different approaches and tools.
Things to consider is:
- Speed of Innovation to gain market advantage
- Faster Time To Market/Production
  - The level of automation through the IaC deployment allows for a dramatic increase in workflow streamlining and the speed of the infrastructure provisioning process during the stages of development, testing, and production. It also shortens the time needed for scaling and/or taking down production infrastructure when necessary. Thanks to its codifying and documenting of all the components, the IaC benefits the companies with faster and automated provisioning of traditional infrastructures, the process that would otherwise involve many time-consuming procedures.

- Consistancy and reliability of the provisioning and configuration of the cloud infrastructure
  - This is one of the IaC benefits that is derived from the aforementioned ‘configuration drift’ issue that tends to cause mismatched development, test, and/or deployment environments due to ad-hoc configuration changes and updates. These issues can further jeopardize the deployment process and lead to security-based risks during app and service development, which can be especially vulnerable to the projects that are required to meet strict regulatory compliance standards. IaC benefits businesses as it obviates drift by provisioning the same environment every time, enabling improved infrastructure consistency at all times.

- Efficiency and cost savings
  - Development automation via Infrastructure as Code and DevOps approach enables a more simple provisioning process, resulting in more consistent and much more accelerated phases of the software delivery lifecycle.
  - Perhaps the most enticing of IaC benefits is the combo of reduced costs and increased Return on Investment. Not only does the utilization of IaC reduce the amount of effort, time, and specialized skills necessary for successful infra provisioning and scaling, it also allows you to leverage all the cost-reduction potential that a highly scalable consumption-based cost structure can provide.

Improved Security
- If implemented right, the IaC-based infrastructure can improve the overall security of your computing architecture and the data stored within it. It takes care of misconfigured IaC files throughout the development process, while it also transforms the run-time security issues into build-time governance, but does so only if it is:
  - Automated
  - Delivered as code
  - Implemented within a continuous and consistent workflow

Increased Workflow Transparency & Structural Arrangement
- Companies that successfully implement Infrastructure as Code and DevOps approach can enjoy one of the most underrated IaC benefits that is – workflow transparency. Instead of everything being thrown around in a diffuse manner across the Graphical User Interface, the structural arrangement of your workloads are much more organized and transparent, allowing for a more streamlined workflow and increased consistency.

Code Your Way Through To The Single Source Of Truth
- One of the most commonly used rules of thumb involves deploying code to describe your infrastructure wherever and whenever possible. Most of the time, codifying both traditional and cloud infrastructures is plausible and recommended. Codifying physical/virtual server management is possible via Terraform, YAML, Python, and CloudFormation; network management is most commonly performed through Puppet/Chef modules, while container management is usually done via Docker. When it comes to infrastructure specifications, we recommend establishing these configuration files as your “single source of truth.”

- Faster development lifecycle
  - IaC lets you quickly establish your entire infrastructure by operating a script. You may do this for all environments, from development through to production, going through QA, staging, and the like. IaC could help streamline the whole software development lifecycle.
- Accuracy and consistency
  - Manual processes often lead to mistakes due to human error and poor communication. Manual infrastructure management will, in most cases, lead to discrepancies. IaC deals with this issue by ensuring the configuration files are the single source of truth. This makes sure that the same configurations will be carried out without inconsistencies.
- Visibility and accountability
  - IaC configuration files can be versioned like any source code file, so you can achieve full visibility into the modifications that each configuration has undergone.
- Version control
  - When infrastructure is expressed as code, it may be checked into, source controlled, code-reviewed and versioned using current software engineering operations. Modifications to infrastructure can be carried out using available CI/CD tools.
- Support for DevOps
  - With the setup of the infrastructure written as code, you can apply the same CI/CD pipeline steps that IT professionals use for application code, such as version control and automated testing. An organization could decide to use IaC alongside containers that remove the application from the infrastructure at the level of the operating system. Because the hardware and operating system infrastructure are provisioned automatically, and the application is enclosed on top of it, such technologies are relevant for various deployment goals, including staging, testing and production.

### Approaches

Automation best practices:

If you are a startup organization and an application or platform has not yet been created, don’t attempt to automate all processes from the start (this is because of the fast rate of change). When the platform is more stable, you will be ready to automate its maintenance and provisioning.
Use peer reviews with PULL requests and version control in the same manner as you would when detailing with developers. This will let you fully experience the advantages of infrastructure code being used by many team members and you will always have an additional set of eyes monitoring your infrastructure.
Use quality control and CI/CD for repository alongside your IaC—this will enable you to ensure a high level of code and get quick feedback loops from your DevOps developers or teammates (once changes have been applied). Fortunately, test frameworks exist that can help you write the tests—the earlier you attempt to cover everything, the greater benefit you will gain from it and you will experience fewer unexpected issues with infrastructure. You can’t deal with the application mistakes here, but you can be more assured of your infrastructure.
Apply the idempotency design principle. IaC code should generally be maintained in a manner that allows it to generate consistent results when you apply something and run it repeatedly. This typically requires eliminating certain bash scripts created by your system admins and replacing them with more dependable components of your IaC ecosystem.
Modularize the code. Most IaC tools let you write roles, modules, or any other abstraction that collects blocks of code into a single logical unit. By using modules, you can gain the same advantages as you would from creating a mature program in any language.

What you do not automate, make a backlog item for it!



## Ops models

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

- Getting to DevOps, automated deployment of infra where human intervention is required for compliance, management, approvals and quality assurance:

Simply put, DevOps teams use CI/CD to deliver software with less risk, to improve developer productivity, to deliver products that users require, and to release new features on a more frequent basis. In fact, research shows that the highest performing DevOps teams use tactics like CI/CD to make on-demand deployments multiple times per day, reduce change lead times to under one hour, restore services in under one hour, and minimize change failure rates to between 0-15%.


  - Everything-As-Code
    - Why?
      - Speed and efficiency
      - Consistency
      - Aligned with DevOps
      - Simplify edit, copy/reuse and distribute
      - Single source of truth.
    - Code versioning
    - Reducing access to the platform resources to the automation
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

- Progressing away from ClickOps and the error prone process of deploying things manually to more control:
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

## Unsorted

CRUD activities on Infrastructure as Code (Software Defined Infrastructure)

- Extreme automation - Cost/benefit - Return on investment
- Discuss different approaches to automation of the platform deployment and configuration (day 2 ops).
- Configuration changes on the platform can have huge implications on workloads running on it.
- Establishing a **4 eyes principle** could limit errors and mistakes when deploying or reconfiguring the platform.
- Different solutions to consider as teams transition from a **ClickOps** approach where changes happen in the portal.
- Tools that can push and pull configuration to and from Azure, allowing a dual mode of **ClickOps** and **DevOps**.
- Use of CI/CD to enable a **fail fast** approach where validation happens before deployment.
- Consider an approach of treating **Everything as Code** including but not limited to:
- What is being deployed and configured
- Details on how the automation does what it does (i.e. deployment logic as code, yml pipelines vs Release pipelines)
- How to handle rollback of changes
  - Infrastructure as Code (CI/CD, GitOps, DevOps)
  - Azure Policy (Blueprint?)
  - Azure Automation
  - Azure Functions
  - Scheduled jobs on CI/CD platform

How should automation be triggered?
- Code change (CI/CD)
- Scheduling
- event-driven
- state-driven
- both, or none?


Offload operations with automation to allow for the team to focus on product improvements.
Accept risk, just what?


Less operator intervation
More intelligent insights
Use more SaaS > PaaS > IaaS for automaiton

Today you can fire off an API call and have more compute power at your disposal than existed just a year ago. But to take advantage of this power, you need automation; and you need to be able to manage your infrastructure programmatically—at every layer.

You need powerful operations tools. You need to write code.

Years ago, we used to treat servers as pets (we'd even name them!) But now, the most competitive software firms are operating dynamic, hybrid infrastructures filled with containers, VMs, bare metal, and containers on VMs on bare metal that they might not even own. The proliferation of X-as-a-service (-aaS) systems (e.g., CDN, DNS, database, monitoring, security, and object storage cloud services) increases the complexity of this situation even further. The only agile way to manage this type of infrastructure is by treating servers as cattle, not pets—and we need programming code to act as the herder.

Seth Vargo, a developer advocate at Google, provides a map of the modern tooling ecosystem that operations and DevOps engineers need to understand. The categories include:

- Configuration management - Chef, Puppet, Ansible, SaltStack
- Containers — Docker or other Open Containers Initiative (OCI) compliant runtimes
- Infrastructure as Code — Terraform
- Continuous Integration (CI)/Continuous Delivery(CD) — Jenkins and the Jenkinsfile, Travis CI and the .travis.yaml file — Managing security and policy at scale — Vault — Container orchestrators — Kubernetes, Nomad

Vargo also lists the advantages that programming code gives you when managing operational complexity:

- Linting, static analysis, and alerting
- Testing
- Collaboration (a common language)
- Separation of concerns
- Model abstract concepts
- Theft (stealing ideas from the application development workflow)

Improve security, agility, efficiency, and to deliver software faster


And what is the future of infrastructure as code, if we keep following the innovations of software developers over the last decade?
- Less operator intervention
- Deeper automatic scaling insights
- Automatic security scanning and pen testing
- Automatic security patching
- AI & machine learning in operations (log analysis and anomaly detection)
- Machine learning-based distributed tracing
- Serverless / Functions

Vargo believes that another major paradigm shift will happen in operations when organizations move from a culture of fighting fires to a culture of starting fires.



Organizations turn to infrastructure as code tools to automate infrastructure deployment and streamline application development, particularly as it applies to DevOps. Infrastructure as code reduces many of the manual processes and inefficiencies of traditional approaches to deploy infrastructure. It can also help simplify infrastructure management and reduce operating costs, while eliminating inconsistencies between environments such as testing, staging and production.

To streamline operations even further, some organizations use infrastructure as code (IaC) in conjunction with composable disaggregated infrastructure (CDI), which provides a foundation for automating and orchestrating resource provisioning. A CDI appliance delivers a software-defined environment that abstracts the physical resources and makes them available as services that can be dynamically composed and recomposed. The composable architecture also helps optimize resource utilization and simplify general administration.

When an organization uses CDI and IaC together, they have a platform for easily allocating resources to meet changing workload requirements, without the deployment and maintenance headaches that go with traditional infrastructure. For organizations to use IaC effectively with CDI, they need the right tools. But selecting the best tool can be a difficult process because there are so many products to choose from and it isn't always apparent how they differ. The following IaC tools comparison examines eight popular services that take different approaches to IaC. Although some products might be better suited to CDI, each provides an effective tool for using IaC to automate resource allocation.

How composable disaggregated infrastructure supports IaC
- Provides a software-defined infrastructure that automatically controls the physical resources without human intervention.
- Can perform such operations as provisioning, configuration and management to meet workload requirements, as defined by the coded infrastructure.
- Disaggregates the physical resources and presents them as services, providing an extremely flexible environment for running modern workloads.
- Provides flexible building blocks for composing and recomposing resources on demand, making it possible to implement infrastructure as needed to accommodate changing workloads.
- Can better accommodate fluctuating requirements as infrastructure needs change, while using resources more efficiently.
- Can run workloads in VMs, in containers and on bare metal, making it easier to accommodate varied IaC requirements.
- Doesn't have to be preconfigured for specific workloads because resources are configured on demand.
- Minimizes administrative overhead with built-in automation and orchestration.
- Offers a comprehensive management API that enables third-party tools to interface with the environment, enabling organizations to use their existing IaC tools.



CONFIGURATION DRIFT
Regardless of how consistently or frequently you configure your servers, drifts in configuration may occur in the long run. This is why you should make sure there is no outside interference after you’ve established your IaC workflow. Every time you need to modify your infrastructure, you must ensure it is done according to your pre-established maintenance workflow. Should you still end up making some non-uniform changes to a similar system group, some of them will inevitably be different from the others, potentially resulting in a shift in configurations.

- Mitigation


POTENTIAL DUPLICATION OF ERRORS
Though the IaC implementation process and machine creation rely heavily on automation, there are still certain segments of the entire process that need to be done manually. Writing the parent code is one of those processes, and – naturally – there’s always potential for error when there’s human work involved. Even within an environment where QA checks are regular and consistent.
These errors (however minor in nature) could occur in multiple machines as a side-effect of automation. To make sure you are always on the safe side, we highly recommend double-checking the code that generates your IaC architecture. This can be done through strict and extremely consistent testing and thorough auditing processes. However, these additional efforts often lead to increased overheads.

- Mitigation - Tested modules


NEED FOR NEW SKILLS AND/OR STAFF
Since the Infrastructure as Code and DevOps models require high levels of technical expertise, certain management teams may face challenges involving the constant investing in staff and their skills. This goes for both your current employees and potential newcomers, which may prove too costly for some. This is why many organizations opt for outsourcing IaC services, especially during the initial stages of the implementation. This option is the go-to solution for them as it provides them with the opportunity to familiarize themselves with the procedure, tools, and best practice strategies. This leads to the optimization of their automation process in terms of both costs and the overall quality of their IT architecture.





### What is devops + extreme automation

DevOps is a growing movement that encourages closer collaboration of developers and system operations to help business goals to be achieved efficiently and on time. Software development and infrastructure scaling are very fast-paced nowadays. That brings a necessity of larger automation, measurement and information sharing for all involved processes.
Focuses on solving challenges that organizations face when implementing DevOps initiatives. It introduces principles of DevOps and tools that help reach full automation of infrastructure provisioning and software delivery. Theoretical background as well as practical hands-on examples of tools like AWS/GCP, Ansible, Terraform, Docker, Kubernetes, Helm, Prometheus, Grafana, Linkerd, Serverless and many others are given during this workshop.
- Unique content - real-life use cases, modern infrastructure, CI/CD/GitOps principles shown in practice.
- Join from the convenience of your office or home.
- Live and interactive - you can ask questions in the chat and get live clarifications.
- Q&A session in the end of each day - you will to get answers to more complex questions in a 1-hour long Q&A session.
- Practical exercises with solutions - lots of simple and not-so-simple tasks to practice with during the course; Solutions will be provided afterwards.
- Video recordings will be available after the course - you can revisit some topics later.
- Additional home work - for those who want to practice more after the course; Homework will be reviewed and supplemented by constructive feedback.
- Lifetime e-mail support - you can get answers on anything related to the course content as well as advice based on your company specific situation.
- Quizzes and polls during the course - learning should be fun.
- Certificate of attendance - you will get a shareable online certificate.
- Exam after the course - you may pass an optional 1-hour exam and get your score printed on the certificate.

- introduction to DevOps, infrastructure as code, immutable infrastructure, idempotence principle, delivery pipelines, GitOps
- managing virtual/cloud resources with IaC, tooling overview, building first infrastructure configuration pipeline with Terraform
- managing multi-cloud/multi-data-center resources with Terraform and Terraform modules
- integrating with classic server provisioning tools like Ansible
- dynamic inventories, network management, building complex infrastructure delivery pipelines, organizing team work
- managing base machine images with Packer
- introduction to containers and container management
- building/publishing images, running containers with Docker
- implementing complex use cases with Docker Compose
- using Kubernetes to run container workloads
- using Helm charts and Kubernetes operators
- leveraging service mesh features with Linkerd
- introduction to observability: logs, metrics, traces
- configuring Prometheus jobs and exporters, creating Grafana data sources and dashboards
- DevSecOps: integrating linters, security policy checkers, vulnerability scanners
- leveraging managed FaaS: OpenFaaS, Kubeless and Serverless
- implementing a chat bot for Slack for effective ChatOps
- introduction to chaos engineering



IT automation is the process of creating software and systems to replace repeatable processes and reduce manual intervention. It accelerates the delivery of IT infrastructure and applications by automating manual processes that previously required a human touch. With IT automation, software is used to set up and repeat instructions, processes, or policies that save time and free up IT staff for more strategic work. With the rise of virtual networks and cloud services that require rapid, complex provisioning, automation is an indispensable strategy for helping IT teams deliver services with improved speed, consistency, and security.
IT automation overcomes the static, manual nature of IT operations jobs that prevent successful digital transformation. The technologies manage tasks based on business policies and resources. The goal is to establish an effective mechanism of automation within the dynamic settings of the IT environment, workforce resources, and the business landscape.
IT automation is a powerful tool that can scale a business, result in faster operations and provide significant cost savings. A fully automated environment can reduce the time to delivery for production-ready resources from weeks to less than a day.
Here are 7 key considerations for you to implement and effective automation strategy into your business:

How to prioritize automation when you start?
- Gain a clear understanding of the process to be automated
  - Automation is about optimising and modernising processes. As such, organisations must understand all the steps in an existing process, identify which steps are necessary, where any existing bottlenecks are, and whether the process can adjust to new requirements as they evolve with the growth of the business.
  - That knowledge, combined with automation technologies, is how businesses can move from simple process improvement to real process transformation.
  - It is possible for organisations to optimise their processes without technology, but they can only SERIOUSLY transform and modernise them with the use of technology.
- Re-imagine workflow – then automate
  - Businesses and process owners need to take their understanding of a process and find ways to improve it though automation if they want to see real transformation.
  - It’s possible for automation technologies to be point solutions to automate specific activities here and there, but that doesn’t show the improvement that you could capture if you re-evaluate the entire process.
  - With that in mind, look for ways to make processes more efficient before even working on automation implementation, that way you will often find that there is plenty of room for workflow improvement.
  - Businesses will find there are certain things they do for no other reason than because that was always the way they did them. Implementing automation helps transform your processes by taking out as many steps as possible and streamlining them.
  - To understand existing requirements and processes, your IT team should work with functional area teams to understand the flow of work and identify unnecessary steps. Ask yourself, are we doing something because 10 years ago, when we build the process, it was the only way to get the work done and whether it’s still relevant for the business today?
  - If you fail to evaluate and optimise processes before automating them, you risk perpetuating inefficiencies for a long time to come.
- Establish a modern IT stack
  - Automation is best suited when you have an infrastructure within IT that supports integration and rapid changes.
  - Often you will find that you are unable to automate business processes with legacy architecture and will need to be using a modern IT infrastructure to have the advantage. For example, automating certain processes requires cloud computing, sophisticated data analytics, application programming interfaces (APIs) and, of course, some level of AI capabilities already working in the IT environment in support of the automation initiative.

- Choose the right tools for your organisation
  - Pick the right automation tools for your organisation and automating on a toolchain that your staff don’t want to use, or is unnecessarily complex, or simply doesn’t match your needs – will create problems that will thwart success.
  - Any solution with too steep of a learning curve will be a turnoff for most of your team, who are already busy trying to get their day-to-day work done.
  - When selecting an ideal automation toolbox, focus on three key factors – flexibility, simplicity and usability. From setup and deployment to long-term ease of use, each of these attributes in your automation tools will deliver long-term results.

- Manage change and service requests
  - As is the case with any technology enabled initiative, businesses must have in place a strong change-management strategy so that the users impacted as a result of automation will adjust to the new workflow, rather than rejecting the changes.
  - Many users fear that they’ll be replaced by technology, but automation doesn’t necessarily mean job loss. Rather, it creates additional capacity for workers, and Return on Investment (ROI) giving them time to shift to higher-value work and the new initiatives being created by advancing technologies.
  - Still, staff need to understand retooled workflows and adjust to their roles in automated processes, and they need to understand how their overall jobs are influenced and affected by automation.


- Automate processes as part of a long term plan
  - It is important that you begin your automation process in stages rather than trying to tackle your entire software development lifecycle, or a similarly large workflow all at once.
  - Your step-by-step approach to automation should be part of a larger long-term plan to achieve your goals. Circumstances will change, the environment will mature, and new requirements will arrive on a regular basis. Those conditions will require the maintenance and updating of your automation framework.
  - A key part of that long-term plan will be accounting for ongoing operations and optimisation. Don’t fall for the misconception that automating a process means you’ll never have to think about it again, or that it won’t require human intervention. Automation, like any other spoke in the lifecycle, is a feedback loop requiring monitoring and maintenance.
  - There’s no end point to the improvements you could be making and the return on investment of automation. Lumina Technologies can help you with all your IT needs including working with you to devise an IT automation journey. We offer IT support for all our clients and ensure that an effective IT strategy is in place.


### Considations for implementing automation:

Describe why a platform team should consider automating platform deployment/configuration for an evolving platform.
- Reduce manual errors. Manual data entry is prone to human errors. So, the first of the benefits of automation is that it can take on manual data entry tasks on your behalf – meaning reduced risk of human error. This ensures consistent quality in your data entry. (And across the board).
- Reduce employee workload, improve productivity. With automation software, teams are no longer forced to spend precious time on tedious admin. This, in turn, helps to boost productivity. With fewer processes and rote tasks holding them back, your team members can get more done.
- Improved worker safety. Automated cells remove workers from dangerous tasks. Your employees will thank you for safeguarding them against the hazards of a factory environment.
- Rapid reactions. Another of the benefits of automation is that the tool allows for rapid reactions when they’re needed most. Business process automation software can parse incoming data — your emails, your web forms, social media, system data, etcetera. Then, it can alert you to things like complaints or service outages. Automation can also reply to incoming messages for you. So, you get increased speed of resolution when things go wrong.
- Reduced lead times. Automation can keep your process in-house, improve process control and significantly reduce lead times compared to outsourcing or going overseas.
- Boost morale and teamwork. The benefits of automation are all great within themselves. But, as an added boon, they also combine to create a happier working environment. With the stress of repetitive processes gone, employees enjoy boosted morale. Plus, it makes complex processes easier to manage. So, teams can collaborate with each other with increased ease. This adds to a healthy workplace atmosphere.
- Cut costs. Business process automation also helps you cut costs. Software doesn’t tire or run out. So, you can get more done with less resource spent. In other words, for the price of BPA software, you get more processes done in less time. Robots can perform the work of three to five people, depending on the task. In addition to savings on the cost of labor, energy savings can also be significant due to lower heating requirements in automated operations. Robots streamline processes and increase part accuracy, which means minimal material waste for your operation.
- Faster ROI. Automation solutions are based on your unique needs and goals and pay for themselves quickly due to lower operating costs, reduced lead times, increased output and more.
- Optimise skillsets. While automation handles the repetitive and mundane, your team can put their unique skills to work. That is, they get to work on the business, not just in it. This is one of the key benefits of automation — it opens the way for human teams to focus on high-skill, creative tasks that further business growth.
- It promotes efficiency. The act of deploying automation software alone unlocks one of the benefits of automation. Because you set up the processes and rules you want the software to complete, you get to audit and refine your processes. So, you’ll identify any broken or unnecessary workflows. As a result, you get improved operational efficiency. You can also improve the efficiency of your vital processes, to boot.
- Consistent and improved part production and quality. Automated cells typically perform the manufacturing process with less variability than human workers. This results in greater control and consistency of product quality.
- You gain data-led insight. Businesses today collect a lot of data. But it’s not always easy to use. Quite often, large portions of it end up unused. Herein lies another of the benefits of automation. Automation software can help you unlock the insights locked in the data you collect. With tools like sentiment analysis, and the ability to create complex operational reports, you gain insights into more aspects of your business. Your data is no longer collecting cobwebs.
- Clear accountability, easy compliance. Another of the benefits of automation is the improved clarity of your processes. Your business runs on exact rules. So, it’s easy to ensure that your workflows comply with legislation. Plus, it enables audit trials, records and alerts. So, you get a clear view of what, how and when things go wrong.
- Scalability. Finally, automation software scales with you. You can add, subtract, tweak and rewrite rules as you see fit. So, you can enjoy the benefits of automation no matter where you are in your business journey and how much your organisation grows.
- Ability to be more competitive. Automated cells allow you to decrease cycle times and cost-per-piece while improving quality. This allows you to better compete on a global scale. Additionally, the flexibility of robots enables you to retool a cell to exceed the capabilities of your competition.
- Increased production output. A robot has the ability to work at a constant speed, unattended, 24/7. That means you’ve got the potential to produce more. New products can be more quickly introduced into the production process and new product programming can be done offline with no disruption to existing processes.


- Track your infrastructure. Terraform keeps track of your real infrastructure in a state file, which acts as a source of truth for your environment. Terraform uses the state file to determine the changes to make to your infrastructure so that it will match your configuration.
- Collaborate. Terraform allows you to collaborate on your infrastructure with its remote state backends. When you use Terraform Cloud (free for up to five users), you can securely share your state with your teammates, provide a stable environment for Terraform to run in, and prevent race conditions when multiple people make configuration changes at once. You can also connect Terraform Cloud to version control systems (VCSs) like GitHub, GitLab, and others, allowing it to automatically propose infrastructure changes when you commit configuration changes to VCS. This lets you manage changes to your infrastructure through version control, as you would with application code.
- Standardize your deployment workflow. Providers define individual units of infrastructure, for example compute instances or private networks, as resources. You can compose resources from different providers into reusable Terraform configurations called modules, and manage them with a consistent language and workflow. Terraform's configuration language is declarative, meaning that it describes the desired end-state for your infrastructure, in contrast to procedural programming languages that require step-by-step instructions to perform tasks. Terraform providers automatically calculate dependencies between resources to create or destroy them in the correct order.

- Get people on board
  - If you're mostly thinking about your automation project in terms of technology, then think again... Although technology might provide us with the tools to automate, building the technical solution is actually the easiest part of any project. Much more difficult is the change management aspect – making automation part of your organisation's DNA. This involves understanding the impact it will have on the way the business works and on your people.
  - Many people understandably have concerns about the idea of automation, whether that's hesitancy around the new and unknown or the real fear that a robot might replace them.
  - It is extremely important to communicate openly about the project, establishing two-way channels of communication, space for people to ask questions, and an understanding of the benefits automation will bring to your workforce. The success of any technology depends on the full support of the people who will use it, so get them on board as soon as you can.
  - Starting small and scaling quickly with your automation project is a really good way of rapidly releasing value back to the business - this can also boost engagement as staff are able to see the benefits for themselves.

- What's your long term automation strategy?
  - Senior leaders often turn to automation as a way of gaining efficiencies in a specific department or process. Approaching it in this way – as a point solution – will release staff time and provide cost savings. But it doesn't deliver the most impactful benefits in the long term.
  - Instead, the best results are gained when automation is approached at the level of the entire organisation. This ensures that automated processes don't get caught up in residual manual bottlenecks, and typically enables the automation of many more processes than expected.
  - Ideally, organisations should aim to become automation-first, automating as many existing processes as possible, and – when any new tasks or roles are required – turning to automation in the first instance. This is true strategic automation, and it will unlock huge productivity gains for your organisation.

- What will your team do once their time is released?
  - This might seem like an obvious question, but it's worth getting on top of. Automation projects are unusual in the sense that it is possible to provide accurate and detailed figures on return on investment from the outset.
  - You'll have a clear sense of the time and costs you will save, so it's important to know where you will redeploy your staff, and how they can best add more value to the organisation. Asking this question will also help you to pin down why you are pursuing this project, and think more clearly about its purpose.

- How will you communicate the benefits of automation?
  - Once your automation is up and running, and you've begun to reap the benefits – shout them from the rooftops. Show off your metrics including time and costs saved, improved staff satisfaction, and that all-important anecdotal evidence about how employees' working lives have been transformed. Engaging with senior stakeholders, ideally at board level, will help to prove the value of automation, and secure budget for future projects.
  - (Hopefully you'll get a thank you for all your hard work too...)

- What comes next?
  - You've laid the groundwork, built a software robot, and set it to work. So what's next? If your automation project has been a success, you'll likely want to do more. But working with external automation experts – whilst important for getting you started – isn't cost-effective in the long run.
  - You'll probably want to look into bringing automation capability in-house, developing a community of excellence. This might be through upskilling existing teams, or by new hires. Whatever you choose, know that your external partner should transfer their knowledge to you across the entire project. This is something we at Foundry4 do as standard, as it makes for successful, sustainable digital transformation.

- Automation for the win
  - So there you have it - five key pointers for automation, which will stand you in good stead to make your automation journey as successful as possible.
  - If you'd like more information, you'll find lots more resources across our website, including the success stories of organisations we've partnered with. To discover how automation can help your specific needs, get in touch and we'll be more than happy to help.


### How to automate


Selecting a tool to aid your project or organisation with the implementation of automated software testing can be a daunting task. Many tools are available, each of them with its own benefits and drawbacks. The following considerations will provide you with some much-needed guidance in the test tool selection process.


- What kind of technology is to be automated?
  - The choice for a specific automated testing tool heavily depends on the type of application(s) your tests are written for. Many tools are specifically designed for a single type of application, such as Selenium, which is targeted towards websites and web applications running in a browser. Other tools are able to handle a lot of different types of applications, such as browser applications, Windows applications and SAP. Tools that fall into the latter category tend to be more expensive, but might be the better choice if your test scripts cover different types of applications.

- Do I go for open source or for commercially licensed tooling?
  - At first sight, going the open source route when selecting an automated testing tool might seem the most cost-effective option, due to the lack of license fees and support contract fees that typically come with commercial test tools. However, open source tools come with necessary investments of their own, as it often takes more time and more technical (programming) knowledge to set up and maintain automated test scripts. One often overlooked advantage of open source test tooling is the fact that the more popular ones are often supported a large community on the Internet. This community can be tapped into for technical support and often offers a library of additional features and extensions for the tool in case.

- Do I prefer in house implementation or do I want to outsource test automation activities?
  - Another consideration to make is whether to have your own team implement the automated test scripts or to leave this to a third party. Keeping automated test development in house has a number of benefits, such as:
  - The people working on test automation are likely to be very familiar with the application(s) under test.
  - Knowledge gained on test automation is retained within the organisation.
  - The opportunity to work on test automation might be a good motivator for people in the organisation willing to learn something new.
  - On the other hand, outsourcing test automation implementation also has certain benefits, the most important being that dedicated test (automation) service providers likely have a lot of experience with the selected tool, enabling them to implement it much more efficiently.

- How much training is required for the implementation of test automation?
  - Some tools require more technical knowledge upfront before users can successfully automate tests with it, while others do all they can to abstract from the technical details and offer an interface that makes it possible to implement and run automated tests for everybody. The former category of tools typically requires more training for them to be used. Another factor to be considered is the programming or scripting language used by the automated test tool. If, for instance, a tool is Java-based and all you have in your company are PHP developers, more training might be required than when your software development department – and the testers included in it – works with Java on a daily basis.

- Does the tool match our current software testing process?
  - Finally, another thing worth considering is the extent to which the tool matches your current software testing process. Questions that you might want to ask with respect to this are:
  - Do the reports produced by the tool match the information requirements from the software development team and from management?
  - Does the tool integrate nicely with my current or desired automated build or continuous integration software delivery setup?
  - Can scripts be run by everybody within the software development and testing team? Note that this differs from who is going to develop the scripts.
  - When there is a mismatch between the features of the tool under consideration and your current software testing process, there are two further options. One is to consider a different tool that better fits the process, the other is to adapt the process to fit around the tool. The former is generally the more preferable, but in some cases where the testing tool fits the software to be tested perfectly, it might be worthwhile to adapt your testing process in some points to get a good match between the two.

### Benefits of automation


- Increased transparency and accountability
  - The IaC source code files are configuration controlled and can be versioned, enabling traceability, rollbacks, and branching.

- Repeatable configuration consistency:
  - Configuration drift appears when ad hoc changes or updates result in asymmetric development, test, staging, and production environment. IaC prevents configuration drift by provisioning the identical and reproducible environment every time, irrespective of their size. The environment can be easily scaled by calling the centralized/reusable module with the reserved configurations as many times as required.

- Speed, more efficient development:
  - IaC increases the velocity of every step of the software delivery lifecycle. Apart from setting up the entire infrastructure quickly within a short turnaround time, it also increases agility in maintenance. This can be realized in any environment, from the development to production stage, that helps achieve lean and agile operations and hence faster time to market.

- Essential in multi-cloud:
  - Multi-cloud environments have distinct software-defined APIs. IaC is the most effective way to abstract the layers from the heterogeneity of the underlying cloud.

- Protection with documentation and risk mitigation:
  - This acts as a live documentation that is constantly updated as changes are implemented. It makes sure that provisioning intelligence stays in the system, thus mitigating the risks of people change.

- Cost optimization:
  - IaC offers better ROI over traditional methods as it dramatically reduces the time and need to hire specialized skillsets to provision, scale, and manage the infrastructure. Organizations can maximize the advantage from utility-based constructs by employing cloud computing solutions. They can also realize cost savings by utilizing automation strategies that prevent technical experts from performing error-prone, manual tasks and spending more time developing innovative and mission-critical applications.

Here are some of the ways in which IaC can be adopted for rapid modernization:
- Hybrid cloud platform aids enterprises to integrate a private cloud to multiple public cloud solutions. Such cloud solutions with IaC promises to deliver better flexibility to businesses by switching tasks between several cloud solutions and providing insights in intelligent visualization, orchestration, and optimization for infrastructure and application in hybrid environments.
- Distributed Storage Service helps store data on multiple standard servers that act as one storage system, although the data is distributed among these servers. Features such as scalability, fault-tolerance, and power consumption of the distributed storage for a data center become the core aspect of cloud computing to ensure reliability and data availability.
- Composable infrastructure simplifies management and streamlines operations by providing a unified infrastructure model with comprehensive API architecture, available to both developers and administrators. This type of infrastructure makes it easy to create and delete resources on demand while supporting extensive automation and orchestration, as well as DevOps methodologies.

- Matching the pace of innovation with HCL Cloud Smart
  - HCL Cloud Smart offers a diverse portfolio of innovative cloud services backed by intelligent automation and a broad partnership ecosystem. HCL Cloud Smart approach acts as a robust accelerator that helps organizations maximize their business value and accelerate the pace of digital transformation to achieve business goals. Based on the cloud smart strategy, HCL has extensive expertise in leveraging IaC to automate the management of Cloud Infrastructure and application lifecycle, including discovery, inventory, provisioning, configuration, and continual compliance. These solutions enable IT organizations to implement a policy-based automation solution for managing the data centers while ensuring the highest uptime for the business-critical services supported by a robust security model.
  - In today's fast-paced world, organizations must be flexible and quick enough to respond to ever-changing market needs and balance diverse consumer demands. IaC is a crucial element for successful digital modernization. It offers automation solutions across the development, testing, and deployment process that in turn helps improve the quality of software, boost cohesiveness across all the teams, and invariably reduce the overall deployment timeline. IaC helps to realize the true value of cloud computing by providing practices and tools in a unified way to get better functional applications. IT and DevOps teams can reap extensive benefits from IaC in the form of speed, security, reliability, and more. The platform helps in the efficient delivery of new applications and systems, mitigates risks, and enables organizations to be more collaborative, agile, and innovative.

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

## Considerations Platform automation

## Recommendations for Platform automation

Use **Everything as Code** approach for full transparency and configuration control of the Azure platform.
Packages for deploying, where are the packages coming from (Single/Multi repo, Bicep Reg)?

## Read more

- [Adopt policy-driven guardrails - Cloud Adoption Framework | Microsoft Docs](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance)
- [Fundamentals of Bicep - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/fundamentals-bicep/)
- [Intermediate Bicep - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/intermediate-bicep/)
- [Advanced Bicep - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/advanced-bicep/)
- [Deploy Azure resources by using Bicep and GitHub Actions - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/bicep-github-actions/)
- [Deploy Azure resources by using Bicep and Azure Pipelines - Learn | Microsoft Docs](https://docs.microsoft.com/learn/paths/bicep-azure-pipelines/)
- [Control and govern your Azure environment by deploying your infrastructure as code - Learn | Microsoft Docs](https://docs.microsoft.com/learn/modules/control-govern-azure-environment-deploying-infrastructure-code/)
