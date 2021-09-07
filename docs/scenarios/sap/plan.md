---
title: Plan for SAP cloud adoption in Azure
description: Understand how to plan SAP cloud adoption in Azure.
author: JefferyMitchell
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# Plan for SAP cloud adoption in Azure

As discussed in the SAP [strategy](./strategy.md) article, the returns from SAP cloud adoption can be very high, but so can the risk of missed expectations. Developing a clear financial plan that's based on your digital estate will ensure greater accuracy in the expectations that you set. The same financial planning exercises will provide the cloud adoption team with the data needed to plan technical activities.

The [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) and other resources in the Cloud Adoption Framework can help your organization to capture a suitable plan for SAP cloud adoption.

## SAP digital estate planning

Like most complex platforms, your SAP digital estate will include three asset categories that should be recognized in your plan: platform, foundational, and workload assets.

- **Platform assets:** Your SAP platform runs on a collection of dedicated applications, data, virtual machines or server, and potentially appliances. Regardless of what your organization does on that platform, those assets are as defined by SAP deployment requirements.

- **Foundational assets:** Your SAP platform and the supporting environment are also upheld by a collection of necessary assets like identity providers, networking, operational management tools, and more. Azure refers to these assets as foundational utilities, and this articles series will later describe how to deploy of an Azure landing zone to provide them.

- **Workload assets:** Most organizations extend or integrate SAP into various business processes that are supported by a range of workloads across the portfolio. Those workloads are supported by their collections of applications, data, and virtual machines that aren't part of the core platform deployment. Each workload with a dependency on the SAP platform should be named, inventoried, rationalized, and tracked individually to allow for granular financial and technical planning decisions.

For guidance on SAP digital estate planning, look through the processes outlined in the article series on [digital estate planning](../../digital-estate/inventory.md). The best practice article on [assessing on-premises workloads for migration to Azure](../../plan/contoso-migration-assessment.md) proposes Azure Migrate and other assessment tools to make that theoretical guidance from the prior article actionable.

Several considerations should be included in those processes when planning for SAP adoption:

- **Evaluate dependencies:** Dependencies on a core platform like SAP are often undocumented. Be sure to include a dependency analysis for all assets in the portfolio. See [Step 5 of the `best practices` article](../../plan/contoso-migration-assessment.md#step-5-prepare-for-dependency-analysis) for an actionable reference guide.

- **Tagging, grouping, and metadata:** Carefully tag or group all assets:

  - Thoroughly tag and group assets on the platform. It's important to not miss any assets, as they're key to refining the financial or technical plan.

  - Separate and group any foundational assets on which the SAP deployment depends. These can later be replaced with more efficient Azure landing zone options.

  - Group each dependant workload individually. Those workloads can each be considered independently during rationalization and migration efforts.

- **Asset rationalization:** Rationalization is one of the most important considerations for the financial plan. Think about the following with each group of assets:

  - Can foundational assets be retired in favor of cloud-native Azure landing zone options?

  - For each workload, will you retire the workload? Would it make sense to rehost the workload to infrastructure as a service? Should you modernize this workload? Is this workload impactful enough to consider rearchitecting or rebuilding the workload to take advantage of cloud-native hosting?

- **Prioritization and sequencing:** Prioritize and sequence the platform and workloads to establish a timeline and plan.

- **Hybrid considerations:** During the execution of the plan, will you release in migration waves? Will you need hybrid connectivity for production traffic during migration waves? Using a hybrid cloud allows companies to scale computing resources. Hybrid implementations also eliminate the need to make massive capital expenditures to handle short-term spikes in demand. When the business needs to free up local resources for more sensitive data or applications, a hybrid implementation accelerates resource reduction efforts.

- **Environment planning:** Are you moving production and nonproduction SAP platforms at the same time or separately? Customers sometimes move their nonproduction SAP platform to Azure, creating an environment for learning and reducing risk. Once the team is comfortable with the SAP platform's operations and Azure workloads, they will migrate the production platform and workloads weeks or months later?

- **Platform rationalization:** The most important consideration is how to rationalize an SAP platform's assets; consider how you'll migrate the platform. The migration approach will shape the inventory of assets that will persist in the cloud and the work to get there. The following options can be considered:

  - **Rehost:** Use Azure Migrate or a homogeneous system copy to lift and shift the current SAP/OS/DBMS platform.

  - **Replatform:** Combine making heterogeneous platform copy of SAP with a move to Azure, such as when the OS requires this or the DBMS changes. This include when an SAP NetWeaver production changes to HANA as a DBMS.

- **Rearchitect:** Implement a new SAP platform on Azure.

Once these considerations are integrated into your digital estate evaluation, you can refine your business justification. You'll also be ready to build out your SAP cloud adoption plan.

## SAP cloud adoption plan

The Cloud Adoption Framework includes a tool and several templates for creating a cloud adoption plan or Azure DevOps backlog, which are based on the tasks outlined in each methodology. Learn more about templates in the [cloud adoption plan and Azure DevOps](../../plan/template.md) article.

Whether you use templates or your own project planning tools, factor in the following SAP-specific actions:

- Evaluate your foundational assets, and deploy an appropriate Azure landing zone.
- Use your platform rationalization efforts to finish migrating the SAP platform.
- Account for each workload (or wave of workloads) to be migrated.

You can use the [Azure DevOps web interface](/azure/devops/project/navigation/) to add those line items to the plan. If you're working from a current asset inventory, you could build your plan faster with the Microsoft Excel integration outlined in the Cloud Adoption Framework article about [tracking workloads](../../plan/workloads.md).

## SAP readiness plan

Once you have a general work plan, you can begin aligning team members and estimating the work.

This project's team members could be SAP or Azure experts, but it's unlikely for the team to have equal expertise in both areas. Use the cloud adoption plan to determine the skills that the team will need to acquire. Then, map those skills to team members to gain a clearer picture of readiness, skilling, and training needs. The Cloud Adoption Framework [building a skills readiness plan](../../plan/adapt-roles-skills-processes.md) article and [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) can help your team to track and address skilling gaps to create stronger cross-functional collaboration in each sprint.

## Next step: Review your environment or Azure landing zone for an SAP enterprise-scale migration

The following articles provide guidance for specific points throughout the cloud adoption journey to help you succeed in adopting SAP in Azure.

- [Review your environment or Azure landing zones](./ready.md)
- [Migrate an SAP platform to Azure](./migrate.md)
- [Innovate with SAP](./innovate.md)
- [Manage SAP](./manage.md)
