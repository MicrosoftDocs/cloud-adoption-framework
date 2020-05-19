---
title: FAQ
description: FAQ
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

## FAQ

This page will list frequently asked question for enterprise-scale design as well as Contoso implementation.

## Enterprise-scale design

### What does "landing zone" map to in Azure in the context of enterprise-scale

From enterprise-scale point of view, subscription is the "landing zone" in Azure.

## Contoso implementation

### Why do enterprise-scale ARM templates require permission at tenant root '/' scope

Management group creation is tenant level put API and hence it is prerequisite to grant permission at root scope to use example templates.

### Why do we need to sync fork with upstream repo

This allows you to control how frequently you want to take bug/patches. This is interim solution while we package pipeline codebase as GitHub action so this step will not be required in future.
