# Plan the cloud-native solution

A cloud-native solution creates new business value by build new applications or adding new features. This guidance helps you deliver cloud-native workloads quickly and effectively by aligning with business goals, using Azure's strengths including AI, and following a clear, repeatable process.

**Prerequisites:** [Architecture plan](/azure/cloud-adoption-framework/plan/estimate-total-cost-of-ownership), [Azure landing zone](/azure/cloud-adoption-framework/ready)

## Define requirements that drive implementation

1. **Document functional requirements.** Functional requirements describe the capabilities, features, and behaviors the system must provide to meet user needs. Capture these as user stories that define who needs what functionality and why. For example: “As a customer, I need to track my order status in real time so I can plan for delivery.”

2. **Establish non-functional requirements.** Non-functional requirements define performance expectations, security needs, scalability targets, and compliance obligations. Document specific, measurable targets for things like response time (e.g. “95% of requests under 2 seconds”), throughput, data protection standards, and availability (e.g. uptime SLAs). For example: “The system must support 1,000 concurrent users with response times under 2 seconds.”

3. **Connect requirements directly to business objectives.** Ensure each requirement supports a business goal such as revenue growth, cost reduction, customer experience improvement, or market expansion. This alignment helps prioritize requirements based on business impact and technical feasibility. Focus development efforts on the most valuable outcomes first. Every feature should trace back to a concrete business value.

## Design the cloud-native solution

1. **Design using Azure Well-Architected Framework principles.** Follow the five pillars of reliability, security, performance efficiency, cost optimization, and operational excellence throughout the design. Bake these principles into your architecture from the beginning rather than trying to add them later. This proactive approach reduces technical debt and accelerates time to production.

1. **Select Azure services that align with your requirements.** Use Azure’s decision guides and the Azure Architecture Center to choose the most appropriate services for your use case. Favor platform-as-a-service (PaaS) offerings whenever possible to reduce operational overhead by abstracting away infrastructure management. Managed services (for compute, databases, messaging, etc.) can accelerate development and simplify maintenance.

1. **Select the right service tier (SKU).** Estimate expected user concurrency, transaction volumes, data sizes, and latency needs. Choose service SKUs that meet these targets, and validate your choices through performance testing. Adjust the SKU if needed based on test results to achieve an optimal balance of cost and performance. It’s better to start with a smaller size and scale up as required than over-provision without data.

1. **Determine how many regions to use.** Use your reliability requirements, such as service level objectives (SLOs) for uptime, recovery point objectives (RPOs), and recovery time objectives (RTOs), to decide how many Azure regions your solution should use. For high availability or disaster recovery, multi-region deployments might be necessary. However, multi-region architectures can introduce complexity around data replication, latency, and data residency regulations. Work with your compliance team to ensure your regional strategy meets any legal or regulatory obligations.

1. **Plan governance controls.** Design the solution to fit within your organization’s established Azure landing zone structure (subscriptions, resource groups) so that it inherits existing governance policies. By deploying resources in the predefined application landing zone, you automatically apply Azure Policy definitions for things like tagging standards, allowed locations, and compliance requirements. Incorporate Azure role-based access control (RBAC) and security best practices from the start, rather than as an afterthought.

1. **Evaluate integration requirements**. Evaluate integration requirements and ecosystem compatibility. Assess how the new services and components will integrate with existing systems and toolchains. Consider dependencies on identity and access management (Microsoft Entra ID), networking (VNets, hybrid connections), and third-party services. Ensure the technology stack of the solution is compatible with your organization’s IT ecosystem and can be managed by your operational teams. Early identification of integration points (APIs, data feeds, authentication mechanisms) helps avoid surprises during development.

1. **Update or create architectures.** Create a lightweight design document or architecture diagram that outlines, Selected Azure services and their roles. Key design decisions and trade-offs Non-functional requirements such as compliance, latency, or throughput targets. This documentation supports stakeholder alignment, accelerates reviews, and guides implementation.

## Prevent new build scope creep

1. **Define a focused scope that delivers core business value.** Clearly articulate the minimum viable product (MVP) or initial feature set that addresses the primary business requirements. Document the project scope boundaries so everyone understands what will and won’t be delivered. This focus helps prevent feature creep during development. Defer nice-to-have enhancements to future phases. When new feature ideas come up, evaluate them against the project’s original objectives and timeline before deciding to include them now or later.

1. **Control scope changes.**  Establish a structured process for handling change requests. If stakeholders propose additions to the scope, record each request in a separate backlog (“future features” backlog) for later consideration. Only approve a scope change for the current release if it clearly supports the project’s goals and can be implemented without jeopardizing the timeline or budget. This formal check keeps the project on track.

1. **Communicate project focus consistently.** Provide regular updates to stakeholders highlighting progress on the agreed-upon scope and upcoming planned work. Transparency about what the team is currently focused on makes it easier to push back on out-of-scope requests. If someone asks for extra features mid-stream, politely remind them of the agreed scope and timeline, and explain that new requests will be logged for future evaluation. Consistent messaging reinforces discipline and manages expectations.

1. **Capture future opportunities separately.** Cloud-native development often reveals opportunities for business improvements or new capabilities. Instead of expanding the current project scope, maintain a dedicated backlog for these future enhancement ideas.

## Plan deployment strategy

### New workload deployment

plan to deploy new workloads with infrastructure as code and through your CI/CD pipeline. promote from stage and consider a canary roll out to a limited set of users.

### New features deployment

when should you use in-place updates and canary rollout and how do you do this

when should you use parallel environment and canary rollout and how do you do this

## Plan for new features

New features required integration with existing workloads

### Use a change management process

[!INCLUDE]

### Define rollback and recovery procedures

[!INCLUDE]

## Secure stakeholder approval

[!INCLUDE]

## Plan for operational handover

Decide how the new solution will be operated and supported once it’s in production. No matter what, include monitoring, alerting, and disaster recovery plans in your design
