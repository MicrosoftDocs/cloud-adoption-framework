---
title: "Secure 'data management and analytics' in Azure"
description: Manage 'data management and analytics' in Azure
author: mboswell
ms.author: mboswell
ms.date: 06/25/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Secure 'data management and analytics'

Data governance is often in between rigid security to restrict risk as much as possible and providing access to perform needed data analytics while maintaining balance among operations, maintenance, and control. Together with the underlying principle of our data lake solution architecture design which is Infrastructure-As-Code and Security-As-Code.

A focus of the Enterprise Scale Analytics and AI construction set is based on items listed in Table 1.

| Principle  |Description|
|--|--|
| **Single authoritative source of identity**| Consistency and single authoritative source increases clarity and reduces risk from human errors, and configuration and automation complexity. |
| **Automated approach to data security**| Automation enables auditability and the implementation of multiple control points as well as reducing human errors. Automation makes data governance easier and brings overhead under control.|
| **Only least privilege required to complete task**| Granting only the amount of access to users that they need to perform their jobs and only allow certain actions at a particular scope.| |
|  **Simplified but yet secure permissions**| Customization leads to complexity that inhibits human understanding, security, automation and governance; for example, use build-in roles for assigning permissions to data services and avoid permissions specifically referencing individual resources or users.|
| **Better clarity and enforceability of rules and definitions**| Clear segregation of data helps keep the environment organized while making it easy to enforce security rules and definitions. |

Table 1: Key Management Principle

When deploying the Enterprise Scale Analytics and AI you should consider these principles around automation to enable security as opposed relying upon manually applying them via human interaction. The most interaction the person should have is to approve or deny an access request.
