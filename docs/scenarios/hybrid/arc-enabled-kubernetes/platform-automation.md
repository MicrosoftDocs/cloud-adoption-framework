---
title: Automation for Azure Arc-enabled Kubernetes
description: Understand the design considerations and recommendations for automation of Arc-enabled Kubernetes
author: mrhoads
ms.author: mirhoads
ms.date: 11/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: e2e-hybrid, think-tank
---

# Automation for Azure Arc-enabled Kubernetes

Azure Arc-enabled Kubernetes clusters allow you to manage your Kubernetes clusters that are hosted outside of Azure, on your corporate network, or on another cloud provider.  This document is written to help plan the automation of onboarding of clusters and adding additional capability through cluster extensions.  This article presents key recommendations for operations teams to onboard and automate Azure Arc-enabled clusters thorughout their lifecycle.

## Design Considerations

The following are some design considerations before onboarding Azure Arc-enabled Kubernetes clusters to Azure:

### Review requirements

- Your cluster runs a Cloud Native Computing Foundation [CNCF](/azure/azure-arc/kubernetes/overview#supported-kubernetes-distribution) distribution
- You've reviewed the Azure Arc-enabled Kubernetes [agent](/azure/azure-arc/kubernetes/conceptual-agent-overview) overview

### Network connectivity

Your cluster has connectivy from your on-premises network or third-party cloud providers to Azure - either directly connected, via a proxy server, or private endpoint.  See the [Network connectivity for Azure Arc-enabled Kubernetes](./network-connectivity.md) section of this guide for design considerations and recommendations.

### Environment preparation

- To deploy and configure the Azure Arc-enabled Kubernetes agent, a **[Missing] role** is required.

### Onboard Azure Arc-enabled Kubernetes

- Before onboarding clusters, you've **[MISSING registered the Azure resource providers]**
- Decide how you'll install and configure the Azure agent on your cluster.  Typically you'll deploy the agent using your organization's standard automation tools.

### Cluster extensions

Determine which Azure capabilities you want on your Azure Arc-enabled Kubernetes cluster.  Some capabilities require a cluster extension to be deployed.

### Lifecycle automation

Create a cluster update management strategy for Azure Arc-enabled Kubernetes clusters.