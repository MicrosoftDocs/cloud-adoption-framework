---
title: Secure generative AI in Azure
description: Learn how to secure generative AI by following the secure considerations from the Cloud Adoption Framework.
ms.author: tozimmergren
author: Zimmergren
ms.date: 05/30/2024
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Secure generative AI in Azure

## Checklist

## Shared responsibility

Much like the traditional [shared responsibility model in the cloud](/azure/security/fundamentals/shared-responsibility), AI in Azure also follows an [AI shared responsibility model](/azure/security/fundamentals/shared-responsibility-ai). This model defines the responsibilities of Microsoft and the customer in securing the AI services and data.

![A diagram showing the shared responsibility model for AI in Azure.](./media/ai-shared-responsibility.svg)

## Principles

- Confidentiality
- Integrity
- Availability
- Sustainment

## Approaches

- Security automation for and with AI (Defender, Sentinel, Policy, ...)
- Security monitoring for AI -> What should be captured in SIEM systems to allow for monitoring of AI systems?
- Auditing and logging for AI -> What should be logged and audited in AI systems?
- Security training -> Link back to Skills readiness
- Zero Trust and AI?
- Security posture for AI?

## Preparedness

- Communication plan around AI
- Empower teams to enforce stricter controls for AI
- AI incident response plan
- Protect and recover: Backup plans.

## Next steps

> [!div class="nextstepaction"]
> [Governing generative AI in Azure](./govern.md)
