---
title: Understand partnership and support options
description: Use the Cloud Adoption Framework for Azure to understand partnership options and approaches to supporting migration costs.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

<!-- cSpell:ignore CSPs MSPs -->

# Understand partnership and support options

During migration, the cloud adoption team performs the actual migration of workloads to the cloud. Unlike the collaborative and problem-solving tasks when defining the [digital estate](../../../digital-estate/index.md) or building the core cloud infrastructure, migration tends to be a series of repetitive execution tasks. Beyond the repetitive aspects, there are likely testing and tuning efforts that require deep knowledge of the chosen cloud provider. The repetitive nature of this process can sometimes be best addressed by a partner, reducing strain on full-time staff. Additionally, partners may be able to better align deep technical expertise when the repetitive processes encounter execution anomalies.

Partners tend to be closely aligned with a single cloud vendor or a small number of cloud vendors. To better illustrate partnership options, the remainder of this article assumes that Microsoft Azure is the chosen cloud provider.

During plan, build, or migrate, a company generally has four execution partnership options:

- **Guided self-service.** The existing technical team executes the migration, with help from Microsoft.
- **FastTrack for Azure.** Use the Microsoft FastTrack for Azure program to accelerate migration.
- **Solutions partner.** Get connected with Azure partners or cloud solution providers (CSPs) to accelerate migration.
- **Supported self-service.** Execution is completed by the existing technical staff with support from Microsoft.

## Guided self-service

If an organization is planning an Azure migration on its own, Microsoft is always there to assist throughout the journey. To help fast-track migration to Azure, Microsoft and its partners have developed an extensive set of architectures, guides, tools, and services to reduce risk and to speed migration of virtual machines, applications, and databases. These tools and services support a broad selection of operating systems, programming languages, frameworks, and databases.

- **Assessment and migration tools.** Azure provides a wide range of tools to be used in different phases for your cloud transformation, including assessing your existing infrastructure. For more information, refer to the "assess" section in the "migration" chapter that follows.
- [Microsoft Cloud Adoption Framework](../../index.md). This framework presents a structured approach to cloud adoption and migration. It is based on best practices across many Microsoft-supported customer engagements and is organized as a series of steps, from architecture and design to implementation. For each step, supporting guidance helps you with the design of your application architecture.
- [Cloud design patterns](/azure/architecture/patterns/). Azure provides some useful cloud design patterns for building reliable, scalable, secure workloads in the cloud. Each pattern describes the problem that the pattern addresses, considerations for applying the pattern, and an example based on Azure. Most of the patterns include code samples or snippets that show how to implement the pattern on Azure. However, they're relevant to any distributed system, whether hosted on Azure or on other cloud platforms.
- [Cloud fundamentals](/azure/architecture/guide/). Fundamentals help teach the basic approaches to implementation of core concepts. This guide helps technicians think about solutions that go beyond a single Azure service.
- [Example scenarios](/azure/architecture/browse/). The guide provides references from real customer implementations, outlining the tools, approaches, and processes that past customers have followed to accomplish specific business goals.
- [Reference architectures](/azure/architecture/browse/). Reference architectures are arranged by scenario, with related architectures grouped together. Each architecture includes best practices, along with considerations for scalability, availability, manageability, and security. Most also include a deployable solution.

## FastTrack for Azure

[FastTrack for Azure](https://azure.microsoft.com/programs/azure-fasttrack/) provides direct assistance from Azure engineers, working hand in hand with partners, to help customers build Azure solutions quickly and confidently. FastTrack brings best practices and tools from real customer experiences to guide customers from setup, configuration, and development to production of Azure solutions, including:

- Datacenter migration
- Windows Server on Azure
- Linux on Azure
- SAP on Azure
- Business continuity and disaster recovery (BCDR)
- High-performance computing
- Cloud-native applications
- DevOps
- Application modernization
- Cloud-scale analytics
- Intelligent applications
- Intelligent agents
- Data modernization to Azure
- Security and management
- Globally distributed data
- Azure Virtual Desktop
- Azure Marketplace
- Fundamentals and governance

During a typical FastTrack for Azure engagement, Microsoft helps to define the business vision to plan and develop Azure solutions successfully. The team assesses architectural needs and provides guidance, design principles, tools, and resources to help build, deploy, and manage Azure solutions. The team matches skilled partners for deployment services on request and periodically checks in to ensure that deployment is on track and to help remove blockers.

The main phases of a typical FastTrack for Azure engagement are:

- **Discovery.** Identify key stakeholders, understand the goal or vision for problems to be solved, and then assess architectural needs.
- **Solution enablement.** Learn design principles for building applications, review architecture of applications and solutions, and receive guidance and tools to drive proof-of-concept work through to production.
- **Continuous partnership.** Azure engineers and program managers check in every so often to ensure that deployment is on track and to help remove blockers.

## Microsoft Services offerings aligned to Cloud Adoption Framework approaches

![Microsoft Services Cloud Adoption Framework approach](../../../_images/migrate/mcs-program-approach.jpg)

**Assess:** Microsoft Services uses a [unified data- and tool-driven approach](https://download.microsoft.com/download/C/7/C/C7CEA89D-7BDB-4E08-B998-737C13107361/Secure_Cloud_Insights_Datasheet_EN_US.pdf) consisting of architectural workshops, Azure real-time information, security and identity threat models and various tools to provide insights into challenges, risks, recommendations and issues to an existing Azure environment with a key outcome such as [high-level modernization roadmap](https://download.microsoft.com/download/F/7/2/F72FAD7E-8BBD-4E04-8C7B-9AC4FE04A150/Cloud_Adoption_Discovery_and_Roadmap_Datasheet.pdf).

**Adopt:** Using the [Azure cloud foundation](https://download.microsoft.com/download/D/8/7/D872DFD0-1C46-4145-95E4-B5EAB2958B96/Hybrid_Cloud_Foundation_Datasheet_EN_US.pdf) from Microsoft Services, establish your core Azure designs, patterns and governance architecture by mapping your requirements to the most appropriate reference architecture and plan, design and deploy the infrastructure, management, security, and identity required for workloads.

**Migrate/optimize:** The [cloud modernization solution](https://download.microsoft.com/download/3/7/3/373F90E3-8568-44F3-B096-CD9C1CD28AB7/Cloud_Modernization_Datasheet_EN_US.pdf) from Microsoft Services offers a comprehensive approach to move applications and infrastructure to Azure, as well as to optimize and modernize after cloud deployment, backed by streamlined migration.

**Innovate:** The [cloud center of excellence (CCoE) solution](https://download.microsoft.com/download/F/8/B/F8BBE4BD-E5F8-4DFB-82F7-C0A4E17051BB/Cloud_Center_of_Excellence_Datasheet_EN_US.pdf) from Microsoft Services offers a DevOps coaching engagement and uses DevOps principles combined with prescriptive cloud-native service management and security controls to help drive business innovation, increase agility, and reduce time to value within a secure, predictable, and flexible services delivery and operations management capability.

## Azure Support

If you have questions or need help, [create a support request](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest). If your support request requires deep technical guidance, visit [Azure Support plans](https://azure.microsoft.com/support/plans/) to align the best plan for your needs.

## Azure solutions partner

Microsoft certified solution providers specialize in providing modern customer solutions based on Microsoft technologies across the world. Optimize your business in the cloud with help from an experienced partner.

Get help from partners with ready-made or custom Azure solutions and partners who can help deploy and manage those solutions:

- [Find a cloud solutions partner](https://www.microsoft.com/solution-providers/home). A certified CSP can help take full advantage of the cloud by assessing business goals for cloud adoption, identifying the right cloud solution that meets business needs and helps the business become more agile and efficient.
- [Find an Azure Expert Managed Service Provider (MSPs)](https://www.microsoft.com/azure/partners/azureexpertmsp?filters=all). MSPs help businesses transition to Azure by guiding all aspects of the cloud journey. From consulting to migrations and operations management, cloud MSPs show customers all the benefits that come with cloud adoption. They also act as a one-stop shop for common support, provisioning, and the billing experience, all with a flexible pay-as-you-go business model.

## Next steps

After a partner and support strategy is selected, the [release and iteration backlogs](./release-iteration-backlog.md) can be updated to reflect planned efforts and assignments.

> [!div class="nextstepaction"]
> [Manage change using release and iteration backlogs](./release-iteration-backlog.md)
