---
title: Schema
description: Schema
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/20
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

## CAF enterprise-scale template schema

This article will help you to familiarize with CAF enterprise-scale template deployments, which consist on one and only one ARM template (one template to rule them all), and then, just providing the details of the resource(s) you want to deploy by using parameters files.

## Target audience

The target audience for this guide is people with a typical DevOps / sre background and assumes knowledge in Azure Resource Manager (ARM) /infrastructure as code (iac), Git, and PowerShell.

## Contents

This article is divided in two sections:

- The first part will describe the [generic enterprise-scale ARM template](./NorthStar-template-schema.md), so that you don't have to write your own ARM templates anymore (unless you decide to do so).
- The second part of this article will explain how to deploy ARM resources by simply updating a [enterprise-scale ARM parameters file](./NorthStar-parameters-schema.md).
