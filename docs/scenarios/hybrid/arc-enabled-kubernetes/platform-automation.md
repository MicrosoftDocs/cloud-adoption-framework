---
title: Automation for Azure Arc-enabled Kubernetes
description: Understand the design considerations and recommendations for automation of Arc-enabled Kubernetes
author: mrhoads
ms.author: mirhoads
ms.date: 11/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid
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

- To deploy and configure the Azure Arc-enabled Kubernetes agent, a cluster admin role is required on your Kubernetes cluster.

### Onboard Azure Arc-enabled Kubernetes

- Decide how you'll install and configure the Azure agent on your cluster.  Typically you'll deploy the agent using your organization's standard automation tools.

### Cluster extensions

Determine which Azure capabilities you want on your Azure Arc-enabled Kubernetes cluster.  Some capabilities require a cluster extension to be deployed.

### Lifecycle automation

Create a cluster update management strategy for Azure Arc-enabled Kubernetes clusters.

## Design recommendations

The following are general design recommendations for Azure Arc-enabled Kubernetes clusters:

### Environment preparation

- Create a [dedicated resource group](/azure/azure-resource-manager/management/manage-resource-groups-portal#create-resource-groups) to include only Azure Arc-enabled Kubernetes clusters and centralize management and monitoring of these resources.
- Evaluate and develop an IT-aligned [tagging strategy](/azure/cloud-adoption-framework/decision-guides/resource-tagging/) that can help reduce the complexity of managing your Azure Arc-enabled Kubernetes and simplifies the process of making management decisions.
- A kubeconfig file with context pointing to the Kubernetes cluster which will be Arc-enabled.
- Create a Service Principal to onboard Kubernetes clusters non-interactively using the Azure CLI. Visit [Identity and Access Management](./identity-access-management.md) for more information surrounding required permissions.

### Onboard Azure Arc-enabled Kubernetes clusters

One of your first tasks will be to onboard your fleet of Kubernetes clusters to Azure Arc. After determining resource group placement and your target clusters, if you only have a few clusters, you can opt to run the onboarding directly from your Windows or Linux machine using the Azure CLI. For larger fleets of clusters, we recommended creating a service principal and onboarding your clusters in an automated fashion by way of automation tooling such as Azure DevOps, GitHub Actions, or an existing automation tool used to currently manage your Kubernetes clusters. Ensure your Kubernetes clusters meet the network requirements found in [network connectivity](./network-connectivitiy.md).

Afterwards, be sure to [verify your connection](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#5-verify-cluster-connection) to Azure Arc-enabled Kubernetes.

### Arc-enabled Kubernetes extensions

Depending on the needs of Extensions, you may opt to have extensions that are required to be installed on all of your Arc enabled Kubernetes clusters, as well as certain extensions which are installed only to specific Arc-enabled Kubernetes clusters. For extensions that are not widely adopted across your fleet of clusters, considering automating by way for CLI and Arm template using automation tools such as Azure DevOps or GitHub Actions.

For cases where extensions are common across all of your Arc-enabled Kubernetes clusters, or large groups of Arc-enabled Kubernetes clusters, we recommend automating the deployment of Arc extensions at scale via [Azure Policy](/azure/governance/policy/overview). The following is an overview of steps:

- Create an [initiative](/azure/security-center/security-policy-concept#what-is-a-security-initiative) to deploy Arc-enabled Kubernetes extensions at scale.
- Use a "[DeployIfNotExists](/azure/governance/policy/concepts/effects#deployifnotexists)" policy effect to ensure the Arc-enabled Kubernetes extensions get deployed automatically, as more Kubernetes clusters are onboarded, and remediate any Kubernetes clusters where the extensions have been removed.
- More details on using policy with Azure Arc-enabled Kubernetes clusters can be found in the [Security, governance and compliance for Azure Arc-enabled Kubernetes](./eslz-security-governance-and-compliance.md) section of this guide.


### Lifecycle Automation

During the onboarding process, Azure Arc enabled Kubernetes provision agents on to your Kubernetes cluster, these agent versions will change with updates to Azure Arc and should be regularly upgraded. We recommend enabling the auto-upgrade feature for the Azure Arc agents running inside your cluster, this is the default behavior when onboarding a cluster to Azure Arc. Visit [Upgrade Agents] for more information on the auto-upgrade feature and version support policy.

The other Arc components that will require updates on your cluster are Extension versions. For any extension installed on your cluster, we recommend to leave the default behavior to automatically upgrade the extension minor version, which can optionally be disabled during provisioning. In the case of a major version upgrade which may cause, there will be a migration path documented to move to the extension major release. Please see [Extensions and Custom locations](./extensions-management.md) for more information.


## Next steps

For more guidance for your hybrid cloud adoption journey,  review the following:

- Review [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_k8s/) scenarios
- Review [Identity and Access requirements](./identity-access-management.md) for Azure Arc-enabled Kubernetes
- To learn more about Azure Arc, check out the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/)
