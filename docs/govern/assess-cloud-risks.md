---
title: Conduct a risk assessment
description: Learn how to conduct a risk assessment and catalog risks
author: stephen-sumner
ms.author: ssumner
ms.date: 04/01/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Assess cloud risks

This article outlines the approach to assess risks associated with the cloud. All technologies introduce certain risks to an organization. Risks are potential undesired outcomes that could affect your operations, such as non-compliance with industry standards. When adopting the cloud, you need to identify the risks the cloud poses to your organization so the cloud governance team can create cloud governance policies to manage those risks.

<img src="c:\GitHub\cloud-adoption-framework-pr\docs\govern/media/image3.png" style="width:6.5in;height:0.98889in" alt="A blue rectangle with white text Description automatically generated" />

## Identify cloud risks

Catalog a comprehensive list of cloud risks. Knowing your risks allows you to create governance policies that effectively mitigate cloud risks. To identify cloud risks, follow these recommendations:

- *Catalog all cloud assets.* List all your cloud assets so you can comprehensively identify risks. For example, you can use the Azure portal, Azure Resource Graph, PowerShell, and Azure CLI to view all resources in a subscription.

<!-- -->

- *Discover cloud risks.* Start with high-priority risks and develop the list over time. Common categories of risk are regulatory compliance, security, operations, cost, data, resources, and AI. Include those that are unique to your organization, such non-Microsoft software, partner or vendor support, and internal cloud competencies.

- *Involve key stakeholders.* Gather input from diverse organizational roles—IT, security, legal, finance, and business units—to consider all potential risks. This collaborative approach guarantees a holistic view of risks related to the cloud.

### Azure facilitation: Identifying cloud risks

The following guidance is meant to help you identify cloud risks in Azure. It provides a sample starting point for major categories of cloud governance. Azure can help automate part of the process of finding risks with tools such as Azure Advisor, Microsoft Defender for Cloud, Azure Policy, Azure Service Health, and Microsoft Purview.

- *Identify cloud regulatory compliance risks.* Identify risks of non-compliance with legal and regulatory frameworks affecting cloud data and operations. Know the regulatory requirements of your industry. Use the Azure compliance documentation to start.

- *Identify cloud security risks.* Identify threats and vulnerabilities that jeopardize the confidentiality, integrity, and availability of the cloud environment. Use Azure to assess your [cloud security posture](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-cloud-security-posture-management) and detect [identity risks](https://learn.microsoft.com/en-us/entra/id-protection/overview-identity-protection).

- *Identify cloud* *cost risks.* Identify risks related to the financial management of cloud resources, such as overprovisioning, underprovisioning, underutilization, and unexpected costs from data transfer fees or service scaling. Use a [cost assessment](https://learn.microsoft.com/en-us/assessments/ad1c0f6b-396b-44a4-924b-7a4c778a13d3/) to identify cost management risk. Use Azure to estimate costs with the [Azure pricing calculator](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/pricing-calculator). [Analyze and forecast](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/quick-acm-cost-analysis) costs on current resources. Identify [unexpected changes](https://learn.microsoft.com/en-us/azure/cost-management-billing/understand/analyze-unexpected-charges) in cloud costs.

- *Identify cloud operations risks.* Identify risks that threaten the continuity of cloud operations, such as downtime and data loss. Use Azure to identify risks to [reliability and performance](https://learn.microsoft.com/en-us/azure/advisor/advisor-overview).

- [Identify cloud data risks](https://ppc-word-edit.officeapps.live.com/we/wordeditorframe.aspx?ui=en-US&rs=en-US&wopisrc=https%3A%2F%2Fmicrosoft-my.sharepoint.com%2Fpersonal%2Fssumner_microsoft_com%2F_vti_bin%2Fwopi.ashx%2Ffiles%2F7740e4123e93454299433c7c8ed2ae4b&wdlor=c10849B9E-7989-4A04-A19A-2317C4D6D166&wdenableroaming=1&wdfr=1&mscc=1&wdodb=1&hid=824BBBF7-DC93-4220-9C2D-E538E27B48B3.0&uih=sharepointcom&wdlcid=en-US&jsapi=1&jsapiver=v2&corrid=17be43da-cf45-43e4-66cf-b27125506ab8&usid=17be43da-cf45-43e4-66cf-b27125506ab8&newsession=1&sftc=1&uihit=docaspx&muv=1&cac=1&sams=1&mtf=1&sfp=1&sdp=1&hch=1&hwfh=1&dchat=1&sc=%7B%22pmo%22%3A%22https%3A%2F%2Fmicrosoft-my.sharepoint.com%22%2C%22pmshare%22%3Atrue%7D&ctp=LeastProtected&rct=Normal&wdorigin=Outlook-Body.Sharing.ServerTransfer&wdhostclicktime=1709846847570&instantedit=1&wopicomplete=1&wdredirectionreason=Unified_SingleFlush#_Identify_data_risks)*.* Identify risks related to data management within the cloud. Consider improper handling of data and flaws in data lifecycle management. Use Azure tools to help [identify data risks](https://learn.microsoft.com/en-us/purview/purview-compliance) and [explore risks to sensitive data](https://learn.microsoft.com/en-us/azure/defender-for-cloud/data-security-review-risks).

- *Identify cloud resource management risks.* Identify risks stemming from the provisioning, deployment, configuration, and management of cloud resources. Identify risks to [operational excellence](https://learn.microsoft.com/en-us/azure/advisor/advisor-overview).

<!-- -->

- *Identify AI risks.* Regularly [red team large language models](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/red-teaming)*.* Facilitate test by using [automated risk identification tools for AI](https://github.com/Azure/PyRIT#python-risk-identification-tool-for-generative-ai-pyrit). Look for common [human-AI interaction failures](https://www.microsoft.com/en-us/haxtoolkit/playbook/). Consider risks associated with use and access, intellectual property rights, model biases, output accuracy and consistency, data sovereignty, and regulated data usage. Review the tenets of [responsible AI](https://www.microsoft.com/en-us/ai/responsible-ai) and the responsible AI [maturity model](https://www.microsoft.com/en-us/research/publication/responsible-ai-maturity-model/).

## Analyze cloud risks

Assign a qualitative or quantitative ranking to each risk so you can prioritize them by severity. Risk prioritization combines risk probability and risk impact. Prefer quantitative risk analysis over qualitative for more precise risk prioritization. To analyze cloud risks, follow these strategies:

### Evaluate risk probability

Estimate the quantitative or qualitative probability of each risk occurring per year. A percentage range is a common way to represent quantitative risk probability (0%-100%). Low, medium, and high are common labels for qualitative risk probability. To evaluate risk probability, follow these recommendations:

- *Use public benchmarks.* Use data from reports, studies, or service level agreements that document common risks and their occurrence rates.

- *Analyze historical data.* Look at internal incident reports, audit logs, and other records to identify how often similar risks occurred in the past.

- *Test control effectiveness.* Assess the effectiveness of current controls in place to minimize risks. Consider reviewing control testing results, audit findings, and performance metrics.

### Determine risk impact

Estimate the quantitative or qualitative impact of the risk occurring on the organization. A dollar amount is a common way to represent quantitative risk impact. Low, medium, and high are common labels for qualitative risk impact. To determine risk impact, follow these recommendations:

- *Conduct financial analysis.* Calculate potential financial loss by looking at factors such as cost of downtime, legal fees, fines, and the cost of remediation efforts.

<!-- -->

- *Conduct reputational impact assessment.* Use surveys, market research, or historical data on similar incidents to estimate the potential impact on the organization's reputation.

<!-- -->

- *Conduct operational disruption analysis.* Assess the extent of operational disruption by estimating downtime, loss of productivity, and the cost of alternative arrangements.

<!-- -->

- *Assess legal implications.* Estimate potential legal costs, fines, and penalties associated with non-compliance or breaches.

### Calculate risk priority

Assign a risk priority to each risk. Risk priority is the importance you assign to a risk so you know whether to treat the risk with high, medium, or low urgency. The governance team must use a consistent methodology across the organization. To calculate risk priority, follow these recommendations:

- *Use a risk matrix for qualitative assessments.* Create a matrix to assign a qualitative risk priority to each risk. One axis of the matrix represents risk probability and the other represents risk impact.

<!-- -->

- *Use formulas for quantitative assessments*. A simple model could be *risk priority = risk probability \* risk impact.*

### Assign a risk level

Categorize each risk into one of three levels: major risks (level 1), sub-risks (level 2), and risk drivers (level 3). Risk levels allow you to plan an appropriate risk management strategy and anticipate future challenges. Level 1 risks threaten the organization or technology. Level 2 risks fall under the level 1 risk. Level 3 risks are trends that could potentially culminate in one or more risks identified at the levels above. For example, non-compliance with data protection laws leading to legal issues (level 1), improper cloud storage configurations (level 2), and increasing complexity of regulatory requirements (level 3).

### Determine risk management strategy

For each risk, identify appropriate risk treatment options, such as avoiding, mitigating, transferring, or accepting the risk. Provide an explanation of the choice. For example, if you decide to accept a risk because the cost of mitigating it is too expensive, you should document that reasoning for reference.

### Assign risk owners

Designate a primary risk owner for every risk. The risk owner has the responsibility of managing each risk. This person coordinates the risk management strategy across every team involved and is the initial point of contact for risk escalation.

## Document cloud risks

Document each risk and the details of the risk analysis. Create a list of risks (risk register) that contains all the information you need to identify, categorize, prioritize, and manage risks. Develop standardized language for risk documentation so everyone can easily understand the cloud risks. Conduct monthly reviews and updates to reflect new risks that emerge as technology and business objectives evolve. Consider including these elements:

- *Risk ID:* A unique identifier for each risk.

- *Risk management status:* Status of the risk (open, closed).

- *Risk category:* A label such as regulatory compliance, security, cost, operations, AI, or resource management.

- *Risk description:* A brief description of the risk.

- *Risk probability:* The probability of the risk occurring per year. Use a percentage or qualitative label.

- *Risk impact:* Provide the risk impact on the organization if the risk occurs such as a dollar amount or qualitative label.

- *Risk priority:* Provide the risk probability (probability x impact). Use a dollar amount or qualitative label.

- *Risk level:* Categorize risk as major threat (level 1), sub-risk (level 2), or risk driver (level 3).

- *Risk management strategy:* The approach to manage the risk such as mitigate, accept, avoid.

- *Risk management enforcement:* The techniques to enforce the risk management strategy.

- *Risk owner:* The individual on the cloud governance team managing the risk.

- *Risk closure date:* A date when the risk management strategy should be applied.

For more information, see [Risk list example](https://ppc-word-edit.officeapps.live.com/we/wordeditorframe.aspx?ui=en-US&rs=en-US&wopisrc=https%3A%2F%2Fmicrosoft-my.sharepoint.com%2Fpersonal%2Fssumner_microsoft_com%2F_vti_bin%2Fwopi.ashx%2Ffiles%2F7740e4123e93454299433c7c8ed2ae4b&wdlor=c10849B9E-7989-4A04-A19A-2317C4D6D166&wdenableroaming=1&wdfr=1&mscc=1&wdodb=1&hid=824BBBF7-DC93-4220-9C2D-E538E27B48B3.0&uih=sharepointcom&wdlcid=en-US&jsapi=1&jsapiver=v2&corrid=17be43da-cf45-43e4-66cf-b27125506ab8&usid=17be43da-cf45-43e4-66cf-b27125506ab8&newsession=1&sftc=1&uihit=docaspx&muv=1&cac=1&sams=1&mtf=1&sfp=1&sdp=1&hch=1&hwfh=1&dchat=1&sc=%7B%22pmo%22%3A%22https%3A%2F%2Fmicrosoft-my.sharepoint.com%22%2C%22pmshare%22%3Atrue%7D&ctp=LeastProtected&rct=Normal&wdorigin=Outlook-Body.Sharing.ServerTransfer&wdhostclicktime=1709846847570&instantedit=1&wopicomplete=1&wdredirectionreason=Unified_SingleFlush#_Risk_register_example).

## Communicate cloud risks

Clearly convey identified cloud risks to the executive sponsor and executive-level management. The goal is to ensure the organization prioritizes cloud risks. Provide regular updates on cloud risk management and communicate when you need extra resources to manage risks. Promote a culture where managing cloud risks management and governance is a part of daily operations.

## Next step

The next step is to [document cloud governance policies](https://ppc-word-edit.officeapps.live.com/we/wordeditorframe.aspx?ui=en-US&rs=en-US&wopisrc=https%3A%2F%2Fmicrosoft-my.sharepoint.com%2Fpersonal%2Fssumner_microsoft_com%2F_vti_bin%2Fwopi.ashx%2Ffiles%2F7740e4123e93454299433c7c8ed2ae4b&wdlor=c10849B9E-7989-4A04-A19A-2317C4D6D166&wdenableroaming=1&wdfr=1&mscc=1&wdodb=1&hid=824BBBF7-DC93-4220-9C2D-E538E27B48B3.0&uih=sharepointcom&wdlcid=en-US&jsapi=1&jsapiver=v2&corrid=17be43da-cf45-43e4-66cf-b27125506ab8&usid=17be43da-cf45-43e4-66cf-b27125506ab8&newsession=1&sftc=1&uihit=docaspx&muv=1&cac=1&sams=1&mtf=1&sfp=1&sdp=1&hch=1&hwfh=1&dchat=1&sc=%7B%22pmo%22%3A%22https%3A%2F%2Fmicrosoft-my.sharepoint.com%22%2C%22pmshare%22%3Atrue%7D&ctp=LeastProtected&rct=Normal&wdorigin=Outlook-Body.Sharing.ServerTransfer&wdhostclicktime=1709846847570&instantedit=1&wopicomplete=1&wdredirectionreason=Unified_SingleFlush#_Document_cloud_governance). Documenting cloud governance policies uses the risk list to create one or more policies to manage each risk.

## Example: Risk list

The risk list is an example that you should tailor to fit the specific needs and context of your organization's Azure cloud environment. Regularly updating the risk list (risk register) and reviewing it with stakeholders is crucial for effective cloud governance.

<table>
<colgroup>
<col style="width: 3%" />
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 12%" />
<col style="width: 8%" />
<col style="width: 7%" />
<col style="width: 6%" />
<col style="width: 4%" />
<col style="width: 9%" />
<col style="width: 13%" />
<col style="width: 8%" />
<col style="width: 6%" />
</colgroup>
<thead>
<tr class="header">
<th><strong>Risk ID</strong></th>
<th><strong>Risk management status</strong></th>
<th><strong>Risk category</strong></th>
<th><strong>Risk description</strong></th>
<th><strong>Risk probability</strong></th>
<th><strong>Risk impact</strong></th>
<th><strong>Risk priority</strong></th>
<th><strong>Risk level</strong></th>
<th><strong>Risk management strategy</strong></th>
<th><strong>Risk management enforcement</strong></th>
<th><strong>Risk owner</strong></th>
<th><strong>Risk closure date</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>R01</td>
<td>Open</td>
<td>Regulatory compliance</td>
<td>Non-compliance with GDPR.</td>
<td>20% OR Medium</td>
<td>$100,000 OR High</td>
<td>$20,000 OR High</td>
<td>Level 2</td>
<td>Mitigate</td>
<td><p>Use Microsoft Purview GDPR monitoring.</p>
<p>Compliance reporting in Microsoft Purview</p></td>
<td>Compliance lead</td>
<td>2024-04-01</td>
</tr>
<tr class="even">
<td>R02</td>
<td>Open</td>
<td>Security</td>
<td>Unauthorized access to cloud services.</td>
<td>30% OR High</td>
<td>$200,000 OR Very High</td>
<td>$60,000 OR Very High</td>
<td>Level 1</td>
<td>Mitigate</td>
<td><p>Microsoft Entra ID multi-factor authentication.</p>
<p>Microsoft Entra ID Governance monthly access reviews.</p></td>
<td>Security lead</td>
<td>2024-03-15</td>
</tr>
<tr class="odd">
<td>R03</td>
<td>Open</td>
<td>Cost</td>
<td>Overspending on cloud services due to overprovisioning and lack of monitoring.</td>
<td>40% OR High</td>
<td>$50,000 OR Medium</td>
<td>$20,000 OR High</td>
<td>Level 2</td>
<td>Mitigate</td>
<td><p>Set budgets and alerts for workloads.</p>
<p>Review Azure Advisor cost recommendations</p></td>
<td>Cost lead</td>
<td>2024-03-01</td>
</tr>
<tr class="even">
<td>R04</td>
<td>Open</td>
<td>Operations</td>
<td>Service disruption due to Azure region outage</td>
<td>25% OR Medium</td>
<td>$150,000 OR High</td>
<td>$37,500 OR High</td>
<td>Level 1</td>
<td>Mitigate</td>
<td><p>Mission-critical workloads have active-active architecture</p>
<p>Active-passive architecture for non-mission-critical workloads</p></td>
<td>Operations lead</td>
<td>2024-03-20</td>
</tr>
<tr class="odd">
<td>R05</td>
<td>Open</td>
<td>Data</td>
<td>Loss of sensitive data</td>
<td>35% OR High</td>
<td>$250,000 OR Very High</td>
<td>$87,500 OR Very High</td>
<td>Level 1</td>
<td>Mitigate</td>
<td><p>Apply encryption in transit and at rest.</p>
<p>Establish data lifecycle policies using Azure tools.</p></td>
<td>Data lead</td>
<td>2024-04-10</td>
</tr>
<tr class="even">
<td>R06</td>
<td>Open</td>
<td>Resource management</td>
<td>Misconfiguration of cloud resources leading to unauthorized access and data exposure.</td>
<td>30% OR High</td>
<td>$100,000 OR High</td>
<td>$30,000 OR High</td>
<td>Level 2</td>
<td>Mitigate</td>
<td><p>Use infrastructure as code (IaC).</p>
<p>Enforce tagging requirements using Azure Policy</p></td>
<td>Resource lead</td>
<td>2024-03-25</td>
</tr>
<tr class="odd">
<td>R07</td>
<td>Open</td>
<td>AI</td>
<td>AI model producing biased decisions due to unrepresentative training data.</td>
<td>15% OR Low</td>
<td>$200,000 OR High</td>
<td>$30,000 OR Medium</td>
<td>Level 3</td>
<td>Mitigate</td>
<td><p>Use bias detection and mitigation techniques.</p>
<p>Red teaming AI models monthly</p></td>
<td>AI lead</td>
<td>2024-05-01</td>
</tr>
</tbody>
</table>

> [!div class="nextstepaction"]
> [Document cloud governance policies](document-cloud-governance-policies.md)