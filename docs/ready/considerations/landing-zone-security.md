---
title: Improve landing zone security
description: Improve landing zone security.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Improve landing zone security

When a workload or the landing zones that hosts it require access to any sensitive data or critical systems, it's important to protect the data and assets. Improving landing zone security builds on the [test-driven development approach to landing zones](./test-driven-development.md) by expanding or refactoring the landing zone to account for heightened security requirements.

## Landing zone security best practices

The following list of reference architectures and best practices provides examples of ways to improve landing zone security:

- [Azure Security Center](/azure/security-center/security-center-get-started?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json): Onboard a subscription to Security Center.
- [Azure Sentinel](/azure/sentinel/quickstart-onboard?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json): Onboard Azure Sentinel to provide a **security information event management (SIEM)** and **security orchestration automated response (SOAR)** solution.
- [Network boundary security](../../reference/networking-vdc.md): Several reference patterns for developing a network, similar to how the network boundary is secured in a datacenter.
- [Secure network architecture](/azure/architecture/reference-architectures/dmz/secure-vnet-dmz?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json): Reference architecture for implementing a perimeter network and secure network architecture.
- [Identity management and access control](/azure/security/fundamentals/identity-management-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json): Series of best practices for implementing identity and access to secure a landing zone in Azure.
- [Network security practices](/azure/security/fundamentals/network-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json): Provides additional best practices for securing the network.
- [Operational security](/azure/security/fundamentals/operational-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) provides best practices for increasing operational security in Azure.
- The [Security Baseline discipline](../../govern/guides/complex/security-baseline-improvement.md#incremental-improvement-of-best-practices): Example of developing a governance-driven security baseline to enforce security requirements.

## Test-driven development cycle

Before beginning any security improvements, it's important to understand the "definition of done" and all "acceptance criteria". For more information, see the articles on [test-driven development of landing zones](./test-driven-development.md) and [test-driven development in Azure](./azure-test-driven-development.md).

![Test-driven development process for cloud landing zones](../../_images/ready/test-driven-development-process.png)

## Next steps

Understand how to [improve landing zone operations](./landing-zone-operations.md) to support critical applications.

> [!div class="nextstepaction"]
> [Improve landing zone operations](./landing-zone-operations.md)
