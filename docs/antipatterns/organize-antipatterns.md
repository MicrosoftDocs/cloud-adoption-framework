---
title: "Cloud organizational Antipatterns"
description: Many companies still treat the IT department as a cost center.
author: sarahwendel
ms.author: brblanch
ms.date: 01/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: organize
ms.custom: think-tank
---

# Organizational Antipatterns

Customers frequently experience a number of common cloud adoption antipatterns within their organizational structure. This can be attributed to misalignment of the IT department, the tool set, partners or engineers. It's important to understand the role each of these play in a successful cloud adoption scenario.

## Antipattern: Treat the IT department as a cost center

Many companies still treat the IT department as a cost center. This can easily lead to the perception that the IT department does not offer any (additional) value to the company. Meaning the role of the IT is rather seen as a provider than an enabler. This view on the IT can lead to discouraged employees and the inability to attract the right talent for the company. Eventually, this leads to reduced motivation, long life-cycle times, low-quality inside the IT department and development of [silos and fiefdoms](../organize/fiefdoms-silos.md).

### Example of this antipattern

AdventureWorks manages their IT department as a cost center and therefore is under the responsibility of the CFO. The perception inside the managing board is, that the IT is very slow in providing services whilst being one of the biggest cost drivers. However, the managing board is unaware that Business Unit "Mobility" is consuming most of the IT assets, that have been procured by the IT department. Since the IT has purchased the datacenter anyway, the Business unit gets oversized assets and IT is perceived as an executer rather than an enabler or partner.

### Preferred outcome: IT as an enabler

Instead of managing the IT department as a cost center, consider using the approaches of [Chargeback](../strategy/cloud-accounting.md) and [Showback or awareness-back](../strategy/cloud-accounting.md). Companies can use the cloud as a tool to increase cost and business transparency. With the implementation of the [Cost Management Discipline](../govern/cost-management/index.md) the IT can increase cost transparency, which leads to more awareness of the cost of different business units as well as appreciation of the IT department as an enabler for different business units.

Additionally, concepts like [cost-conscious organization](../organize/cost-conscious-organization.md) help to increase Visibility, Accountability and Optimization throughout the whole company leading to a better overall awareness transparency.

## Antipattern: Investing in developing new platforms without involving the business

IT departments often invest significant human and financial resources in building and deploying robust platforms and tool sets. However, often the business units and their needs are not involved in the design or development process. This leads to new platforms with minimal relevance for the business (unit) and eventually the platforms or tool sets end up having poor or slow adoption.

### Example of an investment antipattern

The IT department of A. Datum Corp. has setup an Azure platform without involving the business units. Whilst using the (by the IT customized) platform, the business unit developers realize that they don’t have the required permission to deploy and are restricted in the services that they can use for their use case. This results in emerging support tickets, long approval cycles that end up raising doubts in the platform or concept.  In the end, some developers decided to purchase an Azure subscription by themselves to avoid having to deal with the rules and regulations of the IT. This leads to Shadow IT within the company that is not controllable and eventually results in high security risks.

### Preferred outcome: integration of business units in decision making

IT departments should avoid the creation or building of [IT-silos](../organize/fiefdoms-silos.md) in the process of deploying an enterprise ready cloud platform. Developers as well as technical decisions makers (TDMs) in the business unit should be integrated in the design and development process to ensure increased adoption and make their voices heard.

Reference implementations like [Enterprise-Scale](../ready/enterprise-scale/index.md) help companies to increase the speed of adoption based on Microsoft best practices. Those best practices already include certain design principles that are tailored towards developers. It’s a definite goal of the concept to identify and define the right balance between agility and flexibility. For example, developers on the one hand and rules and regulations provided by the governance and platform team on the other hand.

## Antipattern: Outsourcing of core business function

Using consulting partners and managed service providers (MSPs) is important along the cloud journey, but companies should watch out to not get into a position where the work of their partners creates the most value for the company’s business. When companies already outsource a lot of responsibilities to either the MSP or the cloud provider, they should draw a line to not be completely dependent to either of them.

### Example of outsourcing of core business function antipattern

Trey Research have worked with an MSP along their cloud journey. As the migration project was timely critical, they chose the MSP to build up their Azure Foundation as well as doing the migration. This led to a very fast cloud adoption journey, but instead of learning and building up skills themselves within the cloud adoption phase, they chose to hand over all Azure responsibility to their MSP. As Trey Research has no cloud nor Azure knowledge the MSP took and still takes the lead on all decisions. Leading to a dependence on the MSP.

### Preferred outcome: critical design areas are the company's responsibility

Outsourcing is a good cost cutting strategy, but the following critical design areas should remain in the company's responsibility as well as should be decided by the company: Governance, Risk, Compliance, and Identity. These areas are critical to the company’s security estate and therefore should be in the own responsibility. External partners could and should be used to speed up the adoption journey, but not everything should be outsourced in order to stay independent.

## Antipattern: Concentration on technical decision maker rather than developing cloud engineers

Finding the right personal is quite important for companies these days. Companies tend to hire or build up Technical decision managers within the first phases of the cloud adoption journey. But within the cloud space a successful cloud journey relies not only on TDMs but mostly on cloud engineers with their “all hands-on deck” mentality and deep technical skills.

### Example of cloud engineering antipattern

Trey Research has hired several technical decision makers (TDM) to lead the cloud journey for the company. After the initial high level concept phase for the cloud ended, they realize that once they started with the implementation, that cloud deployments behave quite different compared to on-premises. Additional (cloud) engineering effort was needed to properly implement the concepts of Infrastructure as Code (IaC) as well as Policy-Driven governance.

### Preferred outcome: capable cloud engineers

Whilst “as a Service” models have a big shift when it comes to responsibility and tasks, engineers are essential to implement proper cloud automation and landing zone concepts. Even though the cloud can help you increase the speed of going into production due to shifted responsibilities to the cloud provider, certain task requires deep engineering knowledge to leverage the advantages that the cloud provides. This can only be done by capable cloud engineers. This does not interfere with the need to have technical decision managers that take the right decisions.

## Next steps

- [Align responsibilities across teams](../organize/raci-alignment.md)
- [Organizational antipatterns: Silos and fiefdoms](../organize/fiefdoms-silos.md)
- [Build a cost-conscious organization](../organize/cost-conscious-organization.md)
