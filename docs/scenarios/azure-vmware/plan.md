---
title: Plan for Azure VMware Solution
description: <<Describe the scenario's impact on planning.>>
author: mhenry
ms.author: jaalmond
ms.date: 08/30/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Plan for Azure VMware Solution

[Cloud Adoption Framework's Plan methodology](../../plan/index.md) helps create an overall cloud adoption plan to guide the programs and teams involved in your cloud-based digital transformation. This guidance provides templates for creating your backlog and plans for building necessary skills across your teams, all based on what you are trying to do in the cloud. This article outlines how to include Azure VMware Solution into the overall cloud adoption plan.

Application of the Plan methodology focuses on the [five Rs of rationalizing your digital estate](../../digital-estate/5-rs-of-rationalization.md). The most common path to the cloud focuses on speed, efficiency, and repeatability of the migration and modernization processes. From the five Rs, planning usually prioritizes rehost options with limited parallel support for rearchitect and rebuild options.

## Azure VMware Solution estate

Azure VMware Solution is dedicated infrastructure packaged with VMware vSphere clusters, provisioned as a private cloud on Azure. The minimum initial deployment is three hosts, but additional hosts can be added one at a time, up to a maximum of 16 hosts per cluster. All provisioned private clouds include vCenter Server, vSAN, vSphere, and NSX-T. As a result, you can seamlessly migrate or extend workloads from your on-premises VMware environments to Azure VMware Solution. Your Azure VMware Solution estate can extend on-premises resources, private cloud resources, and other Azure public cloud resources. For more details on connectivity between environments and across virtual networks, please refer to the [AVS Hub and Spoke topology here](/azure/azure-vmware/concepts-hub-and-spoke). 

:::image type="content" source="./media/running-vmware-natively-on-azure.jpg" alt-text="Diagram of running vmware natively on azure.":::

## Azure VMware Solution adoption plan

In adopting Azure VMware Solution there are many business and technical considerations needed for scoping, architectural design, evaluation and deployment. Like any successful project defining your objectives and success criteria in the beginning is crucial to establishing the right solution for the business needs.


Objectives of the project are in support of the business goals and are aligned to initial motivations for Azure VMware Solution. Some examples of these are:
- **For a Datacenter evacuation,** often you will need to define a timeline objective that achieves the fixed date that that datacenter needs to be closed by. An example might be “migration must be completed from the datacenter by x date”
- **For increasing infrastructure scale, capacity, and disaster recovery,** you will require to know things like ability to burst capacity on AVS and locations of disaster recovery sites. An example objective related to this might be “Ability to increase capacity by x number of nodes (or via storage integrations), and ability to establish disaster recovery site in within x region or geographic radius
- **For hardware/software end of support,** you will need to establish how many licenses and what is the license mobility across current on-premises environments and the cloud. An example might be ability to gain extended security updates for x number of Windows Server and x number of SQL Server virtual machines on Azure VMware Solution.

Similarly defining success criteria for the AVS project is aligned to the outcomes your organization is looking for:

- **Realize cost efficiencies and reduction of TCO.** Often this is the measurement between lowering the datacenter footprint and optimizing costs through cloud economics and Azure reservations. Whether this is at a macro level or goals specific to the AVS project, you should create clear success measure on reduction in TCO for VMware workloads. 
- **Realize ease of implementation and change management.** By leveraging existing VMware skills and processes with Azure VMware Solution, define success measures related to resourcing in hours. Include requirements for in-house project support, any reskilling of IT professionals, and/or new skill acquisition required.
- **Realize minimal downtime and business continuity impact.** Defines success measures related to acceptable system downtime if any, and other factors that may impact continuity of business such as latency for system communication, and process re-engineering.

## Adoption Stages

**Scoping:** At the scoping stage of your AVS project, you will have finalized the objectives and success criteria, these should be translated to your business and technical requirements for the scope of work. Examples include:
- Business Requirements
  - Timeline for migration
  - Successfully migrate an application
- Technical Requirements
  - Migrate a set number of virtual machines from a datacenter
  - Estimated number of AVS nodes in which Azure Regions

**Architectural Design:** 
Following the scoping and requirements, you will be able to construct an architectural design in conjunction and with support from Microsoft and Partner. Typically, in this process the following topics will be addressed and evaluated as a “Discovery Phase and Technical Review".
- **AVS Solution Overview**
  - Licensing Requirements
  - Azure Reserved Instances 
  - Private Clouds, Clusters, and Host 
  - Storage 
  - High Level Networking and Connectivity
  - Access and Identity
  - Maintenance and Monitoring
- **Networking / Security**
  - WAN Connectivity and ExpressRoute
  - Edge Security – Options available
  - L2 Stretching
  - Firewall 
  - Azure topology integration
- **Migration / Operational**
  - Typical Migration Toolchain 
  - Typical Process and Runbook for migrations
  - HCX Cluster Capabilities and Limitations
  - DR and HA scenarios
  - Backup Tools and Processes

The focus here is to ensure all domain owners within your organization understand scope and success. We recommend as many domain owners (e.g. network, security, operations, etc.) are able to be a part of this phase.

**Pilot Deployment:** Once the scope of work is agreed and in place, we recommend beginning the project with a pilot or proof of concept. For Azure VMware Solution we recommend deploying and testing the following: 
- Deploy the AVS Cloud Service and nodes
- Network configuration
- Complete configurations
- HCX configuration – as needed
- Configure additional Azure services, 3rd party applications – as needed

**Pilot Validation:** Review pilot against established business and technical requirements of the Azure VMware Solution project and confirm success criteria is met.

**Production:** Plan business for transition of production VMware workloads to the new AVS environment. Set forth migration ramp up plan on node capacity requirements for Azure VMware Solution private cloud. To investigate the number of nodes your environment will require leverage the resources here for Azure migrations:
- [Create your first Azure VMware Solution (AVS) assessment](/azure/migrate/how-to-create-azure-vmware-solution-assessment)
- [How to review an Azure VMware Solution assessment](/azure/migrate/tutorial-assess-vmware-azure-vmware-solution)
- [Azure migration center](https://azure.microsoft.com/migration/)

**Extend and Modernize:** Once you have established your Azure VMware Solution environment, the hub and spoke network connection ensures extension to other Azure public cloud services is seamless. Customers will often look to optimize through resource management, monitoring and security, storage, and other integrations to modernize the application in current infrastructure design.

:::image type="content" source="./media/migration-made-easy.jpg" alt-text="Diagram of migration made easy.":::

## Azure VMware Solution readiness plan

The following list is a variety of resources that help organizations skill and get familiar with the technical components of Azure VMware Solution.
- [Tech Community Blog](https://techcommunity.microsoft.com/t5/azure-migration-and/bg-p/AzureMigrationBlog)
- [AVS Quick Start Guides](/azure/azure-vmware/plan-private-cloud-deployment)
- [AVS Hands On Labs](https://web.hol.vmware.com/landingPages/index.aspx?id=PN5RRQA9)


## Next step: Review your environment or Azure Landing Zone

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.


- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate Azure VMware Solution](./migrate.md)
- [Innovate with Azure VMware Solution](./innovate.md)
- [Govern Azure VMware Solution](./govern.md)
- [Manage Azure VMware Solution](./manage.md)

