---
title: Data governance and security baselines with Microsoft Purview
description: "Data governance and security baselines with Microsoft Purview"
#customer intent: As a technology decision maker, I want to have a governance and security baseline checklist that I can use to ensure all my data sources are visible, compliant, governed, secured, and monitored.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 03/09/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Data governance and security baselines

With the foundational strategy and architecture in place, you must establish strong governance and security practices from the very beginning. This ensures that as data from all corners of the organization flows into your unified platform, it remains well-managed, compliant, and secure. We will break this into two parts: governing the overall data estate (all data across cloud and on-premises, not just Fabric) and then the specific governance and security measures within Microsoft Fabric OneLake.

## 1. Data visibility baseline

Data governance starts with a clear view of all your data assets across the entire estate. Before focusing on Fabric specifically, use Microsoft Purview to gain visibility and control over data *wherever it resides*: Azure services, Microsoft 365, other clouds like AWS or Google, on-premises databases, SaaS applications, etc. Establishing a strong data estate governance baseline will ensure consistency once that data enters OneLake. **Here’s a checklist of best practices:**

### 1.1 Create a data catalog

The cornerstone of governance is a comprehensive inventory (catalog) of data assets. Use [Microsoft Purview's Unified Catalog](/purview/unified-catalog) as your organization’s single source of truth about data. This catalog stores information about each data asset’s location, what it contains, who owns it, how it’s classified, and how it flows between systems. Here’s how:

1. **Use governance domains**. Organize the Unified Catalog using Purview [governance domains](/purview/unified-catalog-plan#create-governance-domains) that align to existing data domains. Collections, roles, and permissions should reflect these boundaries, so each data domain has authority in their area. The Unified Catalog begins empty, but as data sources are registered and scanned, it grows into an accurate map of the estate. Setting domains early brings clarity as the catalog expands.

2. **Define data glossary.** With structure in place, the next step is creating a shared business glossary that anchors the organization’s most important concepts and metrics. Terms such as Customer, Product, Employee, and Location, and measures like Revenue or Headcount, often vary subtly across departments unless intentionally harmonized. Documenting these definitions as [Glossary Terms](/purview/unified-catalog-glossary-terms) the Unified Catalog and communicating them broadly helps eliminate ambiguity. This clarity supports consistent AI, analytics, and reporting practices across teams.

### 1.2. Map data sources

Once the catalog and glossary are established, all relevant data sources must be visible in Purview. Registering and scanning systems across the estate populates the [Data Map](/purview/data-map-scan-ingestion) with metadata from your scanned data sources. It does not bring the actual into Purview. It does not replace the security controls of each data source. **Best practices:**

1. **Create Purview architecture.** Use Purview collections and [Data Map domains](/purview/data-map-domains) to align permissions and governance with the needs of your data domains. These constructs define boundaries for access control, policy management, and operational responsibility. Follow Purview [domain and collection architecture best practices](/purview/data-gov-best-practices-domains-collections#domains-and-collections-archetypes).

2. **Set up Purview for Microsoft 365 data.** Purview has native integration with Microsoft 365 data (such as SharePoint, OneDrive, Exchange, Teams). Ensure that content in Microsoft 365 is also being governed. When Microsoft 365 documents and messages are brought into OneLake or otherwise used in analytics, any labels or classifications from Microsoft 365 will carry over. In Purview, you’ll be able to see things like sensitivity labels and retention labels that were applied in the M365 environment. See [Microsoft Purview setup guides](/purview/purview-fast-track-setup-guides).

3. **Scan Microsoft Fabric OneLake.** Fabric OneLake is not automatically included in the Purview Data Map and must be explicitly registered and scanned. Scanning OneLake enables metadata discovery, lineage tracking, and cataloging of Fabric assets in Purview. See [Register and scan Microsoft Fabric](/purview/register-scan-fabric-tenant?tabs=Scenario1).

### 1.3. Scan cloud, SaaS and on-premises data

Data stored in Azure services, Microsoft Dataverse, on‑premises systems, and other clouds (AWS, Google Cloud, Oracle) requires connector-based scanning. See how to [Register](/purview/data-map-data-sources-register-manage#register-a-new-source) and scan [supported data sources in Data Map](/purview/data-map-data-sources). Make sure to follow Purview’s [scanning best practices](/purview/data-map-scanning-best-practices), such as scheduling scans during off-peak hours and monitoring for any scan failures

Before scanning begins, a choice must be made about whether to scan source systems or only scan the Microsoft Fabric OneLake layer. This decision depends on visibility needs, compliance requirements, operational overhead, and the role each system plays in analytics and reporting. **Decision guidance:**

1.  **When to scan source systems.** Scanning operational systems such as Azure databases or AWS S3 provides end‑to‑end lineage from the system of record. This is important for regulated or business‑critical data where full provenance supports audits and compliance. It provides the clearest visibility into upstream changes but introduces complexity. Connector configuration, credentials, and scheduling require attention, and some sources require you to [Choose the right integration runtime.](/purview/data-map-integration-runtime-choose)

2.  **When to scan only the Fabric layer*.*** If deep visibility into upstream systems is not required, scanning only the Fabric layer simplifies the governance model. Lineage begins when data enters Fabric, reducing integration work in environments where upstream systems are already well governed or where compliance obligations do not require full lineage. This approach reduces operational friction while still supporting analytics scenarios. See [Fabric](/purview/register-scan-fabric-tenant?tabs=Scenario1) in Microsoft Purview.

### 1.4. Apply sensitivity labels

Sensitivity labels are a fundamental tool for classifying and protecting data. In Microsoft Purview, there are typically two kinds of sensitivity labels:

- **Metadata-only labels**: These labels are metadata tags in the Purview catalog. For example, labeling an Azure SQL table as “Confidential” in the catalog without it affecting the source system directly. These help track and manage data sensitivity in Purview for assets outside of Microsoft 365/Fabric.

- **Protective labels:** These labels that not only mark data with a classification, like “Confidential”, but also enforce protection. They can enforce encryption or restricted access on files and emails. These are heavily used in Microsoft 365 and now extend into Fabric as well.

Both contribute to a consistent governance model, and clarity about their purpose helps align the right label type to the right scenario. **Best practices** for labeling:

1. **Define a sensitivity label taxonomy.** Define a simple, organization-wide labeling schema. A common schema is Non-business, Public, General, Confidential, Highly Confidential. Make sure everyone understands what each label means and what types of data fall under each category. Get buy-in on this taxonomy from compliance and business stakeholders. See [Get started with sensitivity labels.](/purview/get-started-with-sensitivity-labels)

2. **Label Microsoft 365 data (protection label).** Ensure Microsoft 365 information is labeled using Microsoft Purview Information Protection. These labels impose security controls (encryption, restricted access) and they persist with the data even when it’s brought into OneLake or shared via other tools. **Best practice:** Many organizations set up auto-labeling policies to detect sensitive info, like credit card numbers or personal data, and automatically apply a label. See [automatically apply sensitivity labels to Microsoft 365 data](/purview/apply-sensitivity-label-automatically).

3. **Label Microsoft Fabric data (protected label).** Microsoft Fabric supports [protected sensitivity labels](/fabric/governance/protected-sensitivity-labels) on its own assets, like tables in a Lakehouse, and Power BI datasets. Configure [default label policies](/fabric/governance/sensitivity-label-default-label-policy) in Fabric so that new data in OneLake is labeled appropriately from creation. For instance, you could specify that any new dataset in certain workspaces is by default labeled as internal or confidential unless changed. This ensures no data enters the lake without classification. Adjust these defaults for areas that handle highly sensitive data versus those that are open. See [Govern Fabric](#data-lake-governance-and-security-baselines).

4. **Label entries in Purview Data Map (metadata-only label).** For data sources that are scanned into Purview (like an AWS S3 bucket or an on-prem database), apply metadata labels in the Purview Data Map. While these won’t encrypt or restrict the data at the source, they do inform users and systems that the data is, say, confidential. They can also trigger additional governance workflows. Essentially, everything in your catalog should have a sensitivity designation. See [Use autolabeling policies](/purview/data-map-sensitivity-labels-apply) to detect data assets and apply these metadata-only sensitivity labels automatically.

### 1.5. Capture data lineage

Data lineage shows the lifecycle of data, beginning with its origin and continuing as it moves across systems. It helps with root-cause analysis, debugging, troubleshooting, and other investigative work. Microsoft Purview [automates](/purview/data-gov-classic-lineage-user-guide#lineage-collection) lineage capture for many assets. Where automation is not available, you can add lineage manually in Purview to fill gaps. See [Manual lineage setup](/purview/data-gov-classic-lineage-user-guide#manual-lineage). Configure data lineage in Purview for [Fabric](/purview/data-map-lineage-fabric) and, as needed, for [Azure Databricks](/purview/unified-catalog-data-quality-azure-databricks-unity-catalog).

## 2. Data estate compliance baseline

Once the estate is cataloged and the organization has a clear view of what data exists and where it resides, the next step is understanding the regulatory, legal, and internal obligations that govern that data. Microsoft Purview provides the tools to interpret those obligations, evaluate current alignment, and guide the work needed to meet them. **Here’s a checklist of best practices:**

1. **Define your compliance requirements.** Compliance requirements vary by industry, region, and workload. The governance model must reflect them before any protective or technical controls are applied. Identify which regulatory frameworks or industry standards are relevant to your organization. **Best practices:** Use Microsoft Purview [regulatory templates](/purview/compliance-manager-regulations-list) and [assessments](/purview/compliance-manager-assessments). They represent standards such as [GDPR](/compliance/regulatory/gdpr), [HIPAA and HITECH](/compliance/regulatory/offering-hipaa-hitech), [PCI DSS v4.0](/compliance/regulatory/offering-pci-dss), [Sarbanes-Oxley Act](/compliance/regulatory/offering-sox), and [ISO 27001](/compliance/regulatory/offering-iso-27017). Review these templates to understand which rules apply across Microsoft 365, Azure, AWS, and Google Cloud. These provide a checklist of controls and practices you should have in place. Use the Compliance Manager’s scores and recommendations to gauge your current posture, identify gaps, and prioritize what to address first.

2. **Monitor data compliance.** Once you’ve set up Purview’s compliance templates, regularly review the **compliance score** and reports. Purview will automatically assess aspects of compliance for [Microsoft 365 data](/purview/compliance-manager-setup) and data across [Azure, AWS, and Google Cloud](/purview/compliance-manager-multicloud). It will highlight issues and suggested actions to improve compliance. Set up alerts for any critical compliance policy violations **Best practices:** If sensitive data is found in an unapproved location or if a retention policy is violated, responsible teams should be notified immediately to take action. Steady monitoring and incremental improvements will ensure you’re not caught off guard by audits or incidents.

3. **Configure M365 data retention.** Decide how long different types of data should be kept and when they should be deleted or archived. Ambiguity in retention can either lead to keeping data too long (risking compliance breaches or unnecessary storage costs) or deleting too soon (losing valuable history). **Best practice:** Use Microsoft Purview’s data lifecycle management for [Microsoft 365 data](/purview/get-started-with-data-lifecycle-management#common-scenarios) to set retention or deletion policies on emails, documents, and Teams messages.

4. **Configure Azure data retention.** For data in Azure services (databases, storage accounts), set up their built-in retention and backup policies. This might include configuring backup retention for databases, like Azure SQL, Cosmos DB, and using Azure Storage [lifecycle management rules](/azure/storage/blobs/lifecycle-management-policy-configure?tabs=azure-portal) to archive or delete old data. The key is to mirror your compliance requirements in the technical settings of each service. As a leader, ensure your cloud governance team has defined standards for data retention and that each service’s owners are implementing those. See backup and retention docs for [Azure SQL Database](/azure/azure-sql/database/long-term-backup-retention-configure?view=azuresql&tabs=portal), [CosmosDB](/azure/cosmos-db/periodic-backup-modify-interval-retention?context=%2Fazure%2Fcosmos-db%2Fcontext%2Fcontext&tabs=azure-portal), and [MySQL](/azure/mysql/flexible-server/concepts-backup-restore).

5. **Configure on-premises and other clouds data retention.** If you have important data outside of Azure or Microsoft 365, implement retention and backup processes for those as well. This could mean using Azure Backup or third-party backup solutions to pull backups of on-premise, AWS, and GCP data into a controlled Azure environment for long-term retention and archiving. The bottom line is that all enterprise data should have an intentional retention strategy. Whether it’s kept for a certain number of years for compliance or deleted when no longer needed. See [Backup cloud and on-premises workloads to cloud](/azure/backup/guidance-best-practices). You can also manually [upload](/azure/storage/common/storage-use-azcopy-blobs-upload?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json) files to Azure Storage (blob) and [archive](/azure/storage/blobs/archive-blob?tabs=azure-portal) the blob.

## 3. Data estate security baseline

After gaining visibility and setting compliance policies, apply **consistent security controls** across your data estate. The goal is a unified security posture so that sensitive data remains protected no matter where it lives or is used. **Checklist of best practices:**

1. **Enable sensitive data classifiers.** Start by enabling sensitive information type (SIT) [data classifiers](/purview/data-classification-overview) in Microsoft Purview. These help automatically identify things like credit card numbers, social security numbers, and health record identifiers, in your data. **Best practice:** Turn on the relevant default classifiers and create custom ones if you have domain-specific sensitive data. For example, classify “trade secret” information or proprietary formulas. This automated detection feeds into labeling, DLP, and other protection mechanisms.

2. **Apply data loss prevention (DLP).** Configure DLP policies in Microsoft Purview to prevent leaks of sensitive data through everyday actions. This means setting up DLP for both Microsoft 365 (to cover emails, Office documents, Teams chats) and Microsoft Fabric. A DLP policy can, for instance, block a user from sharing a file externally if it contains confidential data like customer PII or health information. In Fabric, DLP can prevent analysts from sharing a dataset or report that includes sensitive data. For detailed configuration, refer to the guidance for [M365 apps](/purview/dlp-learn-about-dlp), [Copilot](/purview/dlp-microsoft365-copilot-location-learn-about), and [Microsoft Fabric](/purview/dlp-powerbi-get-started). **Decision guidance:**

    - **Monitor-only (audit mode):** Start with DLP in monitor-only mode when you’re concerned about disrupting work. It lets you observe and fine-tune policy behavior, but data may still be exposed because enforcement is not active.

    - **Blocking or restricting:** Move to blocking or restricting mode when data leakage would have a severe impact and your detection rules are reliable. Some legitimate actions may be blocked initially and will require exception handling and policy adjustments.

3. **Protect data in Azure services.** Remember that using Purview and Fabric doesn’t automatically secure data that stays in other Azure services. It just catalogs and labels them. Ensure that each service, like Azure SQL, Azure Cosmos DB, Azure Storage, has appropriate security measures in place, such as encryption at rest, network protection, and Microsoft Defender or similar threat protection features enabled. See [Azure SQL Database](/azure/azure-sql/database/threat-detection-configure?view=azuresql), [Azure Cosmos DB](/azure/cosmos-db/defender-for-cosmos-db), and [Azure Storage](/azure/defender-for-cloud/defender-for-storage-introduction?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json).

4. **Protect data in AI apps.** If you are developing custom AI applications, using Microsoft Foundry or other AI platforms, make sure these apps also respect the data governance rules. **Best practice:** Integrate your data governance (Purview) with your AI development lifecycle. Train developers and data scientists on how to handle sensitive data in line with your labels and policies. For critical AI apps, consider a review process ensuring they only use properly governed data sources. They should query data through the approved interfaces, like Fabric data agents or secured APIs, rather than direct, unmanaged connections. Use Purview’s APIs and integration points to feed security and sensitivity context into these applications. For instance, if your AI app retrieves data from a data product, it can check Purview to see if the data is labeled Confidential and then decide to mask certain outputs or not answer certain questions. See [Microsoft Purview and AI](/purview/ai-microsoft-purview) and [Purview with Foundry](/purview/developer/secure-ai-with-purview).

