---
title: Specialized workloads for cloud management
description: Use the Cloud Adoption Framework for Azure to learn about specialized workload cloud management operations.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.localizationpriority: high
ms.custom: internal, fasttrack-edit, AQC
---

# Workload specialization for cloud management

Workload specialization builds on the concepts outlined in [Platform specialization](./platform-specialization.md).

![Beyond the cloud management baseline](../../_images/manage/beyond-the-baseline.png)

- **Workload operations:** The largest per-workload operations investment and highest degree of resiliency. We suggest workload operations for the approximately 20% of workloads that drive business value. This specialization is usually reserved for high criticality or mission-critical workloads.
- **Platform operations:** Operations investment is spread across many workloads. Resiliency improvements affect all workloads that use the defined platform. We suggest platform operations for the approximately 20% of platforms that have the highest criticality. This specialization is usually reserved for medium to high criticality workloads.
- **Enhanced management baseline:** The relatively lowest operations investment. This specialization slightly improves business commitments by using additional cloud-native operations tools and processes.

## High-level process

Workload specialization consists of a disciplined execution of the following four processes in an iterative approach. Each process is explained in more detail in [Platform specialization](./platform-specialization.md).

- **Improve system design:** Improve the design of a specific workload to effectively minimize interruptions.
- **Automate remediation:** Some improvements aren't cost effective. In such cases, it might make more sense to automate remediation and reduce the effect of interruptions.
- **Scale the solution:** As you improve systems design and automated remediation, you can scale those changes across the environment through the service catalog.
- **Continuous improvement:** You can use different monitoring tools to discover incremental improvements. These improvements can be addressed in the next pass of system design, automation, and scale.

## Cultural change

Workload specialization often triggers a cultural change in traditional IT build processes that focus on delivering a management baseline, enhanced baselines, and platform operations. Those types of offerings can be scaled across the environment. Workload specialization is similar in execution to platform specialization. But unlike common platforms, the specialization required by individual workloads often doesn't scale.

When workload specialization is required, operational management commonly evolves beyond a centralized IT perspective. The approach suggested in Cloud Adoption Framework is a distribution of cloud management functionality.

In this model, operational tasks like monitoring, deployment, DevOps, and other innovation-focused functions shift to an application-development or business-unit organization. The cloud platform team and the core cloud monitoring team still delivers on the management baseline across the environment.

Those centralized teams also guide and instruct workload-specialized teams on operations of their workloads. But the day-to-day operational responsibility falls on a cloud management team that is managed outside of IT. This type of distributed control is one of the primary indicators of maturity in a cloud center of excellence.

## Beyond platform specialization: Application Insights

Greater detail on the specific workload is required to provide clear workload operations. During the continuous improvement phase, Application Insights will be a necessary addition to the cloud management toolchain.

| Requirement                          | Tool                 | Purpose                                                                                |
| ------------------------------------ | -------------------- | -------------------------------------------------------------------------------------- |
| Application monitoring               | Application Insights | Monitoring and diagnostics for applications                                                    |
| Performance, availability, and usage | Application Insights | Advanced application monitoring with the application dashboard, composite maps, usage, and tracing |

### Deploy Application Insights

1. In the Azure portal, go to **Application Insights**.
1. Select **+ Add** to create an Application Insights resource to monitor your live web application.
1. Follow the on-screen prompts.

See the [Azure Monitor Application Insights hub](/azure/azure-monitor/azure-monitor-app-hub) for guidance on configuring your application for monitoring.

::: zone target="chromeless"

::: form action="OpenBlade[#create/Microsoft.AppInsights]" submitText="Create Application Insight resources" :::

::: zone-end

### Monitor performance, availability, and usage

1. In the Azure portal, search for **Application Insights**.
1. Choose one of the Application Insights resources from the list.

Application Insights contains different kinds of options for monitoring performance, availability, usage, and dependencies. Each of these views of the application data provides clarity into the continuous-improvement feedback loop.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Insights%2FComponents]" submitText="Monitor applications" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end
