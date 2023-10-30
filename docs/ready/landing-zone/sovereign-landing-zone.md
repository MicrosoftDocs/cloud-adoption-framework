---
title: Sovereignty considerations for Azure landing zones
description: Discusses the sovereign landing zone variant of the Azure landing zone architecture.
author: pikestel
ms.author: pikestel
ms.date: 09/06/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---
# Sovereignty considerations for Azure landing zones

Adopting cloud computing while meeting digital sovereignty requirements is complex and can differ greatly between organizations, industries, and geographies. [Microsoft Cloud for Sovereignty](https://aka.ms/MicrosoftCloudForSovereignty) addresses the sovereignty needs of government organizations by combining the power of the global Azure platform with several sovereignty capabilities that are designed to help mitigate sovereignty risks.

## Microsoft Cloud for Sovereignty

Microsoft Cloud for Sovereignty provides capabilities across different layers:

- Advanced sovereign control services like Azure confidential computing and Azure Key Vault Managed Hardware Security Module (Managed HSM).
- Sovereign guardrails through codified architecture, workload accelerators, localized Azure Policy initiatives, tooling, and guidance.
- Regulatory compliance and transparency into the cloud operator's activities.
- Functionality that's built on top of the Azure public cloud capabilities.

:::image type="content" source="./media/sovereign-landing-zone/sovereign-capabilities.png" alt-text="Diagram that shows the layers of capabilities of Microsoft Cloud for Sovereignty.":::

Public sector customers with sovereignty needs that want to start using Azure can accelerate the definition and deployment of a sovereign environment by using Microsoft Cloud for Sovereignty tools and guidelines, such as the sovereign landing zone (preview).

## Sovereign landing zone

The sovereign landing zone (preview) is an opinionated tailored variant of the [Azure landing zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-architecture) that's intended for organizations that need advanced sovereignty controls. A sovereign landing zone (preview) aligns Azure capabilities such as service residency, customer-managed keys, Azure Private Link, and confidential computing to create a cloud architecture where data and workloads default to encryption and protection from threats.

> [!NOTE]
> Microsoft Cloud for Sovereignty is oriented toward government organizations with sovereignty needs. Customers should carefully consider whether they need the Microsoft Cloud for Sovereignty capabilities, and only then consider adopting the sovereign landing zone (preview) architecture.

## Sovereign landing zone design areas

The Azure landing zone architecture consists of eight [design areas](/azure/cloud-adoption-framework/ready/landing-zone/design-areas). Each design area describes what to consider before you deploy a landing zone. The following sections describe additional considerations to keep in mind when you deploy the sovereign landing zone (preview).

### Resource organization

Add filler sentence.

#### "Confidential" management groups

The sovereign landing zone is a tailored version of the Azure landing zone conceptual architecture. The sovereign landing zone aligns to the guidance that's outlined in [Tailor the Azure landing zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz).

As the following diagram shows, the sovereign landing zone architecture builds on the Azure landing zone architecture:

- Under the *Landing zones* management group, the *Confidential corp* and *Confidential online* management groups are added.
- A set of specific policy initiatives, for example [Microsoft Cloud for Sovereignty policy baseline](/industry/sovereignty/policy-portfolio-baseline/#sovereignty-policy-baseline-initiatives), are also applied. These initiatives offer controls such as resource deployment location, resource deployment types, and encryption.

:::image type="content" source="./media/sovereign-landing-zone/sovereign-landing-zone-management-groups.svg" alt-text="Diagram that shows the additional management groups of a sovereign landing zone.":::

#### Microsoft Cloud for Sovereignty policy baseline

The sovereign landing zone (preview) comes with the Cloud for Sovereignty policy baseline initiatives deployed. As a result, you can deploy other policy sets within the sovereign landing zone (preview). Customers can layer additional policies on top of a sovereign landing zone (preview). Examples include Azure landing zone policies and policy sets that address control frameworks such as NIST 800-171 rev2 and Microsoft Cloud Security Benchmark.

The Cloud for Sovereignty policy baseline consists of:

- Policies to enforce the use of confidential computing resources when workloads are deployed into the confidential management groups. These policies create a platform where workloads are protected at rest, in transit, and while in use, which removes Microsoft from the trust chain.
- Location policies, which are also deployed by default to provide cloud admin control over where Azure resources can be deployed.
- Key management, which is controlled by a Federal Information Processing Standard (FIPS) 140-2 level-3 validated HSM and enforced by policy.

The policies and opinions that the sovereign landing zone (preview) adds on top of the Azure landing zone create a platform that's biased toward increased security and confidentiality by default.

For more information about the sovereignty policy baseline initiative, review the [Microsoft Cloud for Sovereignty policy portfolio](/industry/sovereignty/policy-portfolio-baseline) documentation.

### Network topology and connectivity

Add filler sentence.

#### Network traffic encryption

The sovereign landing zone (preview) focuses on operational control of data at rest, in transit, and in use. For best practices on network encryption, see [Define network encryption requirements](/azure/cloud-adoption-framework/ready/azure-best-practices/define-network-encryption-requirements).

#### Internet inbound and outbound connectivity

Similar to Azure landing zone deployments, the sovereign landing zone deployment supports:

- A parameterized deployment of the premium tier of Azure Firewall, for enabling distributed denial-of-service (DDoS) protection.
- The deployment of a central Azure Bastion infrastructure.

Before you turn on these features, consult the best practices for internet inbound and outbound connectivity in [Plan for inbound and outbound internet connectivity](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity).

### Security

Add filler sentence.

#### Azure Key Vault Managed HSM

The sovereign landing zone architecture makes use of confidential computing in the confidential landing zones. Key Vault is a necessary service for deploying confidential computing resources. For design considerations and recommendations, see [Encryption and key management in Azure](/azure/cloud-adoption-framework/ready/landing-zone/design-area/encryption-and-keys). You might need to choose Azure Key Vault Managed HSM for compliancy requirements.

#### Azure Attestation

If you use Azure confidential computing, you can take advantage of the guest attestation feature of Azure Attestation. This feature helps to confirm that a confidential VM runs on a hardware-based trusted execution environment (TEE) with security features like isolation and integrity enabled.

For more information about enabling guest attestation, see [What is guest attestation for confidential VMs?](/azure/confidential-computing/guest-attestation-confidential-vms).

### Governance

Add filler sentence.

#### Customer Lockbox for Microsoft Azure

In most cases, Microsoft personnel perform operations, support, and troubleshooting. No access to customer data is required. Occasionally, a Microsoft engineer needs to access customer data. These cases can come up in response to customer-initiated support tickets or when Microsoft identifies a problem.

In the rare circumstances when access is required, you can use Customer Lockbox for Microsoft Azure. This feature provides an interface that you can use to review and then approve or reject customer data access requests.

Consider enabling Customer Lockbox for Microsoft Azure. Enabling this option requires the Global Admin role as this is a tenant-wide setting. Further information on how to correctly set up RBAC for Customer Lockbox can be found in [Customer Lockbox for Microsoft Azure](/azure/security/fundamentals/customer-lockbox-overview).

### Platform Automation and DevOps

Add filler sentence.

#### Deployment options

The sovereign landing zone (preview) is available as a GitHub repository <https://github.com/Azure/sovereign-landing-zone> and can be deployed as a whole or on a component per component basis, which allows for integration in a customer's existing deployment workflow. Deployment guidance is located in [Key components of the sovereign landing zone preview deployment](https://github.com/Azure/sovereign-landing-zone/blob/main/docs/03-Deployment-Overview.md).

> [!NOTE]
> The sovereign landing zone (preview), being a variant of the Azure landing zone, does not yet offer all of the deployment choices that are available for the Azure landing zone architecture. Customers should follow the guidance in [Key components of the sovereign landing zone preview deployment](https://github.com/Azure/sovereign-landing-zone/blob/main/docs/03-Deployment-Overview.md).

The deployed components include:

1. Bootstrap: Sets up the management group hierarchy and creates the subscriptions as dictated by the architecture of the sovereign landing zone (preview). This is deployed under the tenant root group of the Azure customer tenant.

1. Platform: Sets up the hub network and logging resources used by the sovereign landing zone (preview) platform and workloads.

1. Compliance: Creates and assigns the default policy sets and provided custom policies, enforced in the environment.

1. Dashboard: Provides customers with a visual representation of their resource compliance.

#### Compliance dashboard

As part of the sovereign landing zone (preview) deployment, a compliance dashboard is deployed to help customers validate the sovereign landing zone (preview) against their requirements and local laws and regulations. Customers can get insight into resource level compliance against the baseline policies deployed with the sovereign landing zone (preview) as well as additional custom compliance that has been deployed. For more information, see the  [Compliance dashboard documentation](https://github.com/Azure/sovereign-landing-zone/blob/main/docs/10-Compliance-Dashboard.md).