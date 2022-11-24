---
title: Security for Azure Red Hat OpenShift
description: Learn how to implement security for Azure Red Hat OpenShift deployments.
author: UmarMohamedUsman
ms.author: umarm
ms.date: 11/17/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aro
---

# Security for the Azure Red Hat OpenShift landing zone accelerator

Security is a critical concern for all online systems. This article provides design considerations and recommendations to protect and secure your Azure Red Hat OpenShift deployments.

## Design considerations

Azure Red Hat OpenShift works with other Azure services like Azure Active Directory, Azure Container Registry, Azure Storage, and Azure Virtual Network. These interfaces require special attention during the planning phase. Azure Red Hat OpenShift also adds extra complexity, so you should consider applying the same security governance and compliance mechanisms and controls as in the rest of your infrastructure landscape.

Here are some design considerations for security governance and compliance:

- If you deploy an Azure Red Hat OpenShift cluster using Azure landing zone best practices, get familiar with the [policies that will be inherited by the clusters](https://github.com/Azure/Enterprise-Scale/blob/main/docs/wiki/ALZ-Policies.md).

- Decide whether the cluster's control plane should be accessible via the internet, which is the default. If so, IP restrictions are recommended. If the cluster control plane will be accessible only from within your private network, either in Azure or on-premises, then deploy [Azure Red Hat OpenShift private cluster](/azure/openshift/howto-create-private-cluster-4x).

- Decide how to control and secure [egress traffic from your Azure Red Hat OpenShift cluster](/azure/openshift/howto-restrict-egress) using Azure Firewall or other network virtual appliance.

- Decide how secrets will be managed in your cluster. You can either use [Azure Key Vault Provider for Secrets Store CSI Driver](/azure/aks/csi-secrets-store-driver) to protect secrets, or [connect Azure Red Hat OpenShift cluster to Azure Arc-enabled Kubernetes](/azure/azure-arc/kubernetes/quickstart-connect-cluster) and use the [Azure Key Vault Secrets Provider extension to fetch secrets](/azure/azure-arc/kubernetes/tutorial-akv-secrets-provider).

- Decide whether your container registry is accessible via the internet, or only within a specific virtual network. Disabling internet access in a container registry can have negative effects on other systems that rely on public connectivity, such as continuous integration pipelines or Microsoft Defender for Containers image scanning. For more information, see [Connect privately to a container registry using Azure Private Link](/azure/container-registry/container-registry-private-link).

- Decide whether your private container registry will be shared across multiple landing zones or if you'll deploy a dedicated container registry to each landing zone subscription.

- Decide how your container base images and application run time will be updated over the container lifecycle. [Azure Container Registry Tasks](/azure/container-registry/container-registry-tasks-overview) provide support to automate your OS and application framework patching workflow, maintaining secure environments while adhering to the principles of immutable containers.

## Design recommendations

- Limit access to the [Azure Red Hat OpenShift cluster configuration](/azure/openshift/configure-azure-ad-cli) file by integrating with Azure Active Directory or your own [identity provider](https://docs.openshift.com/container-platform/4.10/authentication/identity_providers/configuring-ldap-identity-provider.html). Assign appropriate [OpenShift role-based access control](https://docs.openshift.com/container-platform/4.10/authentication/using-rbac.html) such as cluster-admin or cluster-reader.
- [Secure pod access to resources](/azure/aks/developer-best-practices-pod-security#secure-pod-access-to-resources). Provide the least number of permissions, and avoid using root or privileged escalation.

- To manage and protect secrets, certificates, and connection strings in your cluster, you should [connect Azure Red Hat OpenShift cluster to Azure Arc-enabled Kubernetes](/azure/azure-arc/kubernetes/quickstart-connect-cluster) and use the [Azure Key Vault Secrets Provider extension](/azure/azure-arc/kubernetes/tutorial-akv-secrets-provider) to fetch secrets.

- For Azure Red Hat OpenShift 4 clusters, *etcd* data isn't encrypted by default, but it's recommended to [enable etcd encryption](https://docs.openshift.com/container-platform/4.10/security/encrypting-etcd.html) to provide another layer of data security.

- Keep your clusters on the latest OpenShift version to avoid potential security or upgrade issues. Azure Red Hat OpenShift only supports the [current and previous generally available minor release](/azure/openshift/support-lifecycle#red-hat-openshift-container-platform-version-support-policy) of Red Hat OpenShift Container Platform. [Upgrade the cluster](/azure/openshift/howto-upgrade) if it's on a version that's older than the last minor release.

- Monitor and enforce configuration by using the [Azure Policy Extension](/azure/governance/policy/concepts/policy-for-kubernetes#install-azure-policy-extension-for-azure-arc-enabled-kubernetes).

- Connect [Azure Red Hat OpenShift clusters to Azure Arc-enabled Kubernetes](/azure/azure-arc/kubernetes/quickstart-connect-cluster).

- Use [Microsoft Defender for Containers](/azure/defender-for-cloud/defender-for-containers-introduction) supported via [Arc enabled Kubernetes](/azure/defender-for-cloud/supported-machines-endpoint-solutions-clouds-containers?tabs=iaas-arc) to secure clusters, containers, and applications. Also scan your images for vulnerabilities with Microsoft Defender or any other image scanning solution.

- Deploy a dedicated and private instance of [Azure Container Registry](/azure/container-registry/) to each landing zone subscription.

- Use [Private Link for Azure Container Registry](/azure/container-registry/container-registry-private-link) to connect it to Azure Red Hat OpenShift.

- Use a [bastion host](/azure/aks/operator-best-practices-network#securely-connect-to-nodes-through-a-bastion-host), or jumpbox, to securely access Azure Red Hat OpenShift Private Cluster.

## Next steps

Learn about [operations management and baseline considerations for Azure Red Hat OpenShift landing zone](./operations.md).
