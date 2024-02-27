---
title: Prepare workloads for migration - Overview
description: Understand the requirements to successfully prepare for a cloud migration.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/27/2024
ms.topic: conceptual
---

# Prepare workloads for migration - Overview

Prior to beginning to plan individual workload migrations or migration waves, there are several key decisions and processes you need to execute. Many of these are covered earlier in the Cloud Adoption Framework, and some are decisions made that will impact all future migration activities.

The Prepare section provides you with guidance to tackle both of these action sets, so that you can begin to migrate with a secure foundation and plan.

To help organize your readiness, you can use the cloud migration readiness assessment.

## Adoption foundation

Prior to beginning your migrations, you need to have a solid foundation.  Previous phases in the CAF provide these.

From the [Plan](/azure/cloud-adoption-framework/plan/) methodology, you should have:

- **A digital estate plan**: See [What is a digital estate?](/azure/cloud-adoption-framework/digital-estate/)
- **Clearly defined roles**: Ensure you have clearly defined roles for managing and governing migrated workloads. See [Initial organization alignment](/azure/cloud-adoption-framework/plan/initial-org-alignment)
- **A skilling plan**: Build a skilling plan to ensure all team members have the skills to be successful post-migration. See [Adapt existing roles, skills, and processes for the cloud](/azure/cloud-adoption-framework/plan/adapt-roles-skills-processes).

From the Ready methodology, you should have:

- **An Azure landing zone**: An Azure Landing Zone implemented and ready to begin receiving workloads. See [What is an Azure landing zone?](/azure/cloud-adoption-framework/ready/landing-zone/)

## Migration-specific considerations

In addition, there are a few migration specific considerations to address.

- Your Azure landing zone might have specific configurations missing supporting migrated workloads.
- You need to use your digital estate plan to build your Migration backlog.
- You need to decide on your migration tooling.
- You need to plan for how you migrate concerning multiple regions.
- You need to address specific skills for migration.
- You need to understand how partnerships can help your migration, and make any partner agreements. You can also review more assistance resources.

The remainder of this section guides you through implementing these activities.

## Definition of done

The preparation phase is considered complete when:

- **Business readiness**
  - Roles, responsibilities, and expectations have been defined and agreed upon.
  - The migration backlog review is complete.
  - The necessary skills are in place.
  - Partnership options have been evaluated.
- **Technical readiness**
  - A landing zone has been established and prepared for migration on the cloud hosting provider.
  - The required migration tools have been evaluated.

The following articles in this section guide you towards a successful preparation process.

## Next steps

Understand how to prepare your landing zone for migrations.

> [!div class="nextstepaction"]
> [Readying your landing zone](./ready-alz.md)
