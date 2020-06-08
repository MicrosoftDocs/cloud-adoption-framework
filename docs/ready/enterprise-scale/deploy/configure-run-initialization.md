---
title: Configure run initialization
description: Configure run initialization
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Contents

This is the first step of who should deploy your environment. You can learn more about the overall process [here](./Using-Reference-Implementation.md).

![Step 1: the process to deploy your own environment](../media/deploy-environment-step-1.png)
_Figure 1: The process to deploy your own environment_

This article describes how to:

* Configure GitHub Actions to deploy templates
* Create the default management group hierarchy
* Discover your current Microsoft Azure environment

> Important: once you have discovered your current Azure environment, you can make changes there by using a preferred client such as Azure PowerShell, Azure CLI, the Portal, the Resource Manager API, or third-party clients. The discovered environment always represents the state of your Azure tenant.

# Configure GitHub and run initialization

This section describes the steps for how to get started with the full reference implementation by configuring GitHub Actions to deploy Resource Manager templates and how to run the initialization to discover the current Azure environment and create a representation in the local Git repo.

![Initialize AzOps process](../media/initialize-azops.png")
_Figure 2: The Initialize AzOps process._

1. [Fork the repo](https://help.github.com/en/github/getting-started-with-github/fork-a-repo) to your GitHub organization and [clone the forked GitHub repo](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository) to your local machine.
Follow the instructions [here](./prerequisites.md#sync-your-fork-with-upstream-repo) to synchronize your for with the upstream.

2. A User Access Administrator role is required to manage and deploy your enterprise-scale architecture. This may require [elevated account permissions](https://docs.microsoft.com/azure/role-based-access-control/elevate-access-global-admin). It is strongly recommended to assign the permission at the highest scope possible (for example, the tenant root `/`) to ensure you can use the service principal to manage subscriptions. App registration needs to be enabled on the Azure Active Directory (Azure AD) tenant to self-register an app (option 1).
    > Note: read access on the root level is enough to perform the initialization but not deployment. To create management groups and subscriptions, the platform requires tenant-level PUT permission.

    Option 1: App registration enabled

    ```powershell
    #Create Service Principal and assign Owner role to tenant root scope ("/")
    $servicePrincipal = New-AzADServicePrincipal -Role Owner -Scope / -DisplayName AzOps
    ```

    Option 2: App registration disabled

    ```powershell
    #Create Service Principal as the Azure AD Administrator
    $servicePrincipal = New-AzADServicePrincipal -Role Owner -Scope / -DisplayName AzOps -SkipAssignment
    #Assign Owner role to tenant root scope ("/") as a User Access Administrator
    New-AzRoleAssignment -ApplicationId $servicePrincipal.ApplicationId -RoleDefinitionName Owner -Scope /
    ```

    Export the service principal name information. Perform this step in the same PowerShell instance when the service principal name was created.

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

3. To create the following secrets on GitHub, navigate to the main page of the repo and select Settings, Secrets, and Add a New Secret under your repo's name.

- Name: Azure_credentials

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

- Name: Azure_enrollment_account_name [optional]

    This parameter is required if you are planning to create new subscription though this workflow. This secret must contain the **ObjectId** for the Azure enrollment account. You can obtain the ID by running ```get-azenrollmentaccount```

    ```bash
    ObjectId
    ```

- Name: Git_user_name

    ```bash
    MyAwesomeGitID
    ```

- Name: Git_user_email

    ```bash
    github-email@your-domain.com #Github ID primary email
    ```

4. In an Azure PowerShell terminal, run `clear-azcontext` and then [`connect-azaccount` with the service principal](https://docs.microsoft.com/powershell/azure/create-azure-service-principal-azureps?view=azps-3.6.1#sign-in-using-a-service-principal) that you created earlier to validate if you have the appropriate permissions during the initialization. You can run the following code by replacing the placeholders with your actual values:

    ```powershell
    Clear-AzContext -Force
    $user = "<service-principal-id>"
    $password = '<service-principal-password>'
    $tenantid = "<azure-tenant-id>"
    $secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential -ArgumentList $user, $secureStringPwd
    Connect-AzAccount -TenantId $tenantid  -ServicePrincipal -Credential $cred
    ```

    > [!NOTE]
    > The `tenantId` can be found by running `(Get-AzContext).Tenant`.

5. You can create a management structure with any supported client. Create the management group structure below. If there's a management group structure in place for enterprise-scale implementation, we recommended the Azure portal for this step and the following hierarchy:

  ```shell
      /
      └───Tenant Root Group
          ├───<YourCompanyName>     # NEW company root management group
          │   ├───Landing Zones
          │   ├───Platform
          │   ├───Sandbox
          │   └───Decommissioned
          ├───.....                 # Existing management group or subscription
  ```

6. To run an initialization operation in Azure and initialize your repo with your Azure AD tenant locally, run the code below.
   >Note: depending on the size of the environment, it may take a while initialization to complete.

    ```powershell
    Import-Module .\src\AzOps.psd1 -Force
    Initialize-AzOpsRepository -Verbose
    ```

    > [!NOTE]
    `Initialize-AzOpsRepository` will fail in there are multiple subscriptions with the same name. Before running this process, verify that all subscriptions have unique names.

    When the initialization is complete, the `AzOps` folder will have a folder structure that represents your entire Azure environment and list everything from the root management group to resources. You will see that the management group structure you created with the Azure portal in step 5 is reflected here. Please note that each `.AzState` folder will contain a snapshot of the resources/policies in that scope.

    ```shell
    AzOps
    └───Tenant Root Group
        ├───<YourCompanyName>                              # NEW company root management group
        │   ├───.AzState
        │   │   └───Contoso.parameters.json
        │   ├───Landing Zones
        │   │   └───.AzState
        │   │       └───LandingZones.parameters.json
        │   ├───Platform
        │   │   └───.AzState
        │   │       └───Platform.parameters.json
        │   ├───Sandbox
        │   │   └───.AzState
        │   │       └───Sandbox.parameters.json
        │   └───Decommissioned
        │       └───.AzState
        │           └───Decommissioned.parameters.json
        ├───.....                                          # Existing management group or subscription structure
    ```

7. Commit and push changes to your repo. Ensure your changes are in the master branch by either committing to master, or creating a feature branch and merging it to master before proceeding to the next step.

8. Once changes are in the master branch, create a new feature branch to enable the `AzOps-Push` workflow by renaming `.GitHub\workflows\azops-push.yml.disabled` to `.GitHub\workflows\azops-push.yml` and merging to master. For all future pull requests, GitHub Actions will deploy to Azure.
