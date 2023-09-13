---
title: Plan for Oracle on Azure Virtual Machines landing zone accelerator
description: Learn about how to plan for Oracle on Azure Virtual Machines landing zone accelerator.  
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 01/10/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
--- 

# Plan for Oracle on Azure Virtual Machines landing zone accelerator  

This article describes how to plan for Oracle on Azure Virtual Machines landing zone accelerator. As discussed in the Oracle strategy article, the potential returns from implementing Oracle on Azure are high only if you right size your Oracle workload on Azure Infrastructure. Getting the   sizing right also provides an opportunity to optimize Oracle licensing cost.

The infrastructure capacity planning exercises provide value of your Oracle workload adoption on Azure and enable the cloud adoption team with the data needed to plan the following technical activities.

The strategy and plan template and other resources in the Cloud Adoption Framework can help your organization to capture a suitable plan for adopting Oracle on Azure.

## Oracle digital estate planning 

Like most complex platforms, your Oracle digital estate includes three asset categories that should be recognized in your plan: platform, foundational, and workload assets.

**Platform assets**: Your Oracle estate runs on different types of infrastructure or potential appliances. Regardless of what your organization does with Oracle, Oracle deployment requirements define those assets. These deployment requirements could include RAC or Exadata configurations as well.
**Foundational assets**: Your Oracle platform and the supporting environment are also upheld by a collection of necessary assets like identity providers, networking, operational management tools, and more. Azure refers to these assets as foundational utilities, and this article series describes how Azure landing zone provides them.

**Workload assets**: Your Oracle platform can consist of Oracle first party applications like e-commerce suite or third party/bespoke applications. Each workload with a dependency on the Oracle workloads should be named, inventoried, rationalized, and tracked individually to allow for granular financial and technical planning decisions.

For guidance on Oracle digital estate planning, look through the processes outlined in the article series on digital estate planning. The best practice article on assessing on-premises workloads for migration to Azure proposes the OMAT tool or capture AWR script tool to make the theoretical guidance from the prior article actionable.

Several considerations should be included in those processes when planning for Oracle adoption: 

**Describe Oracle database platform**: Describe your Oracle estate using AWR reports (or statspack) – providing a list of hosts and database information. Make sure you generated the AWR and statspack reports on peak-load. If you're unsure about the peak-load, we provide you with a script for each AWR and statspack report that helps you define the top five busiest times.  

**Describe Oracle workloads**: Describe your Oracle applications – Oracle first party or third party applications and any custom developed applications. Thereby, it's also important to fix the region you plan to host your application in or other technical requirements like maximum acceptable downtime, SSL offloading and current architecture diagrams. List the application server describing the vCPU configuration, memory, storage and its utilization as well as operating system, app version, throughput and IOPS. 

**Evaluate dependencies**: Dependencies on a core platform like Oracle are often undocumented. Be sure to include a dependency analysis for all assets in the portfolio.  

**Environment planning**: Are you moving production and nonproduction Oracle workload at the same time or separately? Customers often move their nonproduction workload to Azure initially, creating an environment for learning and reducing risk. Once the team is comfortable with how the Oracle solution performs and operates on Azure, the path to migrating the production is smoother.

**Platform rationalization**: The most important consideration is how to rationalize an Oracle solution’s assets; consider how you migrate the platform using lift & shift approach.  

Once these considerations are integrated into your digital estate evaluation, you can refine your business justification. You're ready to build out your Oracle cloud adoption plan.

## Oracle on Azure cloud adoption plan

The Cloud Adoption Framework includes a tool and several templates for creating a cloud adoption plan or Azure DevOps backlog, which are based on the tasks outlined in each methodology. Learn more about templates in the cloud adoption plan and Azure DevOps article.

Whether you use templates or your own project planning tools, factor in the following Oracle-specific actions:

- Depending on requirements create an Azure landing zone to contain the relevant assets for your complete solution – based on architecture guidelines. 

- Evaluate your database assets [AWR/statspack report based]. This evaluation should include a performance analysis to review the current behavior of the database. and right-sizing your Oracle estate to optimize licensing costs and gain desired performance by choosing the correct Virtual Machine SKU on Azure – based on OMA Tool 

- Choose the right deployment architecture - based on architecture guidelines. 

- Account for each workload (or wave of workloads) to be migrated.

You can use the Azure DevOps web interface to add those line items to the plan. If you're working from a current asset inventory, you could build your plan faster with the Microsoft Excel integration outlined in the Cloud Adoption Framework article about [tracking workloads](../../plan/workloads.md).

## Oracle readiness plan

Once you have a general work plan, you can begin aligning team members and estimating the work.

This project's team members could be Oracle or Azure experts, but it's unlikely for the team to have equal expertise in both areas. Use the cloud adoption plan to determine the skills that the team needs to acquire. Then, map those skills to team members to gain a clearer picture of readiness, skilling, and training needs. The Cloud Adoption Framework building a skills readiness plan article and strategy and plan template can help your team to track and address skilling gaps to create stronger cross-functional collaboration in each sprint.

## Next steps  

- [Oracle on Azure landing zone accelerator](introduction-oracle-landing-zone.md)
