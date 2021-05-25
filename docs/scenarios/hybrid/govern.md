---
title: Govern your portfolio of hybrid and multicloud workloads
description: Expand governance capabilities to hybrid, multicloud, and edge deployments.
author: brianblanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: e2e-hybrid
---

# Govern your portfolio of hybrid and multicloud workloads

The cloud has fundamentally changed IT governance. Intensive manual reviews and change controls processes can now be replaced with automated guardrails and compliance tools. Cloud adoption and workload teams can innovate with confidence, knowing that compliance and governance requirements are detected, and often automated. The key to this agility is the infrastructure-as-code foundation of the cloud. All assets equate back to a defined block of code that can be tested and governed, like any other code base.

In a hybrid multicloud strategy, the advantages of cloud governance can now be expanded beyond the cloud. You can combine [Azure Arc](/azure/azure-arc/overview) with [Azure Policy](/azure/governance/policy/overview), [Azure Blueprints](/azure/governance/blueprints/overview), and other governance tools. The combination extends many governance guardrails to any cloud resource, whether in private or public cloud. [Unified operations](./unified-operations.md) is the best concept to extend your governance controls by using native Azure tools.

Unified operations aims to **provide consistency in governance and operations management across all deployments**. Organizations require consistency in the form of commonly implemented governance and operations management processes and controls across heterogeneous environments—and over the long-term must be able to scale to meet these common processes.

## Deploy consistent hybrid governance MVP

Use a unified operations strategy to **develop uniform resource consistency** across disparate environments, by implementing consistent tagging practices, organizing: resources, resource groups, subscriptions, and [management groups](https://docs.microsoft.com/azure/governance/management-groups/overview)—moving towards unified resource governance across hybrid and multicloud environments.

- Add a tag for `hosting platform` to all hybrid, multicloud, and edge assets.
- Tag resources from AWS, GCP, and so on.
- Query your resources to discover where each is hosted.

 With a unified operations strategy in mind, you can continue to expand the governance MVP, evolving governance baselines to extend the foundation of hybrid governance. Extended hybrid governance helps to manage risk, and adds protections across data services, operations management, security, and identity. Consistent hybrid governance can remediate future, tangible risk for assets across your digital estate.

To expand the discoverability of distributed assets across heterogeneous environments, begin to organize your resources, resource groups, subscriptions, and [management groups to extend ease of governance](/azure/governance/management-groups/overview). Implementing uniform resource consistency practices extends consistent governance practices for visibility in a unified operations strategy.

## Organize and manage distributed server assets

Implement expanded controls for inventory and resource consistency across complex hybrid environments that extends unified operations using Azure-Arc-enabled servers. **Use Resource Graph Explorer as a management engine** to [inventory and tag hybrid and multicloud resources](../../manage/hybrid/server/best-practices/arc-inventory-tagging.md), expand visibility across distributed assets, and reduce management complexity.  

After you establish your expanded inventory and tagging standards and bring on some of your assets, **begin governing those resources by using familiar Cost Management governance tools** like Azure Policy to assess compliance at-scale, and Azure Cost Management + Billing to analyze, manage, and optimize the costs of your workloads. Read more best practices for [managing Azure Arc-enabled servers with Azure Policy](../../manage/hybrid/server/best-practices/arc-policies-mma.md).

## Expand hybrid and multicloud governance foundation

With a unified operations scenario, you can extend cloud governance disciplines to deployments hosted outside of your on-premises Azure environments.

Continue to **expand your governance disciplines across your Security Baseline** in iterations toward [unified hybrid and multicloud identity and access](https://docs.microsoft.com/azure/cloud-adoption-framework/decision-guides/identity/). For consistent IAM across your on-premises and cloud environments for identities, groups, and roles sets, you can require directory synchronization for cloud-based workloads with Azure AD, extending consistent Azure AD services if you have complex AD infrastructure on-premises. [Learn more about implementing secure hybrid identity with Azure Active Directory](https://docs.microsoft.com/azure/active-directory/hybrid/whatis-hybrid-identity) to require authentication and authorization across complex, heterogeneous environments.

**Mature your hybrid and multicloud policies and processes** across your Security Baseline using best practices for:

- [Collecting and detecting security data across clouds with **Azure Security Center**](/azure/security-center/quickstart-onboard-machines)
- [Monitor networks and resource security health, and detect malicious activity across hybrid environments with **Azure Monitor**](https://docs.microsoft.com/en-us/azure/azure-monitor/vm/vminsights-enable-hybrid)
- [Investigating and responding to security threats with **Azure Sentinel**](/azure/sentinel/tutorial-investigate-cases)
- [Connecting AWS](/azure/security-center/quickstart-onboard-aws) and [GCP accounts](/azure/security-center/quickstart-onboard-gcp) to **Azure Defender**.

## Next steps

For more guidance for your cloud adoption journey, see the following article:

- [Manage hybrid and multicloud environments](./manage.md)
