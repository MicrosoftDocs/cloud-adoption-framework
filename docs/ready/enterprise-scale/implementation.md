---
title: Implement Cloud Adoption Framework enterprise-scale landing zones in Azure
description: Review options to implement the Cloud Adoption Framework for Azure enterprise-scale architecture.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Implement Cloud Adoption Framework enterprise-scale landing zones in Azure

When business requirements necessitate a rich initial implementation of landing zones with fully integrated governance, security, and operations from the start, use the enterprise-scale example options listed here. With this approach, you can use the Azure portal or infrastructure as code to set up and configure your environment. It's also possible to transition between the portal and infrastructure as code (recommended) when your organization is ready.

## Example implementation

The following table lists example modular implementations.

| Example deployment  | Description  | GitHub repo | Deploy to Azure |
|---------|---------|---------|---------|---------|---------|---------|---------|
| Enterprise-scale foundation | This is the suggested foundation for enterprise-scale adoption. | [Example in GitHub](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/wingtip/README.md) | [Deploy example to Azure](https://ms.portal.azure.com/?feature.customportal=false#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fwingtip%2FarmTemplates%2Fes-foundation.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fwingtip%2FarmTemplates%2Fportal-es-foundation.json) |
| Enterprise-scale Virtual WAN | Add a Virtual WAN network module to the enterprise-scale foundation. | [Example in GitHub](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md) | [Deploy example to Azure](https://ms.portal.azure.com/?feature.customportal=false#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fcontoso%2FarmTemplates%2Fes-vwan.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fcontoso%2FarmTemplates%2Fportal-es-vwan.json) |
| Enterprise-scale hub and spoke | Add a hub-and-spoke network module to the enterprise-scale foundation. | [Example in GitHub](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md) | <!-- [Deploy example to Azure](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkrnese%2FAzureDeploy%2Fmaint%2FARM%2Fdeployments%2Fe2e.json) --> Coming soon |

## Next steps

These examples provide an easy deployment option to support continued learning for the enterprise-scale approach. Before you use these examples in a production version of enterprise scale, review the [enterprise-scale architecture](./architecture.md).
