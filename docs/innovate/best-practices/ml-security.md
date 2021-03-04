---
title: Machine learning security
description: Machine learning presents unique security considerations for businesses, and companies should consider several security principles when designing and assessing machine learning architectures.
author: shinchan75034
ms.author: brblanch
ms.date: 01/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: think-tank
---

# Machine learning security

Machine learning presents unique security considerations for businesses, and companies should consider several security principles when designing and assessing machine learning architectures.

- **Resilience:** Machine learning systems should identify abnormal behavior and prevent manipulation or coercion.

- **Discretion:** Any data access scenarios involving AI should limit access to the data to the minimal extent.

- **Malicious data:** Machine learning algorithms must protect against maliciously introduced data.

- **Transparency and accountability:** AI must have built-in forensic capabilities that provide transparency and accountability. These capabilities function as an early form of AI intrusion detection to help engineers understand the exact point in time a decision was made and the data that was used.

- **Secure environments:** Access to development, training, and inference environments must be secured to protect data and model results/predictions.

## Deploy Azure Kubernetes Service to secure an inference environment

Azure Kubernetes Service (AKS) is recommended for inference in a production environment. Two options are available in your virtual network:

- Deploy or attach an AKS cluster with a public IP address to your virtual network.
- Attach a private AKS cluster to your virtual network.

Default AKS clusters have a control plane with a public IP address. If you need a private IP address for your AKS cluster, use the private AKS cluster. For inference, the AKS cluster and Azure Machine Learning workspace must be in the same virtual network.

For securing the default AKS inference cluster inside your virtual network, specify three IP addresses:

- CIDR notation specifies an **AKS address range**. It must not overlap with any other subnet range.

- An **AKS DNS service IP address** is assigned for the DNS service within AKS. It must be within the AKS address range.

- A **Docker bridge address** is assigned to the Docker bridge, which executes your scoring script as a container. This address must not be within your subnet IP or AKS address range.

You can configure AKS to use an internal and private load balancer with a private AKS cluster. Only private IPs are allowed for this scenario, and you can use a Python SDK or Azure command-line extension but not Azure Machine Learning studio for this task. When using a private load balancer, you have to grant the Network Contributor role to the AKS cluster resource group that contains the virtual network.

## Next steps

- Reference how to [secure an Azure Machine Learning inferencing environment with virtual networks](/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python#secure-vnet-traffic) to see an IP address range and the steps to perform inference in a virtual network.

- See the [Network Contributor role section](/azure/machine-learning/how-to-secure-inferencing-vnet?tabs=python#network-contributor-role) to learn how to configure a private load balancer and set up a Network Contributor role.
