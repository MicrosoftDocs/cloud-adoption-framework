---
title: Risk tolerance metrics and indicators in the Deployment Acceleration discipline
description: Use the Cloud Adoption Framework for Azure to quantify business risk tolerance related to the Deployment Acceleration discipline.
author: alexbuckgit
ms.author: abuck
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Risk tolerance metrics and indicators in the Deployment Acceleration discipline

Learn to quantify business risk tolerance associated with the Deployment Acceleration discipline. Defining metrics and indicators helps to create a business case for investing in the maturity of this discipline.

## Metrics

Deployment acceleration focuses on risks related to how cloud resources are configured, deployed, updated, and maintained. The following information is useful when adopting the Deployment Acceleration discipline:

- **Deployment failures:** Percentage of deployments that fail or result in misconfigured resources.
- **Time to deployment:** The amount of time needed to deploy updates to an existing system.
- **Assets out-of-compliance:** The number or percentage of resources that are out of compliance with defined policies.

## Risk tolerance indicators

Risks related to deployment acceleration are largely related to the number and complexity of cloud-based systems deployed for your enterprise. As your cloud estate grows, the number of systems deployed and the frequency of updating your cloud resources will increase. Dependencies between resources magnify the importance of ensuring proper configuration of resources and designing systems for resiliency if one or more resources experiences unexpected downtime.

Traditional corporate IT organizations often have siloed operations, security, and development teams that often do not collaborate well or are even adversarial or hostile toward one another. Recognizing these challenges early and integrating key stakeholders from each of the teams can help ensure agility in your cloud adoption while remaining secure and well-governed. Therefore, consider adopting a DevOps or [DevSecOps](https://www.microsoft.com/devsecops) organizational culture early in your cloud adoption journey.

Work with your DevSecOps team and business stakeholders to identify [business risks](./business-risks.md) related to configuration, then determine an acceptable baseline for configuration risk tolerance. This section of the Cloud Adoption Framework guidance provides examples, but the detailed risks and baselines for your company or deployments will likely differ.

Once you have a baseline, establish minimum benchmarks representing an unacceptable increase in your identified risks. These benchmarks act as triggers for when you need to take action to remediate these risks. The following are a few examples of how configuration-related metrics, such as those discussed above, can justify an increased investment in the Deployment Acceleration discipline.

- **Configuration drift triggers:** A company that is experiencing unexpected changes in the configuration of key system components, or failures in the deployment of or updates to its systems, should invest in the Deployment Acceleration discipline to identify root causes and steps for remediation.
- **Out of compliance triggers:** If the number of out-of-compliance resources exceeds a defined threshold (either as a total number of resources or a percentage of total resources), a company should invest in Deployment Acceleration discipline improvements to ensure each resource's configuration remains in compliance throughout that resource's lifecycle.
- **Project schedule triggers:** If the time to deploy a company's resources and applications often exceed a define threshold, a company should invest in its deployment acceleration processes to introduce or improve automated deployments for consistency and predictability. Deployment times measured in days or even weeks usually indicate a suboptimal Deployment Acceleration strategy.

## Next steps

Use the [Deployment Acceleration discipline template](./template.md) to document metrics and tolerance indicators that align to the current cloud adoption plan.

Review sample Deployment Acceleration policies as a starting point to develop your own policies to address specific business risks aligned with your cloud adoption plans.

> [!div class="nextstepaction"]
> [Review sample policies](./policy-statements.md)
