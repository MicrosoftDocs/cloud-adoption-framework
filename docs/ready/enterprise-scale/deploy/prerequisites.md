---
title: Xx
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

## Prerequisites

This table lists the technical prerequisites needed to use the enterprise-scale reference implementation. We have chosen to base the reference implementation on PowerShell, but if desired, it is perfectly possible to use other tools such as e.g. Azure CLI for deployment operations.

|Requirement|Additional info | |
|---------------|--------------------|--------------------|
|Git >= 2.1| Latest version of Git can be found [here](https://git-scm.com/). <br> <br> Run following command from command prompt to ensure your Git is correctly configured. You may be prompted for login that may require you to sign in with multi-factor authentication. <br> <br>```git clone https://github.com/Azure/CET-NorthStar.git``` | [Git handbook](https://guides.github.com/introduction/git-handbook/)|
| Vscode |  Latest version of vscode. <br><br> Open the directory ```CET-NorthStar``` cloned from previous step inside vscode and run ```git pull``` command to ensure Git credentials are setup correctly in vscode. <br> <br> Exit vscode and delete ```CET-NorthStar``` directory as it will no longer be required. | [Install](https://code.visualstudio.com/download#)  |
Minimum version of PowerShell: 7.0|  The latest version of PowerShell including install instructions can be found [here](https://github.com/PowerShell/PowerShell). <br> Confirm the version of PowerShell that you are running by typing `$psversiontable` in a PowerShell session.| [Instructions](https://github.com/PowerShell/PowerShell)
|az.accounts >= 1.7 <br>az.resources >= 1.13 |  `Install-module -name az.<modulename> -Minimumversion <version> -Scope allusers`<br>Confirm the version of the module you have by running <br>`Get-module az.<modulename> -Listavailable`. | [Docs](https://docs.microsoft.com/powershell/azure/install-az-ps)|
| Pester >= 4.10.1 |  ***Only required if you want to run pester-tests as a developer*** <br>`Install-module -name pester -minimumversion 4.10.1 -scope allusers`<br> You can confirm the version of the module you have by running <br>`Get-module pester -listavailable`. | [Docs](https://github.com/pester/Pester) |

> :iphone: If you have Multi-factor authentication (MFA) enabled on any of your accounts, make sure that you have your token app/phone easily accessible before you start.

## Fork the CET-NorthStar repo to your GitHub account

Login to GitHub in your web browser using your private account (that was onboarded to `Azure` organization), and [fork](https://help.github.com/en/github/getting-started-with-github/fork-a-repo) `Azure/CET-NorthStar` repository to your account. This will allow you to contribute to this repository with pull requests and standard GitHub flow.

## Clone the repository to your local machine

In your local machine, open the command prompt, navigate to a directory, where you typically keep your code, and run the following command (replace <youraccount> With your GitHub account name).

```shell
git clone https://github.com/<yourAccount>/CET-NorthStar.git
```

## Sync your fork with upstream repo

Follow these steps in order to synchronize the latest changes from the upstream repo into your local fork.

1. Run the following Git commands only once you change your directory to your local fork to add a reference to the upstream repo

    ```shell
    git remote -v
    git remote add upstream https://github.com/Azure/CET-NorthStar.git
    git remote -v
    ```

2. Execute the following Git commands only when you need to synchronize changes from upstream repo into your local fork:

    ```shell
    git fetch upstream
    git merge upstream/master
    ```
