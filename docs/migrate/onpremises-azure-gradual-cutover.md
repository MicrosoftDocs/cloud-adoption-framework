---
title: Gradually cut over workloads from on-premises to Azure
description: Guidance to help you safely migrate workloads from on-premises to Azure using progressive traffic routing strategies that minimize risk and ensure business continuity
author: stephen-sumner
ms.author: ssumner
ms.date: 08/01/2025
ms.topic: conceptual
---

# Gradually cut over workloads from on-premises to Azure

This article provides guidance to help you safely migrate workloads from on-premises to Azure using progressive traffic routing strategies. Organizations benefit from gradual cutover approaches because these strategies minimize migration risks, validate Azure performance under production load, and provide quick rollback options if issues arise.

## Determine your requirements

Your network connectivity between on-premises and Azure environments affects which routing options are available and how traffic flows during migration. Different connectivity patterns enable different routing strategies and have implications for performance, security, and management complexity.

1. **Assess whether you have dedicated connectivity through ExpressRoute or VPN connections.** Dedicated connections enable Azure Application Gateway to include on-premises resources in backend pools and provide consistent network performance. This connectivity supports hybrid backend pools and enables Azure-based load balancers to distribute traffic between environments. Dedicated connections also reduce latency and provide predictable network behavior.

2. **Evaluate internet-based connectivity options for routing traffic between environments.** When dedicated connectivity is not available, you can use internet-based routing through Azure Traffic Manager or Azure Front Door. These services route traffic based on DNS responses or HTTP redirects and do not require private network connectivity. Internet-based routing may introduce higher latency and variable performance compared to dedicated connections.

3. **Consider DNS resolution requirements for your applications and users.** Applications that depend on specific DNS resolution behaviors may require hybrid DNS solutions using Azure Private DNS Resolver. This service provides bidirectional DNS forwarding between Azure and on-premises environments, enabling consistent name resolution during migration. DNS resolution requirements affect which routing services you can use effectively.

4. **Plan for SSL certificate management across environments.** SSL certificates must be properly configured in both on-premises and Azure environments during the cutover period. Azure Front Door and Application Gateway can terminate SSL and manage certificates, while Traffic Manager operates at the DNS level and does not handle SSL termination. Certificate management affects your routing service selection and operational complexity.

## Choose your traffic routing architecture

The architecture you select for controlling traffic flow between on-premises and Azure determines where routing decisions occur and what capabilities are available. Your choice depends on your network connectivity, DNS requirements, and control preferences. You must understand the tradeoffs between each approach to select the option that best fits your migration strategy.

1. **Use Azure-based routing services when you need global load balancing and advanced traffic management capabilities.** Azure Front Door and Azure Traffic Manager provide routing control from Azure, which offers global distribution, health monitoring, and sophisticated routing rules. These services require that you direct your DNS to Azure endpoints, and Azure makes routing decisions based on your configured rules. This approach provides the most flexible traffic management capabilities.

    1. **Choose Azure Traffic Manager for DNS-based global traffic distribution.** Traffic Manager operates at the DNS level and supports weighted, geographic, priority, and performance-based routing methods. This service works well when you need to route traffic based on user location, distribute load across regions, or implement failover scenarios. Traffic Manager provides simple percentage-based traffic splitting and supports health monitoring of endpoints.

    2. **Select Azure Front Door for HTTP/HTTPS workloads requiring advanced routing capabilities.** Front Door provides global load balancing with SSL termination, caching, and rules-based routing. This service supports weighted traffic distribution, session affinity, and custom routing rules based on headers, paths, and query strings. Front Door works best for web applications that need content acceleration and sophisticated routing logic.

    3. **Deploy Azure Application Gateway when you need Layer 7 load balancing with hybrid backend pools.** Application Gateway supports backend pools that include both Azure resources and on-premises systems. But you must use ExpressRoute or VPN connections to route to on-premises public endpoint. This approach enables you to use a single load balancer to distribute traffic between environments while maintaining session affinity and SSL termination capabilities. If you need to route traffic across Azure regions, use Traffic Manager.

    4. **Consider Azure Private DNS Resolver for hybrid DNS scenarios.** When you need seamless name resolution between Azure and on-premises environments, Azure Private DNS Resolver provides bidirectional DNS forwarding. This service enables Azure resources to resolve on-premises domains and on-premises systems to resolve Azure private DNS zones without custom DNS solutions.

2. **Implement on-premises DNS-based routing when you need to maintain control from your existing infrastructure.** Configure your on-premises DNS servers to resolve your application's FQDN to different IP addresses based on your cutover strategy. This approach keeps routing decisions within your on-premises environment and provides familiar operational control. You can gradually change DNS responses to shift traffic to Azure without requiring Azure-based routing services.

## Deploy your workload to Azure before traffic cutover

A successful migration depends on having your workload fully deployed and tested in Azure before you begin routing production traffic. The Azure environment must be ready to handle production workloads without affecting your on-premises operations. You need to complete all infrastructure provisioning, application deployment, and initial testing before you start the cutover process.

1. **Complete a full deployment of your workload in Azure that mirrors your on-premises environment.** This deployment creates an identical copy of your production environment in Azure. The Azure deployment includes all application components, databases, dependencies, and supporting infrastructure required for your workload. This approach ensures that you can validate the complete system before directing traffic to Azure.

2. **Validate the Azure deployment performs correctly under synthetic test loads.** You should conduct comprehensive testing that simulates your production workload patterns. This testing verifies that your Azure environment can handle the expected load and performs within acceptable parameters. Testing identifies any configuration issues or performance bottlenecks before real users access the system.

3. **Establish monitoring and alerting for both environments during the cutover period.** You need visibility into the health and performance of both your on-premises and Azure environments throughout the migration process. This monitoring enables you to detect issues quickly and make informed decisions about traffic routing adjustments.

## Configure DNS for traffic routing

DNS configuration controls how traffic routes between on-premises and Azure environments during the cutover process. DNS routing decisions determine which infrastructure handles the load balancing and where you maintain operational control. You should choose the approach that aligns with your network connectivity, operational requirements, and control preferences.

### Configure Azure-based load balancing

1. **Deploy Azure service as your traffic entry point.** Configure the selected service to act as the primary entry point for all incoming traffic. Azure Front Door provides global load balancing with content delivery network capabilities, while Application Gateway offers regional Layer 7 load balancing with web application firewall protection. Both services support backend pools that include multiple environments.

2. **Update public DNS records to point to your Azure load balancing service.** Change your public DNS records to resolve to the chosen Azure service endpoint (Traffic Manager, Front Door, or Application Gateway). This configuration ensures that all incoming traffic reaches Azure first, where routing decisions occur based on your configured rules. The Azure service then distributes traffic to appropriate backend destinations according to your migration strategy.

3. **Configure on-premises and Azure endpoints.** Add your on-premises endpoint and Azure-hosted endpoint as backends in the same configuration. For Application Gateway, you need ExpressRoute or VPN connectivity to include on-premises resources as backend targets. For Traffic Manager and Front Door, you can use public endpoints for both environments.

4. **Implement weighted routing starting with minimal Azure traffic.** Configure initial weights to send most traffic to on-premises (95-99%) and minimal traffic to Azure (1-5%). This configuration validates the Azure environment under real production load while minimizing user impact. Gradually adjust weights as validation succeeds and confidence increases in the Azure deployment.

### Configure on-premises DNS for controlled routing

1. **Configure DNS records to initially resolve to on-premises IP addresses.** Set up your DNS infrastructure to resolve your application's FQDN to your on-premises IP addresses. This configuration maintains normal operations while you prepare for migration. Document your current DNS configuration and ensure you have proper backup procedures.

2. **Implement DNS-based traffic splitting using weighted DNS responses.** Configure your DNS servers to return different IP addresses based on weighted algorithms. Some DNS servers support weighted round-robin responses that can distribute traffic between on-premises and Azure IP addresses. This approach provides percentage-based traffic distribution controlled from your on-premises infrastructure.

3. **Use DNS views or conditional forwarders for user-based routing.** Configure DNS views that resolve to different IP addresses based on the source of the DNS query. This approach enables you to route specific user groups or geographic regions to Azure while others remain on-premises. DNS views provide granular control over which users experience the Azure environment.

4. **Plan for DNS TTL management during cutover phases.** Lower DNS TTL values during migration phases to enable faster changes to routing decisions. Reduce TTL values before making routing changes and increase them after changes are validated. This approach balances routing flexibility with DNS performance impact.

## Implement progressive traffic cutover

The progressive cutover process involves gradually increasing traffic to Azure while monitoring system health and user experience. This approach minimizes the impact of potential issues and provides opportunities to address problems before they affect all users. You should follow a structured approach with defined phases and validation criteria.

1. **Start with a small percentage of traffic (5-10%) to validate Azure performance under real load.** This initial phase exposes a limited number of users to the Azure environment while you monitor system behavior. Monitor key metrics including response times, error rates, and resource utilization. This phase helps identify any issues that synthetic testing might have missed.

2. **Increase traffic to Azure in incremental phases (10%, 25%, 50%, 75%, 100%) with validation between each phase.** Each phase should run for sufficient time to gather meaningful performance data and user feedback. Wait at least 24-48 hours between phases to account for different usage patterns and time zones. This gradual increase allows you to identify and resolve issues before they impact larger user populations.

3. **Establish clear criteria for proceeding to the next phase or rolling back.** Define specific metrics and thresholds that must be met before increasing traffic to Azure. These criteria should include performance metrics, error rates, user feedback, and business impact measures. Having clear rollback criteria ensures you can quickly revert to on-premises if issues arise.

4. **Maintain the ability to quickly redirect traffic back to on-premises if issues occur.** Your traffic routing solution must support immediate traffic redirection without requiring complex configuration changes. Test your rollback procedures regularly to ensure they work correctly when needed. Document the rollback process and ensure operations teams understand how to execute it quickly.

## Monitor and validate the cutover process

Comprehensive monitoring during the cutover process provides visibility into system health, user experience, and migration progress. This monitoring enables you to make informed decisions about traffic routing adjustments and quickly identify issues that require attention. You must establish monitoring for both environments and track key metrics throughout the migration.

1. **Establish baseline metrics for both on-premises and Azure environments before starting the cutover.** Collect performance metrics, error rates, response times, and resource utilization data for both environments. These baselines provide reference points for comparing system behavior during the migration. Document normal operating ranges for all key metrics.

2. **Monitor application performance, error rates, and user experience throughout each phase.** Track metrics including response times, transaction success rates, error frequencies, and user satisfaction indicators. Set up alerts for metric values that fall outside acceptable ranges. This monitoring helps you identify issues early and take corrective action before they impact more users.

3. **Track business metrics to ensure the migration doesn't negatively impact operations.** Monitor metrics like conversion rates, transaction volumes, and user engagement to ensure the migration maintains business performance. These metrics provide insight into the real-world impact of the migration on your organization's operations.

4. **Use Azure Monitor and Application Insights to gain detailed visibility into Azure workload performance.** Configure comprehensive monitoring for your Azure deployment including application performance monitoring, infrastructure monitoring, and custom metrics. This detailed visibility enables you to optimize Azure performance and troubleshoot issues effectively.

## Handle rollback scenarios

Rollback capabilities provide essential safety mechanisms during migration activities. You must prepare for scenarios where issues require reverting traffic to on-premises systems quickly and efficiently. The rollback process should be tested and documented to ensure it works correctly when needed under pressure.

1. **Define clear rollback criteria including performance thresholds and error rate limits.** Establish specific metrics and thresholds that trigger rollback procedures. These criteria should include response time increases, error rate spikes, user complaint volumes, and business impact measures. Having clear criteria helps operations teams make quick decisions during incidents.

2. **Test rollback procedures regularly to ensure they work correctly and quickly.** Conduct regular tests of your rollback procedures to verify they function as expected. Time these tests to understand how quickly you can revert traffic to on-premises. Document any issues found during testing and update procedures accordingly.

3. **Maintain on-premises capacity and capability throughout the cutover period.** Keep your on-premises environment fully operational and capable of handling full production load until the migration is complete. Don't decommission on-premises resources until you're confident the Azure migration is successful and stable.

4. **Document step-by-step rollback procedures and ensure operations teams understand the process.** Create clear documentation that operations teams can follow during high-pressure situations. Include specific commands, configuration changes, and validation steps required for rollback. Train operations teams on these procedures and conduct regular drills.

## Complete the migration and decommission on-premises resources

The final phase of your migration involves completing the traffic cutover to Azure and safely decommissioning on-premises resources. This phase requires careful planning to ensure business continuity and proper resource cleanup. You should follow a structured approach to avoid disrupting ongoing operations.

1. **Validate that 100% of traffic flows to Azure and performs within acceptable parameters.** Confirm that all users access the Azure environment and that system performance meets your requirements. Monitor key metrics for an extended period to ensure stability under full production load. This validation confirms that the migration is successful and stable.

2. **Maintain on-premises resources for a defined period to support rapid rollback if needed.** Keep your on-premises environment operational for a predetermined time period (typically 30-90 days) to support emergency rollback scenarios. This approach provides additional safety margin and confidence during the early post-migration period.

3. **Update DNS records to point directly to Azure endpoints after successful cutover.** Once you're confident in the Azure deployment, update your DNS records to point directly to Azure endpoints rather than routing through Traffic Manager or Front Door. This change eliminates the intermediate routing layer and reduces complexity for ongoing operations.

4. **Plan and execute systematic decommissioning of on-premises infrastructure.** Develop a plan for shutting down on-premises resources in a controlled manner. This plan should include data backup procedures, license management, and resource cleanup activities. Execute decommissioning gradually to ensure no critical dependencies are overlooked.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Global Load Balancing | [Azure Front Door](/azure/frontdoor/) | Provides global load balancing with weighted traffic distribution and health monitoring |
| DNS Traffic Management | [Azure Traffic Manager](/azure/traffic-manager/) | Offers DNS-based traffic routing with multiple routing methods including weighted and geographic |
| Layer 7 Load Balancing | [Azure Application Gateway](/azure/application-gateway/) | Supports hybrid backend pools with on-premises and Azure resources |
| Hybrid DNS | [Azure Private DNS Resolver](/azure/dns/dns-private-resolver-overview) | Enables bidirectional DNS resolution between Azure and on-premises environments |
| Application Monitoring | [Azure Monitor](/azure/azure-monitor/) | Delivers comprehensive monitoring and alerting for Azure resources and applications |
| Application Performance | [Application Insights](/azure/azure-monitor/app/app-insights-overview) | Provides detailed application performance monitoring and diagnostics |
| Container Traffic Splitting | [Azure Container Apps](/azure/container-apps/traffic-splitting) | Supports traffic splitting between application revisions for containerized workloads |
| Kubernetes Traffic Management | [Application Gateway for Containers](/azure/application-gateway/for-containers/how-to-traffic-splitting-gateway-api) | Enables traffic splitting and weighted routing for Kubernetes applications |

## Next steps

> [!div class="nextstepaction"]
> [Plan migration execution](./plan-migration-execution.md#group-dependent-workloads-into-the-same-migration-wave)
