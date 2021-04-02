---
title: Cluster and application security
description: Learn about Kubernetes in the Cloud Adoption Framework for cluster and application security.
author: sabbour
keywords: Application security, security essentials, Kubernetes security
ms.author: brblanch
ms.date: 03/02/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: think-tank, seo-caf-innovate
---

<!-- cSpell:ignore kured -->

# Cluster and application security

Familiarize yourself with Kubernetes security essentials and review the secure setup for clusters and application security guidance. Kubernetes security is important throughout the container lifecycle because of the distributed, dynamic nature of a Kubernetes cluster. Applications are only as secure as the weakest link in the chain of services that comprise the application’s security.

## Plan, train, and proof

As you get started, the security essentials checklist and Kubernetes security resources below will help you plan for cluster operations and application security.  By the end of this section, you'll be able to answer these questions:

> [!div class="checklist"]
>
> - Have you reviewed the security and threat model of Kubernetes clusters?
> - Is your cluster enabled for Kubernetes role-based access control?

:::row:::
   :::column span="":::
      **Security Checklist**
   :::column-end:::
   :::column span="":::
      **Kubernetes security resources**
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Familiarize yourself with the security essentials white paper.** The primary goals of a secure Kubernetes environment are ensuring that it protects the applications it runs, that it identifies and addresses security issues quickly, and that it prevents similar issues in the future.
   :::column-end:::
   :::column span="":::
      
[The definitive guide to securing Kubernetes (white paper)](https://clouddamcdnprodep.azureedge.net/gdc/gdc8LXmoZ/original)
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Review the security hardening setup for the cluster nodes.** A security hardened host OS reduces the surface area of attack and lets you deploy containers securely.
   :::column-end:::
   :::column span="":::
      
[Security hardening in Azure Kubernetes Service (AKS) virtual machine hosts](/azure/aks/security-hardened-vm-host-image)
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Setup cluster Kubernetes role-based access control (Kubernetes RBAC).** This control mechanism lets you assign users, or groups of users, permission to do things like create or change resources, or view logs from running application services.
   :::column-end:::
   :::column span="":::
      
[Understand Role Based Access Control in Kubernetes (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=G3R24JSlGjY&index=12)

[Integrate Azure Active Directory with AKS using the Azure CLI](/azure/aks/azure-ad-integration-cli)

[Use Azure role-based access control to define access to the Kubernetes configuration file in AKS](/azure/aks/control-kubeconfig-access)
   :::column-end:::
:::row-end:::

## Deploy to production and apply Kubernetes security best practices

As you prepare the application for production, implement a minimum set of best practices. Use this checklist at this stage.  By the end of this section, you'll be able to answer these questions:

> [!div class="checklist"]
>
> - Have you set up network security rules for ingress, egress, and intra-pod communication?
> - Is your cluster set up to automatically apply node security updates?
> - Are you running a security scanning solution for your cluster and container services?

:::row:::
   :::column span="":::
      **Security Checklist**
   :::column-end:::
   :::column span="":::
      **Kubernetes security resources**
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Control access to clusters using group membership.** Set up Kubernetes RBAC to limit access to cluster resources based on user identity or group membership.
   :::column-end:::
   :::column span="":::
      
[Control access to cluster resources using Kubernetes RBAC and Azure AD identities in AKS](/azure/aks/azure-ad-rbac)
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Create a secrets management policy.** Securely deploy and manage sensitive information, like passwords and certificates, using secrets management in Kubernetes.
   :::column-end:::
   :::column span="":::
      
[Understand secrets management in Kubernetes (video)](https://www.youtube.com/watch?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT&v=KmhM33j5WYk&index=10)
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Secure intra-pod network traffic with network policies.** Apply the principle of least privilege to control network traffic flow between pods in the cluster.
   :::column-end:::
   :::column span="":::
      
[Secure intra-pod traffic with network policies](/azure/aks/use-network-policies)
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Restrict access to the API server using authorized IPs.** Improve cluster security and minimize attack surface by limiting access to the API server to a limited set of IP address ranges.
   :::column-end:::
   :::column span="":::
      
[Secure access to the API server](/azure/aks/api-server-authorized-ip-ranges)
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Restrict cluster egress traffic.** Learn what ports and addresses to allow if you restrict egress traffic for the cluster. You can use Azure Firewall or a third-party firewall appliance to secure your egress traffic and define these required ports and addresses.
   :::column-end:::
   :::column span="":::
      
[Control egress traffic for cluster nodes in AKS](/azure/aks/limit-egress-traffic)
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Secure traffic with Web Application Firewall (WAF).** Use Azure Application Gateway as an ingress controller for Kubernetes clusters.
   :::column-end:::
   :::column span="":::
      
[Configure Azure Application Gateway as an ingress controller](/azure/application-gateway/ingress-controller-overview)
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Apply security and kernel updates to worker nodes.** Understand the AKS node update experience. To protect your clusters, security updates are automatically applied to Linux nodes in AKS. These updates include OS security fixes or kernel updates. Some of these updates require a node reboot to finish the process.
   :::column-end:::
   :::column span="":::
      
[Use kured to automatically reboot nodes to apply updates](/azure/aks/node-updates-kured)
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Set up a container and cluster scanning solution.** Scan containers pushed into Azure Container Registry and gain deeper visibility to your cluster nodes, cloud traffic, and security controls.
   :::column-end:::
   :::column span="":::
      
[Azure Container Registry integration with Security Center](/azure/security-center/defender-for-container-registries-introduction)

[AKS integration with Security Center](/azure/security-center/defender-for-kubernetes-introduction)
   :::column-end:::
:::row-end:::

## Optimize and scale

Now that the application is in production, how can you optimize your workflow and prepare your application and team to scale? Use the optimization and scaling checklist to prepare.  By the end of this section, you'll be able to answer this question:

> [!div class="checklist"]
>
> - Can you enforce governance and cluster policies at scale?

:::row:::
   :::column span="":::
      **Security Checklist**
   :::column-end:::
   :::column span="":::
      **Kubernetes security resources**
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Enforce cluster governance policies.** Apply at-scale enforcements and safeguards on your clusters in a centralized, consistent manner.
   :::column-end:::
   :::column span="":::
      
[Control deployments with Azure Policy](/azure/governance/policy/concepts/policy-for-kubernetes)
   :::column-end:::
:::row-end:::
:::row:::
   :::column span="":::
      
**Rotate cluster certificates periodically.** Kubernetes uses certificates for authentication with many of its components. You might want to periodically rotate those certificates for security or policy reasons.
   :::column-end:::
   :::column span="":::
      
[Rotate certificates in AKS](/azure/aks/certificate-rotation)
   :::column-end:::
:::row-end:::
