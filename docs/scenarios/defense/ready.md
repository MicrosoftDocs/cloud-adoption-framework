---
title: Ready for defense
description: Recommendations for building a landing zone in a defense organization
author: stephen-sumner
ms.author: wayne.meyer, michael.mcKanna
ms.reviewer: ssumner
ms.date: 10/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
---
# Ready for defense cloud adoption

The ready methodology is the first step in the platform domain of cloud adoption.

:::image type="content" source="./images/platform.png" alt-text="Figure that shows a domain tracker. It shows mission, platform, and workload. Platform is highlighted to show we're in the platform domain of cloud adoption." border="false":::
*Figure 1: Domain tracker - platform domain*

The ready methodology focuses on building landing zones. Landing zones enable application migration, modernization, and innovation at enterprise-scale. They provide a home for cloud workloads and form the foundation of the resource management system.

A secure architecture is key for your cloud security posture. Architecture refers to the components of an environment and the traffic flows between them. Defense organizations often have compliance standards for architecture that apply to landing zones. The cloud broker will be responsible for building a landing zone to meet these standards.

Microsoft developed mission landing zone called the Secure Azure Cloud Architecture (SACA). It aligns with the U.S. Secure Cloud Computing Architecture (SCCA) standard and can be deployed with the click-of-a-button implementation options with a few configuration selections.

For information on the mission landing zone, see:

- [Introduction to landing zones](/azure/cloud-adoption-framework/ready/landing-zone/)
- [Secure Cloud Computing Architecture (SACA) overview](/azure/azure-government/compliance/secure-azure-computing-architecture)
- [Deployable mission landing zone template](https://github.com/Azure/missionlz)

Here are a few general architecture recommendations for landing zone deployments:

## Place a firewall between cloud and defense network

The architecture should use a firewall/IDS/IPS to protect the defense network from attacks originating in the cloud. It should sit in the defense network and inspect and filter all traffic heading into the defense network from the cloud. It will provide a barrier between the two environments.

## Inspect all inbound traffic

Route all inbound traffic through your security stack before sending to applications. The security stack  should be in its own environment. It should inspect and filter traffic before routing to cloud applications.

## Isolate security management tools

Create a separate environment for your security management tools. At a minimum, the security management environment should include vulnerability scanning, host scanning, endpoint protection, and centralized logging.

## Designate an architecture owner

Mission owners should designate a single member of their personnel to own landing zone security. This person should be responsible for coordinating with the cloud broker, managing identity and access, and restricting elevated privileges.

## Next steps

The ready methodology is about building a platform. The govern methodology provides insights on governing the platform.

> [!div class="nextstepaction"]
> [](govern.md)
