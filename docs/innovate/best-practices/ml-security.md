---
title: Machine learning security
description: Machine learning presents unique security considerations for businesses, and a number of security principles must be considered when designing and assessing machine learning architectures.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/07/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
---

# Machine learning security

Machine learning presents unique security considerations for businesses, and a number of security principles must be considered when designing and assessing machine learning architectures.

- **Resilience:** Machine learning systems should identify abnormal behavior and prevent manipulation or coercion.

- **Discretion:** Any data access scenarios involving AI should limit access to the data to the minimum extent required.

- **Malicious data:** Machine learning algorithms must protect against maliciously introduced data.

- **Transparency and accountability:** AI must have built in forensic capabilities to provide transparency and accountability and to function as an early form of “AI intrusion detection” to enable engineers to understand the exact point in time a decision was made and the data that was used.

- **Secure environments:** Access to development, training and inferencing environments must be secured such data and model results / predictions can not be compromised.

## Deploy Azure Kubernetes Service to secure an inference environment

It's recommended to use Azure Kubernetes Service (AKS) for inference in a production environment. Two options are available in your virtual network:

- Deploy or attach an AKS cluster with public IP address to your virtual network.
- Attach a private AKS cluster to your virtual network.

Default AKS clusters have a control plane with a public IP address. If you need a private IP address for your AKS cluster, use the private AKS cluster. For inference, the AKS cluster and Azure Machine Learning workspace must be in the same virtual network.

For securing the default AKS inference cluster inside your virtual network, specify three IP addresses:

1. CIDR notation specifies an **AKS address range**. It must not overlap with any other subnet range.

1. An **AKS DNS service IP address** is assigned for the DNS service within AKS. It must be within the AKS address range.

1. A **Docker bridge address** is assigned to the Docker bridge, which executes your scoring script as a container. This address must not be within your subnet IP range or the AKS address range.

Reference [Secure the inference environment](/azure/machine-learning/how-to-network-security-overview#secure-the-inferencing-environment) to see an IP address range and a practice assignment for inference in a virtual network.

You can configure AKS to use an internal (private) load balancer when using a private AKS cluster. Only private IPs are allowed in this scenario. You can create an AKS cluster that uses internal load balancer through a Python SDK or Azure command-line interfact extension but not through Azure Machine Learning Studio. When using a private load balancer, you have to grant a 'Network contributor' role to the AKS cluster resource group containing the virtual network.

You may find instruction configuring private load balancer and how to grant the aforementioned role in [here](/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python#internal-aks-load-balancer).