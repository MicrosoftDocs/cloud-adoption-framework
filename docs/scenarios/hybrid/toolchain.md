---
title: Introduction to Azure hybrid and multicloud products
description: Introduce the Azure products that help enable hybrid and multicloud solutions
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/11/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
ms.custom: e2e-hybrid
---

# Introduction to hybrid and multicloud products on Azure

Relying on an effective multicloud, multiedge hybrid approach is even more important than it has ever been. Azure has been hybrid by design since the beginning, focused on supporting the hybrid needs of customers, and for the last several years, has centered efforts around hybrid integration across Azure products.

As customers have grown more sophisticated in their adoption of multiple clouds, a number of Azure products have broadened that perspective to support the on-premises, multicloud, edge, and unified operations requirements of customers. Hybrid integration means that customers can consistently build and deploy applications and databases, operate seamlessly, and deliver integrated cloud security across heterogeneous environments, with unified governance and management.

This article won't introduce all of the Azure products with hybrid and multicloud capabilities, but introduces a few of the core products that can unlock this capability across your cloud portfolio.

See the [Azure hybrid and multicloud hub](/hybrid/) for a deeper look at what you can do with Azure's hybrid and multicloud products.

![Overview of the Azure hybrid and multicloud products listed below](../../_images/hybrid/hybrid-hero-slide.png)

This article series will help to integrate these tools into relevant processes-from initial business strategy to workload optimization, and long into your operations management cycles.

## Manage hybrid and multicloud environments with unified operations tools

- [Azure Arc](/azure/azure-arc/?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) this cloud-based service extends the Azure Resource Manager-based management model to non-Azure resources including virtual machines (VMs), Kubernetes clusters, and containerized databases.
- [Azure Arc enabled servers](/azure/azure-arc/servers/overview?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) this hybrid service allows you to manage your Windows and Linux machines, hosted outside of Azure, on your corporate network or other cloud provider. This is similar to how you manage native Azure VMs.
- [Azure Arc enabled Kubernetes](/azure/azure-arc/kubernetes/overview?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) this hybrid service allows you to streamline deployment and management of Kubernetes clusters inside or outside of Azure.
- [Azure Arc enabled SQL Server](/sql/sql-server/azure-arc/overview?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) this part of the Azure Arc enabled servers extends Azure services to SQL Server instances, hosted outside of Azure in the customer's datacenter, on the edge or in a multicloud environment.
- [Azure Arc enabled data services](/azure/azure-arc/data/overview?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) this hybrid service makes it possible to run Azure data services on-premises, at the edge, and in public clouds using Kubernetes and the infrastructure of your choice.
- [Azure Arc enabled SQL Managed Instance](/azure/azure-arc/data/managed-instance-overview?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) this Azure SQL Database data service can be created on your choice of infrastructure that hosts Azure Arc enabled data services.

## Deploy hybrid and multicloud solutions

- [Azure Stack HCI (20h2)](/azure-stack/hci/overview?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) this is a hyperconverged infrastructure (hci) cluster solution that hosts virtualized Windows and Linux operating system (OS) workloads and their storage in a hybrid on-premises environment. A cluster consists of two to 16 physical nodes.
- [Azure Kubernetes Service on Azure Stack HCI](/azure-stack/aks-hci/overview?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) this is an implementation of AKS, which automates running containerized applications at scale on Azure Stack HCI.
- [Azure Kubernetes Service](/azure/aks/intro-kubernetes?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) this is a service that makes it simple to deploy a managed Kubernetes cluster in Azure.
- [Azure IoT Edge](/azure/iot-edge/?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) deploy cloud-based solutions to the edge of your local environment, with full support from Azure to manage those devices and the IoT data they produce.

## Connect your hybrid and multicloud environments

- [Virtual WAN](/azure/virtual-wan/?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) connect to a secure, global branching solution.
- [ExpressRoute](/azure/expressroute/?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) establish a fast, private connection to Microsoft cloud services
- [VPN gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) send encrypted traffic to Azure
- [Azure Firewall](/azure/firewall/overview?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability.
