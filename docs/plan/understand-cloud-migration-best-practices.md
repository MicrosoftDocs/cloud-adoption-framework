---
title: Apply cloud migration best practices for successful Azure adoption
description: Learn proven patterns for migrating workloads to Azure, including when to rehost versus modernize, and how to minimize risk while maximizing business value.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: conceptual
---

# Understand cloud migration best practices

This article outlines proven patterns that support successful Azure migrations. These patterns help you evaluate each workload and select the most effective migration approach. Follow these recommendations:

## Know when to rehost then modernize

A rehost is a like-for-like migration strategy. You move workloads to Azure with minimal changes, providing a fast and low-risk path to cloud adoption. This approach establishes a foundation for future modernization while minimizing business disruption. You must plan for both rehosting and modernization phases to achieve successful cloud adoption. 


1. **Rehost workloads to minimize business disruption.** A like-for-like migration transfers workloads to Azure with the fewest possible changes, enabling rapid adoption and reducing migration complexity. This strategy allows your organization to realize immediate cloud benefits, such as improved scalability and availability, without requiring new application development skills. Use Azure Migrate or partner tools to assess dependencies and automate workload migrations from on-premises or other cloud platforms. Prioritize rehosting to establish baseline cloud operations and reduce the risk of deployment failures. Adopt new processes and practices more effectively by keeping workloads similar to their source environment. Plan to modernize workloads in Azure after rehosting, especially for large-scale datacenter transformations. Launch a cloud skills initiative in parallel to build team readiness for future modernization. See [Shared responsibility in the cloud](/azure/security/fundamentals/shared-responsibility).

2. **Rehost to build cloud operational capabilities.** Rehosting provides hands-on experience with Azure services, security models, and operational procedures. This experience prepares teams for more advanced modernization efforts. Train teams on Azure Resource Manager templates, monitoring tools, and backup procedures during rehosting projects to support long-term cloud operations.

3. **Rehost when modernization skills or time are limited.** Teams without established Azure modernization skills or with tight migration timelines benefit from initial rehosting. This approach delivers operational Azure experience while maintaining stable workload performance. Document current application architectures, establish cloud operational baselines, and build team expertise by managing rehosted workloads before pursuing complex modernization.

4. **Commit to modernization post-migration.** Post-migration modernization requires clear commitment and resource allocation to avoid indefinite delays. Executive sponsorship ensures continued investment after initial migration. Set modernization milestones within six months of migration completion, assign dedicated resources, and establish success metrics aligned with business objectives.

5. **Document technical debt and modernization opportunities during migration.** Migration assessments reveal architectural limitations and areas for improvement that support future modernization. Catalog performance bottlenecks, security vulnerabilities, and cost optimization opportunities identified during migration planning to build strong business cases for modernization.

6. **Use Azure operational data to prioritize modernization.** Running workloads in Azure generates performance metrics and cost data that inform modernization decisions. Analyze Azure Monitor metrics, Cost Management reports, and Azure Advisor recommendations after 30–60 days of operation to identify and prioritize workloads that offer the greatest modernization value.

## Know when to modernize workloads during migration

While modernizing as you migrate can yield long-term benefits, it also introduces additional complexity and risk. Only pursue modernization during migration when there is a compelling business reason to do so. For each potential modernization effort, be sure to perform a thorough cost-benefit and risk analysis before proceeding

1. **Modernize only when you have the skillset and time.** An attempt to modernize without the necessary Azure skills or time can delay migration and increase risk. If your team lacks experience or time, defer the workload to a later migration wave.

1. **Modernize only after you validate service model impacts.** A service model defines how your organization delivers and manages computing resources, such as on-premises, infrastructure as a service (IaaS), or platform as a service (PaaS). Many organizations assume that moving to PaaS always reduces costs compared to IaaS, but this assumption can lead to premature modernization without sufficient validation, skills, or time. Validate cost, skill, and process impacts before selecting a new service model. Review current workload requirements and compare them to Azure IaaS and PaaS capabilities. Analyze total cost of ownership for each service model, including operational, licensing, and support costs. Identify required skills and training for teams to operate and support the target service model. Plan for changes in engineering practices and delivery processes that the new service model introduces. Engage stakeholders to validate assumptions and align service model decisions with business objectives.

1. **Modernize when you secure investment and executive support.** Migration projects often present the best opportunity to secure funding for modernization efforts. Take advantage of this moment to align modernization activities with business priorities. Delaying modernization may result in running inefficient workloads in Azure and missing the chance to get stakeholder support later. This can lead to higher costs from inefficient code, unnecessary calls, and increased maintenance requirements.

1. **Modernize when current technology is incompatible with Azure services.** Legacy technologies require modernization when Azure does not support equivalent hosting options. This requirement provides clear justification for the additional effort and complexity. Identify unsupported operating systems, deprecated frameworks, or proprietary dependencies early in the assessment phase to plan appropriate modernization strategies.

1. **Modernize when workloads have critical performance or reliability issues.** Business-critical applications with known problems benefit from modernization during migration rather than carrying issues into Azure. This approach addresses root causes while transitioning platforms. Document current performance metrics, identify architectural limitations, and design cloud-native solutions that resolve these issues using Azure platform capabilities.

## Next steps

> [!div class="nextstepaction"]
> [Discover your existing inventory](./discovery-inventory.md)