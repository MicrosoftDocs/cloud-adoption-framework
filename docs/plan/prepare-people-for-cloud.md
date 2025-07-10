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

## Understand the cloud skills you need

A clear understanding of required cloud skills enables targeted development and accelerates Azure adoption. Skill alignment reduces implementation risks and increases the return on cloud investments. You must assess your team's readiness across three core skill categories: Azure adoption fundamentals, Azure environment management, and cloud-native development.

1. **Understand the skills required to adopt Azure.** Foundational skills include governance, security, identity, networking, management, and workload design. These skills ensure secure and effective use of Azure from the start. You must review Azure [governance](/azure/cloud-adoption-framework/govern/), [security](/azure/cloud-adoption-framework/secure/overview) ([identity and access management](/entra/fundamentals/introduction-identity-access-management), [networking](/azure/networking/foundations/network-foundations-overview)), [management](/azure/cloud-adoption-framework/manage/) ([deployments](/cloud-adoption-framework/manage/administer#manage-cloud-resources), [monitoring](/azure/cloud-adoption-framework/manage/monitor), [reliability](/azure/cloud-adoption-framework/manage/protect#manage-reliability)) to identify gaps in your team's knowledge. Use the [Azure Architecture Center](/azure/architecture/guide/), and [Well-Architected Framework](/azure/well-architected/) to guide workload design and architecture decisions.

2. **Understand the skills required to manage Azure.** Assess the skills required to manage Azure environments. Management skills ensure operational excellence and alignment with business objectives. These include administering resources, monitoring performance, and protecting workloads. Use the RAMP model (Ready, Administer, Monitor, Protect) to evaluate your team's capabilities. Incorporate tools such as Azure DevOps, GitHub, and infrastructure as code (IaC) platforms like Bicep, Terraform, and ARM templates. See [CAF Manage](/azure/cloud-adoption-framework/manage/).

3. **Understand the skills required for cloud-native development.** Evaluate the skills required for cloud-native development. Cloud-native development supports innovation and modernization goals. These skills include platform engineering, containerization, microservices, and AI development. See [AI development](../scenarios/ai/plan.md#assess-ai-skills) and [cloud-native development](../innovate/index.md).

## Close the skills gap

After you identify Azure skill gaps, take deliberate steps to close those gaps. Targeted training reduces risk, accelerates delivery, and increases team confidence. If your timeline requires faster results, engage external experts to provide focused support and hands-on guidance.

1. **Train your team using Microsoft Learn.** [Microsoft Learn](/) contains Microsoft product [documentation](/docs), [personalized training](/plans/ai/), [credentials](/credentials/) like [Microsoft Applied Skills](/credentials/applied-skills/) and [Microsoft certifications](/credentials/browse/) aligned to Azure roles. Encourage your team to pursue certifications such as Azure Administrator, Developer, Solutions Architect, or DevOps Engineer. Certifications validate skills and build confidence.

2. **Use expert support to accelerate readiness.** Expert guidance provides hands-on experience and reduces implementation risks when timelines are compressed. Microsoft specialists and trusted partners offer workshops, architectural reviews, and practical training that help teams avoid common pitfalls. You need to engage experts who can provide targeted support aligned to your specific cloud adoption goals. Contact [Microsoft](https://azure.microsoft.com/solutions/migration/migrate-modernize-innovate/) specialists or find trusted [partners](https://partner.microsoft.com/partnership/find-a-partner) who can deliver workshops, conduct architectural reviews, and provide hands-on guidance tailored to your Azure adoption requirements.

## Sustain cloud skills across your organization

Cloud technology constantly evolves with new Azure services, features, and ecosystem updates released regularly. Organizations that maintain current cloud capabilities outperform those with outdated skills and achieve better business outcomes. You should establish processes that support continuous learning and practical application of new cloud knowledge.

1. **Create a learning sandbox.** Provide a safe, low-risk Azure environment where teams can experiment, test, and learn without affecting production workloads. Use Azure Dev/Test subscriptions to manage costs and access. For an example, see [Azure landing zone sandbox environments](/azure/cloud-adoption-framework/ready/considerations/sandbox-environments).

2. **Promote continuous learning.** A continuous learning culture ensures teams maintain current Azure skills as cloud technologies evolve. Regular engagement with learning resources keeps your organization prepared for new Azure capabilities and implementation methods. You need to establish structured programs that encourage and reward ongoing skill development.

    a. Dedicate time each week for team members to complete Microsoft Learn modules aligned with your cloud adoption goals
    b. Create a recognition system that tracks Microsoft Learn points and celebrates learning achievements
    c. Schedule regular participation in Azure community events, user groups, and technical sessions
    d. Maintain a curated collection of trusted Azure blogs, videos, and documentation for quick reference on new services and best practices

3. **Implement a skills management program.** A formal program tracks team capabilities, identifies gaps, and aligns training to business priorities. This structured approach ensures your organization maintains the right skills for current and future cloud initiatives. Develop a skills matrix that maps required Azure competencies to roles and create individual development plans that include certification targets.

## Next steps

> [!div class="nextstepaction"]
> [3. Plan your migration to Azure](./discover-existing-workload-inventory.md)

Cloud-native startups skip to step four:

> [!div class="nextstepaction"]
> [4. Estimate total cost of ownership](./estimate-total-cost-of-ownership.md).
