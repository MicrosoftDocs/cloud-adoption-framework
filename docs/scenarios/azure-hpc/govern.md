---
title: Govern Azure HPC
description: As an IT professional, I want to find guidance in the Cloud Adoption Framework covering governance for using Azure High-performance computing (HPC) as part of my IT strategy.
author: Rajani-Janaki-Ram
ms.author: padmalathas
ms.date: 09/19/2022
ms.topic: conceptual
ms.custom: think-tank
---

# Govern Azure high-performance computing (HPC)

The [Cloud Adoption Framework provides a methodology](../../govern/index.md) to systematically and incrementally improve governance of your cloud portfolio. This article demonstrates how you can extend your governance approach to govern HPC.

## HPC policies

While HPC in Azure doesn't have any specific considerations or recommendations which would impact governance related decisions, it's important to understand any decisions previously made by the cloud platform team to be aware of existing governance recommendations [for corporate policies](../../govern/corporate-policy.md).

Define the corporate policy by identifying and mitigating business risks regardless of the cloud platform. Follow the three-step process of defining corporate policies by developing:
- [**Business risks:**](../../govern/policy-compliance/business-risk.md) to scope and uniquely define the minimum viable product (MVP) for your HPC environment.
- [**Policy and compliance:**](../../govern/policy-compliance/policy-definition.md) for establishing the previously defined business risks and how to remediate them where possible.
- [**Processes:**](../../govern/policy-compliance/processes.md) to establish compliance for your HPC cloud deployments, the criteria for policy violations, and associated remediation actions.

## HPC disciplines

For approaching disciplines for HPC in Azure, follow and understand any decisions previously made by the cloud architect team for existing [cloud governance disciplines.](../../govern/governance-disciplines.md) 

Ensure the five disciplines of cloud governance are implemented:
- [**Cost Management:**](../../govern/cost-management/index.md) Develop cost control policies when optimizing performance of your HPC environment.
- [**Security baseline:**](../../govern/security-baseline/index.md) Establish security baselines and enforce those requirements across network, data, and all HPC asset configurations.
- [**Identity baseline:**](../../govern/identity-baseline/index.md) Define authentication and authorization requirements across all HPC cloud adoption efforts.
- [**Resource Consistency:**](../../govern/resource-consistency/index.md) Configure your HPC resources to manage risks related to onboarding, drift, discoverability, and recovery.
- [**Deployment acceleration:**](../../govern/deployment-acceleration/index.md) Create policies surrounding your HPC configuration or deployment by either DevOps automation or manual activities.

## HPC governance references

For HPC governance examples, organizations in the manufacturing or automotive space often rely on additional compliance and regulation standards like [Trusted Information Security Assessment Exchange (TISAX).](/azure/compliance/offerings/offering-tisax) Following the TISAX standard ensures HPC cloud solutions with strong information security and data protection.

Banking organizations will also have data security considerations that include conducting security risk assessments before placing workloads in the cloud. Risk grid computing also follows both Microsoft Azure ExpressRoute and VPN Gateway as the thousands of ingested documents typically live in on-premises locations.


## Next steps

- After extending your governance approach for your HPC environment, outline your [management](./manage.md) path for implementing an operations baseline.
- Review and understand additional [governance recommendations](../../ready/landing-zone/design-area/governance.md) decisions made by your cloud platform team.
