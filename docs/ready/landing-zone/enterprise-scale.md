---
title: Deploy a CAF enterprise-scale landing zone in Azure
description: Learn how to deploy a migration landing zone in Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/27/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Deploy a CAF enterprise-scale landing zone in Azure

An enterprise-scale landing zone is an environment that's been provisioned with all of the supporting resources required to host more complex workloads. Starting with an enterprise-scale landing zone allows you to host mission-critical and secure workloads in alignment with security, governance, compliance, and operational requirements from the first deployment.

## Approach

The _start small_ approach outlined in the Ready methodology starts with a single landing zone and integrates richer enterprise features as the cloud adoption plan moves towards enterprise-scale. That approach creates a structured hands-on learning path aligned with the needs of each release or migration wave. With that approach, the landing zones might support production workloads, but they aren't truly enterprise-ready for the first several releases.

When customers need to get to enterprise readiness faster, a more complex architecture is required. A single landing zone can not deliver at enterprise scale in isolation. An enterprise-scale architecture requires an enterprise-ready environment, which hosts enterprise-ready landing zones. Both approaches follow the same principles and best practices. But the enterprise-scale approach applies multiple best practices via a single JSON file that uses a GitHub action and deployment pipeline to deploy all aspects of the environment including multiple landing zones. This highly opinionated implementation uses the same ARM template, Azure Policy, and RBAC tools used in the smaller blueprint approaches.

Once deployed both approaches follow infrastructure-as-code and test-driven-development models to expand the landing zones to fit your future landing zone needs.

## Deploy the first landing zone

Before you use the enterprise-scale approach and implementation, review the following assumptions, decisions, and implementation guidance. If this guidance aligns with your cloud adoption plan, the enterprise-scale environment and landing zone can be deployed using the [enterprise-scale implementation](../enterprise-scale/implementation.md).

> [!div class="nextstepaction"]
> [Implement the enterprise-scale landing zone solution](../enterprise-scale/implementation.md)

## Assumptions

This approach and architecture includes the following assumptions. If these assumptions align with your needs and constraints, you can use the implementation to configure your environment and deploy your first landing zone. Once deployed, the implementation can be customized by expanding the landing zones and environment to meet your future landing zone needs.

- **Subscription limits:** This architecture is not constrained by [subscription limits](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits) unlike the other landing zone options.
- **Compliance:** No third-party compliance requirements not deployed by this implementation but can be easily added.
- **Architectural complexity:** Unlike the other options, there are no limitations to the architectural complexity of the workloads that can be hosted by this landing zone and environment.
- **Shared services:** Shared services are configured in alignment with Microsoft best practices.
- **Limited production scope:** This landing zones default configuration is more likely to meet your mission critical and sensitive data hosting needs.
- **Advanced skills required:** Technical skill requirements are significantly higher for teams implementing this approach. Learn more about the technical skills requirements on the [enterprise-scale landing-zone overview](../enterprise-scale/index.md).

If these assumptions align with your current adoption needs, then this implementation might be a good starting point for building your landing zones and environments.

## Decisions

For a full set of decisions that shape the enterprise-scale implementation, see the [implementation guidelines](../enterprise-scale/implementation-guidelines.md).

## Customize or deploy a landing zone

For an example of deploying the enterprise-scale implementation, see the [Contoso enterprise-scale implementation guide](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md).

To customize the enterprise-scale architecture, see the [design guidelines](../enterprise-scale/design-guidelines.md).

## Next steps

After deploying your first landing zone, you're ready to [expand your landing zone](../considerations/index.md)

> [!div class="nextstepaction"]
> [Expand your landing zone](../considerations/index.md)
