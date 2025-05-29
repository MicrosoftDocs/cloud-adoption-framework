---
title: Plan for application delivery
description: Examine key design considerations and recommendations surrounding the delivery of applications in a secure way.
author: Zimmergren
ms.author: pnp
ms.date: 11/08/2022
ms.topic: conceptual
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
  - Treat the Application Gateway as an application component and deploy it in a spoke virtual network not as a shared resource in the hub.
  - To interpret Web Application Firewall alerts, you generally need in-depth knowledge of the application to decide whether the messages that trigger those alerts are legitimate.
  - You might face role-based access control problems if you deploy Application Gateway in the hub when teams manage different applications but use the same instance of Application Gateway. Each team then has access to the entire Application Gateway configuration.
  - If you treat Application Gateway as a shared resource, you might exceed [Azure Application Gateway limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#application-gateway-limits).
  - Read more about this in [Zero-trust network for web applications](/azure/architecture/example-scenario/gateway/application-gateway-before-azure-firewall).

- For secure delivery of HTTP/S applications, use Application Gateway v2 and ensure that WAF protection and policies are enabled.

- Use a partner NVA if you can't use Application Gateway v2 for the security of HTTP/S applications.

- Deploy Azure Application Gateway v2 or partner NVAs used for inbound HTTP/S connections within the landing-zone virtual network and with the applications that they're securing.

- Use a DDoS standard protection plan for all public IP addresses in a landing zone.

- Use Azure Front Door with WAF policies to deliver and help protect global HTTP/S applications that span Azure regions.

- When you're using Front Door and Application Gateway to help protect HTTP/S applications, use WAF policies in Front Door. Lock down Application Gateway to receive traffic only from Front Door.

- Use Traffic Manager to deliver global applications that span protocols other than HTTP/S.
