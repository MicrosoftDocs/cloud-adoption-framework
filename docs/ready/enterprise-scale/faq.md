---
title: FAQ
description: FAQ
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# FAQ

This page shows frequently asked questions for enterprise-scale design and Contoso implementation.

## Enterprise-scale design

### Where a landing zone maps in Azure in the context of enterprise-scale

From enterprise-scale point of view, a subscription is the landing zone in Azure.

## Contoso implementation

### Why enterprise-scale Azure Resource Manager templates require permissions at the tenant root '/' scope

Management group creation is a tenant-level `put` application programming interface. The prerequisite for using example templates is to grant permission at the root scope.

### Why sync a fork with the upstream repo

This allows you to control how frequently you want to take bug/patches. This is an interim solution while we package pipeline codebase as GitHub Actions, so this step won't be required in future.
