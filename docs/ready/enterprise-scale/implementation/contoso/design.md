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

## Contoso's reference implementation

Contoso's enterprise-scale reference implementation is rooted in the principle that **Everything in Azure is a resource** Contoso is using native **Azure Resource Manager (ARM)** to describe and manage their resources as part of their target state architecture at scale.

Contoso will enable security, logging, networking, and any other plumbing needed for landing zones (I.e. Subscriptions) autonomously through policy enforcement. Contoso will bootstrap the Azure environment with ARM templates to create the necessary structure for management and networking to declare a desired goal state. Contoso will apply the principal of "policy-driven governance" to deploy all necessary platform resources for a landing zone using policy. For example, deploying a key vault to store platform level secrets in the management subscription; instead of scripting the template deployment to deploy Key Vault, the north star-based reference implementation will have a policy definition that deploys the key vault in a prescriptive manner, using a policy assignment at the management subscription scope. The core benefits of a policy-driven approach are manyfold but the most significant include:

- Platform can provide an orchestration capability to bring target resources (in this case a subscription) to a desired goal state.
- Continuous conformance to ensure all platform level resources are compliant. Because the platform is aware of the goal state, the platform can assist by monitoring and remediating the resources throughout the lifecycle of the resource.
- Platform enables autonomy regardless of the customer's scale point.

### File -> New -> Region

Contoso want to use all Azure region and deploy the workload closer to the user and will be adding new Azure regions as business demand arises. As a part of enterprise-scale design principle of policy-driven governance, Contoso will be assign policy in their environment with number of regions they would like to use and policies will ensure their Azure environment is setup correctly:

#### Management

Contoso have decided to use single Log Analytics workspace. When the first region is enabled, Contoso will deploy Log Analytics workspace in their management subscription. No action will be required when enabling subsequent Azure regions, as Azure Policy will ensure all platform logging is routed to the workspace.

#### Networking

Policy will continuously check if virtual WAN virtual hub already exist in "connectivity" subscription for all enabled regions and create one if it doesn't exist. Configure virtual WAN virtual hub to secure internet traffic from secured connections (spoke virtual networks inside landing zone) to the internet via Azure Firewall.

For all Azure Virtual WAN virtual hubs, policy will ensure that Azure Firewall is deployed and linked to existing global Azure Firewall policy, as well as the creation of a regional firewall policy if needed.

Azure Policy will also deploy default NSGs and UDRs in landing zones, and while NSG will be linked to all subnets, UDR will only be linked to virtual network injected PaaS services subnets. Azure Policy will ensure that the right NSG and UDR rules are configured to allow control plane traffic for virtual network injected services to continue to work but only for those Azure PaaS services that have been approved as per the whitelisting framework described in this document. This is required, as when landing zone virtual networks get connected to virtual WAN virtual hub, they will get the default route (0.0.0.0/0) configured to point to their regional Azure Firewall, hence UDR and NSG rules are required to protect and manage control plane traffic for virtual network injected PaaS services (such as SQL mi).

For cross-premises connectivity, policy will ensure that ExpressRoute and/or VPN gateways are deployed (as required by the regional virtual hub), and it will connect the virtual hub to on-premises using ExpressRoute (by taking the ExpressRoute resource ID and authorization key as parameters). In case of VPN, Contoso can decide if they use their existing sd-WAN solution to automate the connectivity from branch offices into Azure via s2s VPN, or alternatively, Contoso can manually configure the cpe devices on the branch officers, and then let Azure Policy to configure the VPN sites in Azure Virtual WAN. As Contoso is rolling out a sd-WAN solution to manage the connectivity of all their branches around the globe, their preference is to use the sd-WAN solution, which is a solution certified with Azure Virtual WAN, to connect all their branches to Azure.

### File ->New -> Landing zone (subscription)

Contoso wants to minimize the time it takes to create landing zones and do not want Central IT to become bottleneck. Subscription will be unit of management for the landing zones and each business owner will have access to Azure billing profile that will allow them to create new subscription (a.k.a. Landing zones) with and ability to delegate this task to their own IT teams.
Once new subscription is provisioned, subscription will be automatically placed in desired management group and subject to policy configured.

Networking:

1. Create virtual network inside landing zone and establish virtual network peering with virtual WAN virtual hub in the same Azure region
2. Create default NSG inside landing zone with default rules e.g. No RDP/SSH from internet
3. Ensure new subnets created inside landing zone must have NSGs
4. Default NSG rules cannot be modified e.g. RDP/SSH from internet
5. Enable NSG flow logs and connect it to Log Analytics workspace in management subscription.
6. Protect virtual network traffic across virtual hubs with NSGs.

IAM

1. Create Azure AD group for subscriptions access
2. Create Azure AD PIM entitlement for the scope

### File -> New -> Sandbox

Sandbox subscriptions are for experiment and validation only. Sandbox subscription will not be allowed connectivity to production and policy will prevent the connectivity to on-premises resources.

### File -> Delete -> Sandbox/landing zone

Susbcription will be moved to decommissioned management group. Decommissioned management group policies will deny creation of new services and subscription cancellation request will sent.

## Implementation

Contoso will use "azops" acronym (inspired by gitops, kops etc.) for Azure operations in context of enterprise-scale design principles. Contoso have decided to use platform-native capability to orchestrate, configure and deploy landing zones using Azure Resource Manager (ARM) to declare goal state. Contoso have abide by "policy-driven governance" design principle and wants landing zones (a.k.a subscription) to be provisioned and configured autonomously.

Contoso have deliberated over whether to use single template versus modular templates and pros and cons of both and decided in favour of single template for platform orchestration. Primary reason behind this is, template will mainly consist of policy definition and policy assignments. Since, policy assignments have direct dependency on policy definitions, it will be operationally easier to manage and control lifecycle changes/versioning if artifact are represented in same template.

Contoso will use platform provided schema as input to parameter file. End to end template will use nested deployment to trigger deployment for nested children at appropriate scope I.e. Management group or subscription scope.

```powershell
Get-AzManagementGroup -GroupName Tailspin -Expand -Recurse | ConvertTo-Json -Depth 100
```

Reasoning behind this is it can be machine generated on-demand and it can be **consistently** exported to be able to help with configuration drift.

```json
{
  "Id": "/providers/Microsoft.Management/managementGroups/Tailspin",
  "Type": "/providers/Microsoft.Management/managementGroups",
  "Name": "Tailspin",
  "TenantId": "3fc1081d-6105-4e19-b60c-1ec1252cf560",
  "DisplayName": "Tailspin",
  "UpdatedTime": "0001-01-01T00:00:00Z",
  "UpdatedBy": null,
  "ParentId": "/providers/Microsoft.Management/managementGroups/3fc1081d-6105-4e19-b60c-1ec1252cf560",
  "ParentName": "3fc1081d-6105-4e19-b60c-1ec1252cf560",
  "ParentDisplayName": "3fc1081d-6105-4e19-b60c-1ec1252cf560",
  "Children": [
    {
      "Type": "/providers/Microsoft.Management/managementGroups",
      "Id": "/providers/Microsoft.Management/managementGroups/Tailspin-bu1",
      "Name": "Tailspin-bu1",
      "DisplayName": "Tailspin-bu1",
      "Children": [
        {
          "Type": "/providers/Microsoft.Management/managementGroups",
          "Id": "/providers/Microsoft.Management/managementGroups/Tailspin-bu1-corp",
          "Name": "Tailspin-bu1-corp",
          "DisplayName": "Tailspin-bu1-corp",
          "Children": null
        }
      ]
    }
  ]
}

```

User should be able to copy/paste (a.k.a. "Export") output into input template parameter file. It is important to note that not all properties required but also having extra metadata will do no-harm and platform and template will ignore these properties. Please take a look at example [20-create-child-managementgroup.parameters.json](../examples/20-create-child-managementgroup.parameters.json) for what is required.

```json
{
  "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "input": {
      "value": {
        "Name": "Tailspin",
        "DisplayName": "Tailspin",
        "ParentId": "/providers/Microsoft.Management/managementGroups/3fc1081d-6105-4e19-b60c-1ec1252cf560",
        "Children": [
          {
            "Id": "/providers/Microsoft.Management/managementGroups/Tailspin-bu1",
            "Name": "Tailspin-bu1",
            "DisplayName": "Tailspin-bu1",
            "Children": [
              {
                "Id": "/providers/Microsoft.Management/managementGroups/Tailspin-bu1-corp",
                "Name": "Tailspin-bu1-corp",
                "DisplayName": "Tailspin-bu1-corp"
              }
            ]
          }
        ]
      }
    }
  }
}
```

The tenant level ARM deployment above should create the following deployment at root scope and nested deployment at the scope of children.

- Tailspin
- Tailspin-bu1
- Tailspin-bu1-corp

This ARM template can be expanded to include [subscriptions](../examples/60-move-subscription-under-managementgroup.parameters.json) (moving subscription),  [policy definition](../examples/30-create-policydefinition-at-managementgroup.parameters.json), [policy assignment](../examples/40-create-policyassignment-at-managementgroup.parameters.json), role definition and role assignment.

Contoso has decided following for their reference implementation:

### Git repository for Azure platform configuration

Contoso is already using Azure and is concerned about their existing management group and subscription already deployed in production. To address the concerns, Contoso has decided to create Git repository to store existing management group and subscription organization.

Azure resources are organized in hierarchical manner:

```shell
Tenant Root
└───Management Group
    ├───Subscription
        ├───Resource Group
            ├───Resources
```

Contoso have found it advantageous to organize these resources in same hierarchical layout inside Git repo. As over time, management groups and subscriptions move and/or are renamed, organizing resources in a hierarchical manner allows to track the lineage over time. It will allows to map the path of the resources based on resourceid in predictable manner inside Git and reduce miss-configuration.

**AzOpsScope** class will abstract the mapping between resource identifier in Azure and the path to resources stored in the Git repo. This will facilitate quick conversion between Git and Azure and vice versa. Examining the examples below, important properties to note are scope, type (e.g. Tenant, managementgroup, subscription, resource group) and statepath (representing file location inside Git).

Another advantage of the class is recognized when deployment templates are updated in pull request, pipeline can determine at what scope to trigger deployments and appropriate parameters to pass like name, scope etc. In this way, pipeline can be triggered in predictable manner and deployment artifact can be organized at appropriate scope without including deployment scripts in each pull request throughout the scope of the Azure platform using same Azure AD tenant. Please check [deploy-templates](https://github.com/Azure/CET-NorthStar/blob/master/docs/Implementation-Getting-Started.md#deploy-templates) section for further details.

```powershell
    New-AzTenantDeployment
    New-AzManagementGroupDeployment
    New-AzSubscriptionDeployment
    New-AzResourceGroupDeployment
```

```powershell
#Example-1
New-AzOpsScope -scope /providers/Microsoft.Management/managementGroups/contoso

scope            : /providers/Microsoft.Management/managementGroups/contoso
type             : managementGroups
name             : contoso
statepath        : C:\Git\CET-NorthStar\azops\3fc1081d-6105-4e19-b60c-1ec1252cf560\contoso\managementgroup.json
managementgroup  : contoso
subscription     :
resourcegroup    :
resourceprovider :
resource         :

#Example-2
New-AzOpsScope -path C:\Git\CET-NorthStar\azops\3fc1081d-6105-4e19-b60c-1ec1252cf560\contoso\connectivity

scope            : /subscriptions/99c2838f-a548-4884-a6e2-38c1f8fb4c0b
type             : subscriptions
name             : 99c2838f-a548-4884-a6e2-38c1f8fb4c0b
statepath        : C:\Git\CET-NorthStar\azops\3fc1081d-6105-4e19-b60c-1ec1252cf560\contoso\connectivity\subscription.json
managementgroup  : contoso
subscription     : connectivity
resourcegroup    :
resourceprovider :
resource         :
```

### Initalization

**Initialize-AzOpsRepository**

This will provide discovery function to traverse the whole management group and subscription hierarchy by calling:

```powershell
Get-AzManagementGroup -Recurse -expand -GroupName {{root management group name or ID}} | ConvertTo-Json -depth 100
```

This will build the relationship association between management group and subscription. Further upon when initialize-azopsrepository function is called with -recurse parameter, it should enlist all resources available at the scope as well as children e.g. When calling of subscription, it will also get list of resource groups.

### Deployment

**Invoke-AzOpsGitPush**

Contoso wants to ensure that all platform changes are peer reviewed and approved before deploying in to production environment. Contoso have decided to implement workflow (a.k.a. Deployment pipeline) and use GitHub action for that. Contoso have named this workflow as "azops-push" referring the the direction of the change I.e. Git to Azure. All platform changes will come in the form of pull request and peer reviewed. Once pull request review is completed satisfactorily, platform team will attempt the merge of the pull request in to master branch and trigger deployment action by calling invoke-azopsgitpush function.

This function will be entry point of GitHub Actions when pull request is approved but before it is merged in master branch. Master branch represents the truth from iac perspective. This quality gate will ensure master branch remains healthy and only contain artifact that are successfully deployed in Azure. It will determine the files changed in pull request by comparing feature branch with current master brach. Following actions should be executed inside invoke-azopsgitpush:

- Validate current Azure configuration is the same as what is stored in Git by running initialize-azopsrepository.
- Git will determine if working directory is dirty and exit the deployment task to alert user and run initialize-azopsrepository interactively. All deployments should be halted at this stage as platform is in nondeterministic state from iac point of view.
- Invoke built-in new-az-*deployment commandlets at appropriate scope.

### Operationalize - configuration drift and reconciliation

**Invoke-AzOpsGitPull**

"Operationalize" Azure environment at-scale for day-to-day activities.

Contoso has decided to use PowerShell 7 and mandated all CI tasks must complete successfully on both Windows and Linux hosts simultaneously to ensure complete coverage. No local execution should be necessary after initialization and discovery activity is completed and they will publish these CI tasks as GitHub Actions.
