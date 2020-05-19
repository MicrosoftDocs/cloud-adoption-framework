---
title: faq
description: FAQ
author: tbd
ms.author: tbd
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

## FAQ

This page will list frequently asked question for North Star design as well as Contoso Implementation.

## North Star Design

### What does "Landing Zone" map to in Azure in the context of North Star?

From North Star point of view, Subscription is the "Landing Zone" in Azure.


## Contoso Implementation

### Why do North Star ARM templates require permission at tenant root '/' scope?

Management Group creation is tenant level PUT API and hence it is pre-requisite to grant permission at root scope to use example templates.

### Why do we need to sync fork with upstream repo?

This allows you to control how frequently you want to take bug/patches. This is interim solution while we package pipeline codebase as GitHub action so this step will not be required in future.
