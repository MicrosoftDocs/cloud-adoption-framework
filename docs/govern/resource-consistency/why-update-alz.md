---
title: 'Why update Azure Landing Zone environments'
description: Use the Cloud Adoption Framework for Azure to determine when to update your Azure Landing Zone implementation.
author: Jfaurskov
ms.author: Janfaurs
ms.date: 01/10/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Why update Azure Landing Zone environments

Azure Landing Zone (ALZ) is a set of pre-defined Azure resources and configurations that provide a foundation for a cloud-based application or workload. As a business, it is important to ensure that your deployed ALZ environment is up to date in order to maintain security, platform configuration drift and optimized for new feature releases.

Here are a few reasons why keeping your Azure Landing Zone up to date is crucial:
1. Security: Cybersecurity threats are constantly evolving, and it is important to ensure that your Azure Landing Zone reflect the latest best practices for protecting your data and systems. Keeping your Azure Landing Zone up to date helps you mitigate the risk of a security breach and helps you keep your data properly secured.
2. Platform configuration drift: As Azure Landing Zone continues to be developed, drift relative to your deployed environment will be introduced. Examples of drift include:
    - ALZ Policies could be superseded by built-in Azure policies or updated to newer versions of ALZ policies.
    - Improvements to network features
    - New feature introduction
    
    The longer drift is left unattended, it will incur increasing technical debt, that will require remediating. To avoid high volumes of remediation activities, it is encouraged to regularly evaluate against provided guidance on changes to [Azure Landing Zone](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new).
3. Optimization for Azure improvements: As new Azure features and services are released, Azure Landing Zone may be modified to include them. Likewise, as older Azure features become deprecated, this may also require changes to Azure Landing Zone.
4. Getting support. Azure landing zones, as a deployable reference and implementation, is an open-source project, and as such support is limited to community engagement. Being aligned to the current implementation makes community support more likely.

In summary, not staying up-to-date with ALZ could reduce your security posture as well as the benefits you are currently leveraging from ALZ. To protect your investment in Azure, you are encouraged to regularly review and update your Azure Landing Zone estate as required. In the following section are links to guidance on how to do so. 

## Next steps
For current details and guidance on how to update your ALZ implementation, please refer to the following sections.

- [Azure Landing Zone What's new](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new)
- [Migrate ALZ custom policies to Azure built-in policies](./update-alz-policies.md)
- [Updating Azure Landing Zone custom policies to new versions](./update-alz-custom-policies.md)