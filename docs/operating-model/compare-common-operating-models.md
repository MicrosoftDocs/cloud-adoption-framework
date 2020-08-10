---
title: "Review common examples of cloud operating models"
description: See how other companies have implemented their cloud operating model & what guidance can support your efforts.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/20/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
ms.custom: operating-model
---

# Common cloud operating models

Operating models are unique and personal to the business they support, based on their current requirements and constraints. But, this uniqueness shouldn't suggest that operating models are "snowflakes". There are a few common patterns among customer operating models. This article outlines the four most common patterns.

## Operating model comparison

The following image maps common operating models based on the range of complexity from least complex (decentralized) to most complex (global operations). The tables below compares the same operating models based on relative value of a few other attributes.

![Degrees of operating model complexity](../_images/operating-model/operating-model-complexity.png)

### Priorities or Scope

Cloud operating model is primarily driven by two factors: Strategic priorities (or motivations) and the scope of the portfolio to be managed.

||Decentralized operations (ops) |Centralized operations (ops) |Enterprise operations (ops) |Distributed operations (ops) |
|---------              |---------      |---------    |---------          |---------|
|Strategic priority|Innovation|Control|Democratization|Integration|
|Portfolio scope|Workload|Landing zone |Cloud Platform|Full Portfolio|
|Workload environment|High complexity|Low complexity|Medium complexity|Medium or variable complexity|
|Landing zone|N/A|High complexity|Medium to Low complexity|Low complexity|
|Foundation utilities|N/A|N/A or Low support|Centralized & more support|Most support|
|Cloud foundation|N/A|N/A|Hybrid, provider specific, or regional foundations|Distributed and synchronized|

**Strategic priorities or [motivations](../strategy/motivations.md):** Each operating model is capable of delivering the typical [strategic motivations for cloud adoption](../strategy/motivations.md). However, some operating models tend to make it a little easier to realize some specific motivations.

**[Portfolio Scope](../reference/fundamental-concepts/hosting-hierarchy.md):** The portfolio scope row below identifies the largest scope that a specific operating model is designed to support. Example: Centralized operations is designed for a small number of landing zones. But that operating model decision could inject operational risks for an organization which is attempting to manage a large, complex portfolio which could require a large number of landing zones or variable complexity in landing sone design.

> [!IMPORTANT]
> Adopting the cloud often triggers a reflection on the current operating model & may lead to a shift from one of the common operating models to another. But cloud adoption isn't the only trigger. As business priorities and the scope of cloud adoption change how the portfolio needs to be supported, there could be other shifts in the most-appropriately aligned operating model. When the board or other executive teams develop 5 to 10 year business plans, those plans often include a requirement (explicit or implied) to adjust the operating model. While these common models are a good reference for guiding decisions, keep in mind that your operating model may change or you may need to customize one of these models to meet your requirements and constraints.

### Accountability alignment

Many teams and individuals will be responsible for supporting different functions. But each of the common operating models focuses final accountability for decisions and their outcomes on one team or one individual. This impacts how the operating model is funded & what level of support is provided for each function.

||Decentralized ops |Centralized ops  |Enterprise ops          |Distributed ops|
|---------              |---------      |---------    |---------          |---------|
|Business alignment|[Workload team](../organize/cloud-adoption.md)|[Central Cloud strategy](../organize/cloud-strategy.md)|[CCoE](../organize/cloud-center-of-excellence.md)|Variable - [Form a broad cloud strategy team?](../get-started/team/cloud-strategy.md)|
|[Cloud operations](../organize/cloud-operations.md)|[Workload team](../organize/cloud-adoption.md)|[Central IT](../organize/central-it.md)|[CCoE](../organize/cloud-center-of-excellence.md)|Based on portfolio analysis - See [Business Alignment](../manage/considerations/business-alignment.md) and [Business commitments](../manage/considerations/commitment.md)|
|[Cloud governance](../organize/cloud-governance.md)|[Workload team](../organize/cloud-adoption.md)|[Central IT](../organize/central-it.md)|[CCoE](../organize/cloud-center-of-excellence.md)|[Multiple layers of governance](../govern/guides/complex/multiple-layers-of-governance.md)|
|[Cloud security](../organize/cloud-security.md)|[Workload team](../organize/cloud-adoption.md)|[Security Operations Center (SOC)](../organize/cloud-security-operations-center.md)|[CCoE](../organize/cloud-center-of-excellence.md) + [SOC](../organize/cloud-security-operations-center.md)|Mixed - See [Define a security strategy](../strategy/define-security-strategy.md)|
|[Cloud automation & devops](../organize/cloud-automation.md)|[Workload team](../organize/cloud-adoption.md)|[Central IT](../organize/central-it.md) or N/A|[CCoE](../organize/cloud-center-of-excellence.md)|Based on portfolio analysis - See [Business Alignment](../manage/considerations/business-alignment.md) and [Business commitments](../manage/considerations/commitment.md)|

### Accelerate operating model implementation in Azure

As described in the prior article in this series, [Defining your operating model](./methodologies.md), each methodology in the cloud adoption framework provides a structured path to iteratively developing each aspect of your operating model. Following the most relevant methodology will help you overcome blockers to adoption that stem from gaps in the cloud operating model.

But there are ways to accelerate your operating model implementation, as outlined in the table below.

||Decentralized ops  |Centralized ops  |Enterprise ops          |Distributed ops|
|---------              |---------      |---------    |---------          |---------|
|Starting point|[Well-Architected Framework (WAF)](/azure/architecture/framework/)|Azure landing zones: [Start Small options](../ready/landing-zone/implementation-options.md)|Azure landing zones: [CAF enterprise-scale](../ready/enterprise-scale/implementation.md)|[Business Alignment](../manage/considerations/business-alignment.md)|
|Iterations|A focus on workloads will allow the team to iterate within WAF|The start small option will require additional iteration on each methodology, but that can be done as cloud adoption efforts mature.|As illustrated by the reference implementations, future iterations will typical focus on minor configuration additions|Review the [Azure landing zone implementation options](../ready/landing-zone/implementation-options.md) to start with the option that best meets your operations baseline. Follow the iteration path defined in that options design principles.|

## Decentralized operations

![Decentralized operations](../_images/operating-model/decentralized-operations.png)

Operations is always complex. By limiting the scope of operations to one workload or a small collections of workloads, that complexity can be controlled. As such, decentralized operations is the least complex of the common operating models. In this form of operations, all workloads are operated independently by dedicated workload teams.

- **Priorities:** Innovation is prioritized over centralized control or standardization across multiple workloads.
- **Distinct advantage:** Maximizes speed of innovation by placing workload and business teams in full control of design, build, and operations.
- **Distinct disadvantage:** Reduction in cross-workload standardization, economies of scale through shared services, and consistent governance centralized compliance efforts.
- **Risk:** This approach introduces risk when managing a portfolio of workloads. Since the workload team is less likely to have specialized teams dedicated to central IT functions, this operating model is viewed as a high risk option by some organizations, especially companies which are required to follow 3rd party compliance requirements.
- **Guidance:** Decentralized operations are limited to workload level decisions. The Microsoft Azure Well-Architected Framework is designed to support the decisions made within that scope. The processes and guidance within the Cloud Adoption Framework are likely to add overhead that are not required by decentralized operations.

### Advantages of decentralized operations

- **Cost management:** Cost of operations can be easily mapped to the a single business unit. Workload specific operations allow for greater workload optimization.
- **Responsibilities:** Typically, this form of operations is highly dependent on automation to minimize overhead. Responsibilities tend to focus on devops and pipelines for release management. This allows for faster deployments and shorter feedback cycles during development.
- **Standardization:** Source code and deployment pipeline should be used standardize the environment from release to release.
- **Operations support:** Decisions that impact operations are only concerned with the needs of that workload, simplifying operations decisions. Many in the devops community would argue that this is the purest form of operations because of the tighter operational scope.
- **Expertise:** DevOps and Development teams are most empowered by this approach & experience the least resistance to driving market change.
- **Landing zone design:** No specific operational advantage.
- **Foundational utilities:** No specific operational advantage.
- **Separation of duty:** No specific operational advantage.

### Disadvantages of decentralized operations

- **Cost management:** Enterprise costs are harder to calculate. Lack of centralized governance teams make it harder to implement uniform cost controls or optimization. At scale, this can be a costly model, since each workload would likely have duplication in deployed assets and staffing assignments.
- **Responsibilities:** Lack of centralized supporting teams means that the workload team is entirely responsible for governance, security, operations, and change management. This is a detriment when those tasks have not been automated in code review and release pipelines.
- **Standardization:** Standardization across a portfolio of workloads can become variable and inconsistent.
- **Operations support:** Scale efficiencies are often missed. As our uniform best practices across multiple workloads.
- **Expertise:** Team members have a greater responsibility to make wise & ethical decisions regarding governance, security, operations, and change management decisions within the application design and configuration. The Well Architected Review and Well-Architected Framework should be consulted frequently to improve the required expertise.
- **Landing zone design:** Landing zones are not workload specific & are not considered in this approach.
- **Foundational utilities:** Few (if any) foundational services are shared across workloads, reducing scale efficiencies.
- **Separation of duty:** Higher requirements on devops and development teams increases the usage of elevated privileges from those teams. If Separation of duty is required, heavy investment in devops maturity will be needed to operate in this approach.

## Centralized operations

![Centralized operations](../_images/operating-model/centralized-operations.png)

Stable state environments may not require as much of a focus on the architecture or distinct operational requirements of the individual workloads. Central operations tend to be the norm for technology environments that consist primarily of stable-state workloads. Examples of a stable-state of operations include things like Commercial-off-the-shelf (COTS) apps or well-established custom applications that have a slow release cadence. When rate of change is driven by a regular drumbeat of updates and patches (over the high change rate of innovation), centralization of operations is an effective means to manage the portfolio.

- **Priorities:** Prioritizes central control over innovation. Also prioritizes continuation of existing operational processes over cultural shift to modern cloud operations options.
- **Distinct advantage:** Centralization introduces economies of scale, best-of-breed controls, and standardized operations. This approach works best with the cloud environment needs specific configurations integrate cloud operations into existing operations and processes. This approach is most advantageous to centralized teams with a portfolio of a few hundred workloads with modest architectural complexity and compliance requirements.
- **Distinct disadvantage:** Scaling to meet the demands of a large portfolio of workloads can place significant strain on a centralized team making operational decisions for production workloads. If technical assets are expected to scale beyond 1,000 or so VMs, Apps, or data sources in the cloud within the next 18-24 months, an enterprise model should be considered.
- **Risk:** This approach limits centralization to a smaller number of subscriptions (often times one production subscription). There is a risk of significant refactoring later in the cloud journey that could interfere with adoption plans. Specifically, care should be given to segmentation, environment boundaries, identity tooling, and other foundational elements to avoid significant rework in the future.
- **Guidance:** Azure landing zone implementation options aligned to the the "start small & expand" development velocity creates a sound starting point. Those can be used to accelerate adoption efforts. To be successful, clear policies must be established to guide early adoption efforts within acceptable risk tolerances. Govern and Manage methodologies create processes to mature operations in parallel. Those steps serve as stage gates that must be completed before allowing for increased risk as operations matures.

### Advantages of centralized operations

- **Cost management:** Centralizing shared services across a number of workloads creates economies of scale & eliminates duplicated tasks. Central teams can more quickly implement cost reductions through enterprise-wide sizing and scale optimizations.
- **Responsibilities:** Centralized expertize and standardization is likely to lead to higher stability, better operational performance, and lower risk of change-related outages. This reduces broad skilling pressures on the workload focused teams.
- **Standardization:** In general, standardization and cost of operations is lowest with a centralized model because there are fewer duplicated systems or tasks.
- **Operations support:** Reducing complexity and centralizing operations makes it easy for smaller IT teams to support operations.
- **Expertise:** Centralization of supporting teams allow for experts in the fields of security, risk, governance, and operations to drive business critical decisions.
- **Landing zone design:** Central IT tends to minimize the number of landing zones and subscriptions to reduce complexity. Landing zone designs tend to mimic the preceding data center designs, which reduces transition time. As adoption progresses, shared resources can then be moved out into a separate subscription or Platform Foundation.
- **Foundational utilities:** Carrying existing data center designs into the cloud results in foundational, shared services that mimic on-prem tools and operations. When on-premise operations are your primary operating model, this can be an advantage (beware the disadvantages below). Doing so reduces transition time, capitalizes on economies of scale, & allows for consistent operational processes between on-prem and cloud hosted workloads. This approach can reduce short-term complexity/effort & allow smaller teams to support cloud operations with reduced learning curves.
- **Separation of duty:** Separation of duty is very clear in central operations. Central IT maintains control of the production environments reducing the need for any elevated permissions from other teams. This reduces the surface area of breach by reducing the number of accounts with elevated privileges.

### Disadvantages of centralized operations

- **Cost management:** Central teams seldom have enough understanding of the workload architectures to produce impactful optimizations at the workload level. This limits the amount of cost savings that can come from well-tuned workload operations. Further, lack of workload architecture understanding can cause centralized cost optimizations to have a direct impact on performance, scale, or other pillars of a well-architected workload. Before applying enterprise-wide cost changes to high profile workloads, the well-architected review should be completed and considered by the central IT team.
- **Responsibilities:** Centralizing production support and access places a higher operational burden on a smaller number of people. It also places greater pressure on those individuals to perform deeper reviews of the deployed workloads to validate adherence to detailed security, governance, and compliance requirements.
- **Standardization:** Central IT approaches make it difficult to scale standardization without a linear scaling of Central IT staff.
- **Operations support:** Not the disadvantage and risks listed above. The greatest disadvantages of this approach are associated with significant scale & shifts that prioritize innovation.
- **Expertise:** Developer and DevOps experts are at risk of being under-valued or too constrained in this type of environment.
- **Landing zone design:** Data center designs are based on the constraints of preceding approaches, which aren't always relevant to the cloud. Following this approach reduces the opportunities to rethink environment segmentation and empower innovation opportunities. Lack of landing zone segmentation also increases the potential impact of breach, increases complexity of governance/compliance adherence, and could create blockers to adoption later in the cloud journey. See the risks section above.
- **Foundational utilities:** During digital transformation, cloud may become the primary operating model. Persisting central tools built for on-premise operations reduces opportunities to modernize operations & drive increased operational efficiencies. Choosing not to modernize operations early in the adoption process can be overcome through creation of a platform foundations subscription later in the cloud adoption journey, but that effort can be complex, costly, and time consuming without advanced planning.
- **Separation of duty:** Central operations generally follow one of two paths, both can hinder innovation. Option 1: Teams outside of central IT are granted very limited access to development environments that mimic production. This option hinders experimentation. Option 2: Teams perform development &/or quality control in non-supported environments. This option hinders deployment processes & increases post-deployment integration testing efforts.

## Enterprise operations

![Enterprise operations](../_images/operating-model/enterprise-operations.png)

Enterprise operations is the suggested target state for all cloud operations. Enterprise operations balances the need for control and innovation by democratizing decisions and responsibilities. Central IT is replaced by a more facilitative Cloud Center of Excellence or CCoE team which supports workload teams and hold them accountable for decisions, as opposed to controlling or limiting their actions. Workload teams are granted more power and more responsibility to drive innovation, within well-defined guardrails.

- **Priorities:** Prioritizes democratization of technical decisions. Democratization of technical decisions shifts responsibilities previously held by Central IT to workload teams when applicable. To deliver this shift in priorities, decisions become less dependent on human-run review processes and more dependent on automated review, governance, and enforcement using cloud-native tools.
- **Distinct advantage:** Segmentation of environments and separation of duties allow for balance between control and innovation. Central operations can maintain centralized operations for workloads that require increase compliance, stable state operations, or represent greater security risks. Conversely, this approach allows for reduction in centralized control of workloads and environments that require greater innovation. Since larger portfolios are more likely to struggle with the balance between control and innovation, this flexibility makes it easier to scale to thousands of workloads with reductions in operational pains.
- **Distinct disadvantage:** What worked well on-premise, may not work well in enterprise cloud operations. This approach to operations requires changes on many fronts. Cultural shifts in control and responsibility are often the biggest challenge. Operational shifts that follow the cultural shift take time and committed effort to implement, mature, and stabilize. Architectural shifts are sometimes required in otherwise stable workloads. Tooling shifts are required to empower and support the cultural, operational, and architectural shifts which may require commitments to a primary cloud provider. Adoption efforts made prior to these changes may require significant re-work that goes beyond typical refactoring efforts.
- **Risk:** This approach requires executive commitment to the change strategy. It also requires commitment from the technical teams to overcome learning curves and deliver the required change. Long term cooperation between business, CCoE/central IT, and workload teams is required to see long-term benefits.
- **Guidance:** Azure landing zone implementation options defined as "Enterprise-Scale" provide reference implementations to demonstrate how the technical changes are delivered using cloud-native tooling in Azure. The enterprise-scale approach guides teams through the operational and cultural shifts required to take full advantage of those implementations. That same approach can be used to tailor the reference architecture to configure the environment to meet your adoption strategy & compliance constraints. Once enterprise-scale has been implemented, the Govern and Manage methodologies can be used to define processes & expand your compliance and operations capabilities to meet your specific operational needs.

### Advantages of enterprise operations

- **Cost management:** Central teams act on cross-portfolio optimizations and hold individual workload teams accountable for deeper workload optimization. Workload focused teams are empowered to make decisions & provided clarity when those decisions have a negative cost impact. Central and workload teams share accountability for cost decisions at the right level.
- **Responsibilities:** Central teams use cloud-native tools to define, enforce, and automate guardrails. Efforts of the workload teams are accelerated through CCoE automation and practices. The workload teams are then empowered to drive innovation & make decisions within those guardrails.
- **Standardization:** Centralized guardrails and foundational services create consistency across all environments, regardless of scale.
- **Operations support:** Workloads which require centralized operations support are segmented to environments with stable-state controls. Segmentation and separation of duties empower workload teams to take accountability for operational support in their own dedicated environments. Automated, cloud native tools ensure a minimum operations baseline for all environments with centralized operational support for the baseline offering.
- **Expertise:** Centralization of core services such as security, risk, governance, and operations ensures proper central expertise. Clear processes and guardrails educates and empowers all members of the workload teams to make more detailed decisions that expand the impact of the centralized experts, without needing to scale that staff linearly with technology scale.
- **Landing zone design:** Landing zone design replicates the needs of the portfolio, creating clear security, governance, and accountability boundaries required to operate workloads in the cloud. Segmentation practices are unlikely to resemble the constraints created by preceding data center designs. In enterprise operations, landing zone design is less complex, allowing for faster scale & reduced barriers to self-service demand.
- **Foundational utilities:**  Foundational utilities are hosted in separate centrally-controlled subscriptions referred to as the Platform Foundation. Central tools are then "piped" into each landing zone as a utility services. Separating foundational utilities from the landing zones maximizes consistency, economy of scale, and creates clear distinctions between centrally managed responsibilities and workload level responsibilities.
- **Separation of duty:** Clear separation of duty between foundational utilities and landing zones is one of the biggest advantages of this approach to operations. Cloud-native tools and sound processes allow for just-in-time access & proper balance of control between centralized teams and workload teams, based on the requirements of the individual landing zones and the workloads hosted in those landing zone segments.

### Disadvantages of enterprise operations

- **Cost management:** Central teams are more dependent on workload teams to make production changes within landing zones. This shift does create a risk of potential budget overruns & slower right-sizing of actual spend. Cost control processes, clear budgets, automated controls, and regular reviews must be in place early to avoid cost surprizes.
- **Responsibilities:** Enterprise operations requires greater cultural and operational requirements on central and workload teams to ensure clarity in responsibilities and accountability between teams.
- Traditional change management processes or change advisory boards (CABs) are less likely to maintain the pace & balance required in this operating model. Those processes should be reflected in the automation of processes and procedures to safely scale cloud adoption.
- Lack of commitment to change will first materialize in negotiation and alignment of responsibilities. Inability to align on shifts in responsibility is an indication that central IT operating models may be required during short term cloud adoption efforts.
- **Standardization:** Lack of investment in centralized guardrails or automation create risks to standardization that are more difficult to overcome through manual review processes. Additionally, operational dependencies between workloads in the landing zones and shared services in the platform foundation creates greater risk to standardization during upgrade cycles or future versions of the foundational utilities. During platform foundation revisions, improved or even automated testing is required of all supported landing zones and the workloads they host.
- **Operations support:** The operations baseline provided through automation and centralized operations may be sufficient for low impact or low criticality workloads. However, workload teams or other forms of dedicated operations will likely be required for complex or high criticality workloads. This may necessitate a shift in operations budgets, requiring business units to allocate operating expenses to those forms of advanced operations. If Central IT is required to maintain sole accountability for the cost of operations, then enterprise operations will be difficult to implement.
- **Expertise:** Central IT team members will be required to develop expertise regarding automation of central controls previously delivered via manual processes. Those team may also need to develop a proficiency for infrastructure-as-code approaches to defining the environment, along with an understanding of branching, merging, and deployment pipelines. At minimum a platform automation team will need these skills to act on decisions made by the Cloud Center of Excellence or Central operations teams. Workload teams will be required to develop additional knowledge related to the controls and processes that will govern their decisions.
- **Landing zone design:** Landing zone design takes a dependency on the foundational utilities. To avoid duplication of effort (or errors/conflicts with automated governance), each workload focused team should understand what is included in the design & what is forbidden. Exception processes should also be factored in to landing zone designs to create flexibility.
- **Foundational utilities:** Centralization of foundational utilities does take some time to consider options and develop a solution that will scale to meet various adoption plans. This can delay early adoption efforts, but should be offset long-term by accelerations and blocker avoidance later in the process.
- **Separation of duty:** Ensuring clear separation of duty does require mature identity management processes. There may be additional maintenance associated with the proper alignment of users, groups, and on-boarding/off-boarding activities. new processes will likely be needed to accommodate just-in-time access via elevated privileges.

## Distributed operations

![Distributed operations](../_images/operating-model/complex-operations.png)

The existing operating model may be too engrained for the entire organization to shift to a new operating model. For others, global operations and various compliance requirements may prevent specific business units from making a change. For those companies, a distributing operations approach may be required. This is by far the most complex approach, as it requires an integration of one or more of the previously mentioned operating models.

While heavily discouraged, this approach to operations may be required for some organizations who consist of a loose collection of disparate business units. Especially when those business units span a diverse base of customer segments or regional operations.

- **Priorities:** Integration of multiple existing operating models.
- Transitional state with a focus on moving the entire organization to one of the previously mentioned operating models, over time.
- Longer term operational approach when the organization is too large or too complex to align to a single operating model.
- **Distinct advantage:** Integration of common operating model elements from each business unit. Creates a vehicle to group operating units into a hierarchy & help them mature operations using consistent repeatable processes.
- **Distinct disadvantage:** Consistency and standardization across multiple operating models is difficult to maintain for extended periods. This operational approach requires deep awareness of the portfolio and how various segments of the technology portfolio are operated.
- **Risk:** Lack of commitment to a primary operating model could lead to confusion across teams. This operating model should only be used when there is no way to align to a single operating model.
- **Guidance:** Start with a thorough review of the portfolio using the approach outlined in the [Business Alignment](../manage/considerations/business-alignment.md) articles. Take care to group the portfolio by desired state operating model (Decentralized, Centralized, or Enterprise).
- Develop a management group hierarchy that reflects the operating model groupings, followed by other organizational patterns for region, business unit, or other criteria that maps the workload clusters from least common to most common buckets.
- Evaluate the alignment of workloads to operating models to find the most relevant operating model cluster to start with. Follow the guidance that maps to that operating model for all workloads under than node of the management group hierarchy.
- Leverage the Govern and Manage methodologies to find common corporate policies and required operational management practices at various points of the hierarchy. Apply common Azure policies to automate the shared corporate policies.
- As those Azure policies are tested with various deployments, attempt to move them higher in the management group hierarchy applying those policies to greater numbers of workloads to find commonalities and distinct operation needs.
- Over time this approach will help define an operating model that scales across your various other operating models & unifies teams through a set of common policies and procedures.

Advantages and disadvantages of this approach are purposefully blank. After you complete the business alignment of your portfolio, see the predominant operating model section above for clarity on advantages and disadvantages.
