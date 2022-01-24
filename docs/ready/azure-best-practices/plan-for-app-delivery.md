---
title: Plan for application delivery
description: Examine key design considerations and recommendations surrounding the delivery of applications in a secure way.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Plan for application delivery

This section explores key recommendations to deliver internal-facing and external-facing applications in a secure, highly scalable, and highly available way.

**Design considerations:**

- Azure Load Balancer (internal and public) provides high availability for application delivery at a regional level.

- Azure Application Gateway allows the secure delivery of HTTP/S applications at a regional level.

- Azure Front Door allows the secure delivery of highly available HTTP/S applications across Azure regions.

- Azure Traffic Manager allows the delivery of global applications.

**Design recommendations:**

- Perform application delivery within landing zones for both internal-facing and external-facing applications.

- For secure delivery of HTTP/S applications, use Application Gateway v2 and ensure that WAF protection and policies are enabled.

- Use a partner NVA if you can't use Application Gateway v2 for the security of HTTP/S applications.

- Deploy Azure Application Gateway v2 or partner NVAs used for inbound HTTP/S connections within the landing-zone virtual network and with the applications that they're securing.

- Use a DDoS standard protection plan for all public IP addresses in a landing zone.

- Use Azure Front Door with WAF policies to deliver and help protect global HTTP/S applications that span Azure regions.

- When you're using Front Door and Application Gateway to help protect HTTP/S applications, use WAF policies in Front Door. Lock down Application Gateway to receive traffic only from Front Door.

- Use Traffic Manager to deliver global applications that span protocols other than HTTP/S.

- Summarized ingress traffic patterns in Azure Landing Zones Plan for app delivery.
  ![appdelivery-ingress-pattern-v1](https://user-images.githubusercontent.com/38658285/150786316-9914527b-d2f8-420e-8b1e-a9dbb1150bae.png)

