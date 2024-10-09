---
title: Govern AI – Recommendations for governing AI
description: Get recommendations for governing AI. Get recommendations for governing models, costs, security, operations, compliance, and data management.
author: stephen-sumner
ms.author: ssumner
ms.date: 11/01/2024
ms.topic: conceptual
---

# Govern AI – Recommendations for governing AI

This article provides recommendations for developing an AI governance framework. It assumes that you're already familiar with the governance processes defined in [Govern overview](/azure/cloud-adoption-framework/govern/) and doesn't repeat the common cloud governance practices described there. Additionally, it assumes that you've established governance policies at the management group level for your AI workload types, like internet-facing (online) and internal (corporate) workloads. These polices are covered in [AI Ready](ready.md#prepare-ai-resource-organization).

The following recommendations are intended as a starting point for your AI governance. The goal is to create a unified governance framework to mitigate AI risks. You need to assess the risks that are specific to your business and stay vigilant about emerging risks so that you can update your AI governance policies accordingly.



## Next step

> [!div class="nextstepaction"]
> [Manage AI](manage.md)

## Example AI risk mitigations

The following table lists some common AI risks and provides a mitigation strategy and a sample policy for each one. The table doesn't list a complete set of risks.

| Risk ID | AI risk  | Mitigation | Policy|
|---|---|---|---|
| R001    | Noncompliance with data protection laws  | Use Microsoft Purview Compliance Manager to evaluate data compliance.                                  |The Security Development Lifecycle must be implemented to ensure that all AI development and deployment complies with data protection laws.          |
| R005    | Lack of transparency in AI decision making | Apply a standardized framework and language to improve transparency in AI processes and decision making.                 | The NIST AI Risk Management Framework must be adopted and all AI models must be thoroughly documented to maintain transparency of all AI models.              |
| R006    | Inaccurate predictions           | Use Azure API Management to track AI model metrics to ensure accuracy and reliability.                          |Continuous performance monitoring and human feedback must be used to ensure that AI model predictions are accurate.               |
| R007    | Adversarial attack             | Use PyRIT to test AI systems for vulnerabilities and strengthen defenses.                                |The Security Development Lifecycle and AI red team testing must be used to secure AI systems against adversarial attacks. |
| R008    | Insider threats              | Use Microsoft Entra ID to enforce strict access controls that are based on roles and group memberships to limit insider access to sensitive data.      | Strict identity and access management and continuous monitoring must be used to mitigate insider threats.           |
| R009    | Unexpected costs              | Use Microsoft Cost Management to track CPU, GPU, memory, and storage usage to ensure efficient resource utilization and prevent cost spikes. |Monitoring and optimization of resource usage and automated detection of cost overruns must be used to manage unexpected costs.      |
| R010    | Underutilization of AI resources      | Monitor AI service metrics, like request rates and response times, to optimize usage.                          | Performance metrics and automated scalability must be used to optimize AI resource utilization.               |

