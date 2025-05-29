---
title: Govern your portfolio of hybrid and multicloud workloads
description: Expand governance capabilities to hybrid, multicloud, and edge deployments.
author: Zimmergren
ms.author: pnp
ms.date: 05/07/2024
ms.topic: conceptual
ms.custom: e2e-hybrid, think-tank
---

# Govern your portfolio of hybrid and multicloud workloads

The cloud has fundamentally changed IT governance. Intensive manual reviews and change controls processes can now be replaced with automated guardrails and compliance tools. Cloud adoption and workload teams can innovate with confidence, knowing that compliance and governance requirements are detected and are often automated. The key to this newfound freedom is the infrastructure-as-code (IaC) foundation of the cloud. All assets equate back to a defined block of code that can be tested and governed, like any other code base.

You can expand the advantages of cloud governance beyond the cloud in a hybrid, multicloud, and edge strategy. You can combine [Azure Arc](/azure/azure-arc/overview) with [Azure Policy](/azure/governance/policy/overview) and other governance tools. This integration broadens the scope of your governance controls to encompass almost all cloud resources, whether they reside in private or public clouds. Use native Azure tools to incorporate the [unified operations](./unified-operations.md) concept and enhance your governance controls.

## Deploy a unified operations MVP for governance

Well-defined governance starts with sound resource consistency practices. Organizing resources, resource groups, subscriptions, and [management groups allows for ease of governance](/azure/governance/management-groups/overview). Expand your cloud governance practices with a few steps:

- Add a tag for `hosting platform` to all hybrid, multicloud, and edge assets.
- Tag resources from AWS, GCP, and so on.
- Query your resources to see where each is hosted.

After you establish your tagging standards and bring on some of your assets, you can begin governing those resources by using familiar governance tools like Azure Policy.

## Governance disciplines

With a basic understanding of unified operations and Azure Arc, you can extend your disciplines of cloud governance to deployments hosted outside of your Azure environments.

Security baselines are among the most common ways that you can expand your governance disciplines in a unified operations scenario. The following best practices will help preserve your security baseline across all environments:

- [Collect and detect security data across clouds with Microsoft Defender for Cloud](/azure/security-center/quickstart-onboard-machines)
- [Investigate and respond to security threats with Microsoft Sentinel](/azure/sentinel/investigate-cases)
- [Connect AWS accounts to Microsoft Defender for Cloud](/azure/security-center/quickstart-onboard-aws)
- [Connect GCP accounts to Microsoft Defender for Cloud](/azure/security-center/quickstart-onboard-gcp)

## Next step

For more guidance for your cloud adoption journey, see the following article:

- [Manage hybrid and multicloud environments](./manage.md)
