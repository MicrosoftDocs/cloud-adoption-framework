---
title: Getting started
description: Getting started
author: tbd
ms.author: tbd
ms.date: 06/01/2020
ms.topic: deploy
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Navigation menu

* [Overview](../../README.md)
* [CAF enterprise-scale architecture](../CAF enterprise-scale-Architecture.md)
  * [Design principles](../Design-Principles.md)
  * [Design guidelines](../Design-Guidelines.md)
    * [A - Enterprise enrollment and Microsoft Azure Active Directory tenants](../A-Enterprise-Enrollment-and-Azure-AD-Tenants.md)
    * [B - Identity and access management](../B-Identity-and-Access-Management.md)
    * [C - Management group and subscription organization](../C-Management-Group-and-Subscription-Organization.md)
    * [D - Network topology and connectivity](../D-Network-Topology-and-Connectivity.md)
    * [E - Management and monitoring](../E-Management-and-Monitoring.md)
    * [F - Business continuity and disaster recovery](../F-Business-Continuity-and-Disaster-Recovery.md)
    * [G - Security, governance, and compliance](../G-Security-Governance-and-Compliance.md)
    * [H - Platform automation and DevOps](../H-Platform-Automation-and-DevOps.md)
  * [Implementation guide](../Implementation-Guide.md)
* [Contoso reference](../Contoso/Readme.md)
  * [Scope and design](../Contoso/Scope.md)
  * [Implementation](../Contoso/Design.md)
* [Using reference implementation in your own environment](./Readme.md)
  * [Getting started](./Getting-Started.md)
    * [Prerequisites](./Prerequisites.md)
    * [Validate prerequisites](./Validate-prereqs.md)
  * [Configure your own environment](./Using-Reference-Implementation.md)
    * [Configure GitHub](./Configure-run-initialization.md)
    * [Provision Platform](./Deploy-platform-infra.md)
    * [Create Landing Zones](./Deploy-lz.md)
    * [Trigger deployments locally](./Trigger-local-deployment.md)
  * [CAF enterprise-scale template schema](./northstar-schema.md)
    * [Generic CAF enterprise-scale Microsoft Azure Resource Manager template](./northstar-template-schema.md)
    * [CAF enterprise-scale Azure Resource Manager parameters file](./northstar-parameters-schema.md)
  * [Known issues](./Known-Issues.md)
* [How do I contribute?](../CAF enterprise-scale-Contribution.md)
* [FAQ](../northstar-FAQ.md)
* [Road map](../northstar-roadmap.md)


---

## Getting started

This article describes how to get started with CAF enterprise-scale reference implementation by walking you through all the prerequisites to deploy a platform-native reference implementation of CAF enterprise-scale.
> Note:  Before you start, make sure that you have read and understood the overall design objective and scope of the reference implementation.

## Target audience
The target audience for this guide is people with a typical DevOps / SRE background and assumes knowledge in Azure Resource Manager (ARM)/Infrastructure as Code (IaC), Git, and PowerShell.

## Contents
This article is divided in two sections:
 - The first part will cover the [prerequisites](./Prerequisites.md) needed to use the CAF enterprise-scale reference implementation and it will also describe how to [sync your fork with upstream repo](./Prerequisites.md/#Sync-your-fork-with-upstream-repo), to ensure your GitHub fork is kept updated with changes being released in the upstream CAF enterprise-scale GitHub [repo](https://github.com/Azure/CET-NorthStar).
 - The second part of this article will describe how to test and [validate prerequisites](./Validate-prereqs.md) by deploying ARM templates at the tenant root scope. Please note that this step is optional.

