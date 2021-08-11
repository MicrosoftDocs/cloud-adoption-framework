---
title: Enterprise-scale platform automation and DevOps for Azure VMware Solution
description: Learn how to leverage platform automation for the Azure VMware Solution
author: ScottHolden
ms.author: scholden
ms.date: 08/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Platform Automation for Azure VMware Solution enterprise-scale scenario

The Enterprise Scale Landing Zone sets forward a series of best practices for Automation & DevOps which can assist with the deployment of an Azure VMware Solution (AVS) Private Cloud. This solution guide provides an overview of deployment considerations for both the initial deployment of AVS and guidance for operational automation. This implementation follows the architecture and best practices of the [Cloud Adoption Framework](/azure/cloud-adoption-framework), focusing on designing for scale. 

This solution is made up of two key parts; guidance around deployment & automation practices for AVS and a set of open-source artifacts that can be adapted to assist in the deployment of your Private Cloud. While this solution aims to set forward an end-to-end automation journey, it is open to the implementing organization to decide what components are manually deployed based on the considerations below. 

This document covers the following areas with a set of considerations & recommendations:
- Deployment options for AVS including manual & automated.
- Automated scale considerations & implementation details.
- Considerations for VMware-level automation within a private cloud.
- Recommendations on automation approaches extended from an Enterprise Landing Zone.
- Considerations on automation technologies to leverage for deployment & management (Azure CLI, ARM, Bicep, & PowerShell)

## Deployment strategy
### Manual deployment
An Azure VMware Solution private cloud can be deployed and configured graphically through the Azure portal. While this option is suitable for smaller-scale deployments, customers looking to deploy large-scale AVS topologies in a repeatable manner should look towards automated deployment. Likewise, configuring connectivity to the private cloud and scaling it can be performed via the Azure portal manually.
#### Considerations:
- Consider utilizing [manual deployments](/azure/azure-vmware/tutorial-create-private-cloud) for initial pilots and small-scale environments or where you do not have an existing automation or infrastructure-as-code practice in place.
- When deploying AVS via the Azure Portal, [Azure CLI](/cli/azure/vmware/private-cloud#az_vmware_private_cloud_create), or [Azure Powershell Modules](/powershell/module/az.vmware/new-azvmwareprivatecloud), a series of terms and conditions relating to data protection within the solution is presented. If you are using the ARM APIs directly or deploying via an ARM or Bicep template, consider reviewing these [terms and conditions](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/Microsoft.AVS?tab=Overview) before deploying automation.
- For on-demand environments that are spun-up as required, consider automating the AVS private cloud creation process, limiting the amount of manual interaction.
- Consider using the deployments blade of the target resource group within the Azure Portal to monitor the private cloud creation process. Once the private cloud has been deployed, confirm that it is in the “Succeeded” status before proceeding. If the private cloud shows [a “Failed” status](/azure/azure-vmware/fix-deployment-provisioning-failures), you may be unable to connect to vCenter, and removal & redeployment of the Private Cloud may be required.

#### Recommendations:
- If choosing a manual deployment method, it is important to document the configuration used to provision the private cloud. Once deployed, you should [download the deployment template](/azure/azure-resource-manager/templates/export-template-portal#export-template-after-deployment) used for documentation purposes. This template artifact contains the ARM template used to deploy the private cloud and a parameters file that contains the configuration you selected.
- If you are going to interact with the private cloud within the Azure portal regularly, it is recommended to place a [resource lock](/azure/azure-resource-manager/management/lock-resources) to restrict the private cloud resource deletion. Read-only resource locks can also be utilized to restrict scale operations.

### Automated Deployment
Automated deployments can be used to deploy AVS environments in a repeatable fashion, allowing you to design & then deploy on-demand. This leads to not only an efficient deployment mechanism to roll out multiple environments & regions at scale, but in turn, allows for a low-risk, on-demand, & repeatable deployment process.

#### Considerations:
- An AVS private cloud deployment may take [several hours to complete](/azure/azure-vmware/faq#how-long-does-it-take-to-provision-the-initial-three-hosts-in-a-cluster). Consider monitoring this process via either the ARM deployment status or checking the status property on the private cloud. If you are using a deployment pipeline or programmatically deploying via PowerShell or the AzureCLI, ensure that appropriate timeout values are selected to accommodate the private cloud provisioning process.
- Consider pre-allocating address ranges for private clouds and workload networks ahead of time as per the recommendations set out in [network topology and connectivity](eslz-network-topology-and-connectivity.md), and add them into environment configuration/parameter files. The address range overlap is not validated at deploy time and can lead to issues if two private clouds have the same address range or if the range overlaps with existing networks within Azure or on-premises.
- Utilizing service principals for deployment allows for the least privileged access. Consider utilizing [Azure RBAC](/azure/role-based-access-control/best-practices) to limit access for the deployment process.
- Consider using a [DevOps strategy](/azure/devops/pipelines/overview-azure) for private cloud deployment, utilizing pipelines for automated & repeatable deployments without relying on local tools.

#### Recommendations:
- Deploy a minimal private cloud and then scale as required.
- [Request host quota](/azure/azure-vmware/request-host-quota-azure-vmware-solution) or capacity ahead of time to ensure successful deployment. 
- Monitor both the private cloud deployment process and the status of the private cloud before deploying sub-resources. Further configuration updates to the Private Cloud can only be processed once the Private Cloud is in a Succeeded status. For Private Clouds that are in a [Failed status](/azure/azure-vmware/fix-deployment-provisioning-failures), it is recommended to stop any further operations and raise a support ticket.
- Include relevant resource locks either within the automated deployment, or ensure they are applied via policy.

### Automated Connectivity
Once the AVS private cloud has been deployed, you can set up connectivity via ExpressRoute. There are two critical paths for network connectivity described within this construction set: connectivity to a Virtual Network/vWAN via a Virtual Network Gateway and connectivity between AVS and an existing ExpressRoute via Global Reach. For more information about recommended network topologies, refer to [network topology and connectivity](eslz-network-topology-and-connectivity.md).
#### Considerations:
- Connecting an AVS private cloud to an Azure Virtual Network or an existing ExpressRoute automatically advertises routes from both the management networks & workload networks within the private cloud. As there are no overlap checks put in place, consider validating advertised networks before connecting.
- Consider aligning the names of ExpressRoute authorization keys with existing naming schemes for the resources they connect to, allowing for easy identification of related resources. 
- ExpressRoute Virtual Network Gateways and ExpressRoute Circuits may live in a different subscription to the AVS private cloud. You will need to decide if you want a single service principal to have access to all these resources or if you want to keep these separate. 
- The NSX-T Workload Networking via the Azure portal can deploy essential network resources into a private cloud, whereas NSX-T Manager gives more control over NSX-T components. It is worth considering what level of control you require over the network segments.
  - NSX-T Workload Networking within the Azure Portal should be used to set up DNS Zones for Private DNS integration.
  - For network topologies that only require a single Tier-1 gateway, NSX-T Workload Networking within the Azure Portal can be utilized.
  - For advanced configurations, NSX-T Manager can be utilized directly.

#### Recommendations:
- If utilizing separate service principals for AVS deployment vs. ExpressRoute configuration [Azure Key Vault](/azure/key-vault) or a similar secret store should be used to pass Authorization keys between deployments if required.
- There are [limits](/azure/azure-vmware/concepts-networking#limitations) to the number of parallel operations that can be performed over an AVS private cloud at any point in time, for templates that define many AVS private cloud sub-resources, utilizing dependencies to deploy in a serial fashion is recommended.

### Automated Scale
By default, an AVS cluster has a fixed number of hosts defined by the “scale” of the cluster. Per-cluster scaling can be programmatically modified, allowing customers to scale in & out via automation, either on-demand, on a schedule, or in reaction to Azure Monitor Alerts.
#### Considerations:
- Automated scale-out can provide additional capacity on-demand, but it is important to consider the cost of additional hosts. This will be limited to the quota that is allocated to the subscription, but manual limits should be in place.
- Before automating the scale-in, consider the impact on running workloads and storage policies applied within the cluster. For example, workloads that have RAID-5 assigned cannot be scaled-in to a 3-node cluster. It is also important to consider memory & storage utilization as this may block a scale-in operation.
- Only a single scale operation can be performed at a time, so it is important to consider the orchestration of scale operations between multiple clusters.
- An AVS Scale operation is not instantaneous, and you need to consider the time it takes to [add an additional node to an existing cluster](/azure/azure-vmware/faq#how-long-does-it-take-to-provision-the-initial-three-hosts-in-a-cluster).
- 3rd party solutions & integrations may not expect hosts to be continuously removed and added. Consider validating the behavior of all 3rd party products to ensure additional steps are not required to refresh/reconfigure the product when hosts are added or removed.
#### Recommendations:
- Put hard limits in place for both scale-in and scale-out operations outside of quota.
- [Request quota](/azure/azure-vmware/request-host-quota-azure-vmware-solution) ahead of time so it does not impact a scale operation. Quota is not a guarantee for capacity but rather the ability to deploy up to a specific limit. Review the Quota limit regularly to ensure there is always headroom.
- Ensure any automated scaling system is monitored and alerts when a scale operation is performed to ensure there are no unexpected scale events.
- Utilize Azure Metrics to confirm cluster capacity before scale-in operations to ensure there is adequate headroom. It is important to pay attention to CPU, Memory, and Storage before, during, and after any scale operations to ensure it does not impact SLA.

## Azure Integration
An AVS private cloud can also leverage several different Azure native services. These can be included within the AVS deployment or deployed as separate components. Whilst outside the scope of the document, we recommend that you should also look to leverage the existing patterns within the [Enterprise Scale Landing Zone](/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) architecture to integrate with these services.
#### Considerations:
- Consider the deployment lifecycle of each component you plan to automate. Components tightly bound by their lifecycle should be grouped together, allowing for deployment as a single unit. Components with different lifecycles should be separated.

## Automation Tooling
An AVS private cloud exists as a resource within the Azure Resource Management (ARM), allowing interaction via several different automation tools. First-party Microsoft tooling generated from the ARM specifications tends to support features shortly after being released. From an automation perspective, the considerations provided within this document are provided in a way that can be applied across different toolsets.
#### Considerations:
- Utilizing declarative tooling such as ARM Templates & Bicep Templates allows you to define configuration as a single artifact. Command-line and script-based tooling such as Azure CLI & PowerShell requires a step-by-step approach to execution which is more in line with manual deployment.
- Third-party automation tooling such as [Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vmware_private_cloud) can also be used to deploy AVS and Azure Native services. It is important to check if the features you are looking to leverage within AVS are currently included within the available resources.
- When taking a script-based approach to deployment, always consider the implications of failure to deploy & monitor appropriately. For AVS specifically, you should consider not only monitoring the deployment but also the private cloud status. For more information on monitoring AVS please visit [management and monitoring for AVS](eslz-management-and-monitoring.md).
#### Recommendations: 
- Utilize [Azure CLI](/cli/azure/vmware), [PowerShell](/powershell/module/az.vmware), or a declaritivae template such as [ARM Templates or Bicep Templates](/azure/templates) to deploy AVS in an automated manner.
- Where possible, utilize ‘what-if’ to confirm changes before execution, pausing on resource deletion for verification.
- For operations that will be single deployment but still require infrastructure as code, utilize Azure Blueprints, allowing for stamped & repeatable deployments without the need for automation pipelines.

## DevOps Approach
AVS deployment automation should be implemented as a series of repeatable steps, ideally via a workflow or pipeline. It is important to scope out the required steps that you plan to include within the deployment. This could include (but is not limited to):
- Private Cloud Deployment
- ExpressRoute Gateway Connectivity
- Global Reach Connectivity
- Simplified NSX-T DHCP, DNS, & Segment creation
Post private cloud deployment, you can then look to deploy resources within the private cloud. For further details on this, see the "VMware Platform Automation" section below.
#### Considerations:
- If you have an existing automation practice or have built a DevOps strategy as part of the Enterprise Scale Landing Zone, consider reusing the same patterns for AVS deployments to keep a consistent automation style across the board.
- For more information please visit the Enterprise Scale Landing Zone [Platform automation and DevOps documentation](/azure/cloud-adoption-framework/ready/enterprise-scale/platform-automation-and-devops).

## VMware Platform Automation
- Within an AVS private cloud, you may also choose to automate the creation of resources within vCenter & NSX-T manager. A series of considerations are listed below to assist in designing VMware-level automation.
### vCenter Automation – PowerCLI
#### Considerations:
- Use [PowerCLI](https://developer.vmware.com/powercli) to create and configure VMs, resource pools, VM templates, and more, giving you full programmatic control over vCenter.
- As vCenter is only available through private connectivity (private IP), PowerCLI must be run on a machine that has line of sight to the AVS Management Networks. Consider using a self-hosted agent for your pipeline execution, allowing you to run on a Virtual Machine within a Virtual Network or NSX-T segment.
- You may not have access to perform certain operations, as you are limited by the CloudAdmin role. Consider mapping out required permissions for the automation you plan to implement and validate it against the [CloudAdmin permissions](/azure/azure-vmware/concepts-identity).
- For least privilege access, consider using a service account for vCenter level automation via Active Directory integration.

### NSX-T Automation – PowerCLI
#### Considerations:
- By default in an AVS Private Cloud the admin user has administrative access to NSX-T, you need to consider the impact of changes made via [PowerCLI](https://developer.vmware.com/powercli) or the NSX-T APIs directly. Making modifications to Microsoft-managed components such as the Transport Zone & Tier-0 gateway are not permitted, and caution is advised.
- Private connectivity will be required from the Virtual Machine running PowerCLI to the AVS Private cloud to interact with NSX-T. 
- Workload Networking can also be controlled via ARM. This enables a subset of operations to be performed via the ARM API, and in turn, the Azure CLI & PowerShell, leveraging Azure RBAC instead of NSX-T identity.

### Terraform vSphere & NSX-T Providers
#### Considerations:
- The [vSphere](https://registry.terraform.io/providers/vmware/nsxt/latest/docs) & [NSX-T](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs) providers for Terraform can be utilized to deploy resources within the scope of the Private Cloud in a declerative fashion.
- As Terraform will need to talk to the API endpoints within vCenter & NSX-T manager, it will need to have private connectivity to the Private Cloud management network. Consider deploying from an Azure Virtual Machine that can route to the Private Cloud.

### vRealize Automation / vRealize Operations
#### Considerations:
- [vRealize Automation](https://docs.vmware.com/en/vRealize-Suite/index.html) can be used similarly to an on-premises environment, allowing you to automate the provisioning of virtual machines within AVS.
- There are limitations to the deployment models that are supported on AVS. Consider either utilizing vRealize Cloud, or hosting the vRealize Appliances on-premises.
- As with PowerCLI, private connectivity to AVS will be required from the environment where the [vRealize Automation & Operations appliances](/azure/azure-vmware/vrealize-operations-for-azure-vmware-solution) reside.

## Workload-Level Automation
Within individual workloads on AVS, you may choose to set up automation on a per-VM level. This can be achieved in the same manner as on-premises and is out of scope for this document. Examples of this could include SCCM, Chef, Puppet, Ansible, etc. You can also utilize Azure Automation for VM-level configuration using the on-premises agent.
