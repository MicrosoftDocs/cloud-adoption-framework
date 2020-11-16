---
title: "Strategy for unified operations adoption"
description: Describe the scenario's impact on strategy
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic impact of unified operations

Few organizations jump straight into a cloud-native portfolio. 
For most customers, hybrid environments across multiple clouds is the undeniable reality.

You will likely be operating in a hybrid environment. 
The big decision: 
- Are you hybrid because of a one-way trip to the cloud?
- Are you hybrid by choice, supporting a mixture of assets living in public & private cloud

If you plan to be hybrid by design for the next 12 months or longer, you should consider unified operations to manage you overall digital estate.

## Unified operations motivations

- Regulatory requirements
- Latency & connectivity
- Aging assets with no migration compatibility
- Sprawl across clouds

What would motivate the customer to act on this scenario?
https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/motivations

## Unified operations outcomes

When customers act on this scenario, what do they expect to see as an outcome?
https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/

- IT Estate visibility and control - ability to see all resources in a single location and be able to query through them to gain insights.
  
- Cloud-based management - ability to modernize operations by being able to use the same cloud management services on resources outside of Azure.
  
- Governance - ability to ensure consistent configurations in all  resources from a central location.
  
- DevOps and cloud native app deployment flexibility - ability to deploy apps’ infra through templates and apps’ configurations through GitOps.
  
- Increased flexibility when adopting PaaS - ability to run PaaS services on infrastructure of choice.


## What is the business justification for a multi-cloud control plane?

Is there something special that customers have to do to justify doing this thing?
https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/cloud-migration-business-case

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
		



## Next step: Plan for unified operations

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for unified operations](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Assess for unified operations migration](./migrate-assess.md)
- [Migrate unified operations](./migrate-deploy.md)
- [Release unified operations to production](./migrate-release.md)
- [Innovate with unified operations](./innovate.md)
- [Govern unified operations](./govern.md)
- [Manage unified operations](./manage.md)
