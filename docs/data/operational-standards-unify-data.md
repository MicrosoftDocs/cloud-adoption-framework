# Operational standards

With a unified architecture and governance guardrails in place, focus on the **day-to-day practices** for handling data. Operational standards ensure that every data domain follows consistent processes to move data from source systems into OneLake, transform it into high-quality data products, and make those products available for use. By standardizing these processes, you achieve a single source of truth in OneLake and make analytics and AI outcomes repeatable and trustworthy. This section covers best practices for data ingestion, processing, publishing, securing, and consuming data products. 

## 4.8 Cost management standards

**Cost operational standards** define how leaders expect teams to manage cost once Microsoft Fabric is running. Recommendation: **Decision makers must set clear expectations for cost decisions and reviews that occur throughout normal operations.** Here’s a checklist:

1.  **Review monitoring and cost outcomes at the leadership level**. Leadership review ensures monitoring data drives decisions, not just reports. **Best practice:** Effective organizations review Fabric health, reliability, and cost metrics together in leadership forums. This keeps the data platform aligned with business priorities. **Decision guidance:** Decide how often to review outcomes. Choose quarterly for stable environments. Choose monthly when growth is rapid. More frequent reviews increase alignment but require focus. See [Understand your Fabric capacity Azure bill](/fabric/enterprise/azure-billing) and [Evaluate and optimize your Microsoft Fabric capacity](/fabric/enterprise/optimize-capacity)

2.  **Define how scaling decisions are made and approved**  
    Scaling a Fabric capacity affects both cost and performance. Teams must not scale based on short term pressure. **Best practice:** Leaders define a clear path for how scaling requests are evaluated and who approves them. Scaling decisions are tied to business demand and reliability targets. **Decision guidance:** Use central approval when scaling affects shared budgets. Allow delegated approval only after teams show cost discipline. Central approval lowers financial risk. Delegation improves speed when trust is earned. See [Pause and resume your capacity](/fabric/enterprise/pause-resume) and [Scale your Fabric capacity](/fabric/enterprise/scale-capacity).

3.  **Set standards for throttling and surge scenarios**. Throttling and surge protection define how the platform behaves under heavy load. **Best practice:** Mature teams monitor throttling patterns and act before impact. They predefine responses using capacity scaling or workload priority. Leaders treat throttling as an early warning, not a steady state. **Decision guidance:** Decide when throttling is acceptable. Accept it only for non critical workloads. Add capacity when reliability expectations are strict. More capacity improves experience but increases cost. See [Understand your Fabric capacity throttling](/fabric/enterprise/throttling) and [Surge protection](/fabric/enterprise/surge-protection).

By enforcing these cost standards, leaders ensure the platform stays aligned to value. The unified data platform remains reliable. It operates within expected cost boundaries. This is critical for long term success and trust in the organization’s data strategy.

## 3.1 Deployment standards

Deployment standards define how teams move and release data into OneLake. These standards let leaders trust security, data quality, and outcomes across the organization. **Best practice:** Treat all data artifacts as code. Require source control for pipelines, notebooks, SQL, and semantic models. This creates version history. It supports collaboration. It enables rollback.

Establish a CI/CD process to test and deploy changes. Automation reduces human error and prevents configuration drift. **Standard to enforce:** Teams do not deploy to production by clicking buttons. All production changes flow from a source controlled repository through a scripted or automated pipeline.

## 3.1. Raw data ingestion standards

Each data domain is responsible for ingesting the **raw data** needed to create its data products into OneLake (the central data lake). The guiding principle is to **only ingest data that has a clear purpose** for analytics or AI. Avoid dumping data “just in case”; focus on data that will drive decisions, insights, or automation. **Checklist of best practices for data ingestion:**

1.  **Be selective.** Identify the data that truly supports the creation of useful data products. A simple test is to ask: *“Does this dataset help explain or measure a business process or outcome we care about?”* If yes, plan to bring it into OneLake. If not, consider leaving it where it is (for example, in an operational system or a departmental SharePoint) until there is a clear use case.  This reduces unnecessary storage, improves cost control, and helps teams concentrate on data that produces measurable value.

2.  **Review operational data.** Some data exists only inside operational systems and is not present in any lake or pipeline. In these situations, bring the data directly into OneLake. For these sources, Microsoft Fabric provides two primary methods: [Shortcuts](/fabric/onelake/onelake-shortcuts) (virtual ingestion) and [mirroring](/fabric/mirroring/overview) (replication). Mirroring is often required for data in Azure databases. This creates a direct and reliable intake path for new sources and keeps OneLake at the center of future data products.

3.  **Review existing data lake.** Some organizations already keep curated data in an existing cloud data lake, whether that lake is ADLS in Azure, Google Cloud Storage, or Amazon S3. When these environments already host Delta tables or other structured outputs that feed established data products, the data can stay exactly where it is. OneLake [shortcuts](/fabric/onelake/onelake-shortcuts) make this data immediately visible inside Fabric without moving or copying anything. [Mirroring](/fabric/mirroring/overview) becomes the right choice when a synchronized copy inside OneLake improves performance or simplifies downstream operations. Both options allow Fabric, Purview, and AI workloads to treat the existing lake as part of a unified foundation while avoiding any disruption to current processes.

4.  **Ingest Azure Databricks outputs.** If some data domains produce their refined data using Azure Databricks (with its own Bronze/Silver/Gold processing in ADLS), you can keep those pipelines running as is. At a minimum, surface the final **Gold datasets** into OneLake. As mentioned in the architecture section, use an **ADLS** [shortcut](/fabric/onelake/onelake-azure-databricks) to expose Databricks’ curated outputs in Fabric, or [mirroring](/fabric/mirroring/azure-databricks) the critical ones into OneLake. This approach preserves your investments in Databricks while enabling centralized discovery and use of that data through Fabric and Purview. **Decision Guidance:** Use shortcuts for Databricks outputs if the performance of reading them remotely is fine and if you want to avoid duplication. Use mirroring if you need the data to be physically present in OneLake for performance or governance reasons.

5.  **Separate internal vs. external data.** Organize your data ingestion such that any data intended for external sharing or public use is kept separate from strictly internal data. For example, you might have a workspace or lake folder for “External Data Products” that contains only data cleared for clients or partners.  It reduces the risk that sensitive internal data accidentally gets exposed to external users because it was mixed together. It also simplifies applying different security policies to external-facing data versus internal data.

## 3.2. Data transformation standards

Getting data into OneLake is only the first step. The real value comes from transforming raw data into high-quality, ready-to-use data products. This typically involves cleaning, integrating, and aggregating data, which can be a complex technical process. As a decision-maker, you don’t need to write the code, but you do need to set standards and make key choices about *how* your organization will perform these data transformations. Two major considerations are choosing the right processing platform and enforcing a standard architecture for data refinement.

### 1. Use the right data processing platform

Platform selection should align with your data assessment and target data architecture. For each data product, balance simplicity and native integration with the need for specialized engineering capabilities. Regardless of platform choice, all processing should operate over the same governed data estate to avoid fragmentation and duplicated logic.

1.  **Fabric (default).** Microsoft Fabric provides built-in engines for data transformation: Dataflows Gen2 (for data integration pipelines), Spark (for big data processing with notebooks), and SQL-based processing (for data warehousing and analytics). In many cases, these will cover your needs and have the advantage of being tightly integrated with OneLake and the rest of Fabric. **When to choose:** Choose Fabric when standard data engineering, BI, or analysis tasks are required, and especially if teams are already familiar with tools like Power Query, SQL, or Spark and can adapt to Fabric’s version of them. 

2.  **Azure Databricks.** Many organizations also use Azure Databricks or other platforms for certain workloads, such as large-scale data processing or advanced machine learning. You may even have existing data pipelines in Databricks or other tools. **When to choose:** Choose Databricks when you have existing expertise there or needs that go beyond Fabric’s current capabilities. **Tradeoff:** Using multiple platforms means you must put more effort into integration and governance. Use OneLake and Purview to bridge the gap). It could also mean higher overhead in terms of skillsets required and duplicated data. **Best practices:** *Don’t create new silos.* If you use Azure Databricks (or another platform), ensure it operates on the *same unified data lake*. For instance, you might continue to use Databricks for specialized tasks but still store the output in OneLake (or use shortcuts to link the storage) so that governance, discovery, and downstream usage remain unified. The key is to avoid parallel, disconnected data pipelines that produce conflicting results.

**Standards to enforce:** Ensure you’re not paying twice for the same outcome. Factor in the cost model and licensing of each option. Fabric capacity is a straightforward way to get a bundle of capabilities. Databricks is a PaaS platform in Azure with its own cos. For example, running a transformation in Databricks and then again in Fabric would be wasteful. Aim for clear delineation: which tool does what, and avoid overlaps. 

In summary, make platform decisions with a bias toward simplicity and integration, but remain open to using the right tool for the job if needed. Crucially, all platforms should feed into the unified data lake and governance framework. 

### 2. Apply medallion architecture

Adopt the medallion architecture as the standard for creating data products. Successful organizations use this model for governance. The medallion architecture uses three layers of data transformation: bronze (raw), silver (trusted), gold (data product). Data moves forward only. This prevents disagreement about which data is correct. Here’s the structure to follow:

1.  **Bronze (raw ingestion)**: The Bronze layer is the system of record. It captures data exactly as it enters OneLake. Data is immutable and append only. Nothing is corrected or enriched at this stage. **Standard to enforce:** Every piece of data that comes into OneLake should land in a Bronze area first, even if it’s quickly transformed afterward. Teams should not directly modify or use raw data without going through this layering, to avoid confusion about what’s original data.

2.  **Silver (validated)**: The Silver layer represents trust. Data here is cleaned, validated, and standardized. Errors are removed. Formats are aligned. Basic business rules are applied. **Standard to enforce: **Data in the Silver layer should be considered the official cleansed data for the organization. Once data is in Silver, teams should not need to go back to raw sources for cleansed data. This means governance of the Silver layer is critical. It should be well documented, and changes should be managed.** **

3.  **Gold (business context, data products)**: The Gold layer delivers value. It contains certified business data products that leaders rely on to run the business. Data is aligned to business definitions. Metrics and KPIs are clear and approved. Conflicting numbers are eliminated. **Best practices:** Design Gold data with the end-user in mind. These datasets should be optimized for easy consumption. They might have business-friendly column names, predefined calculations (like year-to-date totals, common KPIs), and performance optimizations (indexes, pre-aggregations). Ensure that every Gold dataset is registered in **Microsoft Purview as a data product**, with clear metadata (description, owner, update schedule, so any user or system can discover and trust it). **Standard to enforce:** No “rogue” data products. Every dataset that is used for important decisions or by multiple teams must be in the Gold layer (or certified as such), meaning it’s governed.

4.  **Sanitize data for external use:** If you do need to share some internal data with external parties (or make it public), do not share the raw internal dataset directly. Instead, create a sanitized, curated version of the data specifically for that purpose. This might involve removing or masking any sensitive or personal information, aggregating detailed data into summary statistics, and thoroughly reviewing it for compliance. Treat this sanitized dataset as its own data product. Give it an owner, document its contents and purpose, apply appropriate labels (“Public” or “External Use”), and ensure it’s stored in a location designated for external data. This way, when external consumers access it, they get only what they are supposed to, and the truly sensitive internal data remains protected. 

In Fabric, [Materialized lake views](/fabric/data-engineering/materialized-lake-views/overview-materialized-lake-view) can automatically manage the transformations. See [Medallion Lakehouse Architecture in Fabric](/fabric/onelake/onelake-medallion-lakehouse-architecture). For an analytics architecture, see [Analytics End-to-End with Microsoft Fabric](/azure/architecture/example-scenario/dataplate2e/data-platform-end-to-end).

*Table. Example medallion architecture. Gold layer combines data from two datasets.*

| ***Dataset*** | ***Layer*** | ***Example Data*** | ***What happened*** |
|----|----|----|----|
| *Sales transactions* | *Bronze* | *OrderID=984321 · StoreID=17 · Amount="1,200" · TxnDate="2026-01-05T14:32:09Z"* | *This record arrived from the sales system exactly as sent. Amount is text. Timestamp follows system format. No meaning is applied.* |
|  | *Silver* | *OrderID=984321 · StoreID=17 · Amount=1200.00 · TxnDate=2026-01-05* | *The transaction is standardized and validated. Amount is numeric. Date follows enterprise rules. Data is now trustworthy.* |
| *Store reference* | *Bronze* | *StoreID="17" · RegionName="EAST "* | *This record arrived from a location system. Formatting reflects the source.* |
|  | *Silver* | *StoreID=17 · Region=East* | *Store identifiers align with sales data. Region values are cleaned and consistent.* |
| *Daily revenue by region* | *Gold* | *Region=East · Date=2026-01-05 · TotalRevenue=425000* | *This value combines Silver sales transactions with Silver store reference data. Individual records are summarized to answer a business question.* |

### 3. Build Adaptive gold layer

Adaptive Gold is included here as a forward‑looking consideration. The idea is that you use AI agents to create gold layers. Agents can observe patterns that we might not be able to. If users frequently ask for “top customer issues by region per month,” AI agents can materialize that dataset. This capability is not provided out of the box in Microsoft Fabric today. It would require building a custom AI agent that operates on Fabric and Power BI telemetry.

## 3.3. Data product publishing standards

After transforming data into valuable products, the next operational step is to publish these data products in a way that makes them easy to discover, understand, and use across the organization (or even externally, if intended). Publishing is more than just putting data into OneLake. It involves adding the necessary context and access so that the data product can actually deliver value. **Best practices checklist:**

1.  **Use the OneLake Catalog:** All approved data products, regardless of where they were processed (Fabric, Databricks), should be made available through OneLake Catalog. OneLake is your standardized storage and access layer for data products. By ensuring everything is in OneLake, you simplify integration with tools like Power BI, Fabric data agents, Azure AI Search, and other consumption methods. It also means Purview can see and govern all the data products in one place.

- **OneLake** is the execution and consumption surface for data products

- **Microsoft Purview** is the governance and business definition system of record

1.  **Ensure discoverability.** The data product must be published in the **OneLake data catalog** with appropriate visibility. The Fabric workspace where the data product lives should be visible (at least in a discoverable sense) to the relevant audiences. Use Purview’s catalog and **Fabric’s item endorsement** features to boost visibility. For example, mark key datasets as “Promoted” or “Certified” in Fabric so users know which ones are official.  Set permissions such that users who might need the data can request access if they don’t have it. Purview can enable a workflow where a user finds a dataset and can ask the owner for permission. 

2.  **Enrich with metadata**. As you publish, enrich each data product so that consumers can find, understand, and trust it. Adding descriptive [tags in Fabric](/fabric/governance/tags-overview) helps keep the catalog organized, making it easier for users to locate resources by business domain or project.

3.  **Endorse and certify when appropriate**: Endorsement in Fabric allows data owners to mark a data product as *Promoted* (“this is useful and somewhat validated”) or *Certified* (“this has been through a formal governance review and is a trusted source”). **Best practice:** Create a process for certification of critical data products. For example, require that a Gold dataset feeding executive reports is reviewed by a governance board or data steward, then mark it as Certified. This gives users confidence. Promoted can be a lighter-weight, interim step to indicate a dataset is recommended by its domain owners even if not formally certified. See [Endorsement](/fabric/governance/endorsement-overview).

4.  **Publish as a data product in Purview.** Microsoft Purview has a concept of *data products* in its catalog. It groups together a set of data assets and metadata into a higher-level product view. When you publish a data product, consider creating a data product entry in Purview. This would include the product’s name, description, the list of underlying data assets (tables, reports, models that constitute the product), owners, and quality status. It provides a one-stop summary in the catalog. This is useful for consumers to get the full picture of a data product and for you to manage the lifecycle at a product level. See [Data Products in Unified Catalog.](/purview/unified-catalog-data-products)

5.  **Declare intended audience and usage.** Make it clear who the data product is intended for and how it should (and shouldn’t) be used.** Best practice:** Specify whether the product is for internal teams, partners, or public consumption, and whether it supports analytics, BI, agentic, or public web workloads. Products intended for external agentic experiences must include an approved external purpose. Use Purview [**metadata**](/purview/unified-catalog-custom-metadata), [**glossary terms**](/purview/unified-catalog-glossary-terms), and [**sensitivity labels**](/purview/data-map-sensitivity-labels) work together to express this intent consistently.

#### Next step

By thoroughly publishing your data products with context and access, you turn raw data into readily usable knowledge. This maximizes the return on the effort invested in data preparation. Now the stage is set for these products to be used in analytics and AI. But you need to make sure access is controlled and responsible. This topic brings us to securing and managing consumption of data products. 

## 3.4. Data products security standards

Once data products are in place, it’s critical to enforce a **consistent security model** whenever and wherever those products are accessed. In a unified data platform, data may be consumed through various tools: Power BI reports, custom applications, AI agents like Microsoft 365 Copilot, Microsoft Fabric data agents, Azure OpenAI services, etc. Each of these must respect the permissions and sensitivity labels you’ve applied. As a decision maker, you should ensure that your security and compliance requirements carry through to every consumption layer.  Best practices for security data consumption: 

**Standards to set:** As a decision maker, set policies for your AI development teams on which data access methods are preferred. For example, you might say: “Any agent that needs structured data from our internal systems must use a Fabric Data Agent unless a specific exception is approved,” or “If using Azure AI Search, the index must have sensitivity label enforcement enabled.” These policies will ensure that even as new AI solutions are developed, they remain within your governance guardrails. 

### Microsoft’s AI data boundary

The Microsoft AI data boundary means prompts and responses stay inside Microsoft managed enterprise services and Microsoft does not use that data to train foundation models. Treat the Microsoft boundary as a required security baseline for business data. **Best practice:** Successful organizations publish a policy that limits business data use to enterprise AI services that honor tenant controls and do not reuse prompts for training. They also set an approval gate for any tool that can capture prompts or outputs. They train leaders to treat prompts as business records.

### Microsoft 365 Copilot data access security

**Microsoft 365 Copilot** **consuming data in Microsoft 365 apps:** Microsoft 365 Copilot can access only the data already available to a user within Microsoft 365, including files, emails, chats, calendars, and other information exposed through Microsoft Graph and the [Semantic Index](/microsoftsearch/semantic-index-for-copilot#privacy-compliance-and-security). It uses the user’s existing identity and respects all current access permissions. Copilot operates entirely within Microsoft’s enterprise boundary, and prompt data is not used for model training. See [How does Microsoft 365 Copilot protect organizational data?](/copilot/microsoft-365/microsoft-365-copilot-privacy#how-does-microsoft-365-copilot-protect-organizational-data)

**Microsoft 365 Copilot** **and Fabric data agents:** When Microsoft 365 Copilot connects to a Fabric data agent, it continues to operate under the user’s identity. Fabric remains responsible for enforcing workspace permissions, item permissions, and row‑ or column‑level security. This ensures users never see more data through Copilot than they are already entitled to view in Fabric. See [Microsoft 365 Copilot and Fabric data agent](/fabric/data-science/data-agent-microsoft-365-copilot).

### Fabric data agent data access security

Fabric data agents let people and systems query OneLake data using natural language. An agent is an entry point to a data product. It honors the caller’s Microsoft Entra identity and enforces the same workspace roles and item permissions used in Fabric. Fabric data agents preserve row‑, column‑, and object‑level security. OneLake access controls also still apply. Publishing an agent does not expose data by itself. See [Fabric data agent sharing and permission management.](/fabric/data-science/data-agent-sharing)

### Azure AI Search data access security

Azure AI Search indexes data so applications and AI systems can retrieve it. It can read data from [Fabric OneLake](/azure/search/agentic-knowledge-source-how-to-onelake?pivots=python) and other locations only when it has been [granted explicit permission](/azure/search/search-how-to-index-onelake-files#grant-permissions). These indexes sit between source data and downstream experiences and only enforce the access controls present in the index itself. They do not automatically inherit Fabric workspace permissions.

This creates an important governance consideration: if sensitive data is indexed without access metadata or classification enforcement, any application that can query that index may retrieve confidential content.

**Best practice:** Successful organizations index only approved content for the target audience. They require either ACL metadata or Purview sensitivity label enforcement for sensitive content. They also require testing with real identities before any application goes live. They maintain an inventory of indexes with owners and retention rules. This guidance applies to all platforms that use Azure AI Search, including Microsoft Foundry, Microsoft Copilot Studio, and any other system that queries Azure AI Search indexes.

**Decision guidance:** These options help ensure that only users or applications with the appropriate rights can retrieve specific documents.

- **Purview sensitivity labels:** [Microsoft Purview sensitivity‑label enforcement](/azure/search/search-query-sensitivity-labels) prevents a caller from retrieving labeled documents unless their identity is allowed to view them. Choose Purview label enforcement when you need policy checks for confidential data. **Tradeoff**: You accept dependency on correct labeling and label governance.

- **ACL-based filtering**: [ACL‑based filtering](/azure/search/search-query-access-control-rbac-enforcement) restricts results by evaluating the caller’s identity against the document’s stored permissions. Choose ACL filtering when access varies by document and you can maintain accurate permission metadata. **Tradeoff**: You accept higher metadata management cost.

- **Both**: Choose both when you need defense in depth. **Tradeoff**: You accept more complexity in troubleshooting and validation.

### Microsoft Foundry data access security

Microsoft Foundry lets you build AI agents that can use data from Fabric, OneLake, and other enterprise systems. Microsoft Foundry agents operate within Microsoft‑controlled infrastructure. Microsoft does not share prompt data with external model providers.

Agents can pull information from four main sources: Foundry IQ, Azure AI Search indexes, MCP servers, and Fabric data agents. Each one handles data security differently, so it’s important to choose the right method for your scenario:

- **Foundry IQ**: Uses Azure AI Search knowledge bases and enforces access through index‑level metadata (ACLs or sensitivity labels). Only authorized content is returned. Governance quality depends on the underlying search index. See [Connect Agents to Foundry IQ Knowledge Bases](/azure/ai-foundry/agents/how-to/tools/knowledge-retrieval?view=foundry&tabs=search%2Cpython#authentication-and-permissions).

<!-- -->

- **Azure AI Search index.** Foundry agents can query Azure AI Search indexes.  
  When you use this approach, you must follow the Azure AI Search data security best practices. Azure AI Search enforces access rules during queries only when the index contains ACL metadata or sensitivity labels. Without this information, any caller with access to the index can retrieve all its content. See [Connect an Azure AI Search index to Foundry agents](/azure/ai-foundry/agents/how-to/tools/ai-search?view=foundry&tabs=keys%2Cazurecli&pivots=python)

- **MCP servers**: MCP servers provide tools or data through the Model Context Protocol. Foundry supports multiple authentication models. **Best practice:** Use identity passthrough when user‑level access decisions matter. Avoid placing sensitive data behind services that cannot enforce per‑user authorization. See [MCP server authentication](/azure/ai-foundry/agents/how-to/mcp-authentication?view=foundry).

- **Fabric data agents**: Fabric enforces all security controls, including row‑ and column‑level policies. Foundry does not bypass these controls. **Best practices:** Use Fabric agents when consistent, governed access to data products is required across AI experiences. Let Fabric handle row‑ and column‑level security. Use separate agents if different audiences require different data views. See guidance in [Microsoft Foundry](/azure/ai-foundry/agents/how-to/tools/fabric?view=foundry&preserve-view=true&pivots=python) and [Microsoft Fabric](/fabric/data-science/data-agent-foundry#how-it-works) docs.

### Microsoft Copilot Studio data access security

Microsoft Copilot Studio enables custom copilots that operate entirely within the tenant boundary. Prompts and responses remain within Microsoft systems and are not reused for training. When copilots consume data from:

- **Azure AI Search:** When a Copilot Studio uses [Azure AI Search](/microsoft-copilot-studio/knowledge-azure-ai-search), enforcement depends on the presence of ACLs or sensitivity labels in the index.

- **Fabric data agents:** When a copilot calls a [Fabric data agents](/fabric/data-science/data-agent-microsoft-copilot-studio), Fabric applies all existing permissions and security policies This includes workspace, item, row‑level, and column‑level security. See [Consuming a data agent in Microsoft Copilot Studio.](/fabric/data-science/data-agent-microsoft-copilot-studio)

Purview [Sensitivity labels](/microsoft-copilot-studio/sensitivity-label-copilot-studio#microsoft-purview-strengthens-information-protection-for-copilot-studio) flow through responses to help govern outputs. To block knowledge sources, administrators can apply [data policies](/microsoft-copilot-studio/admin-data-loss-prevention) to limit which knowledge sources are available.

### Microsoft PowerBI data access security

Power BI transforms OneLake data into reports and dashboards while preserving Microsoft Purview sensitivity labels. These protections extend to exported content when supported by upstream systems. **Decision guidance:** For leaders, Power BI represents the final mile of data exposure. Ensuring labels are applied upstream guarantees that protections remain intact even when content is shared or exported. See [Power BI implementation planning.](/power-bi/guidance/powerbi-implementation-planning-content-distribution-sharing)

### Copilot in Fabric data access security

Copilot in Fabric operates entirely within Fabric and acts only on behalf of the signed‑in user. It does not introduce a new access path and cannot exceed existing permissions. Outputs remain private until explicitly shared. See [Privacy, Security, and Responsible AI Use of Copilot in Fabric.](/fabric/fundamentals/copilot-privacy-security) See [diagram of Copilot in Fabric](/fabric/fundamentals/how-copilot-works#process-overview-diagram).

### Next step

By paying attention to each of these areas, you ensure that once data products are published, **every consumption channel is governed**. The core principle is that security and compliance should be **pervasive**: from the raw data in OneLake, to the BI reports, to the AI agents answering questions, the same policies and permissions apply. Users and systems should only access what they are allowed to, and sensitive data should remain protected at every step.

## 3.5. Data product usage standards

Finally, with data products available and secured, guide how the organization consumes and uses these data products responsibly. This step is about establishing policies and practices that ensure data is used intentionally and ethically, especially as more teams and AI agents start leveraging the data. **Best practices checklist:**

1.  **Set usage approval processes**: If someone wants to use enterprise data in a new product or service (especially a customer-facing one), ensure there’s a vetting step. For example, using an internal dataset in a marketing app for clients might require data owner approval and possibly anonymization. This prevents mistakes like exposing customer data inappropriately. It also fosters a partnership between data producers and consumers, where both confirm the data is suitable for the intended purpose.

2.  **Enforce least-privilege access**: Reinforce that teams consuming data should only get the minimum access required. If a particular AI agent only needs summary data, don’t give it full detail-level access. Data domain leads, when granting permissions, should think carefully about the scope and context. This prevents oversharing and limits potential misuse.

3.  **Test data access.** Before any new report, application, or AI agent goes live using a data product, require a testing phase. In this phase, the team should simulate how the data is used and confirm security is working correctly (for example, use a test user account with limited permissions to see if they can only retrieve what they should). Use Purview’s DLP simulation mode or similar tools to identify if any sensitive data would leak under the planned usage. Catching misconfigurations early is much easier than cleaning up an incident later.

4.  **Review for responsible AI.** If the data product will feed into an AI system, incorporate a Responsible AI review. This means checking the data for biases (does it over-represent or under-represent certain groups?), ensuring it has appropriate labels (so the AI knows what’s sensitive), and documenting limitations. For example, if you have an AI agent answering questions about HR data, verify that the data it’s using is up-to-date and doesn’t include anything that should not be shared even internally. If you train a model on the data, document what time period or population the data covers so the AI’s results are interpreted correctly. **Standards to enforce:** Decision makers should ensure an AI ethics or responsible AI team is involved when deploying AI that uses enterprise data. 

## 4.6 Change management

Just as your operational systems have change management, treat your data products similarly. Every Gold dataset should have an owner who is accountable for maintaining it. Consumers of the data (like an application team) should subscribe to notifications or check-in regularly for any updates to the data schema or refresh schedule. Encourage a culture where producers and consumers of data talk to each other. For instance, if the Finance domain plans to change how it calculates “Net Profit” in its Gold dataset, it should inform downstream report owners or AI teams that use that data. Conversely, if an AI team finds an issue with the data, they should know who to contact to get it resolved. This two-way street ensures that data remains reliable and that any issues are quickly addressed. 

## 3.6 Monitoring standards

Even after setting up the platform with strong governance, ongoing **operational monitoring** is needed to keep the data platform healthy and cost-efficient. Decision makers should establish clear metrics and review processes to track performance, reliability, data quality, and spending.

**Best practice:** Deploy monitoring tools or dashboards to watch key health indicators of your Fabric environment. Microsoft Fabric

1.  **Monitor health metrics.** Health metrics show whether Fabric capacities operate within acceptable performance and reliability limits. **Best practice:** Define a standard, capacity‑level set of health measures and review them on a fixed cadence using the [Fabric Capacity Metrics app](/fabric/enterprise/metrics-app). Leaders track throttling behavior, overall consumption, background activity, and interactive usage trends to detect risk early. **Decision guidance:** Decide whether metrics are reviewed centrally by a platform leadership group or delegated to business units. Choose central review when consistency and risk reduction matter most. Choose delegated review only when teams have mature accountability. Central review reduces surprises but requires clear ownership.

2.  **Monitor reliability and performance trends centrally.** Reliability and performance monitoring shows whether Fabric activities complete successfully and on time across experiences. **Best practice:** Successful customers require central visibility into failed, delayed, or long‑running Fabric activities using the [**Fabric Monitoring hub**](/fabric/admin/monitoring-hub) rather than reviewing individual workload logs.
