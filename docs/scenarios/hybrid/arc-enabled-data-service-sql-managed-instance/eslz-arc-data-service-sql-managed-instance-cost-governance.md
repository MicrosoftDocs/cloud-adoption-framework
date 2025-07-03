---
title: Cost governance for Azure Arc-enabled SQL Managed Instance
description: Learn design considerations and recommendations on cost governance for Azure Arc-enabled SQL Managed Instance.
author: mrhoads
ms.author: mirhoads
ms.date: 09/22/2022
ms.topic: conceptual
ms.custom: e2e-hybrid, think-tank
---

# Cost governance for Azure Arc-enabled SQL Managed Instance

Cost governance is the continuous process of implementing policies to control the costs of services you use in Azure. This article provides cost governance considerations and recommendations for you to keep in mind while using Azure Arc-enabled data services.

## Cost of Azure Arc-enabled SQL Managed Instance

Azure Arc-enabled SQL Managed Instance (MI) provides two types of service tiers:

- General Purpose
- Business Critical

Both tiers are priced per vCore and like many other Azure services, offer reserved instances and Azure Hybrid Benefit for more savings.  

The costs of Arc-enabled SQL MI are in addition to any extra functionality deployed to your Azure Arc-enabled Kubernetes cluster. For more information on design considerations and recommendations for the Kubernetes cluster, see [Kubernetes cost governance](../arc-enabled-kubernetes/eslz-arc-kubernetes-cost-governance.md).

## Cost of High Availability Infrastructure

While not a direct cost of Arc-enabled SQL MI, when you deploy an instance in the business critical tier, it includes high availability. This approach means you'll need to deploy and maintain another Kubernetes cluster.

## Design considerations

- **Service tier** Define the business requirements to determine the most appropriate service tier. In addition, consider the extra infrastructure needed to support [business continuity and disaster recovery](./eslz-arc-data-service-sql-managed-instance-business-continuity-disaster-recovery.md).

- **Connectivity modes** How usage and billing information is sent to Azure varies depending on whether one is using the directly connected or indirectly connected mode. If you're using the indirectly connected mode, consider how the usage and billing information is regularly sent to Azure.

- **Reserved instances** Based on the expected time for Arc-enabled SQL MI, consider whether pay-as-you-go, a one-year reserved instance, or a three-year reserved instance offers savings.

- **Azure Hybrid Benefit** For SQL Server, Azure Hybrid Benefits offers savings on both service tiers of Arc-enabled SQL MI.

Consider the combination of service tier needs, timeline for Arc-enabled SQL MI deployment(s), and whether your organization has [Azure Hybrid Benefit](/azure/azure-sql/azure-hybrid-benefit). Also, [Dev/Test pricing](https://azure.microsoft.com/pricing/dev-test/) is available for both service tiers, though it's only for development use. Review the [cost management considerations](../../../ready/landing-zone/design-area/governance.md#cost-management-considerations) of Azure landing zones to understand broad cost-related considerations. Finally, consider using the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to estimate cost.

## Design recommendations

The following sections contain design recommendations for Arc-enabled SQL MI cost governance.

> [!NOTE]
> Pricing information shown in these screenshots are examples that demonstrate cost governance concepts but don't necessarily reflect the actual pricing information you might see in your own Azure Arc deployments.

### Service tier

The biggest cost component in an Arc-enabled SQL MI deployment is the service tier you select. Choose the service tier that meets your business requirements. For more information on service tiers, see the [Service tier comparison](/azure/azure-arc/data/service-tiers#service-tier-comparison). Consider your needs for high-availability and read scale-out, among other factors. If you're migrating an existing SQL Server deployment, think about the SQL edition currently in use and required features for the Arc-enabled SQL MI deployment.

:::image type="content" source="./media/arc-enabled-data-svc-sql-mi-cost-01.png" alt-text="A screenshot of a service tier and estimated cost summary." lightbox="./media/arc-enabled-data-svc-sql-mi-cost-01.png":::

### Connectivity mode

If you're using the directly connected mode, no further action is needed. The necessary usage and billing data is sent to Azure. If you're using the indirectly connected mode, establish an automated mechanism to transmit this data based on what's described in [Upload usage data to Azure in indirect mode](/azure/azure-arc/data/upload-usage-data). Configure a cron job or other automated task to upload the data on a daily basis and monitor the job for failure. While the uploaded data is only required to be sent every 30 days, uploading it on a daily basis reduces the chance of entering a degraded state.

### Reserved instances

Based on the expected duration of the Arc-enabled SQL MI deployment, choose a one-year or three-year reserved instance if it results in savings for your organization. For more information on reserved VM instances, see the [Cloud Adoption Framework](../../../govern/cost-management/best-practices.md#best-practice-use-azure-reserved-vm-instances) best practices.

:::image type="content" source="./media/arc-enabled-data-svc-sql-mi-cost-02.png" alt-text="A screenshot of a reserved instance purchase overview." lightbox="./media/arc-enabled-data-svc-sql-mi-cost-02.png":::

### Azure Hybrid Benefit

If your organization has [Azure Hybrid Benefit](/azure/azure-sql/azure-hybrid-benefit), use it to lower the cost of Arc-enabled SQL MI.

### Governance

- Review the recommendations in the [resource organization](eslz-arc-data-service-sql-managed-instance-resource-organization.md) and [governance disciplines](eslz-arc-data-service-sql-managed-instance-governance-disciplines.md) critical design areas. The recommendations help you implement a governance strategy, organize your resources for better cost control and visibility, and avoid unnecessary costs by using the least privileged access model for onboarding and management. Also, review the broader recommendations for Azure Arc-enabled Kubernetes [resource organization](../arc-enabled-kubernetes/eslz-arc-kubernetes-resource-organization.md) and [governance discipline](../arc-enabled-kubernetes/eslz-arc-kubernetes-governance-disciplines.md) to understand governance principles outside of a data services context.

- Use [Microsoft Cost Management](/azure/cost-management-billing/costs/quick-acm-cost-analysis) to understand Arc-enabled SQL MI costs.

:::image type="content" source="./media/arc-enabled-data-svc-sql-mi-cost-03.png" alt-text="A screenshot of cost analysis." lightbox="./media/arc-enabled-data-svc-sql-mi-cost-03.png":::

### Azure Policy for Kubernetes

- Review [Azure Policy for Kubernetes pricing](https://azure.microsoft.com/pricing/details/azure-arc/). An optional component that might complement Arc-enabled SQL MI by, for example, enforcing tagging or controlling the enablement of Azure services.
- Review the [Security, governance, and compliance critical design area](.\eslz-arc-data-service-sql-managed-instance-management-disciplines.md) to learn best practices and recommendations for implementing Azure Policy for Kubernetes. These best practices include how to:
  - Enforce tagging for better cost visibility across clusters
  - Control the enablement of Azure services

## Next steps

For more information about your hybrid and multicloud journey, see the following articles:

- Learn how to [Manage hybrid and multicloud environments](../manage.md).
- Explore Azure Arc-enabled data services automated scenarios with [Azure Arc Jumpstart Project](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_data/).
- Learn more about Azure Arc in the [Azure Arc learning path on Microsoft Learn](/learn/paths/manage-hybrid-infrastructure-with-azure-arc/).
- See the [Frequently Asked Questions - Azure Arc-enabled](/azure/azure-arc/kubernetes/faq) to find answers to the most common questions.
