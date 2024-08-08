---
title: Security modernization
description: Learn about security governenance.
author: claytonsiemens77
ms.author: csiemens
ms.date: 06/24/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Security modernization

## Introduction

Your security posture is defined by your security strategy and how that strategy is implemented and governed. Developing a security strategy requires collaboration between technology and business leaders to ensure that the strategy can meet business requirements and all parties understand any tradeoffs that must be made in the process. Implementing the security strategy relies on the expertise of all [teams and roles](./refresh-teams-and-roles.md) in the security organization and must be carefully planned and executed to ensure strict alignment with the strategy. Governance of the strategy is the day-to-day operations activities and continuous improvement activities that maintain and enforce the implementation. 

To be successful in the cloud, it is critical that you adopt a modern approach to security that is built on a strategy optimized for the complexity of cloud computing and governed with specialized tooling and methodologies. 

## Strategy

Moving your organization into the cloud adds significant complexity to security, and to be successful in the cloud, your security strategy needs to meet modern challenges inherent to cloud computing. In the adoption and operation of a cloud estate, security becomes a necessary consideration in all facets, rather than a separate function that is secondarily involved in certain facets, which can be a common approach for organizations running on-premises technology platforms. Strategy modernization not only involves the adoption of new technologies and new operational practices, it also normally involves a mindset shift across the organization. New [teams and roles](./refresh-teams-and-roles.md) may need to be filled and existing teams and roles may need to be involved in security in ways that they're unaccustomed to. These changes, which can sometimes be monumental for organizations, can be the source of stress and internal conflicts, so it is important to promote healthy, honest, and blame-free communications across the organization throughout the adoption process.

Refer to the [Define a security strategy](../strategy/define-security-strategy.md) guide for a comprehensive overview of these considerations.

For Microsoft's recommendations for modernizing your cloud posture, refer to the [Zero Trust guidance](/security/zero-trust/adopt/rapidly-modernize-security-posture)

### Adopting Zero Trust

Adopting [Zero Trust](/security/zero-trust/zero-trust-overview) as a strategy will help start your cloud journey off with a modern approach to security in place. The Zero Trust approach is founded on three principles:

- **Verify explicitly:** Always authenticate and authorize based on all available data points.

- **Use least privilege:** Limit user access with Just-In-Time and Just-Enough-Access (JIT/JEA), risk-based adaptive policies, and data protection.

- **Assume breach:** Minimize blast radius and segment access. Verify end-to-end encryption and use analytics to get visibility, drive threat detection, and improve defenses.

By applying these principles across the cloud adoption process, the transformation to modern security can be a smoother experience for the entire organization.

### Summary

Modernizing your security strategy can be an undertaking as large and complex as any your organization might take on, but getting it right is critical to the success of your cloud adoption journey. Redefining your security practices and incorporating the principles of the Zero Trust approach can help ease the transformations that your organization must accomplish, giving you the tools you need to implement a well-designed cloud strategy.

## Plan

Building a security modernization plan focuses primarily on the adoption of new technologies and new operational practices, but business alignment is an equally important aspect as well.

### Pillars

- **Identity** https://learn.microsoft.com/en-us/security/zero-trust/deploy/identity
- **Endpoints** https://learn.microsoft.com/en-us/security/zero-trust/deploy/endpoints
- **Data** https://learn.microsoft.com/en-us/security/zero-trust/deploy/data
- **Apps** https://learn.microsoft.com/en-us/security/zero-trust/deploy/applications
- **Infra** https://learn.microsoft.com/en-us/security/zero-trust/deploy/infrastructure
- **Network** https://learn.microsoft.com/en-us/security/zero-trust/deploy/networks
- **Visibility, automation, and orchestration** https://learn.microsoft.com/en-us/security/zero-trust/deploy/visibility-automation-orchestration

## Business alignment

Condense https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/secure/security-integration

## Enforcement

- **Policies**
- **Training**

## Risk management

Condense https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/secure/risk-insights

## Automation

### Tooling

- **Policy**
- **SIEM**
- **CSPM** https://www.microsoft.com/en-us/security/business/security-101/what-is-cspm
- **Investigation and remediation (AIR)** https://learn.microsoft.com/en-us/microsoft-365/security/mtp/mtp-autoir
- 

### Testing

https://learn.microsoft.com/en-us/azure/well-architected/security/test

## DevSecOps

https://learn.microsoft.com/en-us/devops/operate/security-in-devops

### Secure dev platform 

https://learn.microsoft.com/en-us/security/zero-trust/develop/secure-devops-platform-environment-zero-trust

### Secure dev environments

https://learn.microsoft.com/en-us/security/zero-trust/develop/secure-dev-environment-zero-trust

### Secure dev practices (SDL)

https://learn.microsoft.com/en-us/security/zero-trust/develop/embed-zero-trust-dev-workflow

https://learn.microsoft.com/en-us/azure/well-architected/operational-excellence/safe-deployments

## References

https://learn.microsoft.com/en-us/security/

https://learn.microsoft.com/en-us/security/zero-trust

## Azure facilitation

- **Defender for Cloud** https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-cloud-introduction
- **Sentinel** https://l**earn.microsoft.com/en-us/azure/sentinel/overview
- **Defender XDR (AIR, Identity, DLP, App governance)** https://learn.microsoft.com/en-us/defender-xdr/microsoft-365-defender
