---
title: Management operations for the Azure Spring Apps landing zone accelerator
description: Operational considerations and recommendations for a Spring Boot workload.
author: pagewriter-msft
ms.author: prwilk
ms.date: 03/01/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-spring-apps
---

# Management operations for the Azure Spring Apps landing zone accelerator


Patience is a virtue!

Content coming soon. 



Management and operational considerations for Azure Spring Apps

This article provides design considerations and recommendations for operations management when using the Azure Spring Apps. While Azure Spring Apps aims to simplify the overall management of your application, the below list covers common operational aspects that need to be addressed.

Design Considerations
Workload Management and Monitoring
Metrics
Azure Metrics explorer is a component of the Microsoft Azure portal that allows plotting charts, visually correlating trends, and investigating spikes and dips in metrics. Use the metrics explorer to investigate the health and utilization of your resources
Logs
Determine if you want to export logs to a tool such as Azure Log Analytics, stream logs to a partner solution such as Splunk or ELK or even store logs in a Storage account for future analysis.
Distributed Tracing
For distributed workloads, it is recommended to enable distributed tracing to provide observability across different services within your Azure Spring Apps ecosystem
Azure Spring Apps provides incredible flexibility when it comes to configuring monitoring agents for your applications. Determine if you want to use Azure's Application Insights Java agent or a partner solution such as Dynatrace, AppDynamics, New Relic etc.
Alerts
Azure Spring Apps allows using alert pipelines comprising of Action Groups and Alert Rules to monitor resources based on a variety of metrics such as storage, rate of requests and data usage
Service Discovery
Azure Spring Apps provides options to greatly minimize manual effort to discover and register your spring app services. Instrument your apps using the recommendations below so that Azure Spring Apps can maintain a list of live apps to call, route and load balance requests.
Health Probes
Azure Spring Apps allows you to create Readiness, Liveness and Startup probes offering default health probe rules for every application. Make sure to review how health probes are set up for your apps to ensure graceful termination in case of failures.
Redundancy
Determine if your applications can benefit from using the zone redunant feature that are available as part of the standard and enterprise tiers.

[!NOTE]

Zone redundancy can be applied only when you create a new Azure Spring Apps Service instance.
While Azure Spring Apps does not provide region redundancy out of the box, Azure Spring Apps can be deployed in paired regions along with cross-region traffic routing using Azure Traffic Manger or Azure Front Door. Determine of your application will benefit from using geo-redundancy and ensure to choose a region that supports Azure Spring Apps zone redundancy.

Scalability
Consider your application's performance needs while choosing between manual scaling and autoscaling.
Tier Offerings
Azure Spring Apps provides three tiers - Basic Tier for Dev/Test workloads, Standard Tier for general purpose production workloads and Enterprise Tier for production workloads that can take advantage of VMWare Tanzu components
Enterprise Tier also comes with VMWare Spring Runtime Support
Application-specific considerations
As you prepare to deploy spring applications to Azure Spring Apps, ensure that the below application specific considerations are being addressed -

Java Runtime version
Spring Boot/Spring Cloud version
Dependencies
Design Recommendations
Workload Management and Monitoring
Metrics
Azure Monitor Metrics is a feature of Azure Monitor that collects numeric data from monitored resources into a time-series database. Metrics are numerical values that are collected at regular intervals and describe some aspect of a system at a particular time.
Metrics allow for near-real time insights unlike logs. Azure Spring Apps.
In Azure Spring Apps two viewpoints for metrics can be leveraged:
Charts in each application overview page
Common metrics page
Metrics can also be queried from Log Analytics in the AzureMetrics table.
Logs
Use the Diagnostics setting page within Azure Spring Apps to configure the desired combination of diagnostic setting for your apps.
Note that there is a delay of upto 15 minutes for logs to appear in your storage account, your event hub, or Log Analytics. If the Spring app instances are deleted or moved in the interim, the diagnostic settings should be deleted too to ensure that another app with the same resource id does not reuse the same diagnostic setting.
Azure Spring Apps allows you to collect Spring Cloud Resilience4j metrics into Application Insights.
Enable the Java In-Process agent and configure dimension collection for resilience4j metrics within Application Insights which will then allow you to view resilience4j metrics with Azure Spring Apps.
Distributed Tracing
Use Application Insights created by Azure Spring Apps
The Application Map blade in App Insights showcases all the dependencies and traces.
Use the Performance/Dependencies/Exception blades to dive deeper into issues or view parts of the application that can be potential bottlenecks.
Use the End-to-end transaction details to view the end to end transactions.
Azure Spring Apps integrates Spring Cloud Sleuth and Zipkin with Application Insights.
Service Discovery
For Standard Tier, Azure Spring Apps provides two options to quickly discover and register app instances.
Kubernetes Service Discovery
Azure Spring Apps automatically creates a corresponding Kubernetes service for each app with the app name acting as the Kubernetes Service name. Apps can call then call another apps using the service name
Managed Spring Cloud Service Registry (using Eureka)
You can configure your applications (via annotations) which then gets picked up by the Spring Cloud Service Registry server to maintain a list of live apps.
Enterprise Tier provides the Tanzu Service Registry which uses annotations to identify applications that are discovered and registered as services which can then be called by other apps/services.
Health Probes
Always use the readiness and liveness probes together so that apps are removed from Kubernetes Service Discovery as well as Managed Service Discovery using Eureka
If you have an app that has a longer startup time, make sure to adjust the total timeout i.e. initialDelaySeconds + periodSeconds * failureThreshold to a value longer than the start time of your application. This will help avoid the probe to fail and hence force the app to restart
For Spring Boot applications, you can take advantage of Actuator health indicators to configure your health probes.
Redundancy
Select the zone-redunant option when you create a new Azure Spring Apps instance to ensure that your apps are deployed across multiple availability zones
If your application needs to be redundant across regions, deploy the solution in more than one region and use Traffic Manager or Azure Front Door to balance load between these deployments.
If your application spans geographies, consider deploying to a single region in each applicable geography and use Traffic Manager or Azure Front Door to provide geography-based routing. This will provide enhanced performance and increased redundancy.
If you need to recover from a disaster, consider if redeploying the application from a CI/CD process would be adequate. Also consider that a webspring app is a component in a larger solution, and you will need to consider the DR processes for the other components in the solution.
Scalability
Azure Spring Apps provides autoscaling cpabilities out of the box, allowing apps to scale based on metric thresholds or during a specific time window. Autoscaling is recommended when apps need to scale up or scale out in response to changing demand.
Azure Spring Apps also supports scaling your applications manually using the following attribute - CPU, Memory/GB per instance and App instance counts. Think of this as a one time manual scaling activity that you may want to perform for certain apps. Ensure you adjust these parameters based on your application's scaling needs while also understanding the maximum limits supported by each of these attributes. Note that this feature is different from the manual scale option that is available as part of the auto scale setting.