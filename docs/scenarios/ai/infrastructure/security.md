---
title: Security for AI on Azure infrastructure
description: Discover how to build AI applications on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Security for AI on Azure infrastructure

AI workload combine data, storage, networking, and compute infrastructure used to generate and host models. It’s recommended to evaluate security from the viewpoint of the wholistic system as well as the individual components that comprise the whole. To secure your AI infrastructure, follow these recommendations:

## Secure Azure services

- *Apply secure configurations to Azure services.* Follow the [Azure security baselines](/azure/security/benchmark/azure/security-baselines-overview) for each service in your architecture. Common Azure services in AI workloads on Azure infrastructure include:
	- [Windows](/azure/security/benchmark/azure/baselines/virtual-machines-windows-virtual-machines-security-baseline) and [Linux](/azure/security/benchmark/azure/baselines/virtual-machines-linux-virtual-machines-security-baseline) Azure Virtual Machines
	- [Azure CycleCloud](/azure/cyclecloud/concepts/security-best-practices)
	- Virtual Machine Scale Sets
	- Azure Managed Lustre File System
	- Azure NetApp Files
	- Azure Kubernetes Service
	- Azure Database for MySQL
	- [Key Vault](/azure/security/benchmark/azure/baselines/key-vault-security-baseline)

## Secure networks

- *Use private endpoints.* Use private endpoints available in [Azure Private Link](/azure/networking/fundamentals/networking-overview#privatelink) for any PaaS solution in your architecture, such as your storage or filesystem.
- *Implement Network Security Groups (NSGs).* NSGs can be complex. Ensure you have a clear understanding of the NSG rules and their implications when setting up your Azure infrastructure for AI workloads.
- *Use Application Security Groups*. If you need to label traffic at a greater granularity than what virtual networks provide, consider using [Application Security Groups](/azure/virtual-network/application-security-groups). This can be useful when managing traffic for specific AI workloads.
- *Understand NSG prioritization rules*. [NSG](/azure/virtual-network/network-security-groups-overview) rules have a priority order. Understand this order to avoid conflicts and ensure the smooth running of your AI workloads.
- *Use a network firewall.* If you’re using a hub-spoke topology, deploy a [network firewall](/azure/networking/fundamentals/networking-overview#firewall) to inspect and filter network traffic between the spokes.
- *Close unused ports.* Limit internet exposure by exposing only services intended for external-facing use cases and using private connectivity for other services.

## Secure data

- *Encrypt data*: Encrypt data at rest and in transit using strong encryption technologies between each service in the architecture.
- *Protect secrets*: Protect secrets by storing them in a key vault or HSM and routinely rotating them.

## Secure access

- *Configure authentication*: Enable multi-factor authentication (MFA) and prefer secondary administrative accounts or just-in-time access for sensitive accounts. Limit control plane access using services like Azure Bastion as secure entry points into private networks.
- *Use Conditional Access Policies.* Require MFA for accessing critical AI resources to enhance security. Restrict access to AI infrastructure based on geographic locations or trusted IP ranges. Ensure that only compliant devices (those meeting security requirements) can access AI resources. Implement risk-based conditional access policies that respond to unusual sign-in activity or suspicious behavior. Use signals like user location, device state, and sign-in behavior to trigger additional verification steps.
- *Configure least privilege access.* Configure least privilege access by implementing Role-Based Access Control (RBAC) to provide minimal access to data and services. Assign roles to users and groups based on their responsibilities. Use Azure RBAC to fine-tune access control for specific resources such as virtual machines and storage accounts. Ensure users have only the minimum level of access necessary to perform their tasks. Regularly review and adjust permissions to prevent privilege creep. For example,
	- *Data Scientists* should have read/write access to data storage, permission to run training jobs, and access to model training environments.
	- *AI Developers* should have access to development environments, deployment permissions, and the ability to modify AI applications.
	- *IT Administrators* should have full access to manage infrastructure, network configurations, and security policies.

## Prepare for incident response

- *Collect logs.* Implement logging and integrate with a Security Information and Event Management (SIEM) system to detect, analyze, and respond to threats.

## Secure operating systems

- *Patch VM guests.* Regularly apply patches to virtual machines and container images. Consider enabling [automatic guest patching](/azure/virtual-machines/automatic-vm-guest-patching) for your virtual machines and scale sets.
- *Use antimalware.* Use [Microsoft Antimalware for Azure](/azure/security/fundamentals/antimalware) on your virtual machines to protect them from malicious files, adware, and other threats.