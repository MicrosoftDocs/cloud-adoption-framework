---
title: Prerequisites
description: Prerequisites
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Prerequisites

This table lists the technical prerequisites for enterprise-scale reference implementation. We have chosen to base the reference implementation on PowerShell, but it's possible to deploy operations with Microsoft Azure CLI or other tools if you desire.

<!-- markdownlint-disable MD033 -->

| Requirement | Additional info | |
|---------------|--------------------|--------------------|
| Git >= 2.1 | The latest version of Git can be found [here](https://git-scm.com/). <br><br> Run the following command from command prompt to ensure your Git is correctly configured. You may be prompted to sign in with multi-factor authentication (multi-factor authentication). <br> <br> `git clone https://github.com/Azure/CET-NorthStar.git` | [Git handbook](https://guides.github.com/introduction/git-handbook/) |
| Visual Studio Code (vs code) | The latest version of vs code. <br><br> Open the directory `CET-NorthStar` cloned from the previous step inside vs code and run the `git pull` command to verify that Git credentials are set up correctly in vs code. <br><br> Exit vs code and delete the `CET-NorthStar` directory, as no longer required. | [Install](https://code.visualstudio.com/download#) |
Minimum version of PowerShell: 7.0 |  The latest version of PowerShell with install instructions can be found [here](https://github.com/PowerShell/PowerShell). <br> Confirm your PowerShell version by typing `$PSVersionTable` in a PowerShell session. | [Instructions](https://github.com/PowerShell/PowerShell)
| Az.Accounts >= 1.7 <br> Az.Resources >= 1.13 |  `Install-Module -Name Az.<moduleName> -MinimumVersion <version> -Scope AllUsers`<br>Confirm the version of the module you have by running <br> `Get-Module Az.<moduleName> -ListAvailable`. | [Docs](https://docs.microsoft.com/powershell/azure/install-az-ps) |
| Pester >= 4.10.1 | _Only required if you want to run pester-tests as a developer._ <br> `Install-Module -Name Pester -MinimumVersion 4.10.1 -Scope AllUsers`<br> You can confirm the version of the module you have by running <br> `Get-Module Pester -ListAvailable`. | [Docs](https://github.com/pester/Pester) |

> [!NOTE]
> For iPhones, if you have multi-factor authentication enabled on any of your accounts, make sure that your phone and app are easily accessible before you start.

## Fork the repo to your GitHub account

Open your browser and log into your GitHub account (onboarded to the `Azure` organization), and [fork](https://help.github.com/github/getting-started-with-github/fork-a-repo) the `Azure/CET-NorthStar` repo to your account. This will allow you to contribute to this repo with pull requests and participate in the standard GitHub flow.

## Clone the repo to your local machine

Open the command prompt on your local machine, navigate to a directory where you typically keep your code, and run the following command. Replace `<your-account-name>` With your GitHub account name:

```shell
git clone https://github.com/<yourAccount>/CET-NorthStar.git
```

## Sync your fork with the upstream repo

Follow these steps to synchronize the latest changes from the upstream repo to your local fork.

Run the following Git commands only after changing your directory to your local fork and adding a reference to the upstream repo:

  ```shell
  git remote -v
  git remote add upstream https://github.com/Azure/CET-NorthStar.git
  git remote -v
  ```

Execute the following Git commands only when you need to synchronize changes from upstream repo into your local fork:

  ```shell
  git fetch upstream
  git merge upstream/master
  ```
