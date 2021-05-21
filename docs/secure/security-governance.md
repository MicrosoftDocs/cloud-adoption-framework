---
title: Security governance, risk, and compliance
description: Learn about security governance, risk, and compliance. Includes topics like architecture and standards, and security posture management.
author: NaomiOooo
ms.author: brblanch
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Security governance

Security governance bridges your business priorities with technical implementation like architecture, standards, and policy. Governance teams provide oversight and monitoring to sustain and improve security posture over time. These teams also report compliance as required by regulating bodies.

:::image type="content" source="./media/governance-structure.png" alt-text="Security Governance" lightbox="./media/governance-structure-popout.png":::

**Business goals and risk** provide the best direction for security. This direction ensures that security focuses their efforts on important matters for the organization. It also informs risk owners using familiar language and processes in the risk management framework.

## Compliance and reporting

Compliance and reporting on external security requirements, and sometimes internal policy, are basic required elements of operating in a given industry. The mandatory requirements are like feeding a bear in the zoo. If you don't feed the bear every day, it might eat you.

## Architecture and standards

Architecture, standards, and policy provide the critical translation from business requirements and risk into the technical environment. We recommend having a unified view across your enterprise estate instead of splitting up cloud versus on-premises. Attackers don't care about your internal processes and follow the path of least resistance to their goal. That includes moving laterally between cloud and on-premises environments. Most enterprises today are a hybrid environment that spans:

- **On-premises:** Includes multiple generations of technology and often a significant amount of legacy software and hardware. This tech sometimes includes operational technology controlling physical systems with a potential life or safety impact.
- **Clouds:** Typically includes multiple providers for:
  - Software as a service (SaaS) applications
  - Infrastructure as a service (IaaS)
  - Platform as a service (PaaS)

## Security posture management

Hope and reporting problems isn't a plan. Governance in the cloud age must have an active component that continuously engages with other teams. Security posture management is an emerging function. It represents a step forward in the long-term convergence of security functions. These functions answer the question "how secure is the environment?", including vulnerability management and security compliance reporting.

In the on-premises world, security governance followed the cadence of data it could get about the environment. This way of getting data might take time and be constantly out of date. Cloud technology now provides on-demand visibility into the current security posture and asset coverage. This visibility drives a major transformation of governance into a more dynamic organization. This organization provides a closer relationship to other security teams to monitor security standards, provide guidance, and improve processes.

In its ideal state, governance is the heart of continuous improvement. This improvement engages across your organization to constantly improve security posture.

The key tenets of success for governance are:

- **Continuous discovery of assets and asset types:** A static inventory isn't possible in a dynamic cloud environment. Your organization must focus on the continuous discovery of assets and asset types. In the cloud, new types of services are added regularly. Workload owners dynamically spin up and down instances of applications and services as needed, making inventory management a dynamic discipline. Governance teams need to continuously discover asset types and instances to keep up with this pace of change.
- **Continuous improvement of asset security posture:** Governance teams should focus on improving standards, and enforcement of those standards, to keep up with the cloud and attackers. Information technology (IT) organizations must react quickly to new threats and adapt accordingly. Attackers are continuously evolving their techniques, and defenses are continuously improving and might need to be enabled. You can't always get all the security you need into the initial configuration.
- **Policy-driven governance:** This governance provides consistent execution by fixing something once in policy that's automatically applied at scale across resources. This process limits any wasted time and effort on repeated manual tasks. It's often implemented using Azure Policy or third-party policy automation frameworks.

To maintain agility, best practices guidance is often iterative. It digests small pieces of information from multiple sources to create the whole picture and continuously make small adjustments.

## Governance and protection disciplines

Protection disciplines include access control, asset protection, and innovation security. The security governance team provides standards and guidance to drive consistent execution of security best practices and controls.

In the ideal state, the protection teams apply these controls and provide feedback on what's working, like challenges in applying the controls. The teams then work together to identify the best solutions.

## Governance and security operations

Security governance and security operations work together to provide complete visibility. They ensure that lessons learned from real world incidents are integrated into architecture, standards, and policy.

Governance and security operations provide complementary types of visibility.

- **Security operations** provide insight into the immediate risk of active attacks.
- **Security governance** provides a broad or long view of risk from potential future attacks and attack vectors.

The security architects within the governance function help identify lessons learned from incidents. For example, the root cause of major incidents. They capture the lessons into your organization's standards to ensure consistent application across the enterprise.

For more information, see [Security integration](./security-integration.md).

> [!NOTE]
> Some organizations place monitoring of security posture in security operations. We recommend having this monitoring in governance. This placement creates a better relationship with the IT engineering and operations teams that apply the standards. This relationship often results in higher quality communications and better security outcomes. Otherwise, you have a governance team that never sees the real world impact of their standards.

## Next steps

The next discipline is [innovation security](./innovation-security.md).
