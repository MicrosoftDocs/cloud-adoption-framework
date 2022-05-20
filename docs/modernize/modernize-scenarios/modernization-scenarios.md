---
title: Modernization scenarios
description: Review scenarios of cloud adoption-related modernizations and how they provided business value.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: internal, seo-caf-modernize
keywords: scenarios, cloud innovation, cloud adoption, cloud framework, cloud adoption framework
---

# Modernization scenarios

The modernization scenarios captured in this section demonstrate the same set of consistent guidelines and processes for modernizing both Microsoft and third-party technologies.

## Scenarios and methodology

The following diagram and table outline scenarios that follow the modernize methodology.

:::image type="content" source="../../_images/modernize/modernize-methodology-graphic.png" alt-text="Graphic showing methodology for modernization broken down into business alignment phases and modernization disciplines.":::

|**Virtual machines**|**Applications**|**Data**|**Hybrid**| **Technology platforms**| **More scenarios**|
|--------------------|----------|---------|-------|----------|---------------|
| [Virtual machines](../../migrate/azure-best-practices/contoso-migration-rehost-vm.md) |[ASP.NET](../../migrate/azure-best-practices/contoso-migration-refactor-web-app-sql.md)  |[SQL Server](../../migrate/azure-best-practices/contoso-migration-rehost-vm-sql-managed-instance.md)  |[Azure Stack](/../azure-stack/index.md)|  SAP (classic and HANA)|[Secure workloads](../../migrate/azure-best-practices/migrate-best-practices-security-management.md) |
|[Linux servers](../../migrate/azure-best-practices/contoso-migration-rehost-linux-vm.md)  |[Java](/azure/developer/java/migration/migration-overview?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)  |[Open-source databases](../../migrate/azure-best-practices/sql-migration.md)  |[VMware](/azure/cloud-adoption-framework/scenarios/azure-vmware/)  |Kubernetes  |[Multi-tenant environments](/azure/lighthouse/how-to/migration-at-scale?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json)  |
|[Virtual desktops](../../scenarios/wvd/index.md) | [PHP](../../migrate/azure-best-practices/contoso-migration-refactor-linux-app-service-mysql.md) |[Analytics](../../migrate/azure-best-practices/analytics/analytics-solutions-overview.md)  |  |[Mainframes](../../infrastructure/mainframe-migration/index.md) |[More modernization examples](../business-alignment/evaluate-modernization-options.md#modernization-examples) |

Watch this short video for more information about using the right tools to move, manage, and optimize your cloud environment.

<!-- markdownlint-disable MD034 -->

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4NHCS]

<!-- markdownlint-enable MD034 -->

## Next steps

If you aren't modernizing a specific scenario, start by following the [four-step Cloud Adoption Framework modernizing process](../../migrate/index.md).
