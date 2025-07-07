---
title: Prepare your people for the cloud
description: Discover actionable guidance to equip your team with the skills needed for successful Azure adoption.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: conceptual
---

# Prepare your people for the cloud

This article provides guidance to equip your team with the skills necessary for successful Azure adoption. Proper skill development accelerates cloud adoption, reduces implementation risks, and maximizes your return on cloud investments. Follow these recommendations to assess skill needs, develop capabilities, and create a culture of continuous learning that supports your cloud adoption journey.

## Assess cloud skills

A clear understanding of your team’s current capabilities and future requirements is essential to guide upskilling efforts. Different cloud adoption goals, such as migration, modernization, or building cloud-native solutions, require distinct skill sets. You must assess your team’s readiness across three dimensions:

1. **Identify skills to adopt Azure.** These are the foundational skills needed to begin using Azure securely and effectively. They include Azure [governance](/azure/cloud-adoption-framework/govern/), [security](/azure/cloud-adoption-framework/secure/overview) ([identity and access management](/entra/fundamentals/introduction-identity-access-management), [networking](/azure/networking/foundations/network-foundations-overview)), [management](/azure/cloud-adoption-framework/manage/), and workload design ([cloud architecture](/azure/architecture/guide/), and [Well-Architected Framework](/azure/well-architected/)).

2. **Identify skills for ongoing operations.** Effective cloud management ensures your Azure cloud estate aligns with business objectives and minimizes the effects of incidents. Use Cloud Adoption Framework's RAMP (Ready, Administer, Monitor, Protect) process to manage your Azure cloud estate. See [CAF Manage](/azure/cloud-adoption-framework/manage/). Use tools like Azure DevOps, GitHub, AI development assistance (GitHub Copilot), and infrastructure as code (Bicep, Terraform, and ARM templates).

3. **Identify skills for innovation.** These are skills aligned to your innovation goals, such as [AI development](../scenarios/ai/plan.md#assess-ai-skills) and [cloud-native development](../innovate/index.md), and platform engineering.

## Close identified skill gaps

Once you identify the gaps, take deliberate steps to close those gaps. Upskilling is essential to reduce risk, accelerate delivery, and improve confidence across teams.

1. **Upskill your team using Microsoft Learn.** [Microsoft Learn](/) contains Microsoft product [documentation](/docs), [personalized training](/plans/ai/), [credentials](/credentials/) like [Microsoft Applied Skills](/azure/credentials/applied-skills/) and [Microsoft certifications](/credentials/browse/?credential_types=certification) aligned to Azure roles. Encourage your team to pursue certifications such as Azure Administrator, Developer, Solutions Architect, or DevOps Engineer. Certifications validate skills and build confidence.

2. **Use expert support to accelerate readiness.** [Microsoft](https://azure.microsoft.com/solutions/migration/migrate-modernize-innovate/) experts or trusted [partners](https://partner.microsoft.com/partnership/find-a-partner) provide hands-on guidance, workshops, and architectural reviews. These engagements help teams gain practical experience and avoid common pitfalls.

## Sustain skills across the organization

Cloud adoption is not a one-time event. You must create a culture of continuous learning and experimentation to keep pace with Azure innovation.

1. **Create a learning sandbox.** Provide a safe, low-risk Azure environment where teams can experiment, test, and learn without affecting production workloads. Use Azure Dev/Test subscriptions to manage costs and access. For an example, see [Azure landing zone sandbox environments](/azure/cloud-adoption-framework/ready/considerations/sandbox-environments).

2. **Promote continuous learning.** Encourage ongoing training through Microsoft Learn and internal programs. Gamify learning by recognizing top learners, tracking Microsoft Learn points, and offering monthly rewards.

## Next steps

If you’re not migrating any workloads to Azure and only building cloud-native, skip to:

> [!div class="nextstepaction"]
> [Estimate total cost of ownership](./plan-azure-environment-cost-estimation.md).

If you're migrating workloads to Azure, follow:

> [!div class="nextstepaction"]
> [Plan your migration to Azure](./discover-existing-inventory.md)
