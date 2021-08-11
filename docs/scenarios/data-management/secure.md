---
title: Secure data management and analytics for Azure
description: Learn about the principles of secure data management and analytics for Azure.
author: mboswell
ms.author: mboswell
ms.date: 07/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Secure data management and analytics

To limit security risk as much as possible while also providing access to do data analytics, use data governance. Data governance provides balance among operations, maintenance, and control. It follows the underlying principle of data lake solution architecture design, which uses infrastructure as code and security as code.

## Security principles

The focus of the data management and analytics scenario is based on key management principles:

| Principle  |Description|
|--|--|
| **Single authoritative source of identity**| Use consistency and a single authoritative source to increase clarity, and reduce the risk from human error and configuration and automation complexity. |
| **Automated approach to data security**| Use automation to enable auditability, implement multiple control points, and reduce human errors. Automation also makes data governance easier and limits overhead.|
| **Grant least privilege required to complete task**| Grant only the amount of access to users that they need to do their jobs and limit the allowed actions for a particular scope.|
|  **Simplified yet secure permissions**| Avoid customization. Customization leads to complexity, which inhibits human understanding, security, automation, and governance. For example, use built-in roles to assign permissions to data services and avoid permissions that specifically reference individual resources or users.|
| **Better clarity and enforceability of rules and definitions**| Clearly separate data to help keep the environment organized, while making it easy to enforce security rules and definitions. |

> [!TIP]
> When you deploy enterprise-scale for analytics and AI, consider using these automation principles to enable security, as opposed to manually applying them. Ideally, a user should do manual interaction only to approve or deny an access request. For more information, see [Deployment templates for enterprise-scale for analytics and AI deployment](./eslz-deployment-templates.md).

## Next steps

- [Authentication](./secure-authentication.md)
- [Authorization](./secure-analytics-role-based-access-control.md)
