---
title: Assess cloud risks
description: Learn how to assess cloud risks effectively with our comprehensive guide. Dive into the essentials of cloud governance and risk management within Microsoft's Govern methodology for Azure. This article provides a step-by-step approach to identify, prioritize, and mitigate cloud risks. Discover best practices for cloud risk assessment tools, techniques, and strategies to protect your digital assets. Perfect for organizations using the cloud, seeking to set up and maintain the cloud governance approach.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/05/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Assess cloud risks

This article outlines the approach to assess risks associated with the cloud. All technologies introduce certain risks to an organization. Risks are undesired outcomes that could affect your business, such as noncompliance with industry standards. When adopting the cloud, you need to identify the risks the cloud poses to your organization so the cloud governance team can create cloud governance policies to manage those risks.

:::image type="content" source="./_images/assess.svg" alt-text="Diagram showing the process to set up and maintain cloud governance. The diagram shows five sequential steps: build a cloud governance team, document cloud governance policies, enforce cloud governance policies, and monitor cloud governance. The first step you perform once. The last four steps you perform once to set up cloud governance and continuously to maintain cloud governance." lightbox="./_images/assess.svg" border="false":::

## Identify cloud risks

Catalog a comprehensive list of cloud risks. Knowing your risks allows you to create governance policies that effectively mitigate cloud risks. To identify cloud risks, follow these recommendations:

- *Catalog all cloud assets.* List all your cloud assets so you can comprehensively identify risks. For example, you can use the Azure portal, Azure Resource Graph, PowerShell, and Azure CLI to view all resources in a subscription.

- *Discover cloud risks.* Start with high-priority risks and develop the list over time. Common categories of risk are regulatory compliance, security, operations, cost, data, resources, and AI. Include risks that are unique to your organization, such non-Microsoft software, partner or vendor support, and internal cloud competencies.

- *Involve key stakeholders.* Gather input from diverse organizational roles—IT, security, legal, finance, and business units—to consider all potential risks. This collaborative approach guarantees a holistic view of risks related to the cloud.

### Azure facilitation: Identifying cloud risks

The following guidance is meant to help you identify cloud risks in Azure. It provides a sample starting point for major categories of cloud governance. Azure can help automate part of the process of finding risks. Use tools such as Azure Advisor, Microsoft Defender for Cloud, Azure Policy, Azure Service Health, and Microsoft Purview.

- *Identify cloud regulatory compliance risks.* Identify risks of noncompliance with legal and regulatory frameworks affecting cloud data and operations. Know the regulatory requirements of your industry. Use the Azure compliance documentation to start.

- *Identify cloud security risks.* Identify threats and vulnerabilities that jeopardize the confidentiality, integrity, and availability of the cloud environment. Use Azure to assess your [cloud security posture](/azure/defender-for-cloud/concept-cloud-security-posture-management) and detect [identity risks](/entra/id-protection/overview-identity-protection).

- *Identify cloud cost risks.* Identify risks related to the costs of cloud resources. Cost-related risks include overprovisioning, underprovisioning, underutilization, and unexpected costs from data transfer fees or service scaling. Use a [cost assessment](/assessments/ad1c0f6b-396b-44a4-924b-7a4c778a13d3/) to identify cost risk. Use Azure to estimate costs with the [Azure pricing calculator](/azure/cost-management-billing/costs/pricing-calculator). [Analyze and forecast](/azure/cost-management-billing/costs/quick-acm-cost-analysis) costs on current resources. Identify [unexpected changes](/azure/cost-management-billing/understand/analyze-unexpected-charges) in cloud costs.

- *Identify cloud operations risks.* Identify risks that threaten the continuity of cloud operations, such as downtime and data loss. Use Azure to identify risks to [reliability and performance](/azure/advisor/advisor-overview).

- *Identify cloud data risks.* Identify risks related to data management within the cloud. Consider improper handling of data and flaws in data lifecycle management. Use Azure tools to help [identify data risks](/purview/purview-compliance) and [explore risks to sensitive data](/azure/defender-for-cloud/data-security-review-risks).

- *Identify cloud resource management risks.* Identify risks stemming from the provisioning, deployment, configuration, and management of cloud resources. Identify risks to [operational excellence](/azure/advisor/advisor-overview).

- *Identify AI risks.* Regularly [red team large language models](/azure/ai-services/openai/concepts/red-teaming)*.* Facilitate test by using [automated risk identification tools for AI](https://github.com/Azure/PyRIT#python-risk-identification-tool-for-generative-ai-pyrit). Look for common [human-AI interaction failures](https://www.microsoft.com/en-us/haxtoolkit/playbook/). Consider risks associated with use, access, and output. Review the tenets of [responsible AI](https://www.microsoft.com/ai/responsible-ai) and the responsible AI [maturity model](https://www.microsoft.com/research/publication/responsible-ai-maturity-model/).

## Analyze cloud risks

Assign a qualitative or quantitative ranking to each risk so you can prioritize them by severity. Risk prioritization combines risk probability and risk impact. Prefer quantitative risk analysis over qualitative for more precise risk prioritization. To analyze cloud risks, follow these strategies:

### Evaluate risk probability

Estimate the quantitative or qualitative probability of each risk occurring per year. A percentage range is a common way to represent quantitative risk probability (0%-100%). Low, medium, and high are common labels for qualitative risk probability. To evaluate risk probability, follow these recommendations:

- *Use public benchmarks.* Use data from reports, studies, or service level agreements that document common risks and their occurrence rates.

- *Analyze historical data.* Look at internal incident reports, audit logs, and other records to identify how often similar risks occurred in the past.

- *Test control effectiveness.* Assess the effectiveness of current risk-mitigation controls to minimize risks. Consider reviewing control testing results, audit findings, and performance metrics.

### Determine risk impact

Estimate the quantitative or qualitative impact of the risk occurring on the organization. A dollar amount is a common way to represent quantitative risk impact. Low, medium, and high are common labels for qualitative risk impact. To determine risk impact, follow these recommendations:

- *Conduct financial analysis.* Calculate potential financial loss by looking at factors such as cost of downtime, legal fees, fines, and the cost of remediation efforts.

- *Conduct reputational impact assessment.* Use surveys, market research, or historical data on similar incidents to estimate the potential impact on the organization's reputation.

- *Conduct operational disruption analysis.* Assess the extent of operational disruption by estimating downtime, loss of productivity, and the cost of alternative arrangements.

- *Assess legal implications.* Estimate potential legal costs, fines, and penalties associated with noncompliance or breaches.

### Calculate risk priority

Assign a risk priority to each risk. Risk priority is the importance you assign to a risk so you know whether to treat the risk with high, medium, or low urgency. The governance team must use a consistent methodology across the organization. To calculate risk priority, follow these recommendations:

- *Use a risk matrix for qualitative assessments.* Create a matrix to assign a qualitative risk priority to each risk. One axis of the matrix represents risk probability and the other represents risk impact.

- *Use formulas for quantitative assessments*. A simple model could be *risk priority = risk probability x risk impact.*

### Assign a risk level

Categorize each risk into one of three levels: major risks (level 1), subrisks (level 2), and risk drivers (level 3). Risk levels allow you to plan an appropriate risk management strategy and anticipate future challenges. Level 1 risks threaten the organization or technology. Level 2 risks fall under the level 1 risk. Level 3 risks are trends that could potentially culminate in one or more level 1 or level 2 risks. For example, consider noncompliance with data protection laws (level 1), improper cloud storage configurations (level 2), and increasing complexity of regulatory requirements (level 3).

### Determine risk management strategy

For each risk, identify appropriate risk treatment options, such as avoiding, mitigating, transferring, or accepting the risk. Provide an explanation of the choice. For example, if you decide to accept a risk because the cost of mitigating it's too expensive, you should document that reasoning for reference.

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
- *Risk level:* Categorize risk as major threat (level 1), subrisk (level 2), or risk driver (level 3).
- *Risk management strategy:* The approach to manage the risk such as mitigate, accept, avoid.
- *Risk management enforcement:* The techniques to enforce the risk management strategy.
- *Risk owner:* The individual on the cloud governance team managing the risk.
- *Risk closure date:* A date when the risk management strategy should be applied.

For more information, see [Risk list example](#example-risk-list).

## Communicate cloud risks

Clearly convey identified cloud risks to the executive sponsor and executive-level management. The goal is to ensure the organization prioritizes cloud risks. Provide regular updates on cloud risk management and communicate when you need extra resources to manage risks. Promote a culture where managing cloud risks management and governance is a part of daily operations.

## Example risk list

The risk list is an example that you should tailor to fit the specific needs and context of your organization's Azure cloud environment. Regularly updating the risk list (risk register) and reviewing it with stakeholders is crucial for effective cloud governance.

|Risk ID|Risk management status|Risk category|Risk description|Risk probability|Risk impact|Risk priority|Risk level|Risk management strategy|Risk management enforcement|Risk owner|Risk closure date|
|---|---|---|---|---|---|---|---|---|---|---|---|
|R01|Open|Regulatory compliance|Noncompliance with sensitive data requirements.|20% OR Medium|$100,000 OR High|$20,000 OR High|Level 2|Mitigate|Use Microsoft Purview for sensitive data monitoring. <br> Compliance reporting in Microsoft Purview|Compliance lead|2024-04-01|
|R02|Open|Security|Unauthorized access to cloud services.|30% OR High|$200,000 OR Very High|$60,000 OR Very High|Level 1|Mitigate|Microsoft Entra ID multifactor authentication. <br> Microsoft Entra ID Governance monthly access reviews.|Security lead|2024-03-15|
|R03|Open|Security|Insecure code management.|20% OR Medium|$150,000 OR High|$30,000 OR High|Level 2|Mitigate| Use defined code repository. <br> Use quarantine pattern for public libraries. |Developer lead|2024-03-30|
|R04|Open|Cost|Overspending on cloud services due to overprovisioning and lack of monitoring.|40% OR High|$50,000 OR Medium|$20,000 OR High|Level 2|Mitigate|Set budgets and alerts for workloads. <br>Review and apply Azure Advisor cost recommendations|Cost lead|2024-03-01|
|R05|Open|Operations|Service disruption due to Azure region outage|25% OR Medium|$150,000 OR High|$37,500 OR High|Level 1|Mitigate|Mission-critical workloads have active-active architecture. <br> Other workloads have active-passive architecture.|Operations lead|2024-03-20|
|R06|Open|Data|Loss of sensitive data due to improper encryption and data lifecycle management.|35% OR High|$250,000 OR Very High|$87,500 OR Very High|Level 1|Mitigate|Apply encryption in transit and at rest. <br> Establish data lifecycle policies using Azure tools.|Data lead|2024-04-10|
|R07|Open|Resource management|Misconfiguration of cloud resources leading to unauthorized access and data exposure.|30% OR High|$100,000 OR High|$30,000 OR High|Level 2|Mitigate|Use infrastructure as code (IaC). <br> Enforce tagging requirements using Azure Policy|Resource lead|2024-03-25|
|R08|Open|AI|AI model producing biased decisions due to unrepresentative training data.|15% OR Low|$200,000 OR High|$30,000 OR Medium|Level 3|Mitigate|Use content filtering mitigation techniques. <br>Red teaming AI models monthly|AI lead|2024-05-01|

## Next step

> [!div class="nextstepaction"]
> [Document cloud governance policies](document-cloud-governance-policies.md)
