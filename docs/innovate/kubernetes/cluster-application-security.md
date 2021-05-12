---
title: Cluster and application security
description: Learn about Kubernetes security essentials in the Cloud Adoption Framework for cluster and application security.
author: sabbour
ms.author: brblanch
ms.date: 04/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: think-tank, seo-caf-innovate
keywords: application security, security essentials, Kubernetes security
---

<!-- cSpell:ignore kured -->

# Cluster and application security

Familiarize yourself with Kubernetes security essentials and review the secure setup for clusters and application security guidance. Kubernetes security is important throughout the container lifecycle because of the distributed, dynamic nature of a Kubernetes cluster. Applications are only as secure as the weakest link in the chain of services that comprise the application's security.

## Plan, train, and proof

As you get started, the security essentials checklist and Kubernetes security resources below will help you plan for cluster operations and application security. By the end of this section, you'll be able to answer these questions:

> [!div class="checklist"]
>
> - Have you reviewed the security and threat model of Kubernetes clusters?
> - Is your cluster enabled for Kubernetes role-based access control?

**Security checklist:**

- **Familiarize yourself with the security essentials white paper.** The primary goals of a secure Kubernetes environment are ensuring that the applications it runs are protected, that security issues can be identified and addressed quickly, and that future similar issues will be prevented. For more information, see [The definitive guide to securing Kubernetes (white paper)](https://clouddamcdnprodep.azureedge.net/gdc/gdc8LXmoZ/original).

- **Review the security hardening setup for the cluster nodes.** A security hardened host OS reduces the surface area of attack and allows deploying containers securely. To learn more, see [Security hardening in AKS virtual machine hosts](/azure/aks/security-hardened-vm-host-image).

- **Setup cluster Kubernetes role-based access control (Kubernetes RBAC).** This control mechanism lets you assign users, or groups of users, permission to do things like create or modify resources, or view logs from running application workloads.

  For more information, see
  - [Understand Kubernetes role-based access control (Kubernetes RBAC)  (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=G3R24JSlGjY&index=12) <br>
  - [Integrate Azure AD with Azure Kubernetes Service](/azure/aks/azure-ad-integration-cli) <br>
  - [Limit access to cluster configuration file](/azure/aks/control-kubeconfig-access)

## Deploy to production and apply Kubernetes security best practices

As you prepare the application for production, implement a minimum set of best practices. Use this checklist at this stage. By the end of this section, you'll be able to answer these questions:

> [!div class="checklist"]
>
> - Have you set up network security rules for ingress, egress, and intra-pod communication?
> - Is your cluster set up to automatically apply node security updates?
> - Are you running a security scanning solution for your cluster and container services?

**Security checklist:**

- **Control access to clusters using group membership.** Configure Kubernetes role-based access control (Kubernetes RBAC) to limit access to cluster resources based on user identity or group membership. For more information, see [Control access to cluster resources using Kubernetes RBAC and Azure AD identities](/azure/aks/azure-ad-rbac).

- **Create a secrets management policy.** Securely deploy and manage sensitive information, such as passwords and certificates, using secrets management in Kubernetes. For more information, see [Understand secrets management in Kubernetes (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=KmhM33j5WYk&index=10).

- **Secure intra-pod network traffic with network policies.** Apply the principle of least privilege to control network traffic flow between pods in the cluster. For more information, see [Secure intra-pod traffic with network policies](/azure/aks/use-network-policies).

- **Restrict access to the API server using authorized IPs.** Improve cluster security and minimize attack surface by limiting access to the API server to a limited set of IP address ranges. For more information, see [Secure access to the API server](/azure/aks/api-server-authorized-ip-ranges).

- **Restrict cluster egress traffic.** Learn what ports and addresses to allow if you restrict egress traffic for the cluster. You can use Azure Firewall or a third-party firewall appliance to secure your egress traffic and define these required ports and addresses. To learn more, see [Control egress traffic for cluster nodes in AKS](/azure/aks/limit-egress-traffic).

- **Secure traffic with Web Application Firewall (WAF).** Use Azure Application Gateway as an ingress controller for Kubernetes clusters. For more information, see [Configure Azure Application Gateway as an ingress controller](/azure/application-gateway/ingress-controller-overview).

- **Apply security and kernel updates to worker nodes.** Understand the AKS node update experience. To protect your clusters, security updates are automatically applied to Linux nodes in AKS. These updates include OS security fixes or kernel updates. Some of these updates require a node reboot to complete the process. To learn more, see [Use kured to automatically reboot nodes to apply updates](/azure/aks/node-updates-kured).

- **Configure a container and cluster scanning solution.** Scan containers pushed into Azure Container Registry and gain deeper visibility to your cluster nodes, cloud traffic, and security controls.

  For more information, see:
  - [Azure Container Registry integration with Security Center](/azure/security-center/defender-for-container-registries-introduction) <br>
  - [Azure Kubernetes Service integration with Security Center](/azure/security-center/defender-for-kubernetes-introduction)

## Optimize and scale

Now that the application is in production, how can you optimize your workflow and prepare your application and team to scale? Use the optimization and scaling checklist to prepare. By the end of this section, you'll be able to answer this question:

> [!div class="checklist"]
>
> - Can you enforce governance and cluster policies at scale?

**Security checklist:**

- **Enforce cluster governance policies.** Apply at-scale enforcements and safeguards on your clusters in a centralized, consistent manner. To learn more, see [Control deployments with Azure Policy](/azure/governance/policy/concepts/policy-for-kubernetes).

- **Rotate cluster certificates periodically.** Kubernetes uses certificates for authentication with many of its components. You might want to periodically rotate those certificates for security or policy reasons. To learn more, see [Rotate certificates in Azure Kubernetes Service (AKS)](/azure/aks/certificate-rotation).
