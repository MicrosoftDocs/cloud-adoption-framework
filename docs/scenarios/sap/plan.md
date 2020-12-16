---
title: "Plan for SAP"
description: Plan for SAP on Azure
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Plan for SAP adoption

As discussed in the SAP Strategy article, the returns from SAP cloud adoption can be very high. So can the risk of missed expectations. Developing a clear financial plan, based on your digital estate will ensure greater accuracy in the expectations you set. The same financial planning exercises will provide the cloud adoption team with the data needed to plan for technical activitites.

This article will aid in capturing the plan for SAP cloud adoption using the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) and other references from the Cloud Adoption Framework.

## SAP digital estate planning

Like most complex platforms, your digital estate for SAP will include three categories of assets that will need to be classified and accounted for in your plan: platform assets, foundational assets, and workload assets.

- **Platform assets:** Your SAP platform runs on a collection of dedicated applications, data, virtual machines (&/or servers), and potentially appliances. Those assets are as defined by SAP's deployment requirements, regardless of what your organization does on that platform.
- **Foundational assets:** Your SAP platform is also supported by a collection of assets such as identity providers, networking, operational management tools, etc. Those assets are required to operate your SAP platform and the supporting environment. In Azure, we refer to that collection of assets as foundational utilities. Later articles in this series will discuss deployment of an Azure Landing Zone to provide those foundational assets.
- **Workload assets:** Most organizations extend or integrate SAP into numerous business processes supported by a range of workloads across the portfolio. Those workloads are supported by their collections of applications, data, and virtual machines that are not part of the core platform deployment. Each workload with a depency on the SAP platform should be named, inventoried, rationalized, and tracked individually to allow for granular financial and technical planning decisions.

The processes outlined in the article series on [digital estate planning](https://docs.microsoft.com/azure/cloud-adoption-framework/digital-estate/inventory.md) can be followed for SAP digital estate planning. The best practice article on [assessing on-premises workloads for migration to Azure](https://docs.microsoft.com/azure/cloud-adoption-framework/plan/contoso-migration-assessment) will make that theoretical guidance actionable using Azure Migrate and other assessment tools. 

However, there are a few considerations that must be included in those processes when planning for SAP adoption:

- **Evaluate dependencies:** Dependencies on a core platform like SAP can often go undocumented. Be sure to include a dependency analysis for all assets in the portfolio. See [Step 5 of the best practice article](../../plan/contoso-migration-assessment.md#step-5-prepare-for-dependency-analysis) for an actionable reference guide.
- **Tagging/Grouping/Meta data:** Carefully tag or group all assets: 
  - Thoroughly review platform asset tagging & grouping. Its important that no platform assets are missed, as they are crucial to refining the financial or technical plan.
  - Seperately group any foundational assets that the SAP deployment is dependent on. These may later be replaced with more efficient Azure Landing Zone options.
  - Group each dependent workload individually. Those workloads can each be considered independently during rationalization and migration efforts.
- **Asset Rationalization:** Rationalization is one of the most important considerations to the financial plan. Think about the following with each group of assets:
  - Can foundational assets be retired in favor of cloud-native Azure Landing Zone options?
  - For each workload, will you retire the workload? Would it make sense to rehost the workload to IaaS? Should you modernize that workload? Is this workload impactful enough to consider rearchitecting or rebuilding the workload to take advantage of cloud-native hosting?
- **Prioritization & sequencing:** Prioritize and sequence the platform and workloads to establish a timeline and plan.
- **Hybrid considerations:** During the execution of the plan, will you release in migration waves? Will you need hybrid connectivity for production traffic during miration waves? Using a hybrid cloud allows companies to scale computing resources. Hybrid implementations also eliminate the need to make massive capital expenditures to handle short-term spikes in demand. When the business needs to free up local resources for more sensitive data or applications, a hybrid implementation accelerates resource reduction efforts. 
- **Environment planning:** Are you moving production and non-production SAP platforms at the sametime or separately? Sometimes customers move their non-production SAP platform to Azure, creating an environment for learning and reducing risk. Once the team is comfortable with operations of the SAP platform and workloads in Azure, they will then migrate the production platform and workloads, weeks or months later. 
- **Platform rationalization:** The most important consideration, is related to rationalization of the SAP platform itself. To rationalize your SAP platform assets, consider how your will migrate the platform itself. The migration approach will shape the inventory of assets that will persist in the cloud, along with the work to get there. The following are a few options to consider:
- Rehost: Lift and shift of existing SAP product/OS/DBMS platform with either Azure Migrate or homogeneous system copy. 
- Replatform: Heterogeneous Platform copy of SAP combined with a move to Azure. This is the case where either OS requires/ DBMS gets changed. This include a change with a NetWeaver product to HANA as DBMS 
- Rearchitect: Implement a new SAP platform on Azure

Once these considerations are integrated into your digital estate evaluation, you will be able to refine your business justification. You'll also be ready to build out your SAP cloud adoption plan.

## SAP cloud adoption plan

The Cloud Adoption Framework includes a tool and several templates to create a cloud adoption plan, or Azure DevOps Backlog, based on the tasks outlined in each methodology. Learn more in the article about the [cloud adoption plan templates](https://docs.microsoft.com/azure/cloud-adoption-framework/plan/template.md).

If you use those templates, or your own project planning tools, there are a few SAP specific considerations you will need to factor into the plan.

- Include work efforts to evaluate your foundational assets & deploy an appropriate Azure Landing Zone
- Include work efforts to complete the migration of the SAP Platform, based on your platform rationalization
- Include work efforts for each workload (or wave of workloads) to be migrated

To add those lineitems to the plan, you can use the Azure DevOps web interface. If you are working from an existing inventory of assets, you may be able to build your plan quicker using the excel integration outlined in the [article about workload tracking](https://docs.microsoft.com/azure/cloud-adoption-framework/plan/workloads.,d).

## SAP readiness plan

Once you have a general work plan, you can begin aligning team members and estimating the work.

Many of the team members involved in this project will be experts at SAP or Azure. It is unlikely that the team will have expertise in both areas.
Use the cloud adoption plan to determine the skills that will need to be addressed by the team. Then map those skills to team members to gain a clearer picture of readiness, skilling, and training needs. The article on [building a skills readiness plan](https://docs.microsoft.com/azure/cloud-adoption-framework/plan/adapt-roles-skills-processes.md) and the [strategy & plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) can help track and address skilling gaps to create stronger, cross functional teams in each sprint.

**TODO: Are there specific skills or extra training this team should take before getting started?
Do we have learn modules, articles, websites, or training series that we can point the readers to?**

## Next step: Review your environment or Azure Landing Zone

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for SAP](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate SAP](./migrate.md)
- [Innovate with SAP](./innovate.md)
- [Manage SAP](./manage.md)
