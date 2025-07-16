---
title: Replatform workloads during Azure migration
description: Learn how to replatform workloads during migration to Azure using a comprehensive framework that modernizes your hosting environment with minimal code changes through Azure PaaS services.
author: stephen-sumner
ms.author: pnp
ms.date: 07/16/2025
ms.topic: conceptual
---

# Replatform workloads to Azure PaaS services

This article provides a comprehensive framework for replatforming workloads during Azure migration. Replatforming modernizes applications by moving from virtual machines (VMs) to platform as a service (PaaS) offerings in Azure. This approach reduces operational overhead, improves scalability, and accelerates innovation while maintaining application functionality with minimal code changes.

## Build a comprehensive replatforming assessment

A thorough assessment forms the foundation of successful replatforming. This assessment identifies the current state of your applications and determines the optimal path forward. You must understand your application architecture, dependencies, and technical constraints before beginning any replatforming effort.

2. **Map application dependencies and data flows.** Enable dependency analysis in Azure Migrate to visualize cross-server dependencies and identify systems that must migrate together. Use either agentless dependency analysis for VMware, Hyper-V, and physical servers, or agent-based analysis for detailed dependency mapping. This mapping ensures that interdependent systems are grouped correctly and prevents surprise outages during migration.

3. **Assess application compatibility for PaaS services.** Evaluate each application component against Azure PaaS service requirements. Consider programming languages, frameworks, runtime versions, and third-party dependencies. Use Azure Migrate application and code assessment tools for .NET and Java applications to identify potential compatibility issues and receive replatforming recommendations.

4. **Analyze performance and capacity requirements.** Review historical performance data collected by Azure Migrate to understand CPU, memory, disk, and network utilization patterns. This analysis helps determine appropriate Azure service tiers and configurations. Performance data is crucial for right-sizing Azure resources and ensuring the replatformed application meets or exceeds current performance benchmarks.

5. **Document security and compliance requirements.** Identify security controls, compliance frameworks, and regulatory requirements that must be maintained during replatforming. Document authentication methods, data encryption requirements, network security configurations, and audit trails. Ensure that the target PaaS services support these requirements.

6. **Calculate total cost of ownership and business value.** Compare the current on-premises costs with projected Azure PaaS costs using Azure Migrate cost assessments. Include infrastructure, licensing, operational overhead, and scalability benefits in your calculations. Document the business value of replatforming, including improved agility, reduced maintenance burden, and enhanced scalability.

## Prioritize components using a strategic framework

Component prioritization ensures that replatforming efforts focus on the highest-value, lowest-risk opportunities first. This strategic approach maximizes early wins and builds organizational confidence in the replatforming process.

1. **Classify components by replatforming complexity and risk.** Evaluate each application component across multiple dimensions: OS dependencies, custom configurations, third-party integrations, and data persistence requirements. Create a matrix that categorizes components as low, medium, or high complexity. Components with minimal OS dependencies, standard configurations, and stateless designs are typically better candidates for early replatforming.

2. **Assess business impact and technical feasibility.** Rank components based on their business importance and technical feasibility for replatforming. Consider factors such as revenue impact, user base, regulatory requirements, and integration complexity. Use a scoring system that weighs business value against technical risk to create a prioritized list.

3. **Identify quick wins and foundation components.** Focus first on components that provide immediate value with minimal risk. Stateless web applications, API services, and background processing jobs often represent good initial candidates. These components typically have fewer dependencies and can demonstrate the value of PaaS services to stakeholders.

4. **Group related components for coordinated migration.** Identify components that share dependencies or form logical application tiers. Plan to replatform these components together to maintain application integrity and reduce integration complexity. Use dependency mapping to understand these relationships and plan appropriate migration sequences.

5. **Define success criteria for each component.** Establish clear, measurable success criteria for each replatforming effort. Include performance benchmarks, availability targets, security requirements, and cost objectives. These criteria provide objective measures for evaluating replatforming success and inform rollback decisions if needed.

## Design the replatforming architecture

Architecture design translates assessment findings into a concrete technical plan. This design phase defines the target state architecture and ensures alignment with Azure best practices and organizational requirements.

1. **Select appropriate Azure PaaS services for each component.** Use Azure service decision trees and architecture guidance to choose the most suitable PaaS services for each application component. Consider Azure App Service for web applications, Azure Functions for event-driven workloads, Azure SQL Database for relational data, and Azure Container Apps for containerized applications. Evaluate service capabilities, scalability limits, and integration options.

2. **Design for high availability and disaster recovery.** Implement multi-region architectures where business requirements justify the additional complexity and cost. Use Azure availability zones for regional fault tolerance and Azure Site Recovery for disaster recovery capabilities. Design auto-scaling configurations to handle varying load patterns and ensure consistent performance.

3. **Plan data migration and transformation.** Design data migration strategies that minimize downtime and ensure data integrity. Use Azure Database Migration Service for database migrations and Azure Data Factory for data transformation requirements. Consider data partitioning strategies and implement appropriate backup and recovery procedures.

4. **Implement security and compliance controls.** Design security architectures that meet or exceed current security posture. Implement Azure Active Directory for authentication, Azure Key Vault for secrets management, and Azure Security Center for threat detection. Use network security groups, private endpoints, and Azure Firewall to control network access.

5. **Design monitoring and observability solutions.** Implement comprehensive monitoring using Azure Monitor, Application Insights, and Log Analytics. Design alerting strategies that provide early warning of performance issues or security threats. Create dashboards that provide visibility into application health, performance metrics, and business indicators.

6. **Plan integration and API management.** Design API strategies that support both current integrations and future scalability needs. Use Azure API Management for API governance, security, and monitoring. Consider event-driven architectures using Azure Event Grid or Azure Service Bus for loose coupling between components.

## Implement Infrastructure as Code foundations

Infrastructure as Code (IaC) provides the foundation for repeatable, consistent deployments and enables automated testing and rollback capabilities. This approach ensures that replatforming efforts can be validated and repeated across environments.

1. **Select appropriate IaC tools and establish standards.** Choose between Azure Resource Manager (ARM) templates, Bicep, or Terraform based on your organization's preferences and multi-cloud requirements. Bicep offers native Azure integration and simplified syntax, while Terraform provides multi-cloud capabilities. Establish coding standards, naming conventions, and resource tagging strategies.

2. **Implement modular IaC templates.** Create reusable infrastructure modules that can be combined to build complete application environments. Design modules for common patterns such as web applications, API services, and database deployments. Use Azure Verified Modules where available to leverage pre-tested, Microsoft-validated templates.

3. **Establish environment management practices.** Create separate environments for development, testing, staging, and production. Use parameter files and environment-specific configurations to manage differences between environments. Implement access controls and governance policies that ensure appropriate separation of duties.

4. **Integrate with CI/CD pipelines.** Connect IaC templates to Azure DevOps or GitHub Actions pipelines for automated deployment. Implement validation steps that test infrastructure changes before deployment. Use deployment slots and blue-green deployment strategies to minimize downtime during updates.

5. **Implement configuration management and secrets handling.** Use Azure App Configuration for centralized application settings management. Implement Azure Key Vault integration for secure secrets storage and retrieval. Design configuration strategies that support different environments and enable feature toggles where appropriate.

## Execute systematic component migration

Component migration requires careful orchestration to minimize risk and ensure successful outcomes. This systematic approach treats each component as a discrete migration project with defined phases and success criteria.

1. **Establish migration project governance.** Create a migration plan for each component that includes goals, timelines, resource requirements, and success criteria. Assign clear roles and responsibilities for each migration effort. Establish communication protocols and escalation procedures for issue resolution.

2. **Build and validate target environments.** Use Infrastructure as Code to provision PaaS resources in development and staging environments. Implement identical configurations across environments to ensure consistency. Validate that all required integrations, security controls, and monitoring capabilities are properly configured.

3. **Execute data migration and application deployment.** Implement data migration strategies that minimize downtime and ensure data integrity. Use Azure Database Migration Service for database migrations and appropriate tools for file and blob storage migrations. Deploy applications using automated pipelines that ensure consistency and repeatability.

4. **Perform comprehensive testing and validation.** Execute functional testing to verify that the replatformed component behaves correctly in its new environment. Conduct performance testing to ensure that the component meets or exceeds baseline performance metrics. Validate security controls, backup procedures, and disaster recovery capabilities.

5. **Implement progressive traffic migration.** Use blue-green deployment strategies to minimize risk during production cutover. Start with a small percentage of traffic directed to the new environment and gradually increase based on monitoring results. Implement automated monitoring and alerting to detect issues early and trigger rollback procedures if necessary.

## Monitor and optimize post-migration performance

Post-migration monitoring ensures that replatformed components continue to meet performance, security, and cost objectives. This ongoing optimization process identifies opportunities for further improvement and ensures long-term success.

1. **Establish comprehensive monitoring and alerting.** Configure Azure Monitor and Application Insights to capture detailed performance metrics, error rates, and user experience indicators. Implement alerting rules that notify appropriate personnel of performance degradation or security issues. Create dashboards that provide visibility into application health and business metrics.

2. **Optimize performance and resource utilization.** Monitor resource utilization patterns and adjust Azure service configurations based on actual usage. Implement auto-scaling policies that respond to demand changes while minimizing costs. Use Azure Advisor recommendations to identify optimization opportunities for performance, security, and cost.

3. **Validate and refine backup and recovery procedures.** Test backup and recovery procedures to ensure they meet recovery time and recovery point objectives. Validate that backup jobs complete successfully and that restored data maintains integrity. Document and train operations teams on recovery procedures.

4. **Assess cost optimization opportunities.** Use Azure Cost Management to monitor spending patterns and identify cost optimization opportunities. Implement Azure reservations for predictable workloads and use Azure Hybrid Benefit for licensing cost reductions. Review and optimize resource configurations based on actual usage patterns.

5. **Gather stakeholder feedback and measure business outcomes.** Collect feedback from end users, administrators, and business stakeholders about the replatformed application's performance and usability. Measure business outcomes such as improved feature delivery speed, reduced operational overhead, and enhanced security posture. Document lessons learned for future replatforming efforts.

6. **Plan continuous improvement and further modernization.** Identify opportunities for additional modernization such as implementing microservices architectures, adopting containerization, or integrating artificial intelligence capabilities. Create a roadmap for ongoing improvements that align with business objectives and technology evolution.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Discovery and Assessment | [Azure Migrate](https://learn.microsoft.com/azure/migrate/migrate-services-overview) | Comprehensive discovery and assessment of on-premises workloads with dependency mapping |
| Application Assessment | [Azure Migrate application and code assessment](https://learn.microsoft.com/azure/migrate/appcat/overview) | Detailed assessment of .NET and Java applications for replatforming recommendations |
| Infrastructure as Code | [Azure Bicep](https://learn.microsoft.com/azure/azure-resource-manager/bicep/) | Native Azure infrastructure as code with simplified syntax |
| Infrastructure as Code | [Azure Verified Modules](https://learn.microsoft.com/azure/architecture/guide/azure-resource-manager/advanced-templates/verified-modules) | Pre-tested, Microsoft-validated infrastructure templates |
| CI/CD Pipeline | [Azure DevOps](https://learn.microsoft.com/azure/devops/) | Comprehensive DevOps platform with integrated CI/CD capabilities |
| Database Migration | [Azure Database Migration Service](https://learn.microsoft.com/azure/dms/dms-overview) | Managed service for database migrations with minimal downtime |
| Load Balancing | [Azure Front Door](https://learn.microsoft.com/azure/frontdoor/) | Global load balancer with traffic routing capabilities for blue-green deployments |
| Application Hosting | [Azure App Service](https://learn.microsoft.com/azure/app-service/) | Fully managed platform for web applications with deployment slots |
| Container Hosting | [Azure Container Apps](https://learn.microsoft.com/azure/container-apps/) | Serverless container platform with built-in blue-green deployment support |
| Monitoring | [Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/) | Comprehensive monitoring and alerting platform |
| Cost Management | [Azure Cost Management](https://learn.microsoft.com/azure/cost-management-billing/) | Cost tracking and optimization tools |

## Next steps

> [!div class="nextstepaction"]
> [Modernize in the cloud](index.md)