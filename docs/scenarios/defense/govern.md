---
title: Govern for defense cloud adoption
description: Recommendations for cloud platform governance in a defense organization
author: stephen-sumner
ms.author: ssumner
ms.reviewer: ssumner
ms.date: 12/6/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---
# Govern for defense cloud adoption

The govern methodology focuses on the platform domain. It affects your workload cost management, security baseline, identity access roles, and resource consistency parameters.

:::image type="content" source="./images/platform.png" alt-text="Figure that shows a domain tracker. It shows mission, platform, and workload. Platform is highlighted to show we're in the platform domain of cloud adoption." border="false":::
*Figure 1: Domain tracker - platform domain*

Governance is a framework that aligns personnel, deployments, and budgets to a common initiative and prevents drift from that vision. It provides control over cloud environments and helps defense organizations meet mission objectives.

Defense organizations need governance to mitigate risks. Effective cost, security, and policy governance can streamline platform operations and provide a means to inherit these guardrails at the workload level. Without proper governance, significant management burdens and productivity limits will occur. A lack of governance also creates responsibility gaps, introduces security risks, and delays return on investments (ROIs) due to excessive deployment delays and rework.

To avoid some of these issues, it’s worth considering the following governance best practices.

## Evaluate roles and responsibilities

Mission owners need a responsibility model that accounts for every resource in the cloud before committing to a governance strategy. If available, mission owners should coordinate roles and responsibilities with the cloud broker strategy. If the cloud broker doesn't provide roles and responsibilities model, mission owners will need to establish governance functions.

Cloud adoption can change aspects of IT operations. These changes require a reevaluation of roles and responsibilities. The goal of the reevaluation is to avoid having multiple groups/personnel responsible for the same service while ensuring there are no responsibility gaps.

The following techniques can help avoid governance redundancies or gaps:

- ***Create a service dependency map***: A service dependency map is a document that lists all your IT services and the people responsible for them. To create a service dependency map, you should outline all the services that your organization provides and then identify the teams or individuals that are responsible for each of those services.
- ***Track those responsible, accountable, consulted, and informed (RACI)***: A RACI matrix defines levels of responsibility for a given service.  You should list who is responsible and accountable for each service and who should be consulted and informed in the decision-making process.

For more information, see [cloud governance functions](../../organize/cloud-governance.md).

## Automate compliance

Defense organizations have layers of compliance requirements to protect sensitive data and secrets. Governance is necessary to protect these assets, but it creates management burdens. Governance requires precision, repetition, and consistency, and these tasks automation performs much better than humans. Defense organizations should automate governance processes. It will improve operational efficiency and security and free defense personnel to focus on other priorities.

Azure simplifies many aspects of defense governance. Azure has an automated governance tool called Azure Policy that is built into the Azure platform. This tool keeps cloud environments in alignment with available policies, standards, and compliance requirements. It allows teams to automate compliance assessments and even remediation against pre-defined compliance standards.  

There are many built-in policies available in Azure that make governance automation easier. These built-in policies meet many government compliance requirements. They include NIST 800-53, NIST 800-171, CMMC 2.0, Impact-Level 4, Impact-Level 5, ISO 27001:2013, FedRAMP High, and others. There are also workbooks in Microsoft Sentinel that help you visualize compliance. Governance teams can use policies to enforce governance across cloud resources. Users select the desired policies and assign them to the proper scope of resources. Azure Policy also allows users to create and modify policies to meet different governance requirements.

These policies check the compliance of new deployments and existing resources against the policies put in place. New deployments that don’t meet a policy requirement won't deploy. Existing deployments that don’t meet governance policies will also be identified so teams can enforce compliance on every resource.

Policies in Azure create a firm guardrail and automate the bulk of governance tasks. In doing so, they mitigate risk and increase efficiency, helping mission owners achieve their mission objectives faster.

For more on governance automation, see

- [Security governance](../../secure/security-governance.md)
- [Overview of Azure Policy](/azure/governance/policy/)
- [Compliance in Azure](/azure/azure-government/documentation-government-plan-compliance)
- [Azure compliance standards](/azure/compliance/)
- [Governance visualization tool](https://aka.ms/alz/azgovviz)
- [Microsoft Sentinel workbooks](/azure/sentinel/top-workbooks)

## Create a cost governance strategy

Costs are a tangible indication of governance effectiveness. Charges should align with expectations and surprises on a bill mean the governance approach in place has gaps. Cost governance is about getting the most out of the resources needed and preventing resource deployments that aren't authorized.

Here are a few considerations when building a cost governance strategy:

**Know cost responsibility** - Resource consumption needs governance to optimize costs, avoid waste, and adhere to the allocated budget. Cost governance provides cost management techniques that allow you to predict, control, and correctly assign costs. Cost governance often has associated legal requirements. It's backed by laws that will initiate budget oversight committees to investigate and punish if there are infringements.

**Review billing** - Costs should be reviewed every billing cycle. More frequent reviews will yield better cost control. Regular cost reviews will help identify governance early on issues. It's recommended that cloud brokers and mission owners implement budgets and alerts based on the scope of interest. Budgets will help tracking spend and send alerts if spending thresholds are exceeding. Multiple thresholds can be set to ensure that budgets are informed in time.

**Cost security** - Poor cost governance creates security risks and limits the ability to meet mission objectives. Without cost governance, anyone could add extra cost to a bill by provisioning resources without permission. Services provisioned this way are easily overlooked and forgotten. Forgotten resources increase the attack surface and potential vulnerabilities in the cloud. Spending on unnecessary services not only creates risk, but it also steals funds from other priorities. Unexpected charges can be an indication of incorrect governance and require a review of the organization’s governance discipline.

**Trend analysis** - Conduct trend analysis to drive transparency and allows visibility into active resources and consumption. Anomalous spikes in resource spend and should be brought to the technical team for explanation. It could signal a new phase in operations or a governance gap. Flag and review any new charges or spikes in trends. This form of active cost management helps avoid waste and mitigates risk. Trend analysis can also help manage infrastructure and determine future priorities. Mission owners can see how much money is spent on a given capability. If the money spent doesn’t help meet mission objectives, the future of this resource or workload needs reevaluation.

For more information, see [cost governance](../../govern/cost-management/index.md) and [cost management & billing](/azure/cost-management-billing/cost-management-billing-overview).

## Create cost baselines

Workload cost governance begins with baseline estimates. Defense teams should perform a TCO estimate for each individual workload expected to be migrated to the cloud. Mission Owners need to monitor those cloud resources costs and manage their services appropriately to reach the desired outcomes. One benefit of the cloud is lower shared services fees. They tend to be a fraction of on-premises datacenter service fees.

Here are some practical steps to creating workload estimates:

**Start with the return on investment (ROI) of moving to the cloud** - To calculate the ROI of the cloud, mission owners need to determine the Total Cost of Ownership (TCO) for each individual workload transitioning to the cloud. Azure has a [TCO Calculator](https://azure.microsoft.com/pricing/tco/calculator/) that allows the Mission Owner to estimate cost per instance with several variables:

- Facilities (building, real estate)
- Electricity and cooling charges
- Network (internal and/or  external to the datacenter)
- Hardware (servers, racks, routers, disk storage)
- Licenses for both system and applications software
- Operations staff

Not all variables require entry, and some services can be difficult to estimate. Mission owners should determine the level of accuracy required to establish this baseline. Once a TCO estimate is created, mission owners should document this data for later analysis.

**Estimate monthly costs for required services** - The next step in establishing a workload cost baseline is to determine the estimated monthly costs for required services. Monthly estimates tie into budgets and budgets enable business forecasting. The resource organization capabilities in Azure facilitate budgets at different levels in an organization structure. Budgets can be applied at the Management Group, Subscription, or Resource Group level. Additional information on creating, monitoring, and updating budgets within Azure can be found in the Azure Cost Management & Billing documentation. The [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/) can help create monthly estimates and TCO calculator. These estimates should be run for each individual workload to be migrated. Once a monthly Azure workload estimate has been calculated, the mission owner should document this data into a repository or other tracking resource for later analysis. This location should be the same as the TCO estimate. For more information, see [cost tools](../../govern/cost-management/toolchain.md).

For more information on governance, see:

- [Governance guide](../../govern/guides/complex/index.md)
- [Governance disciplines](../../govern/governance-disciplines.md)

## Next step

After governance, cloud adoption moves into the workload domain and starts with the adopt methodology.

> [!div class="nextstepaction"]
> [Adopt](adopt.md)
