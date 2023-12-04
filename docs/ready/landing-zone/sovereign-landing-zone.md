---
title: Sovereignty considerations for Azure landing zones
description: Learn about the sovereign landing zone variant of the Azure landing zone architecture. See how to adopt the cloud while meeting digital sovereignty requirements.
author: pikestel
ms.author: pikestel
ms.date: 11/07/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---
# Sovereignty considerations for Azure landing zones

Adopting cloud computing while meeting digital sovereignty requirements is complex and can differ greatly between organizations, industries, and geographies. [Microsoft Cloud for Sovereignty](https://aka.ms/MicrosoftCloudForSovereignty) addresses the sovereignty needs of government organizations by combining the power of the global Azure platform with several sovereignty capabilities that are designed to help mitigate sovereignty risks.

## Microsoft Cloud for Sovereignty

Microsoft Cloud for Sovereignty provides capabilities across various layers:

- Advanced sovereign control services like Azure confidential computing and Azure Key Vault Managed Hardware Security Module (Managed HSM)
- Sovereign guardrails through codified architecture, workload accelerators, localized Azure Policy initiatives, tooling, and guidance
- Regulatory compliance and transparency into the cloud operator's activities
- Functionality that's built on top of the Azure public cloud capabilities

:::image type="content" source="./media/sovereign-landing-zone/sovereignty-capabilities.png" alt-text="Diagram that shows the layers of capabilities of Microsoft Cloud for Sovereignty.":::

Public sector customers with sovereignty needs who want to start using Azure can benefit from Microsoft Cloud for Sovereignty. The tools and guidelines that Microsoft Cloud for Sovereignty provides, such as the sovereign landing zone (preview), can accelerate the definition and deployment of a sovereign environment.

## Sovereign landing zone

The sovereign landing zone (preview) is an opinionated tailored variant of the [Azure landing zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-architecture) that's intended for organizations that need advanced sovereignty controls. The sovereign landing zone (preview) aligns Azure capabilities such as service residency, customer-managed keys, Azure Private Link, and confidential computing to create a cloud architecture where data and workloads offer encryption and protection from threats by default.

> [!NOTE]
> Microsoft Cloud for Sovereignty is oriented toward government organizations with sovereignty needs. You should carefully consider whether you need the Microsoft Cloud for Sovereignty capabilities, and only then consider adopting the sovereign landing zone (preview) architecture.

## Sovereign landing zone design areas

The Azure landing zone architecture consists of eight [design areas](/azure/cloud-adoption-framework/ready/landing-zone/design-areas). Each design area describes factors to consider before you deploy a landing zone. The following sections describe additional considerations that apply when you deploy the sovereign landing zone (preview). Besides the Azure landing zone guidance, also keep these new considerations in mind.

### Resource organization

The sovereign landing zone is a tailored version of the Azure landing zone conceptual architecture. The sovereign landing zone aligns to the guidance that's outlined in [Tailor the Azure landing zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz).

##### Management groups for confidential computing

As the following diagram shows, the sovereign landing zone architecture builds on the Azure landing zone architecture:

- Under the *Landing zones* management group, the *Confidential corp* and *Confidential online* management groups are added.
- A set of specific policy initiatives, for example, [Microsoft Cloud for Sovereignty policy baseline](/industry/sovereignty/policy-portfolio-baseline/#sovereignty-policy-baseline-initiatives), are also applied. These initiatives offer controls such as resource deployment location, resource deployment types, and encryption.

:::image type="content" source="./media/sovereign-landing-zone/sovereign-landing-zone-management-groups.svg" alt-text="Diagram that shows the management groups of a sovereign landing zone." lightbox="./media/sovereign-landing-zone/sovereign-landing-zone-management-groups.svg":::

*Download a [Visio file](https://github.com/microsoft/CloudAdoptionFramework/raw/master/ready/sovereign-landing-zone-management-groups.vsdx) of this architecture.*

##### Microsoft Cloud for Sovereignty policy baseline

The sovereign landing zone (preview) comes with the Microsoft Cloud for Sovereignty policy baseline initiatives deployed. As a result, you can deploy other policy sets within the sovereign landing zone (preview). You can layer extra policies on top of the sovereign landing zone (preview). Examples include Azure landing zone policies and policy sets that address control frameworks such as National Institute of Standards and Technology (NIST) 800 171 Revision 2 and Microsoft Cloud Security Benchmark.

The Microsoft Cloud for Sovereignty policy baseline consists of:

- Policies to enforce the use of confidential computing resources when workloads are deployed into the confidential management groups. These policies help create a platform where workloads are protected at rest, in transit, and while in use, which removes Microsoft from the trust chain.
- Location policies, which are also deployed by default to provide cloud admin control over where Azure resources can be deployed.
- Key management, which is controlled by a Federal Information Processing Standard (FIPS) 140-2 level-3 validated HSM and enforced by policy.

The policies and opinions that the sovereign landing zone (preview) adds on top of the Azure landing zone create a platform that's biased toward increased security and confidentiality by default.

For more information about the sovereignty policy baseline initiative, review the [Microsoft Cloud for Sovereignty policy portfolio](/industry/sovereignty/policy-portfolio-baseline) documentation.

### Network topology and connectivity

The sovereign landing zone (preview) focuses on operational control of data at rest, in transit, and in use.

##### Network traffic encryption

For best practices for network encryption, see [Define network encryption requirements](/azure/cloud-adoption-framework/ready/azure-best-practices/define-network-encryption-requirements).

##### Internet inbound and outbound connectivity

Similar to Azure landing zone deployments, the sovereign landing zone deployment supports:

- A parameterized deployment of the premium tier of Azure Firewall, for enabling distributed denial-of-service (DDoS) protection.
- The deployment of a central Azure Bastion infrastructure.

Before you turn on these features, consult the best practices for internet inbound and outbound connectivity in [Plan for inbound and outbound internet connectivity](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity).

### Security

The sovereign landing zone architecture makes use of confidential computing in the confidential landing zones. The following sections describe services that provide support for Azure confidential computing.

##### Azure Key Vault Managed HSM

Key Vault is a necessary service for deploying confidential computing resources. For design considerations and recommendations, see [Encryption and key management in Azure](/azure/cloud-adoption-framework/ready/landing-zone/design-area/encryption-and-keys). You might need to choose Azure Key Vault Managed HSM for compliancy requirements.

##### Azure Attestation

If you use Azure confidential computing, you can take advantage of the guest attestation feature of Azure Attestation. This feature helps to confirm that a confidential VM runs on a hardware-based trusted execution environment (TEE) with security features like isolation and integrity enabled.

For more information about enabling guest attestation, see [What is guest attestation for confidential VMs?](/azure/confidential-computing/guest-attestation-confidential-vms).

### Governance

In most cases, Microsoft personnel perform operations, support, and troubleshooting, and no access to customer data is required. Occasionally, a Microsoft engineer needs to access customer data. These cases can come up in response to customer-initiated support tickets or when Microsoft identifies a problem.

##### Customer Lockbox for Microsoft Azure

In the rare circumstances when access is required, you can use Customer Lockbox for Microsoft Azure. This feature provides an interface that you can use to review and then approve or reject customer data access requests.

Consider enabling Customer Lockbox. You need to have a Global Admin role to turn on this feature, because it's a tenant-wide setting. For more information about how to correctly set up role-based access control for Customer Lockbox, see [Customer Lockbox for Microsoft Azure](/azure/security/fundamentals/customer-lockbox-overview).

### Platform automation and DevOps

The sovereign landing zone (preview) is available as a [GitHub repository](https://github.com/Azure/sovereign-landing-zone).

##### Deployment options

You can deploy the entire landing zone, or you can deploy one component at a time. When you deploy individual components, you can integrate them into your existing deployment workflow. For deployment guidance, see [Key components of the sovereign landing zone preview deployment](https://github.com/Azure/sovereign-landing-zone/blob/main/docs/03-Deployment-Overview.md).

> [!NOTE]
> The sovereign landing zone (preview) is a variant of the Azure landing zone. But the sovereign landing zone doesn't yet offer all the deployment choices that are available for the Azure landing zone architecture. For information about deploying a sovereign landing zone, see [Key components of the sovereign landing zone preview deployment](https://github.com/Azure/sovereign-landing-zone/blob/main/docs/03-Deployment-Overview.md).

The GitHub repository includes the following sovereign landing zone (preview) components:

- Bootstrap: Sets up the management group hierarchy and creates the subscriptions as dictated by the architecture of the sovereign landing zone (preview). These elements are deployed under the tenant root group of the Azure customer tenant.

- Platform: Sets up the hub network and the logging resources that are used by the sovereign landing zone (preview) platform and workloads.

- Compliance: Creates and assigns the default policy sets and the custom policies that are enforced in the environment.

- Dashboard: Provides you with a visual representation of your resource compliance.

##### Compliance dashboard

A compliance dashboard is deployed as part of the sovereign landing zone (preview) deployment. This dashboard helps you validate the sovereign landing zone (preview) against your requirements and local laws and regulations. Specifically, the dashboard gives you insight into resource-level compliance against:

- The baseline policies that are deployed with the sovereign landing zone (preview).
- Other custom compliance that has been deployed.

For more information, see the [Compliance dashboard documentation](https://github.com/Azure/sovereign-landing-zone/blob/main/docs/10-Compliance-Dashboard.md).
