---
title: Ready for defense cloud adoption
description: Recommendations for building a landing zone in a defense organization
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 12/6/2022
ms.topic: conceptual
ms.subservice: scenario
---
# Ready for defense cloud adoption

The ready methodology is the first step in the platform domain of cloud adoption.

:::image type="content" source="./images/platform.png" alt-text="Figure that shows a domain tracker. It shows mission, platform, and workload. Platform is highlighted to show we're in the platform domain of cloud adoption." border="false":::
*Figure 1: Domain tracker - platform domain*

The ready methodology focuses on building the cloud platform. We call this cloud platform a landing zone. Landing zones are home to core services, workloads, and application. They provide a foundation for security and resource management. They enable application migration, modernization, and innovation at enterprise-scale. The landing zone is where services, applications, and workloads are deployed. Here are key considerations for the landing zone build that the cloud broker should follow.

## Build a secure landing zone

Within the landing zone, the cloud broker builds the platform environments, and the mission owner manages the workload environments. These workload environments inherit the security controls of the platform. Landing zones are the foundation of workload security and must be secure. Defense organizations often have compliance standards for architecture that apply to landing zones. The cloud broker will be responsible for building a landing zone to meet these standards. For information on landing zones, see:

- [Introduction to landing zones](../../ready/landing-zone/index.md)

Here are a few general architecture recommendations for landing zone deployments:

**Place a firewall between cloud and defense network** - The architecture should use a firewall, intrusion detection system (IDS), and/or intrusion prevention system (IPS) to protect the defense network from attacks originating in the cloud. It should sit in the defense network and inspect and filter all traffic heading into the defense network from the cloud. This placement will provide a barrier between the two environments.

**Inspect all inbound traffic** - Route all inbound traffic through your security stack before sending to applications. The security stack should be in its own environment and should inspect and filter traffic before routing to cloud applications.

**Isolate security management tools** - Create a separate environment for your security management tools. At a minimum, the security management environment should include vulnerability scanning, host scanning, endpoint protection, and centralized logging.

**Designate an architecture owner** - Mission owners should designate a single member of their personnel to own landing zone security. This person should be responsible for coordinating with the cloud broker, managing identity and access, and restricting elevated privileges.

For more information, see:

- [Landing zone principles](../../ready/landing-zone/design-principles.md)
- [Landing zone design](../../ready/landing-zone/design-areas.md)
- [Landing zone security](../../ready/considerations/landing-zone-security.md)

## Define operations and management expectations

Mission owners and cloud brokers should define the expectations for operations and management during the landing zone build period. Workloads will depend heavily on the platform throughout their lifecycle. Changes in the platform identity, management, or connectivity configurations will affect the hosted workloads. It’s important to synchronize expectations and priorities during the platform build so that mission owners and cloud brokers have a common understanding of success. Having a solid working relationship before production environments go live will help mitigate risks.

We have the following recommendations for operations and management:

**Establish communication channels** - Mission owners should establish communication channels for the cloud broker to use. Communications should be frequent, consistent, and clear. Mission owners should also have availability for field communications for any urgent matters outside the regular meetings. Communication will minimize risk and technical drift from mission objectives. Expectations should be written down, explained, and accessible to the cloud brokers. Regular synchronizations between the cloud broker and mission owner will help ensure the cloud broker understands the security, performance, and financial requirements of mission owners and their workloads.

**Pick operational measurements** - Establish how operational measures will be reviewed. The mission owner and cloud broker should determine how feedback will be received and improvements made.

**Share core services** - The cloud broker in most instances should offer shared services for mission owners to use. Shared services include Azure Virtual Desktops for secure client computing and a shared DevOps toolset such as Azure DevOps. Cloud brokers can also share a common data platform with governance or a shared container platform. Sharing common services saves money and improves compliance.

**Discuss infrastructure automation** - A high-functioning cloud broker will build infrastructure as code (IaC) templates to build secure workload environments consistently and rapidly. These IaC templates can build hardened VMs, functions, storage and more. The broker could even build out the entire mission owner landing zone through code to ensure consistency and compliance.

**Establish change management process** - Change is necessary in the cloud. In fact, a major benefit of the cloud is the ability to accelerate change. Accelerating positive changes is the goal of digital transformation. It’s vital that mission owners and cloud brokers establish a change management process. Change management should account for standard, normal, and emergency change requests. Each request type should have its own process that is optimized and streamlined for consistency, speed, and security.

For more information, see:

- [Improve landing zone operations](../../ready/considerations/landing-zone-operations.md)
- [Landing zone governance](../../ready/considerations/landing-zone-governance.md)

## Next step

The ready methodology focuses on building a cloud platform. The govern methodology focuses on regulating the platform for security, cost, and management.

> [!div class="nextstepaction"]
> [Govern](govern.md)
