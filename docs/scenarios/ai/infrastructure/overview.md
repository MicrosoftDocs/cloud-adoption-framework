---
title: Adopt AI on Azure infrastructure (IaaS)
description: Discover how to build AI applications on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Adopt AI on Azure infrastructure (IaaS) - Recommendations to build AI applications with Azure infrastructure services (IaaS)

Here's your content converted to Markdown:

---

# Adopt AI on Azure infrastructure (IaaS)

This guidance shows you how to design an AI environment to deploy high-performance computing infrastructure to train and run models using infrastructure-as-a-service (IaaS) solutions. Choosing IaaS over PaaS for AI solutions is ideal in specific scenarios. Use IaaS when you need maximum control over the environment and configurations, when your AI workload has unique requirements not supported by PaaS, or when you need a hybrid cloud setup and integration with legacy systems. IaaS is also preferred for granular cost control, especially with highly variable workloads

## How to build AI workloads on Azure infrastructure (IaaS)

This is a quick summary of the essential steps for deploying AI using Azure IaaS.

1. *Set up Azure account.* A customer agreement and Microsoft Entra tenant configured is a prerequisite to adopting AI on Azure IaaS. For more information, see Azure billing offers and Active Directory tenants.

1. *Design AI environment.* Use the guidance in the following design areas to prepare an environment for adopting AI using infrastructure-as-a-service solutions. 

1. *Deploy infrastructure.* Use one of two implementation options. One implementation uses Azure landing zones as a prerequisite and builds an application landing zone on top of it. The other implementation option allows you to do a custom build, using just the resources you need to meet your objectives.

1. *Train AI model.* Upload and store the training dataset in Azure, clean and normalize the data. Provision GPU-enabled VMs and deploy training scripts. Develop or fine-tune models like GPT. Validate and test model output and performance.

1. *Deploy AI model.* Save the trained AI model to Azure Blob Storage, then set up VMs for inference with necessary libraries. Deploy the model as a web service using Flask or FastAPI. Ensure scalability with Azure Kubernetes Service (AKS). Monitor the deployment with Azure Monitor, Grafana, and robust logging tools to track performance and troubleshoot efficiently.