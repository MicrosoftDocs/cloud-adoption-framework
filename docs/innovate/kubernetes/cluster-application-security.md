---
title: "Cluster and application security"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn about Kubernetes in the Cloud Adoption Framework for cluster and application security.
author: sabbour
ms.author: asabbour
ms.topic: guide
ms.date: 03/20/2020
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

<!-- cSpell:ignore asabbour sabbour kured -->

# Cluster and application security

Familiarize yourself with Kubernetes security essentials and review the secure setup for clusters and application security guidance.

## Plan, train, and proof

As you get started, the checklist and resources below will help you plan for cluster operations and security. You should be able answer these questions:

> [!div class="checklist"]
>
> - Have you reviewed the security and threat model of Kubernetes clusters?
> - Is your cluster enabled for role-based access control?

<!-- markdownlint-disable MD033 -->

> [!div class="tdCol2BreakAll"]
>
> | Checklist  | Resources |
> |------------------------------------------------------------------|-----------------------------------------------------------------|
> | **Familiarize yourself with the security essentials whitepaper.** The primary goals of a secure Kubernetes environment are ensuring that the applications it runs are protected, that security issues can be identified and addressed quickly, and that future similar issues will be prevented. | [The Definitive Guide to Securing Kubernetes (whitepaper)](https://clouddamcdnprodep.azureedge.net/gdc/gdc8LXmoZ/original)     |
> | **Review the security hardening setup for the cluster nodes.** A security hardened host OS reduces the surface area of attack and allows deploying containers securely. | [Security hardening in AKS virtual machine hosts](https://docs.microsoft.com/azure/aks/security-hardened-vm-host-image)     |
> | **Setup cluster role-based access control (RBAC).** This control mechanism lets you assign users, or groups of users, permission to do things like create or modify resources, or view logs from running application workloads. | [Understand role-based access control (RBAC) in Kubernetes (video)](https://www.youtube.com/watch?v=G3R24JSlGjY&list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&index=12) <br/> [Integrate Azure AD with Azure Kubernetes Service](https://docs.microsoft.com/azure/aks/azure-ad-integration) <br/> [Limit access to cluster configuration file](https://docs.microsoft.com/azure/aks/control-kubeconfig-access)   |

## Deploy to production and apply best practices

As you prepare the application for production, you should implement a minimum set of best practices. Use the checklist below at this stage. You should be able to answer these questions:

> [!div class="checklist"]
>
> - Have you configured network security rules for ingress, egress, and intra-pod communication?
> - Is your cluster configured to automatically apply node security updates?
> - Are you running a security scanning solution for your cluster and container workloads?

<!-- markdownlint-disable MD033 -->

> [!div class="tdCol2BreakAll"]
>
> | Checklist  | Resources |
> |------------------------------------------------------------------|-----------------------------------------------------------------|
> | **Control access to clusters using group membership.** Configure Kubernetes role-based access control (RBAC) to limit access to cluster resources based user identity or group membership. | [Control access to clusters using RBAC and Azure AD groups](https://docs.microsoft.com/azure/aks/azure-ad-rbac)    |
> | **Create a secrets management policy.** Securely deploy and manage sensitive information, such as passwords and certificates, using secrets management in Kubernetes. | [Understand secrets management in Kubernetes (video)](https://www.youtube.com/watch?v=KmhM33j5WYk&list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&index=10) |
> | **Secure intra-pod network traffic with network policies.** Apply the principle of least privilege to control network traffic flow between pods in the cluster. | [Secure intra-pod traffic with network policies](https://docs.microsoft.com/azure/aks/use-network-policies) |
> | **Restrict access to the API server using authorized IPs.** Improve cluster security and minimize attack surface by limiting access to the API server to a limited set of IP address ranges. | [Secure access to the API server](https://docs.microsoft.com/azure/aks/api-server-authorized-ip-ranges) |
> | **Restrict cluster egress traffic.** Learn what ports and addresses to allow if you restrict egress traffic for the cluster. You can use Azure Firewall or a third-party firewall appliance to secure your egress traffic and define these required ports and addresses. | [Control egress traffic for cluster nodes in AKS](https://docs.microsoft.com/azure/aks/limit-egress-traffic) |
> | **Secure traffic with a web application firewall (WAF).** Leverage Azure Application Gateway as an ingress controller for Kubernetes clusters.  | [Configure Azure Application Gateway as an ingress controller](https://docs.microsoft.com/azure/application-gateway/ingress-controller-overview)    |
> | **Apply security and kernel updates to worker nodes.** Understand the AKS node update experience. To protect your clusters, security updates are automatically applied to Linux nodes in AKS. These updates include OS security fixes or kernel updates. Some of these updates require a node reboot to complete the process. | [Use kured to automatically reboot nodes to apply updates](https://docs.microsoft.com/azure/aks/node-updates-kured) |
> | **Configure a container and cluster scanning solution.** Scan containers pushed into Azure Container Registry and gain deeper visibility to your cluster nodes, cloud traffic, and security controls. | [Azure Container Registry integration with Security Center](https://docs.microsoft.com/azure/security-center/azure-container-registry-integration) <br/> [Azure Kubernetes Service integration with Security Center](https://docs.microsoft.com/azure/security-center/azure-kubernetes-service-integration)  |

## Optimize and scale

Now that the application is in production, how can you optimize your workflow and prepare your application and team to scale? Use the optimization and scaling checklist to prepare. You should be able to answer:

> [!div class="checklist"]
>
> - Can you enforce governance and cluster policies at scale?

<!-- markdownlint-disable MD033 -->

> [!div class="tdCol2BreakAll"]
>
> | Checklist  | Resources |
> |------------------------------------------------------------------|-----------------------------------------------------------------|
> | **Enforce cluster governance policies.** Apply at-scale enforcements and safeguards on your clusters in a centralized, consistent manner. | [Control deployments with Azure Policy](https://docs.microsoft.com/azure/governance/policy/concepts/rego-for-aks)    |
> | **Rotate cluster certificates periodically.** Kubernetes uses certificates for authentication with many of its components. You may want to periodically rotate those certificates for security or policy reasons. | [Rotate certificates in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/certificate-rotation)    |
