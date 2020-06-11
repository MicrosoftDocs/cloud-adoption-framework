---
title: CAF enterprise-scale landing zone - Contoso example
description: CAF enterprise-scale landing zone - Contoso example
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

<!-- docsTest:disable -->

# CAF enterprise-scale landing zone - Contoso example

This section shows how to deploy a platform-native Contoso reference implementation of a CAF enterprise-scale landing zone, the [current design](../implementation-design-guide.md), [FAQ](../faq.md), and [known issues](./known-issues.md).

> [!NOTE]
> Before you start, make sure that you've read and understood the overall design objective and scope of the reference implementation.

## Target audience

The target audience for this guide is people with a typical DevOps or site reliability engineering background and knowledge of Microsoft Azure Resource Manager, infrastructure as code (IaC), Git, and PowerShell.

## Tutorials

- [Deploy a template via the command line](#deploy-arm-templates-at-the-tenant-root-scope). Without Git integration, experiment with Resource Manager template deployments at the tenant-root (`/`) scope to better understand how to instantiate the end-to-end CAF enterprise-scale landing zone architecture.

- [Configure GitHub to deploy the CAF enterprise-scale landing zone](#configure-github-and-run-initialization). Get started with the full reference implementation, including the Git repo to configure the platform, Resource Manager templates triggered by GitHub Actions for landing zones, and operation detection and reconciliation with Azure Monitor logs.

## Prerequisites

This table lists the technical prerequisites needed for using the CAF enterprise-scale landing zone reference implementation. We've chosen to base the reference implementation on PowerShell, but it's possible to use other tools such as Azure CLI for deployment operations.

<!-- markdownlint-disable MD033 -->

| Requirement | Additional info | |
|---|---|---|
| Git >= 2.1 | The latest version of Git can be found [here](https://git-scm.com) | [Git handbook](https://guides.github.com/introduction/git-handbook) |
| Minimum version of PowerShell: 7.0 | The latest version of PowerShell including install instructions can be found [here](https://github.com/powershell/powershell). <br> Confirm the version of PowerShell that you're running by typing `$PSVersionTable` in a PowerShell session. |
| Az.Accounts >= 1.7 <br> Az.Resources >= 1.10 | `Install-Module -Name Az.<module-name> -MinimumVersion <version> -Scope AllUsers` <br> Confirm the version of the module you have by running <br> `Get-Module az.<moduleName> -ListAvailable`. | [Docs](https://docs.microsoft.com/powershell/azure/install-az-ps) |
| Pester >= 4.10.1 | _Only required if you want to run pester tests as a developer._ <br> `Install-Module -Name Pester -MinimumVersion 4.10.1 -scope AllUsers` <br> You can confirm the version of the module you have by running <br> `Get-Module Pester -ListAvailable`. | [Docs](https://github.com/pester/pester) |

> [!NOTE]
> For iPhones, if you have multi-factor authentication enabled on any of your accounts, make sure that your phone and app are easily accessible before you start.

<!-- cSpell:ignore northeurope ADINE policyassignment policydefinition managementgroup azops -->

## Deploy Resource Manager templates at the tenant root scope

1. Connect to Azure using `Connect-AzAccount` with an account that has at least `user access administrator` permissions at the tenant root level.
2. Assign required permissions at the tenant root level for the account that you want to use. `Owner` or `contributor` and `user access administrator` permissions are required to deploy the example templates. If you don't have permissions to assign permissions at the root level, you might have to [elevate your access](https://docs.microsoft.com/azure/role-based-access-control/elevate-access-global-admin) as a `global administrator` before assigning them. If you need to use a service principal, follow the [full end-to-end deployment](#configure-github-and-run-initialization) instructions to assign permissions.

    ```powershell
    New-AzRoleAssignment -SignInName john.doe@contoso.com -RoleDefinitionName "Owner" -Scope "/"  

    RoleAssignmentId   : /providers/Microsoft.Authorization/roleAssignments/3b012473-78b1-4511-8e7f-f6f786bfbb02
    Scope              : /
    DisplayName        : John Doe
    SignInName         : john.doe@contoso.com
    RoleDefinitionName : Owner
    RoleDefinitionId   : 8e3af657-a8ff-443c-a75c-2fe8c4bcb635
    ObjectId           : 24eefd82-dcc3-494f-acdd-f4e258e932e8
    ObjectType         : User
    CanDelegate        : False
    ```

3. [Clone the GitHub repo](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository) or download the necessary template and template parameter files to have the templates from the `examples` folder to deploy on your local machine. <br> For a basic deployment test, you'll need access to the following templates:

    - [10-Create-Child-ManagementGroup.parameters](https://github.com/azure/CET-NorthStar/blob/master/examples/10-Create-ManagementGroup.parameters.json)
      Parameter file to deploy the company root management group (tailspin) as a child of the tenant root group.
    - [20-Create-Child-ManagementGroup.parameters](https://github.com/azure/CET-NorthStar/blob/master/examples/20-Create-Child-ManagementGroup.parameters.json)
      Parameter file to create nested child management groups under the company root management group.
    - [30-Create-PolicyDefinition-at-ManagementGroup.parameters](https://github.com/azure/CET-NorthStar/blob/master/examples/30-Create-PolicyDefinition-at-ManagementGroup.parameters.json)
      Deploys a `DeployIfNotExists` policy definition at the company root management group (Tailspin).
    - [40-Create-PolicyAssignment-at-ManagementGroup.parameters](https://github.com/Azure/CET-NorthStar/blob/master/examples/40-Create-PolicyAssignment-at-ManagementGroup.parameters.json)
      Assigns the policy definition at company root management group scope (Tailspin).
    <br><br>
     > Read the following to better understand how the CAF enterprise-scale landing zone reference Resource Manager templates are constructed (with one master template and parameter files only) [here](../contribution.md#writing-arm-templates-for-contoso-implementation).

4. In all parameter files, change the tenant ID and name of the management groups to reflect the tenant where they'll be deployed. The tenant ID can be found by running `Get-AzTenant`:

    ```json
    {
      "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
        "input": {
          "value": {
            "Name": "<YourManagementGroupName>",
            "DisplayName": "<YourManagementGroupName>",
            "ParentId": "/providers/Microsoft.Management/managementGroups/<tenant-id>"
          }
        }
      }
    }
    ```

5. Deploy templates in sequential order at the tenant scope with the following commands. Execute the commands from the folder containing the `*.parameters.json` files, or reference the files correctly:

    ```powershell
    # Define base deployment settings

    $Name = "MGDeployment-{0}" -f (Get-Random) # Add random number to deployment name
    $TemplateUri = "https://raw.githubusercontent.com/uday31in/AzOps/master/src/tenant.json"
    $Location = "northeurope" # Can be changed to your preferred deployment location

    # Deploy management groups to tenant level

    New-AzTenantDeployment -Name $Name -TemplateUri $TemplateUri -Location $location `
                           -TemplateParameterFile 10-Create-ManagementGroup.parameters.json
    New-AzTenantDeployment -Name $Name -TemplateUri $TemplateUri -Location $location `
                           -TemplateParameterFile 20-Create-Child-ManagementGroup.parameters.json

    # Deploy and assign policies at management group level

    New-AzTenantDeployment -Name $Name -TemplateUri $TemplateUri -Location $location `
        -TemplateParameterFile 30-Create-PolicyDefinition-at-ManagementGroup.parameters.json
    New-AzTenantDeployment -Name $Name -TemplateUri $TemplateUri -Location $location `
        -TemplateParameterFile 40-Create-PolicyAssignment-at-ManagementGroup.parameters.json

    ```

6. Verify that the management group and policy assignments were successfully provisioned with PowerShell. Observe the `Children` property on the management group:

    ```powershell
    # Get management groups  

    Get-AzManagementGroup -GroupName Tailspin -Recurse -Expand

    Id                : /providers/Microsoft.Management/managementGroups/Tailspin
    Type              : /providers/Microsoft.Management/managementGroups
    Name              : Tailspin
    TenantId          : 3fc1081d-6105-4e19-b60c-1ec1252cf560
    DisplayName       : Tailspin
    UpdatedTime       : 0001-01-01 00:00:00
    UpdatedBy         :
    ParentId          : /providers/Microsoft.Management/managementGroups/3fc1081d-6105-4e19-b60c-1ec1252cf560
    ParentName        : 3fc1081d-6105-4e19-b60c-1ec1252cf560
    ParentDisplayName : 3fc1081d-6105-4e19-b60c-1ec1252cf560
    Children          : Tailspin-bu1

    # Get policy assignments at management group level

    Get-AzPolicyAssignment -Scope  /providers/Microsoft.Management/managementGroups/Tailspin -WarningAction Ignore

    Name                  : ADINE-KeyVault
    ResourceId            : /providers/Microsoft.Management/managementGroups/Tailspin/providers/Microsoft.Authorization/policyAssignments/ADINE-KeyVault
    ResourceName          : Tailspin
    ResourceType          : Microsoft.Management/managementGroups
    ExtensionResourceName : ADINE-KeyVault
    ExtensionResourceType : Microsoft.Authorization/policyAssignments
    Location              : northeurope
    Properties            : @{displayName=ADINE-KeyVault;
                            policyDefinitionId=/providers/Microsoft.Management/managementGroups/Tailspin/providers/Microsoft.Authorization/policyDefinitions/DINE-KeyVault;
                            scope=/providers/Microsoft.Management/managementGroups/Tailspin; notScopes=System.Object[]; parameters=; metadata=; enforcementMode=Default}
    Sku                   : @{name=A0; tier=Free}
    Identity              : @{type=SystemAssigned; principalId=04075beb-d2d3-4761-b72e-28628c60c902; tenantId=3fc1081d-6105-4e19-b60c-1ec1252cf560}
    PolicyAssignmentId    : /providers/Microsoft.Management/managementGroups/Tailspin/providers/Microsoft.Authorization/policyAssignments/ADINE-KeyVault
    ```

## Configure GitHub and run initialization

1. [Fork the repo](https://help.github.com/en/github/getting-started-with-github/fork-a-repo) to your GitHub organization and [clone the forked GitHub repo](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository) to your local machine. Follow the instructions [here](#sync-your-fork-with-upstream-repo) to keep your fork synchronized with the upstream repo.

2. A `user access administrator` role is required to manage the deployment of your CAF enterprise-scale landing zone architecture. This may require [elevated account permissions](https://docs.microsoft.com/azure/role-based-access-control/elevate-access-global-admin). Assign the permission at the highest scope possible (for example, the tenant root `/`) to ensure that you can use a service principal to perform subscriptions management operations. App registration needs to be enabled on the Azure AD tenant to self-register an app (option 1).
    > [!NOTE]
    > Read access on the root level is enough to perform initialization but not deployment. To create management groups and subscriptions, the platform requires tenant-level `put` permissions.

    Option 1 (app registration enabled):

    ```powershell
    #Create the service principal and assign the Owner role to tenant root scope ("/")
    $servicePrincipal = New-AzADServicePrincipal -Role Owner -Scope / -DisplayName AzOps
    ```

    Option 2 (app registration disabled):

    ```powershell
    # Create the service principal as the Azure AD administrator

    $servicePrincipal = New-AzADServicePrincipal -Role Owner -Scope / -DisplayName AzOps -SkipAssignment
    # Assign the Owner role to the tenant root scope ("/") as a user access administrator

    New-AzRoleAssignment -ApplicationId $servicePrincipal.ApplicationId -RoleDefinitionName Owner -Scope /
    ```

    Export the service principal name information. Perform this step in the same shell instance the service principal name was created.

    ```powershell

    # Format output for AZURE_CREDENTIALS to enable copying in the next step.

    [ordered]@{
        clientId = $servicePrincipal.ApplicationId
        displayName = $servicePrincipal.DisplayName
        name = $servicePrincipal.ServicePrincipalNames[1]
        clientSecret = [System.Net.NetworkCredential]::new("", $servicePrincipal.Secret).Password
        tenantId = (Get-AzContext).Tenant.Id
        subscriptionId = (Get-AzContext).Subscription.Id
    } | ConvertTo-Json
    ```

3. To create the following secrets on GitHub, navigate to the main page of the repo and select **Settings** > **Secrets**, and add a new secret under the repo name.

- Name: Azure_credentials

    ```json
    {
      "clientId": "<<appId>>",
      "displayName": "<<redacted>>",
      "name": "<<redacted>>",
      "clientSecret": "<<redacted>>",
      "tenantId": "<<redacted>>",
      "subscriptionId": "<<default-subscriptionId>>"
    }
    ```

- Name: Azure_enrollment_account_name
    This secret must contain the `ObjectId` for the Azure enrollment account. You can obtain the `ObjectId` by running `Get-AzEnrollmentAccount`.

    ```bash
    ObjectId
    ```

- Name: Repo_access_token
    This secret must contain a [GitHub personal access](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line#creating-a-token) token.

    ```bash
    PAT TOKEN
    ```

- Name: Repo_access_token_email

    ```bash
    github-email@your-domain.com #Github ID primary email
    ```

4. Run `Clear-AzContext` and then [`Connect-AzAccount` with your service principal](https://docs.microsoft.com/powershell/azure/create-azure-service-principal-azureps?view=azps-3.6.1#sign-in-using-a-service-principal) created earlier ensure that you have the appropriate permissions during the initialization.

5. To run an initialization operation in Azure and initialize your repo with your Azure AD tenant locally, run the code below.
    > [!NOTE]
    > Depending on the size of the environment, it may take a while initialization to complete.

    ```powershell
    Import-Module .\src\AzOps.psd1 -Force
    Initialize-AzOpsRepository -Recurse -Verbose
    ```

    When the initialization is complete, the `AzOps` folder will have a folder structure representing the entire Azure environment from root management group down to resources. Each `.AzState` folder will contain a snapshot of the resources and policies in that scope.

    ```shell
    AzOps
    └───Tenant Root Group
        └───Contoso
            ├───.AzState
            ├───Non-Production
            │   ├───.AzState
            │   └───Subscription 2
            │       ├───.AzState
            │       └───rg1
            │           └───.AzState
            ├───Production
            │   ├───.AzState
            │   └───Subscription 1
            │       ├───.AzState
            │       ├───NetworkWatcherRG
            │       │   └───.AzState
            │       ├───rg1
            │       ├───rg2
            │       └───rg3
            └───Sandbox
                └───.AzState
    ```

6. Commit and push changes to your repo. Ensure your changes are in the `master` branch by either committing to your `master` branch, or creating a feature branch and merge it into `master` before proceeding to the next step.

## Deploy templates

Look at the [examples folder](https://github.com/Azure/CET-NorthStar/tree/master/examples) and explore the end-to-end landing zone templates. Copy and modify the file at the root management group scope.

For any other templates that you might want to deploy, follow the instructions below:

1. Ensure that you've initialized `AzOpsRepository` and that your pushed changes are in the `master` branch.

2. Create a feature branch from `master`.

3. Place `<template-name>.json` and `<template-name>.parameters.json` at the scope you want to trigger the deployment. The `template-name` could be any valid filename, but it must have a `.parameters.json` suffix. See the example `create-storage-account.json` and `create-storage-account.parameters.json` files in the structure below.

There is an exception to this when tenant-level deployment is placed at the root. In that case, the pipeline will use a generic [default template](https://github.com/uday31in/AzOps/blob/master/src/tenant.json), so you don't need to place the `<template-name>.json` file. Only `<template-name>.parameters.json` is required. You can still override this by placing `<template-name>.json` alongside `<template-name>.parameters.json`. For the example below, the file is `10-Create-ManagementGroup.json`. Any other JSON file not named like `*.parameters.json` will be ignored and not used by the pipeline.

```shell
AzOps
└───Tenant Root Group
    |├───Contoso
    │├───.AzState
    │├───Non-Production
    ││   ├───.AzState
    ││   └───Subscription 2
    ││       ├───.AzState
    ││       └───rg1
    ││           └───.AzState
    ││           └─── create-storage-account.json
    ││           └─── create-storage-account.parameters.json
    │├───Production
    ││   ├───.AzState
    ││   └───Subscription 1
    ││       ├───.AzState
    ││       ├───NetworkWatcherRG
    ││       │   └───.AzState
    ││       ├───rg1
    ││       ├───rg2
    ││       └───rg3
    │├───Sandbox
    │└───.AzState
    └────10-Create-ManagementGroup.parameters.json
```

4. Stage your changes in Git. Don't push changes directly to the `master` branch. You should always create a feature branch and submit a pull request (PR) to your `master` branch. If changes are committed directly to the `master` branch, they won't be picked by GitHub Actions.

    For local debugging purposes, you can run the following command to trigger deployment locally.

    ```powershell
    Import-Module .\src\AzOps.psd1 -force
    . .\src\Helper\AzOpsHelper.ps1
    . .\src\Init\AzOpsInit.ps1
    . .\src\Push\AzOpsPush.ps1
    . .\src\Pull\AzOpsPull.ps1
    Initialize-AzOpsGlobalVariables -Verbose
    Invoke-AzOpsGitPush
    ```

5. Commit your changes and push your branch to your GitHub fork.

6. Create a PR from your feature branch to the `master` branch. Pay attention to the upstream branch; the default branch might be an upstream fork rather your own `master` branch.

7. Approve your PR.

8. The `azops-push` GitHub action should trigger automatically at this point and you can monitor the status in the actions log.

9. After all status checks are passed on your PR (including but not limited to the `azops-push` action), squash and merge your changes into your own `master` branch.

10. Sync your local `master` branch on your machine from your `origin/master` branch.

    ```shell
    git checkout master
    git fetch
    git merge origin/master
    ```

## Sync your fork with the upstream repo

Follow these steps in order to synchronize the latest changes from the upstream repo into your local fork.

Run the following Git commands only once in your local fork to add a reference to the upstream repo:

  ```shell
  git remote -v
  git remote add upstream https://github.com/Azure/CET-NorthStar.git
  git remote -v
  ```

Execute the following Git commands only when you need to synchronize changes from the upstream repo into your local fork:

  ```shell
  git fetch upstream
  git merge upstream/master
  ```
