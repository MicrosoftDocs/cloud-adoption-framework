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

## Microsoft Cloud for Sovereignty

Adopting cloud computing while meeting digital sovereignty requirements is complex and can differ greatly between organizations, industries, and geographies. [Microsoft Cloud for Sovereignty](https://aka.ms/MicrosoftCloudForSovereignty) addresses the sovereignty needs of government organizations by combining the power of the global Azure platform with several sovereignty capabilities that are designed to help mitigate sovereignty risks.

Microsoft Cloud for Sovereignty provides capabilities across different layers:

* Advanced sovereign control services like Azure Confidential Computing and Managed Hardware Security Module (HSM).
* Sovereign guardrails through codified architecture, workload accelerators, localized Azure Policy Initiatives, tooling, and guidance.
* Regulatory compliance and transparency into the cloud operator's activities.
* Built on top of the Azure public cloud capabilities.

![Diagram that shows layers of Microsoft Cloud for Sovereignty](./media/sovereign-landing-zone/sovereignLandingZone-managementGroups.png)

Public sector customers with sovereignty needs that want to start using Azure can accelerate the definition and deployment of a sovereign environment using Microsoft Cloud for Sovereignty tools and guidelines, such as the sovereign landing zone (preview).

## Sovereign landing zone

The sovereign landing zone (preview) is an opinionated tailored variant of the [Azure landing zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-architecture) and is intended for organizations that need advanced sovereignty controls. A sovereign landing zone (preview) aligns Azure capabilities such as service residency, customer-managed keys, Azure Private Link, and confidential computing to create a cloud architecture where data and workloads default to encryption and protection from threats.

> [!NOTE]
> Microsoft Cloud for Sovereignty is oriented towards government organizations with sovereignty needs. Customers should carefully consider whether they need the Microsoft Cloud for Sovereignty capabilities, and only then consider adopting the sovereign landing zone (preview) architecture.

## Sovereign landing zone design areas

The Azure landing zone architecture consists of 8 [design areas](/azure/cloud-adoption-framework/ready/landing-zone/design-areas). Each design area describes what to consider before deploying a landing zone. The following sections specifically describe the additional considerations when deploying the sovereign landing zone (preview) on top of what Azure landing zones already advises.

### Resource organization

##### "Confidential" management groups

The sovereign landing zone is a tailored version of the Azure landing zone conceptual architecture, and aligns to the guidance as outlined in [Tailor the Azure landing zone architecture](/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)

Building on the Azure landing zone architecture, from a management group organization perspective, "Confidential Corp" and "Confidential Online" management groups are added under the "Landing Zones" Management Group. A set of specific policy initiatives, for example [Microsoft Cloud for Sovereignty policy baseline](/industry/sovereignty/policy-portfolio-baseline/#sovereignty-policy-baseline-initiatives), are also applied that offer controls such as resource deployment location, resource deployment types, encryption, etc.

![Diagram that shows additional management groups of a sovereign landing zone.](./media/sovereign-landing-zone/sub-organization-slz.png)

##### Microsoft Cloud for Sovereignty policy baseline

The sovereign landing zone (preview) comes with the Sovereignty policy baseline initiatives deployed, enabling other policy sets to be deployed within the sovereign landing zone (preview). Customers can layer additional policies on top of a sovereign landing zone (preview), for example Azure landing zone policies and policy sets that address control frameworks such as NIST 800-171 rev2 and Microsoft Cloud Security Benchmark.

The Sovereignty policy baseline consists of:

* Policies to enforce the use of confidential computing resources when workloads are deployed into the confidential management groups. These policies create a platform where workloads are protected at rest, in transit, and while in use, removing Microsoft from the trust chain.
* Location policies are also deployed by default to provide cloud admin control over where Azure resources can be deployed.
* Key management is controlled by a FIPS 140-2 Level 3 validated HSM and enforced by policy.

The policies and opinions that the sovereign landing zone (preview) layers on top of the Azure landing zone create a platform that is biased towards increased security and confidentiality by default.

For more information on the sovereignty policy baseline initiative, review the documentation [Microsoft Cloud for Sovereignty policy portfolio](/industry/sovereignty/policy-portfolio-baseline)

### Network topology and connectivity

##### Network traffic encryption

The sovereign landing zone (preview) focuses on operational control of data at rest, in transit, and in use. Customers should consider following best practices on network encryption as described in [Define network encryption requirements](/azure/cloud-adoption-framework/ready/azure-best-practices/define-network-encryption-requirements)

##### Internet inbound and outbound connectivity

Similar to Azure landing zone deployments, The sovereign landing zone deployment allows for parameterized deployment of Azure Firewall premium, for enabling DDoS protection, and for deploying a central Azure bastion infrastructure.

Customers should consult the best practices on internet inbound and outbound connectivity found [Plan for inbound and outbound internet connectivity](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity) before enabling those features.

### Security

##### Azure Key Vault managed HSM

The sovereign landing zone architecture leverages the use of confidential computing in the confidential landing zones. Azure Key Vault is a necessary service for deploying confidential computing resources. Customers are encouraged to consult the design considerations and recommendations found at [Encryption and key management in Azure](/azure/cloud-adoption-framework/ready/landing-zone/design-area/encryption-and-keys), and may have to choose Azure Key Vault Managed HSM for compliancy requirements.

##### Azure Attestation

Customers using Azure confidential computing may want to leverage Azure Attestation by enabling guest attestation. The guest attestation feature helps to confirm that a confidential VM runs on a hardware-based trusted execution environment (TEE) with security features (isolation, integrity) enabled.

For more information enabling guest attestation, review the documentation [What is guest attestation for confidential VMs? \|  Microsoft Learn](/azure/confidential-computing/guest-attestation-confidential-vms)

### Governance

##### Customer Lockbox for Microsoft Azure

Most operations, support, and troubleshooting performed by Microsoft personnel and sub-processors don't require access to customer data. In those rare circumstances where such access is required, Customer Lockbox for Microsoft Azure provides an interface for customers to review and approve or reject customer data access requests. It's used in cases where a Microsoft engineer needs to access customer data, whether in response to a customer-initiated support ticket or a problem identified by Microsoft.

Consider enabling Customer Lockbox for Microsoft Azure. Enabling this option requires the Global Admin role as this is a tenant-wide setting. Further information on how to correctly set up RBAC for Customer Lockbox can be found in [Customer Lockbox for Microsoft Azure](/azure/security/fundamentals/customer-lockbox-overview).

### Platform Automation and DevOps

##### Deployment options

The sovereign landing zone (preview) is available as a GitHub repository <https://github.com/Azure/sovereign-landing-zone> and can be deployed as a whole or on a component per component basis, which allows for integration in a customer's existing deployment workflow. Deployment guidance is located in [Key components of the sovereign landing zone preview deployment](https://github.com/Azure/sovereign-landing-zone/blob/main/docs/03-Deployment-Overview.md).

> [!NOTE]
> The sovereign landing zone (preview), being a variant of the Azure landing zone, does not yet offer all of the deployment choices that are available for the Azure landing zone architecture. Customers should follow the guidance in [Key components of the sovereign landing zone preview deployment](https://github.com/Azure/sovereign-landing-zone/blob/main/docs/03-Deployment-Overview.md).

The deployed components include:

1. Bootstrap: Sets up the management group hierarchy and creates the subscriptions as dictated by the architecture of the sovereign landing zone (preview). This is deployed under the tenant root group of the Azure customer tenant.

2. Platform: Sets up the hub network and logging resources used by the sovereign landing zone (preview) platform and workloads.

3. Compliance: Creates and assigns the default policy sets and provided custom policies, enforced in the environment.

4. Dashboard: Provides customers with a visual representation of their resource compliance.

##### Compliance dashboard

As part of the sovereign landing zone (preview) deployment, a compliance dashboard is deployed to help customers validate the sovereign landing zone (preview) against their requirements and local laws and regulations. Customers can get insight into resource level compliance against the baseline policies deployed with the sovereign landing zone (preview) as well as additional custom compliance that has been deployed. For more details, see the  [Compliance dashboard documentation](https://github.com/Azure/sovereign-landing-zone/blob/main/docs/10-Compliance-Dashboard.md).