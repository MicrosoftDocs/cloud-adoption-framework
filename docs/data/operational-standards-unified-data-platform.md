---
title: Operational standards for a unified data platform
description: Establish operational standards for developing, publishing, managing, and consuming trusted data products across a unified data platform.
#customer intent: As a decision maker, I want to establish operational standards for data products so that data domains can develop and manage trusted data products that consumers can reuse securely across the organization.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 10/22/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# Operational standards for a unified data platform

*This article helps decision makers establish operational standards for developing and using data products across a unified data platform.*

Organizations must decide how data domains make data available through OneLake and transform it into trusted data products for reuse across the organization. Central governance should establish organization-wide standards. Data domains should own their data products and make implementation decisions within those boundaries.

Consistent standards reduce unnecessary duplication and help consumers find and use trusted data with appropriate protection. This article covers data intake, transformation, publication, consumption, lifecycle management, security, and exceptions.

## 1. Data intake

*What standards should govern data intake?* The organization must establish standards for which source data becomes available through OneLake and the preferred methods for making it available. Make source data available through OneLake only when it supports an approved data product or analytical need.
### 1.1 Data intake methods

*How should data domains make source data available through OneLake?* The organization should prefer patterns that minimize unnecessary data movement.

- [**Shortcuts**](/fabric/onelake/onelake-shortcuts) should be the preferred pattern when supported data can remain at its source.
- [**Mirroring**](/fabric/mirroring/overview) should be the preferred pattern for supported sources when Fabric needs synchronized access to an external database or catalog.
- **Data movement** should be used when Fabric requires a copy of the data and shortcuts or mirroring don't meet the requirement.

Data domains can choose another approved intake method when the preferred pattern doesn't meet the requirement. See [Unify data with OneLake shortcuts and mirroring](/fabric/onelake/unify-data).

### 1.2 Data sources

*How should we integrate different data sources?* Data domains should make trusted outputs available through OneLake rather than recreate equivalent processing in Fabric without a measurable organizational benefit.

- **Microsoft 365**: Microsoft 365 should normally remain the system of record for collaboration content. Data domains should bring Microsoft 365 content into the unified data platform only when an approved data product requires it, such as for structured analysis.

- **Operational databases**: Operational databases should remain optimized for transactional workloads. Data domains should not allow analytical or AI workloads to query an operational database directly unless the database owner has approved the expected workload and established the required controls.

- **Existing data platforms**: Existing data lakes and transformation platforms, like Azure Databricks, should remain in place when they continue to meet organizational requirements. Migration or recreation in Fabric should require a measurable organizational benefit.
See [Shortcuts](/fabric/onelake/onelake-shortcuts), [Mirroring Azure Databricks Unity Catalog](/fabric/mirroring/azure-databricks), and [Integrate OneLake with Azure Databricks](/fabric/onelake/onelake-azure-databricks).

## 2. Data transformation

*How should we transform data into data products?* The organization should establish a preferred transformation platform to reduce unnecessary duplication of capabilities. Microsoft Fabric can serve as the default when it meets the data product's requirements. Existing platforms, such as Azure Databricks, should remain in use when they provide required capabilities or represent an established organizational investment.

**Transformation pattern**: Medallion architecture should be the preferred pattern when data benefits from progressive refinement. Data domains should use only the quality stages required to produce a trusted data product.

See [Fabric materialized lake views](/fabric/data-engineering/materialized-lake-views/overview-materialized-lake-view), [Medallion Lakehouse Architecture in Fabric](/fabric/onelake/onelake-medallion-lakehouse-architecture), and [Analytics End-to-End with Microsoft Fabric](/azure/architecture/example-scenario/dataplate2e/data-platform-end-to-end).

## 3. Publication

*What should exist for a data product to be published?* A data product can consist of one or more technical assets that collectively provide a supported business offering. Every published data product must have an accountable owner, supported business purpose, intended use, access process, and quality status. When consumers depend on timely availability, it should also define an operational commitment.

- **Security controls**: Required security controls must be in place before publication. Sensitive data products must have the required classification and handling requirements. See Purview [sensitivity labels](/purview/data-map-sensitivity-labels).

- **Metadata**: The organization must define minimum metadata for published data products. Consumers should be able to determine the owning data domain, accountable owner, supported use, quality commitment, and access requirements. See [tags in Fabric](/fabric/governance/tags-overview) and Purview [custom metadata](/purview/unified-catalog-custom-metadata).

- **Data lineage**: Available lineage should provide enough information to understand material upstream dependencies and assess downstream impact. See [Lineage in Fabric](/fabric/governance/lineage).

## 4. Discovery

*How should consumers find data products?* Published data products should be broadly discoverable by default. Use OneLake Catalog for Fabric-native discovery. Represent a data product in Microsoft Purview Unified Catalog when it requires enterprise business context or governance across the broader data estate.

See [OneLake catalog overview](/fabric/governance/onelake-catalog-overview) and [Data products in Unified Catalog](/purview/unified-catalog-data-products).

## 5. Endorsement

*How should consumers determine whether a data product is trusted for reuse?* Fabric endorsement can help consumers assess the level of assurance provided by the items that support a data product. The organization must establish consistent meanings and requirements for each endorsement level.

- **Promotion** should indicate that the owning data domain recommends the data product for reuse.

- **Certification** should indicate that an authorized reviewer confirmed that the data product meets defined organizational standards.

Publication shouldn't require certification. Publication establishes the minimum organizational threshold for supported reuse. Certification provides additional assurance. See [Endorsement in Fabric](/fabric/governance/endorsement-overview).

## 6. Approved consumption

*When can consumers use a data product without additional approval?* Data products can support many consumption patterns, including analytics, applications, AI grounding, and agents. The same approved-use and security standards apply regardless of the consuming technology. The owning data domain must define the uses supported by each published data product. Consumers should be able to use the data product without additional approval when their proposed use falls within those boundaries.

The organization must define uses that always require additional review. These uses should include situations where consumption materially changes the risk of the data, such as external disclosure or consequential AI use.

Approval for one use must not imply approval for another. For example, a data product approved for internal reporting shouldn't automatically be approved for external publication. A data product approved for AI grounding shouldn't automatically be approved for an agent that can take consequential actions.


## 7. Data product lifecycle

*How should data domains manage data products that consumers depend on?* Published data products create dependencies that the owning data domain must manage. The organization must establish standards for changes and retirement so consumers can plan for disruptions and transition when necessary. Together, the publication requirements and lifecycle commitments establish the contract between the owning data domain and consumers of the data product.

### 7.1 Reliability

*What reliability standards should apply to published data products?* The organization should establish reliability requirements based on the business impact of a data product becoming unavailable or losing data. Data domains should apply these requirements to the complete data product rather than assume that the reliability of OneLake or another platform component provides the required level of protection.

- **Reliability classification**: The organization should define reliability requirements for each business criticality tier. Data domains must ensure that the complete data product meets the applicable requirements.

- **Recovery requirements**: The owning data domain must ensure that the complete data product meets the reliability requirements associated with its business criticality. The recovery design should account for the data product and dependencies required for its use. Business-critical data products should have a tested recovery process. 

- **Fabric capacity requirements**: Data domains should ensure that shared Fabric capacity doesn't prevent any assigned data product from meeting its reliability requirements. Use separate capacity when a data product requires capacity-level controls that shouldn't apply to other products.

Don't treat OneLake replication as complete data product recovery. Each business-critical data product should have a recovery design that covers its data and required Fabric items. See OneLake disaster recovery and data protection and Fabric experience-specific disaster recovery guidance. 

### 7.2 Changes

*How should data domains manage changes that affect consumers?* Owning data domains must manage breaking changes according to the business impact of the data product. They should identify affected consumers before making a breaking change and provide a transition period proportionate to the impact.

Change commitments should increase as dependency and business criticality increase. A broadly reused data product that supports a critical business process should have stronger change requirements than a data product with limited use.

Data domains should use available lineage and impact analysis to identify technical dependencies. They should also account for known business dependencies that technical lineage doesn't capture. See [Fabric impact analysis](/fabric/governance/impact-analysis).

### 7.3 Retirement

*How should a data domain retire a published data product?* The organization must establish minimum retirement requirements. Before retirement, the owning data domain must assess active dependencies and provide a transition period proportionate to business impact.

The owning data domain should identify an approved replacement when one exists. It should remove endorsement when consumers should stop creating new dependencies. Existing consumers must receive sufficient notice before access ends.

## 8. Data product security

*How should authorization requirements apply when data products are consumed?* A new consumption path must not weaken the protection required by the source data product. The organization must classify approved consumption patterns according to whether the data product's authorization requirements remain effective.

### 8.1. Source authorization preserved

*When does a consumption pattern preserve the source data product's authorization?* A consumption pattern can rely on the source data product's authorization when it preserves consumer identity and continues to enforce the required access restrictions.

For example, if a sales data product restricts each salesperson to assigned customers, the consumption pattern must preserve that restriction for each consumer. Organizations should validate each approved pattern before allowing it to consume restricted data.

See [Fabric data agents](/fabric/data-science/data-agent-sharing), [Power BI](/fabric/fundamentals/direct-lake-security-integration), and [OneLake MCP server](/fabric/onelake/onelake-hosted-mcp).

### 8.2. New authorization boundary

*What standards apply when a consumption pattern must establish a new authorization boundary?* A consumption pattern that does not preserve the source data product's authorization requirements must establish a new authorization boundary that provides equivalent protection. The organization should not approve the pattern for restricted data when it cannot provide that protection.

This situation commonly occurs when a service creates another representation of the data or accesses source data through a shared application identity.

- **Indexes**: A search index creates another representation of source data. Restricted data in the index must remain protected according to the authorization requirements of the source data product. The organization must validate how source permissions are represented and enforced in the index rather than assume that OneLake access controls automatically protect indexed content. See [OneLake Indexer](/azure/search/search-how-to-index-onelake-files), [Document-level access control](/azure/search/search-document-level-access-overview), and [Azure AI Search security best practices](/azure/search/search-security-best-practices).

- **Service or shared identities**: When a consuming service accesses a data product through a service identity instead of the consumer's identity, source authorization applies to that service identity. The consuming solution must enforce any consumer-level authorization required by the data product. See [Authentication for Model Context Protocol (MCP) tools](/azure/foundry/agents/how-to/mcp-authentication) and [Use service principal authentication with Fabric data agent](/fabric/data-science/data-agent-service-principal).

## 9. Exceptions to the standards

*Which exceptions can a data domain approve?* The organization must define which standards data domains can vary and which require central approval.

- **Data domains** should have authority to approve exceptions that affect only their budget or local operating model. They must not approve exceptions that weaken organization-wide requirements for security or regulatory compliance. Central approval should also be required for exceptions that weaken organization-wide interoperability requirements or the minimum data product publication standard.

- **Central governance** should own organization-wide standards and review them as Fabric capabilities and organizational practices evolve. Data domains should provide recurring exceptions as input to these reviews. Repeated exceptions can indicate that an organizational standard needs to change.
