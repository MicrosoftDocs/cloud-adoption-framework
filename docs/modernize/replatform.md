---
title: Replatform workloads during Azure migration
description: Learn how to replatform workloads during migration to Azure using a comprehensive framework that modernizes your hosting environment with minimal code changes through Azure PaaS services.
author: stephen-sumner
ms.author: pnp
ms.date: 07/16/2025
ms.topic: conceptual
---

1. Replatforming
🏢 On-Prem to Azure
- VM-based components to Azure PaaS services. Example [Reliable web]

☁️ Within Azure
- VM-based components to Azure PaaS services

🌐 Other Cloud to Azure
- VM-based components to Azure PaaS services
- Other cloud PaaS components to Azure PaaS services

Replatforming moves applications to managed cloud services with minimal code changes. This approach is important because it quickly reduces infrastructure management overhead and improves scalability without the high effort of rewriting code. In the context of modernization, replatforming allows you to gain cloud benefits (like managed databases or app services) as part of a migration or for existing cloud VMs that aren’t yet optimized. You should replatform suitable workloads by shifting them from virtual machines to Platform as a Service (PaaS) offerings to achieve quick wins.
Identify components suitable for replatforming with minimal changes. Prime candidates are those currently running on virtual machines or physical servers that could run on a cloud managed service. For example, a web application on an IIS/Apache server could move to Azure App Service, or a self-hosted database could move to Azure SQL Database or Azure Database for PostgreSQL. Ensure the application can be supported by the target PaaS (check language runtime support, database version compatibility, etc.). The trade-off here is that while replatforming requires only minor tweaks (like configuration changes or updating connection strings), not all workloads are compatible without code changes. It’s important to pick workloads where the transition will be smooth, so you can avoid extensive refactoring at this stage.
Migrate to managed services for immediate benefits. Once you have targets, execute the move to the PaaS service. For instance, containerize an application and deploy it to Azure Kubernetes Service (AKS) or move background jobs from a Windows VM to Azure Functions (serverless). Keep code changes minimal – ideally none besides those needed to connect to the new environment (such as using a managed storage connection string instead of local disk). Take advantage of cloud migration tools: use Azure Migrate to assist with moving databases or use deployment tools to push your app to App Service. By doing this, you quickly eliminate the need to maintain underlying servers and you gain built-in capabilities like auto-scaling, patch management, and high availability. The benefit is faster time to value, though the trade-off is that you might not fully optimize resource usage or address deeper code issues at this stage.
Make necessary configuration adjustments and optimizations post-migration. After replatforming, adjust things like auto-scaling rules, performance tier of managed databases, and enable monitoring on the new services. For example, if you moved a website to Azure App Service, configure staging slots for safe deployments and turn on Application Insights for monitoring. Verify that application settings (environment variables, connection strings) are correctly transferred to the new platform’s configuration system (like App Service Application Settings or Key Vault for secrets). You should conduct testing in the new environment to ensure the workload behaves as before (or better). A key consideration is that replatforming may not solve all existing performance or code issues – it mainly offloads infrastructure management. It’s important to realize this approach yields immediate cloud benefits, but further refactoring might be needed later to fully optimize the application.
Pros: Replatforming is relatively fast and low-risk since you’re not altering much code. It immediately provides benefits like reduced ops burden (the cloud service handles patches, backups, etc.) and potentially better scalability and reliability out-of-the-box.
Cons: Because the application’s architecture and code remain largely the same, you might not fully utilize cloud-native features. Some inefficiencies or limitations of the original design could persist. Replatforming might also incur changes in pricing structure (e.g., moving to a managed database might have different costs) – it’s important to evaluate those. Overall, replatforming is a great first step during migration or early cloud adoption, giving “quick wins” that can later be built upon with deeper modernization.