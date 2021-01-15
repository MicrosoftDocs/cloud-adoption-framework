---
title: "Strategy for unified operations adoption"
description: Describe the scenario's impact on strategy
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic impact of hybrid and multi-cloud operations

## Executive summary

Few organizations jump straight into a cloud-native portfolio. Many customers continue to believe cloud myths that slow innovation efforts, such as "everything should go into the cloud." To minimize common mistakes, [dispel myths about moving to the cloud](../../strategy/cloud-migration-business-case.md). There are sound [motivations](../../strategy/motivations.md) to retain part of your digital estate on-premises, and also want business outcomes related to the innovations of cloud services—where you might consider a hybrid and multi-cloud scenario to be beneficial to your organization.

In moving to a hybrid and multi-cloud scenario, customers might be concerned about maintaining governance, management, and compliance— managing identity and security—migrating data—integrating disparate development environments—managing data management tools—and porting applications across scattered resources and environments.

Deploying a single control plane can accelerate cloud adoption and migration. Organizations can prepare cloud readiness with skilling and process improvements that assume unified operations—bringing innovative cloud practices and technologies to on-premises, and preparing other workloads for migration to the cloud. One pane of glass that consistently operates and manages on-premises and cloud environments with one cloud management solution provides greater visibility into resources, team accountability, developer empowerment, while accelerating innovation from Azure to any location.

## Speed up cloud adoption and migration with one control plane

Initiating cloud readiness and skilling initiatives will accelerate both your cloud adoption and migration efforts. Move towards cloud-readiness and implement innovative cloud practices in workloads staying on-premises, and adopt cloud technologies to prepare other workloads that are moving to the cloud. Work with your cloud strategy team, and build the necessary cloud skills and processes to prepare for your migration effort to a hybrid and multi-cloud environment.

Azure Arc extends Azure management and services with one control plane across hybrid, multi-cloud and edge environments, enabling a consistent state across resource environments and infrastructure.

How does deploying one control plane transform your cloud adoption and migration efforts?

**Promote greater accountability for enterprise IT teams,** extending a uniform control plane from Azure Arc by centralizing visibility, operations, and compliance. across resources and locations.

**Organize, govern, and secure across on-prem, multi-cloud, and edge** on Windows, LInux, SQL Server, and Kubernetes.

**Empower developer teams across the enterprise with the ability to build cloud apps anywhere, at scale,** coding and shipping applications to Kubernetes clusters anywhere, all from Azure.

**Consistently speed up development, at scale**, with templatized deployment, configuration, and security, and reduce errors with policy-driven deployment and operations.

**Bring innovative Azure-Arc enabled services to any location,** deploy faster, consistently, and achieve elastic scale based on capacity.

**Leverage unified operations, management, and security** to ensure consistency across data workloads.

**Practice frictionless development** supporting both disconnected and connected use cases.

Hybrid and multi-cloud is the most common reality across current enterprise environments. For most customers, moving to a hybrid and multi-cloud scenario is simply embracing market reality, and, as previously mentioned, remains a sound business decision. The next decision for your organization is committing to a distributed computing paradigm that will increase the speed of both your cloud adoption and migration efforts. Beginning cross-team initiatives to increase your cloud readiness with innovative cloud practices and technologies is the first step towards deploying one control plane that uniformly protects and monitors resources, standardizes governance and security, and manages all operations. Consider a hybrid and multi-cloud environment to manage your overall digital estate if you are planning to be hybrid by design for the next 12 months or longer.

Work with your [cloud strategy team](../../get-started/team/cloud-strategy.md), to build the necessary skilling and processes to prepare for the move to greater accountability, developer empowerment, and Azure-services anywhere with a unified control plane across hybrid, multi-cloud, and edge.

## Unified operations motivations

There are various [motivations](../../strategy/motivations.md) that might steer customers to adopt a hybrid and multi-cloud approach. Adopting the right cloud strategy depends on documenting what classification the majority of these motivations are associated with: critical business events, migration, or innovation.

Customers may have a digital estate bound by specific regulatory requirements and data localization laws that constrain in what geographical location it must reside. A particular industry might require low-latency and high connectivity for efficient operational capacity, such as financial services, also a common requirement for other industries like media, healthcare, education, and government, for example.

A multi-national organization, for example, might have globally distributed, legacy datacenters, with an aging infrastructure that is simply not compatible with a company-wide migration effort. Or there may be corporations with even larger cloud estates that are sprawled across several cloud environments, and visibility and control of operations is challenging.

## Unified operations outcomes

When customers execute on their cloud strategy and choose a hybrid and multi-cloud scenario, they expect to see business outcomes supported by specific efforts that drive crucial business results, [outcomes grounded in cross-team consensus](../../strategy/business-outcomes/).

Organizations might require **improved visibility and control over their IT estate**. They want the ability to see all their resources in a single location, and be able to query through them to gain insights.
  
Another outcome companies may target is **cloud-based management**—the ability (across platforms) to modernize operations with the same cloud management services on resources in locations that are outside of Azure.
  
**Governance** is an important outcome for companies wishing to ensure consistent configurations across all resources from one central location.
  
**DevOps and cloud native app deployment flexibility** would provide organizations the agility of deploying app infrastructure through templates and app configurations through GitOps.
  
Finally, companies might benefit from the outcome of **increased flexibility when adopting PaaS**, the ability to run PaaS services on their infrastructure of choice.

## What is the business justification for hybrid and multi-cloud?

There may be diverse [business justifications](../../strategy/cloud-migration-business-case.md) to support your organization's choice of a hybrid and multi-cloud approach for cloud transformation. Moving to a hybrid and multi-cloud control plane is multi-faceted. It may be driven by data residency restrictions, keeping legacy applications on-premises, or avoiding the replication of underutilized provisioned environments in the cloud. Organizations seeking to enable higher visibility and control in hybrid and multi-cloud environments can benefit from one control plane over a multi-cloud environment—enabling the consistency of uniform development, unified dev-ops and management, common identity and security, extending existing applications and infrastructure across private cloud, public cloud, and edge computing resources.

## What are the overall benefits of a multi-cloud control plane?

### Uniform governance and compliance

Azure Arc enables you to have a single pane of glass view of all your resources, including Windows, Linux, SQL Servers, and Kubernetes containers to track and capture an accurate inventory of IT assets. Reduce risk in your organization by establishing a unified governance framework—applying a standard set of policies for all workloads. As server/app owners, view the compliance status of servers and take necessary remediation steps from the Azure portal, removing some management overhead from central IT departments for tracking and ensuring adherence to compliance standards.

### Consistent deployments, change control, and DevOps everywhere

Azure Arc enables you to adopt cloud practices on-premises. Deploy applications using a consistent approach with familiar tools and practices across your Kubernetes clusters, on any infrastructure. Standardize change control with declarative configuration management systems like GitOps. Easily adopt DevOps techniques like infrastructure as Code (IaC), and empower developers with self-service access to a rich selection of tools.

### Deploy and manage Azure data services anywhere

Azure Arc-enabled data services provide you with the flexibility to deploy fully managed Azure services anywhere, on-premises or public cloud. Leverage cloud benefits everywhere: scalability, fast deployment, and always up-to-date cloud innovation, while adhering to regulatory requirements. Deploy and manage data services within on-premises environments or in customer regions and reduce latency. Access the latest Azure features and capabilities for on-premises data workloads. Join our public preview—deploy evergreen SQL (SQL Managed Instance) and PostgreSQL Hyperscale on any infrastructure, and benefit from automatic updates, patches, and upgrades with no application downtime.

## What are the benefits of a multi-cloud control plane for IT departments?

For IT administrators, Azure Arc brings consistency and a unified dashboard with a consistent view into thousands of servers in customer environments. Use existing tools on-premises to seamlessly interact with resources, without interfering with existing management tools.

### Inventory management and resource organization

Control resources at organizational, team, and personal levels, and bring them into a single system to organize and inventory through a variety of Azure scopes (e.g., management groups, subscriptions, and resource groups). Create, apply, and enforce standardized and custom tags to keep track of resources. Build powerful queries and search global portfolios (with Azure Resource Graph).

### Extend cloud practices on-premises

Easily adopt DevOps techniques like infrastructure as Code (IaC). Empower developers with self-service access to a rich tool selection, and centralized IT governance and guidance. Standardize change control with declarative configuration management systems like GitOps.

### Easily implement Azure security anywhere

Access Azure Security Center's unified infrastructure security management system, and strengthen your security posture with advanced threat protection across hybrid workloads in cloud—in Azure, multi-cloud, or on-premises. Centrally access and manage all resources with Azure role-based access control (Azure RBAC). Centrally manage and enforce policy compliance, and simplify audit reporting with Azure Policy.

### Governance and configuration of resources anywhere

Standardize activities by creating, applying, and enforcing policies to Kubernetes apps, data, and infrastructure anywhere. Set guardrails across all resources with Azure Policy. Ensure consistent configurations to a single server, cluster, or data service, or at scale by leveraging inheritance capabilities. Standardize role-based access control (RBAC) across systems and different types of resources with Azure role-based access control (Azure RBAC). Automate and delegate remediation of incidents and problems to service teams without IT intervention. Enforce runtime conformance and audit resources with Azure Policy.

### Unified tools and experiences across platforms

Create a shared application and infrastructure lifecycle within teams, traditionally siloed by location, skill, and job description. Simplify work with a unified, consistent view of resources across datacenters, edge locations and multi-cloud through the Azure Portal and Azure API Management. Connect and gain access to Windows and Linux virtual machines (VMs), physical servers, any Kubernetes distribution within the Kubernetes ecosystem, and bring Azure data services to on-premises, multicloud, and edge environments with Azure Arc–enabled data services. Establish clear roles and responsibilities for team members, with clear separation of concerns without losing visibility and access.

### Integrated DevOps and management capabilities

Select additional Arc–enabled services and Azure development and operational tools that are developer tooling-agnostic. Access unified dashboard with a consistent view across your environments—with GitHub, Azure Monitor, Security Center, Azure Update integration, and more. Leverage common templates to automate configuration, and deploy infrastructure as code to make safe and repeatable production deployments. Manage end-to-end identity and access across all users and resources with Azure Active Directory (Azure AD) enterprise identity service and Azure Resource Manager.

## Next step: Plan for hybrid and multicloud

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you become successful in the cloud adoption scenario.

- [Plan for hybrid and multicloud](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Hybrid and multicloud migration](./migrate.md)
- [Govern hybrid and multicloud environments](./govern.md)
- [Manage hybrid and multicloud environments](./manage.md)
