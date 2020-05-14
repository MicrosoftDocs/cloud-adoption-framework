---
title: Trigger local deployment
description: Trigger local deployment
author: tbd
ms.author: tbd
ms.date: 06/01/20
ms.topic: deploy
ms.service: cloud-adoption-framework
ms.subservice: ready
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
    * [Provision platform](./Deploy-platform-infra.md)
    * [Create landing zones](./Deploy-lz.md)
    * [Trigger deployments locally](./Trigger-local-deployment.md)
  * [CAF enterprise-scale template schema](./northstar-schema.md)
    * [Generic CAF enterprise-scale Microsoft Azure Resource Manager template](./northstar-template-schema.md)
    * [CAF enterprise-scale Azure Resource Manager parameters file](./northstar-parameters-schema.md)
  * [Known issues](./Known-Issues.md)
* [How do I contribute?](../CAF enterprise-scale-Contribution.md)
* [FAQ](../northstar-FAQ.md)
* [Road map](../northstar-roadmap.md)

---

# Contents

This article describes how to trigger local definitions/assignments deployments from your computer whenever you need to validate deployments without using GitHub actions.

For local debugging purposes, you can trigger a deployment from your computer by running the following commands from a PowerShell terminal.

 Before running the commands below:
 - Ensure you are located in the root folder of your local clone. 
 - Ensure you have made either definitions or assignments changes in your local clone as described on the [Deploy platform infrastructure](./Deploy-platform-infra.md) and [Deploy landing zones](./Deploy-lz.md) articles.

    ```powershell
    Import-Module .\src\AzOps.psd1 -force
    Get-ChildItem -Path .\src -Include *.ps1 -Recurse | ForEach-Object {.$_.FullName}
    Invoke-AzOpsGitPush -Verbose
    ```

Those commands will trigger a definition or assignment deployment (depending which one you configured in your local folder structure) without involving the GitHub actions deployment process described on the previous sections.