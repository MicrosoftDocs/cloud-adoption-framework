---
title: Infrastructure security overview
description: Understand how application development security relies on infrastructure security.
author: mpvenables
ms.author: mas
ms.date: 06/15/2022
ms.topic: conceptual
ms.subservice: secure
ms.custom: internal
---

# Infrastructure security overview

[Infrastructure](infrastructure-security-strategy.md) and [development](development-security-strategy-overview.md) are broad technical areas. Each has numerous distinct conceptual layers and components that integrate together. The provided best practices also take into account the complex relationship between infrastructure and development.

## Application development and infrastructure security

Application development security relies on infrastructure security. If an application's underlying infrastructure (such as virtual machines) is compromised, attackers who gain control of the infrastructure can almost always gain control of the application and its data as well. Applications and build processes that host CI/CD, and so on. are often hosted on infrastructure operated by an organization (or a SaaS application managed through infrastructure admin personnel and accounts).

As with all technology disciplines, take a "continuous improvement" approach. Start out with quick wins and continue with incremental progress toward a "north star"—a specified end state across your security strategy, architecture, implementation, and operations.

## Next steps

> [!div class="nextstepaction"]
> [Infrastructure security strategy](infrastructure-security-strategy.md)

> [!div class="nextstepaction"]
> [Infrastructure security architecture](infrastructure-security-architecture.md)

> [!div class="nextstepaction"]
> [Infrastructure security implementation](infrastructure-security-implementation.md)
