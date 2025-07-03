---
title: Operations management considerations for Azure API Management
description: Learn about design considerations and recommendations for operations management in the Azure API Management landing zone accelerator
author: Zimmergren
ms.author: pnp
ms.date: 04/12/2022
ms.topic: conceptual
ms.custom: internal
---

# Operations management considerations for the API Management landing zone accelerator

This article provides design considerations and recommendations for operations management when using the API Management landing zone accelerator. Operations management covers multiple aspects, including:

- Provisioning, scaling, and monitoring the API Management instance
- Configuring policies in the gateway
- Managing APIs
- Preparing for business continuity and disaster recovery

Learn more about the [management](../../../ready/landing-zone/design-area/management.md) design area.

## Management and monitoring

### Design considerations for management and monitoring

- Be aware of maximum [throughput limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#api-management-limits) of each API Management service tier. These limits are approximate and not guaranteed.
- Be aware of the maximum number of [scale units](https://azure.microsoft.com/pricing/details/api-management/) per API Management service tier.
- Be aware of the time required to scale out, deploy to another region, or convert to a different service tier.
- API Management doesn't scale out automatically; [additional configuration](/azure/api-management/api-management-howto-autoscale) is required.
- There is no downtime during a scale-out event.
- Only the gateway component of API Management is deployed to all regions in a [multi-region deployment](/azure/api-management/api-management-howto-deploy-multi-region).
- Be aware of the possible performance impact of [Application Insights logging](/azure/api-management/api-management-howto-app-insights) at high loads.
- Be aware of the number of inbound and outbound policies applied and their impact on performance.
- API Management policies are code and should be under version control
- API Management's [built-in cache](/azure/api-management/api-management-howto-cache) is shared by all units in the same region in the same API Management service.
- Use [availability zones](/azure/api-management/zone-redundancy). The number of scale units selected must distribute evenly across the zones.
- If using a [self-hosted gateway](/azure/api-management/self-hosted-gateway-overview), be aware that credentials expire every 30 days and must be rotated.
- The URI `/status-0123456789abcdef` can be used as a common health endpoint for the API Management service.
- The API Management service is not a WAF. Deploy a WAF such as Azure Application Gateway in front for additional layers of protection.
- Client certificate negotiation is enabled in a per-gateway configuration.
- Certificates and secrets in Key Vault are updated in API Management within 4 hours after being set. You can also manually refresh a secret using the Azure portal or via the management REST API.
- [Custom domains](/azure/api-management/configure-custom-domain) can be applied to all endpoints or just a subset. The Premium tier supports setting multiple host names for the Gateway endpoint.
- API Management can be [backed up](/azure/api-management/api-management-howto-disaster-recovery-backup-restore) using its management REST API. Backups expire after 30 days. Be aware of what API Management doesn't back up.
- [Named values](/azure/api-management/api-management-howto-properties) are global in scope.
- API operations can be grouped into [products](/azure/api-management/api-management-howto-add-products) and [subscriptions](/azure/api-management/api-management-subscriptions). Base the design on actual business requirements.

### Design recommendations for management and monitoring

- Apply custom domains to the gateway endpoint only.
- Use [Event Hubs policy](/azure/api-management/api-management-howto-log-event-hubs) for logging at high performance levels.
- Use an [external cache](/azure/api-management/api-management-howto-cache-external) for control and fastest performance.
- Deploy at least two scale units spread over two availability zones per region for best availability and performance.
- Use Azure Monitor to [autoscale](/azure/api-management/api-management-howto-autoscale) API Management. If using a self-hosted gateway, use Kubernetes [horizontal pod autoscaler](/azure/api-management/how-to-self-hosted-gateway-on-kubernetes-in-production#autoscaling) to scale out the gateway.
- Deploy self-hosted gateways where Azure doesn't have a region close to the backend APIs.
- Use Key Vault for certificate storage, notification, and rotation.
- Do not enable 3DES, TLS 1.1, or lower encryption protocols unless required. 
- Use DevOps and infrastructure-as-code practices to handle all deployments, updates, and disaster recovery. 
- Create an API [revision](/azure/api-management/api-management-revisions) and change log entry for every API update.  
- Use [backends](/azure/api-management/backends) to eliminate redundant API backend configurations.
- Use [named values](/azure/api-management/api-management-howto-properties) to store common values that can be used in policies.
- Use Key Vault to store secrets that named values can reference. Secrets updated in the key vault are automatically rotated in API Management
- Develop a communication strategy to notify users of breaking API version updates.
- Configure [diagnostic settings](/azure/api-management/api-management-howto-use-azure-monitor#resource-logs) to forward AllMetrics and AllLogs to Log Analytics workspace.

## Business continuity and disaster recovery

### Design considerations for business continuity and disaster recovery

- Determine the Recovery Time Objective (RTO) and Recovery Point Objective (RPO) for the API Management instances that you want to protect and the value chains they support (consumers and providers). Consider deploying fresh instances or having a hot/cold standby.
- API Management supports [multizone](/azure/api-management/zone-redundancy) and [multiregion](/azure/api-management/api-management-howto-deploy-multi-region) deployments. Based on the requirements, you could enable just one or both.
- Failover can be automated:
  - A multizone deployment automatically fails over.
  - A multiregion deployment requires a DNS-based load balancer such as Traffic Manager to fail over.
- API Management can be [backed up](/azure/api-management/api-management-howto-disaster-recovery-backup-restore#calling-the-backup-and-restore-operations) using its Management REST API.
  * Backups expire after 30 days.
  * Be aware of [what APIM doesn't back up](/azure/api-management/api-management-howto-disaster-recovery-backup-restore#what-is-not-backed-up)

### Design recommendations for business continuity and disaster recovery

- Use a [user-assigned managed identity](/azure/api-management/api-management-howto-use-managed-service-identity) for API Management to prevent downtime during redeployment from ARM templates. If using a system-assigned managed identity, this identity and its associated roles and assignments, such as Azure Key Vault secret access, will be removed if the resource is removed. If using a user-assigned managed identity, these assignments will remain, allowing you to associate it back to API Management without loss of access.
- Use automated Azure Pipelines to run backups.
- Decide whether [multiregion deployment](/azure/api-management/api-management-howto-deploy-multi-region) is required.

## Enterprise-scale assumptions

The following are assumptions that went into the development of the API Management landing zone accelerator:

- A Premium tier instance of API Management that supports availability zones and multiregion deployments is recommended.
- Azure Pipelines are used to manage and deploy infrastructure-as-code.
