---
title: Data Consumption Standards for AI and Analytics
description: "Data consumption standards in Microsoft Fabric and Purview for AI and analytics: learn how to govern access, manage lifecycle, and retire data products safely across your organization."
#customer intent: As a decision, I want to a checklist of best practices to help me make the best decision to establish organization-wide standards for consuming and managing published data products in Microsoft Fabric, so that teams can reuse data safely without creating security risks or platform instability.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 03/09/2026
ms.topic: concept-article
ms.collection: ce-skilling-ai-copilot
---

# Data consumption standards for AI and analytics

Data product consumption defines how data products in Microsoft Fabric used across the organization. This process affects trust, security, and long-term platform success. **Recommendation:** Establish organization-wide standards for how teams consume and manage all published data products in Fabric over time. This approach helps teams safely reuse data without creating risk or instability (see Figure 1). To apply this recommendation, use this article as a checklist:

:::image type="content" source="images/operational-standards-unify-data-platform.svg" alt-text="Diagram showing the three major steps in setting operational standards. First, set data processing standards like how to move data through the bronze, silver, and gold layers. Second, set security standards for how to secure data products in different Microsoft services. Third, set consumption and lifecycle standards for data products." lightbox="images/operational-standards-unify-data-platform.svg" border="false":::
*Figure 1. Three steps to setting operational standards for data.*

## Data consumption standards

Data consumption standards define when and how teams might rely on shared data products for business decisions, reporting, and automated systems. Leaders who set these standards reduce risk, improve trust, and create predictable reuse across Microsoft Fabric and connected services. **Recommendation:** Establish clear rules that control which data products teams might consume, how teams approve new uses, how access is granted, and how consumption paths are validated before production use. To apply this recommendation, use the following checklist:

1. **Require official status before broad consumption.** Official status means a data product is approved for reuse beyond the owning team and is recognized as trusted at the organization level. **Best practices:** Require all shared data products to have an explicit official status before broad consumption. Use consistent signals to show which products are approved for reuse. Ensure each official product has a clear purpose and accountable ownership. Treat official status as the entry point for lifecycle governance.
**Decision guidance:** Decide which endorsement level applies to each product category, such as [Fabric endorsement levels](/fabric/fundamentals/endorsement-promote-certify). Use lighter endorsement for internal reuse. Use certification for cross‑domain or regulated use. Higher endorsement increases confidence but requires more reviews.

2. **Approve significant new uses of data products.** Don't assume a dataset is fit for every purpose without review. **Best practices:** Require an approval step when a team wants to use a data product in a critical scenario. Examples include external customer exposure or AI decision support. Keep the step light. Make it fast. Keep records in the product's documentation. Use [data lineage](/purview/data-map-lineage-fabric) to understand upstream and downstream dependencies before you approve a new use. This approach helps you see what the product depends on and what depends on it. **Decision guidance:** Define which scenarios need formal approval. Internal business-as-usual analyses can be exempt or covered by broad policy for agility. External uses, regulatory-sensitive scenarios, or uses of data in AI systems that make autonomous decisions should trigger a formal review and sign-off. While an approval step can introduce a short delay, it helps prevent misuse of data.

3. **Enforce least-privilege access for consumers.** Only the required data should be accessible to any user or application consumers. **Best practices:** When granting access to a data product, scope it to the minimum necessary for the task. If a particular report or application only needs aggregated data, provide access to an aggregated view rather than the detailed underlying data. Set access standards by using the Fabric [permission model](/fabric/security/permission-model) and [OneLake security](/fabric/onelake/security/get-started-onelake-security). Favor item‑level access over workspace‑wide access. Require periodic access review for official products. **Decision guidance:** Decide which access scope applies to each product tier. Broader access reduces friction but increases exposure. Narrow access improves security but adds governance effort.

4. **Validate consumption paths before production use.** Validation confirms that data access and protection behave as intended when consumers use the product. **Best practices:** Before any new report, application, or AI agent goes live by using a data product, require a testing phase. In this phase, the team should simulate how the data is used and confirm security is working correctly. For example, use a test user account with limited permissions to see if they can only retrieve what they should. To test protection without enforcement, use [Purview's data loss prevention (DLP) simulation](/purview/dlp-simulation-mode-get-started). **Decision guidance:** Decide which validation depth applies per product tier. Lightweight validation suits low‑risk products. Deeper validation suits sensitive products. More validation reduces incidents but increases lead time.

## Responsible AI standards

AI consumption means a data product is used to train or ground AI systems. **Best practices:** If the data product feeds into an AI system, incorporate a Responsible AI review. This review checks the data for biases. Does it over-represent or under-represent certain groups? Ensure it has appropriate sensitivity labels, so the AI knows what's sensitive. For example, if you have an AI agent answering questions about HR data, verify that the data is accurate and shared appropriately. If you train a model on the data, document what time period or population the data covers, so the AI's results are interpreted correctly. **Decision guidance:** Decide which AI use cases require enhanced review. Apply stricter review when AI influences decisions or automates actions. Stronger review reduces risk but limits speed.

## Monitoring and change management standards

Monitoring and change standards protect trust in data products at scale and reduce operational risk for the organization. Decision makers set these standards to balance reliability, cost, and agility across all governed data products. **Recommendation:** Establish clear monitoring and change expectations for all official data products and scale those expectations based on business criticality. To apply this recommendation, use the following checklist:

1. **Monitor usage and operational health.** Define monitoring as the ongoing oversight of usage patterns that affect trust in a data product. Decision makers rely on monitoring to detect issues early and to understand business impact. **Best practices:** Require ongoing monitoring for all official data products. Use [Fabric monitoring](/fabric/admin/monitoring-hub) to track refresh health and failures. Use lineage views to understand downstream impact when an issue occurs. Treat monitoring as a standard control, not an optional feature. **Decision guidance:** Decide which data products require enhanced monitoring. Choose enhanced monitoring for products that support critical business decisions or that have broad adoption. Choose baseline monitoring for low-impact or limited-scope products. Enhanced monitoring improves resilience but consumes more capacity and operational effort.

7. **Set change management standards.** Define change management as the process that governs how updates to a data product affect consumers and dependent systems. Decision makers use change management standards to protect consumers from unexpected disruption. **Best practices:** When you need to change a data product, such as altering its schema, recalculating a metric, or changing its refresh schedule, inform all stakeholders well in advance. Use tools to help identify the effects. For changes to a Power BI semantic model, use [impact analysis](/power-bi/collaborate-share/service-dataset-impact-analysis). Again, use [data lineage](/purview/data-map-lineage-fabric) to understand upstream and downstream dependencies. Use multiple channels if necessary. Make updates in the Microsoft Purview Unified Catalog with notes on the upcoming change. Send out notifications or release notes to known users of the data product. If applicable, announce it in relevant team meetings or internal forums. Clearly explain what is changing, when it happens, and the reason for the change. Explain whether consumers need to do anything, such as update their queries or reports. **Decision guidance:** Decide which change types require longer notice. Breaking changes need more notice. Nonbreaking changes need less. Longer notice protects consumers but reduces agility.

## Data product retirement standards

Retire data products in a controlled manner. Retirement removes a data product from active use without breaking dependent workloads. **Best practices:** Require a documented retirement plan for all official data products. Remove endorsement before retirement. Preserve Purview metadata and lineage for audit and investigation. **Decision guidance:** Decide retirement timelines based on dependency depth. Short timelines reduce cost. Longer timelines reduce disruption. Choose based on business needs.

## Next step

The next step is to establish standards for how AI app and agents consume your data products.

> [!div class="nextstepaction"]
> [General AI adoption](/azure/cloud-adoption-framework/scenarios/ai/)

> [!div class="nextstepaction"]
> [AI Agent adoption](/azure/cloud-adoption-framework//ai-agents/)
