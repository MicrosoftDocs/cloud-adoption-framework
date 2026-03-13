---
title: Data governance and security baselines with Microsoft Purview
description: "Data governance and security baselines with Microsoft Purview"
#customer intent: As a technology decision maker, I want to have a governance and security baseline checklist that I can use to ensure all my data sources are visible, compliant, governed, secured, and monitored.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 03/10/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Data governance and security baselines with Microsoft Purview

With the foundational strategy and architecture in place, establish strong governance and security practices from the very beginning. This approach makes sure that as data from all corners of the organization flows into your unified platform, it remains well managed, compliant, and secure. **Recommendation:** Set Microsoft Purview as the system of record for data governance and security so your organization can apply consistent policy, accountability, and compliance across the full data estate (see Figure 1). To apply this recommendation, use this article as a checklist:

:::image type="content" source="images/purview-architecture-governance-data-estate.svg" alt-text="Diagram showing how Microsoft Purview provides a single governance and security foundation for all organizational data. At the bottom, there are all data sources, including on‑premises systems, Dataverse, Microsoft 365, Azure, Google Cloud, and Amazon S3. These data sources belong to organizational data domains. Each data domain scans its data sources into the Microsoft Purview Data Map. The Data Map feeds the Unified Catalog, which acts as one catalog for all data across the organization. Inside the Unified Catalog, you organize data by Purview governance domains that align to data domains. Each governance domain is responsible for sensitivity labels, data classification, lineage, compliance, data retention, data loss prevention, and data use in AI. Shared governance capabilities include the data glossary, data classifiers, and the sensitivity label taxonomy. At the top, governed data products flow into Microsoft Fabric. Tools like Microsoft Copilot Studio and Microsoft 365 Copilot consume them." lightbox="images/purview-architecture-governance-data-estate.svg" border="false":::
*Figure 1. Microsoft Purview's role in data governance and security baselines.*

## 1. Data visibility baseline

Data governance starts with a clear view of all your data assets across the entire estate. **Recommendation:** Establish a consistent visibility baseline with Microsoft Purview before data enters OneLake. This approach helps governance decisions remain consistent across platforms and teams. To apply this recommendation, use the following checklist:

### 1.1. Create a data catalog

A centralized data catalog provides decision makers with a single system of record for understanding what data exists, where it resides, and who owns it. **Recommendation:** Use [Microsoft Purview's Unified Catalog](/purview/unified-catalog) as the authoritative inventory for all enterprise data assets. To apply this recommendation, use the following checklist:

1. **Use governance domains.** Organize the Unified Catalog by using Purview [governance domains](/purview/unified-catalog-plan#create-governance-domains) that align to existing data domains. Collections, roles, and permissions should reflect these boundaries, so each data domain has authority in its area. The Unified Catalog begins empty, but as data sources are registered and scanned, it grows into an accurate map of the estate. Setting domains early brings clarity as the catalog expands.

2. **Define a business glossary.** With structure in place, create a shared business glossary that anchors the organization's most important terms. Terms, such as Customer, Product, Employee, and Location, and measures like Revenue or Headcount, often vary across departments unless harmonized. Document these definitions as [glossary terms](/purview/unified-catalog-glossary-terms) in the Unified Catalog and view them in Purview's enterprise glossary. Communicate them broadly to help eliminate ambiguity. This clarity supports consistent AI, analytics, and reporting practices across teams.

### 1.2. Map data sources

The Purview Data Map provides visibility into data assets without copying data or replacing source‑level security controls. **Recommendation:** Register and scan all relevant data systems to populate the [Data Map](/purview/data-map-scan-ingestion). To apply this recommendation, use the following checklist:

1. **Create Purview architecture.** Use Purview collections and [Data Map domains](/purview/data-map-domains) to align permissions and governance with the needs of your data domains. These constructs define boundaries for access control, policy management, and operational responsibility. Follow Purview [domain and collection architecture best practices](/purview/data-gov-best-practices-domains-collections#domains-and-collections-archetypes).

2. **Set up Purview for Microsoft 365 data.** Purview has native integration with Microsoft 365 data (such as SharePoint, OneDrive, Exchange, Teams). Make sure that you also govern content in Microsoft 365. When you bring Microsoft 365 documents and messages into OneLake or otherwise use them in analytics, any labels or classifications from Microsoft 365 carry over. In Purview, you can see sensitivity labels and retention labels that you applied in the Microsoft 365 environment. To learn more, see [Microsoft Purview setup guides](/purview/purview-fast-track-setup-guides).

3. **Scan Microsoft Fabric OneLake.** Fabric OneLake isn't automatically included in the Purview Data Map. You must explicitly register and scan it. Scanning OneLake enables metadata discovery, lineage tracking, and cataloging of Fabric assets in Purview. To learn more, see [Register and scan Microsoft Fabric](/purview/register-scan-fabric-tenant).

### 1.3. Scan cloud, SaaS, and on-premises data

Connector-based scanning is required for data stored in Azure services, Microsoft Dataverse, on-premises systems, and other clouds (AWS, Google Cloud, Oracle). You need to [register](/purview/data-map-data-sources-register-manage#register-a-new-source) and scan [supported data sources in Data Map](/purview/data-map-data-sources). **Recommendation:** Follow Purview's [scanning best practices](/purview/data-map-scanning-best-practices). Choose whether to scan source systems or only scan the Microsoft Fabric OneLake layer. This decision depends on visibility needs, compliance requirements, operational overhead, and the role each system plays in analytics and reporting. To apply this recommendation, review the following options:

**Option 1: Scan source systems.** Scanning operational systems such as Azure databases or AWS S3 provides end-to-end lineage from the system of record. This information is important for regulated or business-critical data where full provenance supports audits and compliance. It provides the clearest visibility into upstream changes but introduces complexity. Connector configuration, credentials, and scheduling require attention, and some sources require you to [Choose the right integration runtime](/purview/data-map-integration-runtime-choose).

**Option 2: Scan only the Fabric layer.** If deep visibility into upstream systems isn't required, scanning only the Fabric layer simplifies the governance model. Lineage begins when data enters Fabric. This approach reduces integration work. It's best for data where upstream systems are well governed or where compliance obligations don't require full lineage. To learn more, see [Fabric](/purview/register-scan-fabric-tenant) in Microsoft Purview.

### 1.4. Apply sensitivity labels

Sensitivity labels are a fundamental tool for classifying and protecting data. In Microsoft Purview, there are typically two kinds of sensitivity labels:

- **Metadata-only labels:** These labels are metadata tags in the Purview catalog. For example, labeling an Azure SQL table as "Confidential" in the catalog without affecting the source system directly. These labels help track and manage data sensitivity in Purview for assets outside of Microsoft 365/Fabric.

- **Protective labels:** These labels not only mark data with a classification, like "Confidential," but also enforce protection. They can enforce encryption or restricted access on files and emails. Use these labels heavily in Microsoft 365 and now extend into Fabric as well.

Both contribute to a consistent governance model, and clarity about their purpose helps align the right label type to the right scenario. **Recommendation:** Apply a unified sensitivity labeling strategy across Microsoft 365, Fabric, and the Purview Data Map. To apply this recommendation, use the following checklist:

1. **Define a sensitivity label taxonomy.** Define an organizational labeling schema. A common schema is Non-business, Public, General, Confidential, and Highly Confidential. Make sure everyone understands what each label means and what types of data fall under each category. Get buy-in on this taxonomy from compliance and business stakeholders. See [Get started with sensitivity labels](/purview/get-started-with-sensitivity-labels).

2. **Label Microsoft 365 data (protective label).** Make sure Microsoft 365 information is labeled by using Microsoft Purview Information Protection. These labels impose security controls (encryption, restricted access). They persist with the data when brought into OneLake or shared via other tools. **Best practices:** Many organizations set up auto-labeling policies to detect sensitive info, like credit card numbers or personal data, and automatically apply a label. See [automatically apply sensitivity labels to Microsoft 365 data](/purview/apply-sensitivity-label-automatically).

3. **Label Microsoft Fabric data (protective label).** Microsoft Fabric supports [protected sensitivity labels](/fabric/governance/protected-sensitivity-labels) on its own assets, like tables in a Lakehouse, and Power BI datasets. Configure [default label policies](/fabric/governance/sensitivity-label-default-label-policy) in Fabric so that new data in OneLake is labeled appropriately from creation. For instance, you could specify that any new dataset in certain workspaces is by default labeled as internal or confidential unless changed. This approach makes sure no data enters the lake without classification. Adjust these defaults for areas that handle sensitive data. See [Govern Fabric](./governance-security-baselines-fabric-data-lake-unify-data-platform.md#3-set-data-security-baseline).

4. **Label entries in Purview Data Map (metadata-only label).** For data sources that are scanned into Purview (like an AWS S3 bucket or an on-premises database), apply metadata labels in the Purview Data Map. While these labels don't encrypt or restrict the data at the source, they do inform users and systems that the data is, say, confidential. They can also trigger other governance workflows. Everything in your catalog should have a sensitivity designation. See [Use autolabeling policies](/purview/data-map-sensitivity-labels-apply) to detect data assets and apply these metadata-only sensitivity labels automatically.

### 1.5. Capture data lineage

Data lineage provides visibility into how data moves and changes across systems. **Recommendation:** Enable automated lineage where available and close gaps manually where required. **Best practices:** Use Microsoft Purview to [automate](/purview/data-gov-classic-lineage-user-guide#lineage-collection) lineage capture for many assets. Where automation isn't available, add lineage manually in Purview to fill gaps. See [Manual lineage setup](/purview/data-gov-classic-lineage-user-guide#manual-lineage). Configure data lineage in Purview for [Fabric](/purview/data-map-lineage-fabric) and, as needed, for [Azure Databricks](/purview/unified-catalog-data-quality-azure-databricks-unity-catalog).

## 2. Data estate compliance baseline

Compliance defines the legal, regulatory, and internal obligations that apply to data across platforms. Decision makers must understand these obligations before enforcing controls. This approach makes sure governance actions remain defensible and auditable across Microsoft Fabric and the broader data estate. **Recommendation:** Define compliance requirements centrally and monitor alignment continuously by using Microsoft Purview. Data governance decisions should remain consistent across Microsoft 365, Azure, other clouds, and on‑premises systems. To apply this recommendation, use the following checklist:

1. **Define your compliance requirements.** Compliance requirements vary by industry, region, and workload. The governance model must reflect them before you apply any protective or technical controls. Identify which regulatory frameworks or industry standards are relevant to your organization. **Best practices:** Use Microsoft Purview [regulatory templates](/purview/compliance-manager-regulations-list) and [assessments](/purview/compliance-manager-assessments). They represent standards such as [GDPR](/compliance/regulatory/gdpr), [HIPAA and HITECH](/compliance/regulatory/offering-hipaa-hitech), [PCI DSS v4.0](/compliance/regulatory/offering-pci-dss), [Sarbanes-Oxley Act](/compliance/regulatory/offering-sox), and [ISO 27001](/compliance/regulatory/offering-iso-27017). Review these templates to understand which rules apply across Microsoft 365, Azure, AWS, and Google Cloud. These templates provide a checklist of controls and practices you should have in place. Use the Compliance Manager's scores and recommendations to gauge your current posture, identify gaps, and prioritize what to address first.

2. **Monitor data compliance.** After you set up Purview's compliance templates, regularly review the **compliance score** and reports. Purview automatically assesses aspects of compliance for [Microsoft 365 data](/purview/compliance-manager-setup) and data across [Azure, AWS, and Google Cloud](/purview/compliance-manager-multicloud). It highlights issues and suggested actions to improve compliance. Set up alerts for any critical compliance policy violations. **Best practices:** If Purview finds sensitive data in an unapproved location or if a retention policy is violated, notify responsible teams immediately so they can take action. Steady monitoring and incremental improvements make sure you're not caught off guard by audits or incidents.

3. **Configure Microsoft 365 data retention.** Decide how long to keep different types of data and when to delete or archive it. Ambiguity in retention can either lead to keeping data too long (risking compliance breaches or unnecessary storage costs) or deleting too soon (losing valuable history). **Best practices:** Use Microsoft Purview's data lifecycle management for [Microsoft 365 data](/purview/get-started-with-data-lifecycle-management#common-scenarios) to set retention or deletion policies on emails, documents, and Teams messages.

4. **Configure Azure data retention.** Azure services require service‑specific retention and backup configuration. **Best practices:** Configure backup retention for services, such as Azure SQL, Cosmos DB, and MySQL. Use Azure Storage [lifecycle management rules](/azure/storage/blobs/lifecycle-management-policy-configure) to archive or delete data. Reference service guidance for [Azure SQL Database](/azure/azure-sql/database/long-term-backup-retention-configure), [Cosmos DB](/azure/cosmos-db/periodic-backup-modify-interval-retention), and [MySQL](/azure/mysql/flexible-server/concepts-backup-restore).

5. **Configure on-premises and other clouds data retention.** Data outside Microsoft platforms still requires compliant lifecycle controls. To avoid unmanaged compliance risk, apply intentional retention strategies to all non‑Azure and on‑premises data sources. **Best practices:** Use Azure Backup or third‑party solutions to retain on‑premises, AWS, and GCP data. Follow guidance to [Backup cloud and on-premises workloads to cloud](/azure/backup/guidance-best-practices). Where needed, manually [upload](/azure/storage/common/storage-use-azcopy-blobs-upload) data to Azure Storage and [archive](/azure/storage/blobs/archive-blob) the blob.

## 3. Data estate security baseline

A consistent security baseline makes sure that sensitive data remains protected across Microsoft 365, Microsoft Fabric, Azure services, and AI workloads. **Recommendation:** Define and enforce a single security posture across the entire data estate so that classification, protection, and enforcement operate uniformly at scale. To apply this recommendation, use the following checklist.

1. **Enable sensitive data classifiers.** [Sensitive data classifiers](/purview/data-classification-overview) in Microsoft Purview identify regulated and business‑critical data so that protection controls can act automatically and consistently across services. **Best practices:** Enable the relevant built‑in sensitive information types that align to regulatory and business risk. Create custom classifiers for domain‑specific data, such as trade secrets or proprietary research. Use these classifiers as the foundation for labeling, data loss prevention, and audit controls. **Decision guidance:** Decide to rely on default classifiers when regulatory alignment is the primary goal and the data types match standard definitions. Choose custom classifiers when business‑specific data carries risk that standard classifiers don't detect. Custom classifiers increase coverage but require governance oversight to remain accurate over time.

2. **Apply data loss prevention (DLP).** Configure DLP policies in Microsoft Purview to prevent leaks of sensitive data through everyday actions. Set up DLP for both Microsoft 365 (to cover emails, Office documents, and Teams chats) and Microsoft Fabric. A DLP policy can block a user from sharing a file externally if it contains confidential data like customer personal data or health information. In Fabric, DLP can prevent analysts from sharing a dataset or report that includes sensitive data. For detailed configuration, refer to the guidance for [Microsoft 365 apps](/purview/dlp-learn-about-dlp), [Copilot](/purview/dlp-microsoft365-copilot-location-learn-about), and [Microsoft Fabric](/purview/dlp-powerbi-get-started). **Decision guidance:**

    - **Monitor-only (audit mode):** Start with DLP in monitor-only mode when you're concerned about disrupting work. It lets you observe and fine-tune policy behavior, but data might still be exposed because enforcement isn't active.

    - **Blocking or restricting:** Move to blocking or restricting mode when data leakage would have severe effects and your detection rules are reliable. Some legitimate actions might be blocked initially and require exception handling and policy adjustments.

3. **Protect data in Azure services.** Microsoft Purview catalogs and labels data in Azure services but doesn't replace native security controls for those services. **Best practices:** Apply service‑level security controls, such as network isolation and Microsoft Defender coverage for [Azure SQL Database](/azure/azure-sql/database/threat-detection-configure), [Azure Cosmos DB](/azure/cosmos-db/defender-for-cosmos-db), and [Azure Storage](/azure/defender-for-cloud/defender-for-storage-introduction). Align these controls with Purview classifications so that monitoring and alerting reflect data sensitivity and business risk.

4. **Protect data used by AI apps.** AI applications introduce new data exposure paths that require explicit alignment with enterprise data governance and security policies. Microsoft Purview integrates with Microsoft Foundry and other AI platforms to provide this control. **Best practices:** Use Purview APIs and AI‑specific security features to pass sensitivity context into AI workflows so applications can apply masking or response restrictions when required. Establish review checkpoints for high‑impact AI scenarios to confirm that data access aligns with enterprise standards. To learn more, see [Microsoft Purview and AI](/purview/ai-microsoft-purview) and [Purview with Foundry](/purview/developer/secure-ai-with-purview).

## Next step

> [!div class="nextstepaction"]
> [Fabric governance and security baselines](./governance-security-baselines-fabric-data-lake-unify-data-platform.md)
