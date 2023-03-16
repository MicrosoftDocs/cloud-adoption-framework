---
title: Monitoring operations for the Azure Spring Apps landing zone accelerator
description: Operational considerations and recommendations for a Spring Boot workload.
author: pagewriter-msft
ms.author: prwilk
ms.date: 03/01/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-spring-apps
---

# Monitoring operations for the Azure Spring Apps landing zone accelerator


This article provides **observability considerations and recommendations** for your Spring Boot application deployed in Azure Spring Apps. 

The organization might provide **centralized monitoring shared by all workloads** or provide dedicated Azure Monitor Log Analytics workspaces per workload. If you take dependency on the centralized resources, make sure that the application team members have **access to the logs** with their Azure role-based access control (RBAC) roles.

> For information about the platform design, see [Platform design: Workload management and monitoring](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-workloads).

Alternatively, you can choose to **provision your own monitoring resources**. This approach gives the application team more autonomy and **simplifies the overall management** of your application. The tradeoff might be increased management overhead. The Azure Spring Apps landing zone accelerator and the following guidance are based on this approach. 

## Design considerations

- **Logs and metrics**. Collect logs and metrics emitted from the application and resources. Logs provide insight into the operations of the workload. Metrics are collected at regular intervals and allow for near-real time insights. Both can help with investigations related to the *health and utilization of resources*. 

    Metrics are key for _scaling decisions_. You can allow apps to scale based on metric thresholds or during a specific time window. 

    You should consider *storing this data for future analysis*. Also, have the ability to visualize so that you can spot trends quickly.

- **Instrumentation**. Have instrumentation in place to generate _additional logs and metrics from the application_.  

- **Distributed tracing**. Implement distributed tracing to get _observability across different services_ within your Azure Spring Apps ecosystem. You need to configure monitoring agents for your application. 

- **Alerts**. The application teams must _get notified_ about events that are important for the workload. Setting alerts can achieve that goal. You can set alerts that monitor resources based on metrics such as storage, rate of requests, data usage, and others.

- **Health probes**. You can set up health probes to detect the _health of the backend services_. Make sure that you review how the health probes are set up so that requests are routed to healthy instances and to ensure that the application terminates gracefully if backend services aren't available.

## Design Recommendations

- Use Azure Monitor metrics to collect metrics emitted from monitored resources into a time-series database. 
    
    For Azure Spring Apps, _view the charts_ in each application overview page and _common metrics_ page.

-  Use the _Diagnostics setting_ page within Azure Spring Apps to configure the desired combination of diagnostic setting for your apps.

    > [!NOTE] 
    > There's a delay for logs to appear in your storage account, your event hub, or Log Analytics. If the Spring app instances are deleted or moved during that time, the diagnostic settings should be deleted to ensure that another app with the same resource id does not reuse the same diagnostic setting.

- Use Application Insights as a consistent Application Performance Monitoring (APM) tool across all application components to _collect application logs, metrics, and traces_. It can collect data from all the dependencies and traces and has the capability to visualize end-to-end transactions. 

    Azure Spring Apps allows you to collect Spring Cloud Resilience4J metrics into Application Insights. For that you need to enable the Java In-Process agent and configure dimension collection. 

    Azure Spring Apps integrates Spring Cloud Sleuth and Zipkin with Application Insights.

- Choose service discovery mechanisms that allow you to _quickly discover and register app instances_. The options vary based on the chosen Azure Spring Apps tier. 

    - Basic/Standard: [Kubernetes Service Discovery or  Managed Spring Cloud Service Registry (using Eureka)](/azure/spring-apps/how-to-service-registration?pivots=programming-language-java)
    - (Enterprise) [Tanzu Service Registry](/azure/spring-apps/how-to-enterprise-service-registry) 

- Take advantage of Spring Boot Actuator Health Indicator to configure your health probes.

    Always use _readiness and liveness probes_ together so that unhealthy app instances are removed from service discovery features. 

    If your application has a longer startup time, adjust the total timeout (`initialDelaySeconds + periodSeconds * failureThreshold`) to a value longer than the start time of your application. This adjustment helps avoid the probe to fail and force the application to restart.


## Related links

[Azure Spring Apps landing zone accelerator](./landing-zone-accelerator.md)