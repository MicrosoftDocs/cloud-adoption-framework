---
title: "Strategy for Hybrid and Multicloud adoption"
description: Describe the scenario's impact on strategy
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic impact of Hybrid and Multicloud

Few organizations jump straight into a cloud-native portfolio. 
For most customers, hybrid environments across multiple clouds is the undeniable reality.Organizations are modernizing datacenters, building applications in the cloud, and deploying smart IoT devices. As a result, IT environments are continuously evolving, with different types of applications often running on different hardware across distributed locations including on premises, multicloud and the edge.

The IT department faces a set of key challenges:
- How to seamlessly govern and secure IT resources regardless of where they are running?
- How to bring cloud innovation to existing infrastructure?
- How to modernize local datacenters with new cloud infrastructure?
- How to extend compute and AI to the edge to unlock new business scenarios?   


If you plan to be hybrid by design for the next 12 months or longer, you should consider unified operations to manage you overall digital estate.

## Hybrid and Multicloud motivations

Here are key reasons why cusotmers adopt a hybrid strategy: 
- Regulatory and data sovereignty requirements 
- Low latency & edge connectivity requirements 
- Aging assets with no migration compatibility
- Sprawl across clouds

What would motivate the customer to act on this scenario?
https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/motivations

## Hybrid and Multicloud outcomes

When customers act on this scenario, what do they expect to see as an outcome?
https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/

- IT Estate visibility and control - ability to see all resources in a single location and be able to query through them to gain insights.
  
- Cloud-based management - ability to modernize operations by being able to use the same cloud management services on resources outside of Azure.
  
- Governance - ability to ensure consistent configurations in all  resources from a central location.
  
- DevOps and cloud native app deployment flexibility - ability to deploy apps’ infra through templates and apps’ configurations through GitOps.
  
- Increased flexibility when adopting PaaS - ability to run PaaS services on infrastructure of choice.

## What is the business justification for Hybrid and Multicloud?

Is there something special that customers have to do to justify doing this thing?
https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/cloud-migration-business-case

Is the justification the same for hybrid, multi-cloud, and the controlplane? Or do we need two sets of justification?

## What is the business justification for a multi-cloud control plane?

Is there something special that customers have to do to justify doing this thing?
https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/cloud-migration-business-case

1. Azure Arc enables you to have a single pane of glass view of all your resources – Windows, Linux and SQL Servers as well as Kubernetes containers so you have a better inventory of your IT assets. You can also reduce risk within your organization by establishing a governance framework and applying a standard set of policies for all your workloads. Server/app owners  can now view compliance status of their own servers and take necessary remediation steps from the Azure Portal, This removes some of the management overhead on central IT in tracking and ensuring adherence to compliance standards. Lastly, Azure Arc also helps you adopt cloud practices on-premises – you can deploy applications using a consistent approach (familiar tools/practices) across all your Kubernetes clusters, on any infrastructure. You can standardize change control with declarative configuration management systems like GitOps and you can also easily adopt DevOps techniques, such as Infrastructure as code and empower developers with self service and a selection of tools.

2. With Azure Arc enabled data services, you have the flexibility to deploy fully managed Azure services anywhere – on-premises or in other public clouds so you can take advantage of cloud benefits everywhere, such as scalability, fast deployment, and always up-to-date cloud innovation, while adhering to regulatory requirements. 
These data services can be deployed and managed from within your on-premises environment or in your own customers’ regions, thus reducing the latency. Finally, you can access the latest Azure features and capabilities for on-premises data workloads. Today, in public preview you can deploy evergreen SQL (SQL Managed Instance) and PostgreSQL Hyperscale on any infrastructure and benefit from automatic updates, patches and upgrades without application downtime.

For IT admins, Azure Arc  brings that consistency and single pane of glass experiences to thousands of servers in customer environments.mA key point is that you can continue to use your existing tools on-premises to interact with these resources, we are not interfering with any of those management tools. 

	1. Inventory and Organization
		○ Get control over resources at organizational, team, and personal levels.
		○ Bring all  resources into a single system to organize and inventory through a variety of Azure scopes (such as Management groups, Subscriptions, and Resource Groups).
		○ Create, apply, and enforce standardized and custom tags to keep track of resources.
		○ Build powerful queries and search global portfolio (with Azure Resource Graph).
		
	2. Extend Cloud practices on prem
		○ Easily adopt DevOps techniques such as infrastructure as code.
		○ Empower developers with self-service and choice of tools complemented by central IT governance and guidance.
		○ Standardize change control with declarative configuration management systems like GitOps
		
	3. Easily implement Azure security anywhere
		○ Access unique Azure security capabilities such as Azure Security Center.
		○ Centrally manage and access for resources with Role Based Access Control.
		○ Centrally manage and enforce compliance and simplify audit reporting with Azure Policy.
		
	4. Gov and Confg
		○ Streamline activities by creating, applying, and enforcing policies to Kubernetes apps, data, and infrastructure anywhere.
		○ Set guardrails across all your resources with Azure Policy to ensure consistent configurations to a single server, cluster, or data service or to many at scale by leveraging inheritance capabilities.
		○ Standardize role-based access control (RBAC) across systems and different types of resources.
		○ Automate and delegate remediation of incidents and problems to service teams without IT intervention.
		○ Enforce run-time conformance and audit resources with Azure  Policy
		
	5. Unified tools and experiences
		○ Create a shared application and infrastructure lifecycle experience for teams that have traditionally been siloed based on locations, skills, and job descriptions.
		○ Simplify your work with a unified and consistent view of your resources across datacenters, edge locations and multi-cloud through the Azure Portal and APIs.
		○ Connect and work with Windows and Linux virtual machines (VMs), physical servers, Kubernetes version of your choice from the ecosystem, and Azure data services.
		○ Establish clear roles and responsibilities for team members with clear separation of concerns without sacrificing visibility and access
		
	6. Integrated DevOps and Management Capabilities
		○ Mix and match additional Azure services or your choice of tools.
		○ Integrated with GitHub, Azure Monitor, Security Center, Update, and more.
		○ Common templating for automating configuration and infrastructure as code provide repeatable deployments.
		○ End-to-end identity for users and resources with Azure Active Directory (Azure AD) and Azure Resource Manager.
		



## Next step: Plan for Hybrid and Multicloud

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for Hybrid and Multicloud](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Hybrid and Multicloud migration assessment](./migrate-assess.md)
- [Hybrid and Multicloud migration](./migrate-deploy.md)
- [Release Hybrid and Multicloud migrations to production](./migrate-release.md)
- [Innovate with Hybrid and Multicloud](./innovate.md)
- [Govern with unified operations](./govern.md)
- [Manage with unified operations](./manage.md)
