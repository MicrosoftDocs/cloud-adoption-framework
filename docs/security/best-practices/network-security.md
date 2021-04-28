---
title: Security Title
description: Security Description
author: GitHubAlias
ms.author: msftalias
ms.date: 04/04/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

Point to https://docs.microsoft.com/en-us/azure/security/fundamentals/network-best-practices?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json


# Generic space holder - remember to edit the metadata before publication

## This article should cover all of the items under the "secured the network" question at the CAF level

**Note: On the CAF side, this article should tackle securing the network at the enterprise level**

- There's a designated group within the organization, which is responsible for centralized network management andxrw security of this workload.Centralizing network management and security can reduce the potential for inconsistent strategies that create potential attacker exploitable security risks. Because all divisions of the IT and development organizations do not have the same level of network management and security knowledge and sophistication, organizations benefit from leveraging a centralized network team's expertise and tooling.
- There are controls in place to ensure that security extends past the network boundaries of the workload in order to effectively prevent, detect, and respond to threats.Traditional network controls based on a 'trusted intranet' approach will not be able to effectively provide security assurances for cloud applications.
- Enhanced network visibility is enabled by integrating network logs into a Security information and event management (SIEM) solution or similar technology.Integrating logs from the network devices, and even raw network traffic itself, will provide greater visibility into potential security threats flowing over the wire.
- Cloud virtual networks are designed for growth based on an intentional subnet security strategy.Most organizations end up adding more resources to networks than initially planned. When this happens, IP addressing and subnetting schemes need to be refactored to accommodate the extra resources. This is a labor-intensive process. There is limited security value in creating a very large number of small subnets and then trying to map network access controls (such as security groups) to each of them.
- This workload has a security containment strategy that blends existing on-premises security controls and practices with native security controls available in Azure, and uses a zero-trust approach.Assume breach is the recommended cybersecurity mindset and the ability to contain an attacker is vital to protect information systems.
- Legacy network security controls for data loss prevention were deprecated.Network-based data loss prevention (DLP) is decreasingly effective at identifying both inadvertent and deliberate data loss. The reason for this is that most modern protocols and attackers use network-level encryption for inbound and outbound communications. While the organization can use "SSL-bridging" to provide an "authorized man-in-the-middle" that terminates and then reestablishes encrypted network connections, this can also introduce privacy, security and reliability challenges.
- Traffic between subnets, Azure components and tiers of the workload is managed and protected.
