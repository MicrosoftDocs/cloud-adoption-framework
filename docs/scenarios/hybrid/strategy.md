---
title: Strategy for adopting unified operations
description: Learn about strategic considerations of hybrid and multicloud operations.
author: stephen-sumner
ms.author: pnp
ms.date: 04/21/2021
ms.topic: conceptual
ms.custom: e2e-hybrid, think-tank
---

# Define a strategy for hybrid and multicloud operations

Hybrid cloud refers to a mix of on‑premises/private infrastructure and public cloud services working together, while multicloud means using multiple cloud providers concurrently. Today’s enterprises often have siloed teams, distributed sites, and sprawling systems spanning on-premises and various clouds. In fact, over 90% of large organizations use more than one public cloud. The challenge is to unify these disparate environments in a way that is secure, well-managed, and enables modernization from cloud to edge.

This guidance presents a prescriptive end-to-end framework for unifying and managing hybrid and multicloud environments. A central theme is how Azure solutions, like Azure Arc, Azure Monitor, AKS, Microsoft Fabric, Azure IoT, and Azure Local, enable you to consolidate control and modernize IT across all environments while maintaining security and compliance. The goal is to enable you to create an authoritative operating model that breaks down silos and delivers consistent practices everywhere. We show how to secure, manage, and modernize resources from cloud to edge, unifying previously isolated teams and systems under one cloud-driven strategy.

| Azure Solution | Role in Unified Hybrid/Multicloud Strategy |
| --- | --- |
    Azure Arc
    Extends Azure’s management and security to any infrastructure, on-premises or other clouds. Azure Arc projects existing servers, Kubernetes clusters, and databases into Azure Resource Manager, giving you a single control plane to manage and govern your entire environment. With Arc, you can secure, develop, and operate workloads with Azure services anywhere – enabling central policy, monitoring, and automation across diverse platforms.
  
  
    Azure Monitor
    Provides end-to-end observability across applications, infrastructure, and networks in every environment. Azure Monitor unifies metrics, logs, and traces from Azure and Arc-connected resources into one view, so teams get complete insight into distributed systems. This helps break down operational silos by allowing a single monitoring toolset for all workloads, whether running in Azure, on-prem, or other clouds, improving cross-team visibility and rapid troubleshooting.
  
  
    Azure Kubernetes Service (AKS)
    Azure’s managed Kubernetes platform for deploying and scaling containerized applications anywhere. AKS in Azure provides easy cluster management and integrates with Azure AD and Monitor for consistency. Through Azure Arc, you can also deploy AKS on-premises or in other clouds (e.g. on Azure Local or IoT devices), achieving consistent container orchestration across cloud and edge. This enables teams to use a common Kubernetes-based approach for microservices in any location, unifying the application platform and dev processes.
  
  
    Microsoft Fabric
    Unified data analytics platform (SaaS) that connects every data source and analytics service on a single, AI-powered platform. Microsoft Fabric breaks down data silos by integrating data engineering, warehousing, Power BI, and AI analytics into one environment. In a hybrid context, Fabric can connect on-prem databases, cloud data lakes, and real-time streams, allowing everyone to access and act on data consistently. This unified data foundation means insights and BI dashboards can span across distributed sites with ease – crucial for a modern data-driven organization.
  
  
    Azure IoT Operations
    A comprehensive IoT platform for building interoperable solutions that bridge physical operations with the cloud. Azure IoT Operations (part of Azure’s IoT suite) lets you connect and manage IoT devices and edge gateways at scale, while normalizing data and running analytics at the edge. It integrates with Azure Arc for unified management of IoT infrastructure, so your far-flung operational technology (factories, retail stores, remote sites) can be secured and governed like the rest of IT. This unifies OT and IT teams, bringing formerly siloed operational systems into the cloud-managed fold.
  
  
    Azure Local
    An on-premises extension of Azure (formerly Azure Stack HCI) providing Azure-consistent infrastructure at edge or local datacenters. Azure Local enables you to run VMs and containers on-premises with cloud-like ease, and it comes Arc-enabled by design. This allows you to grow your operations with flexible Azure infrastructure while maintaining control at your sites. Essentially, Azure Local brings Azure’s capabilities to wherever you need them – from factory floors to branch offices – and ensures those resources are part of your unified Azure management and security framework.