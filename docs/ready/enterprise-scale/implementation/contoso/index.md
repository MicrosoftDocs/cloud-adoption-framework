---
title: "CAF enterprise-scale landing zone - Contoso - getting started"
description: CAF enterprise-scale landing zone - Contoso - getting started
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

# Getting Started

This section covers how to deploy platform-native Contoso reference implementation of CAF enterprise-scale landing zone, [current design](./Implementation-design-guide.md), [FAQ](./Implementation-FAQ.md), and [known issues](./Implementation-known-issues.md).
> [!Note]
Before you start, make sure that you have read and understood the overall design objective and scope of the reference implementation.

## Target audience
The target audience for this guide is people with a typical DevOps / SRE background and assumes knowledge in Azure Resource Manager (ARM)/Infrastructure as Code (IaC), Git, and PowerShell.
## Tutorials

 - [**Deploying Template via Command Line**](#deploy-arm-templates-at-the-tenant-root-scope) - Without Git integration, experiment with ARM template deployments at the tenant ("/") root scope to better understand how to instantiate the end-2-end CAF enterprise-scale landing zone Landing Zone architecture.

 - [**Configuring Git to deploy CAF enterprise-scale landing zone**](#configure-github-and-run-initialization) - Get started with the full reference implementation including Git repository for the platform configuration, ARM templates triggered by GitHub actions for landing zones and operation detection and reconciliation with Log Analytics.

## Prerequisites

This table lists the technical prerequisites needed to use the CAF enterprise-scale landing zone reference implementation. We have chosen to base the reference implementation on PowerShell, but if desired, it is perfectly possible to use other tools such as Azure CLI for deployment operations. 

|Requirement|Additional info | |
|---------------|--------------------|--------------------| 
|Git >= 2.1| Latest version of git can be found [here](https://git-scm.com/) | [Git handbook](https://guides.github.com/introduction/git-handbook/)|
Minimum version of PowerShell: 7.0|  The latest version of PowerShell including install instructions can be found [here](https://github.com/powershell/powershell). <br> Confirm the version of PowerShell that you are running by typing `$PSVersionTable` in a PowerShell session.| 
|Az.Accounts >= 1.7 <br>Az.Resources >= 1.10 |  `Install-Module -Name Az.<ModuleName> -MinimumVersion <Version> -Scope AllUsers`<br>Confirm the version of the module you have by running <br>`Get-Module Az.<ModuleName> -ListAvailable`. | [Docs](https://docs.microsoft.com/powershell/azure/install-az-ps)| 
| Pester >= 4.10.1 |  ***Only required if you want to run pester-tests as a developer*** <br>`Install-Module -Name Pester -MinimumVersion 4.10.1 -Scope AllUsers`<br> You can confirm the version of the module you have by running <br>`Get-Module Pester -ListAvailable`. | [Docs](https://github.com/pester/pester) | 

>  :iphone: If you have Multi-factor authentication (MFA) enabled on any of your accounts, make sure that you have your token app/phone easily accessible before you start.

## Deploy ARM templates at the tenant root scope

1. Connect to Azure using `Connect-AzAccount` with an account that has at least "User Access Administrator" permissions at the tenant root level.
2. Assign required permissions at tenant root level for the account that you want to use. Owner **or** Contributor + User Access Administrator permissions is required to be able to deploy the example templates. If you don't have permissions to assign permissions at the root level, you may have to [elevate your access](https://docs.microsoft.com/azure/role-based-access-control/elevate-access-global-admin) as a global administrator before assigning the permissions. <br>
*If you want to use a service principal, follow the instructions to assign permissions under the [**Full end-to-end deployment**](#configure-github-and-run-initialization)*
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

3. [Clone the GitHub repository](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository) or download the necessary templates/template parameter files so you have the templates from the examples folder that you want to deploy on your local machine. <br>For a basic deployment test, you'll at least need access to the following templates:

    * [10-create-child-managementgroup.parameters](https://github.com/azure/cet-northStar/blob/master/examples/10-create-managementgroup.parameters.json)  
      Parameter file to deploy the company root management group (Tailspin) as a child of the Tenant Root Group
    * [20-create-child-managementgroup.parameters](https://github.com/azure/cet-northstar/blob/master/examples/20-create-child-managementgroup.parameters.json)  
      Parameter file to create nested child management groups under the company root management group
    * [30-create-policydefinition-at-managementgroup.parameters](https://github.com/azure/cet-northstar/blob/master/examples/30-create-policydefinition-at-managementgroup.parameters.json)  
      Deploys a deny if not exist (DINE) policy definition at the company root management group (Tailspin)
    * [40-create-policyassignment-at-managementgroup.parameters](https://github.com/Azure/CET-NorthStar/blob/master/examples/40-create-policyassignment-at-managementgroup.parameters.json)  
      Assigns the policy definition at company root management group scope (Tailspin)
    <br><br>
     > Read up to better understand how the CAF enterprise-scale landing zone reference ARM templates are constructed (with **one** master template and parameter files only) [here](../northstar-contribution.md#writing-arm-templates-for-contoso-implementation). 
4. In all parameter files, change the TenantID and name of the management groups to reflect the tenant where they will be deployed. TenantID can be found by running `Get-AzTenant`.
    ```json
    {
      "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
        "input": {
          "value": {
            "Name": "<YourManagementGroupName>",
            "DisplayName": "<YourManagementGroupName>",
            "ParentId": "/providers/Microsoft.Management/managementGroups/<TenantID>"
          }
        }
      }
    }
    ```

5. Deploy templates in sequential order at the tenant scope with the following commands. Execute the commands from the folder containing the *.parameters.json files or reference the files correctly:
    ```powershell
    #Define base deployment settings 
    $Name = "MGDeployment-{0}" -f (Get-Random) #Add random number to deployment name
    $TemplateUri = "https://raw.githubusercontent.com/uday31in/AzOps/master/src/tenant.json"
    $Location = "northeurope" #Can be changed to your preferred deployment location
    

    #Deploy management groups to tenant level
    New-AzTenantDeployment -Name $Name -TemplateUri $TemplateUri -Location $location `
                           -TemplateParameterFile 10-create-managementgroup.parameters.json 
    New-AzTenantDeployment -Name $Name -TemplateUri $TemplateUri -Location $location `
                           -TemplateParameterFile 20-create-child-managementgroup.parameters.json

    #Deploy and assign policies at management group level
    New-AzTenantDeployment -Name $Name -TemplateUri $TemplateUri -Location $location `
                            -TemplateParameterFile 30-create-policydefinition-at-managementgroup.parameters.json
    New-AzTenantDeployment -Name $Name -TemplateUri $TemplateUri -Location $location `
                            -TemplateParameterFile 40-create-policyassignment-at-managementgroup.parameters.json

    ```

6. Verify that the management group and policy assignments were successfully provisioned with PowerShell. Observe the children property on the management group.

    ```powershell
    #Get management groups  
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

    #Get policy assignments at management group level
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

1. [Fork the repository](https://help.github.com/en/github/getting-started-with-github/fork-a-repo) to your GitHub Organization and [clone the forked GitHub repository](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository) to your local machine.<br>Follow the instructions [here](#sync-your-fork-with-upstream-repo) to keep your fork synchronized with the upstream. 

2. "User Access Administrator" role is required to manage the deployment of your CAF enterprise-scale landing zone architecture. This may require [elevated account permissions](https://docs.microsoft.com/azure/role-based-access-control/elevate-access-global-admin) It is recommended to assign the permission at the highest scope possible (e.g., tenant root "/") to ensure you can use the service principal to perform subscriptions management operation. "App registration" needs to be enabled on the Azure AD tenant to self-register an Application (Option 1).
    > Note: Read access on the root level is enough to perform the initialization, but not for deployment. To be able to create management group and subscriptions, platform requires Tenant level PUT permission.

    Option 1 (App registration enabled)
    ```powershell
    #Create Service Principal and assign Owner role to tenant root scope ("/")
    $servicePrincipal = New-AzADServicePrincipal -Role Owner -Scope / -DisplayName AzOps
    ```

    Option 2 (App registration disabled)
    ```powershell
    #Create Service Principal as the Azure AD adminstrator
    $servicePrincipal = New-AzADServicePrincipal -Role Owner -Scope / -DisplayName AzOps -SkipAssignment
    #Assign Owner role to tenant root scope ("/") as a User Access Adminstrator
    New-AzRoleAssignment -ApplicationId $servicePrincipal.ApplicationId -RoleDefinitionName Owner -Scope /
    ```

    Export the SPN information. Perform this step in the same shell instance the SPN was created.
    ```powershell
    #Prettify output to print in the format for AZURE_CREDENTIALS to be able to copy in next step.
    [ordered]@{
        clientId = $servicePrincipal.ApplicationId
        displayName = $servicePrincipal.DisplayName
        name = $servicePrincipal.ServicePrincipalNames[1]
        clientSecret = [System.Net.NetworkCredential]::new("", $servicePrincipal.Secret).Password
        tenantId = (Get-AzContext).Tenant.Id
        subscriptionId = (Get-AzContext).Subscription.Id
    } | ConvertTo-Json
    ```

3. To create the following secrets on GitHub, navigate to the main page of the repository and under your repository name, click  Settings, click Secrets, and then click Add a new secret. 

* Name: AZURE_CREDENTIALS

    ```json
    {
      "clientId": "<<appId>>",
      "displayName": "<<redacted>>",
      "name": "<<redacted>>",
      "clientSecret": "<<redacted>>",
      "tenantId": "<<redacted>>",
      "subscriptionId": "<<default-subscriptionid>>"
    }
    ```

* Name: AZURE_ENROLLMENT_ACCOUNT_NAME 
    This secret must contain the **ObjectId** for the Azure Enrollment Account. You can obtain the ObjectId by running ```Get-AzEnrollmentAccount```

    ```bash
    ObjectId
    ```

* Name: REPO_ACCESS_TOKEN 
    This secret must contain a [GitHub Personal Access](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line#creating-a-token) token.

    ```bash
    PAT TOKEN
    ```

* Name: REPO_ACCESS_TOKEN_EMAIL

    ```bash
    github-email@your-domain.com #Github ID primary email
    ```

4. Run `Clear-AzContext` and then [`Connect-AzAccount` with your service principal](https://docs.microsoft.com/powershell/azure/create-azure-service-principal-azureps?view=azps-3.6.1#sign-in-using-a-service-principal) that was created earlier ensure that you have the appropriate permissions during the initialization. 

5. To run an initialization operation in Azure and initialize your repository with your Azure AD tenant locally, run the code below. 
    Note: Depending on the size of the environment, it may take a while initialization to complete.

    ```powershell
    Import-Module .\src\AzOps.psd1 -Force
    Initialize-AzOpsRepository -Recurse -Verbose
    ```

    When the initialization is complete, the "azops" folder will have a folder structure representing the entire Azure environment from root mg down to resources. Each .AzState folder will contain a snapshot of the resources/policies in that scope.

    ```bash
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

6. Commit and push changes to your repo. **Ensure your changes are in master branch by either committing to your "master" branch or create feature branch and merge it in master before proceeding to next step.**

## Deploy templates

Look at [Examples](https://github.com/Azure/CET-NorthStar/tree/master/examples) folder and explore the End to End Landing Zone Templates. Copy and modify the file at the root management group scope.

For any other templates that you might want to deploy, follow the instructions below:

1. Ensure you have Initialize AzOpsRepository and that pushed changes are in your **master** branch.
2. Create Feature Branch from your master.
3. Place **{{template-name}}.json** and **{{template-name}}.parameters.json** at the scope you want to trigger the deployment. {{template-name}} could be any valid filename but it must have corresponding parameters.json. Look at example **create-storage-account.json** and **create-storage-account.parameters.json** in below structure.

There is an exception to this when tenant-level deployment is placed at the root. In that case pipeline will use generic [default template](https://github.com/uday31in/AzOps/blob/master/src/tenant.json) and you don't need to place  **{{template-name}}.json**. Only **{{template-name}}.parameters.json** is required. You can still override this behavior by placing **{{template}}.json** along side of **{{template}}.parameters.json**. For the below example, it would be 10-create-managementgroup.json

Any other json file that isn't named ***.parameters.json** it will be ignored by pipeline and not used by pipeline.
```
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
    └────10-create-managementgroup.parameters.json
```

4. Stage your changes in Git. It is important that you **do not push changes directly in "master" branch**. You should always create a feature branch and submit a pull request to your 'master' branch. If changes are pushed in "master" branch, they won't be picked by GitHub Deployment actions.

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
6. Create PR from feature branch to master branch. Please pay attention to upstream branch default branch might be upstream fork rather your own master branch.
7. Approve your PR.
8. The "azops-push" GitHub action should trigger automatically at this point and you can monitor the status in Actions log.
9. After all status checks are passed on your PR (including but not limited to "azops-push" action), squash merge your changes to your own master branch.
10. Sync your local master branch on your machine from your origin/master

    ```shell
    git checkout master
    git fetch
    git merge origin/master
    ```

## Sync your fork with upstream repo

Follow these steps in order to synchronize the latest changes from the upstream repo into your local fork

1) Run the following git commands only once in your local fork to add a reference to the upstream repo

    ```shell
    git remote -v
    git remote add upstream https://github.com/Azure/CET-NorthStar.git
    git remote -v
    ```

2) Execute the following git commands only when you need to synchronize changes from upstream repo into your local fork:

    ```shell
    git fetch upstream
    git merge upstream/master
    ```
