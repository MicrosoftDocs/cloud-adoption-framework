---
title: What's new 
description: Learn about updates to the Microsoft Cloud Adoption Framework for Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/02/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: reference
---

# What's new in the Microsoft Cloud Adoption Framework

## Fulfilling the vision

The framework has reached general availability (GA). However, we are still actively building this framework in collaboration with customers, partners, and internal teams. To encourage partnership, content is released as it becomes available. These public releases enable testing, validating, and incrementally refining the guidance.

Significant changes are captured in the following release notes.

## Migration update: 03/02/2020

This release responded to feedback regarding continuity of the migration approach through multiple methodologies, including Strategy, Plan, Ready, and Migrate. The goal of this release was to make it easier for readers to understand the continued refinement of planning and adoption, as customers continue a migration journey. The following changes were made to fulfill the spirit of this release:

### New articles

- [Balancing competing priorities](../strategy/balance-competing-priorities.md): Outlines the balance in priorities occurring in each methodology to inform customer strategies
- [Classification during assess processes](../migrate/migration-considerations/assess/classify.md): Outlines the importance of classifying every asset and workload prior to migration.

### Restructure landing zone process

First landing zone has been pulled out of the readiness guide to serve as it's own section. This approach allows us to expand on the concept of landing zones and landing zone options. This also led to the creation of a few new articles:

- [What is a landing zone?](../ready/landing-zone/index.md): Defines the term landing zone
- [First landing zone](../ready/landing-zone/first-landing-zone.md): Expands on the comparison of various landing zones
- [Migrate landing zone](../ready/landing-zone/migrate-landing-zone.md): Moved the prior landing zone blueprint article, to separate the definition of the blueprint from the selection of the first landing zone, to allow for more landing zone options.
- [Terraform landing zone](../ready/landing-zone/terraform-landing-zone.md) article: Moved from the "Expanded scope" section of the Ready methodology to the new "Landing zone" section of Ready methodology, to treat terraform a first class citizen in the landing zone conversation.
- Group basic landing zone considerations together in the table of contents under "Basic landing zone considerations".
- Moved security best practices from the Migrate methodology into a new landing zone section call "Improve landing zone security (Sensitive data)" to expose readers to this guidance earlier in the lifecycle.

### Refinements to the Azure Migration Guide

User traffic patterns suggest that this section of content is more likely to be used by implementers and architects during their first migration. TO better support this audience, the focus of the migration guide has been refined to better align with the original intent of exposing readers to the tools used during a first migration.

- [Overview](../migrate/azure-migration-guide/index.md): Clearer description of the guide, with reduced number of steps.
- [Assess](../migrate/azure-migration-guide/assess.md): Better illustrate that the assessment in this phase focuses on assessing technical fit of a specific workload and related assets. Added Challenging Assumptions section to demonstrate who this level of assessment works with the Incremental assessment approach first mentioned in the Plan methodology.
- [Migrate](../migrate/azure-migration-guide/migrate.md): In response to feedback at tier 1 conferences, a reference to UnifyCloud was added to the third-party tool options.
- [Test, Optimize, and Promote](../migrate/azure-migration-guide/optimize-and-transform.md): Aligning the title of this article with other process improvement suggestions.

### Refinements to migration process improvements

- [Assess overview](../migrate/migration-considerations/assess/index.md): Better illustrate that the assessment in this phase focuses on assessing technical fit of a specific workload and related assets.
- [Planning Checklist](../migrate/migration-considerations/prerequisites/planning-checklist.md): Clarify the importance of operations alignment during planning for migration efforts to ensure a well-managed workload, post-migration.

### Placement of related articles

Each article list below been moved. Traffic is redirected the new location.

- [Assessment best practice](../plan/contoso-migration-assessment.md) article: Moved from the "Best Practices" section of the Migrate methodology to the new "Best Practice" section of the Plan methodology. This move exposes readers to the practice of assessing local environments earlier in the lifecycle.
- [Balance the portfolio](../strategy/balance-the-portfolio.md) article: Moved from the "Expanded scope" section of the Migrate methodology to the  Strategy methodology. This move exposes readers to this thought process earlier in the lifecycle.

### Alignment of the changes

- [Ready Overview](../ready/index.md): Update the four steps in the Ready overview to reflect the refined process
- [Migrate Overview](../migrate/index.md): Update the steps in the Migrate overview to reflect the refined process
- [Migrate methodology graphic](../migrate/index.md): Update to methodology image to reflect changes
- [Overview graphic](../index.md): Updates to overview graphic to reflect changes
