---
title: Management and monitoring for Azure Arc-enabled Kubernetes
description: Understand the design considerations and recommendations for management and monitoring of Arc-enabled Kubernetes.
author: chintalavr
ms.author: vchintala
ms.date: 11/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: e2e-hybrid, think-tank
---

# Management and monitoring for Azure Arc-enabled Kubernetes

This document provides key design considerations and recommendations to manage and monitor Azure Ar-enabled Kubernetes to help you understand and design solutions with well architected operational excellence.

Before continuing with this document, review [Identity and Access Management](./identity-access-management.md), [Networking](./network-connectivity.md), [Resource Organization](./resource-organization.md), and [Governance](./governance-disciplines.md) critical design areas (CDA) to better understand related design considerations and recommendations to focus on management and monitoring as aspects of the Azure Arc-enabled Kubernetes.

## Architecture

It is important to understand the Arc-enabled Kubernetes architecture and [connectivity modes](/azure/azure-arc/kubernetes/conceptual-connectivity-modes#understand-connectivity-modes) to make the right architectural decision to onboard Kubernetes cluster to Azure Arc, manage, and monitor.

### Cluster management

The following architecture diagram shows different Azure Arc-enabled Kubernetes components and how they interact when onboarding and manage the Kubernetes cluster in a fully connected network connectivity mode.

![Azure Arc-enabled Kubernetes cluster management](./media/arc-enabled-kubernetes-cluster-management.png)

The following diagram shows [Azure Arc-enabled Kubernetes cluster access from anywhere](/azure/azure-arc/kubernetes/conceptual-cluster-connect) and how the components interact with each other to manage cluster using Azure RBAC.

![Access Arc-enabled Kubernetes anywhere](./media/conceptual-cluster-connect.png)

### Cluster monitoring

The following architecture diagram shows Azure Arc-enabled Kubernetes cluster monitoring in a fully connected network connectivity mode.

![Arc-enabled Kubernetes cluster monitoring](./media/arc-enabled-kubernetes-cluster-monitoring.png)

## Design considerations

**Cluster onboarding:**

- Consider designing enterprise landing zone subscriptions for Azure Arc-enabled Kubernetes cluster and the [extensions](/azure/azure-arc/kubernetes/extensions) deployment]and management based on the [resource organization](./resource-organization.md) and [governance principles](./governance-disciplines.md) defined for the organization.
- Consider using a shared administration terminal servers to install required tools to maintain consistent versions across all users to avoid issues when deploying and managing Azure Arc-enabled Kubernetes cluster.
- Decide between [auto-upgrade versus manual upgrade Azure Arc-enabled Kubernetes agents](/azure/azure-arc/kubernetes/agent-upgrade#toggle-auto-upgrade-on-or-off-when-connecting-cluster-to-azure-arc) depending on the organization change management process and deploy Azure Arc-enabled custer. Azure Arc-enabled Kubernetes agents auto-upgrade management behavior can be changed any time after cluster is deployed if re-considered the decision later.
- Consider designing source and destination groups to manage Azure Arc-enabled Kubernetes network firewall rules to simplify and minimize firewall or proxy management effort. Refer to your on-premises or multi-cloud firewall or proxy management guidelines for more details.
- Consider writing a script to verify connectivity to the [Azure Arc-enabled Kubernetes required URLs](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#meet-network-requirements) from on the on-premises or multi-cloud Kubernetes cluster nodes to minimize effort troubleshooting and resolving connectivity issues.

**Cluster management:**

**Cluster monitoring:**

- Considering the [supported configuration for Azure Monitor for containers](/azure/azure-monitor/containers/container-insights-enable-arc-enabled-clusters?toc=/azure/azure-arc/kubernetes/toc.json#supported-configurations) with Azure Arc-enabled Kubernetes, decide if Azure Monitor for Container is the right monitoring solution to monitor Arc-enabled Kubernetes cluster.
- Consider using dedicated Log Analytics workspace per region to collect logs and metrics from Azure Arc-enabled Kubernetes cluster to monitoring and reporting across multiple cluster in a specific environment. Review [resource organization](./resource-organization.md) CDA for additional details.
- Consider Azure Monitor [ITSM connector integration](/azure/azure-monitor/alerts/itsmc-overview) with your organization [IT service management] tools to raise incidents for Azure Monitor alerts and track issue resolution.

## Design recommendations

**Cluster onboarding:**

**Cluster management:**

- When using [the semi-connected network connectivity mode](/azure/azure-arc/kubernetes/conceptual-connectivity-modes#understand-connectivity-modes), it is recommended to connect the cluster to Azure Arc at least once in 30 days to export billing data and once in 90 days to renew managed identity certificates, update Azure Arc-enabled Kubernetes resource and agents.

**Cluster monitoring:**

- Enable [Azure Monitor Container Insights for Azure Arc-enabled Kubernetes clusters](/azure/azure-monitor/containers/container-insights-enable-arc-enabled-clusters) to collect logs and metrics to create dashboards and generate alerts for cluster related issues.
- Use Azure Resource Graph or Log Analytics queries to monitor cluster health and raise alerts.

## Next steps

- Review [Azure Arc-enabled Kubernetes network connectivity requirements](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#meet-network-requirements).
- Review [Connect an existing Kubernetes cluster to Azure Arc](/azure/azure-arc/kubernetes/quickstart-connect-cluster).
- Review [Azure Arc Jumpstart - Azure Arc-enabled Kubernetes](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/).
- Review [Upgrading Azure Arc-enabled Kubernetes agents](/azure/azure-arc/kubernetes/agent-upgrade).
- Review [Use Cluster Connect to connect to Azure Arc-enabled Kubernetes clusters](/azure/azure-arc/kubernetes/cluster-connect) to manage clusters.
- Review [Frequently Asked Questions - Azure Arc-enabled](/azure/azure-arc/kubernetes/faq) to get answers to most common questions.
