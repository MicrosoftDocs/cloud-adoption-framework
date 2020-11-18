---
title: "Manage unified operations"
description: Describe the scenario's impact on operations management
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Manage unified operations

Describe how your scenario changes operations management

## unified operations business alignment

Does this scenario require the customer to rethink business alignment or how the platform is supported in operations management?

## unified operations operations baseline

Does this workload have special requirements for Visibility, Operational Compliance, or BCDR?

## unified operations platform operations


### Azure Arc enabled Servers - Day-2 Scenarios & Use-Cases

Once you have server resources projected into Azure with Azure Arc, you can start to use native Azure tooling to manage the servers as native Azure resources. The following guides show examples of using Azure management tools such as resource tags, Azure Policy, Log Analytics, and more with Azure Arc enabled servers.

* [Tagging and querying server inventory across multiple clouds using Resource Graph Explorer](azure_arc_servers_jumpstart/docs/arc_inventory_tagging.md)

* [Deploying Microsoft Monitoring Agent Extension (MMA) to Azure Arc Linux and Windows VMs using Extension Management](azure_arc_servers_jumpstart/docs/arc_vm_extension_mma_arm.md)

* [Deploying Custom Script Extension to Azure Arc Linux and Windows VMs using Extension Management](azure_arc_servers_jumpstart/docs/arc_vm_extension_customscript_arm.md)

* [Deploying Microsoft Monitoring Agent Extension (MMA) to Azure Arc Linux and Windows VMs using Azure Policies](azure_arc_servers_jumpstart/docs/arc_policies_mma.md)
 
* [Integrate Azure Security Center with Azure Arc enabled Servers](azure_arc_servers_jumpstart/docs/arc_securitycenter.md)

* [Integrate Azure Sentinel with Azure Arc enabled Servers](azure_arc_servers_jumpstart/docs/arc_azuresentinel.md)

### Azure Arc enabled Servers - Scaled Deployment Scenarios

The following guides are designed to provide scaled onboarding experience to Azure Arc of virtual machines deployed in various platforms and existing environments.

 * [Scaled Onboarding VMware vSphere Windows Server VMs to Azure Arc](azure_arc_servers_jumpstart/docs/vmware_scaled_powercli_win.md)

 * [Scaled Onboarding VMware vSphere Linux VMs to Azure Arc](azure_arc_servers_jumpstart/docs/vmware_scaled_powercli_linux.md)

 * [Scaled Onboarding AWS EC2 instances to Azure Arc using Ansible](azure_arc_servers_jumpstart/docs/aws_scale_ansible.md)

### Azure Arc enabled SQL Server

The deployment scenarios below will guide you through onboarding Microsoft SQL Server, deployed on various platform to Azure Arc. 

## unified operations workload operations

Are there specific requirements for operations of the individual workloads running on this platform?

## Next step: Your next migration iteration

Once the unified operations migration is complete, the cloud adoption team can begin your next scenario-specific migration. Alternatively, if there are addition platforms to be migrated, this article series can be used again to guide your next unified operations migration or deployment.

- [Strategy for unified operations](./strategy.md)
- [Plan for unified operations](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Assess for unified operations migration](./migrate-assess.md)
- [Migrate unified operations](./migrate-deploy.md)
- [Release unified operations to production](./migrate-release.md)
- [Innovate with unified operations](./innovate.md)
- [Govern unified operations](./govern.md)
- [Manage unified operations](./manage.md)
