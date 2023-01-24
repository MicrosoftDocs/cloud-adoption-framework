---
title: Migrate
description: How to migrate a workload to another region.
author: SomilGanguly
ms.author: ssumner
ms.date: 2/3/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: relocate
ms.custom: internal, seo-caf-relocate
keywords: cloud adoption, cloud framework, cloud adoption framework
---
# How to migrate a workload to another region

The Migrate step of relocation is where you move the workload to the new region. Depending on your workload, you might have a few technical requirements to prepare, but the plan should be clear. You should be ready to execute the migration.

:::image type="content" source="../_images/relocate/caf-relocate-migrate.png" alt-text="Image showing the relocation process and highlights the Migrate process. In the relocation process, there are two phases and five steps. The first phase is the initiate phase, and it has one step called initiate. The second phase is the Move phase. It has four steps that you repeat for each workload. The steps are Evaluate, Select, Migrate, and Cutover." lightbox="../_images/relocate/caf-relocate-migrate.png" border="false":::
*Figure 1. The Migrate step of relocation.*

## Prepare

You might need to prepare the target region before relocating the workload. If the relocation adds to your Azure Landing Zone footprint, you should use the ALZ guidance and return for workload guidance. For more information, see [how to add regions to ALZ](/azure/cloud-adoption-framework/ready/enterprise-scale/faq#how-do-we-enable-more-azure-regions-when-we-use-azure-landing-zone-architecture). As needed, follow these steps to prepare your workload environment before relocation.

**(1) Create new subscriptions if needed.** It’s not necessary to create a new subscription when relocating, but the workload might require a subscription change if you’re restructuring the services and resources. Subscriptions serve as a boundary for budgets, policies, and role-based access controls (RBACs). We encourage you to considered relocation as an as-is effort because creating a new subscription adds complexity. You need to validate budgets, policies, and RBACs. If you don’t move all the resource in a subscription, then you need to rescope the identity and security policies to match the smaller grouping of resources. To create a new subscription, you need to create, scope, and implement the required Azure policies and RBAC roles in the target subscription. The goal is to keep the governance and security posture in the new region.

**(2) Configure a new domain name if needed.** When there's a change in the custom domain of the workload, you need to configure a new domain name. Create the new hostname, assign it to your application or service, and then validate the name resolution. For more information, see:

- [Add your custom domain](/azure/active-directory/fundamentals/add-custom-domain)
- [Map DNS name to App Service plan](/azure/app-service/manage-custom-dns-buy-domain#prepare-the-app)

**(3) Create new SSL/TLS certificates if needed.** You need to create new SSL/TLS certificates (X.509) for any new domain name. These certificates enable public-private key encryption and secure network communication (HTTPS). Use Azure Key Vault to create or import X.509 certificates. For more information, see:

- [Azure Key Vault certificates](/azure/key-vault/certificates/about-certificates)
- [Certificate creation methods](/azure/key-vault/certificates/create-certificate)

**(4) Relocate Azure Key Vault.** You should relocate your Azure Key Vault before moving your workload. We recommend one key vault per application environment. Key Vaults shouldn’t share secrets across regions to ensure confidentiality. You might need to create a new Azure Key Vault in the new target region.

## Migrate workload services

You can begin migrating the services in your workload. For execution, follow available guidance for the relocation tool you selected. Azure Resource Mover and Azure Site Recovery have step-by-step tutorials to follow for service relocation. Infrastructure-as-code automation also has guidance, though the specific steps depend on your scripts. For more information, see:

- [Azure Resource Mover tutorials](/azure/resource-mover/tutorial-move-region-virtual-machines)
- [Azure Site Recovery tutorials](/azure/site-recovery/azure-to-azure-how-to-enable-replication)
- [Infrastructure as code overview](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code)

## Migrate workload data

This stage is only relevant when the workload requires data migration. Perform data migration with the chosen tool.  Before the cutover to the workload in the target region, you must ensure that the related data is in sync with the source region. Data consistency is an important aspect that requires care.  Here's ordered guidance for migrating workload data.

**(1) Source region data.** The approach to migrating source-region data should follow the relocation method for the workload service. The hot, cold, and warm methods have different processes for handling the data in the source region.

**(2) Synchronize data.** The synchronization technique will depend on the architecture of the workload and the demand of the application. For example, in an on-demand sync, changes are pulled when data is accessed for the first time. Pulling and merging of changes occurs only in cases where there's a difference between last and current application access.

**(3) Resolve synchronization conflicts.** Make sure the data in the source and target location are in sync and resolve any data conflicts. For example, Cosmos DB can serialize concurrent writes to ensure data consistency using session consistency and stored procedure in a single-write region. You only want users trying to access data that is available.

## Update connection strings

The connection string configuration depends on the service the application connects to. We recommend searching for “connection string” on our documentation page to find the service-specific guidance and use that guidance to update the connection string. For more information, see the [documentation search page](https://learn.microsoft.com/search/).

## Next steps

You've migrated your workload services and data, now you need to complete the relocation with a cutover.

> [!div class="nextstepaction"]
> [Cutover](cutover.md)
