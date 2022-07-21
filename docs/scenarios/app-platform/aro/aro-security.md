---
title: Security for ARO
description: Describes how to improve security for the Azure RedHat OpenShift Service.
author: UmarMohamedUsman
ms.author: umarm
ms.date: 06/07/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aro
---

## Security for the ARO landing zone accelerator

This article provides design considerations and recommendations for security when using the ARO landing zone accelerator.

## Design considerations

ARO has several interfaces to other Azure services like Azure Active Directory, Azure Container Registry, Azure Storage, and Azure Virtual Network which requires special attention during the planning phase. ARO also adds extra complexity that requires you to consider applying the same security governance and compliance mechanisms and controls as in the rest of your infrastructure landscape.

Here are some other design considerations for ARO security governance and compliance:

- If you create an ARO cluster in a subscription deployed according to Azure landing zone best practices, get familiar with the Azure policies that will be inherited by the clusters, as described in [Policies included in Azure landing zones reference implementations](https://github.com/Azure/Enterprise-Scale/blob/main/docs/ESLZ-Policies.md).
- Decide whether the cluster's control plane should be accessible via the internet (in which case IP restrictions are recommended), which is the default, or only from within your private network in Azure or on-premises as a private cluster. For more information, see deploying [Azure Red Hat OpenShift private cluster](azure/openshift/howto-create-private-cluster-4x).

- Decide how to control/secure egress traffic from your Azure Red Hat OpenShift cluster. For more information, see [Control egress traffic for your ARO](azure/openshift/howto-restrict-egress)

- Decide how the secrets will be managed in your ARO cluster. You can either use [Azure Key Vault provider for Secrets Store CSI Driver](/azure/aks/csi-secrets-store-driver) to protect secrets or [connect ARO cluster to Arc enabled kubernetes](/azure/azure-arc/kubernetes/quickstart-connect-cluster) and use [Azure Key Vault Secrets Provider extension to fetch secrets](/azure/azure-arc/kubernetes/tutorial-akv-secrets-provider).
- Decide whether your container registry is accessible via the internet, or only within a specific virtual network. Disabling internet access in a container registry can have negative effects on other systems that rely on public connectivity to access it, such as continuous integration pipelines or Microsoft Defender for image scanning. For more information, see [Connect privately to a container registry using Azure Private Link](/azure/container-registry/container-registry-private-link).
- Decide whether your private container registry will be shared across multiple landing zones or if you'll deploy a dedicated container registry to each landing zone subscription.
- Decide how your container base images and application run time will be updated over the container lifecycle. [ACR Tasks](/azure/container-registry/container-registry-tasks-overview) provides support to automate your OS and application framework patching workflow, maintaining secure environments while adhering to the principles of immutable containers.
- Consider using a security solution like [Microsoft Defender for Containers](/azure/defender-for-cloud/defender-for-containers-introduction) for threat detection, once ARO cluster is [Connected to Arc-enabled Kubernetes](/azure/azure-arc/kubernetes/quickstart-connect-cluster).
- Consider scanning your container images for vulnerabilities.

## Design recommendations

- If the cluster control plane shouldn't be accessed over the internet then deploy [Azure Red Hat OpenShift private cluster](/azure/openshift/howto-create-private-cluster-4x).

- It's recommended to [control/secure egress traffic from your ARO cluster](/azure/openshift/howto-restrict-egress) using Azure Firewall or other network virtual appliance.

- Limit access to the [ARO cluster configuration](/azure/openshift/configure-azure-ad-cli) file by integrating with Azure AD or your own [identity provider](https://docs.openshift.com/container-platform/4.10/authentication/identity_providers/configuring-ldap-identity-provider.html) and assign appropriate [OpenShift RBAC roles](https://docs.openshift.com/container-platform/4.10/authentication/using-rbac.html) such as cluster-admin or cluster-reader, etc.
- [Secure pod access to resources](/azure/aks/developer-best-practices-pod-security#secure-pod-access-to-resources). Provide the least number of permissions, and avoid using root or privileged escalation.

- In terms of managing/protecting secrets, certificates and connection strings in your ARO cluster, it's recommended to [connect ARO cluster to Arc enabled kubernetes](/azure/azure-arc/kubernetes/quickstart-connect-cluster) and use [Azure Key Vault Secrets Provider extension to fetch secrets](/azure/azure-arc/kubernetes/tutorial-akv-secrets-provider).

- For Azure Red Hat OpenShift 4 clusters, etcd data isn't encrypted by default, but it's recommended to [enable etcd encryption](https://docs.openshift.com/container-platform/4.10/security/encrypting-etcd.html) to provide an additional layer of data security.
- It's recommended to keep the ARO cluster on the latest OpenShift version to avoid potential security or upgrade issues. [ARO only supports two generally available (GA)](/azure/openshift/support-lifecycle#red-hat-openshift-container-platform-version-support-policy) minor versions of Red Hat OpenShift Container Platform. [Upgrade an ARO Cluster](/azure/openshift/howto-upgrade) if the cluster is on N-2 version or older (N being the latest GA minor version that is released).
- Monitor and enforce configuration by using the [Azure Policy Extension](/azure/governance/policy/concepts/policy-for-kubernetes#install-azure-policy-extension-for-azure-arc-enabled-kubernetes) by [connecting ARO cluster to Arc-enabled Kubernetes](/azure/azure-arc/kubernetes/quickstart-connect-cluster).

- Use [Microsoft Defender for Containers](/azure/defender-for-cloud/defender-for-containers-introduction) for securing ARO cluster, containers and applications, by [connecting ARO cluster to Arc-enabled Kubernetes](/azure/azure-arc/kubernetes/quickstart-connect-cluster).

- Deploy a dedicated and private instance of [Azure Container Registry](/azure/container-registry/) to each landing zone subscription.
- Use [Private Link for Azure Container Registry](/azure/container-registry/container-registry-private-link) to connect it to ARO.
- Scan your images for vulnerabilities with [Microsoft Defender for container registries](/azure/security-center/defender-for-container-registries-introduction), or any other image scanning solution.

- Use [Bastion Host](/azure/aks/operator-best-practices-network#securely-connect-to-nodes-through-a-bastion-host) and Jumpbox VM to securely access ARO Private Cluster.

> [!IMPORTANT]
> Microsoft Defender for Cloud image scanning is not compatible with Container Registry endpoints. For more information, see [Connect privately to a container registry using Private Link](/azure/container-registry/container-registry-private-link).
