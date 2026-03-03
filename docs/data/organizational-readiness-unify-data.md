# Organizational readiness

**Organizational readiness** focuses on aligning data initiatives with business priorities. Rather than starting with technology, start by defining *who* owns the data and *why* it matters to the business. This ensures that later architecture and operations choices are driven by business value instead of ad-hoc technical decisions. Decision makers should follow this guidance:

## 1. Identify data domains

The first step is to define how your organization will assign responsibility for data. **Best practice:** This is done by establishing **data domains**. A data domain is a boundary of responsibility. Common data domains are business units (HR, Sales, Marketing, Finance, Operations), or products lines (Product 1, Product 2).

:::image type="content" source="media/unify your data/image3.png" alt-text="":::

1.  **Align data domains to the organizational structure.** The guiding principle is to align data ownership with how the business already makes decisions and allocates authority. Data domains should reflect how the organization runs, where business decisions are already made, and where authority naturally resides. Each data domain will be responsible for producing high-quality data products that can be published to the OneLake data catalog and reused across the organization. It’s important to set up domains in a way that matches your business, not just your IT systems or historical databases. The best boundary is the one where a team already has the authority to decide what data matters, how it should be understood, and when it is sufficient for business use.

2.  **Appoint data domain leadership.** his person is a senior representative who understands the **business context** of that domain’s data. The domain lead’s role is to make decisions about data meaning, quality requirements, priorities, and trade-offs for their domain’s data products. It is critical to establish this **leadership accountability early**. If a domain lacks someone who can confidently take on this responsibility, it’s a sign that you may need to reconsider how you’ve drawn that domain’s boundaries.

In a Microsoft Fabric–based environment, the data domain lead represents the business intent behind what will ultimately be published and shared in the OneLake catalog. If no one can confidently fulfill this function for a data domain, that is a signal that the data domain boundary needs to be revisited before moving forward.

3.  **Define data domain responsibilities.** After establishing who owns each data domain, explicitly document what each domain will be responsible for. Each domain is accountable for its data products across their entire lifecycle. This includes planning which data products to create, delivering those products, operating and maintaining them, managing costs, and ensuring compliance with policies. **Best practice:** To succeed, empower each data domain to make key decisions and control its own resources within agreed guardrails, like managing Fabric capacities. **Benefits:** This clarity ensures domains can deliver data products without constant escalation. If a data domain cannot make these decisions independently, that indicates a mismatch between the domain boundary and the ownership model.

4.  **Adjust data domains over time.** Domains should not change often, but they should change when decision-making starts to break down. If data questions regularly require cross‑domain negotiation or technical arbitration, the domain boundaries no longer reflect reality. Adjusting them early reduces governance friction later.

## 2. Define data products

With domains and their leadership established, shift focus from organizational structure to business outcomes. Now, determine *what data products each domain should create*. Data products are the key outputs that provide value to the business. The purpose of defining data products at this stage is to ensure every data activity is tied to a tangible business goal. In a successful data strategy, we do **not** create data products just because we have data. We create data products because they will drive business outcomes or enable AI and analytics.

*Table: Example data planning template*

| **Business Goal** | **Data Domain: Data Domain Goals** | **Data domain goal priority** | **Data products required (consumer)** | **Required Data Assets for Data Product** |
|---|---|---|---|---|
| Increase Sales | **Sales**: Close deals faster and improve win rates. | High | **Current sales pipeline** (analytics)**Customer purchase behavior** (ML)**Sales playbooks** (AI agents) | CRM opportunity records (Azure SQL / Dataverse) |
| Improve customer satisfaction | **Product 1:** Improve product performance | High | **Historical product metrics** (analytics)**Product demand** (ML)**Product documentation** (AI agent) | Application telemetry (Azure Monitor, Application Insights) |
| Reduce Costs | **Finance**: Improve budget accuracy and reduce reporting time | Medium | **Financial actuals** (analytics)**Cost drivers** (ML)**Finance policies** (AI agents) | General ledger transactions (Azure SQL / Fabric Warehouse |

Follow these steps for defining and prioritizing data products:

1.  **Define business goals first**. Begin by stating your current top business priorities. Leadership should define what the organization aims to achieve in the near to medium term. For example, your goals may include **increasing revenue or** meeting specific regulatory requirements. These goals serve as a lens for evaluating any data initiative. With clear goals, you avoid investing time on “interesting” data projects that don’t impact what matters.

2.  **Create a list of data products that support the business.** Once business goals are clear, each data domain works with leadership to determine how it can contribute to those outcomes within its area of responsibility. The conversation shifts from *what data exists* to *what information is required* for the business to succeed.

For each domain, the guiding question becomes: “What data products would this domain need to deliver in order to measurably support these business goals?” A proposed data product should only move forward if it can be explicitly tied to a business objective. If the organization would not be materially slowed in achieving that objective without the data product, then it should not be prioritized. This discipline ensures that domains focus their effort on high-impact data products rather than attempting to publish everything at once.

3.  **Assess requirements for each data product.** For every proposed data product, determine what it would take to make it real and trustworthy. This includes identifying:

    - **Data Sources:** What source systems and datasets are needed? Where do these data currently reside, and how are they generated?

    - **Ownership:** Who will own this data product once it’s created? Identify data owners and stewards, and clarify who is accountable for the quality and maintenance of the data product over time.

    - **Capabilities needed:** Determine what capabilities are required (data engineering, integration, data modeling, analytics, machine learning) to produce and maintain the data product.

    - **Tools and platforms:** Identify the technologies and services required. For example, will you use Microsoft Fabric? Do you need Azure Databricks for certain transformations or machine learning? What about reporting tools like Power BI or other analytics platforms?

This assessment might reveal gaps in your current state, like missing data sources, data quality issues, or lacking tooling and skills. That’s okay and expected. The point is to map out what needs to be done to create each high-value data product so you can plan effectively.

**AI tip:** Use Copilot or Researcher to draft a preliminary list of data requirements for a given data product. Provide a description of the data product, its purpose, and intended users. Let the AI suggest possible sources, owners, or tools. Have your team review and refine this AI-generated outline to save time.

4.  **Prioritize data products.** Now that you have a clear list of candidate data products and their requirements, it’s time for leadership to decide which ones to do first. Not everything can be done at once. Consider factors such as:

- **Business urgency:** Is the data product needed for an imminent initiative or deadline?

- **Foundational value:** Does this data product provide a **core data asset** that will support many future analytics and AI use cases? These foundational data products, while possibly more time-consuming to build, can unlock a lot of value across multiple teams once they exist.

- **Quick wins vs. strategic builds:** Some data products might be delivered quickly and show immediate value (quick wins). Others are strategic and provide **long-term benefits** but may require more time. Balance your portfolio to include both types, aligned with your current priorities.

- **Dependencies:** Are certain data products prerequisites for others? Prioritize those that enable subsequent work.

As a result of this step, you should have a **roadmap of data products**, each tied to business goals, with clear requirements and a sense of priority. Each data product should either be approved to move forward now or explicitly marked as “not yet” (deferred), with the reasons documented (for example, waiting on data quality improvements or dependent systems).

5.  **Plan for ongoing re-evaluation:** Business needs aren’t static. Establish a regular review cycle (quarterly or biannually) for the data domain leaders and business stakeholders to re-evaluate the portfolio of data products. Retire any that are no longer providing value. Consider new proposals as business strategies evolve. Keeping this data product portfolio under active governance ensures that effort remains aligned with business value and prevents a sprawl of low-value data assets.

## 3. Organize data domain

With clear domain boundaries and a prioritized list of data products, you can now ensure each data domain is properly resourced and enabled to execute. This involves deciding how to staff the team and how to cultivate the necessary skills. It’s crucial to address team structure after defining the scope, goals, and tools for the domain. This way, you build teams *fit for purpose* instead of guessing needs beforehand.

- **Staff the data domain.** Rather than applying a one-size-fits-all team model to every domain, give each domain the flexibility to set up the team that best fits its mission, within the overall budget and governance constraints. The Data Domain Lead should take ownership of determining the right staffing approach for their domain. **Options:** The key decision here is whether the domain should have a dedicated team or leverage shared resources: **Decision guidance:**

  1.  **Dedicated team:** *When to choose:* This model is ideal when a domain has high strategic importance, requires deep business context, and needs to deliver data products rapidly through continuous iterations. *Benefit:* A dedicated team, fully aligned with the domain, can move faster and develop deep expertise in that domain’s data and needs. *Tradeoff:* Dedicating a full team per domain can use more resources. It may be less efficient if certain technical skills or tools could be shared across domains.

  2.  **Shared team:** *When to choose:* This works well when specialized data skills are scarce or when consistency across domains is more important than speed. A central data team (or a pooled team serving multiple domains) can handle data engineering or analytics tasks for several domains. *Benefit:* This approach promotes standardization and can be more resource-efficient. It uses experts who apply best practices across the organization. *Tradeoff:* Relying on shared resources can introduce bottlenecks and reduce a domain’s agility, as they may need to compete for the central team’s time. It’s a balance of efficiency versus responsiveness. Shared teams can slow down domain-specific innovation if not managed carefully.

In practice, many organizations adopt a hybrid approach: some domains (typically larger or high-priority ones) get dedicated teams, while smaller or less mature domains share a central pool of data professionals. As a decision maker, provide clear guidelines on how domains can request dedicated resources and when they should leverage shared services. Make this a conscious decision framework so it doesn’t happen by default or political influence, but rather is driven by strategic needs.

- **Build data skills**. Teams are expected to build data skills while maintaining full delivery commitments. Learning is treated as optional or secondary. This keeps teams locked into existing processes, slows adoption, and limits the long‑term value of data investments**. Best practices:** Successful organizations make learning part of the job. They plan protected time each week for teams to experiment and improve real data products. Learning is hands‑on and tied to active work. Data domains own the skills required to build and operate their data products and clearly explain how those products should be used and where they have limits. Central teams support this with shared learning paths, standards, and communities, while leaving ownership with the domains. **Options:**

  1.  **Planned, domain‑led learning (recommended)**: Learning and experimentation are built into delivery plans. Domains are accountable for skill outcomes, with central teams enabling consistency. *Choose this* when sustained value, adoption, and productivity matter. *Trade‑off:* May reduce short‑term delivery capacity, but improves quality, speed, and decision‑making over time.

  2.  **Ad hoc learning:** Teams learn when time allows, with no change to priorities or workload. *Choose this only* when short‑term delivery is the sole priority and skill growth is not critical. *Trade‑off:* Preserves short‑term output but leads to stalled skills, fragile solutions, and underused talent.

  3.  **Centralized training**: Central teams drive learning through courses and programs, separate from day‑to‑day delivery. *Choose this* when consistency and baseline knowledge are the primary goals. *Trade‑off:* Improves standardization but often fails to change how work is done or improve adoption.

**Enablement Resources:** Support your teams with relevant training materials and certifications. Microsoft offers a range of learning resources tailored to different roles and technologies. Some examples include:

| **Category** | **Focus Area** | **Intended Audience** | **When to Use** |
|----|----|----|----|
| **Training paths** | [Microsoft Fabric.](/training/fabric/) | Data engineers, analysts, platform teams | When teams are adopting or expanding Fabric workloads |
|  | [Azure Databricks](https://aka.ms/AzureDatabricks_UYDforAI) | Data engineers, data scientists | When building or scaling advanced analytics and engineering pipelines |
|  | [Power BI](/training/powerplatform/power-bi) | Analysts, business users | When improving reporting, self‑service analytics, and adoption |
|  | [Training for Data Analysts](/training/career-paths/data-analyst) | Data analysts | When strengthening analytical skills and business insight |
|  | [Data Scientists](/training/career-paths/data-scientist) | Data scientists | When developing advanced modeling and AI capabilities |
| **Role‑based certifications** | [Fabric Analytics Engineer Associate](/credentials/certifications/fabric-analytics-engineer-associate/?practice-assessment-type=certification) and [study guide](/credentials/certifications/resources/study-guides/dp-600) | Analytics engineers | When validating analytics engineering skills and platform usage |
|  | [Fabric Data Engineer Associate](/credentials/certifications/fabric-data-engineer-associate/?practice-assessment-type=certification) and [study guide](/credentials/certifications/resources/study-guides/dp-700) | Data engineers | When standardizing data engineering skills on Fabric |
|  | [Azure AI Engineer](/credentials/certifications/azure-ai-engineer/?practice-assessment-type=certification) and [study guide](/credentials/certifications/resources/study-guides/ai-102) | AI and ML engineers | When building or operationalizing AI solutions |
|  | [Power Platform Solution Architect](/credentials/certifications/exams/pl-600/) and [study guide](/credentials/certifications/resources/study-guides/pl-600) | Solution architects | When designing end‑to‑end data and Power Platform solutions |

## Next step

By planning your **organizational readiness** in these ways you create a solid foundation. This ensures that your technology investments in a unified data platform will have clear purpose, strong ownership, and the necessary human capabilities to be successful.

Technology architecture
