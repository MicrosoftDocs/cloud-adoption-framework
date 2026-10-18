---
title: Modernization preparation
description: Prepare for modernization by identifying opportunities, evaluating business cases, addressing skills gaps, and prioritizing investments based on value and risk.
#customer intent: As a decision maker, I want to establish a consistent modernization process so that we can evaluate modernization opportunities and prioritize investments across our cloud workload portfolio.
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 10/16/2026
ms.topic: concept-article
ai-usage: ai-assisted
---

# Modernization preparation

*This article helps decision makers determine when modernization is worth the investment.*

Modernization can improve existing workloads when business needs change or the current state creates unacceptable cost or risk. Organizations need a consistent way to determine which modernization opportunities justify investment and how to prioritize them across the workload portfolio.

**Outcome:** After preparing for modernization, your organization has a prioritized list of workload modernization investments.

## 1. What is modernization?

Modernization improves an existing workload or workload component to better meet current or future business requirements. It can change different parts of a workload, such as its platform, application, data, or operating model. Modernization isn't a specific technology destination. It can range from a targeted upgrade to a significant architectural change.

The goal isn't to make every workload as modern as technically possible. Organizations should modernize enough to achieve the required improvement at an acceptable cost and level of risk. The appropriate level of modernization depends on the problem you need to solve and the value you expect from solving it.

**Outcome:** You have a shared definition of modernization across your organization.

### 1.1 Modernization opportunities

*Where should organizations look for modernization opportunities?* Common modernization opportunities include databases, application platforms, application code, data, security, sovereignty, and enterprise platforms such as SAP. Modernization can move these areas toward managed services, supported technologies, or other capabilities that better meet organizational requirements.

The following examples help decision makers recognize modernization opportunities across their portfolio and understand the types of changes that might result. An opportunity doesn't by itself justify investment. Workload assessments should establish which changes are feasible and which modernization outcomes they could provide.

*Table. Modernization examples*

| Modernization category | Modernization opportunities | Modernization examples |
| --- | --- | --- |
| Database | SQL Server, Oracle, PostgreSQL, MySQL, MongoDB, other operational databases | [Azure SQL Database](/azure/azure-sql/database/sql-database-paas-overview), [Azure Database for PostgreSQL](/azure/postgresql/), [Azure Cosmos DB](/azure/cosmos-db/) |
| Application platform | Applications hosted on virtual machines, VMware, Windows Server, or mainframes | [App Service](/azure/app-service/overview), [Azure Container Apps](/azure/container-apps/overview), [Azure Kubernetes Service](/azure/aks/what-is-aks), [Azure Functions](/azure/azure-functions/functions-overview) |
| Sovereignty | Existing controls or deployment arrangements that don't meet regulatory or residency requirements | [Microsoft Sovereign Cloud](/azure/cloud-adoption-framework/sovereignty/executive-strategy?tabs=overview) |
| Data | Data trapped in operational systems and business applications | [Unified data platform](/azure/cloud-adoption-framework/data/executive-strategy-unify-data-platform) |
| Security | Security controls that leave gaps in protection or visibility | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) |
| Application code | Legacy .NET, Java, and custom applications | Supported application frameworks |
| SAP | Traditional SAP deployments | [SAP on Azure](/azure/sap/) |

### 1.2 Modern versus legacy

*When is a workload modern?* Treat "modern" and "legacy" as conditions to assess rather than technology labels. A workload doesn't need to become as modern as technically possible. It needs to become modern enough for its purpose.

- **Modern:** A workload is modern enough when further changes wouldn't provide enough improvement to justify their cost, risk, or disruption. Modern workloads commonly use technologies and practices that reduce unnecessary effort or constraints. For example, managed services can reduce infrastructure-management responsibilities. Modern architectures can make workloads easier to change, scale, integrate, secure, or operate. These are characteristics of modernization, not requirements for calling a workload modern.

- **Legacy:** A legacy workload generally has characteristics that newer technologies or practices could improve. Unsupported technology is one example. Age alone doesn't determine whether modernization is necessary. An older workload might be modern enough if it meets its objectives efficiently and its cost and risk remain acceptable.

### 1.3 Modernization versus migration

*What's the difference between modernization and migration?* Migration changes where or how a workload runs. Modernization changes the workload to achieve a better outcome. An initiative can do both. A migration is also modernization when the change produces an approved improvement in business capability, cost, risk, operations, or another required outcome.

## 2. Modernization outcomes

*Why modernize?* Organizations modernize when the current state prevents a workload from achieving required outcomes efficiently enough. Modernization might reduce cost or risk, improve agility, or enable new capabilities. A specific modernization effort doesn't need to improve every outcome. Its business case should establish which improvements justify investment. Modernization can provide the following outcomes:

- **Improve security posture:** Reduce security exposure by replacing unsupported technologies or introducing stronger security capabilities.
- **Reduce operational cost and effort:** Reduce infrastructure management or recurring operational work through capabilities such as managed services and automation.
- **Improve reliability and scalability:** Address constraints that prevent workloads from meeting required availability, performance, or growth.
- **Increase organizational agility:** Reduce technical constraints that make important business changes difficult or slow.
- **Enable data and AI capabilities:** Make governed data or application capabilities available for approved analytics and AI uses.
- **Simplify integration:** Reduce dependencies that make systems difficult or costly to connect and change.
- **Improve workforce productivity:** Reduce unnecessary complexity or repetitive work so teams can focus more capacity on higher-value activities.

**Outcome:** You understand the improvements modernization can provide and which ones matter to your organization.

## 3. Modernization roles and responsibilities

*Who makes what decisions?* Modernization requires coordination across business and technical functions from investment decisions through delivery and ongoing operations. Clear responsibilities help decision makers retain accountability for business outcomes and organizational boundaries without taking responsibility for technical implementation. Modernization responsibilities generally include:

- **Business decision makers:** Own modernization investment decisions and portfolio priorities.
- **Platform teams:** Support onboarding of new technologies, update Azure Policy definitions, and provide workload landing zone subscriptions.
- **Workload teams:** Develop modernization proposals and business cases, recommend the modernization approach, and execute approved modernization investments.

**Outcome:** You have assigned roles and responsibilities across your organization for the modernization lifecycle.

## 4. Modernization approaches

*How much change might be required?* Modernization should make the least amount of change needed to achieve the approved outcome within acceptable cost and risk. A targeted replatform might be sufficient when the platform causes the problem. [Refactoring](/azure/cloud-adoption-framework/plan/select-cloud-migration-strategy#4-refactor-modernize-code) or rearchitecting might be necessary when application or architectural constraints prevent the required outcome. Common modernization approaches include:

- **[Replatform](/azure/cloud-adoption-framework/plan/select-cloud-migration-strategy#3-replatform-modernize-hosting-environment):** Use when the existing functionality meets business needs, but the platform creates unnecessary cost, effort, or constraints.
- **[Refactor](/azure/cloud-adoption-framework/plan/select-cloud-migration-strategy#4-refactor-modernize-code):** Use when code limitations or technical debt prevent the workload from achieving the required outcome.
- **[Rearchitect](/azure/cloud-adoption-framework/plan/select-cloud-migration-strategy#5-rearchitect-modernize-architecture-and-code):** Use when fundamental architectural constraints prevent the workload from meeting required outcomes.
- **Continue and reassess:** Use when the expected benefit doesn't justify modernization cost, risk, or disruption.

Workload teams should recommend the least disruptive approach capable of achieving the approved outcome. Decision makers should evaluate whether the proposed level of change is proportionate to its expected value and risk.

**Outcome:** You can evaluate whether the proposed level of change is proportionate to the expected modernization outcome.

## 5. Modernization skilling

*Can we deliver modernization?* Organizations need sufficient capability and capacity to deliver approved modernization investments at an acceptable level of risk. Gaps don't necessarily prevent modernization. They can affect sequencing, funding, or how expertise is sourced.

- **Develop internal capability:** Organizations can develop modernization capability by training existing staff and giving them time to apply new skills. AI-assisted modernization tools can increase productivity and make specialized modernization knowledge more accessible. For example, the [GitHub Copilot modernization agent](/azure/developer/github-copilot-app-modernization/modernization-agent/overview) can assist with application assessment, modernization planning, and code changes. These tools augment expertise rather than replace the skills and accountability required to validate modernization decisions and outcomes.

  **Choose this option when** modernization capability will support many future initiatives and the organization can invest in developing sustainable internal expertise. **Trade-off:** Building internal capability can take longer and requires protected learning time, even when AI-assisted tools accelerate some modernization tasks. See the [Well-Architected Framework](/azure/well-architected/).

- **Option 2. Microsoft or Microsoft partner:** External expertise can supplement organizational capabilities and accelerate modernization. [Frontier Accelerate for Azure](https://azure.microsoft.com/solutions/frontier-accelerate) provides access to specialized partners, funded assessments, skilling resources, and Microsoft investments. [Cloud Accelerate Factory](https://azure.microsoft.com/solutions/frontier-accelerate#Cloud-Accelerate-Factory) provides zero-cost deployment assistance from Microsoft experts for supported modernization scenarios.

  **Choose this option when** the organization needs specialized expertise or additional delivery capacity faster than it can develop internally. **Trade-off:** External support can accelerate delivery, but organizations should plan for knowledge transfer so they can operate and evolve modernized solutions after the engagement ends.

- **Option 3. Add expertise:** Hire employees or contractors for specific gaps. This option can increase capacity faster than developing internal skills. **Choose this option when** you need sustained capacity or a defined specialist role. **Trade-off:** It adds recruitment costs and takes longer than partnering.

**Outcome:** You understand whether your organization has the capacity and capabilities to deliver its modernization priorities and how you will address material gaps.

## 6. Modernization business case

*Is this specific opportunity worth funding?* A modernization opportunity is worth funding when its expected organizational value justifies the required investment and delivery risk. Some investments are justified by financial return. Others are necessary because the current state creates unacceptable business or organizational risk.

### 6.1 Modernization intake

*Where do modernization candidates come from?* **Successful organizations establish a common intake process for modernization proposals.** The process gives teams a defined way to submit modernization opportunities for consideration and gives decision makers visibility into modernization demand across the workload portfolio. Each proposal should identify the affected workload and why modernization is being considered.

Modernization candidates can originate anywhere an organization identifies a workload problem or improvement opportunity. Workload teams might identify technical debt, unsupported technology, excessive operational effort, or architectural constraints. Business decision makers might identify changing business requirements or new organizational priorities. Security, governance, or platform requirements can also create a need for modernization.

### 6.2 Business case development

*Who develops the business case?* Modernization proposals should provide consistent information for investment decisions. Use the same business case structure for every modernization proposal. This consistency helps decision makers determine whether each proposal justifies investment and compare worthy investments across the workload portfolio. The business case provides the evidence for three prioritization factors: business impact, cost of delay, and delivery feasibility.

Keep the evidence proportionate to the decision. You don't need a complete target architecture or implementation plan. You need enough information to determine whether the opportunity justifies investment.

Business decision makers and workload teams develop the business case together. Workload teams contribute evidence from their knowledge and technical assessment of the workload. Business decision makers contribute organizational priorities, business context, and investment considerations. Platform teams contribute evidence when shared platform capabilities or changes affect the investment or its delivery.

*Table. Modernization business case*

| Business case section | Details it should contain | Examples |
| --- | --- | --- |
| **Business need** | What problem or opportunity exists and why it matters. | 80 engineering hours per month spent on maintenance.<br><br>Unsupported technology creates security risk. |
| **Expected outcome** | What should improve if modernization succeeds. | Reduce maintenance effort by 50%.<br><br>Improve the ability to release application changes quickly. |
| **Expected value** | Why that improvement matters enough to justify investment. | Save $70,000 annually.<br><br>Free engineering capacity for higher-value work. |
| **Current cost and risk** | What happens if the organization doesn't modernize. | Operating costs are increasing 12% annually.<br><br>Unsupported components increase the risk of disruption. |
| **Financial impact** | The expected change in total cost of ownership and return on investment. | Reduce annual operating costs by $70,000.<br><br>Accept higher costs to address a critical security risk. |
| **Required investment** | The expected funding and approximate time to value. | $140,000 over six months.<br><br>Six months of engineering capacity. |
| **Delivery confidence** | Whether the organization has enough capability and capacity to deliver the expected outcome. | Existing team has the required skills.<br><br>Specialized external expertise is required. |

**Outcome:** You have a consistent business case for determining whether each modernization opportunity justifies investment.

## 7. Modernization prioritization

*How should organizations prioritize worthy modernization investments?* Prioritize modernization investments by comparing three factors from each business case: business impact, cost of delay, and delivery feasibility. These factors turn the business case into a consistent basis for deciding which investments should proceed first.

| Prioritization factor | Business case evidence | What to compare |
| --- | --- | --- |
| **Business impact** | Business need, expected outcome, expected value, financial impact | How much value would modernization create? |
| **Cost of delay** | Current cost and risk | What is the impact of postponing modernization? |
| **Delivery feasibility** | Required investment, delivery confidence | How feasible is it to achieve the expected outcome? |

Compare the three factors together to determine modernization priority. Give greater priority to investments that create more value or have a higher cost of delay, but consider whether the organization can realistically deliver the expected outcome. When investments have similar priority, return to the underlying business cases to make the decision.

**Outcome:** You have a prioritized set of modernization investments based on consistent evidence from their business cases.

## Next step

> [!div class="nextstepaction"]
> [Plan your modernization](./plan-cloud-modernization.md)