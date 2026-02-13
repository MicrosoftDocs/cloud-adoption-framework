---
title: Plan for Azure VMware Solution
description: Learn about business and technical considerations for architectural design, evaluation, and deployment of Azure VMware Solution
author: mhenry
ms.author: jaalmond
ms.date: 04/21/2022
ms.topic: concept-article
ms.custom: e2e-azure-vmware, think-tank
---

# Plan for Azure VMware Solution

The [Plan methodology](../../plan/index.md) of the Cloud Adoption Framework helps create an overall cloud adoption plan to guide the programs and teams involved in your cloud-based digital transformation. This guidance provides templates for creating your backlog and plans for building necessary skills across your teams, all based on your cloud objectives. This article outlines how to include Azure VMware Solution in your overall cloud adoption plan.

## Azure VMware Solution estate

Azure VMware Solution is dedicated infrastructure packaged with VMware vSphere clusters, provisioned as a private cloud on Azure. The minimum initial deployment is three hosts, but more hosts can be added one at a time, up to a maximum of 16 hosts per cluster. All provisioned private clouds include vCenter Server, vSAN, ESXi, and NSX-T Data Center. As a result, you can seamlessly migrate or extend workloads from your on-premises VMware vSphere environments to Azure VMware Solution. Your Azure VMware Solution estate can extend on-premises resources, private cloud resources, and other Azure public cloud resources. For more information on connectivity between environments and across virtual networks, see [Integrate Azure VMware Solution in a hub and spoke architecture](/azure/azure-vmware/concepts-hub-and-spoke).

:::image type="content" source="./media/running-vmware-natively-on-azure.png" alt-text="Diagram of running VMware natively on Azure." lightbox="./media/running-vmware-natively-on-azure.png":::

## Azure VMware Solution adoption plan

When planning your adoption of Azure VMware Solution, there are many business and technical considerations for scoping, architectural design, evaluation, and deployment. Like any successful project, defining your objectives and success criteria at the beginning is crucial to establishing the right solution for your business needs.

Project objectives support business goals and align with initial motivations for Azure VMware Solution:

- **For a data center evacuation**, you often need to define a timeline objective that achieves the fixed date by which the data center must be closed. For example, you need to "complete a migration from the data center by X date."
- **For increasing infrastructure scale, capacity, and disaster recovery**, you need to know factors like the ability to burst capacity on Azure VMware Solution and the locations of disaster recovery sites. An example objective might be "ability to increase capacity by X number of nodes (or via storage integrations) and ability to establish a disaster recovery site within X region or geographic radius."
- **For hardware/software end of support**, you need to establish how many licenses are required and the License Mobility across current on-premises environments and the cloud. An example might be "ability to gain extended security updates for X number of Windows Server instances and X number of SQL Server virtual machines on Azure VMware Solution."

Defining success criteria for the Azure VMware Solution project aligns with the outcomes your organization is seeking:

- **Realize cost efficiencies and reduction of TCO.** TCO is often measured by lowering the data center footprint and optimizing costs through cloud economics and Azure Reservations. Whether at a macro level or specific to the Azure VMware Solution project, you should create clear success measures for reducing TCO for VMware vSphere workloads.
- **Realize ease of implementation and change management.** By using existing VMware solution skills and processes with Azure VMware Solution, define success measures related to resourcing in hours. Include requirements for in-house project support, any reskilling of IT professionals, or new skill acquisition required.
- **Realize minimal downtime and business continuity impact.** Define success measures related to acceptable system downtime, if any, and other factors that might affect business continuity, such as latency for system communication and process re-engineering.

## Adoption stages

**Scoping:** At the scoping stage of your Azure VMware Solution project, you should have finalized the objectives and success criteria. These items should be translated into your business and technical requirements for the scope of work, for example:

- Business requirements:
  - Timeline for migration
  - Successfully migrate an application
  - Committed Service Level Agreements (SLAs)
- Technical requirements:
  - Migrate a set number of virtual machines from a data center
  - Estimated number of Azure VMware Solution nodes in specific Azure regions

**Architectural design:** Following the scoping and requirements, you should be able to construct an architectural design with support from Microsoft and a partner. Typically, this process addresses and evaluates the following topics during a "discovery phase and technical review":

- **Azure VMware Solution overview:**
  - Licensing requirements
  - Azure Reserved bare-metal Instances
  - Private clouds, clusters, and hosts
  - Storage
  - High-level networking and connectivity
  - Access and identity
  - Maintenance and monitoring
- **Networking and security:**
  - WAN connectivity and ExpressRoute
  - Edge security (available options)
  - L2 stretching
  - Firewall
  - Azure topology integration
  - Necessary network flows
- **Migration and operational:**
  - Typical migration toolchain
  - Typical process and runbook for migrations
  - HCX cluster capabilities and limitations
  - Disaster recovery and high availability scenarios
  - Backup tools and processes

The focus is to ensure all domain owners within your organization understand the scope and success criteria. We recommend involving as many domain owners, such as network, security, and operations, as possible during this phase.

**Pilot deployment:** Once the scope of work is agreed upon, we recommend beginning the project with a pilot or proof of concept. For Azure VMware Solution, we recommend deploying and testing the following items:

- Deploy the Azure VMware Solution cloud service and nodes
- Network configuration
- Complete configurations
- Complete HCX configuration, as needed
- Configure other Azure services and applications, as needed

**Pilot validation:** Review the pilot against established business and technical requirements of the Azure VMware Solution project and confirm that success criteria are met.

**Production:** Plan the transition of production VMware workloads to the new Azure VMware Solution environment. Start a migration ramp-up plan for node capacity requirements for the Azure VMware Solution private cloud. To investigate the number of nodes your environment requires, use the resources and guidance for Azure migrations:

- [Create your first Azure VMware Solution assessment](/azure/migrate/how-to-create-azure-vmware-solution-assessment)
- [How to review an Azure VMware Solution assessment](/azure/migrate/review-azure-vmware-solution-assessment)
- [Azure migration center](https://azure.microsoft.com/migration/)

**Extend and modernize:** Once you established your Azure VMware Solution environment, the hub-and-spoke network connection ensures seamless extension to other Azure public cloud services. Customers often optimize through resource management, monitoring and security, storage, and other integrations to modernize applications in the current infrastructure design.

:::image type="content" source="./media/migration-made-easy.png" alt-text="Diagram of migration made easy.":::

## Azure VMware Solution readiness plan

The following resources help organizations skill up and familiarize themselves with the technical components of Azure VMware Solution:

- [Tech community blog](https://techcommunity.microsoft.com/t5/azure-migration-and/bg-p/AzureMigrationBlog)
- [Azure VMware Solution quickstart guides](/azure/azure-vmware/tutorial-create-private-cloud)
- [Azure VMware Solution hands-on labs](https://labs.hol.vmware.com/HOL/)

## Next steps

Review key considerations and changes necessary to prepare your environments or Azure landing zones for Azure VMware Solution.

> [!div class="nextstepaction"]
> [Review your environment or Azure landing zones](./ready.md)