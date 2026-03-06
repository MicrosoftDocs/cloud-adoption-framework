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

# Data governance and security baselines with Microsoft Purview

With the foundational strategy and architecture in place, establish strong governance and security practices from the very beginning. This approach ensures that as data from all corners of the organization flows into your unified platform, it remains well-managed, compliant, and secure. This article focuses on all data across clouds and on-premises by using Microsoft Purview (see Figure 1.).

:::image type="content" source="images/purview-architecture-governance-data-estate.svg" alt-text="Diagram showing  how Microsoft Purview provides a single governance and security foundation for all organizational data. At the bottom, there are all data sources, including on‑premises systems, Dataverse, Microsoft 365, Azure, Google Cloud, and Amazon S3. These data sources belong to organizational data domains. Each data domain scans its data sources into the Microsoft Purview Data Map. The Data Map feeds the Unified Catalog, which acts as one catalog for all data across the organization. Inside the Unified Catalog, you organize data by Purview governance domains that align to data domains. Each governance domain is responsible for sensitivity labels, data classification, lineage, compliance, data retention, data loss prevention, and data use in AI. Shared governance capabilities include the data glossary, data classifiers, and the sensitivity label taxonomy. At the top, governed data products flow into Microsoft Fabric. Tools like Microsoft Copilot Studio and Microsoft 365 Copilot consume them." lightbox="images/purview-architecture-governance-data-estate.svg" border="false":::
*Figure 1. Microsoft Purview's role in data governance and security baselines.*

## 1. Data visibility baseline

Data governance starts with a clear view of all your data assets across the entire estate. Before focusing on Fabric specifically, use Microsoft Purview to gain visibility and control over data *wherever it resides*: Azure services, Microsoft 365, other clouds like AWS or Google, on-premises databases, SaaS applications, and more. Establishing a strong data estate governance baseline ensures consistency once that data enters OneLake. **Here’s a checklist of best practices:**

### 1.1 Create a data catalog

The cornerstone of governance is a comprehensive inventory (catalog) of data assets. Use [Microsoft Purview's Unified Catalog](/purview/unified-catalog) as your organization’s single source of truth about data. This catalog stores information about each data asset’s location, what it contains, who owns it, its classification, and how it flows between systems. Here’s how:

1. **Use governance domains**. Organize the Unified Catalog by using Purview [governance domains](/purview/unified-catalog-plan#create-governance-domains) that align to existing data domains. Collections, roles, and permissions should reflect these boundaries, so each data domain has authority in their area. The Unified Catalog begins empty, but as data sources are registered and scanned, it grows into an accurate map of the estate. Setting domains early brings clarity as the catalog expands.

2. **Define data glossary.** With structure in place, create a shared business glossary that anchors the organization’s most important concepts and metrics. Terms such as Customer, Product, Employee, and Location, and measures like Revenue or Headcount, often vary subtly across departments unless intentionally harmonized. Document these definitions as [Glossary Terms](/purview/unified-catalog-glossary-terms) in the Unified Catalog and communicate them broadly to help eliminate ambiguity. This clarity supports consistent AI, analytics, and reporting practices across teams.

### 1.2. Map data sources

Once the catalog and glossary are established, make all relevant data sources visible in Purview. Register and scan systems across the estate to populate the [Data Map](/purview/data-map-scan-ingestion) with metadata from your scanned data sources. Note, it doesn't bring the actual data into Purview. So, it doesn't replace the need to apply security controls at data source, like resources in Azure. **Best practices:**

1. **Create Purview architecture.** Use Purview collections and [Data Map domains](/purview/data-map-domains) to align permissions and governance with the needs of your data domains. These constructs define boundaries for access control, policy management, and operational responsibility. Follow Purview [domain and collection architecture best practices](/purview/data-gov-best-practices-domains-collections#domains-and-collections-archetypes).

2. **Set up Purview for Microsoft 365 data.** Purview has native integration with Microsoft 365 data (such as SharePoint, OneDrive, Exchange, Teams). Ensure that you also govern content in Microsoft 365. When you bring Microsoft 365 documents and messages into OneLake or otherwise use them in analytics, any labels or classifications from Microsoft 365 carry over. In Purview, you can see sensitivity labels and retention labels that you applied in the Microsoft 365 environment. To learn more, see [Microsoft Purview setup guides](/purview/purview-fast-track-setup-guides).

3. **Scan Microsoft Fabric OneLake.** Fabric OneLake isn't automatically included in the Purview Data Map. You must explicitly register and scan it. Scanning OneLake enables metadata discovery, lineage tracking, and cataloging of Fabric assets in Purview. To learn more, see [Register and scan Microsoft Fabric](/purview/register-scan-fabric-tenant).

### 1.3. Scan cloud, SaaS, and on-premises data

Data stored in Azure services, Microsoft Dataverse, on‑premises systems, and other clouds (AWS, Google Cloud, Oracle) require connector-based scanning. See how to [Register](/purview/data-map-data-sources-register-manage#register-a-new-source) and scan [supported data sources in Data Map](/purview/data-map-data-sources). Make sure to follow Purview’s [scanning best practices](/purview/data-map-scanning-best-practices), such as scheduling scans during off-peak hours and monitoring for any scan failures

Before scanning begins, choose whether to scan source systems or only scan the Microsoft Fabric OneLake layer. This decision depends on visibility needs, compliance requirements, operational overhead, and the role each system plays in analytics and reporting. **Decision guidance:**

1. **When to scan source systems.** Scanning operational systems such as Azure databases or AWS S3 provides end-to-end lineage from the system of record. This information is important for regulated or business-critical data where full provenance supports audits and compliance. It provides the clearest visibility into upstream changes but introduces complexity. Connector configuration, credentials, and scheduling require attention, and some sources require you to [Choose the right integration runtime.](/purview/data-map-integration-runtime-choose)

2. **When to scan only the Fabric layer.** If deep visibility into upstream systems isn't required, scanning only the Fabric layer simplifies the governance model. Lineage begins when data enters Fabric. This approach reduces integration work. It's best for data where upstream systems are well governed or where compliance obligations don't require full lineage. To learn more, see [Fabric](/purview/register-scan-fabric-tenant) in Microsoft Purview.

### 1.4. Apply sensitivity labels

Sensitivity labels are a fundamental tool for classifying and protecting data. In Microsoft Purview, there are typically two kinds of sensitivity labels:

- **Metadata-only labels**: These labels are metadata tags in the Purview catalog. For example, labeling an Azure SQL table as "Confidential" in the catalog without affecting the source system directly. These labels help track and manage data sensitivity in Purview for assets outside of Microsoft 365/Fabric.

- **Protective labels:** These labels not only mark data with a classification, like "Confidential," but also enforce protection. They can enforce encryption or restricted access on files and emails. Use these labels heavily in Microsoft 365 and now extend into Fabric as well.

Both contribute to a consistent governance model, and clarity about their purpose helps align the right label type to the right scenario. **Best practices** for labeling:

1. **Define a sensitivity label taxonomy.** Define an organizational labeling schema. A common schema is Non-business, Public, General, Confidential, Highly Confidential. Make sure everyone understands what each label means and what types of data fall under each category. Get buy-in on this taxonomy from compliance and business stakeholders. See [Get started with sensitivity labels.](/purview/get-started-with-sensitivity-labels)

2. **Label Microsoft 365 data (protection label).** Ensure Microsoft 365 information is labeled by using Microsoft Purview Information Protection. These labels impose security controls (encryption, restricted access). They persist with the data when brought into OneLake or shared via other tools. **Best practice:** Many organizations set up auto-labeling policies to detect sensitive info, like credit card numbers or personal data, and automatically apply a label. See [automatically apply sensitivity labels to Microsoft 365 data](/purview/apply-sensitivity-label-automatically).

3. **Label Microsoft Fabric data (protected label).** Microsoft Fabric supports [protected sensitivity labels](/fabric/governance/protected-sensitivity-labels) on its own assets, like tables in a Lakehouse, and Power BI datasets. Configure [default label policies](/fabric/governance/sensitivity-label-default-label-policy) in Fabric so that new data in OneLake is labeled appropriately from creation. For instance, you could specify that any new dataset in certain workspaces is by default labeled as internal or confidential unless changed. This approach ensures no data enters the lake without classification. Adjust these defaults for areas that handle sensitive data. See [Govern Fabric](./governance-security-baselines-fabric-data-lake-unify-data.md#3-set-data-security-baseline).

4. **Label entries in Purview Data Map (metadata-only label).** For data sources that are scanned into Purview (like an AWS S3 bucket or an on-premises database), apply metadata labels in the Purview Data Map. While these labels don't encrypt or restrict the data at the source, they do inform users and systems that the data is, say, confidential. They can also trigger other governance workflows. Essentially, everything in your catalog should have a sensitivity designation. See [Use autolabeling policies](/purview/data-map-sensitivity-labels-apply) to detect data assets and apply these metadata-only sensitivity labels automatically.

### 1.5. Capture data lineage

Data lineage shows the lifecycle of data, beginning with its origin and continuing as it moves across systems. It helps with root-cause analysis, debugging, troubleshooting, and other investigative work. Microsoft Purview [automates](/purview/data-gov-classic-lineage-user-guide#lineage-collection) lineage capture for many assets. Where automation isn't available, you can add lineage manually in Purview to fill gaps. See [Manual lineage setup](/purview/data-gov-classic-lineage-user-guide#manual-lineage). Configure data lineage in Purview for [Fabric](/purview/data-map-lineage-fabric) and, as needed, for [Azure Databricks](/purview/unified-catalog-data-quality-azure-databricks-unity-catalog).

## 2. Data estate compliance baseline

With a data catalog ready, the next step is understanding the regulatory, legal, and internal obligations that govern that data. Microsoft Purview provides the tools to interpret those obligations, evaluate current alignment, and guide the work needed to meet them. **Here’s a checklist of best practices:**

1. **Define your compliance requirements.** Compliance requirements vary by industry, region, and workload. The governance model must reflect them before you apply any protective or technical controls. Identify which regulatory frameworks or industry standards are relevant to your organization. **Best practices:** Use Microsoft Purview [regulatory templates](/purview/compliance-manager-regulations-list) and [assessments](/purview/compliance-manager-assessments). They represent standards such as [GDPR](/compliance/regulatory/gdpr), [HIPAA and HITECH](/compliance/regulatory/offering-hipaa-hitech), [PCI DSS v4.0](/compliance/regulatory/offering-pci-dss), [Sarbanes-Oxley Act](/compliance/regulatory/offering-sox), and [ISO 27001](/compliance/regulatory/offering-iso-27017). Review these templates to understand which rules apply across Microsoft 365, Azure, AWS, and Google Cloud. These templates provide a checklist of controls and practices you should have in place. Use the Compliance Manager’s scores and recommendations to gauge your current posture, identify gaps, and prioritize what to address first.

2. **Monitor data compliance.** Once you set up Purview’s compliance templates, regularly review the **compliance score** and reports. Purview automatically assesses aspects of compliance for [Microsoft 365 data](/purview/compliance-manager-setup) and data across [Azure, AWS, and Google Cloud](/purview/compliance-manager-multicloud). It highlights issues and suggested actions to improve compliance. Set up alerts for any critical compliance policy violations. **Best practices:** If Purview finds sensitive data in an unapproved location or if a retention policy is violated, notify responsible teams immediately so they can take action. Steady monitoring and incremental improvements ensure you’re not caught off guard by audits or incidents.

3. **Configure M365 data retention.** Decide how long to keep different types of data and when to delete or archive it. Ambiguity in retention can either lead to keeping data too long (risking compliance breaches or unnecessary storage costs) or deleting too soon (losing valuable history). **Best practice:** Use Microsoft Purview’s data lifecycle management for [Microsoft 365 data](/purview/get-started-with-data-lifecycle-management#common-scenarios) to set retention or deletion policies on emails, documents, and Teams messages.

4. **Configure Azure data retention.** For data in Azure services (databases, storage accounts), set up their built-in retention and backup policies. This setup might include configuring backup retention for databases, like Azure SQL, Cosmos DB. Or it might require using Azure Storage [lifecycle management rules](/azure/storage/blobs/lifecycle-management-policy-configure) to archive or delete old data. Mirror your compliance requirements in the technical settings of each service. As a leader, ensure your cloud governance team defines standards for data retention and that each service’s owners implement those standards. See backup and retention docs for [Azure SQL Database](/azure/azure-sql/database/long-term-backup-retention-configure), [Cosmos DB](/azure/cosmos-db/periodic-backup-modify-interval-retention), and [MySQL](/azure/mysql/flexible-server/concepts-backup-restore).

5. **Configure on-premises and other clouds data retention.** If you have important data outside of Azure or Microsoft 365, implement retention and backup processes for those data sources as well. This implementation could mean using Azure Backup or third-party backup solutions. These solutions pull backups of on-premises, AWS, and GCP data into Azure for long-term retention and archiving. The bottom line is that all data should have an intentional retention strategy. Keep it for compliance or delete it when no longer needed. See [Backup cloud and on-premises workloads to cloud](/azure/backup/guidance-best-practices). You can also manually [upload](/azure/storage/common/storage-use-azcopy-blobs-upload) files to Azure Storage (blob) and [archive](/azure/storage/blobs/archive-blob) the blob.

## 3. Data estate security baseline

After gaining visibility and setting compliance policies, apply **consistent security controls** across your data estate. The goal is a unified security posture so that sensitive data stays protected no matter where it lives or is used. **Checklist of best practices:**

1. **Enable sensitive data classifiers.** Start by enabling sensitive information type (SIT) [data classifiers](/purview/data-classification-overview) in Microsoft Purview. These classifiers help automatically identify sensitive data like credit card numbers, social security numbers, and health record identifiers. **Best practice:** Turn on the relevant default classifiers and create custom ones if you have domain-specific sensitive data. For example, classify "trade secret" information or proprietary formulas. This automated detection feeds into labeling, DLP, and other protection mechanisms.

2. **Apply data loss prevention (DLP).** Configure DLP policies in Microsoft Purview to prevent leaks of sensitive data through everyday actions. Set up DLP for both Microsoft 365 (to cover emails, Office documents, Teams chats) and Microsoft Fabric. A DLP policy can block a user from sharing a file externally if it contains confidential data like customer personal data or health information. In Fabric, DLP can prevent analysts from sharing a dataset or report that includes sensitive data. For detailed configuration, refer to the guidance for [Microsoft 365 apps](/purview/dlp-learn-about-dlp), [Copilot](/purview/dlp-microsoft365-copilot-location-learn-about), and [Microsoft Fabric](/purview/dlp-powerbi-get-started). **Decision guidance:**

    - **Monitor-only (audit mode):** Start with DLP in monitor-only mode when you’re concerned about disrupting work. It lets you observe and fine-tune policy behavior, but data might still be exposed because enforcement isn't active.

    - **Blocking or restricting:** Move to blocking or restricting mode when data leakage would have a severe effects and your detection rules are reliable. Some legitimate actions might be blocked initially and will require exception handling and policy adjustments.

3. **Protect data in Azure services.** Remember that using Purview and Fabric doesn’t automatically secure data that stays in other Azure services. It just catalogs and labels them. Ensure that each service, like Azure SQL, Azure Cosmos DB, and Azure Storage, has appropriate security measures in place. These measure include network protection and enabling Microsoft Defender. See [Azure SQL Database](/azure/azure-sql/database/threat-detection-configure), [Azure Cosmos DB](/azure/cosmos-db/defender-for-cosmos-db), and [Azure Storage](/azure/defender-for-cloud/defender-for-storage-introduction).

4. **Protect data in AI apps.** If you're developing custom AI applications with Microsoft Foundry, make sure these apps also respect the data governance rules. **Best practice:** Integrate your data governance (Purview) with your AI development lifecycle. Train developers and data scientists on how to handle sensitive data in line with your labels and policies. For critical AI apps, consider a review process ensuring they only use properly governed data sources. They should query data through the approved interfaces, like Fabric data agents or secured APIs, rather than direct, unmanaged connections. Use Purview’s APIs. They feed security and sensitivity context into these applications. For instance, if your AI app retrieves data from a data product, it can check Purview to see if the data is labeled Confidential. Then, it can decide to mask certain outputs or not answer certain questions. See [Microsoft Purview and AI](/purview/ai-microsoft-purview) and [Purview with Foundry](/purview/developer/secure-ai-with-purview).

# Next step

> [!div class="nextstepaction"]
> [Fabric governance and security baselines](./governance-security-baselines-fabric-data-lake-unify-data.md)