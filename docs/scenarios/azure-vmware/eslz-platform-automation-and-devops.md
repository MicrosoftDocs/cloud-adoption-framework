---
title: Enterprise-scale platform automation for Azure VMware Solution
description: Learn about considerations for the initial deployment of Azure VMware Solution, and find guidance for operational automation.
author: ScottHolden
ms.author: scholden
ms.date: 09/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-azure-vmware
---

# Platform automation for Azure VMware Solution enterprise-scale scenario

The enterprise-scale landing zone uses a series of best practices for automation and DevOps. These best practices can assist with the deployment of an Azure VMware Solution private cloud. This guide provides an overview of deployment considerations for the initial deployment of Azure VMware Solution. It also provides guidance for operational automation. This implementation follows the architecture and best practices of the [Cloud Adoption Framework](/azure/cloud-adoption-framework), focused on designing for scale.

This solution is made up of two key parts. The first part is guidance around deployment and automation practices for Azure VMware Solution. The second part is a set of open-source artifacts that can be adapted to help with the deployment of your private cloud. While this solution aims to start an end-to-end automation journey, your organization can decide what components to deploy manually based on the considerations in this article.

This article covers considerations and recommendations in the following areas:

- Deployment options for Azure VMware Solution, including manual and automated.
- Automated scale considerations and implementation details.
- Considerations for VMware-level automation within a private cloud.
- Recommendations on automation approaches extended from an enterprise landing zone.
- Considerations on automation technologies to use for deployment and management, like Azure CLI, Azure Resource Manager (ARM), Bicep, and PowerShell.

## Deployment strategy

### Manual deployment

You can configure and deploy an Azure VMware Solution private cloud graphically through the Azure portal. This option is suitable for smaller-scale deployments. If you want to deploy large-scale Azure VMware Solution topologies in a repeatable manner, consider an automated deployment. You can also configure connectivity to the private cloud, and then scale it manually via the Azure portal.

**Considerations:**

- You can use [manual deployments](/azure/azure-vmware/tutorial-create-private-cloud) for initial pilots and small-scale environments. You can also use them where you don't have an existing automation or infrastructure-as-code practice in place.
- When you deploy Azure VMware Solution via the Azure portal, [Azure CLI](/cli/azure/vmware/private-cloud#az_vmware_private_cloud_create), or [Azure PowerShell modules](/powershell/module/az.vmware/new-azvmwareprivatecloud), you'll see a series of terms and conditions about data protection in the solution. If you're using the ARM APIs directly or deploying via an ARM or Bicep template, consider reviewing these [terms and conditions](https://azuremarketplace.microsoft.com/marketplace/apps/Microsoft.AVS?tab=Overview) before deploying automation.
- For on-demand environments that are spun-up as required, consider automating the Azure VMware Solution private cloud creation process to limit the amount of manual interaction.
- You can use the deployments blade of the target resource group within the Azure portal to monitor the private cloud creation process. Once you've deployed the private cloud, confirm that it's in the *Succeeded* status before proceeding. If the private cloud shows a [*Failed* status](/azure/azure-vmware/fix-deployment-provisioning-failures), you might be unable to connect to vCenter. Removal and redeployment of the private cloud might be required.

**Recommendations:**

- If you choose a manual deployment method, it's important to document the configuration you use to provision the private cloud. Once deployed, [download the deployment template](/azure/azure-resource-manager/templates/export-template-portal#export-template-after-deployment) you used for documentation purposes. This template artifact contains the ARM template used to deploy the private cloud. It also has a parameters file that contains the configuration you selected.
- If you're going to interact with the private cloud in the Azure portal regularly, we recommend placing a [resource lock](/azure/azure-resource-manager/management/lock-resources) to restrict resource deletion. You can also use read-only resource locks to restrict scale operations.

### Automated deployment

You can use automated deployments to deploy Azure VMware Solution environments in a repeatable fashion. You can then design and deploy the environments on-demand. This usage leads to an efficient deployment mechanism to roll out multiple environments and regions at scale. They also provide for a low-risk, on-demand, and repeatable deployment process.

**Considerations:**

- An Azure VMware Solution private cloud deployment might take [several hours to complete](/azure/azure-vmware/faq#how-long-does-it-take-to-provision-the-initial-three-hosts-in-a-cluster). Consider monitoring this process by using the ARM deployment status or the status property on the private cloud. You might use a deployment pipeline or programmatically deploy via PowerShell or the Azure CLI. If so, ensure that appropriate timeout values are selected to accommodate the private cloud provisioning process.
- You can pre-allocate address ranges for private clouds and workload networks ahead of time per the recommendations in [Network topology and connectivity](./eslz-network-topology-connectivity.md). Then, add them into environment configuration or parameter files. The address range overlap isn't validated at deploy time. This lack of validation can lead to issues if two private clouds have the same address range. Issues can also happen if the range overlaps with existing networks within Azure or on-premises.
- You can use service principals for deployment to provide least privileged access. You can also use [Azure role-based access control (RBAC)](/azure/role-based-access-control/best-practices) to limit access for the deployment process.
- You can use a [DevOps strategy](/azure/devops/pipelines/overview-azure) for private cloud deployment, using pipelines for automated and repeatable deployments without relying on local tools.

**Recommendations:**

- Deploy a minimal private cloud and then scale as required.
- [Request host quota](/azure/azure-vmware/request-host-quota-azure-vmware-solution) or capacity ahead of time to ensure a successful deployment.
- Monitor both the private cloud deployment process and the status of the private cloud before deploying subresources. Further configuration updates to the private cloud can only be processed once the private cloud is in a *Succeeded* status. For private clouds that are in a [*Failed* status](/azure/azure-vmware/fix-deployment-provisioning-failures), we recommend you stop any further operations and raise a support ticket.
- Include relevant resource locks within the automated deployment or ensure they're applied via policy.

### Automated connectivity

Once you deploy the Azure VMware Solution private cloud, you can set up connectivity via ExpressRoute. There are two critical paths for network connectivity described within this construction set:

- Connectivity to a virtual network or an Azure Virtual WAN via a virtual network gateway.
- Connectivity between Azure VMware Solution and an existing ExpressRoute via Global Reach.

For more information about recommended network topologies, see [Network topology and connectivity](./eslz-network-topology-connectivity.md).

**Considerations:**

- You can connect an Azure VMware Solution private cloud to an Azure virtual network or an existing ExpressRoute. This connection automatically advertises routes from both the management networks and workload networks within the private cloud. As there are no overlap checks in place, consider validating advertised networks before connecting.
- You can align the names of ExpressRoute authorization keys with existing naming schemes for the resources they connect to. This alignment provides easy identification of related resources.
- ExpressRoute virtual network gateways and ExpressRoute circuits might live in a different subscription than the Azure VMware Solution private cloud. Decide whether you want a single service principal to have access to all of these resources or if you want to keep them separate.
- The NSX-T workload networking via the Azure portal can deploy essential network resources into a private cloud, but NSX-T Manager gives more control over NSX-T components. It's worth considering what level of control you require over the network segments.
  - Use the NSX-T workload networking within the Azure portal to set up Domain Name System (DNS) zones for private DNS integration.
  - For network topologies that only require a single tier-one gateway, use NSX-T workload networking within the Azure portal.
  - For advanced configurations, you can use NSX-T Manager directly.

**Recommendations:**

- If you're using separate service principals for Azure VMware Solution deployment instead of ExpressRoute configuration, use [Azure Key Vault](/azure/key-vault) or a similar secret store to pass authorization keys between deployments if necessary.
- There are [limits](/azure/azure-vmware/concepts-networking#limitations) to the number of parallel operations that can be done over an Azure VMware Solution private cloud at any moment. For templates that define many Azure VMware Solution private cloud subresources, we recommend using dependencies to deploy in a serial fashion.

### Automated scale

By default, an Azure VMware Solution cluster has a fixed number of hosts defined by the scale of the cluster. You can programmatically modify per-cluster scaling, so that you can scale in and out via automation. This automation might be on-demand, on a schedule, or in reaction to Azure Monitor alerts.

**Considerations:**

- Automated scale-out can provide more capacity on-demand, but it's important to consider the cost of more hosts. This cost is limited to the quota that's provided to the subscription, but manual limits should be in place.
- Before you automate the scale-in, consider the impact on running workloads and storage policies applied within the cluster. For example, workloads that have RAID 5 assigned can't be scaled in to a three-node cluster. It's also important to consider memory and storage use, as this usage might block a scale-in operation.
- Only one single-scale operation can be done at a time, so it's important to consider the orchestration of scale operations between multiple clusters.
- An Azure VMware Solution scale operation isn't instantaneous, and you must consider the time it takes to [add another node to an existing cluster](/azure/azure-vmware/faq#how-long-does-it-take-to-provision-the-initial-three-hosts-in-a-cluster).
- Third-party solutions and integrations might not expect hosts to be continuously removed and added. Consider validating the behavior of all third-party products. This validation ensures more steps aren't required to refresh or reconfigure the product when hosts are added or removed.

**Recommendations:**

- Put hard limits in place for both scale-in and scale-out operations outside of quota.
- [Request quota](/azure/azure-vmware/request-host-quota-azure-vmware-solution) ahead of time so it doesn't impact a scale operation. Quota isn't a guarantee for capacity, but rather the ability to deploy up to a specific limit. Review the quota limit regularly to ensure there's always headroom.
- Ensure any automated scaling system is monitored and that it alerts you when a scale operation is done. This alert ensures there are no unexpected scale events.
- Use Azure Monitor Metrics to confirm cluster capacity before scale-in operations to ensure there's adequate headroom. Pay attention to CPU, memory, and storage before, during, and after any scale operations. This attention to capacity ensures that it doesn't impact the service-level agreement (SLA).

## Azure integration

An Azure VMware Solution private cloud can also use several different Azure native services. You can include these services within the Azure VMware Solution deployment or deployed as separate components. When outside the scope of the article, we recommend that you use the existing patterns within the [enterprise-scale landing zone](/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) architecture to integrate with these services.

**Considerations:**

Consider the deployment lifecycle of each component you plan to automate. Group components tightly bound by their lifecycle should be grouped together, allowing for deployment as a single unit. Separate components with different lifecycles.

## Automation tooling

An Azure VMware Solution private cloud exists as a resource within the ARM, providing interaction via several different automation tools. First-party Microsoft tooling generated from the ARM specifications tends to support features shortly after being released. From an automation perspective, the considerations in this article are provided in a way that can be applied across different toolsets.

**Considerations:**

- Use declarative tooling like ARM and Bicep templates so that you can define configuration as a single artifact. Command-line and script-based tooling like Azure CLI and PowerShell requires a step-by-step approach to execution that's more in line with manual deployment.
- You can use third-party automation tooling like [Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vmware_private_cloud) to deploy Azure VMware Solution and Azure native services. It's important to make sure that the features you want to use within Azure VMware Solution are currently included within the available resources.
- When taking a script-based approach to deployment, always consider the implications of failure-to-deploy and monitor appropriately. For Azure VMware Solution specifically, consider monitoring both the deployment and the private cloud status. For more information on monitoring Azure VMware Solution, see [Management and monitoring for Azure VMware Solution](./eslz-management-and-monitoring.md).

**Recommendations:**

- Use [Azure CLI](/cli/azure/vmware), [PowerShell](/powershell/module/az.vmware), or a declarative template like [ARM or Bicep](/azure/templates) to deploy Azure VMware Solution in an automated manner.
- Where possible, use *what-if* to confirm changes before execution, pausing on resource deletion for verification.
- For operations that are single deployment, but still require infrastructure as code, use Azure Blueprints. Azure Blueprints provides stamped and repeatable deployments without the need for automation pipelines.

## DevOps approach

You should implement Azure VMware Solution deployment automation as a series of repeatable steps, ideally via a workflow or pipeline. It's important to scope out the required steps that you plan to include within the deployment. These steps might include:

- Private cloud deployment
- ExpressRoute gateway connectivity
- Global Reach connectivity
- Simplified NSX-T DHCP, DNS, and segment creation

After you deploy your private cloud, you can deploy resources within the private cloud. For more information, see [VMware platform automation](#vmware-platform-automation).

**Considerations:**

- You might have an existing automation practice, or you built a DevOps strategy as part of the enterprise-scale landing zone. If so, consider reusing the same patterns for Azure VMware Solution deployments to keep a consistent automation style across the board.
- For more information, see the enterprise-scale landing zone [platform automation and DevOps documentation](/azure/cloud-adoption-framework/ready/enterprise-scale/platform-automation-and-devops).

## VMware platform automation

Within an Azure VMware Solution private cloud, you might also choose to automate the creation of resources within vCenter and NSX-T Manager. The following series of considerations are listed to help design VMware-level automation.

### vCenter automation - PowerCLI

**Considerations:**

- Use [PowerCLI](https://developer.vmware.com/powercli) to create and configure virtual machines (VMs), resource pools, and VM templates, giving you full programmatic control over vCenter.
- As vCenter is only available through private connectivity, or private IP, you must run PowerCLI on a machine that has line of sight to the Azure VMware Solution management networks. Consider using a self-hosted agent for your pipeline execution. With this agent, you can run PowerCLI on a VM within a virtual network or NSX-T segment.
- You might not have access to do certain operations, as you're limited by the CloudAdmin role. Consider mapping out required permissions for the automation you plan to implement and validate it against the [CloudAdmin permissions](/azure/azure-vmware/concepts-identity).
- For least privilege access, consider using a service account for vCenter level automation via Active Directory integration.

### NSX-T automation - PowerCLI

**Considerations:**

- In an Azure VMware Solution private cloud, the admin user has administrative access to NSX-T by default. Because of this default access, consider the impact of changes made via [PowerCLI](https://developer.vmware.com/powercli) or the NSX-T APIs directly. Making modifications to Microsoft-managed components like the transport zone and tier-zero gateway aren't permitted, and caution is advised.
- Private connectivity is required from the VM running PowerCLI to the Azure VMware Solution private cloud to interact with NSX-T.
- You can control workload networking via ARM. This control enables a subset of operations to be done via the ARM API, which then enables operations via Azure CLI and PowerShell using Azure RBAC instead of NSX-T identity.

### Terraform vSphere and NSX-T providers

**Considerations:**

- You can use [vSphere](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs) and [NSX-T](https://registry.terraform.io/providers/vmware/nsxt/latest/docs) providers for Terraform to deploy resources. These resources are deployed within the scope of the private cloud in a declarative fashion.
- As Terraform needs to talk to the API endpoints within vCenter and NSX-T Manager, it needs to have private connectivity to the private cloud management network. Consider deploying from an Azure virtual machine that can route to the private cloud.

### vRealize Automation and vRealize Operations

**Considerations:**

- You can use [vRealize Automation](https://docs.vmware.com/en/vRealize-Suite/index.html) similarly to an on-premises environment, so that you can automate the provisioning of virtual machines within Azure VMware Solution.
- There are limitations to the deployment models supported on Azure VMware Solution. Consider using vRealize Cloud Management, or hosting the vRealize Automation appliances on-premises.
- As with PowerCLI, private connectivity to Azure VMware Solution is required from the environment where the [vRealize Automation and vRealize Operations appliances](/azure/azure-vmware/vrealize-operations-for-azure-vmware-solution) is.

## Workload-level automation

Within individual workloads on Azure VMware Solution, you can choose to set up automation on a per-VM level. This automation is achieved in the same way as on-premises and is out of scope for this article. Examples of this automation include SCCM, Chef, Puppet, and Ansible. You can also use Azure Automation for VM-level configuration using the on-premises agent.

## Next steps

Now that you've read through the design areas, learn about the architectural approach and implementation for Azure VMware Solution in an enterprise-scale scenario.

> [!div class="nextstepaction"]
> [Enterprise-scale for Azure VMware Solution](enterprise-scale-landing-zone.md)
