---
title: Secure data management and analytics in Azure
description: Describe the principles of secure data management and analytics in Azure
author: mboswell
ms.author: mboswell
ms.date: 07/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Secure data management and analytics in Azure

To limit security risk as much as possible while also providing access to do data analytics, use data governance. Data governance provides balance among operations, maintenance, and control. It follows the underlying principle of data lake solution architecture design, which uses Infrastructure as Code and Security as Code.

A focus of the Enterprise Scale Analytics and AI construction set is based on items listed in the following table of key management principles:

| Principle  |Description|
|--|--|
| **Single authoritative source of identity**| Consistency and single authoritative source increases clarity and reduces risk from human errors, and configuration and automation complexity. |
| **Automated approach to data security**| Automation enables auditability, the implementation of multiple control points, and reduces human errors. Automation also makes data governance easier and limits overhead.|
| **Only least privilege required to complete task**| Grant only the amount of access to users that they need to do their jobs and allow only certain actions at a particular scope.|
|  **Simplified yet secure permissions**| Customization leads to complexity that inhibits human understanding, security, automation, and governance. For example, use built-in roles to assign permissions to data services and avoid permissions that specifically reference individual resources or users.|
| **Better clarity and enforceability of rules and definitions**| Clear separation of data helps keep the environment organized while making it easy to enforce security rules and definitions. |

When you deploy Enterprise Scale Analytics and AI, consider using these automation principles to enable security, as opposed to manually applying them. Ideally, a user should do manual interaction only to approve or deny an access request.

## Next steps

- [Authentication](secure-authentication.md)
- [Authorization](secure-analytics-role-based-access-control.md)
