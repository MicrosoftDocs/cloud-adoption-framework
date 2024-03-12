---
title: Align roles and responsibilities
description: Prepare for cultural complexity by aligning roles and responsibilities to drive clarity during the migration process.
author: Zimmergren
ms.author: tozimmergren
ms.date: 01/11/2024
ms.topic: conceptual
---

# Align roles and responsibilities

Understanding the culture that's required to operate existing datacenters is important to the success of any migration. In some organizations, datacenter management is contained within centralized IT operations teams. In these centralized teams, roles and responsibilities tend to be well defined and well understood throughout the team. For larger enterprises, especially in organizations that are bound by third-party compliance requirements, the culture tends to be more nuanced and complex. Cultural complexity can lead to roadblocks that are difficult to understand and time-consuming to overcome.

The Azure Cloud Adoption Framework details many different functions that are part of [managing organizational alignment](/azure/cloud-adoption-framework/organize/). The functions aren't departments or organizations. Instead, they can be served by aligning team members in different parts of the organization to work together to complete the function.

To have the most successful migration possible, you need several roles from these functions available. This article provides a guide for what roles come from what functions, and what is needed.

Later articles indicate the roles that are primarily responsible for certain steps. This article is meant to provide a high-level overview of the roles needed.

## Cloud strategy function roles

To make sure that you have the necessary commitment and organization for your migration project, you need the following roles from the [cloud strategy function](/azure/cloud-adoption-framework/organize/cloud-strategy). The following table describes the cloud strategy function roles and their responsibilities:

| Role | Responsibilities |  
| --- | --- |
| Project Sponsor | Define the scope of the migration in terms of what workloads move and what value needs to be achieved by the movement. Provide decision-making ownership for migration tooling purchases, over all workload architecture, and for release activities. |
| Project Manager | Drive the project plan for the overall migration scope. Drive testing processes. Organize status communications to stakeholders. |
| Organizational Change Manager | Help the project team communicate changes to the organization. Work with different functions to make sure that the right team members are involved and that the correct organizational changes occur to support the migration. |
| Licensing Specialist | Provide licensing insight and FinOps management to ensure that the migration project is properly licensed and is using existing license resources. |
| Workload Business Owner | Provide decision-making ownership for workload assessment, architecture, and migration process. Acts as an owner for the business value of the workload operating in Azure. |

Some roles, like specific workload business owners, might not exist in your Cloud Strategy function currently, but the function should be able to identify the right team members to take on the role for the project.

## Cloud adoption function roles

During the migration, most of your technical execution comes from the [cloud adoption function](/azure/cloud-adoption-framework/organize/cloud-adoption). From this function, you should plan to have the roles that are described in the following table:

| Role | Responsibilities |
| --- | --- |
| Migration Architect | Oversee the technical decision making for the workloads, such as migration wave planning and migration processes. |
| Migration Engineer | Execute tasks identified as part of the project. |

## Other supporting roles

The next table describes supporting roles:

| Role | Responsibilities |
| --- | --- |
| Landing Zone Architect | Provide support for migrating workloads to a landing zone. Helps remediate any issues with platform services in the landing zone. See more about [cloud platform functions](/azure/cloud-adoption-framework/organize/cloud-platform). |
| Cloud Operations Manager | Provide support for onboarding migrating workloads to the management platform to ensure proper management is in place for the workloads when migration occurs. See more about [cloud operations functions](/azure/cloud-adoption-framework/organize/cloud-operations). |
| Workload Architect | Provide architectural guidance and decision making for designing the migrating workload in Azure. For each workload, you might need a specific subject matter expert to fulfill multiple instances of this role. See more about [central IT functions](/azure/cloud-adoption-framework/organize/central-it). |
| User Acceptance Tester | Test individual workloads. You might have multiple instances of this role for user acceptance testing (UAT) for each workload, to provide feedback. See more about [central IT functions](/azure/cloud-adoption-framework/organize/central-it). |

## Identify unclear role owners

It can be difficult to identify some of these roles, such as Workload Architect and Workload Business Owner. If a workload has been in maintenance for a long period and without frequent changes, there might be limited ownership and technical expertise. Also, sometimes in digital estate planning, servers might not be mapped to a specific workload, so it can be unclear who has ownership of them.

If you have difficulties identifying roles, try using the following data or approaches:

- **Historical data**: Use your configuration management database or ticketing system to identify any historical items that indicate who requests maintenance or who communicates about the server or workload.
- **Sign-in logs**: Look for the users who were most recently logged into the servers that make up the workload. Although this might not identify an owner, these users can give you context for the server and who supervises or leads their team.
- **Dependency analysis**: Use dependency analysis tools to identify who most frequently connects to the functions that are hosted on the servers. These tools can help you identify business departments, which can in turn help you identify an owner.
- **Related application owners**: Contact owners of applications that service a similar business department or function. Ask them to help you identify the roles that you need.

Even if no one who is an expert currently exists in your organization, you need to fill these roles during the migration process. The business and IT functions should identify interim members, and then build a plan for ownership for long-term support of the workload after migration.

## Scale roles for large migration initiatives

Depending on the size and number of workloads that you migrate, you might need to have multiple team members assigned to each role. A good approach is to use the scale that's described here for up to five workloads that are medium in size and complexity per two-week sprint.

However, workload sizing and complexity can be challenging to judge. In your early migration waves, start with a core team, but scale out if needed.

If you find that you need to scale out, you should also plan for the roles that are described in the following table:

| Role | Responsibilities |
| --- | --- |
| Program Manager | Organizing project management activities across multiple project scopes. |
| Migration Architecture Lead | Driving technical excellence across multiple migration architect scopes. |

## Responsibility matrix example

You can use the following responsibility matrix as a basis for your migration project. You might need to identify more roles or shift responsibilities based on the needs of your organization.

The following table uses this legend:

- **D** = **Driver**: One user who is the single driver of the objective.
- **A** = **Approver**: One or more users who make most decisions, and who are responsible if the objective isn't met.
- **C** = **Contributor**: Users who are responsible for carrying out tasks that support the objective.
- **I** = **Informed**: Users who are affected by the project, and who are informed of decisions and given status updates about the project.

| Role | Digital estate discovery | Migration scope | Project plan | Migration tooling | Workload discovery | Workload assessment | Workload architecture | Wave planning | Workload test migration | Workload migration UAT | Workload migration | Workload release UAT | Organizational change management | Transition to operations | Workload licensing |
| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---| ---|
| **Migration Architect** | D | D | A | D | A | A | D | A | A | A | A | A | I | D | I |
| **Migration Engineer** | C | I | C | C | D | D | C | D | D | C | D | C | I | C | C |
| **Project Manager** | I | I | D | I | I | I | I | I | I | D | I | D | I | C | I |
| **Project Sponsor** | A | A | A | A | I | I | A | I | I | I | A | I | A | A | A |
| **User Acceptance Tester** | I | I | I | I | I | I | I | I | I | C | I | C | I | C | I |
| **Workload Architect** | I | I | C | C | C | C | C | C | C | C | C | C | C | C | I |
| **Workload Business Owner** | I | I | C | I | A | A | A | A | A | A | A | A | C | C | A |
| **Organizational Change Manager** | I | I | C | I | I | I | I | I | I | C | I | C | D | C | I |
| **Licensing Specialist** | I | I | C | C | I | C | C | C | I | I | I | I | I | C | D |
| **Cloud Operations Manager** | C | C | C | I | I | I | I | C | I | I | I | I | C | A | I |
| **Landing Zone Architect** | I | I | C | C | I | I | C | C | I | I | I | I | I | I | I |

## Next step

> [!div class="nextstepaction"]
> [Skills readiness for migration](./skills-and-support.md)
