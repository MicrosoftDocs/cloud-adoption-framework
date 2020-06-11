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

# Implementing enterprise-scale Azure Landing Zones

When business requirements necessitate a rich initial implementation of landing zones, with fully integrated governance, security, and operations from the start, Microsoft suggests using the enterprise-scale example options on this page. This approach can use the Azure Portal or infrastructure-as-code to setup and configure your environment. It is also possible to transition between portal and infrastructure-as-code (recommended) when your organization is ready. As with any other Azure Infrastructure-as-code approaches, you will require skills in Azure Resource Manager Templates and GitHub.

## Example implementation

The following grid captures each of the modular implementations.

|Example deployment  |Description  |GitHub Repo|Deploy to Azure|
|---------|---------|---------|---------|---------|---------|---------|---------|
|Enterprise-Scale Foundation|This is the suggested platform foundation deployment for enterprise-scale adoption.|[Example in GitHub](https://github.com/Azure/CET-NorthStar/tree/master/examples/NorthStar-foundation)|[Deploy example to Azure](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkrnese%2FAzureDeploy%2Fmaster%2FARM%2Fdeployments%2Fe2e.json)|
|Enterprise-Scale VWan|Add a VWan network module to the Enterprise-scale foundation.|[Example in GitHub](https://github.com/Azure/CET-NorthStar/tree/master/examples/NorthStar-VWAN)|[Deploy example to Azure](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkrnese%2FAzureDeploy%2Fmaster%2FARM%2Fdeployments%2Fe2e.json)|
|Enterprise-Scale Hub/Spoke|Add a Hub/Spoke network module to the Enterprise-scale foundation.|[Example in GitHub](https://github.com/Azure/CET-NorthStar/tree/master/examples/NorthStar-foundation)|[Deploy example to Azure](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkrnese%2FAzureDeploy%2Fmaster%2FARM%2Fdeployments%2Fe2e.json)|

## Next steps

The above examples are meant to provide an easy deployment option to support continued learning for the enterprise-scale approach. Before using these examples in a production version of enterprise-scale, you should first review the [Enterprise-scale architecture](./architecture.md).
