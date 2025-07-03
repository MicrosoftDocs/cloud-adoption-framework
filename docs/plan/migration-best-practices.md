---
title: Apply cloud migration best practices for successful Azure adoption
description: Learn proven patterns for migrating workloads to Azure, including when to rehost versus modernize, and how to minimize risk while maximizing business value.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: conceptual
---

# Understand cloud migration best practices

Successful migrations to Azure follow consistent patterns. Understand these patterns before deciding how to handle each workload. Follow these recommendations:

## Use a rehost for minimal risk

A rehosting approach moves workloads to Azure with minimal changes, providing the fastest path to cloud adoption. This strategy reduces complexity and risk while building foundational cloud experience. You must prioritize rehosting to establish baseline cloud operations before pursuing more complex modernization efforts. Follow these recommendations:

1. **Start with like-for-like migration to minimize risk and accelerate adoption.** Like-for-like migration provides immediate cloud benefits without requiring new application development skills. This approach allows teams to focus on cloud operational capabilities rather than application changes, reducing the potential for deployment failures. Use Azure Migrate or partner tools to assess dependencies and perform automated workload migrations from on-premises environments or other cloud platforms.

2. **Establish cloud operational excellence through rehosting experience.** Rehosting provides practical experience with Azure services, security models, and operational procedures. This experience creates the foundation for more complex modernization efforts. Use rehosting projects to train teams on Azure Resource Manager templates, monitoring tools, and backup procedures that support long-term cloud operations.

## Know when to modernize during migration

Modernizing during migration introduces additional complexity and risk that requires careful evaluation. This decision impacts project timelines, resource requirements, and success rates. You need to assess each modernization opportunity against clear business objectives and technical constraints. Follow these recommendations:

1. **Modernize when you have the required Azure skills and adequate time.** The team needs demonstrated Azure platform expertise and sufficient project timeline to handle modernization complexity. This combination ensures successful implementation without compromising migration deadlines. Assess your team's Azure certifications, hands-on experience with target services, and available project buffer time before committing to modernization efforts.

2. **Modernize when you secure investment backing for the additional effort.** Migration projects present unique opportunities to obtain modernization funding because stakeholders recognize the transformation value. This timing aligns technical improvements with business priorities and budget cycles. Document the total cost of ownership benefits and present clear return on investment calculations to secure necessary resources during the migration planning phase.

3. **Modernize when current technology proves incompatible with Azure services.** Legacy technologies require modernization when Azure lacks equivalent hosting options or support. This necessity creates clear justification for the additional effort and complexity. Identify unsupported operating systems, deprecated frameworks, or proprietary dependencies early in the assessment phase to plan appropriate modernization strategies.

4. **Modernize when existing workloads exhibit critical performance or reliability issues.** Business-critical applications with known problems benefit from modernization during migration rather than perpetuating issues in Azure. This approach addresses root causes while transitioning platforms. Document current performance metrics, identify architectural limitations, and design cloud-native solutions that resolve these issues through Azure platform capabilities.

## Know when to migrate first, then modernize

Sequential migration and modernization reduces risk while preserving modernization opportunities. This approach balances immediate migration needs with long-term transformation goals. You must plan for both phases to ensure successful cloud adoption. Follow these recommendations:

1. **Rehost workloads when you lack immediate modernization capabilities.** Teams without established Azure modernization skills benefit from initial rehosting to meet migration deadlines. This approach provides operational Azure experience while maintaining stable workload performance. Document current application architectures, establish cloud operational baselines, and build team expertise through managing rehosted workloads before attempting complex modernization efforts.

2. **Create specific modernization timelines with executive sponsorship.** Post-migration modernization requires documented commitment and resource allocation to prevent indefinite delays. Executive sponsorship ensures continued investment after initial migration success. Define modernization milestones within six months of migration completion, assign dedicated resources, and establish success metrics that align with business objectives.

3. **Document technical debt and modernization benefits during migration.** Migration assessments reveal architectural limitations and improvement opportunities that justify future modernization. This documentation supports resource requests and priority decisions. Catalog performance bottlenecks, security vulnerabilities, and cost optimization opportunities discovered during migration planning to build compelling modernization business cases.

4. **Use Azure operational data to prioritize modernization efforts.** Running workloads in Azure generates performance metrics and cost data that inform modernization decisions. This information identifies the highest-value modernization targets. Analyze Azure Monitor metrics, Cost Management reports, and Azure Advisor recommendations after 30-60 days of operation to prioritize workloads that deliver maximum modernization return on investment.

## Next steps

> [!div class="nextstepaction"]
> [Discovery your existing inventory](./discovery-inventory.md)