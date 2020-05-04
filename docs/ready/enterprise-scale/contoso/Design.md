---
title: "CAF enterprise-scale landing zone - Contoso's Reference Implementation"
titleSuffix: Cloud Adoption Framework
description: CAF enterprise-scale landing zone - Contoso's Reference Implementation
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

# Contoso's reference implementation

Contoso's CAF enterprise-scale landing zone reference implementation is rooted in the principle that **Everything in Azure is a resource** Contoso is leveraging native **Azure Resource Manager (ARM)** to describe and manage their resources as part of their target state architecture at scale.

Contoso will enable security, logging, networking, and any other plumbing needed for landing zones (i.e. Subscriptions) autonomously through policy enforcement. Contoso will bootstrap the Azure environment with ARM templates to create the necessary structure for management and networking to declare a desired goal state. Contoso will apply the principal of "Policy Driven Governance" to deploy all necessary resources for a Landing Zone using policy. For example, deploying a Key Vault to store platform level secrets in the management subscription; instead of scripting the template deployment to deploy Key Vault, the CAF enterprise-scale landing zone-based reference implementation will have a policy definition that deploys the Key Vault in a prescriptive manner, using a policy assignment at the management subscription scope. The core benefits of a policy driven approach are manyfold but the most significant include:

* Platform can provide an orchestration capability to bring target resources (in this case a subscription) to a desired goal state.
* Continuous conformance to ensure all platform level resources are compliant. Because the platform is aware of the goal state, the platform can assist by monitoring and remediating the resources throughout the life cycle of the resource.
* Platform enables autonomy regardless of the customer's scale point.

### File -> New -> Region

Contoso want to leverage all Azure region and deploy the workload closer to the user and will be adding new Azure regions as business demand arises. As a part of CAF enterprise-scale landing zone design principle of policy-driven governance, Contoso will assign policies in their environment with the number of regions they would like to use, and Policies will ensure their Azure Environment is set up correctly.

#### Management

Contoso has decided to use a single Log Analytics workspace. When the first region is enabled, Contoso will deploy Log Analytics workspace in their management subscription. No Action will be required when enabling subsequent Azure regions, as Azure Policy will ensure all platform logging is routed to the workspace.

#### Networking

Policy will continuously check if Virtual WAN VHub already exist in "Connectivity" subscription for all enabled regions and create one if it doesn't exist. Configure Virtual WAN VHub to secure internet traffic from secured connections (spoke VNets inside Landing Zone) to the internet via Azure Firewall.

For all Azure Virtual WAN VHubs, Policy will ensure that Azure Firewall is deployed and linked to existing global Azure Firewall Policy, as well as the creation of a regional Firewall Policy if needed.

Azure Policy will also deploy default NSGs and UDRs in Landing Zones, and while NSG will be linked to all subnets, UDR will only be linked to VNet injected PaaS services subnets. Azure Policy will ensure that the right NSG and UDR rules are configured to allow control plane traffic for VNet injected services to continue to work but only for those Azure PaaS services that have been approved as per the whitelisting framework described in this document. This is required. When landing zone VNets connect to Virtual WAN VHub, they will get the default route (0.0.0.0/0) configured to point to their regional Azure Firewall. UDR and NSG rules are required to protect and manage control plane traffic for VNet injected PaaS services (such as SQL MI).

For cross-premises connectivity, Policy will ensure that ExpressRoute and/or VPN gateways are deployed (as required by the regional VHub), and it will connect the VHub to on-premises using ExpressRoute (by taking the ExpressRoute resource ID and authorization key as parameters). In case of VPN, Contoso can decide whether to use their existing SD-WAN solution to automate the connectivity from branch offices into Azure via S2S VPN, or alternatively, Contoso can manually configure the CPE devices on the branch officers, and then let Azure Policy to configure the VPN sites in Azure Virtual WAN. As Contoso is rolling out an SD-WAN solution to manage the connectivity of all their branches around the globe, their preference is to use the SD-WAN solution, which is a solution certified with Azure Virtual WAN to connect all of their branches to Azure.

 
### File -> New -> Landing Zone (subscription)

Contoso wants to minimize the time it takes to create Landing Zones and does not want central IT to be bottlenecked. A subscription will be the unit of management for landing zones, and each business owner will have access to an Azure Billing Profile that will allow them to create new subscriptions (also known as "landing zones") with an ability to delegate this task to their IT teams.
Once a new subscription is provisioned, it's automatically placed in a target management group and subject to the configured policy.

Networking:
1)    Create VNet inside Landing Zone and establish VNet peering with VWAN VHub in the same Azure region
2)    Create Default NSG inside Landing Zone with default rules; e.g., no RDP/SSH from Internet
3)    Ensure new subnets created inside Landing Zone must have NSGs
4)    Default NSG Rules cannot be modified; e.g., RDP/SSH from Internet
5)    Enable NSG Flow logs and connect it to Log Analytics Workspace in management subscription
6)    Protect VNet traffic across VHubs with NSGs

IAM
1)    Create Azure AD Group for Subscriptions access
2)    Create Azure AD PIM Entitlement for the scope
 
### File -> New -> Sandbox

Sandbox subscriptions are for experiment and validation only. Sandbox subscription will not be allowed connectivity to Production and policy will prevent the connectivity to on-premises resources.

### File -> Delete -> Sandbox/Landing Zone

Subscription will be moved to decommissioned management group. Decommissioned management group policies will deny creation of new services and subscription cancellation requests will be sent.

## Implementation

Contoso will use "AzOps" acronym (inspired by GitOps, KOps etc.) for Azure Operations in context of CAF enterprise-scale landing zone design principles. Contoso has decided to use platform-native capability to orchestrate, configure and deploy Landing Zones using Azure Resource Manager (ARM) to declare goal state. Contoso has abided by "Policy-driven Governance" design principle and wants landing zones (also known as "subscriptions") to be provisioned and configured autonomously.

Contoso has deliberated whether to use a single template or modular templates and the pros and cons of both, deciding in favor of a single template for platform orchestration. The primary reason for this is that the Template will mainly consist of Policy Definition and Policy Assignments. Since Policy Assignments have direct dependency on Policy Definitions, it will be operationally easier to manage and control lifecycle changes/versioning if artifacts are represented in the same template.

Contoso will use platform provided schema as input to parameter file. End to End Template will use nested deployment to trigger deployment for nested children at appropriate scope; e.g., Management Group or Subscription scope.

```powershell
Get-AzManagementGroup -GroupName Tailspin -Expand -Recurse | ConvertTo-Json -Depth 100
```
The reasoning behind this is that it can be machine-generated on demand, and it can be **consistently** exported to be able to help with configuration drift.

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

Users should be able to copy/paste (also known as "export") output into input Template Parameter files. It is important to note that not all properties required but also having extra metadata will do no-harm and platform and template will ignore these properties. Review example [20-create-child-managementgroup.parameters.json](../examples/20-create-child-managementgroup.parameters.json) for what is required.

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
The Tenant level ARM deployment above should create the following deployment at root scope and nested deployment at the scope of children.

- Tailspin
- Tailspin-bu1
- Tailspin-bu1-corp

This ARM template can be expanded to include [Subscriptions](../examples/60-move-subscription-under-managementgroup.parameters.json) (moving subscription),  [Policy Definition](../examples/30-create-policydefinition-at-managementgroup.parameters.json), [Policy Assignment](../examples/40-create-policyassignment-at-managementgroup.parameters.json), Role Definition and Role Assignment.

Contoso has decided following for their reference implementation:

### Git repository for Azure Platform configuration

Contoso is already using Azure and is concerned about their existing management group and subscription already deployed in production. To address the concerns, Contoso has decided to create Git repository to store existing management group and subscription organization.

Azure resources are organized in hierarchical manner:

```shell
Tenant Root
└───Management Group
    ├───Subscription
        ├───Resource Group
            ├───Resources
```

Contoso has found it advantageous to organize these resources in same hierarchical layout inside Git Repo. Over time, management groups and subscriptions move and/or are renamed; organizing resources in a hierarchical manner allows tracking lineage over time. It will allow mapping the path of the resources based on the resourceID in predictable manner inside Git and reduce misconfiguration.



**AzOpsScope** class will abstract the mapping between resource identifier in Azure and the path to resources stored in the Git repo. This will facilitate quick conversion between Git and Azure and vice versa. Examining the examples below, important properties to note are scope, type (e.g. tenant, ManagementGroup, Subscription, Resource Group) and state path (representing file location inside Git).

Another advantage of the class is recognized when deployment templates are updated in pull request, pipeline can determine at what scope to trigger deployments and appropriate parameters to pass like name, scope etc. In this way, pipeline can be triggered in predictable manner and deployment artifact can be organized at appropriate scope without  including deployment scripts in each pull request throughout the scope of the Azure platform using same Azure AD tenant. Please check the [deploy-templates](https://github.com/Azure/CET-NorthStar/blob/master/docs/Implementation-Getting-Started.md#deploy-templates) section for further details.

* New-AzTenantDeployment
* New-AzManagementGroupDeployment
* New-AzSubscriptionDeployment
* New-AzResourceGroupDeployment

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

### Initialization

**Initialize-AzOpsRepository**

This will provide Discovery function to traverse the whole management group and subscription hierarchy by calling:

```powershell
Get-AzManagementGroup -Recurse -expand -GroupName {{root management group name or ID}} | ConvertTo-Json -depth 100
```

This will build the relationship association between management group and subscription. Further upon when Initialize-AzOpsRepository function is called with -Recurse parameter, it should enlist all resources available at the scope as well as children e.g. when calling of subscription, it will also get list of resource groups.

### Deployment

**Invoke-AzOpsGitPush**

Contoso wants to ensure that all platform changes are peer reviewed and approved before deploying in to production environment. Contoso has decided to implement workflow (also known as "deployment" pipeline) and use GitHub Action for that. Contoso has named this workflow as "azops-push" referring the direction of the change; e.g., Git to Azure.  All platform changes will come in the form of pull request and peer reviewed. Once Pull Request review is completed satisfactorily, Platform Team will attempt the merge of the pull request in to master branch and trigger deployment action by calling Invoke-AzOpsGitPush function.

This function will be entry point of GitHub Actions when pull request is approved but before it is merged in master branch. Master branch represents the truth from IaC perspective. This quality gate will ensure that the master branch remains healthy and only contains artifacts successfully deployed in Azure. It will determine the files changed in pull requests by comparing feature branch with the current master branch. The following actions should be executed inside Invoke-AzOpsGitPush:

* Validate current Azure configuration is the same as what is stored in Git by running Initialize-AzOpsRepository.
* Git will determine if working directory is dirty and exit the deployment task to alert user and run Initialize-AzOpsRepository interactively. All deployments should be halted at this stage as platform is in non-deterministic state from IaC point of view.
* Invoke built-in New-AZ-*Deployment commandlets at appropriate scope.


### Operationalize - configuration drift and reconciliation

**Invoke-AzOpsGitPull**

"Operationalize" Azure environment at-scale for day-to-day activities.

Contoso has decided to leverage PowerShell 7 and mandated all CI tasks must complete successfully on both Windows and Linux hosts simultaneously to ensure complete coverage. No local execution should be necessary after initialization and discovery activity is completed and they will publish these CI tasks as GitHub Actions.
