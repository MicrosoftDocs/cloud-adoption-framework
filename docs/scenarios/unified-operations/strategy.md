---
title: "Strategy for adopting unified operations"
description: Describe the scenario's impact on strategy
author: mpvenables
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic impact of hybrid and multicloud operations

## Executive summary

Few organizations jump straight into a cloud-native portfolio. To avoid possibly slowing cloud adoption and migration efforts across your organization, [dispel myths about moving to the cloud](<https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/cloud-migration-business-case>). There are sound [motivations](<https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/motivations>) to retain part of your digital estate on-premises, and desire business outcomes tied to to the innovations of cloud services where you might consider a hybrid and multi-cloud scenario to be beneficial to your organization.

Before considering a hybrid and multi-cloud scenario, customers may have several valid concerns: 
* Maintaining governance, management, and compliance
* Managing identity and security
* Migrating data
* Integrating disparate development environments
* Managing data management tools
* Transferring data across scattered resource environments

Deploying a single enterprise control plane can accelerate cloud adoption and migration. Organizations can develop cloud readiness with cloud skilling efforts and process improvements that assume unified operations—bringing innovative cloud practices and technologies to on-premises environments, while preparing other workloads for migration to the cloud. One cloud operations management dashboard can help you to manage and govern your operations consistently—across on-premises, multi-cloud, and edge environments. You gain greater visibility (into assets scattered across environments), cross-team accountability, and faster, consistent, and at-scale deployments for developers.

## Accelerate cloud adoption and migration efforts with one enterprise control plane

Starting comprehensive cloud readiness and skilling initiatives can accelerate cloud adoption and migration efforts across your organization. Assess and advance cloud readiness, implementing innovative cloud practices in your workloads that will remain on-premises, and adopt cloud technologies to prepare other workloads that you might move to the cloud. Work with your cloud strategy team, and build the necessary cloud skilling and processes to prepare for your migration effort to a hybrid and multi-cloud environment.

How can one enterprise control plane transform your organization's cloud adoption and migration effort?

Azure Arc extends one enterprise control plane with Azure management and services across hybrid, multicloud and edge environments—enabling a consistent state across heterogeneous resource environments and infrastructures.

**Promote greater accountability for enterprise IT teams,** extending a uniform enterprise control plane from Azure Arc by centralizing visibility, operations, and compliance across resources and locations.

**Organize, govern, and secure across on-prem, multicloud, and edge,** on Windows, Linux, SQL Server, and Kubernetes.

**Empower developer teams across the enterprise with the ability to build cloud apps anywhere, at scale,** coding and shipping applications to Kubernetes clusters anywhere, all from Azure.

**Consistently speed up development, at scale,** with templatized deployment, configuration, and security, and reduce errors with policy-driven deployment and operations.

**Bring innovative Azure-Arc enabled services to any location,** deploy faster, consistently, and achieve elastic scale based on capacity.

**Maintain standardized management and security with unified operations,** to ensure consistency across data workloads.

**Practice frictionless development,** supporting both disconnected and connected use cases.

Hybrid and multi-cloud environments are the most common realities found across today's enterprise IT landscape. For most customers, moving to a hybrid and multi-cloud scenario simply means embracing market realities and being motivated by a sound business strategy. The next decision for your organization is committing to a distributed cloud computing model that can increase the speed of your cloud adoption and migration efforts. Initiating a cross-team effort to increase your cloud readiness with innovative cloud practices and technologies is the first step towards implementing one enterprise control plane. Consistently protect and monitor resources, standardize governance and security, and manage your operational processes on-premises, multicloud, and edge. Consider a hybrid and multicloud environment to manage your overall digital estate if you are planning a hybrid strategy by design for the next 12 months or longer.

Work with your [cloud strategy team](<https://docs.microsoft.com/azure/cloud-adoption-framework/get-started/team/cloud-strategy>), to build the necessary skilling and processes to prepare the move to an enterprise control plane across hybrid, multicloud, and edge that encourages greater accountability within IT teams, empowers developer teams, and extends Azure-services to any infrastructure, anywhere.

## Unified operations motivations

There are various [motivations](../../strategy/motivations.md) that might steer customers to adopt a hybrid and multi-cloud approach. Adopting the right cloud strategy depends on documenting what classification the majority of these motivations are associated with: Critical business events, migration, or innovation.

Customers may have a digital estate that is bound by specific regulatory requirements, and data localization laws that constrain in which geographic location it must reside. A particular industry might require low latency and high connectivity for efficient operational capacity, such as financial services. Low-latency and high-connectivity are common requirements for other industries such as media, healthcare, education, and government.

A multi-national organization, for example, might have globally distributed, legacy datacenters, with an aging infrastructure that is simply not compatible with a company-wide migration effort. Or, there may be corporations with even larger cloud estates that are sprawled across several cloud environments, where visibility and control of IT operations is challenging.

## Unified operations outcomes

When customers execute on their cloud strategy and choose hybrid and multicloud scenario, they expect to see business outcomes supported by specific efforts that drive crucial business results, [outcomes grounded in cross-team consensus](../../strategy/business-outcomes/index.md).

Outcomes include:

* **Improved visibility and control over an IT estate** - The ability to see all resources in a single location, and be able to query through them to gain insights.
* **Cloud-based management** — The ability (across platforms) to modernize operations using the same cloud management services on resources in locations that are outside of Azure.
* **Governance**  - An important outcome for companies wishing to ensure consistent configurations across all resources from one central location.
* **DevOps and cloud native app deployment flexibility** - Provides organizations the agility to deploy app infrastructure through templates and app configurations through GitOps.
* **Increased flexibility when adopting PaaS** - The ability to run PaaS services on any infrastructure of choice.

There may be diverse [business justifications](../../strategy/cloud-migration-business-case.md) to support your organization's choice of a hybrid and multicloud approach for cloud transformation. Moving to a hybrid and multicloud control plane is multi-faceted, perhaps driven by data residency restrictions, keeping legacy applications on-premises, or avoiding the replication of underutilized provisioned environments in the cloud. Organizations seeking to enable higher visibility and control in hybrid and multicloud environments can benefit from one control plane, enabling:

* Consistency of uniform development
* Unified DevOps and management
* Common identity and security
* Extension of existing applications and infrastructure across private and public cloud
* Edge computing resources

## What are the overall benefits of a multicloud control plane?

### Uniform governance and compliance

Azure Arc provides:

* A single pane of glass view of all your resources, including Windows, Linux, SQL Servers, and Kubernetes containers, to capture and track an accurate inventory of IT assets.
* Reduces risk in your organization by establishing a unified governance framework and applying a standard set of policies for all workloads.
* For server and app owners, a view of the compliance status of servers, ability to take necessary remediation steps from the Azure portal, and removing management overhead from central IT departments for tracking and ensuring adherence to compliance standards.

### Consistent deployments, change control, and DevOps everywhere

Azure Arc enables you to adopt cloud practices on-premises. Deploy applications using a consistent approach with familiar tools and practices across your Kubernetes clusters, on any infrastructure. Standardize change control with declarative configuration management systems like GitOps. Easily adopt DevOps techniques like Infrastructure as Code (IaC), and empower developers with self-service access to a rich selection of tools.

### Deploy and manage Azure data services anywhere

Azure Arc-enabled data services provide you with the flexibility to deploy fully managed Azure services anywhere, on-premises or public cloud. Extend cloud benefits everywhere, providing scalability, fast deployment, and always up-to-date cloud innovation, while adhering to regulatory requirements. Deploy and manage data services within on-premises environments or in customer regions, and reduce latency. Access the latest Azure features and capabilities for on-premises data workloads. Join our public preview—deploy evergreen SQL (SQL Managed Instance) and PostgreSQL Hyperscale on any infrastructure, and benefit from automatic updates, patches, and upgrades with no application downtime.

## What are the benefits of a multicloud control plane for IT departments?

For IT administrators, Azure Arc brings consistency and a unified dashboard with a consistent view into thousands of servers across customer environments. Use existing tools on-premises to seamlessly interact with resources, without interfering with existing management tools.

### Inventory management and resource organization

Control resources at organizational, team, and personal levels, and bring them into a single system to organize and inventory through a variety of Azure scopes (e.g., management groups, subscriptions, and resource groups). Create, apply, and enforce standardized and custom tags to keep track of resources. Build powerful queries and search global portfolios (with Azure Resource Graph).

### Extend cloud practices on-premises

Easily adopt DevOps techniques like Infrastructure as Code (IaC). Empower developers with self-service access to a variety of tools, and centralized IT governance and guidance. Standardize change control with declarative configuration management systems like GitOps.

### Easily implement Azure security anywhere

Access Azure Security Center's system of unified infrastructure security management, and strengthen your security posture with advanced threat protection across hybrid workloads in the cloud—whether in Azure, multi-cloud, or on-premises. Centrally access and manage all resources with Azure role-based access control (Azure RBAC). Centrally manage and enforce policy compliance, and simplify audit reporting with Azure Policy.

### Governance and configuration of resources anywhere

Standardize activities by creating, applying, and enforcing policies to Kubernetes apps, data, and infrastructure anywhere. Set guardrails across all resources with Azure Policy. Ensure consistent configurations to a single server, cluster, or data service, or at scale by leveraging inheritance capabilities. Standardize role-based access control (RBAC) across systems and different types of resources. Automate and delegate remediation of incidents to service teams without IT intervention. Enforce runtime conformance and audit resources with Azure Policy.

### Unified tools and experiences across platforms

Create a shared application and infrastructure lifecycle within teams traditionally siloed by location, skill, and job description. Simplify work with a unified, consistent view of resources across datacenters, edge locations, and multicloud through the Azure Portal and Azure API Management. Connect and gain access to Windows and Linux virtual machines (VMs), physical servers, any Kubernetes distribution within the Kubernetes ecosystem, and bring Azure data services to on-premises, multicloud, and edge environments with Azure Arc–enabled data services. Establish clear roles and responsibilities for team members with clear separation of concerns, without losing visibility and access.

### Integrated DevOps and management capabilities

Select additional Arc–enabled services, Azure development, and operational tools that are developer tooling-agnostic. Access a unified enterprise dashboard that grants you a consistent view across environments—with GitHub, Azure Monitor, Security Center, Azure Update integration, and more. Deploy common templates to automate configurations, and deploy Infrastructure as code to make safe and repeatable production deployments. Manage end-to-end identity and access across all users and resources with Azure Active Directory (Azure AD), enterprise identity service, and Azure Resource Manager.

## Next step: Plan for hybrid and multicloud

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you become successful in your particular cloud adoption scenario.

* [Plan for hybrid and multicloud](./plan.md)
* [Review your environment or Azure Landing Zone(s)](./ready.md)
* [Hybrid and multicloud migration](./migrate.md)
* [Govern hybrid and multicloud environments](./govern.md)
* [Manage hybrid and multicloud environments](./manage.md)
