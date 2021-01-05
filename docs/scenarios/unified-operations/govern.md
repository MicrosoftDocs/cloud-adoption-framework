---
title: "Govern hybrid and multicloud deployments"
description: Expand governance capabilities to hybrid, multicloud, and edge deployments
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
---

# Govern hybrid and multicloud deployments

The cloud has fundamental changed IT governance. Human intense, manual review and change controls processes can now be replaced with automated guardrails and enforcement tools. Cloud adoption and workload teams are able to innovate with confidence, knowing that compliance and governance requirements are detected & often times automated. The key to this new found freedom is the infrastructure as code foundation of the cloud. All assets equate back to a defined block of code that can be tested and governed, like any other code base.

In a hybrid, multicloud, and edge strategy, the advantages of cloud governance can now be expanded beyond the cloud. Combining Azure Arc with existing governance tools like Azure Policy, Azure Blueprint, and others, extends many of your governance guardrails to virtually any cloud resource (Private or public clouds alike). [Unified operations](./unified-operations.md) is the best practice concept to extend your governance controls using native Azure tools for governance.

## Deploy a unified operations MVP for governance

Good governance starts with sound resource consistency practices. Organizing resources, resource groups, subscriptions, and management groups allows for ease of governance application. Expand your cloud governance practices with a few simple steps:

- Add a tag for "hosting platform" to all hybrid, multicloud, and edge assets
- Tag resources from AWS, GCP, etc...
- Query your resources to see where they are all hosted.

To get started, [Inventory and tag your hybrid and multicloud resources](https://review.docs.microsoft.com/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/arc_inventory_tagging?branch=pr-en-us-884)
**TODO Point to relative link**

Once you establish your tagging standards and onboarded some of your assets, you can begin governing those resources using familiar governance tools like Azure Policy. To assign policies to your hybrid and multicloud resources, see the best practices on [Managing Arc enabled servers with Azure Policy](https://review.docs.microsoft.com/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/arc_policies_mma?branch=pr-en-us-884).

Continue building on this governance MVP, using the remaining sections of this article or the [best practices on unified operations](https://review.docs.microsoft.com/azure/cloud-adoption-framework/manage/unified-operations/?branch=pr-en-us-884).

## Governance disciplines

With a basic understanding of unified operations and Azure Arc, you can begin extending your disciplines of cloud governance to deployments hosted outside of your Azure environments.

Security baseline is among the most common ways a customer will expand their governance disciplines in a unified operations scenario. THe following best practices will help preserve your security baseline across all environments:

- [Collect and detect security data across clouds with Azure Security Center](https://review.docs.microsoft.com/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/arc_securitycenter?branch=pr-en-us-884)
- [Investigate and respond to security threats with Azure Sentinel](https://review.docs.microsoft.com/azure/cloud-adoption-framework/manage/unified-operations/server/best-practices/arc_azuresentinel?branch=pr-en-us-884)
- [Connect AWS accounts to Azure Defender](https://docs.microsoft.com/azure/security-center/quickstart-onboard-aws)
- [Connect GCP accounts to Azure Defender](https://docs.microsoft.com/azure/security-center/quickstart-onboard-gcp)

## Next step: Manage hybrid and multicloud environments

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Manage hybrid and multicloud environments](./manage.md)
