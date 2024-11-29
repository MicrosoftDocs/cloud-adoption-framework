---
title: Resiliency
description: Learn how to design your cloud infrastructure with resilience in mind to minimize the impact of disruptions, maintaining continuity and reliability for your business operations.
ms.author: tozimmergren
author: Zimmergren
ms.topic: conceptual
ms.date: 11/21/2024
---

# Resiliency

Resilience is the ability of your infrastructure to maintain functionality and availability despite disruptions or failures and is a cornerstone of any successful cloud adoption strategy.  Design your cloud infrastructure with resilience in mind to minimize the impact of disruptions, maintaining continuity and reliability for your business operations.

Consider that the more tightly integrated your business is with your technology, the more important the resiliency of that technology is.

If a system supports a key process or is critical to your business operations, any downtime can lead to significant financial losses, resource drain, or even a complete halt to your business activities.

## Plan for the unexpected

In a modern landscape where downtime can lead to significant financial losses and damage to reputation, resilience is a necessity for many organizations. Whether it’s due to natural disasters, cyber-attacks, or system failures, disruption can happen unexpectedly at any time.

Resilience is about ensuring that your cloud infrastructure and applications are robust enough to handle these challenges, minimize downtime, and preserve the integrity of your services and data.  

Typically, not all systems require the same level of resilience in your business. You might consider offering flexibility in choosing resiliency levels within your business, allowing you to focus on resilience investments where it matters most.

It also enables your organization to maintain business continuity, meet regulatory requirements, and enhance customer trust by ensuring that critical applications and services remain available when the unexpected happens.

## Understand the shared responsibility model

Resiliency is a joint responsibility between a cloud provider and its customers.  

The shared responsibility model defines the division of responsibilities and establishes boundaries for what the provider manages, like the core cloud infrastructure, and what the customer is responsible for, such as the security and configuration of their applications and data.

Documenting and understanding shared responsibility is crucial in your cloud adoption strategy because it ensures you understand your role in maintaining security, compliance, and reliability. By incorporating the shared responsibility model into your strategy, you can proactively address potential risks, ensure proper governance, and build a more robust cloud environment that aligns with organizational goals and regulatory requirements.

Ensuring system reliability on Azure is a shared responsibility between the customer and the cloud provider. Microsoft manages the *reliability of the cloud platform*, while customers and partners are *responsible for the reliability of their cloud applications and infrastructure deployments*.

:::image type="content" source="../media/placeholder-5.svg" alt-text="Diagram showing responsibility metrics.":::

## Empower your cloud adoption strategy

Integrating resilience into your cloud adoption strategy provides quality control as a competitive edge. By designing your architecture with resilience in mind, you can make sure your applications – and your business – are operational throughout a range of situations, including hardware or networking problems, or even the loss of a data center or entire cloud region. This strategic focus allows for more effective resource allocation, improved operational efficiency, and better risk management.

It can also facilitate the agile deployment of services, enabling your organization to quickly adjust to market demands while maintaining robust security and compliance postures.  

Ultimately, resilience is an essential component of your cloud adoption strategy in driving quality and innovation, and supporting long-term business objectives.

## Resiliency scenario examples

Here are a few examples of the importance of resiliency in a cloud adoption strategy, mapped to specific types of risk scenarios.

| Risk scenario | Risk impact | Resilience mitigation example |
| --- | --- | --- |
| *Cyber attacks* | Ransomware, Distributed Denial of Service (DDoS), or unauthorized access. | Robust security measures, including a proper backup and recovery process in your adoption strategy and plan can help reduce impact. |
| *System failures* | Hardware or software malfunctions. | Design for quick recovery and data integrity restoration. Handle transient faults in your applications, and provide redundancy in your infrastructure, such as multiple replicas with automatic failover. |
| *Configuration issues* | Deployment errors or misconfigurations | Treat configuration changes as code changes with Infrastructure as Code (IaC). Embrace Continuous Integration/Continuous Deployment (CI/CD) pipelines, canary deployments and rollback mechanisms minimize the impact of faulty updates or deployments. |
| *Demand spikes or overload* | Performance degradation during peak usage or spikes in traffic | Elastic scalability to ensure systems auto-scale to handle an increased demand without disruption to service. |
| *Compliance failures* | Breaches of regulatory standards | Adopt compliance tools such as Microsoft Purview and use Azure Policy to enforce compliance requirements. |
| *Natural disasters* | Data center outages due to earthquakes, floods, or storms. | Plan for failover, high availability, and disaster recovery by using availability zones, multiple regions, or even multi-cloud approaches. |

**Recommendations:**

Follow these recommendations to inform your cloud adoption strategy of resilience considerations. 

- *Perform a business impact analysis (BIA)*: Define the criticality of various systems and applications to help prioritize resource and recovery efforts. Do this iteratively throughout your cloud adoption journey.
- *Risk assessment*: Identify potential threats and vulnerabilities that could impact your cloud infrastructure and use this to build mitigation strategies and inform your resilience and reliability plans.
- *Cost-benefit analysis*: Map out and understand how investments in your cloud adoption are aligned with business continuity requirements and SLAs.
- *Understand shared responsibility*: Ensure your strategy team includes details about the shared responsibility model in the cloud, including what it means for reliability. For more information, see [reliability requirements](/azure/reliability/overview#reliability-requirements).
- *Understand Azure reliability*: Use the [Azure reliability documentation](/azure/reliability/overview) to build a better understanding of how reliability and resiliency works in Azure.
- *Azure services reliability capabilities*: Explore the [Azure service reliability guides](/azure/reliability/overview-reliability-guidance) to inform your adoption strategy about reliability capabilities for specific Azure services.
- *Recovery objectives*: Build an understanding of [Recovery Time Objectives (RTO) and Recovery Point Objectives (RPO)](/azure/reliability/overview#rto-and-rpo-) as part of your cloud adoption strategy to understand downtime and data loss limits for your systems.
- *Define realistic reliability targets*: Set realistic expectations with your internal stakeholders about reliability and use contractual agreements to communicate those expectations to customers. See Azure Well-Architected Framework's [Recommendations for defining reliability targets](/azure/well-architected/reliability/metrics).

## Next steps

> [!div class="nextstepaction"]
> [AI](ai.md)
