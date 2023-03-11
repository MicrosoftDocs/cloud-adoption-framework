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


This article provides observability considerations and recommendations for your Spring Boot application deployed in Azure Spring Apps. 

The organization might provide centralized monitoring that's shared by all workloads or provide dedicated Azure Monitor Log Analytics workspaces per workload. If you take dependency on the centralized resources, make sure that the application team members have access to the logs with their Azure role-based access control (RBAC) roles.

> For information about the platform design, see [Platform design: Workload management and monitoring](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-workloads).

Alternatively, you can choose to provision your own monitoring resources. This approach will give the application team more autonomy and simplify the overall management of your application. The tradeoff might be increased management overhead. The Azure Spring Apps landing zone accelerator and the following guidance is based on this approach. 

## Design considerations

- **Logs and metrics**. This data is emited from the application and resources. Logs provide insight into the operations of the workload. Metrics are are collected at regular intervals and allow for near-real time insights. Both can help with investigations related to the health and utilization of resources. 

    Logs and metrics are key for scaling decisions. You can allow apps to scale based on metric thresholds or during a specific time window. 

    You should consider storing this data for future analysis. Also, have the ability to visualize so that you can spot trends quickly.

- **Distributed tracing**. Distributed tracing gives you observability across different services within your Azure Spring Apps ecosystem. You'll need to configure monitoring agents for your application. 

- **Alerts**. The application teams must get notified about events that are important for the workload. Alerts is one way of achieving that goal. You can set alerts that monitor resources based on metrics such as storage, rate of requests, data usage, and others.

- **Instrumentation**. Instrumentation allows you to capture data from the application so that you can make performance decisions.  

    An important use case is service discovery. Instrument your application so that Azure Spring Apps can maintain a list of live apps to call that's used to route and load balance requests.

- **Health probes**. You can set up health probes to detect the health of the backend services. Make sure that you review how the health probes are set up so that requests are routed to healthy instances and to ensure graceful termination in case backend services aren't available.


## Design Recommendations

- Use Azure Monitor metrics to collect metrics emitted from monitored resources into a time-series database. 
    
    For Azure Spring Apps, view the charts in each application overview page and common metrics page.

-  Use the Diagnostics setting page within Azure Spring Apps to configure the desired combination of diagnostic setting for your apps.

    > [!NOTE] There's a delay for logs to appear in your storage account, your event hub, or Log Analytics. If the Spring app instances are deleted or moved during that time, the diagnostic settings should be deleted to ensure that another app with the same resource id does not reuse the same diagnostic setting.

- Use Application Insights as a consistent Application Performance Monitoring (APM) tool across all application components to collect application logs, metrics, and traces. It can collect data from all the dependencies and traces and has the capability to visualize end-to-end transactions. 

    Azure Spring Apps allows you to collect Spring Cloud Resilience4J metrics into Application Insights. For that you need to enable the Java In-Process agent and configure dimension collection. 

    Azure Spring Apps integrates Spring Cloud Sleuth and Zipkin with Application Insights.

- Choose service discovery mechanisms that allow you to quickly iscover and register app instances. The options vary by Azure Spring Apps. 

    - Basic/Standard: [Kubernetes Service Discovery or  Managed Spring Cloud Service Registry (using Eureka)](/azure/spring-apps/how-to-service-registration?pivots=programming-language-java)
    - (Enterprise) [Tanzu Service Registry](/azure/spring-apps/how-to-enterprise-service-registry) 

- Take advantage of Spring Boot Actuator Health Indicator to configure your health probes.

    Always use the readiness and liveness probes together so that apps are removed from service discovery features. 

    If your application has a longer startup time, adjust the total timeout (`initialDelaySeconds + periodSeconds * failureThreshold`) to a value longer than the start time of your application. This will help avoid the probe to fail and force the application to restart.


