---
title: Fabric Governance and Security Baselines
description: "Fabric governance and security baselines: Learn how to secure and govern your Microsoft Fabric OneLake environment with best practices for workspaces, cost, and data protection."
#customer intent: As a technology decision maker, I want to have a governance and security baseline checklist that I can use to ensure the Fabric platform is minimizing risk, governing and securing all data uniformly, and cost optimized.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 03/09/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Fabric governance and security baselines

This section focuses on governance and security inside the Microsoft Fabric OneLake environment. OneLake accumulates data from across your enterprise, so it's the hub of your analytics and AI data. Apply the same principles you established for the broader [data estate](./governance-security-baselines-purview-data-estate-unify-data.md), but tailor them to the Fabric context, to keep this unified data lake secure and well-governed.

## 1. Set Fabric environment governance baseline

A core governance decision is how you define and structure environments in Microsoft Fabric. In Fabric, **workspaces are the primary construct used to represent environments**, control access, allocate capacity, and apply governance. Most organizations converge on one of the following patterns. The right choice depends on how teams are organized, how strictly environments must be isolated, and which governance principles are most important for your organization.

**Option 1: One workspace per data product.** In this model, each major data product (with its full data pipeline) gets its own workspace. This approach works best when a single team develops and manages the entire pipeline for a data product. Having everything in one workspace makes ownership clear and collaboration easier within the team. **Decision guidance:** Within the workspace, there are two ways to implement the medallion architecture. (If you don’t understand medallion architecture, see [Apply medallion architecture](./operational-standards-unify-data.md#2-apply-medallion-architecture)).

- **Single Lakehouse with multiple schemas**: The simplest option is to use one [Lakehouse](/fabric/data-engineering/lakehouse-overview) in the workspace and separate raw (Bronze), cleaned (Silver), and curated (Gold) data by using distinct [schemas](/fabric/data-engineering/lakehouse-schemas) or folders. This approach keeps things simple (one place for all data), but it requires strong governance discipline to prevent accidental mixing of raw and curated data (see Figure 1).

:::image type="content" source="images/one-workspace-per-data-product-fabric-single-lakehouse-multiple-schemas.svg" alt-text="Diagram showing one Fabric workspace per data product. Within the Fabric workspace, there's a single Fabric lakehouse with multiple Lakehouse schemas for each layer of the medallion architecture. There's a separate Lakehouse schema for Bronze, Silver, and Gold.":::

*Figure 1. One workspace per data product. Single Lakehouse for each data product. One Lakehouse schema for each layer of the medallion architecture.*

- **Multiple Lakehouses for layers**: Alternatively, use multiple Lakehouse objects in the same workspace, dedicating one to each layer. There’s one Lakehouse for raw Bronze data, one for Silver, and one for Gold. This approach provides clearer separation and safety between stages. You can give different permissions or even use separate compute for each layer. But it adds more operational complexity when managing the workspace (see Figure 2).

:::image type="content" source="images/one-workspace-per-data-product-fabric-multiple-lakehouses-per-layer.svg" alt-text="Diagram showing one Fabric workspace per data product. Within the Fabric workspace, there's are multiple Fabric lakehouse, one for each layer of the medallion architecture. There's a separate Lakehouse for Bronze, Silver, and Gold.":::
*Figure 2. One workspace per data product. Multiple Lakehouses for each data product. One Lakehouse for each layer of the medallion architecture.*

**Option 2: Multiple workspaces per data product (High Isolation).** In some cases, you might split a single data product’s pipeline across multiple workspaces. This pattern provides the highest level of isolation. It’s useful if different teams manage different stages of the pipeline or if you have strict requirements that the production-grade data be walled off from development work. **Tradeoff:** This approach increases coordination effort and complexity. Multiple workspaces for one product mean you need processes to move data between those workspaces and to manage security across them. Choose this approach only when the benefits of isolation, such as meeting regulatory requirements or clear separation of duties between teams, outweigh the additional overhead (see Figure 3).

:::image type="content" source="images/multiple-workspaces-per-data-product-fabric.svg" alt-text="Diagram showing multiple Fabric workspaces per data product. For a data product, three separate workspace, one workspace for each layer of the medallion architecture Within the Fabric workspace, there's only one Fabric lakehouse, one for that layer of the medallion architecture.":::
*Figure 3. Multiple Fabric workspaces per data product. One workspace per medallion layer.*

**Option 3. One Fabric workspace for multiple data products (capacity-constrained scenarios).** If your organization faces constraints on the number of workspaces or available Fabric capacity (for example, due to licensing or cost limits), you might have to put multiple smaller data products into a single workspace. In this case, a domain team manages several data products together in one container. **When to choose:** This approach is generally not ideal, but it might be necessary for small-scale deployments or during initial experimentation. Use it for less critical or low-volume data products if you don’t have enough capacity for each to have its own workspace. **Tradeoff:** The downside is reduced isolation. Multiple products sharing a workspace can lead to resource contention and intermingling of data. It also complicates governance. You rely on naming conventions, access controls, and team discipline to keep each product’s data separate within the shared workspace.

**Standard to enforce:** Whichever workspace approach you choose, tie it back to your data domains. Make sure it mirrors how you want to delegate control and ensure clear data ownership. Also, document your workspace strategy and educate teams on how to use workspaces properly. For example, use one workspace per product as the default unless a specific reason warrants otherwise.

## 2. Set cost governance baselines

A cost governance baseline defines how each data domain configures and operates Microsoft Fabric capacities so all workloads stay within the approved budget over time.

1. **Define a Fabric budget.** A Fabric budget is the financial limit that applies to all workloads running on a data domain’s Fabric capacities. **Best practice:** Each data domain receives and sets a budget for its Fabric usage before onboarding any workloads. Treat this budget as a hard governance boundary, not a planning estimate. Align spending decisions to it from day one.

2. **Control which workloads consume Fabric capacity.** Workspace assignment controls access to shared compute and shared spend. **Best practice:** Require approval before assigning new workspaces to Fabric capacities. Use this step to confirm business value and budget fit. **Decision guidance:** Limit assignment rights to a small number of platform owners when governance maturity is low. Broaden access only when cost discipline is proven. Restriction reduces surprise cost. Broader access increases speed.

3. **Standardize permissions that influence capacity consumption**. Certain Fabric permissions allow actions that significantly increase capacity usage. **Best practice:** Restrict advanced creation and scaling permissions on high‑cost Fabric capacities. Assign elevated permissions only to trusted operational roles within the data domain. **Decision guidance:** Choose central role assignment when strong guardrails matter. Choose delegated assignment when teams show cost discipline. Central control reduces risk. Delegation improves speed but needs audit discipline.

## 3. Set data security baseline

Define workspace boundaries, ownership, labeling, and sharing rules *before* you publish any data products so leaders can make consistent access and governance decisions across teams. This baseline prevents “ad-hoc” sharing patterns from becoming your default operating model. **Checklist of best practices:**

1. **Establish workspace security baselines.** In Fabric, as mentioned, the workspace is a primary security boundary. Before teams start creating and publishing data products, define how you'll manage workspace access.

    - *Who can create new workspaces?* Consider a process or approval for creating Fabric workspaces so they align with your governance. Uncontrolled workspace creation could lead to sprawl and data governance gaps. 

    - *Who can access what?* Ensure each workspace has assigned administrators and owners who control membership. Enforce the principle of **least privilege**: give each user or group the minimum permissions they need (viewer, contributor, admin). Avoid overly broad access or ad-hoc sharing of workspaces and items, because that can inadvertently expose data to the wrong people. 

    **Best practice**: Many organizations designate a primary Workspace Data Owner or administrator responsible for managing access and security settings for each workspace. They also establish naming conventions and metadata tags for workspaces indicating their purpose. Follow the [OneLake security best practices.](/fabric/onelake/security/best-practices-secure-data-in-onelake)

2. **Apply sensitivity labels.** Fabric uses the same sensitivity label taxonomy you defined in Purview. However, you need to **default sensitivity labels** at various levels in OneLake so Fabric items receive the appropriate classification when created. **Best practices:** Configure default sensitivity labels at various levels:

    - **Fabric tenant:** Set default label policies at the Fabric tenant level, like “Internal”, to any new item if no one labels it. 

    - **Workspace:** Set default label policies at the Fabric tenant level. If a particular workspace often contains  sensitive data, you might auto-label everything created there as “Confidential” unless changed.

    This way, every dataset, table, or report in Fabric gets a label by default. Producers must intentionally downgrade or change it if needed. This approach prevents unlabeled and thus ungoverned data from proliferating. Over time, adjust these defaults as you see patterns. For example, if a workspace consistently produces public-ready data, maybe the default can be lowered there, or vice versa. See [default label policy](/fabric/governance/sensitivity-label-default-label-policy) and [default sensitivity labels](/fabric/governance/domain-default-sensitivity-label) in Fabric.

3. **Apply protection policies.** Sensitivity labels classify data. Purview protection policies enforce access behavior. **Best practice:** Define protection rules for each label tier. **Decision guidance:**

    - **Label-only:** If your organization is just starting with data classification, you might begin with labeling-only (no automatic enforcement) to focus on visibility and user education. This approach is simpler to implement initially but relies on users following guidelines.

    - **Protection policies:** If you already know you have sensitive data in OneLake that must be protected, you should configure label-based protection policies from the outset. This configuration ensures that even if a user has access to data, they can't perform disallowed actions (like sharing it publicly or downloading it unencrypted). The tradeoff of enabling protection policies is the added effort to design and test them, and the need to handle situations where they might block some legitimate access. This situation requires a process to override or refine policies. See Microsoft Purview [protection policies](/fabric/governance/protection-policies-overview).

4. **Define data loss policies.** **Best practice:** Similar to DLP in Microsoft 365, set up [DLP policies for Fabric](/purview/dlp-powerbi-get-started#supported-item-types). This setup helps prevent accidental or risky sharing of data from OneLake.  See [supported item type](/purview/dlp-powerbi-get-started#supported-item-types) containing sensitive information, the policy triggers the configured actions. **Decision guidance:** Choose monitor only when you need to understand real behavior and you expect high change friction. You get evidence and you get time to tune. You also leave risk in place during the learning period. Choose block and restrict actions when exposure impact is high and when policy confidence is strong. You prevent common leakage paths and you enforce standard behavior.

5. **Use data lineage.** Fabric automatically tracks lineage of data within and across workspaces. For example, it knows which dataflow or pipeline produced a given dataset, and which reports or AI models are using that dataset. It also passes lineage information to Purview. Make use of this lineage data. **Best practices:** Train your data engineers and stewards to use the built-in lineage views to trace how data moves from raw sources to final products. Encourage them to check lineage when diagnosing data quality issues or assessing the impact of a proposed change. Share lineage information with governance and audit teams through Purview’s reports. See [lineage in Fabric](/fabric/governance/lineage).

    See [Microsoft Purview Information Protection in Fabric](/fabric/governance/microsoft-purview-fabric#microsoft-purview-and-microsoft-fabric-together).

## 4. Set a network security baseline

Fabric runs as a SaaS service in the Microsoft cloud. By default, it uses secure communication over the Microsoft global network. Any connection to on-premises systems or external services should follow defined and approved network paths. **Best practices:** Set up standards for when to use public connectivity or private connectivity. **Decision guidance:**

1. **Public network connectivity:** By default, many services connect to Fabric over the internet using encryption (HTTPS). **When to choose:** This connectivity is acceptable for many scenarios, especially when data sensitivity is low and ease of setup is important, such as connecting to a public SaaS API. **Benefit:** Simpler configuration. There’s no special network setup needed. **Tradeoff:** Data travels over public networks (though encrypted). You're relying on internet connectivity and public endpoints which might be less controlled. 

2. **Private network connectivity:** **When to choose:** For more sensitive data or stricter compliance needs, use private connectivity options. For Azure sources, prefer **Azure** Private Link or managed virtual network integration for Fabric connectors. For on-premises data, use a private data gateway or VPN/ExpressRoute connections to avoid exposing endpoints to the internet. **Benefit:** Traffic stays on controlled networks, reducing exposure. **Tradeoff:** More complex to set up and manage. It requires networking configuration and possible impact on performance or cost due to routing through private links. See [Network security in Fabric](/fabric/security/security-overview#understand-network-security).

## 5. Use the monitoring baseline

Use the [Microsoft Purview Hub](/fabric/governance/use-microsoft-purview-hub?tabs=overview) to monitor your Fabric environment. The Purview Hub provides a single pane where you can see all Fabric assets, like tables, datasets, and reports. You can also see their metadata, like sensitivity labels, ownership, and lineage. This helps your governance team ensure that everything in OneLake is classified and that data flows are understood. It’s a great tool for data stewards to catch issues, like a dataset missing a description or a sensitive data store without a label, and to maintain the quality of the catalog. Regularly reviewing the Purview Hub can become part of your data governance routine. It’s an actionable way to enforce the standards you’ve set.

### Next step

By establishing these governance and security baselines for both your overall data estate and specifically for OneLake, you create a safe environment for data innovation. Good governance is invisible when done well. It operates in the background, ensuring people have access to the data they need without compromising security or compliance . The next step is making sure you have robust operational processes so that data flows from sources to insights in a consistent, reliable manner. 
