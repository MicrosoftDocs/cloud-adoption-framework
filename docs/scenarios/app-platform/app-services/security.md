---
title: Security considerations for Azure App Service
description: Learn about design considerations and recommendations for security in the Azure App Service landing zone accelerator
author: martinekuan
ms.author: martinek
ms.date: 03/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Security considerations for the Azure App Service landing zone accelerator

This article provides design considerations and recommendations for security when using the Azure App Service landing zone accelerator. Security covers multiple aspects including securing application secrets, network isolation, and vulnerability scanning.

Learn more about the [security](../../../ready/landing-zone/design-area/security.md) design area.

## Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service:

- Review your security requirements to determine if they allow your web applications to be run on shared network infrastructure or if they require the complete network/virtual machine isolation available with [App Service Environments](/azure/app-service/environment/overview).
- Evaluate the security of your software supply chain and determine the tools and processes in place to automatically patch application dependency vulnerabilities and reliably deploy them into your environment.

## Design recommendations

The following is a bulleted list of things you must think about when preparing for **any** deployment of App Service:

- Store application secrets (database credentials, API tokens, private keys) in Azure Key Vault and configure your App Service app to access them securely with a Managed Identity.  Determine [when to use Azure Key Vault vs Azure App Configuration](/azure/architecture/solution-ideas/articles/appconfig-key-vault) with the guidance in mind.
- [Enable Cross-Origin Resource Sharing (CORS)](/azure/app-service/app-service-web-tutorial-rest-api#enable-cors) within App Services or using your own CORS utilities to indicate which origins the user’s browser should permit resources to be loaded from.
- When deploying containerized web applications to App Services, [enable Azure Defender for container registries](/azure/security-center/defender-for-container-registries-introduction) to automatically scan images for vulnerabilities.
- Enable [Azure Defender for App Service](/azure/security-center/defender-for-app-service-introduction#:~:text=%20When%20you%20enable%20Azure%20Defender%20for%20App,App%20Service%20resources%20by%20monitoring%3A%0Athe%20VM...%20More%20) to assess the security of your web applications and detect threats to your App Service resources.
- Use [Private Endpoint](/azure/private-link/private-endpoint-overview) to privately access [Azure services](/azure/private-link/availability) through your VNet.
