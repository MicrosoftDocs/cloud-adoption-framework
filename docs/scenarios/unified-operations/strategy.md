---
title: Strategy for adopting unified operations
description: Describe the scenario's impact on strategy
author: brianblanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: e2e-hybrid
---

# Strategic considerations of hybrid and multicloud operations

Best practice encourages customers to create a single centralized cloud adoption strategy, using the [Cloud Adoption Framework's Strategy methodology](../../strategy/index.md). If you haven't already, use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) to record your cloud adoption strategy. This article will help expose a number of technical considerations regarding hybrid and multicloud that may have an impact on your strategy.

## Common motivations for hybrid and multicloud

Hybrid and multicloud is not a strategy. It is a technical approach with dependencies on specific architectures and tools, which can accelerate a number of business and technology strategies. The following are a few of the common strategic motivations that can be affected through the use of hybrid and multicloud:

- **Critical business events:*- responding to critical business events is a common driver for hybrid and multicloud adoption. The ability to *connect multiple environments with hybrid networks and move workloads between platforms- allows technology staff to more effectively respond rapidly to business changes from a datacenter exit, to merger/acquisition events, or even changes to regulatory compliance.
- **Migration motivations:*- looking beyond immediate and critical events, migration and modernization motivations strive for mid-term optimization of technology costs, operational complexity, and business agility. Connectivity between the current environment and the cloud provider allows for one-way migration capabilities. Use of abstraction layers, like containers, Kubernetes, or Azure Kubernetes Service (AKS) streamline the migration process.
- **Innovation motivations:*- when building solutions to drive long-term innovation, hybrid and multicloud may accelerate development efforts. Containers, Kubernetes, and AKS allow developers to build solutions with less dependencies on the features of any one cloud platform. Azure Stack (hci, hub, and edge) allow developers to continue innovating with cloud native solutions, even in the local, on-premises datacenter. Conversely, connectivity across multiple clouds allows developers to maximize the use of cloud native services on their chosen platform, while integrating across those clouds for holistic enterprise environments.

Review a detailed list of [common motivations](../../strategy/motivations) to see which of the above most closely maps to your organization's strategy.

## Hybrid and multicloud outcomes

Before executing on any cloud strategy, best practice also suggests that the cloud strategy team establish a clear set of [measurable business outcomes to track progress](../../strategy/business-outcomes/index.md). Hybrid and multicloud alone is unlikely to deliver any of the common business outcomes. But enabling hybrid and multicloud is often a required milestone and is often tracked as a key result required to unlock business outcomes.

Hybrid and multicloud is also commonly used as a tactic to acclerate the following business outcomes:

- Agility, Global Reach, and customer outcomes: The ability to move between cloud providers allows businesses to more easily deploy to the cloud platform that can best address each of these business outcomes.
- Application innovation, data innovation and data democratization outcomes: Each is accelerated by allowing development and analytics teams to manage and work with applications and data, regardless of the chosen cloud platform.

## Technical considerations

Hybrid and multicloud connectivity, container hosting, and hyperconverged infrastructure can each accelerate your strategy. But each comes with the following technical considerations that should be included in your overall strategy and cloud adoption plan:

- How will you maintain governance, management, and compliance across hybrid and multicloud?
- How will you consistently manage identity and security?
- How will you manage and govern data safely?
- How will you safely transfer data across distributed environments?
- How will you integrate disparate environments?

## Unified operations considerations

There may be diverse strategic impacts as a result of various hybrid and multicloud decisions. But there is one constant considerations in any strategy that involves hybrid and multicloud; investments in unified operations and a single cloud control plane will reduce roadblocks to your hybrid and multicloud projects. The following are key considerations for unified operations:

Organizations might require **improved visibility and control over their IT estate**. They want the ability to see all their resources in a single location, and be able to query through them to gain insights.

Another outcome companies may desire is **cloud-based management**-the ability (across platforms) to modernize operations with the same cloud management services, on resources in locations that are outside of Azure.

**Governance*- is an important outcome for companies wishing to ensure consistent configurations across all resources, from one central location.

**DevOps and flexible, cloud-native application deployments*- would provide organizations the agility of deploying application infrastructure through templates, and application configurations through GitOps.

Organizations might also benefit from **increased flexibility when adopting PaaS**, with the ability to run PaaS services on their infrastructures of choice.

Deploying a single enterprise control plane can accelerate hybrid and multicloud adoption. Organizations can develop cloud readiness with cloud skilling efforts and process improvements that assume unified operations; bringing innovative cloud practices and technologies to on-premises environments, while preparing other workloads for migration to the cloud. A single cloud operations management dashboard can help you to manage and govern your operations consistently across on-premises, multicloud, and edge environments. You gain greater visibility (into assets scattered across environments), cross-team accountability, and faster, consistent, and at-scale deployments for developers.

## Accelerate hybrid and multicloud adoption with unified operations

Starting comprehensive cloud readiness and skilling initiatives can accelerate cloud adoption and migration efforts across your organization. Assess and advance cloud readiness, implementing innovative cloud practices in your workloads that will remain on-premises, and adopt cloud technologies to prepare other workloads that you might move to the cloud. Work with your cloud strategy team, and build the necessary cloud skilling and processes to prepare for your migration effort to a hybrid and multicloud environment.

How can unified operations transform your organization's cloud adoption and migration effort?

Azure Arc extends one enterprise control plane with Azure management and services across hybrid, multicloud and edge environments-enabling a consistent state across heterogeneous resource environments and infrastructures.

- **Address data sovereignty and sensitivity, *- delivering data in the private and public cloud with minimal changes per platform.
- **Practice frictionless development, *- supporting both disconnected and connected use cases.
- **Bring innovative Azure services to any location, *- deploy faster, consistently, and achieve elastic scale based on capacity.
- **Empower developer teams across the enterprise with the ability to build cloud applications anywhere, at scale, *- coding and shipping applications to container and Kubernetes clusters anywhere.
- **Consistently speed up development, at scale, *- with templatized deployment, configuration, and security, and reduce errors with policy-driven deployment and operations.
- **Promote greater accountability for enterprise IT teams, *- extending a uniform enterprise control plane from Azure Arc by centralizing visibility, operations, and compliance across resources and locations.
- **Organize, govern, and secure across on-premises, multicloud, and edge, *- on Windows, Linux, SQL Server, and Kubernetes.
- **Maintain standardized management and security with unified operations, *- to ensure consistency across data workloads.

Hybrid and multicloud environments is the most common reality found across today's enterprise IT landscape. For most customers, moving to a hybrid and multicloud scenario is simply embracing market reality, and motivated by a sound business strategy. The next decision for your organization would be committing to a distributed cloud computing model that can increase the speed of your cloud adoption and migration efforts. Initiating a cross-team effort to increase your cloud readiness with innovative cloud practices and technologies is the first step towards implementing one enterprise control plane. Consistently protect and monitor resources, standardize governance and security, and manage your operational processes on-premises, multicloud, and edge. Consider a hybrid and multicloud environment to manage your overall digital estate if you are planning a hybrid strategy by design for the next 12 months or longer.

Work with your [cloud strategy team](../../get-started/team/cloud-strategy) to build the necessary skilling and processes to prepare the move to an enterprise control plane across hybrid, multicloud, and edge that encourages greater accountability within IT teams, empowers developer teams, and extends Azure-services to any infrastructure, anywhere.

## Unified operations motivations

There are various [motivations](../../strategy/motivations.md) that might steer customers to adopt a hybrid and multicloud approach. Adopting the right cloud strategy depends on documenting what classification the majority of these motivations are associated with: critical business events, migration, or innovation.

Customers may have a digital estate that is bound by specific regulatory requirements, and data localization laws that constrain in which geographic location it must reside. A particular industry might require low latency and high connectivity for efficient operational capacity, such as financial services. Low-latency and high-connectivity are common requirements for other industries such as media, healthcare, education, and government.

A multinational organization, for example, might have globally distributed, legacy datacenters, with an aging infrastructure that is simply not compatible with a company-wide migration effort. Or, there may be corporations with even larger cloud estates that are sprawled across several cloud environments, where visibility and control of IT operations is challenging.

## What are the overall benefits of a multicloud control plane?

### Uniform governance and compliance

Azure Arc provides:

- A single pane of glass view of all your resources, including Windows, Linux, SQL servers, and Kubernetes containers, to capture and track an accurate inventory of IT assets.
- Reduces risk in your organization by establishing a unified governance framework and applying a standard set of policies for all workloads.
- For server and application owners, a view of the compliance status of servers, ability to take necessary remediation steps from the Azure portal, and removing management overhead from central IT departments for tracking and ensuring adherence to compliance standards.

### Consistent deployments, change control, and DevOps everywhere

Azure Arc enables you to adopt cloud practices on-premises. Deploy applications using a consistent approach with familiar tools and practices across your Kubernetes clusters, on any infrastructure. Standardize change control with declarative configuration management systems like GitOps. Easily adopt DevOps techniques like infrastructure as code (IaC), and empower developers with self-service access to a rich selection of tools.

### Deploy and manage Azure data services anywhere

Azure Arc enabled data services provide you with the flexibility to deploy fully managed Azure services anywhere, on-premises or public cloud. Extend cloud benefits everywhere, providing scalability, fast deployment, and always up-to-date cloud innovation, while adhering to regulatory requirements. Deploy and manage data services within on-premises environments or in customer regions, and reduce latency. Access the latest Azure features and capabilities for on-premises data workloads. Join our public preview - deploy evergreen SQL (SQL Managed Instance) and PostgreSQL hyperscale on any infrastructure, and benefit from automatic updates, patches, and upgrades with no application downtime.

## What are the benefits of a multicloud control plane for IT departments?

For IT administrators, Azure Arc brings consistency and a unified dashboard with a consistent view into thousands of servers across customer environments. Use existing tools on-premises to seamlessly interact with resources, without interfering with existing management tools.

### Inventory management and resource organization

Control resources at organizational, team, and personal levels, and bring them into a single system to organize and inventory through a variety of Azure scopes (e.g., management groups, subscriptions, and resource groups). Create, apply, and enforce standardized and custom tags to keep track of resources. Build powerful queries and search global portfolios (with Azure Resource Graph).

### Extend cloud practices on-premises

Easily adopt DevOps techniques like infrastructure as code (IaC). Empower developers with self-service access to a variety of tools, and centralized IT governance and guidance. Standardize change control with declarative configuration management systems like GitOps.

### Easily implement Azure security anywhere

Access Azure Security Center's system of unified infrastructure security management, and strengthen your security posture with advanced threat protection across hybrid workloads in the cloud-whether in Azure, multicloud, or on-premises. Centrally access and manage all resources with Azure role-based access control (Azure RBAC). Centrally manage and enforce policy compliance, and simplify audit reporting with Azure Policy.

### Governance and configuration of resources anywhere

Standardize activities by creating, applying, and enforcing policies to Kubernetes applications, data, and infrastructure anywhere. Set guardrails across all resources with Azure Policy. Ensure consistent configurations to a single server, cluster, or data service, or at scale by using inheritance capabilities. Standardize role-based access control (RBAC) across systems and different types of resources. Automate and delegate remediation of incidents to service teams without IT intervention. Enforce runtime conformance and audit resources with Azure Policy.

### Unified tools and experiences across platforms

Create a shared application and infrastructure lifecycle within teams traditionally siloed by location, skill, and job description. Simplify work with a unified, consistent view of resources across datacenters, edge locations, and multicloud through the Azure portal and Azure API Management. Connect and gain access to Windows and Linux virtual machines (VMs), physical servers, any Kubernetes distribution within the Kubernetes ecosystem, and bring Azure data services to on-premises, multicloud, and edge environments with Azure Arc enabled data services. Establish clear roles and responsibilities for team members with clear separation of concerns, without losing visibility and access.

### Integrated DevOps and management capabilities

Select additional Azure Arc - enabled services, Azure development, and operational tools that are developer tooling-agnostic. Access a unified enterprise dashboard that grants you a consistent view across environments-with GitHub, Azure Monitor, Security Center, Azure update integration, and more. Deploy common templates to automate configurations, and deploy infrastructure as code to make safe and repeatable production deployments. Manage end-to-end identity and access across all users and resources with Azure Active Directory (Azure AD), enterprise identity service, and Azure Resource Manager.

## Next step: Plan for hybrid and multicloud

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you become successful in your particular cloud adoption scenario.

- [Plan for hybrid and multicloud](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Hybrid and multicloud migration](./migrate.md)
- [Govern hybrid and multicloud environments](./govern.md)
- [Manage hybrid and multicloud environments](./manage.md)
