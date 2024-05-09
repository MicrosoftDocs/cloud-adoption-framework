---
title: Function of cloud infrastructure and endpoint security
description: Understand the function of cloud infrastructure and endpoint security.
author: martinekuan
ms.author: martinek
ms.date: 05/07/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency3
---

# Function of cloud infrastructure and endpoint security

A cloud security team working on infrastructure and endpoint security provides security protections, detective, and response controls for infrastructure and network components used by enterprise applications and users.

## Modernization

Software-defined datacenters and other cloud technologies are helping solve longstanding challenges with infrastructure and endpoint security that include:

- **Inventory and configuration error discovery** are much more reliable for cloud hosted assets as they're all immediately visible (as opposed to a physical datacenter).

- **Vulnerability management** evolving into a critical part of overall security posture management.

-**Addition of container technologies** to be managed and secured by infrastructure and network teams as the organization adopts this technology broadly. See [Container security in Defender for Cloud](/azure/security-center/container-security) for an example.

- **Security agent consolidation** and tool simplification to reduce the maintenance and performance overhead of security agents and tools.

- **Allow-listing of applications** and internal network filtering is becoming easier to configure and deploy for cloud hosted servers (using machine learning generated rule sets). See [Adaptive application controls](/azure/security-center/security-center-adaptive-application) and [adaptive network hardening](/azure/security-center/security-center-adaptive-network-hardening) for Azure examples.

- **Automated templates**, for example [infrastructure as code (IaC)](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code) in Azure, for configuring infrastructure and security are easier with software-defined datacenters in the cloud.

- **Just in time (JIT) and just enough access (JEA)** to enable practical application of least privilege principles to privileged access for servers and endpoints.

- **User experience** becomes critical as users increasingly can choose or purchase their endpoint devices.

- **Unified endpoint management** lets you manage the security posture of all endpoint devices, including mobile and traditional PCs. Unified endpoint management also provides critical device integrity signals for Zero Trust access control solutions.

- **Network security architectures** and controls are partially diminished with the shift to cloud application architectures, but they remain a fundamental security measure. For more information, see [Network security and containment](/azure/architecture/framework/security/design-network-segmentation).

## Team composition and key relationships

Cloud infrastructure and endpoint security commonly interacts with the following roles:

- IT architecture and operations
- Security architecture
- Security operations center (SOC)
- Compliance team
- Audit team

## Next step

Review the function of [threat intelligence](./cloud-security-threat-intelligence.md).
