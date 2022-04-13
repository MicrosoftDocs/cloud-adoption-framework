---
title: Landing zone accelerator for Azure API Management
description: <<Describe how Landing zone accelerator for <<Token-LongName>> can accelerate adoption of Azure API Management.>>
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Landing zone accelerator for API Management 

The Landing zone accelerator for API Management set is an open-source collection of Terraform templates that you can use to automate the deployment of an environment capable of hosting API management. It can provide a specific architectural approach and reference implementation to prepare your enterprise-scale landing zones. The landing zones adhere to the architecture and best practices of the Cloud Adoption Framework.

Customers adopt API Managemen t in various ways. The construction set can be adapted to produce an architecture that fits **your** way and puts your organization on a path to sustainable scale.

## Implement a platform foundation

Landing zone accelerator for API Management assumes that a platform foundation that takes care of the shared services (network, security, identity, and governance) required to effectively construct and operationalize a landing zone has been successfully implemented. This isn't mandatory when implementing Landing zone accelerator for API Management, but it does handle much of the security and management required to safely manage your cloud environment. If you already have one, you can skip this step. For more information on this, review these articles:

- [Start with Cloud Adoption Framework enterprise-scale landing zones](../../ready/enterprise-scale/index.md)
- [Implement Cloud Adoption Framework enterprise-scale landing zones in Azure](../../ready/enterprise-scale/implementation.md)

## What Landing zone accelerator for API Management provides

The Landing zone accelerator approach to landing zones provides these assets to support your project:

- A modular approach, so that you can customize environment variables
- Design guidelines to aid in evaluating critical decisions
- The landing zone architecture
- An implementation that includes:
  - A deployable reference capable of creating the environment for your API Management deployment
  - A Microsoft-approved API Management reference implementation to test the deployed environment

## Design guidelines

These articles provide guidelines for creating your landing zone:

- [Azure Billing and Active Directory Tenant](./azure-billing-ad-tenant.md)
- [Identity and access management](./identity-and-access-management.md)
- [Network topology and connectivity](./network-topology-and-connectivity.md)
- [Resource organization](./resource-organization.md)
- [Security](./apim-security.md)
- [Management](./management.md)
- [Governance](./governance.md)
- [Platform automation and DevOps](./platform-automation-and-devops.md)

## Example conceptual reference architecture

The following conceptual reference architecture is an example that shows design areas and best practices.

TODO: Include RA image here
TODO: Once a reference architecture for this Landing zone accelerator has been published to Azure Architecture Center, include a link & reference here.

## Deploy Landing zone accelerator for API Management

The <<Token-LongName>> construction set is available here...
TODO: Once a reference implementation for this Landing zone accelerator has been published to Azure Architecture Center, include a link & reference here.

## Next steps

- Review the API Management construction set critical design areas to make complete considerations and recommendations for your API Management construction set architecture. See [<<Token-LongName>> enterprise-scale scenario](./eslz-identity-and-access-management.md).
