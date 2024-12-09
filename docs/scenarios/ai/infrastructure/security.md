---
title: Security recommendations for AI workloads on Azure infrastructure (IaaS)
description: Learn how to secure AI workloads on Azure infrastructure (IaaS).
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Security recommendations for AI workloads on Azure infrastructure (IaaS)

This article provides security recommendations for organizations running AI workloads on Azure infrastructure (IaaS). Security for AI on Azure infrastructure involves protecting data, compute, and networking resources that support AI workloads. Securing these components ensures that sensitive information remains safe, minimizes exposure to potential threats, and ensures a stable operational environment for AI models and applications.

## Secure Azure services

Azure service security requires configuring each Azure service used in an AI architecture to meet specific security standards and benchmarks. To apply secure configurations to Azure services, use the [Azure security baselines](/security/benchmark/azure/security-baselines-overview) for each service in your architecture. Common Azure services in AI workloads on Azure infrastructure include: [Windows virtual machines](/security/benchmark/azure/baselines/virtual-machines-windows-virtual-machines-security-baseline), [Linux virtual machines](/security/benchmark/azure/baselines/virtual-machines-linux-virtual-machines-security-baseline), [Azure CycleCloud](/azure/cyclecloud/concepts/security-best-practices), and [Key Vault](/security/benchmark/azure/baselines/key-vault-security-baseline).

## Secure networks

Securing networks involves setting up private endpoints, Network Security Groups (NSGs), and firewalls to manage and control data flow within Azure. This step limits exposure to external threats and protects sensitive data as it moves between services within the Azure infrastructure.

- *Use private endpoints.* Use private endpoints available in [Azure Private Link](/azure/networking/fundamentals/networking-overview#privatelink) for any PaaS solution in your architecture, such as your storage or filesystem.

- *Use encrypted virtual network connections for Azure to Azure connectivity.* Encrypted connections between virtual machines or virtual machine scale sets in the same or peered virtual networks prevent unauthorized access and eavesdropping. Establish these secure connections by configuring encryption options in Azure Virtual Network for virtual machine communication.

- *Implement Network Security Groups (NSGs).* NSGs can be complex. Ensure you have a clear understanding of the NSG rules and their implications when setting up your Azure infrastructure for AI workloads.

- *Use Application Security Groups*. If you need to label traffic at a greater granularity than what virtual networks provide, consider using [Application Security Groups](/azure/virtual-network/application-security-groups).

- *Understand NSG prioritization rules*. [NSG](/azure/virtual-network/network-security-groups-overview) rules have a priority order. Understand this order to avoid conflicts and ensure the smooth running of your AI workloads.

- *Use a network firewall.* If you’re using a hub-spoke topology, deploy a [network firewall](/azure/networking/fundamentals/networking-overview#firewall) to inspect and filter network traffic between the spokes.

- *Close unused ports.* Limit internet exposure by exposing only services intended for external-facing use cases and using private connectivity for other services.

## Secure data

Securing data includes encrypting data at rest and in transit, along with protecting sensitive information such as keys and passwords. These measures ensure that data remains private and inaccessible to unauthorized users, reducing the risk of data breaches and unauthorized access to sensitive information.

- *Encrypt data*: Encrypt data at rest and in transit using strong encryption technologies between each service in the architecture.

- *Protect secrets*: Protect secrets by storing them in a key vault or a hardware security module and routinely rotate them.

## Secure access

Securing access means configuring authentication and access control mechanisms to enforce strict access permissions and verify user identities. By restricting access based on roles, policies, and multifactor authentication, organizations can limit exposure to unauthorized access and protect critical AI resources.

- *Configure authentication*: Enable multifactor authentication (MFA) and prefer secondary administrative accounts or just-in-time access for sensitive accounts. Limit control plane access using services like Azure Bastion as secure entry points into private networks.

- *Use Conditional Access Policies.* Require MFA for accessing critical AI resources to enhance security. Restrict access to AI infrastructure based on geographic locations or trusted IP ranges. Ensure that only compliant devices (those meeting security requirements) can access AI resources. Implement risk-based conditional access policies that respond to unusual sign-in activity or suspicious behavior. Use signals like user location, device state, and sign-in behavior to trigger extra verification steps.

- *Configure least privilege access.* Configure least privilege access by implementing role-based access control (RBAC) to provide minimal access to data and services. Assign roles to users and groups based on their responsibilities. Use Azure RBAC to fine-tune access control for specific resources such as virtual machines and storage accounts. Ensure users have only the minimum level of access necessary to perform their tasks. Regularly review and adjust permissions to prevent privilege creep.

## Prepare for incident response

Preparing for incident response involves collecting logs and integrating them with a Security Information and Event Management (SIEM) system. This proactive approach enables organizations to detect and respond to security incidents quickly, reducing potential damage, and minimizing downtime for AI systems.

## Secure operating systems

Securing operating systems requires keeping virtual machines and container images up-to-date with the latest patches and running antimalware software. These practices protect AI infrastructure from vulnerabilities, malware, and other security threats. They help maintain a secure and reliable environment for AI operations.

- *Patch virtual machine guests.* Regularly apply patches to virtual machines and container images. Consider enabling [automatic guest patching](/azure/virtual-machines/automatic-vm-guest-patching) for your virtual machines and scale sets.

- *Use antimalware.* Use [Microsoft Antimalware for Azure](/azure/security/fundamentals/antimalware) on your virtual machines to protect them from malicious files, adware, and other threats.

## Next step

> [!div class="nextstepaction"]
> [Govern AI](../govern.md)
