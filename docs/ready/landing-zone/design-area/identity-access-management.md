---
title: Identity and access management
description: Design area guidance for identity and access management
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Design area: Identity and access management

Identity provides the basis of a large percentage of security assurance. It enables access based on identity authentication and authorization controls in cloud services to protect data and resources and to decide which requests should be permitted.

Identity and access management (IAM) is boundary security in the public cloud. It must be treated as the foundation of any secure and fully compliant public cloud architecture. Azure offers a comprehensive set of services, tools, and reference architectures to enable organizations to make highly secure, operationally efficient environments as outlined here.

This section examines design considerations and recommendations related to IAM in an Azure environment.

## Why we need identity and access management

The technological landscape in the enterprise is becoming complex and heterogenous. To manage compliance and security for this environment, IAM enables the right individuals to access the right resources at the right time for the right reasons.

### Plan for identity and access management

Organizations typically follow a least-privileged approach to operational access. This model should be expanded to consider Azure through Azure Active Directory (Azure AD), Azure role-based access control (Azure RBAC), and custom role definitions. It's critical to plan how to govern control- and data-plane access to resources in Azure. Any design for IAM and Azure RBAC must meet regulatory, security, and operational requirements before it can be accepted.

Identity and access management is a multistep process that involves careful planning for identity integration and other security considerations, such as blocking legacy authentication and planning for modern passwords. Staging planning also involves selection of business-to-business or business-to-consumer identity and access management. While these requirements vary, there are common design considerations and recommendations to consider for an enterprise landing zone.

![Diagram that shows identity and access management.](./media/iam.png)