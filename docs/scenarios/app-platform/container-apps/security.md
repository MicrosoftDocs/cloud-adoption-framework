---
title: Security considerations for the Azure Container Apps landing zone accelerator
description: Learn how to secure apps in Azure Container Apps.
author: craigshoemaker
ms.author: cshoe
ms.date: 10/06/2023
ms.topic: concept-article
---

# Security considerations for the Azure Container Apps - Landing Zone Accelerator

> [!IMPORTANT]
> **Deprecation notice:** This article is deprecated and is no longer being updated. To ensure only the best guidance is surfaced, this article will be deleted in May 2026.
>
> For alternative guidance, see [**Azure Container Apps**](/azure/architecture/example-scenario/serverless/microservices-with-container-apps) architecture guidance in the Azure Architecture Center.
>
> If you would like to save this guidance, you can select **Download a PDF** at the bottom left of this page or download the files from [GitHub](https://github.com/MicrosoftDocs/cloud-adoption-framework/tree/main/docs/scenarios/app-platform/container-apps).

Cloud applications often feature different layers of security to fully protect an application from attack. To decide which layers are best for your applications, review the following resources:

| Resource | Description |
|---|---|
| [Container Apps security benchmarks](/security/benchmark/azure/baselines/azure-container-apps-security-baseline) | The security baseline incorporates recommendations from the Microsoft cloud security benchmarks specifically for Azure Container Apps. This benchmark offers guidance on securing Azure cloud solutions, categorized by the defined security controls. |
| [Cloud Security Benchmark](/security/benchmark/azure/overview) | The Microsoft cloud security benchmark (MCSB) offers best practices and recommendations for enhancing security on Azure and multicloud environments. |
| [Azure Landing Zone security](/azure/cloud-adoption-framework/secure/) | The Cloud Adoption Framework offers guidance on security processes and best practices. This framework collaborates with organizations such as NIST, The Open Group, and the Center for Internet Security (CIS). |
| [Secure outbound traffic](/azure/container-apps/user-defined-routes) | You can use user-defined routes (UDR) with Azure Firewall to restrict outbound traffic from your Container Apps to Azure back-end resources or other network assets. |

## Recommendations

You can configure your Container Apps environment to accept [external](/azure/container-apps/vnet-custom) requests, or to lock down to only [internal](/azure/container-apps/vnet-custom) requests.

The Landing Zone Accelerator recommendations include:

- **Create an internal environment**: If you want to expose your application to the public web, you can use [Azure Application Gateway](/azure/application-gateway/) or [Azure Front Door](/azure/frontdoor/front-door-overview) for fine-grained security control.

- **Secure outbound traffic**: To secure outbound traffic, you can configure a route table that instructs outgoing traffic to go through an [Azure Firewall](/azure/firewall/overview) that is deployed in the Hub network.

- **Log security related activity**: Use extensive use of [observability tools](/azure/container-apps/observability) and [Log Analytics](/azure/azure-monitor/logs/log-analytics-overview) to record information on sensitive actions.

- **Security profiles**: Use the [Container Apps security profile](/security/benchmark/azure/baselines/azure-container-apps-security-baseline#security-profile) as a starting point for securing your Container Apps.
