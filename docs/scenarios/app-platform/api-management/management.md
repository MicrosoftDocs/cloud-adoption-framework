---
title: Operations management considerations for Azure API Management
description: <<Describe how this landing zone accelerator can improve operations management for Azure API Management.>>
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---

# Operations management considerations for API Management landing zone accelerator

[Intro paragraph. Disclose any required dependency on ESLZ design area or other ALZ design areas, with links to those supporting materials.]

## Management and monitoring

### Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of API Management.

- Be aware of maximum throughput limits of each API Management SKU
- Be aware of the maximum number of scale-out units per API Management SKU
- Be aware of the maximum throughputs are approximate and not guarantees 
- Be aware of the time required to scale-out, deploy into another region, or convert from deployment types
- API Management does not scale-out automatically, additional configuration is required.
- There is no downtime during a scale-out event
- Only the gateway component of API Management is deployed to all regions in a multi-region deployment. 
- Be aware of the possible performance impact of AppInsights logging at high loads.
- Be aware that the number of inbound and outbound policies applied and their impact to performance
- Policies are code and should be under version control
- API Management's built-in cache is shared by all units in the same region in the same API Management service.
- Utilize Availability Zones, the number of Units selected must distribute evenly across the zones
- Self-hosted gateway's credentials expire every 30 days and must be rotated. 
- The Uri /status-0123456789abcdef can be used as a common health endpoint for the API Management service.
- The API Management Service is not a WAF. Deploy Azure Application Gateway in front to add additional layers of protection
- Client certificate negotiation is enabled is a per-gateway configuration 
- certificates updated in the key vault are automatically rotated in API Management and is updated within 4 hours. 
- Secret in Key Vault is updated within 4 hours after being set. You can also manually refresh the secret using the Azure portal or via the management REST API.
- Custom Domains can be applied to all endpoints or just a subset. The Premium tier supports setting multiple host names for the Gateway endpoint.
- API Management can be backed up using its Management REST API. Backups expire after 30 days. Be aware of what API Management does not back up.
- Named-Keys are global in scope.
- API Operations can be grouped into Products and Subscriptions. The design will be based on actual business requirements.


### Design recommendations

- Apply custom domains to the Gateway endpoint only
- Use Event Hub policy for logging at high performance levels 
- Utilize an external cache for control and fastest performance 
- Deploy at least two scale units spread over two AZs per region for best availability and performance 
- Utilize Azure Monitor to Autoscale API Management. If using a self-hosted gateway, use Kubernetes Horizonal Pod Autoscaler to scale out the gateway
- Deploy self-host gateways where Azure does not have a region close to the back-end API
- Utilize Key Vault for Certificate storage, notification, and rotation
- Do not enable 3DES, TLS1.1 or lower encryption protocols unless absolutely required. 
- Utilize DevOps and Infrastructure-As-Code practices to handle all deployments, updates, and DR. 
- Create an API revision and Change Log entry for every API update.  
- Utilize Backends to eliminate redundant API backend configurations.
- Utilize Named-Values to store common values that can be used in policies.
- Utilize Key Vault to store secrets that Named-Values can reference.
- Secrets updated in the key vault are automatically rotated in API Management.
- Develop communication strategy to notify users of breaking API version update.
- Set diagnostic settings to forward AllMetrics and AllLogs to Log Analytics workspace

## Business continuity and disaster recovery

### Design considerations

The following is a bulleted list of things you must think about when preparing for **any** deployment of API Management.

- What are the RTO and RPO for the impacted API Management instance(s) and the value chains they support (consumers & providers). Deploying a fresh instance runs through a lot of wall clock time (40-60 minutes) Having a cold standby might be beneficial.  
    - Will many teams move to the same region(s) once a disaster is declared?
        - Will they all use Azure DevOps to deploy (and thus create a large queue) of deployment jobs
- How is the fail-over orchestrated (and if so by whom)? 
    - Are consumers and providers aware or should this be transparent (from connectivity perspective, performance may be impacted)
- Is the failover manual or automated?
- Are multiple API Management gateway instances (already) deployed in different regions
- How to fail back when the disaster is relieved

### Design recommendations


The following is a bulleted list of best practices that should be included in any deployment of API Management.

[NONE]

## Enterprise-scale assumptions

The following are assumptions that went into the development of the deployable asset: Enterprise-scale for API Management.

## Additional considerations

Create as many H2 "##" headers as is required to educate the customer on this topic.
