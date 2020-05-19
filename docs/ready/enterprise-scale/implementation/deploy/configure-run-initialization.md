---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 05/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Contents

This is the first step on who to deploy your own environment. You can learn more about the overall process [here](./Using-Reference-Implementation.md).

![Deploy your own environment process - step 1](./media/deploy-environment-step-1.png)

This article describes how to:

- Configure GitHub Actions to deploy templates
- Create the default management group hierarchy
- Run a discovery of your existing Azure environment

> Important note: once you have discoverd your existing Azure environment you can make changes in the environment by using your prefered client (such as Azure PowerShell, Azure CLI, Azure portal, ARM API or 3th party clients). The discoverd environment represents always the state of your Azure tenant.

# Configure GitHub and run initialization

This section desribes how to get started with the full reference implementation by configuring GitHub Actions to deploy ARM templates and also, this section describes how to run the initialization process, which will discover the existing Azure environment, and create a representation in the local Git repository.

![Initialize AzOps process](./media/initialize-azops.png "Initialize AzOps process")

1. [Fork the repository](https://help.github.com/en/github/getting-started-with-github/fork-a-repo) to your GitHub organization and [clone the forked GitHub repository](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository) to your local machine.
Follow the instructions [here](./Prerequisites.md/#sync-your-fork-with-upstream-repo) to keep your fork synchronized with the upstream.

2. "User access administrator" role is required to manage the deployment of your enterprise-scale architecture. This may requires [elevated account permitions](https://docs.microsoft.com/azure/role-based-access-control/elevate-access-global-admin) It is strongly recommended to assign the permission at the highest scope possible (I.e. Tenant root "/") to ensure you can use the service principal to perform subscriptions management operation. "App registration" needs to be enabled on the Azure AD tenant to self-register an application (option 1).
    > Note: read access on the root level is enough to perform the initialization, but not for deployment. To be able to create management group and subscriptions, platform requires tenant level put permission.

    Option 1 (app registration enabled)

    ```powershell
    #Create Service Principal and assign Owner role to tenant root scope ("/")
    $servicePrincipal = New-AzADServicePrincipal -Role Owner -Scope / -DisplayName AzOps
    ```

    Option 2 (app registration disabled)

    ```powershell
    #Create Service Principal as the Azure AD adminstrator
    $servicePrincipal = New-AzADServicePrincipal -Role Owner -Scope / -DisplayName AzOps -SkipAssignment
    #Assign Owner role to tenant root scope ("/") as a User Access Adminstrator
    New-AzRoleAssignment -ApplicationId $servicePrincipal.ApplicationId -RoleDefinitionName Owner -Scope /
    ```

    Export the spn information. Perform this step in the same PowerShell instance the spn was created.

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

3. To create the following secrets on GitHub, navigate to the main page of the repository and under your repository name, click settings, click secrets, and then click add a new secret.

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

    This parameter is required if you are planning to create new subscription though this wofklow. This secret must contain the **ObjectId** for the Azure enrollment account. You can obtain the ID by running ```get-azenrollmentaccount```

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

4. In an Azure PowerShell terminal, run `clear-azcontext` and then [`connect-azaccount` with your service principal](https://docs.microsoft.com/powershell/azure/create-azure-service-principal-azureps?view=azps-3.6.1#sign-in-using-a-service-principal) that was created earlier ensure that you have the appropriate permissions during the initialization. You can run the following code by replacing the placeholders with your actual valuaes:

    ```powershell
    Clear-AzContext -Force
    $user = "<service-principal-id>"
    $password = '<service-principal-password>'
    $tenantid = "<azure-tenant-id>"
    $secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential -ArgumentList $user, $secureStringPwd
    Connect-AzAccount -TenantId $tenantid  -ServicePrincipal -Credential $cred
    ```

    > Note: tenantid can be found by running `(get-azcontext).tenant`

5. Create the following management group structure. For enterprise-scale implementation, it is recommended to create the following hierarchy as a parallel structure if there is an existing management group structure in place. You can create the management structure with any supported client. __> We recommend using the Azure portal for this step so you can enjoy an enlightening moment after step 6.__

  ```bash
      /
      └───Tenant Root Group
          ├───<YourCompanyName>     # NEW company root management group
          │   ├───Landing Zones
          │   ├───Platform
          │   ├───Sandbox
          │   └───Decommissioned
          ├───.....                 # Existing management group or subscription
  ```

6. To run a initialization operation in Azure, and initialize your repository with your Azure AD tenant locally, run the code below.
   >Note: depending on the size of the environment, it may take a while initialization to complete.

    ```powershell
    Import-Module .\src\AzOps.psd1 -Force
    Initialize-AzOpsRepository -Verbose
    ```

    >Note: the initialize-azopsrepository process will fail in there are multiple subscriptions with the same name. Before running this process, ensure all subscriptions have unique names.

    When the initialization is complete, the "azops" folder will have a folder structure representing your entire Azure environment from root management group down to resources. You will notice that the management group structure you created in step 5 via the Azure portal is reflected in the "azops" folder. Please note that each .azstate folder will contain a snapshot of the resources/policies in that scope.

    ```bash
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

7. Commit and push changes to your repo. **Ensure your changes are in master branch by either committing to your "master" branch or create feature branch and merge it in master before proceeding to next step.**

8. Once changes are in the master branch, create a new feature branch to enable azops-push workflow by renaming .GitHub\workflows\azops-push.yml.disabled to .GitHub\workflows\azops-push.yml and merge into master. For all future PR, this GitHub action will orchestrate deployment to Azure.
