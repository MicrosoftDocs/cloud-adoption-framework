---
title: Govern Azure VMware Solution
description: Learn about how to extend your governance approach across the Azure VMware Solution.
author: mpvenables
ms.author: janet
ms.date: 08/30/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-azure-vmware
---

# Govern Azure VMware Solution

Azure VMware Solution combines its software-defined datacenter (SDDC) software with Azure's global cloud platform. Use the [Govern methodology](../../govern/index.md) to incrementally improve governance of your cloud portfolio. Microsoft manages Azure VMware Solution to meet performance, availability, security, and compliance requirements. Microsoft provides the following components to run Azure VMware Solution at scale in Azure - across management systems, networking services, operating platform, and back-end infrastructure operations.

To extend your governance approach across the Azure VMware Solution, evaluate and manage risk tolerance by identifying high-risk areas for business, convert risk vectors into governing corporate policies, and extend governance policies across Cost, Security Baseline, Identity Baseline, Resource consistency, and Deployment Acceleration disciplines.

![Diagram of enterprise-scale security, governance, and compliance.](../azure-vmware/media/enterprise-scale-security-governance-compliance.png)
*Figure 1*

## Azure VMware Solution management

Azure VMware Solution is an Azure service built with VMware that delivers vSphere clusters, single-tenant, and a private cloud environment. It's accessible for users and applications from on-premises and Azure-based environments or resources. The VMware technology stack on-premises runs with a highly secure set of compute, storage, and networking technologies.

A required ExpressRoute circuit can connect to Azure Cloud Services with a dedicated private and redundant layer-3 network fiber connection that supports bandwidth up to 100 Gbps. The Azure VMware Solution also requires an Azure virtual network (VNet) to connect.

All provisioned private clouds have vCenter Server, vSAN, vSphere, and NSX-T, so you can migrate workloads from your on-premises environments, deploy new virtual machines (VMs), and consume Azure services from your private clouds.

 VMware vSphere clusters reside on top of "share nothing" hyper-converged, bare-metal infrastructure. Azure VMware cluster architecture is dedicated and isolated - meaning that networking, storage, or compute is not shared with any other tenant. VSphere clusters are managed by Microsoft to meet performance, availability, security, and compliance requirements, at scale in Azure, providing unified management, networking, and operational controls.

Because Azure VMware Solution run hybrid workloads across on-premises and private cloud, unified operations is the best approach to providing a single pane of glass for incrementally deploying required governance and operational management controls. Read [Introduction to unified operations](/azure/cloud-adoption-framework/scenarios/hybrid/unified-operations) to get started.

## Unified security and compliance

On Azure, you can run, manage, and secure applications across VMware environments with a common operating framework. Use your existing VMware tools, like VMware vSphere, vSAN, and vCenter, combined with the scale, performance, and innovation of Azure. In terms of access and security, Azure VMware Solution private clouds use vSphere role-based access control for enhanced security. You can integrate vSphere SSO LDAP capabilities with Azure Active Directory. Read more about [Access and Identity concepts](/azure/azure-vmware/concepts-identity).

Using a unified operations approach that uses familiar Azure tools to manage and govern your VMware hybrid workloads across on-premises and private cloud. Monitor, manage, and protect virtual machines in a hybrid environment (Azure, Azure VMware Solution, and on-premises). Read more about how you can [Start small with basic VM management](/azure/architecture/hybrid/azure-arc-hybrid-config?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/scenarios/hybrid/toc.json).

### Integration with Azure-native services

Integrating with Azure-native services in your Azure VMware Solution private cloud will ensure that your Azure VMware workloads benefit from unified operations best practices for governance guardrails.

**Unified VM management:** single pane of glass to manage vSphere-based and Azure native VMs, with uniform identities, access control, and monitoring.

 **Native Azure integration:** connect to Azure services endpoints. For example, deploy Azure Active Directory as VMware vCenter SSO identity source.

**Single point of support:** Azure VMware Solution is Microsoft-developed, operated, and supported. Microsoft is first and only contact and coordinates support with VMware as required.

**Unified licensing and consumption:** avoid unnecessary complexity and take confidence in managing a single vendor for licensing and resource consumption.

**Azure Hybrid Use Benefits:** maximize the value of existing Windows Server and SQL Server licenses. Save up to 80 percent with Azure Hybrid Use Benefits and Azure Reserved VM Instances.

![Diagram of enterprise-scale security, governance, and compliance.](../azure-vmware/media/on-premises-environments-Azure-private-clouds-networks-services.png)
*Figure 2*

### Unified operational management controls

We recommend a [unified operations](/azure/cloud-adoption-framework/scenarios/hybrid/unified-operations) approach, so you can extend consistent Azure governance and operational management controls across your vSphere cluster, and seamlessly modernize your VMware workloads with native Azure services.

Azure Resource Manager (ARM) is the operating system of Azure that, stretching across VMware resources, extends Azure-native governance and operational management controls across clusters, resource pools, and private clouds. For more information, see:

- [Monitor and protect VMs with Azure native services](/azure/azure-vmware/integrate-azure-native-services)
- [Integrate security solutions in Azure Security Center](/azure/azure-vmware/azure-security-integration)
- [Integrate Azure NetApp Files with Azure VMware Solution](/azure/azure-vmware/netapp-files-with-azure-vmware-solution)
- [Protect web apps on Azure VMware Solution with Azure Application Gateway](/azure/azure-vmware/protect-azure-vmware-solution-with-application-gateway)
- [Deploy Traffic Manager to balance Azure VMware Solution workloads](/azure/azure-vmware/deploy-traffic-manager-balance-workloads)
- [Configure Azure Alerts in Azure VMware Solution](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution)
- [Attach disk pools to Azure VMware Solution hosts (Preview)](/azure/azure-vmware/attach-disk-pools-to-azure-vmware-solution-hosts)
- [Back up VMware VMs with Azure Backup Server](/azure-docs/articles/backup/backup-azure-backup-server-vmware.md)
- [Prepare Azure Site Recovery resources for disaster recovery of Azure VMware Solution VMs](/azure/site-recovery/avs-tutorial-prepare-azure?context=/azure/azure-vmware/context/context)

To learn more about how Azure VMware Solution integrates with native Azure services, see [What is Azure VMware Solution](/learn/modules/intro-azure-vmware-solution/2-what-is-azure-vmware-solution)

## Governance MVP for hybrid workloads

 .

An initial governance foundation should consider:

- Hybrid and multicloud network connectivity
- Common identity management
- Integrated resource consistency, resource management, and security
- Unified operational process controls for management operations, governance, and compliance
- Unified, consistent development, and DevOps
- Azure Arc enabled resource management and governance policy enforcement

### Enterprise-scale security, governance, and compliance

These are the main focus areas of governance in an initial Azure VMware Solution implementation. For more information, see:

- [An introduction to Azure Automation](/azure/automation/automation-intro)
- [Azure subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits)
- [Perform actions using Backup center](/azure/backup/backup-center-overview)
- [Understand roles in Azure Active Directory](/azure/active-directory/roles/concept-understand-roles)
- [What is Azure AD Privileged Identity Management?](/azure/active-directory/privileged-identity-management/pim-configure)
- [Azure Monitor overview](/azure/azure-monitor/overview)
- [Create a Log Analytics workspace in the Azure portal](/azure/azure-monitor/logs/quick-create-workspace)
- [Extended Security Updates](/lifecycle/faq/extended-security-updates)
- [Security alerts and incidents in Azure Security Center](/azure/security-center/security-center-alerts-overview)
- [Identity governance and administration solutions](/azure/active-directory/governance/identity-governance-overview)

We recommend you implement an Azure VMware Solution that's secure, and that includes solid governance in your environment for the whole lifecycle. This will help your organization meet compliance requirements, and explore recommended design elements during your implementation.

For more recommendations about security, governance, and overall design, including guidance on enterprise-scale landing zone and Azure services, see [Security, governance and compliance disciplines for Azure VMware Solution](./eslz-security-governance-and-compliance.md)

## Expanding hybrid governance

For more information on how to expand your hybrid governance, see:

- [Save costs with Azure VMware Solution](./reserved-instance.md)
- [How to secure your private cloud environment](/azure/vmware-cloudsimple/private-cloud-secure?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)
- [Using Azure AD as an identify provider for vCenter on CloudSimple Private Cloud](/azure/vmware-cloudsimple/azure-ad)
- [Security Control V2: Asset Management](/security/benchmark/azure/security-controls-v2-asset-management)
- [Overview of the Azure Security Benchmark Foundation blueprint sample](/azure/governance/blueprints/samples/azure-security-benchmark-foundation/)

### Azure VMware infrastructure hybridity

VMware HCX Enterprise can speed up your organization's hybrid cloud adoption with enhanced VMware-native features that operate seamlessly on Azure.

**Accelerate cloud adoption** create application mobility across any vSphere 5.0+ version deployed on-premises and Azure VMware Solution

**Hybrid Cloud Extension** deliver multisite, WAN optimized, secured, load balanced, traffic engineered network extension

**Replicated Assisted vMotion** execute large scale bulk migrations with Zero-downtime using the HCX Interconnect appliance along with replication and vMotion technologies

**Mobility Optimized Networking** used to ensure traffic between the source datacenter and destination private cloud is optimally routed preventing asymmetric traffic flows. Scenarios include optimal VM to VM communication on extended segments and define default gateway options.

## Next steps

> [!div class="nextstepaction"]
> [Manage Azure VMware Solution](./manage.md)
