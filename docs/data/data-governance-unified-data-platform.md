---
title: Data governance in a unified data platform
description: "Learn how to establish organization-wide data governance in a unified data platform"
#customer intent: As a decision maker, I want to establish consistent data governance requirements across my organization so that data is discoverable, compliant, classified, protected, and governed according to business and regulatory needs.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 10/23/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# Data governance in a unified data platform

*This article helps decision makers establish data governance across the organization.*

Organizations should establish common data governance requirements that every data domain applies to the data it owns. Consistent governance helps the organization use data with confidence and manage business or regulatory risk regardless of where the data resides. This article provides guidance for establishing those requirements and applying them consistently across your organization.

## Architecture and decision tree

# [Purview baseline](#tab/purview)

:::image type="content" source="images/purview-architecture-governance-data-estate.svg" alt-text="Diagram showing how Microsoft Purview provides a single governance and security foundation for all organizational data. At the bottom, there are all data sources, including on‑premises systems, Dataverse, Microsoft 365, Azure, Google Cloud, and Amazon S3. These data sources belong to organizational data domains. Each data domain scans its data sources into the Microsoft Purview Data Map. The Data Map feeds the Unified Catalog, which acts as one catalog for all data across the organization. Inside the Unified Catalog, you organize data by Purview governance domains that align to data domains. Each governance domain is responsible for sensitivity labels, data classification, lineage, compliance, data retention, data loss prevention, and data use in AI. Shared governance capabilities include the data glossary, data classifiers, and the sensitivity label taxonomy. At the top, governed data products flow into Microsoft Fabric. Tools like Microsoft Copilot Studio and Microsoft 365 Copilot consume them." lightbox="images/purview-architecture-governance-data-estate.svg" border="false":::

*Microsoft Purview's role in data governance and security baselines.*

# [Conceptual](#tab/conceptual)

:::image type="content" source="./images/executive-architecture-unified-data-platform-ai-analytics.svg" alt-text="High‑level diagram showing Microsoft Fabric at the center of a unified data platform. Data from enterprise sources, such as on‑premises systems, Microsoft services, and public cloud platforms, flows into Fabric, where you organize it as shared data products. These data products are then used across the organization to support analytics, AI systems, and reporting, including Power BI and data science workloads. Fabric connects with Azure for governance, security, and monitoring, while Azure workloads run alongside it as needed. The overall flow shows data coming into Fabric, being governed and standardized, and then powering AI, analytics, and business insights across the organization." lightbox="./images/executive-architecture-unified-data-platform-ai-analytics.svg" border="false":::

*Conceptual architecture of a unified data platform for AI and analytics.*

# [Decision tree](#tab/decision-tree)

:::image type="complex" source="images/decision-tree-unify-data-platform.svg" alt-text="Diagram showing a decision tree for unifying your data platform for leaders and decision makers." lightbox="images/decision-tree-unify-data-platform.svg" border="false":::
    The flow asks a series of yes-or-no questions. Each "Yes" leads to specific guidance. The first question asks whether the organization needs help with understanding data priorities or building skills to get more value from data. If yes, the guidance is to prepare people through roles, training, and readiness activities. The second question asks whether the organization needs a unified way to access data across clouds and workloads to support analytics and AI. If yes, the guidance is to use Microsoft Fabric as the unified data platform. The third question asks whether the organization needs help with turning operational data into business value or securely feeding data into AI systems, such as Microsoft Foundry. If yes, the guidance is to integrate Azure services with Fabric. Fourth question asks whether the organization needs help with controlling access to data or with securing data consistently. If yes, the guidance is to set governance and security baselines using Microsoft Purview and related controls. Fifth question asks whether the organization needs help with setting consistent organizational standards to process, secure, and consume data products for analytics and AI. If yes, the guidance is to set operational standards for data products, security, and lifecycle management. The flow ends by pointing to adopting AI and adopting AI agents once the unified data platform and standards are in place.
:::image-end:::

*Microsoft's decision tree to guide your unified data platform.*

---

## 1. Data inventory

*How should we understand the data we have?* The organization should establish Microsoft Purview as the common governance system for enterprise data metadata. The Microsoft Purview Data Map provides the technical inventory and Microsoft Purview Unified Catalog helps people discover data. These capabilities store metadata. They do not copy the underlying data or grant access to it.

The organization should establish a data inventory policy that defines which data must be discoverable through Microsoft Purview and the order in which additional data enters the inventory. Full technical coverage should not be the initial objective unless a legal or regulatory obligation requires it.

- **Priority coverage**: The first inventory boundary should include data that supports critical business processes or enterprise reporting. It should also include data used by AI solutions where provenance or permitted use affects risk.

- **Microsoft 365 data**: Microsoft 365 content should be included when documents or communications contain information that falls within the organizational governance scope. See [Microsoft Purview setup guides](/purview/purview-fast-track-setup-guides).

- **Microsoft Fabric**: Register and scan the Fabric tenant to bring supported Fabric metadata and lineage into Microsoft Purview. See [Register and scan Microsoft Fabric](/purview/register-scan-fabric-tenant).

- **Multicloud, SaaS, and on-premises data**: Connector-based scanning is required for data stored in Azure, Microsoft Dataverse, on-premises systems, and other clouds (AWS, Google Cloud, Oracle). The organization should register supported sources when central metadata visibility provides a clear governance benefit. That benefit might include regulatory evidence or cross-platform discovery. Unsupported or low-priority sources should remain recorded in the governance scope with an identified owner and a planned treatment. See [Data Map scanning best practices](/purview/data-map-scanning-best-practices).
See [Microsoft Purview's Unified Catalog](/purview/unified-catalog) and [Data Map](/purview/data-map-scan-ingestion).  

## 2. Shared business meaning

*How should we ensure our data definitions are consistent?* The organization should standardize business concepts when inconsistent meaning would affect decisions across data domains. It should not attempt to create one definition for every local concept.

- **Organization-wide concepts**: Concepts should have an organization-wide definition when multiple data domains depend on the same meaning for reporting or AI. Prioritize concepts where inconsistent definitions already affect business decisions. Each shared concept should have an approved definition and an accountable business owner. The definition should identify acceptable variation where business contexts legitimately differ.

- **Data domain-specific concepts**: Data domains should retain authority over concepts that don't require consistent meaning outside their data domain. These concepts should become organization-wide concepts only when cross-data-domain use creates a need for shared meaning.

- **Glossary governance**: Approved definitions should be published through Microsoft Purview Unified Catalog so that users can discover the meaning associated with governed data. Governance domains can organize glossary terms and connect them with relevant data products or data assets. See [Glossary terms in Unified Catalog](/purview/unified-catalog-glossary-terms).

## 3. Compliance

*How should we meet our data compliance obligations?* The organization should translate legal and contractual obligations into data requirements before selecting technical controls. Microsoft Purview Compliance Manager can help assess controls and organize improvement work. 

### 3.1 Compliance requirements

*How should we establish compliance requirements?* The organization should establish a process for translating applicable legal requirements and contractual obligations into data governance requirements. 

- **Responsibilities**: Legal or compliance authorities should determine which obligations apply. Data domains should identify the affected data. Security teams should determine how approved requirements translate into technical controls.

- **Documentation**: The organization should maintain these requirements in a central register. Each requirement should identify its accountable authority and affected data. It should also define the required evidence and review frequency.

- **Tooling**: Microsoft Purview Compliance Manager assessments should help identify control gaps and organize improvement work. A compliance score should serve as a management indicator. It should not be treated as proof that the organization meets a legal obligation.
See [Purview Assessments](/purview/compliance-manager-assessments). 

### 3.2 Monitoring data compliance

*How should we monitor data compliance?* The organization should establish monitoring and escalation requirements according to regulatory and business risk. Requirements with greater potential impact should receive stronger monitoring and remediation expectations. Monitoring should provide evidence that accountable teams can use to identify material compliance gaps and track their resolution.

- **Tooling**: Microsoft Purview Compliance Manager can provide assessments and improvement actions for supported requirements. Decision makers should use this information to monitor compliance posture and unresolved control gaps. They shouldn't treat the compliance score as the compliance outcome. See [Compliance Manager](/purview/compliance-manager-setup) and [Multicloud ](/purview/compliance-manager-multicloud).

- **Compliance evidence**: The organization should retain evidence needed to demonstrate that required controls operate as intended. Evidence requirements and retention periods should follow the obligation documented in the compliance register.

### 3.3. Data lineage

*How should we track data history*? The organization should require data lineage where understanding data origin or transformation supports an important organizational requirement. Lineage should not become an objective to document every data movement.

- **Lineage coverage**: Data domains should capture enough lineage for important data products to support required governance decisions.

- **Source-system lineage** should be required when the organization must demonstrate where important data originated or investigate issues back to an authoritative source. 

- **Consumption layer lineage**, such as Fabric, can form the centralized lineage boundary when upstream systems already provide sufficient evidence. See [Scan Fabric](/purview/register-scan-fabric-tenant).

- **Both source and consumption layers** should be included when transformation can materially change data meaning or permitted use.

- **Tooling**: Microsoft Purview Unified Catalog should provide a centralized view of lineage for governed data assets. Data asset details can show upstream and downstream lineage together with business context such as the asset description and owner. See [Search for data products in Unified Catalog](/purview/unified-catalog-data-products-search).

- **Lineage collection**: The organization should automate lineage collection through supported source integrations where possible. Data domains should identify material gaps when automated lineage does not provide the evidence required for governance decisions. See [Metadata and lineage from Fabric into Microsoft Purview](/purview/data-map-lineage-fabric) and [Manual lineage setup](/purview/data-gov-classic-lineage-user-guide#manual-lineage).

### 3.4 Data retention

*How long should we retain our data?* The organization should establish retention requirements from legal obligations and business needs before configuring individual platforms. Each major data classification or record type should have an approved retention period and disposition requirement. The policy should also identify circumstances that prevent normal deletion, such as a legal hold.

Data domains should apply these organizational requirements to the data they own. Platform teams should provide approved implementation patterns for the services they operate.

#### 3.4.1 Microsoft 365 data retention

Microsoft 365 retention policies and retention labels should implement organizational retention requirements for supported Microsoft 365 content. Organizations should use Microsoft Purview Data Lifecycle Management and Records Management capabilities that meet their retention and disposition requirements. [Microsoft 365 data retention](/purview/retention-settings).

#### 3.4.2 Azure data retention

Azure platform standards should define how organizational retention requirements translate into service-specific backup and lifecycle settings. The organization should distinguish retention for business or regulatory purposes from backup required for operational recovery. These objectives can require different controls. See [Azure Storage](/azure/storage/blobs/lifecycle-management-policy-configure), [SQL Database](/azure/azure-sql/database/long-term-backup-retention-configure), [Cosmos DB](/azure/cosmos-db/periodic-backup-modify-interval-retention), and [MySQL](/azure/mysql/flexible-server/concepts-backup-restore).

#### 3.4.3 On-premises and multicloud data retention

Organizational retention requirements should apply regardless of where the data resides. Data domains should identify platforms that cannot satisfy required retention or disposition policies. If a platform cannot satisfy a requirement, the organization should establish an approved compensating control or move governed records to a platform that can satisfy the requirement.

## 4. Data security

*How should we classify and protect data?* The organization should establish a consistent data security model that protects data according to its sensitivity and business risk. The model should define organization-wide requirements for identifying sensitive data and preventing inappropriate use or disclosure. Each platform should implement those requirements through its supported security controls.

### 4.1 Data classification

*How should we classify our data?* The organization should establish one information classification model across supported platforms. Each classification should define its business meaning and required protection outcome. Platforms should implement that model through supported mechanisms, including sensitivity labels where applicable.

- **Organizational taxonomy**: The taxonomy should use terms that already have an accepted organizational meaning. A model might use classifications such as Public, General, Confidential, and Highly Confidential. The organization should create sensitivity labels only when they represent a distinct protection or handling outcome. Too many labels make classification difficult to understand and apply consistently. See [Get started with sensitivity labels](/purview/get-started-with-sensitivity-labels).

- **Default classification**: The organization should establish a safe default for platforms where unlabeled data would create material risk. A default classification provides a starting point. It does not replace classification by the accountable data domain. See [Default sensitivity labels and policies]( /purview/default-sensitivity-labels-policies).

- **Exception authority**: The organization should define who can lower a classification and what evidence is required. Highly sensitive classifications should require approval from an accountable business owner or designated security authority.

- **Microsoft 365**: Microsoft Purview sensitivity labels can classify Microsoft 365 content and apply configured protection, including encryption and usage restrictions. See [Microsoft 365](/purview/apply-sensitivity-label-automatically).

- **Microsoft Fabric**: Fabric uses Microsoft Purview sensitivity labels for classification. A sensitivity label on a Fabric item doesn't by itself enforce equivalent access restrictions on the Fabric item. Fabric permissions continue to control access. When a classification requires restricted access, use Fabric access controls or supported protection policies to enforce it. See [Protected sensitivity labels](/fabric/governance/protected-sensitivity-labels) and [Fabric default label policies](/fabric/governance/sensitivity-label-default-label-policy).

- **Protection verification**: The organization should test whether its required protection survives important transitions between platforms. Testing should cover paths where data can leave a more controlled environment, such as export from Fabric into Microsoft 365.

### 4.2 Sensitive data

*How should we protect sensitive data?* The organization should define which information creates material business or compliance risk and establish consistent methods for detecting it. Data domains should identify sensitive information within their business context. Security and compliance teams should translate those definitions into reusable classifiers and protection controls.

- **Standard detection**: Sensitive information types or exact data match should be used when sensitive data has a reliable pattern or authoritative reference set. Examples include national identifiers or known customer records.

- **Contextual detection**: Trainable classifiers should be used when sensitivity depends on the meaning of the content rather than a predictable pattern. Examples include confidential strategy documents or proprietary research.

Microsoft Purview provides sensitive information types and trainable classifiers that can support these organizational definitions. See [Microsoft Purview classifiers overview](/purview/data-classification-overview).

### 4.3 Data loss prevention

*How should we set up data loss prevention (DLP)?* The organization should establish DLP policies for specific data-loss scenarios where preventing or detecting an action reduces a material business risk. Don't apply the strictest available control to every location. DLP should be one control within the broader data protection model because coverage varies by platform and activity.

- **Risk scenarios**: Each DLP policy should define the sensitive data and risky action that it addresses. It should also define the population or service in scope. For example, a policy can address external sharing of customer personal data from Microsoft 365.

- **Monitoring phase**: New policies should normally begin in audit or simulation mode. The accountable team should review matches against representative business activity and define approved exceptions before enabling restrictions. See [DLP simulation mode]( /purview/dlp-simulation-mode-learn).

- **Enforcement phase**:  Blocking should apply when the expected effect of data exposure exceeds the business effect of interrupting legitimate work. The organization should establish exception authority before enabling blocking.

- **Policy review**: Repeated overrides or false positives should trigger policy review. These patterns can indicate inaccurate detection or a legitimate business process that conflicts with the policy.

See DLP for [Microsoft Purview Data Loss Prevention](/purview/dlp-learn-about-dlp) and specific guidance for [Microsoft Fabric](/purview/dlp-powerbi-get-started) and [Microsoft Copilot](/purview/dlp-microsoft365-copilot-location-learn-about).

### 4.4 Azure data security 

*How should we secure data in Azure systems?* The organization should establish Azure data protection standards that translate data classification into minimum security requirements. Microsoft Purview classification can identify the sensitivity and business importance of data. Azure services should enforce the resulting requirements through their supported security controls.

- **Protection baseline**: Platform teams should provide approved Azure patterns that satisfy those requirements so individual workload teams don't design the organizational security model independently.

- **Service implementation**: Azure services should enforce the organizational baseline through their native capabilities. Data classification should inform which protections are required rather than dictate a specific technical implementation for every service.

- **Control verification**: Security teams should periodically verify that services containing sensitive data meet the organizational baseline and identify exceptions that require remediation or formal risk acceptance.
