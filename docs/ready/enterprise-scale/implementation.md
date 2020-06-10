---
title: Enterprise-scale implementation
description: Options to implement the enterprise-scale architecture
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Implement enterprise-scale Azure landing zones

When business requirements necessitate a rich initial implementation of landing zones, with fully integrated governance, security, and operations from the start, Microsoft suggests using the enterprise-scale example options shown here. This approach assumes existing skills in Azure platform automation, experience with GitHub, and deployment of Azure Pipelines via GitHub Actions. This approach will also implement opinionated options for platform automation, governance, security, and operations.

## Example implementation

The following table shows each of the modular implementations.

| Example deployment  | Description  | GitHub repo | Deploy to Azure |
|---------|---------|---------|---------|---------|---------|---------|---------|
| Enterprise-scale foundation | This is the suggested foundation for enterprise-scale adoption. | [Example in GitHub](https://github.com/Azure/CET-NorthStar/tree/master/examples/NorthStar-foundation) | [Deploy example to Azure](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkrnese%2FAzureDeploy%2Fmaster%2FARM%2Fdeployments%2Fe2e.json) |
| Enterprise-scale Virtual WAN | Add a Virtual WAN network module to the enterprise-scale foundation. | [Example in GitHub](https://github.com/Azure/CET-NorthStar/tree/master/examples/NorthStar-VWAN) | [Deploy example to Azure](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkrnese%2FAzureDeploy%2Fmaster%2FARM%2Fdeployments%2Fe2e.json) |
| Enterprise-scale hub and spoke | Add a hub and spoke network module to the enterprise-scale foundation. | [Example in GitHub](https://github.com/Azure/CET-NorthStar/tree/master/examples/NorthStar-foundation) | [Deploy example to Azure](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkrnese%2FAzureDeploy%2Fmaster%2FARM%2Fdeployments%2Fe2e.json) |
| CAF migration landing zone sample | Deploy a CAF migration landing zone using the enterprise-scale deployment approach | [Example in GitHub](https://github.com/Azure/CET-NorthStar/tree/master/examples/Sandbox-CAF-Migration) | [Deploy example to Azure](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkrnese%2FAzureDeploy%2Fmaster%2FARM%2Fns%2FSandbox-CAF-Migration.json) |
| CAF foundation sample | Deploy a CAF foundation sample using the enterprise-scale deployment approach | [Example in GitHub](https://github.com/Azure/CET-NorthStar/tree/master/examples/Sandbox-CAF-Foundation) | [Deploy example to Azure](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkrnese%2FAzureDeploy%2Fmaster%2FARM%2Fns%2FSandbox-CAF-Foundation.json) |

## Next steps

The above examples provide an easy deployment option to support continued learning for the enterprise-scale approach. Before using these examples in a production version of enterprise-scale, you should first review the [enterprise-scale architecture](./architecture.md).
