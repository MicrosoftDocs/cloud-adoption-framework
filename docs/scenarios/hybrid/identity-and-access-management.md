---
title: Govern your portfolio of hybrid and multicloud workloads
description: Expand governance capabilities to hybrid, multicloud, and edge deployments.
author: brianblanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid
---

# Govern your portfolio of hybrid and multicloud workloads

The cloud has fundamentally changed IT governance. Intensive manual reviews and change controls processes can now be replaced with automated guardrails and compliance tools. Cloud adoption and workload teams can innovate with confidence, knowing that compliance and governance requirements are detected and are often automated. The key to this newfound freedom is the infrastructure-as-code foundation of the cloud. All assets equate back to a defined block of code that can be tested and governed, like any other code base.

In a hybrid, multicloud, and edge strategy, the advantages of cloud governance can now be expanded beyond the cloud. You can combine [Azure Arc](/azure/azure-arc/overview) with [Azure Policy](/azure/governance/policy/overview), [Azure Blueprints](/azure/governance/blueprints/overview), and other governance tools. The combination extends many of your governance guardrails to virtually any cloud resource, private or public clouds alike. [Unified operations](./unified-operations.md) is the best concept to extend your governance controls by using native Azure tools.

## Deploy a unified operations MVP for governance

Well-defined governance starts with sound resource consistency practices. Organizing resources, resource groups, subscriptions, and [management groups allows for ease of governance](/azure/governance/management-groups/overview). Expand your cloud governance practices with a few steps:

- Add a tag for `hosting platform` to all hybrid, multicloud, and edge assets.
- Tag resources from AWS, GCP, and so on.
- Query your resources to see where each is hosted.

To get started, [inventory and tag your hybrid and multicloud resources](../../manage/hybrid/server/best-practices/arc-inventory-tagging.md).

After you establish your tagging standards and bring on some of your assets, you can begin governing those resources by using familiar governance tools like Azure Policy. To assign policies to your hybrid and multicloud resources, see the recommended practices on [managing Azure Arc enabled servers with Azure Policy](../../manage/hybrid/server/best-practices/arc-policies-mma.md).

## Governance disciplines

With a basic understanding of unified operations and Azure Arc, you can extend your disciplines of cloud governance to deployments hosted outside of your Azure environments.

Security baselines are among the most common ways that you can expand your governance disciplines in a unified operations scenario. The following best practices will help preserve your security baseline across all environments:

- [Collect and detect security data across clouds with Azure Security Center](/azure/security-center/quickstart-onboard-machines)
- [Investigate and respond to security threats with Azure Sentinel](/azure/sentinel/tutorial-investigate-cases)
- [Connect AWS accounts to Azure Defender](/azure/security-center/quickstart-onboard-aws)
- [Connect GCP accounts to Azure Defender](/azure/security-center/quickstart-onboard-gcp)

## Next steps

For more guidance for your cloud adoption journey, see the following article:

- [Manage hybrid and multicloud environments](./manage.md)
