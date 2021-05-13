---
title: Governing a Windows Virtual Desktop environment
description: Explore governance best practice for Windows Virtual Desktop
author: DominicAllen
ms.author: doalle
ms.date: 4/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Governing a Windows Virtual Desktop environment

The [Cloud Adoption Framework provides a methodology](../../govern/index.md) to systematically and incrementally improve governance of your cloud portfolio. This article demonstrates how you can extend your governance approach to Windows Virtual Desktop environments deployed to Azure.

## Initial governance foundation

Governance starts with an [initial governance foundation often referred to as a governance MVP](../../govern/initial-foundation.md). This foundation deploys the basic Azure products required to deliver governance across your cloud environment.

The initial governance foundation focuses on the following aspects of governance:

- Basic hybrid network and connectivity.
- Azure Role-based access control (RBAC) for identity and access control.
- Naming and tagging standards for consistent identification of resources.
- Organization of resources using resource groups, subscriptions, and management groups.
- Azure Policy and Azure Blueprints to enforce governance policies.

## Expanding on governance disciplines

For Windows Virtual Desktop, the baseline needs to expand to include controls for functions specific to virtual desktops:

- User device used to access the virtual desktop
- Application security
- Session host OS
- Deployment configuration

## Security baseline

The following guides provide best practices for implementing security controls for Windows Virtual Desktop environments:

- [Windows Virtual Desktop Security Baseline](/security/benchmark/azure/baselines/windows-virtual-desktop-security-baseline).

- [Windows Virtual Desktop Security Guide](/virtual-desktop/security-guide).
