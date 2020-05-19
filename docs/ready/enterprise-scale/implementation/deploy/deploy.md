---
title: Deploy
description: Deploy
author: tbd
ms.author: tbd
ms.date: 06/01/2020
ms.topic: conceptual
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
  * [CAF enterprise-scale template schema](./NorthStar-schema.md)
    * [Generic CAF enterprise-scale Microsoft Azure Resource Manager template](./NorthStar-template-schema.md)
    * [CAF enterprise-scale Azure Resource Manager parameters file](./NorthStar-parameters-schema.md)
  * [Known issues](./Known-Issues.md)
* [How do I contribute?](../Northstar-Contribution.md)
* [FAQ](../Northstar-FAQ.md)
* [Road map](../Northstar-roadmap.md)

---

# Contents

This article describes how to deploy landing zones under the management group scope. This is the last of the three steps to set up your environment. Please complete [Step 1](./Configure-run-initialization.md) and [Step 2](./Deploy-lz.md) before you continue.

![Deploy your own environment process - step 3](./media/deploy-environment-step-3.png)

# Create landing zones

In a CAF enterprise-scale implementation, all platform resources in the __Connectivity__ and __Management__ subscriptions are deployed via Microsoft Azure Policy. CAF enterprise includes policy definitions and assignments required to deploy the necessary resources. While it's possible to follow the GitHub steps described in this to deploy Azure Policy definitions and assignments within the CAF enterprise deployment process, CAF enterprise provides flexibility for how the assignments can be done within platform subscriptions.

All Azure platform resources in a landing Zone follow CAF enterprise guidance and are fully controlled and provisioned through Azure Policy on the landing zone management group scope. More information on the [policy-driven approach](./../Design-Principles.md) can be found in the CAF enterprise design principals section of this document.

Before continuing, please ensure that you have completed all prerequisites in the previous sections with special attention to the following steps:

1. Ensure that the default management structure described in [configure GitHub and run initialization](./Configure-run-initialization.md) section exists.
2. Ensure that you have [initialized AzOps repository](Configure-run-initialization.md) and that pushed changes are in your **master** branch.
3. Ensure that all platform infrastructure has been deployed following [these instructions](./Deploy-platform-infra.md).

---

## Create a landing zone

There is only one more step required to move forward with creating a landing zone—create or move a subscription under the landing zone management group. Once the required definitions (roles, policies, and policy set) and assignment (roles and policies) are deployed, subscriptions can be created or moved to the landing zone's management group or any other scope below.

> Important: existing subscription and Azure resources in it will be moved into a compliant state when moved under the landing zone scope.
