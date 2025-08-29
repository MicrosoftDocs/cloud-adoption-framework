---
title: Azure billing offers and Microsoft Entra tenants
description: Understand Azure billing offers and Microsoft Entra tenants.
author: jtracey93
ms.author: jatracey
ms.date: 11/28/2024
ms.update-cycle: 180-days
ms.topic: conceptual
ms.custom: think-tank, UpdateFrequency.5
---

# Azure billing offers and Microsoft Entra tenants

This critical design area focuses on the two highest levels of alignment across all of your Azure deployments; your Azure billing offer and the association of that offer with a Microsoft Entra tenant.

## Design area review

**Involved roles or functions:** This design area will likely require support from one or more of the following functions or roles to make decisions and implement those decisions: cloud strategy, [cloud platform](../../../organize/cloud-platform.md), and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md)

**Scope:** The objective of this exercise is to evaluate the various [offer types](https://azure.microsoft.com/support/legal/offer-details/) and Microsoft Entra tenant association is best suited for your overall environment.

**Out of scope:** This design area doesn't focus on the identity or management aspects of Microsoft Entra ID, only the tenant in which your identities will ultimately be hosted. That guidance will be reviewed in the [identity and access management design area](./identity-access.md).

## Design area overview

The Azure service presents a range of [active subscription offers](https://azure.microsoft.com/support/legal/offer-details/), and customers can use these offers at the same time to gain flexible billing options. Example subscriptions include Enterprise Agreement (Enterprise Agreement), Microsoft customer agreement, cloud service provider, and others.

:::image type="content" source="./media/azure-scopes-billing.svg" alt-text="Diagram that shows Azure scopes within one Microsoft Entra tenant with various billing offers and subscriptions." border="false":::

The Azure landing zone architecture supports subscriptions from any [Azure offer](https://azure.microsoft.com/support/legal/offer-details/). Subscriptions can only exist within one Microsoft Entra tenant to then relocate into the management group hierarchy within that tenant. They can then be managed by the various controls with enterprise-scale platforms like Azure Policy and role-based access control (RBAC).

> [!NOTE]
> The Azure landing zone accelerator implementation is scoped and deployed to one Microsoft Entra tenant; however, billing options can span across multiple Microsoft Entra tenants. For example, an Enterprise Agreement enrollment supports Azure subscriptions across different Microsoft Entra tenants.

Explore the further information, considerations and recommendations for each approach below:

- [Enterprise Agreement (EA)](./azure-billing-enterprise-agreement.md)
- [Microsoft customer agreement (MCA)](./azure-billing-microsoft-customer-agreement.md)
- [Cloud solution provider agreement (CSP)](./azure-billing-cloud-solution-provider.md)
- [Define a Microsoft Entra tenant](./azure-ad-define.md)

## Billing and Tenant Relationship

:::image type="content" source="./media/azure-billing-tenant.png" alt-text="Diagram that shows the relationship between a billing contract and associated tenant(s) and subsequent subscriptions." border="false":::

## Customer to contract

Customer Organizations can sign multiple contracts with Microsoft. Even though it is generally advised to have a 1:1 relationship between Customer and Microsoft contract, Customer's can theoretically use multiple contracts at the same time.
Examples

Best example for this is during a transition period from EA to MCA, where the customer has an active EA and an active MCA contract.
During M&A activities a customer organization might end up with multiple EA or MCA contracts.

## Contract to price sheet

Every contract is associated with a customer specific price sheet determining the individual customer prices in the agreed billing currency.
In MCA the default associated price sheet basically equals the Azure Retail price list in USD.
The price sheet can be accessed in the Azure portal.

## Contract to Microsoft Azure Consumption Commitment (MACC)

Customers can sign a MACC. There is usually a 1:1 relationship between a contract and a MACC.
As a benefit of this commitment, Customers might get discounted pricing on Azure Resources (usage). This potential discount will be reflected in the price sheet associated with the contract.

## Contract to billing roles

Both EA and MCA provide Customers with roles, that can manage certain aspects of the contract. These roles are called billing roles. Billing roles differ from EA to MCA and are described in detail here for EA and here for MCA.
A key difference between EA and MCA is, that Customers can associate any valid work, school, or Microsoft account to EA billing roles but only work accounts of an approved tenant for MCA.

## Contract to tenant

To manage billing roles customers must associate exactly one Entra ID tenant with the contract. This happens at contract setup. Identities within this Tenant can be assigned to billing roles within the contract.
Example
User Dirk from the contoso.com tenant can be assigned to the EA admin role in Contoso’s EA contract.

In MCA this tenant is called the primary billing tenant. Only users from this tenant can be assigned to billing roles within the MCA contract.

CAUTION: The tenant global administrator role is above the billing account administrator. Global administrators in a Microsoft Entra ID tenant can add or remove themselves as billing account administrators at any time to the Microsoft Customer Agreement.

If you want to assign identities from tenants other than the primary billing tenant, you can add associated billing tenants.

NOTE: Even though customers should strive for a single tenant, there is no restriction in how many tenants a customer can create within a contract.

## Contract to subscription

An Azure subscription is a logical container used to provision and manage Azure resources. Resource access is managed by a trust relationship to an Entra ID tenant and billing is managed by a billing relationship to a Microsoft contract (EA or MCA).
Every subscription can only have one billing relationship to one contract. This billing relationship can be moved to a different contract based on certain conditions (e.g. in EA/MCA transition scenarios or M&A scenarios).

Every contract can manage 5000 subscriptions by default.

NOTE: The billing relationship determines the prices for the consumed resources within the subscription. If you have a subscription that is associated with a contract that uses Azure retail prices you pay the retail price. If the associated contract has customer specific prices (e.g. by signing a MACC with applicable discounts), the resources within this subscription will be charged at these prices.

## Subscription to tenant

Every subscription has a 1:1 trust relationship to an Entra ID tenant. This trust relationship determines, which identities can manage the resources within the subscription.

## Tenant to subscription

Every tenant can manage trust relationships with virtually unlimited number of subscriptions. These subscriptions can use billing relationships to multiple contracts which might lead to different prices for resources deployed to these subscriptions.
