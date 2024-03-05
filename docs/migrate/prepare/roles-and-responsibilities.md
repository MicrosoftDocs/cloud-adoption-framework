---
title: Aligning roles and responsibilities
description: Prepare for cultural complexity by aligning roles and responsibilities to drive clarity during the migration process.
author: Zimmergren
ms.author: tozimmergren
ms.date: 01/11/2024
ms.topic: conceptual
---

# Aligning roles and responsibilities

An understanding of the culture required to operate the existing datacenters is important to the success of any migration. In some organizations, datacenter management is contained within centralized IT operations teams. In these centralized teams, roles and responsibilities tend to be well defined and well understood throughout the team. For larger enterprises, especially those bound by third-party compliance requirements, the culture tends to be more nuanced and complex. Cultural complexity can lead to roadblocks that are difficult to understand and time consuming to overcome.

The Cloud Adoption Framework details many different functions as part of [managing organizational alignment](/azure/cloud-adoption-framework/organize/). These functions aren't departments or organizations; they can be served by aligning team members in different parts of the organization to work together to complete the function.

To have the most successful migration possible, you need several roles from these functions available. This article provides a guide for what roles come from what functions, and what is needed.

Later articles indicate the roles that are primarily responsible for certain steps. This article is meant to provide a high-level overview of the roles needed.

## Cloud strategy functions

To make sure you have the proper commitment and organization for your migration project, you need the following roles from the [Cloud Strategy function](/azure/cloud-adoption-framework/organize/cloud-strategy).

|Role|Responsibilities|
|---|---|
|Project Sponsor|Owns defining the scope of the migration, in terms of what moves and what value needs to be achieved by the movement. Provides decision making ownership for migration tooling purchases, over all workload architecture, and release activities.|
|Project Manager|Drives the project plan for the over-all migration scope. Drives the testing processes. Organizes and communicates status to stakeholders.|
|Organizational Change Manager|Helps the project team communicate changes to the organization. Works with different functions to make sure the right team members are involved, and the correct organizational changes are occurring to support the migration.|
|Licensing Specialist|Provides licensing insight and FinOps management to ensure that the migration project is properly licensed and is using existing license resources.|
|Workload Business Owners|Provide decision making ownership for workload assessment, architecture, and migration process. Acts as an owner for the business value of the workload operating in Azure.|

Some roles, like specific workload business owners, might not exist in your Cloud Strategy function currently, but the function should be able to identify the right team members to take on the role for the project.

## Cloud adoption roles

During the migration, most of your technical execution comes from the [Cloud Adoption Function](/azure/cloud-adoption-framework/organize/cloud-adoption). From this function, you should plan to have the following roles:

|Role|Responsibilities|
|---|---|
|Migration Architect|Oversees the technical decision making for the workloads, such as migration wave planning and migration processes.|
|Migration Engineer|Execute tasks identified as part of the project.|

## Other supporting roles

|Role|Responsibilities|
|---|---|
|[Cloud platform functions](/azure/cloud-adoption-framework/organize/cloud-platform).<br><li>Example: Landing zone architect|Prove support for migrating workloads into a Landing zone. Helps with the remediation of any issues with the platform services in the landing zone.|
|[Cloud operations functions](/azure/cloud-adoption-framework/organize/cloud-operations).<br><li>Example: Cloud Operations Manager|Provide support for onboarding migrating workloads into the management platform, to ensure proper management is in place day 1 for the workloads.|
|[Central IT functions](/azure/cloud-adoption-framework/organize/central-it).<br><li>Example: Workload Architects|Provide architectural guidance and decision making for designing the migrating workload in Azure. For each workload, you might need a specific subject matter expert to fulfill these roles.|
|[Central IT functions](/azure/cloud-adoption-framework/organize/central-it).<br><li>Example: User Acceptance Tester|Responsible for testing individual workloads. You might have multiple of these for each workload, to provide feedback.|

## Identify unclear role owners

It can be difficult to identify some of these roles, such as Workload Architects and Workload Business Owners. If a workload has been in maintenance for a long period, without frequent changes, there might be limited ownership and technical expertise. Also sometimes, in digital estate planning, you might have servers that aren't mapped to a specific workload, so it can be unclear who has what ownership of them.

If you're encountering challenges with identifying roles, you can try the following:

- **Historical data**: Use your configuration management database or ticketing system to try to identify any historical items that can tell you who requests maintenance or who communicates about the server or workload.
- **Sign-in logs**: Look for the users that were most recently logged into the servers that make up the workload. While this might not identify an owner, these users would be able to give context for the server and who they work under.
- **Dependency analysis**: Use dependency analysis tools to identify who most frequently connect to the functions hosted on the servers, if any. These can help you identify business departments, which can lead you to an owner.
- **Related application owners**: Reach out to owners of applications that service a similar business department or function, and ask them for help with identifying the roles needed.

Even if no one exists who is currently an expert, these roles need to be filled during the migration process, so the business and IT should identify interim members, and build a plan for ownership for long term support of the workload after the migration.

## Scaling roles for large migration initiatives

Depending on the size and number of workloads that you're migrating, you may need to have multiple team members from each role. A good rule of thumb is that the scale approached here can work for up to five medium size/complexity workloads per two-week sprints.

However, workload sizing and complexity can be hard to judge. Early migration waves should start with a core team but scale out if needed.

If you find that such scaling is needed, you should also plan for the following roles:

|Role|Responsibilities|
|---|---|
|Program Manager|Organizing project manager activities across multiple project manager scopes.|
|Migration Architecture Lead|Driving technical excellence across multiple migration architect scopes.|

## Example responsibility matrix

You can use the following responsibility matrix as a basis for your migration project. You might need to identify more roles, or shift responsibilities based on your organization's needs.

In the below table, we use this matrix legend:

- **D**river: A single driver of the objective.
- **A**pprover: One or more approvers who make most decisions, and are responsible if the objective isn't met.
- **C**ontributor: Contributors are responsible for carrying out the tasks.
- **I**nformed:Impacted by the project and are provided status and informed of decisions.

| **Role** | **Digital Estate Discovery** | **Migration Scope** | **Project Plan** | **Migration Tooling** | **Workload Discovery** | **Workload Assessment** | **Workload Architecture** | **Wave Planning** | **Workload Test Migration** | **Workload Migration UAT** | **Workload Migration** | **Workload Release UAT** | **Organizational Change Management** | **Transition to Operations** | **Workload Licensing** |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
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

## Next steps

> [!div class="nextstepaction"]
> [Preparing your migration backlog](./preparing-migration-backlog.md)
