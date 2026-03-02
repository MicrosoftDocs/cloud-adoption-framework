---
title: Plan for Oracle on Azure adoption
description: Learn how to create a cloud adoption workload migration plan for Oracle on Azure.
author: jfaurskov
ms.author: janfaurs
ms.date: 04/26/2024
ms.topic: concept-article
ms.custom: e2e-oracle
--- 

# Plan for Oracle on Azure

This article describes how to plan for an Oracle on Azure adoption and builds on the [Oracle on Azure strategy](oracle-landing-zone-strategy.md) article. Consider the various factors that affect your decision to move to Azure to get the most out of your migration.

Resources in the Cloud Adoption Framework for Azure help your organization create a suitable plan for adopting Oracle on Azure. Use the [Plan methodology](/azure/cloud-adoption-framework/plan/) of the Cloud Adoption Framework to create an overall cloud adoption plan and help guide your team. This guidance provides templates for creating your backlog and plans for building necessary skills across your teams based on what you want to do in the cloud. This article describes how to include Oracle on Azure adoption into the overall cloud adoption plan.

## Plan your Oracle on Azure estate

Like most complex platforms, your Oracle digital estate includes three asset categories that you should plan for: platform, foundational, and workload assets.

- **Platform assets**: On-premises Oracle estates can run on various types of infrastructure. To some extent, the on-premises assets define the requirements for Oracle deployment on Azure whether your on-premises implementation is Linux-x86 or includes more advanced features. Advanced features include Oracle Real Application Clusters, Exadata configurations, or large endian platforms such as Hewlett Packard Unix (HP-UX), Advanced Interactive Executive (AIX), or a similar platform.

- **Foundational assets**: Your Oracle platform and supporting environment include assets like networking, disaster recovery, and monitoring tools. These assets have corresponding Azure services that you can use to replace or augment your existing Oracle environment. You should inventory and rationalize these assets.

- **Workload assets**: Your existing Oracle solution can consist of Oracle applications, partner applications, or custom applications. Name, inventory, rationalize, and track each workload with Oracle database dependencies for granular financial and technical planning.

Consider the following items when planning for migrating Oracle workloads to Azure:

- **Describe the Oracle database platform**: Describe your Oracle estate using AWR reports or statspack reports. Provide a list of hosts and database performance information. AWR reports or statspack reports should be taken when the system is running at peak load. If you're considering moving to Oracle Database@Azure, you should reach out to your local Oracle sales team for sizing guidance.

- **Describe Oracle workloads**: Describe your applications, including Oracle applications and partner applications. Include custom-developed applications. Prepare the region that you plan to host your application in. You should also ensure that the technical requirements, like maximum acceptable downtime, Secure Sockets Layer (SSL) offloading, and current architecture diagrams, are met. List the application server and describe the CPU configuration, memory, storage, and its usage. Include details on the operating system, app version, throughput, and input/output operations per second (IOPS).

- **Evaluate dependencies**: Document the external dependencies on your Oracle platform. Be sure to include a dependency analysis for all assets in the portfolio. 

- **Plan your environment**: Determine whether you're moving production and nonproduction Oracle workloads concurrently or separately. Customers often move their nonproduction workload to Azure initially, which creates an environment for learning and reduces risk. The path to migrating the production environment is smoother after the team is comfortable with how the Oracle solution performs and operates on Azure.

- **Rationalize your platform**: You should consider identifying and eliminating redundant or obsolete assets as part of the digital estate planning. This process helps reduce costs and improve efficiency.

After you integrate these considerations into your digital estate evaluation, you can refine your business justification. You're ready to build out your Oracle cloud adoption plan.

## Create an Oracle on Azure cloud adoption plan

The Cloud Adoption Framework includes tooling and several templates for creating a cloud adoption plan or Azure DevOps backlog, which are based on the tasks outlined in each methodology. For more information, see [Tools and templates](/azure/cloud-adoption-framework/resources/tools-templates#plan).

Whether you use templates or your own project planning tools, factor in the following Oracle-specific actions:

- Depending on requirements, create an Azure landing zone to contain the relevant assets for your complete solution based on architecture guidelines.

- Evaluate your database assets. This evaluation should include a performance analysis to review the current behavior of the database. Adjust the size of your Oracle estate to effectively manage licensing costs and achieve optimal performance. Select the most suitable Azure architecture for your needs. This architecture can be based entirely on VMs, Oracle Database@Azure, or a combination of both. 

- Choose the right deployment architecture based on architecture guidelines.

- Account for each workload, or wave of workloads, that you plan to migrate.

You can use the Azure DevOps web interface to add the preceding items to your plan. If you use a current asset inventory, you can quickly build your plan with Excel. For more information, see [Add or modify work items in bulk with Excel](/azure/devops/boards/backlogs/office/bulk-add-modify-work-items-excel).

## Create an Oracle readiness plan

After you have a general work plan, you can begin aligning team members and estimating the work.

This project's team should have Oracle and Azure experts, but it's unlikely for the team to have equal expertise in both areas. Use the cloud adoption plan to determine if your team needs to acquire any skills. Then map those skills to team members to gain a clearer picture of readiness, skilling, and training needs. To help your team track and address skilling gaps to create stronger cross-functional collaboration in each sprint, see [Prepare your people for the cloud](/azure/cloud-adoption-framework/plan/prepare-people-for-cloud).

## Next steps

> [!div class="nextstepaction"]
> [Oracle on Azure migration planning](oracle-migration-planning.md)
>
> [Oracle on Azure IaaS landing zone accelerator](oracle-landing-zone-accelerator.md)