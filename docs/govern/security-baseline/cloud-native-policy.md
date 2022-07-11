---
title: Cloud-native Security Baseline policy
description: See a sample cloud-native policy for the Security Baseline discipline, in which Azure tools and platforms are sufficient to manage business risks.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Cloud-native Security Baseline policy

The [Security Baseline discipline](./index.md) is one of the [Five Disciplines of Cloud Governance](../governance-disciplines.md). This discipline focuses on general security topics including protection of the network, digital assets, and data. This article discusses a cloud-native sample policy for the Security Baseline discipline.

> [!NOTE]
> Microsoft is in no position to dictate corporate or IT policy. This article will help you prepare for an internal policy review. It's assumed that this sample policy will be extended, validated, and tested against your corporate policy before attempting to use it. Any use of this sample policy as-is is discouraged.

## Policy alignment

This sample policy synthesizes a cloud-native scenario, meaning that the tools and platforms provided by Azure are sufficient to manage business risks involved in a deployment. In this scenario, it's assumed that a simple configuration of the default Azure services provides sufficient asset protection.

## Cloud security and compliance

Security is integrated into every aspect of Azure, offering unique security advantages derived from global security intelligence, sophisticated customer-facing controls, and a secure, hardened infrastructure. This powerful combination helps protect your applications and data, support your compliance efforts, and provide cost-effective security for organizations of all sizes. This approach creates a strong starting position for any security policy, but does not negate the need for equally strong security practices related to the security services being used.

### Built-in security controls

It's hard to maintain a strong security infrastructure when security controls are not intuitive and need to be configured separately. Azure includes built-in security controls across a variety of services that help you protect data and workloads quickly and manage risk across hybrid environments. Integrated partner solutions also let you easily transition existing protections to the cloud.

### Cloud-native identity policies

Identity is becoming the new boundary control plane for security, taking over that role from the traditional network-centric perspective. Network perimeters have become increasingly porous and that perimeter defense cannot be as effective as it was before the advent of bring your own device (BYOD) and cloud applications. Azure identity management and access control enable seamless secure access to all your applications.

A sample cloud-native policy for identity across cloud and on-premises directories, could include requirements like the following:

- Authorized access to resources with Azure role-based access control (Azure RBAC), multifactor authentication, and single sign-on (SSO).
- Quick mitigation of user identities suspected of compromise.
- Just-in-time (JIT), just-enough access granted on a task-by-task basis to limit exposure of overprivileged admin credentials.
- Extended user identity and access to policies across multiple environments through Azure Active Directory.

While it's important to understand the [Identity Baseline discipline](../identity-baseline/index.md) in the context of the Security Baseline discipline, the [Five Disciplines of Cloud Governance](../index.md) treats it as a separate discipline.

### Network access policies

Network control includes the configuration, management, and securing of network elements such as virtual networking, load balancing, DNS, and gateways. The controls provide a means for services to communicate and interoperate. Azure includes a robust and secure networking infrastructure to support your application and service connectivity requirements. Network connectivity is possible between resources located in Azure, between on-premises and Azure hosted resources, and to and from the internet and Azure.

A cloud-native policy for network controls may include requirements like the following:

- Hybrid connections to on-premises resources, might not be allowed in a cloud-native policy. Should a hybrid connection prove necessary, a more robust enterprise security policy sample would be a more relevant reference.
- Users can establish secure connections to and within Azure using virtual networks and network security groups.
- The native Windows Azure Firewall protects hosts from malicious network traffic by limiting port access. A good example of this policy is a requirement to block or not enable traffic directly to a VM over SSH/RDP.
- Services like the Azure Web Application Firewall (WAF) on Azure Application Gateway and Azure DDoS Protection safeguard applications and ensure availability for virtual machines running in Azure. These features should not be disabled.

### Data protection

One of the keys to data protection in the cloud is accounting for the possible states in which your data may occur, and what controls are available for each state. For the purpose of Azure data security and encryption best practices, recommendations focus on the following data states:

- Data encryption controls are built into services from virtual machines to storage and SQL Database.
- As data moves between clouds and customers, it can be protected using industry-standard encryption protocols.
- Azure Key Vault enables users to safeguard and control cryptographic keys, passwords, connection strings and certificates used by cloud applications and services.
- Azure Information Protection will help classify, label, and protect your sensitive data within applications.

While these features are built into Azure, each of the above requires configuration and could increase costs. Alignment of each cloud-native feature with a [data classification strategy](../policy-compliance/data-classification.md) is highly suggested.

### Security monitoring

Security monitoring is a proactive strategy that audits your resources to identify systems that do not meet organizational standards or best practices. Microsoft Defender for Cloud provides unified security baseline and Microsoft Defender for Identity across hybrid cloud workloads. With Defender for Cloud, you can apply security policies across your workloads, limit your exposure to threats, and detect and respond to attacks, including:

- Unified view of security across all on-premises and cloud workloads with Microsoft Defender for Cloud.
- Continuous monitoring and security assessments to ensure compliance and remediate any vulnerabilities.
- Interactive tools and contextual threat intelligence for streamlined investigation.
- Extensive logging and integration with existing security information.
- Reduces the need for expensive, nonintegrated, one off security solutions.

### Extend cloud-native policies

Using the cloud can reduce some of the security burden. Microsoft provides physical security for Azure datacenters and helps protect the cloud platform against infrastructure threats such as a DDoS attack. Given that Microsoft has thousands of cybersecurity specialists working on security every day, the resources to detect, prevent, or mitigate cyberattacks are considerable. In fact, while organizations used to worry about whether the cloud was secure, most now understand that the level of investment in people and specialized infrastructure made by vendors like Microsoft makes the cloud more secure than most on-premises datacenters.

Even with this investment in a cloud-native security baseline, it's suggested that any Security Baseline policy extend the default cloud-native policies. The following are examples of extended policies that should be considered, even in a cloud-native environment:

- **Secure VMs.** Security should be every organization's top priority, and doing it effectively requires several things. You must assess your security state, protect against security threats, and then detect and respond rapidly to threats that occur.
- **Protect VM contents.** Setting up regular automated backups is essential to protect against user errors. This isn't enough, though; you must also make sure that your backups are safe from cyberattacks and are available when you need them.
- **Monitor applications.** This pattern encompasses several tasks, including getting insight into the health of your VMs, understanding interactions among them, and establishing ways to monitor the applications these VMs run. All of these tasks are essential in keeping your applications running around the clock.
- **Secure and audit data access.** Organizations should audit all data access and use advanced machine learning capabilities to call out deviations from regular access patterns.
- **Failover practice.** Cloud operations that have low tolerances for failure must be capable of failing over or recovering from a cybersecurity or platform incident. These procedures must not simply be documented, but should be practiced quarterly.

## Next steps

Now that you've reviewed the sample Security Baseline policy for cloud-native solutions, return to the policy review guide to start building on this sample to create your own policies for cloud adoption.

> [!div class="nextstepaction"]
> [Build your own policies using the policy review guide](../policy-compliance/cloud-policy-review.md)
