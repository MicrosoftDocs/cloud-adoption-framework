# Governance and security baselines

## 3.1 Data estate governance and security baselines

With the foundational strategy and architecture in place, you must establish strong governance and security practices from the very beginning. This ensures that as data from all corners of the organization flows into your unified platform, it remains well-managed, compliant, and secure. We will break this into two parts: governing the overall data estate (all data across cloud and on-premises, not just Fabric) and then the specific governance and security measures within Microsoft Fabric OneLake.

### 1. Data estate visibility baseline

Data governance starts with a clear view of all your data assets across the entire estate. Before focusing on Fabric specifically, use Microsoft Purview to gain visibility and control over data *wherever it resides*: Azure services, Microsoft 365, other clouds like AWS or Google, on-premises databases, SaaS applications, etc. Establishing a strong data estate governance baseline will ensure consistency once that data enters OneLake. **Here’s a checklist of best practices:**

#### 1. Create a data catalog

The cornerstone of governance is a comprehensive inventory (catalog) of data assets. Use [Microsoft Purview's Unified Catalog](/purview/unified-catalog) as your organization’s single source of truth about data. This catalog stores information about each data asset’s location, what it contains, who owns it, how it’s classified, and how it flows between systems. Here’s how:

1.  **Use governance domains**. Organize the Unified Catalog using Purview [governance domains](/purview/unified-catalog-plan#create-governance-domains) that align to existing data domains. Collections, roles, and permissions should reflect these boundaries, so each data domain has authority in their area. The Unified Catalog begins empty, but as data sources are registered and scanned, it grows into an accurate map of the estate. Setting domains early brings clarity as the catalog expands.

2.  **Define data glossary.** With structure in place, the next step is creating a shared business glossary that anchors the organization’s most important concepts and metrics. Terms such as Customer, Product, Employee, and Location, and measures like Revenue or Headcount, often vary subtly across departments unless intentionally harmonized. Documenting these definitions as [Glossary Terms](/purview/unified-catalog-glossary-terms) the Unified Catalog and communicating them broadly helps eliminate ambiguity. This clarity supports consistent AI, analytics, and reporting practices across teams.

#### 2. Map data sources

Once the catalog and glossary are established, all relevant data sources must be visible in Purview. Registering and scanning systems across the estate populates the [Data Map](/purview/data-map-scan-ingestion) with metadata from your scanned data sources. It does not bring the actual into Purview. It does not replace the security controls of each data source. **Best practices:**

1.  **Create Purview architecture.** Use Purview collections and [Data Map domains](/purview/data-map-domains) to align permissions and governance with the needs of your data domains. These constructs define boundaries for access control, policy management, and operational responsibility. Follow Purview [domain and collection architecture best practices](/purview/data-gov-best-practices-domains-collections#domains-and-collections-archetypes).

2.  **Set up Purview for Microsoft 365 data.** Purview has native integration with Microsoft 365 data (such as SharePoint, OneDrive, Exchange, Teams). Ensure that content in Microsoft 365 is also being governed. When Microsoft 365 documents and messages are brought into OneLake or otherwise used in analytics, any labels or classifications from Microsoft 365 will carry over. In Purview, you’ll be able to see things like sensitivity labels and retention labels that were applied in the M365 environment. See [Microsoft Purview setup guides](/purview/purview-fast-track-setup-guides).

3.  **Scan Microsoft Fabric OneLake.** Fabric OneLake is not automatically included in the Purview Data Map and must be explicitly registered and scanned. Scanning OneLake enables metadata discovery, lineage tracking, and cataloging of Fabric assets in Purview. See [Register and scan Microsoft Fabric](/purview/register-scan-fabric-tenant?tabs=Scenario1).

#### 3. Scan cloud, SaaS and on-premises data

Data stored in Azure services, Microsoft Dataverse, on‑premises systems, and other clouds (AWS, Google Cloud, Oracle) requires connector-based scanning. See how to [Register](/purview/data-map-data-sources-register-manage#register-a-new-source) and scan [supported data sources in Data Map](/purview/data-map-data-sources). Make sure to follow Purview’s [scanning best practices](/purview/data-map-scanning-best-practices), such as scheduling scans during off-peak hours and monitoring for any scan failures

Before scanning begins, a choice must be made about whether to scan source systems or only scan the Microsoft Fabric OneLake layer. This decision depends on visibility needs, compliance requirements, operational overhead, and the role each system plays in analytics and reporting. **Decision guidance:**

1.  **When to scan source systems.** Scanning operational systems such as Azure databases or AWS S3 provides end‑to‑end lineage from the system of record. This is important for regulated or business‑critical data where full provenance supports audits and compliance. It provides the clearest visibility into upstream changes but introduces complexity. Connector configuration, credentials, and scheduling require attention, and some sources require you to [Choose the right integration runtime.](/purview/data-map-integration-runtime-choose)

2.  **When to scan only the Fabric layer*.*** If deep visibility into upstream systems is not required, scanning only the Fabric layer simplifies the governance model. Lineage begins when data enters Fabric, reducing integration work in environments where upstream systems are already well governed or where compliance obligations do not require full lineage. This approach reduces operational friction while still supporting analytics scenarios. See [Fabric](/purview/register-scan-fabric-tenant?tabs=Scenario1) in Microsoft Purview.

#### 4. Apply sensitivity labels

Sensitivity labels are a fundamental tool for classifying and protecting data. In Microsoft Purview, there are typically two kinds of sensitivity labels:

- **Metadata-only labels**: These labels are metadata tags in the Purview catalog. For example, labeling an Azure SQL table as “Confidential” in the catalog without it affecting the source system directly. These help track and manage data sensitivity in Purview for assets outside of Microsoft 365/Fabric.

- **Protective labels:** These labels that not only mark data with a classification, like “Confidential”, but also enforce protection. They can enforce encryption or restricted access on files and emails. These are heavily used in Microsoft 365 and now extend into Fabric as well.

Both contribute to a consistent governance model, and clarity about their purpose helps align the right label type to the right scenario. **Best practices** for labeling:

1.  **Define a sensitivity label taxonomy.** Define a simple, organization-wide labeling schema. A common schema is Non-business, Public, General, Confidential, Highly Confidential. Make sure everyone understands what each label means and what types of data fall under each category. Get buy-in on this taxonomy from compliance and business stakeholders. See [Get started with sensitivity labels.](/purview/get-started-with-sensitivity-labels)

2.  **Label Microsoft 365 data (protection label).** Ensure Microsoft 365 information is labeled appropriately using Microsoft Purview Information Protection. These labels impose security controls (encryption, restricted access) and they persist with the data even when it’s brought into OneLake or shared via other tools. **Best practice:** Many organizations set up auto-labeling policies to detect sensitive info, like credit card numbers or personal data, and automatically apply a label. See [automatically apply sensitivity labels to Microsoft 365 data](/purview/apply-sensitivity-label-automatically).

3.  **Label Microsoft Fabric data (protected label).** Microsoft Fabric supports [protected sensitivity labels](/fabric/governance/protected-sensitivity-labels) on its own assets, like tables in a Lakehouse, and Power BI datasets. Configure [default label policies](/fabric/governance/sensitivity-label-default-label-policy) in Fabric so that new data in OneLake is labeled appropriately from creation. For instance, you could specify that any new dataset in certain workspaces is by default labeled as internal or confidential unless changed. This ensures no data enters the lake without classification. Adjust these defaults for areas that handle highly sensitive data versus those that are open. See [Govern Fabric](#data-lake-governance-and-security-baselines).

4.  **Label entries in Purview Data Map (metadata-only label).** For data sources that are scanned into Purview (like an AWS S3 bucket or an on-prem database), apply metadata labels in the Purview Data Map. While these won’t encrypt or restrict the data at the source, they do inform users and systems that the data is, say, confidential. They can also trigger additional governance workflows. Essentially, everything in your catalog should have a sensitivity designation. See [Use autolabeling policies](/purview/data-map-sensitivity-labels-apply) to detect data assets and apply these metadata-only sensitivity labels automatically.

#### 5. Capture data lineage

Data lineage shows the lifecycle of data, beginning with its origin and continuing as it moves across systems. It helps with root-cause analysis, debugging, troubleshooting, and other investigative work. Microsoft Purview [automates](/purview/data-gov-classic-lineage-user-guide#lineage-collection) lineage capture for many assets. Where automation is not available, you can add lineage manually in Purview to fill gaps. See [Manual lineage setup](/purview/data-gov-classic-lineage-user-guide#manual-lineage). Configure data lineage in Purview for [Fabric](/purview/data-map-lineage-fabric) and, as needed, for [Azure Databricks](/purview/unified-catalog-data-quality-azure-databricks-unity-catalog).

### 2. Data estate compliance baseline

Once the estate is cataloged and the organization has a clear view of what data exists and where it resides, the next step is understanding the regulatory, legal, and internal obligations that govern that data. Microsoft Purview provides the tools to interpret those obligations, evaluate current alignment, and guide the work needed to meet them. **Here’s a checklist of best practices:**

1.  **Define your compliance requirements.** Compliance requirements vary by industry, region, and workload. The governance model must reflect them before any protective or technical controls are applied. Identify which regulatory frameworks or industry standards are relevant to your organization. **Best practices:** Use Microsoft Purview [regulatory templates](/purview/compliance-manager-regulations-list) and [assessments](/purview/compliance-manager-assessments). They represent standards such as [GDPR](/compliance/regulatory/gdpr), [HIPAA and HITECH](/compliance/regulatory/offering-hipaa-hitech), [PCI DSS v4.0](/compliance/regulatory/offering-pci-dss), [Sarbanes-Oxley Act](/compliance/regulatory/offering-sox), and [ISO 27001](/compliance/regulatory/offering-iso-27017). Review these templates to understand which rules apply across Microsoft 365, Azure, AWS, and Google Cloud. These provide a checklist of controls and practices you should have in place. Use the Compliance Manager’s scores and recommendations to gauge your current posture, identify gaps, and prioritize what to address first.

2.  **Monitor data compliance.** Once you’ve set up Purview’s compliance templates, regularly review the **compliance score** and reports. Purview will automatically assess aspects of compliance for [Microsoft 365 data](/purview/compliance-manager-setup) and data across [Azure, AWS, and Google Cloud](/purview/compliance-manager-multicloud). It will highlight issues and suggested actions to improve compliance. Set up alerts for any critical compliance policy violations **Best practices:** If sensitive data is found in an unapproved location or if a retention policy is violated, responsible teams should be notified immediately to take action. Steady monitoring and incremental improvements will ensure you’re not caught off guard by audits or incidents.

3.  **Configure M365 data retention.** Decide how long different types of data should be kept and when they should be deleted or archived. Ambiguity in retention can either lead to keeping data too long (risking compliance breaches or unnecessary storage costs) or deleting too soon (losing valuable history). **Best practice:** Use Microsoft Purview’s data lifecycle management for [Microsoft 365 data](/purview/get-started-with-data-lifecycle-management#common-scenarios) to set retention or deletion policies on emails, documents, and Teams messages.

4.  **Configure Azure data retention.** For data in Azure services (databases, storage accounts), set up their built-in retention and backup policies. This might include configuring backup retention for databases, like Azure SQL, Cosmos DB, and using Azure Storage [lifecycle management rules](/azure/storage/blobs/lifecycle-management-policy-configure?tabs=azure-portal) to archive or delete old data. The key is to mirror your compliance requirements in the technical settings of each service. As a leader, ensure your cloud governance team has defined standards for data retention and that each service’s owners are implementing those. See backup and retention docs for [Azure SQL Database](/azure/azure-sql/database/long-term-backup-retention-configure?view=azuresql&tabs=portal), [CosmosDB](/azure/cosmos-db/periodic-backup-modify-interval-retention?context=%2Fazure%2Fcosmos-db%2Fcontext%2Fcontext&tabs=azure-portal), and [MySQL](/azure/mysql/flexible-server/concepts-backup-restore).

5.  **Configure on-premises and other clouds data retention.** If you have important data outside of Azure or Microsoft 365, implement retention and backup processes for those as well. This could mean using Azure Backup or third-party backup solutions to pull backups of on-premise, AWS, and GCP data into a controlled Azure environment for long-term retention and archiving. The bottom line is that all enterprise data should have an intentional retention strategy. Whether it’s kept for a certain number of years for compliance or deleted when no longer needed. See [Backup cloud and on-premises workloads to cloud](/azure/backup/guidance-best-practices). You can also manually [upload](/azure/storage/common/storage-use-azcopy-blobs-upload?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json) files to Azure Storage (blob) and [archive](/azure/storage/blobs/archive-blob?tabs=azure-portal) the blob.

### 3. Data estate security baseline

After gaining visibility and setting compliance policies, apply **consistent security controls** across your data estate. The goal is a unified security posture so that sensitive data remains protected no matter where it lives or is used. **Checklist of best practices:**

1.  **Enable sensitive data classifiers.** Start by enabling sensitive information type (SIT) [data classifiers](/purview/data-classification-overview) in Microsoft Purview. These help automatically identify things like credit card numbers, social security numbers, and health record identifiers, in your data. **Best practice:** Turn on the relevant default classifiers and create custom ones if you have domain-specific sensitive data. For example, classify “trade secret” information or proprietary formulas. This automated detection feeds into labeling, DLP, and other protection mechanisms. 

2.  **Apply data loss prevention (DLP).** Configure DLP policies in Microsoft Purview to prevent leaks of sensitive data through everyday actions. This means setting up DLP for both Microsoft 365 (to cover emails, Office documents, Teams chats) and Microsoft Fabric. A DLP policy can, for instance, block a user from sharing a file externally if it contains confidential data like customer PII or health information. In Fabric, DLP can prevent analysts from sharing a dataset or report that includes sensitive data. For detailed configuration, refer to the guidance for [M365 apps](/purview/dlp-learn-about-dlp), [Copilot](/purview/dlp-microsoft365-copilot-location-learn-about), and [Microsoft Fabric](/purview/dlp-powerbi-get-started). **Decision guidance:**

    1.  **Monitor-only (audit mode):** Start with DLP in monitor-only mode when you’re concerned about disrupting work. It lets you observe and fine-tune policy behavior, but data may still be exposed because enforcement is not active.

    2.  **Blocking or restricting:** Move to blocking or restricting mode when data leakage would have a severe impact and your detection rules are reliable. Some legitimate actions may be blocked initially and will require exception handling and policy adjustments.

3.  **Protect data in Azure services.** Remember that using Purview and Fabric doesn’t automatically secure data that stays in other Azure services. It just catalogs and labels them. Ensure that each service, like Azure SQL, Azure Cosmos DB, Azure Storage, has appropriate security measures in place, such as encryption at rest, network protection, and Microsoft Defender or similar threat protection features enabled. See [Azure SQL Database](/azure/azure-sql/database/threat-detection-configure?view=azuresql), [Azure Cosmos DB](/azure/cosmos-db/defender-for-cosmos-db), and [Azure Storage](/azure/defender-for-cloud/defender-for-storage-introduction?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json).

4.  **Protect data in AI apps.** If you are developing custom AI applications, using Microsoft Foundry or other AI platforms, make sure these apps also respect the data governance rules. **Best practice:** Integrate your data governance (Purview) with your AI development lifecycle. Train developers and data scientists on how to handle sensitive data in line with your labels and policies. For critical AI apps, consider a review process ensuring they only use properly governed data sources. They should query data through the approved interfaces, like Fabric data agents or secured APIs, rather than direct, unmanaged connections. Use Purview’s APIs and integration points to feed security and sensitivity context into these applications. For instance, if your AI app retrieves data from a data product, it can check Purview to see if the data is labeled Confidential and then decide to mask certain outputs or not answer certain questions. See [Microsoft Purview and AI](/purview/ai-microsoft-purview) and [Purview with Foundry](/purview/developer/secure-ai-with-purview).

## 3.2 Data lake governance and security baselines

Now we focus specifically on governance and security inside the Microsoft Fabric OneLake environment. OneLake will accumulate data from across your enterprise, so it’s the hub of your analytics and AI data. Applying the same principles you established for the broader data estate, but tailored to the Fabric context, will keep this unified data lake secure and well-governed. 

### 1. Set environment governance baseline

A core governance decision is how you define and structure environments in Microsoft Fabric. In Fabric, **workspaces are the primary construct used to represent environments**, control access, allocate capacity, and apply governance. Most organizations converge on one of the following patterns. The right choice depends on how teams are organized, how strictly environments must be isolated, and which governance principles are most important for your organization.

**Option 1: One workspace per data product.** In this model, each major data product (with its full data pipeline) gets its own workspace. This is ideal when a single team is developing and managing the entire pipeline for a data product. Having everything in one workspace makes ownership clear and collaboration easier within the team. **Decision guidance:** Within the workspace, there are two ways to implement the medallion architecture. (If you don’t understand medallion architecture, see [Apply medallion architecture](#apply-medallion-architecture)).

- **Single Lakehouse with multiple schemas**: The simplest option is to use one [Lakehouse](/fabric/data-engineering/lakehouse-overview) in the workspace and separate raw (Bronze), cleaned (Silver), and curated (Gold) data by using distinct [schemas](/fabric/data-engineering/lakehouse-schemas) or folders. This approach keeps things simple (one place for all data), but it requires strong governance discipline to prevent accidental mixing of raw and curated data.

> :::image type="content" source="media/unify your data/image9.png" alt-text="":::
>
> *Figure X.* **Single Lakehouse with multiple schemas with** *One data product per Fabric workspace.*

- **Multiple Lakehouses for layers**: Alternatively, use multiple Lakehouse objects in the same workspace, dedicating one to each layer. There’s one Lakehouse for raw Bronze data, one for Silver, and one for Gold. This provides clearer separation and safety between stages. You can give different permissions or even use separate compute for each layer. But it adds more operational complexity when managing the workspace.

> :::image type="content" source="media/unify your data/image10.png" alt-text="":::
>
> *Figure X.* **Multiple Lakehouses for medallion layers with** *One data product per Fabric workspace.*

**Option 2: Multiple workspaces per data product (High Isolation).** In some cases, you might split a single data product’s pipeline across multiple workspaces. This pattern provides the highest level of isolation. It’s useful if different teams manage different stages of the pipeline or if you have strict requirements that the production-grade data be walled off from development work. **Tradeoff:** This approach increases coordination effort and complexity. Multiple workspaces for one product mean you will need processes to move data between those workspaces and to manage security across them. Choose this only when the benefits of isolation, such as meeting regulatory requirements or clear separation of duties between teams, outweigh the additional overhead.

> :::image type="content" source="media/unify your data/image11.png" alt-text="":::

*Figure X. Multiple Fabric workspaces per data product. One per medallion layer.*

**Option 3. One Fabric workspace for multiple data products (capacity-constrained scenarios).** If your organization faces constraints on the number of workspaces or available Fabric capacity (for example, due to licensing or cost limits), you might have to put multiple smaller data products into a single workspace. In this case, a domain team will manage several data products together in one container. **When to choose:** This is generally not ideal, but it may be necessary for small-scale deployments or during initial experimentation. Use it for less critical or low-volume data products if you don’t have enough capacity for each to have its own workspace. **Tradeoff:** The downside is reduced isolation. Multiple products sharing a workspace can lead to resource contention and intermingling of data. It also complicates governance. You’ll rely on naming conventions, access controls, and team discipline to keep each product’s data separate within the shared workspace.

**Standard to enforce:** Whichever workspace approach you choose, tie it back to your data domains. Make sure it mirrors how you want to delegate control and ensure clear data ownership. Also, document your workspace strategy and educate teams on how to use workspaces properly. For example, one workspace per product is the default unless a specific reason warrants otherwise).

### 2. Set cost governance baselines

A cost governance baseline defines how each data domain configures and operates Microsoft Fabric capacities so all workloads stay within the approved budget over time.

1.  **Define a Fabric budget.** A Fabric budget is the financial limit that applies to all workloads running on a data domain’s Fabric capacities. **Best practice:** Each data domain receives and sets a budget for its Fabric usage before onboarding any workloads. Treat this budget as a hard governance boundary, not a planning estimate. Spending decisions must align to it from day one.

2.  **Control which workloads can consume Fabric capacity.** Workspace assignment controls access to shared compute and shared spend. **Best practice:** Require approval before assigning new workspaces to Fabric capacities. Use this step to confirm business value and budget fit. **Decision guidance:** Limit assignment rights to a small number of platform owners when governance maturity is low. Broaden access only when cost discipline is proven. Restriction reduces surprise cost. Broader access increases speed.

3.  **Standardize permissions that influence capacity consumption**. Certain Fabric permissions allow actions that significantly increase capacity usage. **Best practice:** Restrict advanced creation and scaling permissions on high‑cost Fabric capacities. Assign elevated permissions only to trusted operational roles within the data domain. **Decision guidance:** Choose central role assignment when strong guardrails matter. Choose delegated assignment when teams show cost discipline. Central control reduces risk. Delegation improves speed but needs audit discipline.

### 3. Set data security baseline

Define workspace boundaries, ownership, labeling, and sharing rules *before* any data products are published so leaders can make consistent access and governance decisions across teams. This baseline prevents “ad-hoc” sharing patterns from becoming your default operating model. **Checklist of best practices:**

1.  **Establish workspace security baselines.** In Fabric, as mentioned, the workspace is a primary security boundary. Before teams start creating and publishing data products, define how you will manage workspace access.

    - *Who can create new workspaces?* Consider a process or approval for creating Fabric workspaces so they align with your governance. Uncontrolled workspace creation could lead to sprawl and data governance gaps. 

    - *Who can access what?* Ensure each workspace has assigned administrators and owners who control membership. Enforce the principle of **least privilege**: give each user or group the minimum permissions they need (viewer, contributor, admin). Avoid overly broad access or ad-hoc sharing of workspaces and items, because that can inadvertently expose data to the wrong people. 

> **Best practice**: Many organizations designate a primary Workspace Data Owner or administrator responsible for managing access and security settings for each workspace. They also establish naming conventions and metadata tags for workspaces indicating their purpose. Follow the [OneLake security best practices.](/fabric/onelake/security/best-practices-secure-data-in-onelake)

2.  **Apply sensitivity labels.** Fabric uses the same sensitivity label taxonomy you defined in Purview. However, you need to **default sensitivity labels** at various levels in OneLake so Fabric items receive the appropriate classification when created. **Best practices:** Configure default sensitivity labels at various levels:

    - **Fabric tenant:** Set default label policies at the Fabric tenant level, like “Internal”, to any new item if no one labels it. 

    - **Workspace:** Set default label policies at the Fabric tenant level. If a particular workspace often contains  sensitive data, you might auto-label everything created there as “Confidential” unless changed.

> This way, every dataset, table, or report in Fabric gets a label by default. Producers must intentionally downgrade or change it if needed. This approach prevents unlabeled and thus ungoverned data from proliferating. Over time, adjust these defaults as you see patterns. For example, if a workspace consistently produces public-ready data, maybe the default can be lowered there, or vice versa. See [default label policy](/fabric/governance/sensitivity-label-default-label-policy) and [default sensitivity labels](/fabric/governance/domain-default-sensitivity-label) in Fabric.

3.  **Apply protection policies.** Sensitivity labels classify data. Purview protection policies enforce access behavior. **Best practice:** Organizations define protection rules for each label tier. **Decision guidance:**

    - **Label-only:** If your organization is just starting with data classification, you might begin with labeling-only (no automatic enforcement) to focus on visibility and user education. This is simpler to implement initially but relies on users following guidelines.

    - **Protection policies:** If you already know you have sensitive data in OneLake that must be protected, you should configure label-based protection policies from the outset. This ensures that even if a user has access to data, they cannot perform disallowed actions (like sharing it publicly or downloading it unencrypted). The tradeoff of enabling protection policies is the added effort to design and test them, and the need to handle situations where they might block some legitimate access. This situation requires a process to override or refine policies. See Microsoft Purview [protection policies](/fabric/governance/protection-policies-overview).

4.  **Define data loss policies.** **Best practice:** Similar to DLP in Microsoft 365, set up [DLP policies for Fabric](/purview/dlp-powerbi-get-started#supported-item-types). This helps prevent accidental or risky sharing of data from OneLake.  See [supported item type](/purview/dlp-powerbi-get-started#supported-item-types) containing sensitive information, the policy triggers the configured actions. **Decision guidance:** Choose monitor only when you need to understand real behavior and you expect high change friction. You get evidence and you get time to tune. You also leave risk in place during the learning period. Choose block and restrict actions when exposure impact is high and when policy confidence is strong. You prevent common leakage paths and you enforce standard behavior.

5.  **Use data lineage.** Fabric automatically tracks lineage of data within and across workspaces. For example, it knows which dataflow or pipeline produced a given dataset, and which reports or AI models are using that dataset. It also passes lineage information to Purview. Make use of this lineage data. **Best practices:** Train your data engineers and stewards to use the built-in lineage views to trace how data moves from raw sources to final products. Encourage them to check lineage when diagnosing data quality issues or assessing the impact of a proposed change. Share lineage information with governance and audit teams through Purview’s reports. See [lineage in Fabric](/fabric/governance/lineage).

See [Microsoft Purview Information Protection in Fabric](/fabric/governance/microsoft-purview-fabric#microsoft-purview-and-microsoft-fabric-together).

### 4. Set a network security baseline

Fabric runs as a SaaS service in the Microsoft cloud. By default, it uses secure communication over the Microsoft global network. Any connection to on‑premises systems or external services should follow defined and approved network paths. **Best practices:** Set up standards for when to use public connectivity or private connectivity **Decision guidance:**

1.  **Public network connectivity:** By default, many services connect to Fabric over the internet using encryption (HTTPS). **When to choose:** This is acceptable for many scenarios, especially when data sensitivity is low and ease of setup is important, such as connecting to a public SaaS API. **Benefit:** Simpler configuration. There’s no special network setup needed. **Tradeoff:** Data travels over public networks (though encrypted). You are relying on internet connectivity and public endpoints which may be less controlled. 

2.  **Private network connectivity:** **When to choose:** For more sensitive data or stricter compliance needs, use private connectivity options. For Azure sources, prefer **Azure** Private Link or managed virtual network integration for Fabric connectors. For on-premises data, use a private data gateway or VPN/ExpressRoute connections to avoid exposing endpoints to the internet. **Benefit:** Traffic stays on controlled networks, reducing exposure. **Tradeoff:** More complex to set up and manage. It requires networking configuration and possible impact on performance or cost due to routing through private links.

> See [Network security in Fabric](/fabric/security/security-overview#understand-network-security).

### 5. Use the monitoring baseline

Use the [Microsoft Purview Hub](/fabric/governance/use-microsoft-purview-hub?tabs=overview)  to monitor your Fabric environment. The Purview Hub provides a single pane where you can see all Fabric assets, (like tables, datasets, reports. You can also see their metadata, like sensitivity labels, ownership, and lineage. This helps your governance team ensure that everything in OneLake is classified and that data flows are understood. It’s a great tool for data stewards to catch issues, like a dataset missing a description or a sensitive data store without a label, and to maintain the quality of the catalog. Regularly reviewing the Purview Hub can become part of your data governance routine. It’s an actionable way to enforce the standards you’ve set.

### Next step

By establishing these governance and security **baselines** for both your overall data estate and specifically for OneLake, you create a safe environment for data innovation. Good governance is invisible when done well. It operates in the background, ensuring people have access to the data they need **without compromising security or compliance**. The next step is making sure you have robust operational processes so that data flows from sources to insights in a consistent, reliable manner. 
