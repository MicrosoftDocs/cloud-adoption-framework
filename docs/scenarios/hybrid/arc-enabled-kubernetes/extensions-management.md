---
title: Extensions management for Azure Arc-enabled Kubernetes
description: Understand the design considerations and recommendations for extensions management of Azure Arc-enabled Kubernetes.
author: mrhoads
ms.author: mirhoads
ms.date: 12/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid
---

# Extensions Management for Azure Arc-enabled Kubernetes

This article walks through the key design considerations and best practices for the managing extensions of Azure Arc-enabled Kubernetes deployments as part of a CAF enterprise-scale landing zone implementation.

Before going through this document it is important to understand governance principles because of the effect of the decisions made, also make sure to review [Enterprise-scale for AKS](/azure/cloud-adoption-framework/scenarios/aks/enterprise-scale-landing-zone) to understand the relevant concepts of Enterprise Scale in a container environment.

## Design Considerations

Consider the following factors when designing how to use Azure Arc-enabled Kubernetes extensions:

- know what [extensions are currently available](https://docs.microsoft.com/azure/azure-arc/kubernetes/extensions)
- know how [extensions are built on top of Helm](https://docs.microsoft.com/azure/azure-arc/kubernetes/conceptual-extensions)

Conceptually, extensions for Azure Arc-enabled Kubernetes can be thought of as either management extensions and service extensions.  While this distinction is not made explicitly for the name of each extension, it is helpful to consider keeping these two categories of extensions in mind when creating a design.  For example, the Microsoft Defender for Cloud extension can be thought of as a management extension, whereas the Azure App Service for Azure Arc extension can be thought of as a service extension.

Additionally, while extensions provide additional capability for Azure Arc-enabled Kubernetes clusters, consider your specific use case and needs before installing any extensions.  Furthermore, consider how extensions will be kept up-to-date over the lifespan of your cluster.

## Design Recommendations

### Extension installation

Define a strategy for installing extensions, whether that is through the Portal, CLI, ARM templates, or another mechanism.  After installation, verify that the extension(s) have installed properly.

### Update extensions

Extensions are periodically updated.  Define a strategy to keep cluster extensions up-to-date.  Consider setting the `--auto-upgrade-minor-version` flag to automatically upgrade minor versions of the extension as described in [Usage of Cluster Extensions](https://docs.microsoft.com/azure/azure-arc/kubernetes/extensions#usage-of-cluster-extensions)

## Next steps

For more guidance for your cloud adoption journey, see the following article:

- [Connect an existing Kubernetes cluster to Azure Arc](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli)
- [Secret and certificate management](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/day2/cluster_api/cluster_api_keyvault_extension/)
- [Integrate Azure Defender with Cluster API as an Azure Arc Connected Cluster using Kubernetes extensions](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/day2/cluster_api/cluster_api_defender_extension/)
- [Integrate Open Service Mesh (OSM) with Cluster API as an Azure Arc Connected Cluster using Kubernetes extensions](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/day2/cluster_api/cluster_api_osm_extension/)
- [Enterprise Scale for AKS](/azure/cloud-adoption-framework/scenarios/aks/enterprise-scale-landing-zone)
