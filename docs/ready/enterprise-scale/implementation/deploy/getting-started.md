---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

## Getting Started

This article describes how to get started with enterprise-scale reference implementation by walking you through all the prerequistes to deploy a platform-native reference implementation of enterprise-scale.
> Note:  Before you start, make sure that you have read and understood the overall design objective and scope of the reference implementation.

## Target audience

The target audience for this guide is people with a typical DevOps / SRE background and assumes knowledge in Azure Resource Manager (ARM) /Infrastructure as Code (IaC), Git, and PowerShell.

## Contents

This article is divided in two sections:

- The first part will cover the [prerequisites](./Prerequisites.md) needed to use the enterprise-scale reference implementation and it will also describe how to [sync your fork with upstream repo](./Prerequisites.md/#Sync-your-fork-with-upstream-repo), to ensure your GitHub fork is kept updated with changes being released in the upstream enterprise-scale GitHub [repo](https://github.com/Azure/CET-NorthStar).
- The second part of this article will describe how to test and [validate prerequisites](./Validate-prereqs.md) by deploying ARM templates at the tenant root scope. Please note that this step is optional.
