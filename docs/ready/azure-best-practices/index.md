---
title: Best practices for Azure readiness
description: Learn about best practices and extra guidance to help your team establish and prepare your Azure environment.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/10/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Best practices for Azure readiness

Cloud readiness requires equipping staff with the technical skills needed to start a cloud adoption effort and prepare your migration target environment for the assets and workloads you'll move to the cloud. Read these best practices and more guidance to help your team prepare your Azure environment.

## Azure fundamentals

Organize and deploy your assets in the Azure environment.

- [Azure fundamental concepts](../considerations/fundamental-concepts.md). Learn key Azure concepts and terms, and how these concepts relate to one another.
- [Create your initial subscriptions](./initial-subscriptions.md). Establish an initial set of Azure subscriptions to begin your cloud adoption.
- [Scale your Azure environment using multiple subscriptions](../azure-best-practices/scale-subscriptions.md). Understand reasons and strategies for creating additional subscriptions to scale your Azure environment.
- [Organize your resources with Azure management groups](../azure-best-practices/organize-subscriptions.md). Learn how Azure management groups can manage resources, roles, policies, and deployment across multiple subscriptions.
- [Follow recommended naming and tagging conventions](../azure-best-practices/naming-and-tagging.md). Review detailed recommendations for naming and tagging your resources. These recommendations support enterprise cloud adoption efforts.
- [Create hybrid cloud consistency](../considerations/hybrid-consistency.md). Create hybrid cloud solutions that provide the benefits of cloud innovation while maintaining many of the conveniences of on-premises management.

## Networking

Prepare your cloud networking infrastructure to support your workloads.

- [Networking decisions](../considerations/networking-options.md). Choose the networking services, tools, and architectures that will support your organization's workload, governance, and connectivity requirements.
- [Virtual network planning](/azure/virtual-network/virtual-network-vnet-plan-design-arm?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Plan virtual networks based on your isolation, connectivity, and location requirements.
- [Best practices for network security](/azure/security/fundamentals/network-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Learn best practices for addressing common network security issues using built-in Azure capabilities.
- [Perimeter networks](./perimeter-networks.md). Enable secure connectivity between your cloud networks and your on-premises or physical datacenter networks, along with any connectivity to and from the internet.
- [Hub and spoke network topology](./hub-spoke-network-topology.md). Efficiently manage common communication or security requirements for complicated workloads and address potential Azure subscription limitations.

## Identity and access control

Design your identity and access control infrastructure to improve the security and management efficiency of your workloads.

- [Azure identity management and access control security best practices](/azure/security/fundamentals/identity-management-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Learn best practices for identity management and access control using built-in Azure capabilities.
- [Best practices for Azure role-based access control](../considerations/roles.md). Enable fine-grained and group-based access management for resources organized around user roles.
- [Securing privileged access for hybrid and cloud deployments in Azure Active Directory](/azure/active-directory/users-groups-roles/directory-admin-roles-secure?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Ensure that your organization's administrative access and privileged accounts are secure across your cloud and on-premises environment.

## Storage

- [Azure Storage guidance](../considerations/storage-options.md). Select the right Azure Storage solution to support your usage scenarios.
- [Azure Storage security guide](/azure/storage/blobs/security-recommendations?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Learn about security features in Azure Storage.

## Databases

- [Choose the correct SQL Server option in Azure](/azure/sql-database/sql-database-paas-vs-sql-server-iaas?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Choose the PaaS or IaaS solution that best supports your SQL Server workloads.
- [Database security best practices](/azure/security/azure-database-security-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Learn best practices for database security on the Azure platform.
- [Choose the right data store](/azure/architecture/guide/technology-choices/data-store-overview). Select the right data store to meet your requirements. Hundreds of implementation choices are available among SQL and NoSQL databases. Data stores are often categorized by how they structure data and the types of operations they support. This article describes several common storage models.

## AI + Machine Learning

- [Organize and set up Azure Machine Learning environments](./ai-machine-learning-resource-organization.md). Learn about key decision points in setting up Azure Machine Learning for your organization.

## Cost management

- [Tracking costs across business units, environments, and projects](./track-costs.md). Learn best practices for creating proper cost-tracking mechanisms.
- [How to optimize your cloud investment with Azure Cost Management + Billing](/azure/cost-management-billing/costs/cost-mgt-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Implement a strategy for cost management and learn about the tools available for addressing cost challenges.
- [Create and manage budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Learn to create and manage budgets using Azure Cost Management + Billing.
- [Export cost data](/azure/cost-management-billing/costs/tutorial-export-acm-data?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Learn to export cost data using Azure Cost Management + Billing.
- [Optimize costs based on recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Learn to identify underutilized resources and reduce costs by using Azure Cost Management + Billing and Azure Advisor.
- [Use cost alerts to monitor usage and spending](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Learn to use Azure Cost Management + Billing alerts to monitor your Azure usage and spending.
