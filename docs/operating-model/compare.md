---
title: Compare common cloud operating models
description: Learn how other companies have implemented their cloud operating model and review guidance that can support your efforts.
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/14/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal, operating-model
---

# Compare common cloud operating models

Operating models are unique and specific to the business they support. That is, if they're based on their current requirements and constraints. But, this uniqueness shouldn't suggest that operating models are *snowflakes*. There are a few common patterns of customer operating models. This article outlines the four most common patterns.

## Operating model comparison

The following image maps common operating models based on the range of complexity. They're arranged from least complex (decentralized) to most complex (global operations). The following table compares the same operating models based on the relative value of a few other attributes.

![Diagram that shows the degrees of operating model complexity](../_images/operating-model/operating-model-complexity.png)

### Priorities or scope

A cloud operating model is primarily driven by two factors:

- Strategic priorities and motivations
- The scope of the portfolio to be managed

| &nbsp; | Decentralized operations | Centralized operations | Enterprise operations | Distributed operations |
|--|--|--|--|--|
| **Strategic priority** | Innovation | Control | Democratization | Integration |
| **Portfolio scope** | Workload | Landing zone | Cloud platform | Full portfolio |
| **Workload environment** | High complexity | Low complexity | Medium complexity | Medium or variable complexity |
| **Landing zone** | N/A | High complexity | Medium to low complexity | Low complexity |
| **Foundation utilities** | N/A | N/A or low support | Centralized and more support | Most support |
| **Cloud foundation** | N/A | N/A | Hybrid, provider specific, or regional foundations | Distributed and synchronized |

- **Strategic priorities or [motivations](../strategy/motivations.md)**: Each operating model can deliver the typical [strategic motivations for cloud adoption](../strategy/motivations.md). However, some operating models simplify realizing specific motivations.

- [Portfolio scope](../resources/fundamental-concepts/hosting-hierarchy.md): The **Portfolio scope** row in the table above identifies the largest scope that a specific operating model is designed to support. For example, centralized operations are designed for a few landing zones. But that operating model decision could inject operational risks for an organization. Especially if that organization is trying to manage a large, complex portfolio that might require many landing zones or variable complexity in landing zone design.

> [!IMPORTANT]
> Adopting the cloud often triggers a reflection on the current operating model and might lead to a shift from one of the common operating models to another. But cloud adoption isn't the only trigger. As business priorities and the scope of cloud adoption change how the portfolio needs to be supported, there could be other shifts in the most-appropriately aligned operating model. When the board or other executive teams develop 5 to 10 year business plans, those plans often include a requirement (explicit or implied) to adjust the operating model. While these common models are a good reference for guiding decisions, keep in mind that your operating model might change or you might need to customize one of these models to meet your requirements and constraints.

### Accountability alignment

Many teams and individuals are responsible for supporting different functions. As such, each of the common operating models assigns final accountability for decisions and their outcomes to one team or one individual. This approach affects how the operating model is funded and what level of support is provided for each function.

| &nbsp; | Decentralized ops | Centralized ops | Enterprise ops | Distributed ops |
|--|--|--|--|--|
| **Business alignment** | [Workload team](../organize/cloud-adoption.md) | [Central cloud strategy](../organize/cloud-strategy.md) | [CCoE](../organize/cloud-center-of-excellence.md) | Variable - [form a broad cloud strategy team?](../get-started/team/cloud-strategy.md) |
| **[Cloud operations](../organize/cloud-operations.md)** | [Workload team](../organize/cloud-adoption.md) | [Central IT](../organize/central-it.md) | [CCoE](../organize/cloud-center-of-excellence.md) | Based on portfolio analysis - see [Business alignment](../manage/considerations/business-alignment.md) and [Business commitments](../manage/considerations/commitment.md) |
| **[Cloud governance](../organize/cloud-governance.md)** | [Workload team](../organize/cloud-adoption.md) | [Central IT](../organize/central-it.md) | [CCoE](../organize/cloud-center-of-excellence.md) | [Multiple layers of governance](../govern/guides/complex/multiple-layers-of-governance.md) |
| **[Cloud security](../organize/cloud-security.md)** | [Workload team](../organize/cloud-adoption.md) | [Security operations center (SOC)](../organize/cloud-security-operations-center.md) | [CCoE](../organize/cloud-center-of-excellence.md) + [SOC](../organize/cloud-security-operations-center.md) | Mixed - see [Define a security strategy](../strategy/define-security-strategy.md) |
| **[Cloud automation and DevOps](../organize/cloud-automation.md)** | [Workload team](../organize/cloud-adoption.md) | [Central IT](../organize/central-it.md) or N/A | [CCoE](../organize/cloud-center-of-excellence.md) | Based on portfolio analysis - see [Business alignment](../manage/considerations/business-alignment.md) and [Business commitments](../manage/considerations/commitment.md) |

### Accelerate operating model implementation in Azure

The [Define your operating model](./define.md) article describes Cloud Adoption Framework methodologies. It shows how each methodology provides a structured path to iteratively develop your operating model. Following the most relevant methodology helps overcome blockers to adoption that stem from gaps in the cloud operating model.

But there are ways to accelerate your operating model implementation, as outlined in the following table.

| &nbsp; | Decentralized ops | Centralized ops | Enterprise ops | Distributed ops |
|--|--|--|--|--|
| **Starting point** | [Azure Well-Architected Framework (WAF)](/azure/architecture/framework/) | Azure landing zones: [start-small options](../ready/landing-zone/implementation-options.md) | Azure landing zones: [CAF enterprise-scale](../ready/enterprise-scale/implementation.md) | [Business alignment](../manage/considerations/business-alignment.md) |
| **Iterations** | A focus on workloads allows the team to iterate within WAF. | The start-small option requires more iteration on each methodology, but that can be done as cloud adoption efforts mature. | As illustrated by the reference implementations, future iterations typically focus on minor configuration additions. | Review the [Azure landing zone implementation options](../ready/landing-zone/implementation-options.md) to start with the option that best meets your operations baseline. Follow the iteration path defined in that option's design principles. |

## Decentralized operations

![Diagram that shows decentralized operations.](../_images/operating-model/decentralized-operations.png)

Operations are always complex. If you limit the scope of operations to one workload or a small collection of workloads, complexity can be controlled. As such, decentralized operations are the least complex of the common operating models. In this form of operations, all workloads are operated independently by dedicated workload teams.

- **Priorities**: Innovation is favored over centralized control or standardization across multiple workloads.
- **Distinct advantage**: Maximizes speed of innovation by placing workload and business teams in full control of design, build, and operations.
- **Distinct disadvantage**: Reduction in cross-workload standardization, economies of scale through shared services, and consistent governance centralized compliance efforts.
- **Risk**: This approach introduces risk when managing a portfolio of workloads. The workload team is less likely to have specialized teams dedicated to central IT functions. As such, this operating model is viewed as a high-risk option by some organizations, especially companies that are required to follow third-party compliance requirements.
- **Guidance**: Decentralized operations are limited to workload level decisions. The Microsoft Azure Well-Architected Framework is designed to support the decisions made within that scope. The processes and guidance within the Cloud Adoption Framework are likely to add overhead that are not required by decentralized operations.

### Advantages of decentralized operations

- **Cost management**: Cost of operations can be easily mapped to a single business unit. Workload-specific operations allow for greater workload optimization.
- **Responsibilities**: Typically, this form of operations is highly dependent on automation to minimize overhead. Responsibilities tend to focus on DevOps and pipelines for release management. This focus allows for faster deployments and shorter feedback cycles during development.
- **Standardization**: Source code and deployment pipeline should be used standardize the environment from release to release.
- **Operations support**: Decisions that impact operations are only concerned with the needs of that workload, simplifying operations decisions. Many in the DevOps community would argue that this simplification is the purest form of operations because of the tighter operational scope.
- **Expertise**: DevOps and development teams are most empowered by this approach and experience the least resistance to driving market change.
- **Landing zone design**: No specific operational advantage.
- **Foundational utilities**: No specific operational advantage.
- **Separation of duties**: No specific operational advantage.

### Disadvantages of decentralized operations

- **Cost management**: Enterprise costs are harder to calculate. The lack of centralized governance teams makes it harder to implement uniform cost controls or optimization. At scale, this model can be costly since each workload would likely have duplication in deployed assets and staffing assignments.
- **Responsibilities**: Lack of centralized supporting teams means that the workload team is entirely responsible for governance, security, operations, and change management. This gap is a detriment when those tasks haven't been automated in code review and release pipelines.
- **Standardization**: Standardization across a portfolio of workloads can become variable and inconsistent.
- **Operations support**: Scale efficiencies are often missed, as are uniform best practices across multiple workloads.
- **Expertise**: Team members have a greater responsibility to make wise and ethical decisions about:
    - Governance
    - Security 
    - Operations
    - Change management
  
    Consult the Microsoft Azure Well-Architected Review and Azure Well-Architected Framework frequently to improve the required expertise.
- **Landing zone design**: Landing zones aren't workload-specific and aren't considered in this approach.
- **Foundational utilities**: Few, if any, foundational services are shared across workloads, reducing scale efficiencies.
- **Separation of duties**: Higher requirements for DevOps and development teams increase the usage of elevated privileges from those teams. If separation of duties is required, heavy investment in DevOps maturity will be needed to operate in this approach.

## Centralized operations

![Diagram that shows centralized operations.](../_images/operating-model/centralized-operations.png)

Stable-state environments might not require as much focus on the architecture or distinct requirements of the individual workloads. Central operations tend to be the norm for technology environments that consist primarily of stable-state workloads. Examples of a stable-state of operations include things like commercial-off-the-shelf (COTS) applications or well-established custom applications that have a slow release cadence. When rate of change is driven by regular updates and patches, centralization of operations is an effective means to manage the portfolio.

- **Priorities**: Promotes central control over innovation. Also focuses on existing processes as opposed to a cultural shift to options for modern cloud operations.
- **Distinct advantage**: Centralization introduces economies of scale, best-of-breed controls, and standardized operations. This approach works best with the cloud environment that needs specific configurations integrate cloud operations into existing operations and processes. This approach is advantageous to centralized teams. Teams with a portfolio of a few hundred workloads that have modest architectural complexity and compliance requirements find this approach most advantageous.
- **Distinct disadvantage**: Scaling to meet the demands of a large workload portfolio can place significant strain on a centralized team that makes operational decisions for production workloads. If you expect technical assets to scale beyond 1,000 VMs, applications, or data sources in the cloud within the next 18-24 months, consider using an enterprise model.
- **Risk**: This approach limits centralization to a smaller number of subscriptions (often one production subscription). There's a risk of significant refactoring later in the cloud journey that could interfere with adoption plans. Specifically, pay attention to segmentation, environment boundaries, identity tooling, and other foundational elements. Your attention helps you avoid significant rework in the future.
- **Guidance**: Azure landing zone implementation options that are aligned to the "start small and expand" development velocity create a good starting point. Those options can be used to accelerate adoption efforts. To be successful, clear policies must be established to guide early adoption efforts within acceptable risk tolerances. Govern and Manage methodologies create processes to mature operations in parallel. Those steps serve as stage gates that must be completed before allowing for increased risk as operations matures.

### Advantages of centralized operations

- **Cost management**: Centralizing shared services across many workloads creates economies of scale and eliminates duplicated tasks. Central teams can more quickly implement cost reductions through enterprise-wide sizing and scale optimizations.
- **Responsibilities**: Centralized expertise and standardization are likely to lead to higher stability, better operational performance, and lower risk of change-related outages. This standardization reduces broad skilling pressures on the workload focused teams.
- **Standardization**: In general, standardization and cost of operations is lowest with a centralized model because there are fewer duplicated systems or tasks.
- **Operations support**: Reducing complexity and centralizing operations makes it easy for smaller IT teams to support operations.
- **Expertise**: Centralization of supporting teams allows for experts in the fields of security, risk, governance, and operations to drive business critical decisions.
- **Landing zone design**: Central IT tends to minimize the number of landing zones and subscriptions to reduce complexity. Landing zone designs tend to mimic the preceding datacenter designs and can reduce transition time. As adoption progresses, shared resources can then be moved out into a separate subscription or platform foundation.
- **Foundational utilities**: Carrying existing datacenter designs into the cloud results in foundational, shared services that mimic on-premises tools and operations. On-premises operations that are your primary operating model can be an advantage. Doing so reduces transition time, capitalizes on economies of scale, and allows for consistent operational processes between on-premises and cloud hosted workloads. This approach can reduce short-term complexity or effort, and allow smaller teams to support cloud operations with reduced learning curves.
- **Separation of duties**: Separation of duties is clear in central operations. Central IT maintains control of the production environments, which reduces the need for any elevated permissions from other teams. Separation of duties reduces the scope of breach by reducing the number of accounts with elevated privileges.

### Disadvantages of centralized operations

- **Cost management**: Central teams rarely understand the workload architectures enough to produce impactful optimizations at the workload level. Lack of understanding limits the amount of cost savings that can come from well-tuned workload operations. Further, inability to understand workload architecture can cause centralized cost optimizations to have a direct influence on performance, scale, or other pillars of a well-architected workload. Before applying enterprise-wide cost changes to high profile workloads, the Microsoft Azure Well-Architected Review should be completed and considered by the central IT team.
- **Responsibilities**: Centralizing production support and access places a higher operational burden on a smaller number of people. It also places greater pressure on those individuals to do deeper reviews of the deployed workloads to validate adherence to detailed security governance and compliance requirements.
- **Standardization**: Central IT approaches make it difficult to scale standardization without a linear scaling of central IT staff.
- **Operations support**: Not the disadvantage and risks listed above. The greatest disadvantages of this approach are associated with significant scale and shifts that focus to innovation.
- **Expertise**: Developer and DevOps experts are at risk of being undervalued or too constrained in this type of environment.
- **Landing zone design**: Datacenter designs are based on the constraints of preceding approaches, which aren't always relevant to the cloud. Following this approach reduces the opportunities to rethink environment segmentation and empower innovation opportunities. Lack of landing zone segmentation also increases the potential impact of breach, increases complexity of governance/compliance adherence, and could create blockers to adoption later in the cloud journey. See the risks section above.
- **Foundational utilities**: During digital transformation, cloud might become the primary operating model. Persisting central tools built for on-premises operations reduces opportunities to modernize operations and drive increased operational efficiencies. Choosing not to modernize operations early in the adoption process can be overcome through creation of a platform foundations subscription later in the cloud adoption journey. That effort, though, can be complex, costly, and time consuming without advanced planning.
- **Separation of duties**: Central operations generally follow one of two paths, both of which can hinder innovation.
  - **Option 1**: Teams outside of central IT are granted limited access to development environments that mimic production. This option hinders experimentation.
  - **Option 2**: Teams develop and test in non-supported environments. This option hinders deployment processes and slows post-deployment integration testing.

## Enterprise operations

![Diagram that shows enterprise operations.](../_images/operating-model/enterprise-operations.png)

Enterprise operations are the suggested target state for all cloud operations. Enterprise operations balance the need for control and innovation by democratizing decisions and responsibilities. Replace central IT by a more facilitative cloud center of excellence or CCoE team. This team supports workload teams and holds them accountable for decisions, as opposed to controlling or limiting their actions. Workload teams are granted more power and more responsibility to drive innovation, within well-defined guardrails.

- **Priorities**: Focuses on democratization of technical decisions. Democratization of technical decisions shifts responsibilities that were previously held by central IT to workload teams when applicable. To deliver this shift in priorities, decisions become less dependent on human-run review processes. They become more dependent on automated review, governance, and enforcement using cloud-native tools.
- **Distinct advantage**: Segmentation of environments and separation of duties allow for balance between control and innovation. Central operations can maintain centralized operations for workloads that require increase compliance, stable state operations, or represent greater security risks. Conversely, this approach allows for reduction in centralized control of workloads and environments that require greater innovation. Larger portfolios are more likely to struggle with the balance between control and innovation. This flexibility between control and innovation makes it easier to scale to thousands of workloads with reductions in operational pains.
- **Distinct disadvantage**: Strategies that work on-premises might not work well in enterprise cloud operations. This approach to operations requires changes on many fronts. Cultural shifts in control and responsibility are often the biggest challenge. Operational shifts that follow the cultural shift take time and committed effort to implement, mature, and stabilize. Architectural shifts are sometimes required in otherwise stable workloads. Tooling shifts are required to empower and support the cultural, operational, and architectural shifts, which might require commitments to a primary cloud provider. Adoption efforts made before these changes might require significant rework that goes beyond typical refactoring efforts.
- **Risk**: This approach requires executive commitment to the change strategy. It also requires commitment from the technical teams to overcome learning curves and deliver the required change. Long-term cooperation between business, CCoE/central IT, and workload teams is required to see long-term benefits.
- **Guidance**: Certain Azure landing zone implementation options are defined as "enterprise-scale". Those options provide reference implementations to demonstrate how to deliver the technical changes using cloud-native tooling in Azure. The enterprise-scale approach guides teams through the operational and cultural shifts required to take full advantage of those implementations. That same approach can be used to tailor the reference architecture to configure the environment to meet your adoption strategy and compliance constraints. Once enterprise-scale has been implemented, the Govern and Manage methodologies can be used to define processes. You can also use them to expand your compliance and operations capabilities to meet your specific operational needs.

### Advantages of enterprise operations

- **Cost management**: Central teams act on cross-portfolio optimizations and hold individual workload teams accountable for deeper workload optimization. Workload focused teams are empowered to make decisions and provided clarity when those decisions have a negative cost impact. Central and workload teams share accountability for cost decisions at the right level.
- **Responsibilities**: Central teams use cloud-native tools to define, enforce, and automate guardrails. Efforts of the workload teams are accelerated through CCoE automation and practices. The workload teams are then empowered to drive innovation and make decisions within those guardrails.
- **Standardization**: Centralized guardrails and foundational services create consistency across all environments, whatever the scale.
- **Operations support**: Workloads that require centralized operations support are segmented to environments with stable-state controls. Segmentation and separation of duties empower workload teams to take accountability for operational support in their own dedicated environments. Automated, cloud native tools ensure a minimum operations baseline. This baseline is for all environments with centralized operational support for the baseline offering.
- **Expertise**: Centralization of core services such as security, risk, governance, and operations ensure proper central expertise. Clear processes and guardrails educate and empower all members of the workload teams. The teams can make more detailed decisions that expand the impact of the centralized experts, without needing to scale staff linearly with technology scale.
- **Landing zone design**: Landing zone design replicates portfolio needs by creating clear security, governance, and accountability boundaries. These components are required to operate workloads in the cloud. Segmentation practices are unlikely to resemble the constraints created by preceding datacenter designs. In enterprise operations, landing-zone design is less complex, allowing for faster scale and reduced barriers to self-service demand.
- **Foundational utilities**: Foundational utilities are hosted in separate, centrally-controlled subscriptions referred to as the platform foundation. Central tools are then "piped" into each landing zone as a utility services. Separating foundational utilities from the landing zones maximizes consistency and economy of scale. It also creates clear distinctions between centrally managed responsibilities and workload level responsibilities.
- **Separation of duties**: Clear separation of duties between foundational utilities and landing zones is one of the biggest advantages of this approach to operations. Cloud-native tools and sound processes allow for just-in-time access. They also allow for proper balance of control between centralized teams and workload teams. This balance is based on individual landing zone requirements and the workloads hosted in those landing zone segments.

### Disadvantages of enterprise operations

- **Cost management**: Central teams are more dependent on workload teams to make production changes within landing zones. This shift does create a risk of potential budget overruns and slower right-sizing of actual spend. Cost control processes, clear budgets, automated controls, and regular reviews must be in place early to avoid cost surprises.
- **Responsibilities**: Enterprise operations require greater cultural and operational requirements on central and workload teams to ensure clarity in responsibilities and accountability between teams.
- Traditional change management processes or change advisory boards (CABs) are less likely to maintain the pace and balance required in this operating model. Reflect these processes in the automation of processes and procedures to safely scale cloud adoption.
- Lack of commitment to change first materializes in negotiation and alignment of responsibilities. Inability to align on responsibility shifts is an indication that central IT operating models might be required during short-term cloud adoption efforts.
- **Standardization**: Lack of investment in centralized guardrails or automation create risks to standardization that are more difficult to overcome through manual review processes. Operational dependencies between workloads in the landing zones and shared services in the platform foundation create greater risk. They create greater risk to standardization during upgrade cycles or future versions of the foundational utilities. During platform foundation revisions, improved or even automated testing is required of all supported landing zones and the workloads they host.
- **Operations support**: The operations baseline provided through automation and centralized operations might be sufficient for low-impact or low-criticality workloads. However, workload teams or other forms of dedicated operations are likely required for complex or high criticality workloads. This requirement might cause a shift in operations budgets, requiring business units to give operating expenses to those forms of advanced operations. If central IT is required to maintain sole accountability for the cost of operations, then enterprise operations are difficult to implement.
- **Expertise**: Central IT team members are required to develop expertise about automation of central controls previously delivered via manual processes. Those teams might also need to develop a skill for infrastructure-as-code approaches. They need skills like defining the environment. They also need an understanding of branching, merging, and deployment pipelines. At a minimum, a platform automation team needs these skills to act on decisions that are made by the cloud center of excellence or central operations teams. Workload teams will be required to develop more knowledge related to the controls and processes that will govern their decisions.
- **Landing zone design**: Landing zone design takes a dependency on the foundational utilities. Each workload-focused team should understand what is included in the design and what isn't allowed. This design helps avoid duplication of effort or conflicts with automated governance. Exception processes should also be factored in to landing zone designs to create flexibility.
- **Foundational utilities**: Centralization of foundational utilities does take some time to consider options. The utilities can also be used to develop a solution that scales to meet various adoption plans. This centralization can delay early adoption efforts. But, it should be offset later in the process by accelerations and blocker avoidance.
- **Separation of duties**: Ensuring clear separation of duties does require mature identity management processes. There might be more maintenance associated with the proper alignment of users, groups, and onboarding/off-boarding activities. New processes are likely needed to accommodate just-in-time access via elevated privileges.

## Distributed operations

![Diagram that shows distributed operations.](../_images/operating-model/complex-operations.png)

The existing operating model might be too engrained for the entire organization to shift to a new operating model. For others, global operations and various compliance requirements might prevent specific business units from making a change. A distributing operations approach might be required for those companies. This approach is by far the most complex approach. It requires an integration of one or more of the previously mentioned operating models.

While heavily discouraged, this approach to operations might be required for some organizations who consist of a loose collection of disparate business units. Especially when those business units span a diverse base of customer segments or regional operations.

- **Priorities**: Integration of multiple existing operating models.
- Transitional state that focuses on moving the entire organization to previously mentioned operating models, over time.
- Longer term operational approach when the organization is too large or too complex to align to a single operating model.
- **Distinct advantage**: Integration of common operating model elements from each business unit. Creates a vehicle to group operating units into a hierarchy and help them mature operations using consistent repeatable processes.
- **Distinct disadvantage**: Consistency and standardization across multiple operating models is difficult to maintain for extended periods. This operational approach requires deep awareness of the portfolio and how various segments of the technology portfolio are operated.
- **Risk**: Lack of commitment to a primary operating model could lead to confusion across teams. Use this operating model when there's no way to align to a single operating model.
- **Guidance**: Start with a thorough review of the portfolio using the approach that is outlined in the [business alignment](../manage/considerations/business-alignment.md) articles. Take care to group the portfolio by state operating model (decentralized, centralized, or enterprise).
- Develop a management group hierarchy that reflects the operating model groupings. Follow that with other organizational patterns for region, business unit, or other criteria that map the workload clusters from least common to most common buckets.
- Evaluate the workload alignment compared to operating models. This comparison helps find the most relevant operating model cluster to start with. Follow the guidance that maps to that operating model for all workloads under that management group hierarchy node.
- Use the Govern and Manage methodologies to find common corporate policies and required operational management practices at various points of the hierarchy. Apply common Azure policies to automate the shared corporate policies.
- As you test those Azure policies with various deployments, attempt to move them higher in the management group hierarchy. Apply those policies to greater numbers of workloads to find commonalities and distinct operation needs.
- Over time, this approach helps define an operating model that scales across your various other operating models. This approach unifies teams through a set of common policies and procedures.

Advantages and disadvantages of this approach are purposefully blank. After you complete the business alignment of your portfolio, see the predominant operating model section above for clarity on advantages and disadvantages.

## Next steps

Learn the terminology associated with operating models. The terminology helps you understand how an operating model fits into the bigger theme of corporate planning.

> [!div class="nextstepaction"]
> [Operating model terminology](./compare.md)

Learn how a landing zone provides the basic building block of any cloud adoption environment.

> [!div class="nextstepaction"]
> [Compare common cloud operating models](../ready/landing-zone/index.md)
