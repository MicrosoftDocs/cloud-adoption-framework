---
title: Secure cloud-scale analytics in Azure
description: Learn about the security principles for cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 10/01/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Secure cloud-scale analytics in Azure

To limit security risk as much as possible while also providing access to do data analytics, use data governance. Data governance provides balance among operations, maintenance, and control. It follows the underlying principle of data lake solution architecture design, which uses infrastructure as code and security as code.

## Security principles

The focus of cloud-scale analytics is based on key management principles:

| Principle | Description |
|--|--|
| **Single authoritative source of identity**| Use consistency and a single authoritative source to increase clarity, and reduce the risk from human error and configuration and automation complexity. |
| **Automated approach to data security**| Use automation to enable auditing, implement multiple control points, and reduce human errors. Automation also makes data governance easier and limits overhead.|
| **Grant least privilege required to complete task**| Grant only the amount of access to users that they need to do their jobs and limit the allowed actions for a particular scope.|
|  **Simplified yet secure permissions**| Avoid customization. Customization leads to complexity, which inhibits human understanding, security, automation, and governance. For example, use built-in roles to assign permissions to data services and avoid permissions that specifically reference individual resources or users.|
| **Better clarity and enforceability of rules and definitions**| Clearly separate data to help keep the environment organized, while making it easy to enforce security rules and definitions. |

> [!TIP]
> When deploying cloud-scale analytics, use automation principles to enable security instead of applying them manually. Ideally, you should only manually interact to approve or deny access requests.

## Next steps

> [!div class="nextstepaction"]
> [Authentication for cloud-scale analytics in Azure](./secure-authentication.md)
