---
title: Plan for application delivery
description: Examine key design considerations and recommendations surrounding the delivery of applications in a secure way.
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/08/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

<!-- docutune:casing "Azure VPN Gateway" L7 -->
<!-- cSpell:ignore autoregistration BGPs MACsec MPLS MSEE onprem privatelink VPNs -->

# Plan for app delivery

This section explores key recommendations to deliver internal-facing and external-facing apps in a secure, highly scalable, and highly available way.

**Design considerations:**

- Azure Load Balancer (internal and public) provides high availability for app delivery at a regional level.

- Azure Application Gateway allows the secure delivery of HTTP/S apps at a regional level.

- Front Door allows the secure delivery of highly available HTTP/S apps across Azure regions.

- Azure Traffic Manager allows the delivery of global apps.

**Design recommendations:**

- Perform app delivery within landing zones for both internal-facing and external-facing apps.

- For secure delivery of HTTP/S apps, use Application Gateway v2 and ensure that WAF protection and policies are enabled.

- Use a partner NVA if you can't use Application Gateway v2 for the security of HTTP/S apps.

- Deploy Azure Application Gateway v2 or partner NVAs used for inbound HTTP/S connections within the landing-zone virtual network and with the apps that they're securing.

- Use a DDoS standard protection plan for all public IP addresses in a landing zone.

- Use Azure Front Door with WAF policies to deliver and help protect global HTTP/S apps that span Azure regions.

- When you're using Front Door and Application Gateway to help protect HTTP/S apps, use WAF policies in Front Door. Lock down Application Gateway to receive traffic only from Front Door.

- Use Traffic Manager to deliver global apps that span protocols other than HTTP/S.
