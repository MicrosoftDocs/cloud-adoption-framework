---
title: Machine learning security
description: Machine learning poses unique security issues for businesses, and a number of security principles must be considered when designing and assessing machine learning architectures.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/04/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Machine learning security

Machine learning poses unique security issues for businesses, and a number of security principles must be considered when designing and assessing machine learning architectures.

- **Resilience:** ML Systems should be able to identify abnormal behaviours and prevent manipulation or coercion.
- **Discretion:** Any data access scenarios involving AI should limit access to the data to the minimum extent required.
- **Malicious data:** Machine Learning algorithms must protect against maliciously-introduced data.
- **Transparency and accountability:** AI must have built in forensic capabilities to provide transparency and accountability and to function as an early form of “AI intrusion detection” to enable engineers to understand the exact point in time a decision was made and the data that was used.
- **Secured environments:** Access to development, training and inferencing environments must be secured such data and model results / predictions can not be compromised.

## Securing inference environment: Azure Kubernetes Service deployment

As it's recommended to use Azure Kubernetes Service (AKS) for inferencing in production environment, there are two options available for securing an inference environment with AKS in your virtual network:

- Deploy or attach an AKS cluster with public IP address to your virtual network.
- Attach a private AKS cluster to your virtual network.

Default AKS clusters have a control plane with public IP address. If you need private IP address for your AKS cluster, then you need to use the private AKS cluster. For inference, the AKS cluster and Azure Machine Learning workspace must be in the same virtual network.

For securing the default AKS inferencing cluster inside your virtual network, you need to specify three IP addresses:

1. **AKS address range** is specified through CIDR notation. It must not overlap with any of your other subnet range.
1. **AKS DNS service IP address** is assigned for the DNS service within the Kubernetes. It must be within the Kubernetes Service address range.
1. **Docker bridge address** is assigned to the Docker bridge, which executes your scoring script as a container. This address must not be within any of your subnet IP range or the AKS address range.

An example for IP address range and assignment practice for inferencing in virtual network are [here](/azure/machine-learning/how-to-network-security-overview#secure-the-inferencing-environment).

When using private AKS cluster, you may also configure the AKS to use an internal (private) load balancer. In this case, you can be sure that only private IPs are allowed. You can create an AKS cluster that uses internal load balancer through Python SDK or Azure CLI extension, but not through Azure Machine Learning Studio.

When using a private load balancer, you have to grant the AKS cluster a ‘Network Contributor’ role to the resource group that contains the virtual network.

You may find instruction configuring private load balancer and how to grant the aforementioned role in [here](/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python#internal-aks-load-balancer).