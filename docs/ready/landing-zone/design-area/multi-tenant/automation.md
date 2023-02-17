---
title: Automate Azure landing zones across multiple tenants
description: Learn about the automation considerations and recommendations when handling multiple Azure Active Directory tenants alongside Azure landing zones.
author: jtracey93
ms.author: jatracey
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Automate Azure landing zones across multiple tenants

When your organization has multiple Azure Active Directory tenants with Azure landing zones (ALZ) in each of them, one or multiple times, automation is key. Automation helps to successfully operate and maintain the ALZ deployment at scale across all tenants. There are multiple approaches to automating ALZ deployments across multiple tenants. Which approach you take depends on the reasons your organization has multiple Azure Active Directory tenants.

For example, you might have multiple Azure Active Directory tenants if you're an independent software vendor. It's likely that you want to keep your corporate and SaaS solutions Azure Active Directory tenants separate. The risk of any operation or deployment affecting the other tenant, whether intended or by mistake, is reduced.

The following sections provide diagrams and guidance about the approaches that you can take. Choose which approach is best for you based on your requirements, considerations, and recommendations for automating your Azure landing zones deployments when handling multiple Azure Active Directory tenants.

>[!NOTE]
> It's recommended to read the following articles first to get an overview of Azure Active Directory tenants:
>
> - [Overview for multiple Azure Active Directory tenants](overview.md)
> - [Scenarios for multiple Azure Active Directory tenants](scenarios.md)
> - [Considerations & Recommendations for multi-tenant Azure landing zone scenarios](considerations-recommendations.md)

## Approaches

There are two approaches to automate the deployment of Azure landing zones across multiple Azure Active Directory tenants.

[Approach 1 – Complete isolation](#approach-1--complete-isolation) is the most common approach in multi-tenant scenarios. This approach keeps the required separation and isolation between Azure Active Directory tenants, which is the most common requirement when using a multi-tenant approach.

[Approach 2 – Shared application registration (multi-tenant) with multiple service principals](#approach-2--shared-application-registration-multi-tenant-with-multiple-service-principals) is more commonly used in Managed Service Provider (MSP) scenarios. In this approach, a [Deployment Stamps pattern](/azure/architecture/patterns/deployment-stamp) can be used to automate the deployment of an almost identical architecture across multiple tenants at scale.

Both of these approaches are provided as examples and inspiration. You can mix and match the approaches in your deployments based on your organization's requirements.

>[!IMPORTANT]
> This article covers automating the deployment and operation of Azure landing zones as the platform in each Azure Active Directory tenant your organization has. The approaches, recommendations, and considerations in this article are **not** intended to be used by application teams deploying and operating their services and applications into their landing zones (subscriptions). For more information on the different types of landing zones, see [Platform vs. application landing zones](/azure/cloud-adoption-framework/ready/landing-zone/#platform-vs-application-landing-zones).

### Approach 1 – Complete isolation

In this approach, the primary objective is to keep each Azure Active Directory tenant isolated from each other across all automation components, like:

- A Git repository.
- GitHub Actions or Azure Pipelines (including self-hosted runners, if being utilized).
- Identities used for performing tasks from automation, like managed identities assigned to self-hosted runners, service principal names (SPNs), users, or administrators.

:::image type="content" source="media/automation-approach-1.png" alt-text="Diagram of multiple Azure Active Directory tenants with Azure landing zones deployed using the complete isolation automation approach" lightbox="media/automation-approach-1.png":::

In this approach, there are more components to manage that are duplicated per an Azure Active Directory tenant, but this might be a requirement for some organizations that have regulatory compliance controls enforced on them that mandates this type of segregation and isolation.

>[!NOTE]
> If your organization only allows the use of managed identities for platform automation, you must use this approach or an approach that logs into each tenant individually. Managed identities don't support cross-tenant scenarios. For more information, see [this FAQ](/azure/active-directory/managed-identities-azure-resources/managed-identities-faq#can-i-use-a-managed-identity-to-access-a-resource-in-a-different-directorytenant).

#### Identities for platform administrators and developers - Approach 1

In this approach, identities should also be isolated in each Azure Active Directory tenant, which means each platform administrator or developer requires a separate user account within each tenant to perform operations within that tenant. These accounts are also used to access the developer tooling, like GitHub or Azure DevOps, for each of the tenants. Carefully consider the effects of administrator and developer productivity following this approach.

Azure Active Directory B2B and/or Azure Lighthouse can be used, but this option questions the reasoning for having separate Azure Active Directory tenants.

### Approach 2 – Shared application registration (multi-tenant) with multiple service principals

In this approach, an application registration is created in the managing Azure Active Directory tenant. In every Azure Active Directory tenant that you want to manage, a service principal name (SPN) is created in that tenant, based on the application registration. This action allows the workers running the pipeline tasks and steps to log in to any of the Azure Active Directory tenants with a single set of credentials.

>[!TIP]
> For information about the relationship between application registrations and enterprise applications (service principles), see [Application and service principal objects in Azure Active Directory](/azure/active-directory/develop/app-objects-and-service-principals).

:::image type="content" source="media/automation-approach-2.png" alt-text="Diagram of multiple Azure Active Directory tenants with Azure landing zones deployed using the shared application registration (multi-tenant) with multiple service principals automation approach." lightbox="media/automation-approach-2.png":::

>[!IMPORTANT]
> In this approach, the single application registration and the associated enterprise applications (service principals) should be monitored for any abnormal activity in your security information and event management (SIEM) tooling because this is a highly privileged account. It should send alerts and potentially automatically take action, depending on the alert severity.

In the previous example, a single app registration is in the `contoso.onmicrosoft.com` Azure Active Directory tenant, and an enterprise application is in each of the Azure Active Directory tenants that's linked to the app registration. This setup allows a pipeline to authenticate and authorize to all the Azure Active Directory tenants by using the single app registration. For more information, see [Making your application multi-tenant](/azure/active-directory/develop/howto-convert-app-to-be-multi-tenant).

When using a centralized pipeline, you might need to build a small mapping table that contains data correlating the Azure Active Directory tenants and other metadata, such as the environment, associated subscriptions, organization name, and identity object ID used for authentication and authorization. This data can be called on during the run of the pipeline in a step that uses some logic and conditions to control which Azure Active Directory tenant it's deployed to and with which identities. This can be stored in services, such as Azure Cosmos DB or Azure Table storage.

Handling multiple environments, such as development, test, or production, can be controlled in the same way by using the same, or separate, application registrations and enterprise applications with pipelines.

You might decide to have separate pipelines for each Azure Active Directory tenant or use a single pipeline. The choice is yours based on your requirements.

>[!NOTE]
> Azure Lighthouse works similar to this approach, but Azure Lighthouse doesn't allow the assignment of the RBAC owner, user access administrator, and roles with DataActions permissions. For more information, see [Role support for Azure Lighthouse](/azure/lighthouse/concepts/tenants-users-roles#role-support-for-azure-lighthouse).
>
> The owner and user access roles are typically required in all Azure landing zone deployment scenarios. This requirement removes Azure Lighthouse as an option for the entire platform automation deployment aspect of Azure landing zones, but it's still useful in some scenarios. For more information, see [Azure Lighthouse usage in ALZ multi-tenant](lighthouse.md).

#### Identities for platform administrators and developers - Approach 2

In this approach, platform administrators and developers usually only need access to the managing Azure Active Directory tenant. This access grants them access to the developer tooling, like GitHub or Azure DevOps, that all tenants are deployed to and operated from.

They might also have access into the other Azure Active Directory tenants via Azure Active Directory B2B or Azure Lighthouse by using their same account from the managing tenant, or they might have separate accounts, like [the example in the first approach](#approach-1--complete-isolation).

## Next steps

> [!div class="nextstepaction"]
> [Azure landing zones Canary approach with multiple tenants](canary.md)
