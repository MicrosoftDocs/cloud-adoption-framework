---
title: Plan for SAP cloud adoption on Azure
description: Discover key strategies for SAP cloud adoption in Azure, including asset rationalization, hybrid considerations, and environment planning. Build your roadmap now.
author: stephen-sumner
ms.author: pnp
ms.reviewer: ssumner
ms.date: 01/23/2026
ms.topic: concept-article
---

# Plan for SAP cloud adoption in Azure

This article guides you through creating a comprehensive plan for SAP cloud adoption that aligns technical decisions with business objectives.

## SAP digital estate planning

Like most complex platforms, your SAP digital estate will include three asset categories that should be recognized in your plan: platform, foundational, and workload assets.

- **Platform assets:** Your SAP platform runs on a collection of dedicated applications, data, virtual machines or servers, and potentially appliances. Regardless of what your organization does on that platform, those assets are as defined by SAP deployment requirements.

- **Foundational assets:** Your SAP platform and the supporting environment are also upheld by a collection of necessary assets like identity providers, networking, operational management tools, and more. Azure refers to these assets as foundational utilities, and this article series will later describe how to deploy an Azure landing zone to provide them.

- **Workload assets:** Most organizations extend or integrate SAP into various business processes that are supported by a range of workloads across the portfolio. Those workloads are supported by their collections of applications, data, and virtual machines that aren't part of the core platform deployment. Each workload with a dependency on the SAP platform should be named, inventoried, rationalized, and tracked individually to allow for granular financial and technical planning decisions.Several considerations should be included in those processes when planning for SAP adoption:

- **Evaluate dependencies:** Dependencies on a core platform like SAP are often undocumented. Be sure to include a dependency analysis for all assets in the portfolio.

- **Tagging, grouping, and metadata:** Carefully tag or group all assets:

  - Thoroughly tag and group assets on the platform. It's important to not miss any assets, as they're key to refining the financial or technical plan.

  - Separate and group any foundational assets on which the SAP deployment depends. These can later be replaced with more efficient Azure landing zone options.

  - Group each dependent workload individually. Those workloads can each be considered independently during rationalization and migration efforts.

- **Asset rationalization:** Rationalization is one of the most important considerations for the financial plan. Think about the following with each group of assets:

  - Can foundational assets be retired in favor of cloud-native Azure landing zone options?

  - For each workload, will you retire the workload? Would it make sense to rehost the workload to infrastructure as a service? Should you modernize this workload? Is this workload impactful enough to consider rearchitecting or rebuilding the workload to take advantage of cloud-native hosting?

- **Prioritization and sequencing:** Prioritize and sequence the platform and workloads to establish a timeline and plan.

- **Hybrid considerations:** During the execution of the plan, will you release in migration waves? Will you need hybrid connectivity for production traffic during migration waves? Using a hybrid cloud allows companies to scale computing resources. Hybrid implementations also eliminate the need to make massive capital expenditures to handle short-term spikes in demand. When the business needs to free up local resources for more sensitive data or applications, a hybrid implementation accelerates resource reduction efforts.

- **Environment planning:** Are you moving production and nonproduction SAP platforms at the same time or separately? Customers sometimes move their nonproduction SAP platform to Azure, creating an environment for learning and reducing risk. Once the team is comfortable with the SAP platform's operations and Azure workloads, they will migrate the production platform and workloads weeks or months later?

- **Platform rationalization:** The most important consideration is how to rationalize an SAP platform's assets; consider how you'll migrate the platform. The migration approach will shape the inventory of assets that will persist in the cloud and the work to get there. The following options can be considered:

  - **Rehost:** Use Azure Migrate or a homogeneous system copy to lift and shift the current SAP/OS/DBMS platform.

  - **Replatform:** Combine making a heterogeneous platform copy of SAP with a move to Azure, such as when the OS requires this or the DBMS changes. This includes when an SAP NetWeaver production changes to HANA as a DBMS.

- **Rearchitect:** Implement a new SAP platform on Azure.

Once these considerations are integrated into your digital estate evaluation, you can refine your business justification. You'll also be ready to build out your SAP cloud adoption plan.

## SAP cloud adoption plan

The Cloud Adoption Framework includes a tool and several templates for creating a cloud adoption plan or Azure DevOps backlog, which are based on the tasks outlined in each methodology.

Whether you use templates or your own project planning tools, factor in the following SAP-specific actions:

- Evaluate your foundational assets, and deploy an appropriate Azure landing zone.
- Use your platform rationalization efforts to finish migrating the SAP platform.
- Account for each workload (or wave of workloads) to be migrated.