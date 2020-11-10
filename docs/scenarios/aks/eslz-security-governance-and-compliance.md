---
title: "Enterprise-Scale security, governance, and compliance for AKS"
description: Describe how this enterprise-scale scenario can improve security, governance, and compliance of AKS
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Security, governance, and compliance for AKS Enterprise-Scale scenario

AKS has several interfaces to other Azure services like Azure AD, Azure Storage, Azure Networking etc. that require special attention during the planning phase. And it also adds additional complexity that requires you to consider applying the same security, governance and compliance mechanisms and controls that are in place for the rest of your infrastructure landscape.

## Design considerations

- Decide whether the cluster's control plane is accessible via the internet (default) or within a specific VNet only (private cluster).
- Monitor and enforce configuration using [Azure Policy for Kubernetes](https://docs.microsoft.com/azure/aks/use-pod-security-on-azure-policy)

## Design recommendations

- Limit access to [Kubernetes cluster configuration](https://docs.microsoft.com/azure/aks/control-kubeconfig-access) file with Azure role-based access control.
- Limit access to [actions that containers can perform](https://docs.microsoft.com/azure/aks/developer-best-practices-pod-security#secure-pod-access-to-resources). Provide the least number of permissions, and avoid the use of root / privileged escalation.
- Evaluate the use of the built-in [AppArmor security module](https://docs.microsoft.com/azure/aks/operator-best-practices-cluster-security#app-armor) to limit actions that containers can perform such as read, write, or execute, or system functions such as mounting filesystems.
- Evaluate the use of the [seccomp (secure computing)](https://docs.microsoft.com/azure/aks/operator-best-practices-cluster-security#secure-computing). seccomp works at the process level and allows you to limit the process calls that containers can perform.
- Use [Pod Identities](https://docs.microsoft.com/azure/aks/operator-best-practices-identity#use-pod-identities) and [Secrets Store CSI Driver](https://github.com/Azure/secrets-store-csi-driver-provider-azure#usage) with Azure Key Vault to protect secrets, certificates, and connection strings.
- Ensure certificates are [rotated](https://docs.microsoft.com/azure/aks/certificate-rotation) on a regular basis (e.g. every 90 days).
- Use [AKS node image upgrade](https://docs.microsoft.com/azure/aks/node-image-upgrade) to update AKS cluster node images (preferred) or [Kured](https://docs.microsoft.com/azure/aks/node-updates-kured) to automate node reboots after updates are applied.
- Use [Azure Security Center](https://docs.microsoft.com/azure/security-center/defender-for-kubernetes-introduction) to provide AKS recommendations and consider using [Azure Defender for Kubernetes](https://docs.microsoft.com/azure/security-center/defender-for-kubernetes-introduction) for threat detection.
