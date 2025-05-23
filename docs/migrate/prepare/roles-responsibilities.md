---
title: Align roles and responsibilities
description: Align roles and responsibilities to ensure clarity and coverage of essential functions when migrating to Azure.
author: Zimmergren
ms.author: pnp
ms.date: 04/10/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Align roles and responsibilities

Understanding an organization's culture and datacenter management is vital for Azure migration success. Centralized IT teams with clear roles ease the process, but larger or compliance-bound enterprises face nuanced challenges that can hinder progress.

The Azure Cloud Adoption Framework underscores the role of [organizational alignment](/azure/cloud-adoption-framework/organize/) in migration, advocating for cross-departmental collaboration to fulfill key functions.

In this article, you learn about:

- Migration-specific roles that align with the [cloud strategy](/azure/cloud-adoption-framework/organize/cloud-strategy) and [cloud adoption](/azure/cloud-adoption-framework/organize/cloud-adoption) functions.
- Supporting roles that you might need for other functions during the migration process, for example Landing zone architects and workload architects.
- How to identify relevant experts or owners for roles in your migration projects.
- A responsibility matrix to help understand which role is responsible for what part of a migration project.

> [!TIP]
> The roles mentioned might not match specific job titles or require dedicated team members. Often, one person can cover multiple roles, or several team members can share responsibilities. This list outlines common responsibilities but isn't a staffing guide. The key is ensuring that these responsibilities are met within your organization.

## Cloud strategy function roles

To make sure that you have the necessary commitment and organization for your migration project, you need the following roles for the [cloud strategy function](/azure/cloud-adoption-framework/organize/cloud-strategy). The following table describes the cloud strategy function roles and their responsibilities:

| Role | Responsibilities |  
| --- | --- |
| Project Sponsor | Defines the scope of the migration to determine what resources are moved and the benefit of moving each resource. Provides decision-making ownership for migration tooling purchases, for the overall workload architecture, and for release activities. |
| Project Manager | Drives a project plan for the migration scope. Drives testing processes. Organizes status updates to stakeholders. |
| Organizational Change Manager | Helps the project team communicate changes to the organization. Works with different functions to make sure that the right team members are involved and that the correct organizational changes occur to support the migration. |
| Licensing Specialist | Provides licensing insight and FinOps management to ensure that the project is properly licensed and uses existing licensed resources. |
| Workload Business Owner | Provides decision-making ownership for the workload assessment, architecture, and migration processes. Acts as an owner for the business value of the workload in Azure. |

## Cloud adoption function roles

During your migration to Azure, the [cloud adoption function](/azure/cloud-adoption-framework/organize/cloud-adoption) performs most of the technical execution. For this function, plan to have the roles that are described in the following table:

| Role | Responsibilities |
| --- | --- |
| Migration Architect | Oversees the technical decision making for the workloads, such as migration wave planning and all migration processes. |
| Migration Engineer | Executes tasks that are identified as part of the project. |

## Supporting roles for other functions

The next table describes supporting roles that you might need for other functions:

| Role | Responsibilities |
| --- | --- |
| Landing Zone Architect | Provides support for migrating workloads to a landing zone. Helps remediate any issues with platform services in the landing zone. For more information, see [Cloud platform functions](/azure/cloud-adoption-framework/organize/cloud-platform). |
| Cloud Operations Manager | Provides support for onboarding migrating workloads to the management platform to ensure that proper management is in place for the workloads when they migrate. For more information, see [Cloud operations functions](/azure/cloud-adoption-framework/organize/cloud-operations). |
| Workload Architect | Provides architectural guidance and decision making for the design of the migrating workload. For each workload, you might need a specific subject matter expert to fulfill multiple instances of this role. For more information, see [Central IT functions](/azure/cloud-adoption-framework/organize/central-it). |
| User Acceptance Tester | Tests individual workloads. You might have multiple instances of this role per workload to provide feedback for user acceptance testing (UAT). For more information, see [Central IT functions](/azure/cloud-adoption-framework/organize/central-it). |

## Identify experts or owners for roles

It can be difficult to identify the correct resources for some of these roles, such as for Workload Architect and Workload Business Owner. If a workload is in maintenance for a long period and without frequent changes, you might find limited ownership information and technical expertise to support a function. For example, in digital estate planning, sometimes servers aren't mapped to a specific workload, so it can be unclear who has ownership of them.

Here are some recommendations to identify roles:

- **Historical data**: Use your configuration management database or ticketing system to identify any historical items that indicate who requests maintenance or who communicates about the server or workload.
- **Sign-in logs**: Look for the users who were most recently logged in on the servers in the workload. Although this approach might not identify an owner, recent users can give you context for the server.
- **Dependency analysis**: Use dependency analysis tools to identify who most frequently connects to the functions that are hosted on the servers. These tools can help you identify business departments, which in turn can help you identify an owner.
- **Related application owners**: Contact owners of applications that service a similar business department or function. Ask them to help you identify the roles that you need to fill.
Even if you don't have an expert for a role in your organization, you must fill the role during the migration process. Business teams and IT teams should identify at least interim members, and then build a plan for ownership for long-term support of the workload after it migrates.

## Scale roles for large migration initiatives

Depending on the size and number of workloads that you migrate, you might need to have multiple team members assigned to each role. A good approach is to use the scale that this article describes for up to five workloads that are medium in size and complexity per two-week sprint.

However, workload sizing and complexity can be challenging to judge. In your early migration waves, start with a core team, but scale out if needed.

If you find that you need to scale out, you should also plan for the roles that are described in the following table:

| Role | Responsibilities |
| --- | --- |
| Program Manager | Organizes project management activities across multiple project scopes. |
| Migration Architecture Lead | Drives technical excellence across multiple migration architect scopes. |

## Responsibility matrix example

The following table uses this legend to indicate categories of responsibility per role for stages of a migration project:

- **D** = **Driver**: One individual in the organization who is the single driver of the objective.
- **A** = **Approver**: One or more individuals in the organization who make most decisions and who are responsible if the objective isn't met.
- **C** = **Contributor**: Individuals in the organization who are responsible for carrying out tasks that support the objective.
- **I** = **Informed**: Individuals in the organization who the project affects and who are regularly informed about decisions and the status of the project.

You can use the following responsibility matrix as a basis for your migration project. You might need to identify more roles or to shift responsibilities depending on the needs of your organization.

| Role | Digital estate discovery | Migration scope | Project plan | Migration tooling | Workload discovery | Workload assessment | Workload architecture | Wave planning | Workload test migration | Workload migration UAT | Workload migration | Workload release UAT | Organizational change management | Transition to operations | Workload licensing |
| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---|
| Migration Architect | D | D | A | D | A | A | D | A | A | A | A | A | I | D | I |
| Migration Engineer | C | I | C | C | D | D | C | D | D | C | D | C | I | C | C |
| Project Manager | I | I | D | I | I | I | I | I | I | D | I | D | I | C | I |
| Project Sponsor | A | A | A | A | I | I | A | I | I | I | A | I | A | A | A |
| User Acceptance Tester | I | I | I | I | I | I | I | I | I | C | I | C | I | C | I |
| Workload Architect | I | I | C | C | C | C | C | C | C | C | C | C | C | C | I |
| Workload Business Owner | I | I | C | I | A | A | A | A | A | A | A | A | C | C | A |
| Organizational Change Manager | I | I | C | I | I | I | I | I | I | C | I | C | D | C | I |
| Licensing Specialist | I | I | C | C | I | C | C | C | I | I | I | I | I | C | D |
| Cloud Operations Manager | C | C | C | I | I | I | I | C | I | I | I | I | C | A | I |
| Landing Zone Architect | I | I | C | C | I | I | C | C | I | I | I | I | I | I | I |

## Next step

> [!div class="nextstepaction"]
> [Skills readiness for migration](./skills-support.md)
