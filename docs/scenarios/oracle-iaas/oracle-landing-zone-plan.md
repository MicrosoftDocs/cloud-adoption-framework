---
title: Plan for Oracle on Azure adoption
description: Learn about how to plan for Oracle on Azure.
author: jfaurskov
ms.author: janfaurs
ms.date: 03/22/2024
ms.topic: conceptual
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
--- 

# Plan for Oracle on Azure

This article describes how to plan for Oracle on Azure and builds on the [Oracle on Azure strategy](oracle-landing-zone-strategy.md) article. The potential returns from implementing Oracle on Azure are high only if you consider the different factors affecting the decision to move to Azure.

The [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/main/plan/cloud-adoption-framework-strategy-and-plan-template.docx) and other resources in the Cloud Adoption Framework can help your organization to capture a suitable plan for adopting Oracle on Azure. The [Plan methodology](/azure/cloud-adoption-framework/plan) of the Cloud Adoption Framework helps create an overall cloud adoption plan to guide the programs and teams involved in your cloud-based digital transformation. This guidance provides templates for creating your backlog and plans for building necessary skills across your teams, all based on what you are trying to do in the cloud. This article outlines how to include Oracle on Azure adoption into the overall cloud adoption plan.

## Oracle on Azure estate

Like most complex platforms, your Oracle digital estate includes three asset categories that should be recognized in your plan: platform, foundational, and workload assets.

**Platform assets**:  On-premises Oracle estates can run on different types of infrastructure. The on-premises assets define the requirements for Oracle deployment on Azure to some extent. It's true whether your on-premises implementation is Linux-x86 or includes more advanced features. Advance features include Oracle Real Application Clusters, Exadata configurations, or large endian platforms such as HPUX, AIX or similar.

**Foundational assets**: Your Oracle platform and the supporting environment are also comprised of a collection of necessary assets like networking, disaster recovery, and monitoring tools. These assets have corresponding Azure services that you can use to replace or augment your existing Oracle environment. You should inventory and rationalize these assets.

**Workload assets**: Your existing Oracle solution can consist of Oracle first-party, third-party, or bespoke applications. Each workload with a dependency on Oracle database services should be named, inventoried, rationalized, and tracked individually to allow for granular financial and technical planning decisions.

Consider the following items when planning for migrating Oracle workloads to Azure:

**Describe Oracle database platform**: Describe your Oracle estate using AWR reports (or statspack). Provide a list of hosts and database performance information. AWR reports or statspack report should be taken when the system is running at peak load. Specifically, if you're considering moving to Oracle Database@Azure, you should reach out to your local Oracle sales team for sizing guidance.

**Describe Oracle workloads**: Describe your Oracle applications, such as Oracle first-party or third-party applications. Also include custom developed applications. It's important to fix the region you plan to host your application in or other technical requirements like maximum acceptable downtime, SSL offloading, and current architecture diagrams. List the application server and describe the CPU configuration, memory, storage, and its utilization. Include details on the operating system, app version, throughput, and IOPS.

**Evaluate dependencies**: External dependencies on a core platform like Oracle should be documented. Be sure to include a dependency analysis for all assets in the portfolio.  

**Environment planning**: Are you moving production and nonproduction Oracle workload at the same time or separately? Customers often move their nonproduction workload to Azure initially, creating an environment for learning and reducing risk. Once the team is comfortable with how the Oracle solution performs and operates on Azure, the path to migrating the production environment is smoother.

**Platform rationalization**: As part of the digital estate planning, you should consider identifying and eliminating redundant or obsolete assets. This process can help you to reduce costs and improve efficiency.

Once these considerations are integrated into your digital estate evaluation, you can refine your business justification. You're ready to build out your Oracle cloud adoption plan.

## Oracle on Azure cloud adoption plan

The Cloud Adoption Framework includes tooling and several templates for creating a cloud adoption plan or Azure DevOps backlog, which are based on the tasks outlined in each methodology. For more information, see [Tools and templates](/azure/cloud-adoption-framework/resources/tools-templates#plan).

Whether you use templates or your own project planning tools, factor in the following Oracle-specific actions:

- Depending on requirements create an Azure landing zone to contain the relevant assets for your complete solution – based on architecture guidelines.

- Evaluate your database assets. This evaluation should include a performance analysis to review the current behavior of the database. Additionally, adjust the size of your Oracle estate to effectively manage licensing costs and achieve optimal performance. Select the most suitable Azure architecture for your needs. It could be entirely virtual machine-based, entirely based on Oracle Database@Azure, or a combination of both.

- Choose the right deployment architecture - based on architecture guidelines.

- Account for each workload (or wave of workloads) to be migrated.

You can use the Azure DevOps web interface to add those line items to the plan. If you're working from a current asset inventory, you could build your plan faster with the Microsoft Excel integration outlined in the Cloud Adoption Framework article about [tracking workloads](../../plan/workloads.md).

## Oracle readiness plan

Once you have a general work plan, you can begin aligning team members and estimating the work.

This project's team members should have Oracle and Azure experts, but it's unlikely for the team to have equal expertise in both areas. Use the cloud adoption plan to determine the skills that the team needs to acquire if any. Then, map those skills to team members to gain a clearer picture of readiness, skilling, and training needs. The Cloud Adoption Framework building a skills readiness plan article and strategy and plan template can help your team to track and address skilling gaps to create stronger cross-functional collaboration in each sprint.

## Next steps

> [!div class="nextstepaction"]
> [Oracle on Azure migration planning](oracle-migration-planning.md)