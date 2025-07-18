---
title: Gradually cut over workloads from on-premises to Azure
description: Guidance to help you safely migrate workloads from on-premises to Azure using progressive traffic routing strategies that minimize risk and ensure business continuity
author: stephen-sumner
ms.author: ssumner
ms.date: 08/01/2025
ms.topic: conceptual
---

# Gradually cut over workloads from on-premises to Azure

This article provides guidance to help you migrate workloads from on-premises to Azure using progressive traffic routing strategies. Organizations benefit from gradual cutover approaches because these strategies minimize migration risks, validate Azure performance under production load, and provide quick rollback options if issues arise.

## Choose a routing method that supports gradual workload cutover

A routing architecture defines how users and systems access workloads during migration. This decision affects how easily you can shift traffic, maintain availability, and manage DNS and SSL configurations. You should select a routing architecture that aligns with your connectivity model, DNS control, and operational preferences.

### Use Azure-based routing

Azure routing services provide centralized traffic management that supports gradual workload cutover from on-premises to Azure. Each service offers different capabilities for traffic distribution, connectivity, and geographic reach. You should select the service that matches your cutover requirements, connectivity model, and workload architecture.

1. **Choose Azure Application Gateway for HTTP routing within a single Azure region.** Select Application Gateway when you need Layer 7 HTTP routing and only have a single-region architecture. To route to on-premises public endpoints, you need ExpressRoute or VPN.

1. **Choose Azure Front Door for HTTP routing across multiple Azure regions.** Select Front Door when you need Layer 7 HTTP routing and your Azure deployment spans multiple regions.

1. **Choose Azure Traffic Manager for DNS-based percentage traffic splitting.** Select Traffic Manager when you need to gradually shift traffic percentages between on-premises and Azure using weighted DNS routing (for example, starting with 10% to Azure and increasing over time to 100%). This service works at the DNS level and supports any endpoint accessible over the internet, making it ideal for cutover scenarios where you want precise percentage control.

### Use on-premises DNS routing

On-premises DNS routing allows you to control traffic flow without relying on Azure-native services. This approach is useful when you want to maintain operational control or perform a gradual migration.

1. **Configure on-premises DNS to resolve application FQDNs to Azure or on-premises IPs.** This method allows you to shift traffic by updating DNS responses locally. You should configure DNS records to point to Azure endpoints as workloads are migrated. Use short TTLs to enable rapid updates. Monitor traffic and performance before shifting more users.

2. **Use split-horizon DNS if internal and external users require different routing.**  Split-horizon DNS allows different responses based on the source of the request. You should configure internal DNS to resolve to on-premises systems and external DNS to resolve to Azure. Use this approach to support phased migration without disrupting internal users. Ensure DNS consistency and avoid caching issues.

## Configure DNS for traffic routing

DNS configuration controls how traffic routes between on-premises and Azure environments during the cutover process. DNS routing decisions determine which infrastructure handles the load balancing and where you maintain operational control. You should choose the approach that aligns with your network connectivity, operational requirements, and control preferences.

### Configure Azure-based load balancing

1. **Deploy Azure service as your traffic entry point.** Configure you selected Azure service to act as the primary entry point for all incoming traffic to the workload.

2. **Update public DNS records to point to your Azure load balancing service.** Change your public DNS records to resolve to the chosen Azure service endpoint (Traffic Manager, Front Door, or Application Gateway). This configuration ensures that all incoming traffic reaches Azure first, where routing decisions occur based on your configured rules. The Azure service then distributes traffic to appropriate backend destinations according to your migration strategy.

3. **Configure on-premises and Azure endpoints.** Add your on-premises endpoint and Azure-hosted endpoint as backends in the same configuration. For Application Gateway, you need ExpressRoute or VPN connectivity to include on-premises resources as backend targets. For Traffic Manager and Front Door, you can use public endpoints for both environments.

4. **Manage SSL certificates across hybrid environments.** Choose centralized SSL certificate management when you need to make decisions about certificate consistency and security across both environments during traffic shifting. This approach is ideal when you want to avoid certificate-related issues that could disrupt the gradual cutover process and ensure secure connections regardless of where traffic.

### Configure on-premises DNS for controlled routing

1. **Implement DNS-based traffic splitting using weighted DNS responses.** Configure your DNS servers to return different IP addresses based on weighted algorithms. Some DNS servers support weighted round-robin responses that can distribute traffic between on-premises and Azure IP addresses. This approach provides percentage-based traffic distribution controlled from your on-premises infrastructure.

1. **Use DNS views or conditional forwarders for user-based routing.** Configure DNS views that resolve to different IP addresses based on the source of the DNS query. This approach enables you to route specific user groups or geographic regions to Azure while others remain on-premises. DNS views provide granular control over which users experience the Azure environment.

1. **Plan for DNS TTL management during cutover phases.** Lower DNS TTL values during migration phases to enable faster changes to routing decisions. Reduce TTL values before making routing changes and increase them after changes are validated. This approach balances routing flexibility with DNS performance impact.

## Implement progressive traffic cutover

The progressive cutover process involves gradually increasing traffic to Azure while monitoring system health and user experience. This approach minimizes the impact of potential issues and provides opportunities to address problems before they affect all users. You should follow a structured approach with defined phases and validation criteria.

1. **Start with a small percentage of traffic (5-10%) to validate Azure performance under real load.** This initial phase exposes a limited number of users to the Azure environment while you monitor system behavior. Monitor key metrics including response times, error rates, and resource utilization. This phase helps identify any issues that synthetic testing might have missed.

2. **Increase traffic to Azure in incremental phases (10%, 25%, 50%, 75%, 100%) with validation between each phase.** Each phase should run for sufficient time to gather meaningful performance data and user feedback. Wait at least 24-48 hours between phases to account for different usage patterns and time zones. This gradual increase allows you to identify and resolve issues before they impact larger user populations.

3. **Establish clear criteria for proceeding to the next phase or rolling back.** Define specific metrics and thresholds that must be met before increasing traffic to Azure. These criteria should include performance metrics, error rates, user feedback, and business impact measures. Having clear rollback criteria ensures you can quickly revert to on-premises if issues arise.

4. **Maintain the ability to quickly redirect traffic back to on-premises if issues occur.** Your traffic routing solution must support immediate traffic redirection without requiring complex configuration changes. Test your rollback procedures regularly to ensure they work correctly when needed. Document the rollback process and ensure operations teams understand how to execute it quickly.

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
