---
title: Landing zone accelerator for Azure API Management
description: The landing zone accelerator for Azure API Management is an open-source collection of Bicep templates that you can use to automate the deployment of an environment capable of hosting API Management.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Landing zone accelerator for API Management 

Landing zone accelerator for API Management provides an architectural approach and reference implementation to prepare landing zone subscriptions for a scalable API Management infrastructure. The implementation adheres to the architecture and best practices of the Cloud Adoption Framework's Azure landing zones with a focus on the design principles of enterprise-scale.

Customers adopt API Management in various ways. The construction set can be adapted to produce an architecture that fits **your** way and puts your organization on a path to sustainable scale.

## Implement a platform foundation

Landing zone accelerator for API Management assumes that a platform foundation that takes care of the shared services (network, security, identity, and governance) required to effectively construct and operationalize a landing zone has been successfully implemented. This isn't mandatory when implementing Landing zone accelerator for API Management, but it does handle much of the security and management required to safely manage your cloud environment. If you already have one, you can skip this step. For more information on this, review these articles:

- [Start with Cloud Adoption Framework enterprise-scale landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/)
- [Implement Cloud Adoption Framework enterprise-scale landing zones in Azure](/azure/cloud-adoption-framework/ready/enterprise-scale/implementation)

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

- [Identity and access management](./identity-and-access-management.md)
- [Network topology and connectivity](./network-topology-and-connectivity.md)
- [Security](./security.md)
- [Management](./management.md)
- [Governance](./governance.md)
- [Platform automation and DevOps](./platform-automation-and-devops.md)

## Example conceptual reference architecture

The following conceptual reference architecture is an example that shows design areas and best practices.

:::image type="content" source="media/landing-zone-accelerator/reference-implementation.png" alt-text="Reference implementation":::

[![Landing zone accelerator for API Management architecture](./media/landing-zone-accelerator/reference-implementation.png)](./media/landing-zone-accelerator/reference-implementation.png#lightbox)

It consists of API Management deployed in a virtual network in internal mode, fronted by an Application Gateway, with sample Azure Functions backends. 

## Deploy Landing zone accelerator for API Management

The enterprise-scale API Management reference implementation with infrastructure-as-code templates is available on [GitHub](https://github.com/cykreng/Enterprise-Scale-APIM).

## Next steps

Learn about design considerations for identity and access management in your Azure landing zones.

- [Identity and access management for API Management enterprise-scale scenario](./identity-and-access-management.md)
