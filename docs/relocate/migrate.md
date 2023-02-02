---
title: How to migrate a cloud workload to another region
description: Learn how to migrate cloud workloads and applications to another region.
author: SomilGanguly
ms.author: ssumner
ms.date: 02/03/2023
ms.reviewer: ssumner
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-relocate
keywords: cloud adoption, cloud framework, cloud adoption framework
---
# Migrate a cloud workload to another region

The Migrate step of relocation is where you move the workload to the new region. Depending on your workload, you might have a few technical requirements to prepare, but the relocation strategy for the workload should be clear. You should be ready to execute the relocation.

:::image type="content" source="../_images/relocate/caf-relocate-migrate.png" alt-text="Image that shows the relocation process and highlights the Migrate step in the Move phase. In the relocation process, there are two phases and five steps. The first phase is the initiate phase, and it has one step called initiate. The second phase is the Move phase. It has four steps that you repeat for each workload. The steps are Evaluate, Select, Migrate, and Cutover." lightbox="../_images/relocate/caf-relocate-migrate.png" border="false":::

## Prepare

You might need to prepare the target region before relocating the workload. If the relocation adds to your Azure landing zone footprint, you should use the Azure landing zone guidance and return to this article to relocate the workload. For more information, see [How to add regions to Azure landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/faq#how-do-we-enable-more-azure-regions-when-we-use-azure-landing-zone-architecture). As needed, follow these steps to prepare your workload environment before relocation.  Doing so will ensure you have core regional networking in place such as a regional hub and, if necessary, cross-premises connectivity.

**Create new subscriptions only if needed.** Only create new subscriptions if you need to restructure the services and resources involved. You should approach relocations as an as-is effort because creating a new subscription adds complexity. Subscriptions serve as boundaries for budgets, policies, and role-based access controls (RBACs). For any new subscription, you need to validate budgets, policies, and RBACs. If you don't move all the resources in a subscription, then you need to rescope the identity and security policies to match the smaller grouping of resources. To create a new subscription, you need to create, scope, and implement the required Azure policies and RBAC roles in the target subscription. The goal is to maintain the governance and security posture.

**Configure a new domain name if needed.** When there's a change in the custom domain of the workload, you need to configure a new domain name. Create the new hostname, assign it to your application or service, and then validate the name resolution. You might also plan to lower and configure the time-to-live (TTL) and set it in the cutover stage for auto expiry. For more information, see [Add your custom domain](/azure/active-directory/fundamentals/add-custom-domain) and [Map DNS name to App Service plan](/azure/app-service/manage-custom-dns-buy-domain#prepare-the-app).

**Create new SSL/TLS certificates if needed.** You need to create new SSL/TLS certificates (X.509) for any new domain name. These certificates enable public-private key encryption and secure network communication (HTTPS). Use Azure Key Vault to create or import X.509 certificates. For more information, see [Azure Key Vault certificates](/azure/key-vault/certificates/about-certificates) and [Certificate creation methods](/azure/key-vault/certificates/create-certificate)

**Relocate Azure Key Vault.** You should relocate Azure Key Vault before moving your workload. You should have one key vault per application environment, and your key vault shouldn’t share secrets across regions to ensure confidentiality. You might need to create a new key vault in the new target region to align with this guidance.

## Migrate services

You can begin migrating the services in your workload. For execution, follow available guidance for the relocation automation you selected. Azure Resource Mover and Azure Site Recovery have step-by-step tutorials to follow for service relocation. Infrastructure-as-code automation also has guidance, though the specific steps depend on your scripts. For more information, see:

- [Azure Resource Mover tutorials](/azure/resource-mover/tutorial-move-region-virtual-machines)
- [Azure Site Recovery tutorials](/azure/site-recovery/azure-to-azure-how-to-enable-replication)
- [Infrastructure as code overview](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code)

## Migrate data

This stage is only relevant when the workload requires data migration. Perform data migration with the chosen automation. Before the cutover to the workload in the target region, you must ensure that the related data is in sync with the source region. Data consistency is an important aspect that requires care.  Here's ordered guidance for migrating workload data.

**Migrate source region data.** The approach to migrating source-region data should follow the relocation method for the workload service. The hot, cold, and warm methods have different processes for managing the data in the source region.

**Synchronize data.** The synchronization technique depends on the architecture of the workload and the demand of the application. For example, in an on-demand sync, changes are pulled when data is accessed for the first time. Pulling and merging of changes occurs only in cases where there's a difference between last and current application access.

**Resolve synchronization conflicts.** Make sure the data in the source and target location are in sync and resolve any data conflicts. You only want users trying to access data that is available. For example, Azure Cosmos DB can serialize concurrent writes to ensure data consistency.

## Update connection strings

The connection string configuration depends on the service the application connects to. You can search for “connection string” on our documentation page to find the service-specific guidance and use that guidance to update the connection string. For more information, see the [Technical documentation](/docs/).

## Managed identities

System-assigned managed identities have a lifecycle bound to the Azure resource. So the relocation strategy of the Azure resource determines how the system-assigned managed identity is handled. If a new instance of the resource is created in the target, then you have to grant the new system-assigned managed identity the same permissions as the system-assigned managed identity in source region. On the other hand, user-assigned managed identity have an independent lifecycle, and you can map the user-assigned managed identity to the new resource in the target region. For more information, see [Managed identity overview](/azure/active-directory/managed-identities-azure-resources/overview).

## Next steps

You've migrated your workload services and data. Now you need to complete the relocation with a cutover.

> [!div class="nextstepaction"]
> [Cutover](cutover.md)
