---
title: Trigger local deployment
description: Trigger local deployment
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Contents

This article describes how to trigger local definition/assignment deployments from your computer when you need to validate deployments without GitHub Actions.

For local debugging purposes, you can trigger a deployment from your computer by running the commands below from a PowerShell terminal.

Before running the commands below:

* Make sure that you're in the root folder of your local clone.
* Make sure that you've made either definition or assignment changes in your local clone, as described on the [deploy platform infrastructure](./deploy-platform-infrastructure.md) and [deploy landing zones](./deploy-landing-zone.md) articles.

    ```powershell
    Import-Module .\src\AzOps.psd1 -Force
    Get-ChildItem -Path .\src -Include *.ps1 -Recurse | ForEach-Object {.$_.FullName}
    Invoke-AzOpsGitPush -Verbose
    ```

Those commands will trigger a definition or assignment deployment (depending on which one you configured in your local folder structure) without involving the GitHub Actions deployment process described in the previous sections.
