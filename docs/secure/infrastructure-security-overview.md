---
title: Infrastructure
description: It’s critical to understand that application development security relies on infrastructure security. 
author: mpvenables
ms.author: mas
ms.date: 03/06/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Infrastructure

## Overview

[Infrastructure](infrastructure-security-strategy.md) and [development](development-security-strategy-overview.md) are each broad technical areas with multiple and distinct conceptual layers and components that integrate together. Infrastructure and development also have a complex interrelationship, which is noted throughout these best practices. 

It’s critical to understand that application development security relies on infrastructure security. If the underlying infrastructure of an application (e.g. virtual machines) is compromised, the attackers almost always gain control of the application and its data as well. Applications and build process hosting CI/CD, etc. are often hosted on infrastructure operated by the organization (or a SaaS application managed using infrastructure admin personnel and accounts).

As with all technology disciplines today, we recommend a "continuous improvement" approach that starts with quick wins, and continues with incremental progress towards a "north star"—a specified end state across security strategy, architecture, implementation, and operations.

## Next steps:

- [Strategy](infrastructure-security-strategy.md)
- [Architecture](infrastructure-security-architecture.md)
- [Implementation](infrastructure-security-implementation.md)