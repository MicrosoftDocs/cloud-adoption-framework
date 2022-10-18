---
title: Secure {{Token-LongName}} in Azure
description: #Learn about the security principles for {{Token-Name}} in Azure.
author: {{Token-ContributorGithubId}}
ms.author: {{Token-Alias}}
ms.date: {{Token-Date}}
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# Secure {{Token-LongName}} in Azure

Best practice encourages customers to create a single centralized cloud adoption strategy, using the [Security methodology](/azure/cloud-adoption-framework/secure/) of the Cloud Adoption Framework.

## Security principles

The focus of {{Token-Name}} is based on key management principles:

| Principle | Description |
|--|--|
| **Single authoritative source of identity**| Use consistency and a single authoritative source to increase clarity, and reduce the risk from human error and configuration and automation complexity. |
| **Automated approach to data security**| Use automation to enable auditing, implement multiple control points, and reduce human errors. Automation also makes data governance easier and limits overhead.|
| **Grant least privilege required to complete task**| Grant only the amount of access to users that they need to do their jobs and limit the allowed actions for a particular scope.|
|  **Simplified yet secure permissions**| Avoid customization. Customization leads to complexity, which inhibits human understanding, security, automation, and governance. For example, use built-in roles to assign permissions to data services and avoid permissions that specifically reference individual resources or users.|
| **Better clarity and enforceability of rules and definitions**| Clearly separate data to help keep the environment organized, while making it easy to enforce security rules and definitions. |

## Next steps

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for {{Token-Name}}](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Govern {{Token-Name}}](./govern.md)
- [Organize team members for {{Token-Name}} in Azure](./organize.md)
- [Migrate {{Token-Name}}](./migrate.md)
- [Innovate with {{Token-Name}}](./innovate.md)
- [Manage {{Token-Name}}](./manage.md)
