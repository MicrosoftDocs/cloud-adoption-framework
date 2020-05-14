---
title: Configure run initialization
description: Configure run initialization
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
    * [Provision platform](./Deploy-platform-infra.md)
    * [Create landing zones](./Deploy-lz.md)
    * [Trigger deployments locally](./Trigger-local-deployment.md)
  * [CAF enterprise-scale template schema](./northstar-schema.md)
    * [Generic CAF enterprise-scale Azure Resource Manager template](./northstar-template-schema.md)
    * [CAF enterprise-scale Azure Resource Manager parameters file](./northstar-parameters-schema.md)
  * [Known issues](./Known-Issues.md)
* [How Do I Contribute?](../CAF enterprise-scale-Contribution.md)
* [FAQ](../northstar-FAQ.md)
* [Road map](../northstar-roadmap.md)

---

# Contents

This is the first step on who to deploy your own environment. You can learn more about the overall process [here](./Using-Reference-Implementation.md).

![Deploy your own environment process - step 1](./media/deploy-environment-step-1.png)

This article describes how to:

* Configure GitHub actions to deploy templates
* Create the default management group hierarchy
* Run a discovery of your existing Azure environment

> Important note: once you've discovered your existing Azure environment you can make changes in the environment by using your preferred client such as Microsoft Azure PowerShell, the Azure command-line interface, the Azure portal, the Azure Resource Manager (ARM) REST application programming interface, or third-party clients. The discovered environment always represents the state of your Azure tenant.

# Configure GitHub and run initialization

This section describes how to get started with the full reference implementation by configuring GitHub actions to deploy ARM templates. This section also describes how to run the initialization process, which will discover the existing Azure environment and create a representation in the local Git repository.

![Initialize AzOps process](./media/initialize-azops.png "Initialize AzOps process")

1. [Fork the repository](https://help.github.com/en/github/getting-started-with-github/fork-a-repo) to your GitHub Organization and [clone the forked GitHub repository](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository) to your local machine.  
Follow the instructions [here](./Prerequisites.md/#sync-your-fork-with-upstream-repo) to keep your fork synchronized with the upstream.

2. A user-access administrator role is required to manage the deployment of your CAF enterprise-scale architecture. This may require [elevated account permitions](https://docs.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin). It is strongly recommended to assign the permission at the highest scope possible (for example, the tenant root "/") to ensure you can use the service principal to perform subscriptions management operation. App Registration needs to be enabled on the Azure Active Directory tenant to self-register an application (Option 1).
    > Note: read access on the root level is enough to perform the initialization but not deployment. The platform requires tenant-level PUT permissions to create management groups and subscriptions.

    Option 1: enable application (app) registration 

    ```powershell
    #Create Service Principal and assign Owner role to tenant root scope ("/")
    $servicePrincipal = New-AzADServicePrincipal -Role Owner -Scope / -DisplayName AzOps
    ```

    Option 2: disable app registration 

    ```powershell
    #Create Service Principal as the Azure AD adminstrator
    $servicePrincipal = New-AzADServicePrincipal -Role Owner -Scope / -DisplayName AzOps -SkipAssignment
    #Assign Owner role to tenant root scope ("/") as a User Access Adminstrator
    New-AzRoleAssignment -ApplicationId $servicePrincipal.ApplicationId -RoleDefinitionName Owner -Scope /
    ```

    Export the service principal name (SPN) information. Perform this step in the same PowerShell instance the SPN was created.

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

3. To create the following secrets in GitHub, navigate to the main page of the repository to find you're repository's name. Select Settings, Secrets, and then Add a New Secret.

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

* Name: AZURE_ENROLLMENT_ACCOUNT_NAME [Optional] 
  
    This parameter is required if you are planning to create new subscription though this workflow. This secret must contain the **ObjectId** for the Azure enrollment account. You can obtain the id by running ```Get-AzEnrollmentAccount```

    ```bash
    ObjectId
    ```

* Name: GIT_USER_NAME

    ```bash
    MyAwesomeGitID
    ```

* Name: GIT_USER_EMAIL

    ```bash
    github-email@your-domain.com #Github ID primary email
    ```

4. In an Azure PowerShell terminal, run `Clear-AzContext` and then [`Connect-AzAccount` with your service principal](https://docs.microsoft.com/en-us/powershell/azure/create-azure-service-principal-azureps?view=azps-3.6.1#sign-in-using-a-service-principal) created earlier to ensure that you have the appropriate permissions during the initialization. You can run the following code by replacing the placeholders with your actual values:

    ```powershell
    Clear-AzContext -Force
    $user = "<service-principal-id>"
    $password = '<service-principal-password>'
    $tenantid = "<azure-tenant-id>"
    $secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential -ArgumentList $user, $secureStringPwd
    Connect-AzAccount -TenantId $tenantid  -ServicePrincipal -Credential $cred
    ```

    > Note: the tenant ID can be found by running `(Get-AzContext).Tenant`

5. Create the following management group structure. For CAF enterprise-scale implementation, it's recommended to create the following hierarchy as a parallel structure if there's already a management group structure in place. You can create the management structure with any supported client. __> We recommend for you to use the Azure portal for this in order to enjoy an enlightening moment after step 6.__

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

6. To run an initialization operation in Azure and to initialize your repository with your Azure AD tenant locally, run the code below.
   >Note: depending on the size of the environment, it may take a while for initialization to complete.

    ```powershell
    Import-Module .\src\AzOps.psd1 -Force
    Initialize-AzOpsRepository -Recurse -Verbose
    ```

    >Note: the Initialize-AzOpsRepository process will fail in there are multiple subscriptions with the same name. Before running this process, ensure all subscriptions have unique names.

    When the initialization is complete, the "azops" folder will have a folder structure mirroring your entire Azure environment from the root management group down to resources. You will notice that the management group structure you created in step 5 via the Azure portal is reflected in the "azops" folder. Please note that each ."AzState" folder will contain a snapshot of the resources/policies in that scope.

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

8. Once changes are in the master branch, create a new feature branch to enable the AzOps-Push workflow by renaming .github\workflows\azops-push.yml.disabled to .github\workflows\azops-push.yml and merge into master. For all future pull requests, this GitHub action will orchestrate deployment to Azure.
