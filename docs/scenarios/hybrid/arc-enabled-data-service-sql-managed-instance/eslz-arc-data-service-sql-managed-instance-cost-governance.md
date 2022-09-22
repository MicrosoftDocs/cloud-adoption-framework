---
title: Cost governance for Azure Arc-enabled SQL Managed Instance
description: Learn design considerations and recommendations for cost governance for Azure Arc-enabled SQL Managed Instance
author: mrhoads
ms.author: mirhoads
ms.date: 09/21/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid, think-tank
---

# Cost governance for Azure Arc-enabled SQL Managed Instance

Cost governance is the continuous process of implementing policies to control the costs of services you use in Azure. This article provides cost governance considerations and recommendations for you to keep in mind while using Azure Arc-enabled data services.

## Cost of Azure Arc-enabled SQL Managed Instance

Azure Arc-enabled SQL Managed Instance (MI) provides two types of service tiers:

- General Purpose
- Business Critical

Both tiers are priced per vCore and like many other Azure services, offer reserved instances and Azure Hybrid Benefit for more savings.  

The costs of Arc-enabled SQL MI are in addition to any extra functionality deployed to your Azure Arc-enabled Kubernetes cluster. For more information on design considerations and recommendations for the Kubernetes cluster, see [Kubernetes cost governance](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-cost-governance).

## Cost of High Availability Infrastructure

While not a direct cost of Arc-enabled SQL MI, when you deploy an instance in the business critical tier, it includes high availability. This approach means you'll need to deploy and maintain another Kubernetes cluster.

## Design considerations

- **Service tier** Define the business requirements to determine the most appropriate service tier. In addition, consider the extra infrastructure needed to support [business continuity and disaster recovery](./eslz-arc-datasvc-sqlmi-bcdr.md).

- **Connectivity modes** How usage and billing information is sent to Azure varies depending on whether one is using the directly connected or indirectly connected mode. If you're using the indirectly connected mode, consider how the usage and billing information is regularly sent to Azure.

- **Reserved instances** Based on the expected time for Arc-enabled SQL MI, consider whether pay-as-you-go, a one-year reserved instance, or a three-year reserved instance offers savings.

- **Azure Hybrid Benefit** For SQL Server, Azure Hybrid Benefits offers savings on both service tiers of Arc-enabled SQL MI.

Consider the combination of service tier needs, timeline for Arc-enabled SQL MI deployment(s), and whether your organization has [Azure Hybrid Benefit](/azure/azure-sql/azure-hybrid-benefit?view=azuresql&tabs=azure-portal). Also, [Dev/Test pricing](/pricing/dev-test/) is available for both service tiers, though it's only for development use. Review the [cost management considerations](/azure/cloud-adoption-framework/ready/landing-zone/design-area/governance#cost-management-considerations) of Azure landing zones to understand broad cost-related considerations. Finally, consider using the [Azure Hybrid Benefit Savings Calculator](https://azure.microsoft.com/pricing/hybrid-benefit/#calculator) and the [Total Cost of Ownership Calculator](https://azure.microsoft.com/pricing/tco/) to determine potential cost savings.

## Design recommendations

The following sections contain design recommendations for Arc-enabled SQL MI cost governance.

> [!NOTE]
> Pricing information shown in the provided screenshots are examples and provided to demonstrate cost governance concepts but don't reflect the actual pricing information you might see in your own Azure Arc deployments.

### Service tier

The biggest cost component in an Arc-enabled SQL MI deployment is the service tier you select. Choose the service tier that meets your business requirements. For more information on service tiers, see the [Service tier comparison](/azure/azure-arc/data/service-tiers#service-tier-comparison). Consider your needs for high-availability and read scale-out, among other factors. If you're migrating an existing SQL Server deployment, think about the SQL edition currently in use and required features for the Arc-enabled SQL MI deployment.

[![A screenshot of service tier and estimated cost summary.](./media/arc-enabled-data-svc-sql-mi-cost-01.png)](./media/arc-enabled-data-svc-sql-mi-cost-01.png#lightbox)

### Connectivity mode

If you're using the directly connected mode, no further action is needed. The necessary usage and billing data is sent to Azure. If you're using the indirectly connected mode, establish an automated mechanism to transmit this data based on what's described in [Upload usage data to Azure in indirect mode](/azure/azure-arc/data/upload-usage-data). Configure a cron job or other automated task to upload the data on a daily basis and monitor the job for failure. While the uploaded data is only required to be sent every 30 days, uploading it on a daily basis reduces the chance of entering a degraded state.

### Reserved instances

Based on the expected duration of the Arc-enabled SQL MI deployment, choose a one-year or three-year reserved instance if it results in savings for your organization. For more information on reserved VM instances, see the [Cloud Adoption Framework](/azure/cloud-adoption-framework/govern/cost-management/best-practices#best-practice-use-azure-reserved-vm-instances) best practices.

[![A screenshot of reservation purchase overview.](./media/arc-enabled-data-svc-sql-mi-cost-02.png)](./media/arc-enabled-data-svc-sql-mi-cost-02.png#lightbox)

### Azure Hybrid Benefit

If your organization has [Azure Hybrid Benefit](/azure/azure-sql/azure-hybrid-benefit?view=azuresql&tabs=azure-portal), use it to lower the cost of Arc-enabled SQL MI.

### Governance

- Review the recommendations in the [resource organization](./eslz-arc-datasvc-sqlmi-resource-organization.md) and [governance disciplines](./eslz-arc-datasvc-sqlmi-governance-disciplines.md) critical design areas. The recommendations help you implement a governance strategy, organize your resources for better cost control and visibility, and avoid unnecessary costs by using the least privileged access model for onboarding and management. Also, review the broader recommendations for Azure Arc-enabled Kubernetes [resource organization](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-resource-organization) and [governance discipline](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-kubernetes/eslz-arc-kubernetes-governance-disciplines) to understand governance principles outside of a data services context.

- Use [Azure cost management and billing](/azure/cost-management-billing/costs/quick-acm-cost-analysis) to understand Arc-enabled SQL MI costs.

[![A screenshot of cost analysis.](./media/arc-enabled-data-svc-sql-mi-cost-03.png)](./media/arc-enabled-data-svc-sql-mi-cost-03.png#lightbox)

### Azure Policy for Kubernetes

- Review [Azure Policy for Kubernetes pricing](https://azure.microsoft.com/pricing/details/azure-arc/).  An optional component that might complement Arc-enabled SQL MI by, for example, enforcing tagging or controlling the enablement of Azure services.
- Review the [Security, governance, and compliance critical design area](./eslz-arc-datasvc-sqlmi-management-disciplines.md) to learn best practices and recommendations for implementing Azure Policy for Kubernetes. These best practices include:
  - Enforcing tagging for better cost visibility across clusters
  - Controlling the enablement of Azure services

## Next steps

For more information about your hybrid and multicloud cloud journey, see the following articles:

- Learn how to [Manage hybrid and multicloud environments](/azure/cloud-adoption-framework/scenarios/hybrid/manage).
- Experience Azure Arc-enabled data services automated scenarios with [Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_data/).
- Learn more about Azure Arc in the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/).
- Review the Cloud Adoption Framework [best practices and recommendations](/azure/cloud-adoption-framework/get-started/manage-costs) to efficiently manage your cloud costs.
- See the [Frequently Asked Questions - Azure Arc-enabled](/azure/azure-arc/kubernetes/faq) to find answers to most common questions.
