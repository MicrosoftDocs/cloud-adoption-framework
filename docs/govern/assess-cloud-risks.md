---
title: Assess cloud risks
description: Learn how to assess cloud risks effectively for cloud governance. Identify all risks. Assess, prioritize, and document cloud risks.
author: larzstridh
ms.author: pnp
ms.date: 05/22/2025
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Assess cloud risks

This article outlines how to assess risks associated with the cloud. All technologies introduce certain risks to an organization. Risks are undesired outcomes that could affect your business, such as noncompliance with industry standards. When adopting the cloud, you need to identify the risks the cloud poses to your organization. The cloud governance team creates cloud governance policies to prevent and mitigate those risks. To assess cloud risks, complete these tasks.

:::image type="content" source="./images/assess.svg" alt-text="Diagram showing the process to set up and maintain cloud governance. The diagram shows five sequential steps: build a cloud governance team, document cloud governance policies, enforce cloud governance policies, and monitor cloud governance. The first step you perform once. The last four steps you perform once to set up cloud governance and continuously to maintain cloud governance." lightbox="./images/assess.svg" border="false":::

## Identify cloud risks

Catalog a comprehensive list of cloud risks. Knowing your risks allows you to create cloud governance policies that can prevent and mitigate those risks. To identify cloud risks, follow these recommendations:

- *List all cloud assets.* List all your cloud assets so you can comprehensively identify the risks associated with them. For example, you can use the Azure portal, Azure Resource Graph, PowerShell, and Azure CLI to view all resources in a subscription.

- *Discover cloud risks.* Develop a stable risk catalog to guide cloud governance policies. To prevent frequent adjustments, focus on general cloud risks, not risks unique to a specific workload. Start with high-priority risks and develop a more comprehensive list over time. Common categories of risk are regulatory compliance, security, operations, cost, data, resources, and AI. Include risks that are unique to your organization, such non-Microsoft software, partner or vendor support, and internal cloud competencies.

- *Involve key stakeholders.* Gather input from diverse organizational roles (IT, security, legal, finance, and business units) to consider all potential risks. This collaborative approach ensures a holistic view of risks related to the cloud.

- *Verify risks.* Engage external experts who possess a deep understanding of cloud risk identification to review and validate your risk list. These experts could be Microsoft account teams or specialized Microsoft partners. Their expertise helps confirm the identification of all potential risks and enhances the accuracy of your risk assessment.

### Azure facilitation: Identifying cloud risks

The following guidance is meant to help you identify cloud risks in Azure. It provides a sample starting point for major categories of cloud governance. Azure can help automate part of the process of finding risks. Use Azure tools such as Azure Advisor, Microsoft Defender for Cloud, Azure Policy, Azure Service Health, and Microsoft Purview.

- *Identify regulatory compliance risks.* Identify risks of noncompliance with legal and regulatory frameworks affecting cloud data and operations. Know the regulatory requirements of your industry. Use the [Azure compliance documentation](/azure/compliance/) to start.

- *Identify security risks.* Identify threats and vulnerabilities that jeopardize the confidentiality, integrity, and availability of the cloud environment. Use Azure to assess your [cloud security posture](/azure/defender-for-cloud/concept-cloud-security-posture-management) and detect [identity risks](/entra/id-protection/overview-identity-protection).

- *Identify cost risks.* Identify risks related to the costs of cloud resources. Cost-related risks include overprovisioning, underprovisioning, underutilization, and unexpected costs from data transfer fees or service scaling. Use a [cost assessment](/assessments/ad1c0f6b-396b-44a4-924b-7a4c778a13d3/) to identify cost risk. Use Azure to estimate costs with the [Azure pricing calculator](/azure/cost-management-billing/costs/pricing-calculator). [Analyze and forecast](/azure/cost-management-billing/costs/quick-acm-cost-analysis) costs on current resources. Identify [unexpected changes](/azure/cost-management-billing/understand/analyze-unexpected-charges) in cloud costs.

- *Identify operations risks.* Identify risks that threaten the continuity of cloud operations, such as downtime and data loss. Use Azure tools to identify risks to [reliability and performance](/azure/advisor/advisor-overview).

- *Identify data risks.* Identify risks related to data management within the cloud. Consider improper handling of data and flaws in data lifecycle management. Use Azure tools to help [identify data risks](/purview/purview-compliance) and [explore risks to sensitive data](/azure/defender-for-cloud/data-security-review-risks).

- *Identify resource management risks.* Identify risks stemming from the provisioning, deployment, configuration, and management of cloud resources. Identify risks to [operational excellence](/azure/advisor/advisor-overview).

- *Identify AI risks.* Regularly [red team language models](/azure/ai-services/openai/concepts/red-teaming). Manually test AI systems and supplement manual tests with [automated risk identification tools for AI](https://github.com/Azure/PyRIT#python-risk-identification-tool-for-generative-ai-pyrit). Look for common [human-AI interaction failures](https://www.microsoft.com/en-us/haxtoolkit/playbook/). Consider risks associated with use, access, and output of AI systems. Review the tenets of [responsible AI](https://www.microsoft.com/ai/responsible-ai) and the responsible AI [maturity model](https://www.microsoft.com/research/publication/responsible-ai-maturity-model/).

## Analyze cloud risks

Assign a qualitative or quantitative ranking to each risk so you can prioritize them by severity. Risk prioritization combines risk probability and risk impact. Prefer quantitative risk analysis over qualitative for more precise risk prioritization. To analyze cloud risks, follow these strategies:

### Evaluate risk probability

Estimate the quantitative or qualitative probability of each risk occurring per year. Use a percentage range (0%-100%) to represent annual, quantitative risk probability. Low, medium, and high are common labels for qualitative risk probability. To evaluate risk probability, follow these recommendations:

- *Use public benchmarks.* Use data from reports, studies, or service-level agreements (SLAs) that document common risks and their occurrence rates.

- *Analyze historical data.* Look at internal incident reports, audit logs, and other records to identify how often similar risks occurred in the past.

- *Test control effectiveness.* To minimize risks, assess the effectiveness of current risk-mitigation controls. Consider reviewing control testing results, audit findings, and performance metrics.

### Determine risk impact

Estimate the quantitative or qualitative impact of the risk occurring on the organization. A monetary amount is a common way to represent quantitative risk impact. Low, medium, and high are common labels for qualitative risk impact. To determine risk impact, follow these recommendations:

- *Conduct financial analysis.* Estimate the potential financial loss of a risk by looking at factors such as the cost of downtime, legal fees, fines, and the cost of remediation efforts.

- *Conduct reputational impact assessment.* Use surveys, market research, or historical data on similar incidents to estimate the potential impact on the organization's reputation.

- *Conduct operational disruption analysis.* Assess the extent of operational disruption by estimating downtime, loss of productivity, and the cost of alternative arrangements.

- *Assess legal implications.* Estimate potential legal costs, fines, and penalties associated with noncompliance or breaches.

### Calculate risk priority

Assign a risk priority to each risk. Risk priority is the importance you assign to a risk so you know whether to treat the risk with high, medium, or low urgency. Risk impact is more important than risk probability since a high-impact risk can have lasting consequences. The governance team must use a consistent methodology across the organization to prioritize risk. To calculate risk priority, follow these recommendations:

- *Use a risk matrix for qualitative assessments.* Create a matrix to assign a qualitative risk priority to each risk. One axis of the matrix represents risk probability (high, medium, low) and the other represents risk impact (high, medium, low). The following table provides a sample risk matrix:

    |                      | Low impact      | Medium impact   | High impact     |
    |----------------------|-----------------|-----------------|-----------------|
    | **Low probability**  | Very low        | Moderately low  | Moderately high |
    | **Medium probability**| Low            | Medium          | High            |
    | **High probability** | Medium          | High            | Very high       |

- *Use formulas for quantitative assessments*. Use the following calculation as a baseline: *risk priority = risk probability x risk impact.* Adjust the weight of the variables as needed to tailor the risk priority results. For example, you could put more emphasis on the risk impact with this formula: *risk priority = risk probability x (risk impact x 1.5).*

### Assign a risk level

Categorize each risk into one of three levels: major risks (level 1), subrisks (level 2), and risk drivers (level 3). Risk levels allow you to plan an appropriate risk management strategy and anticipate future challenges. Level 1 risks threaten the organization or technology. Level 2 risks fall under the level 1 risk. Level 3 risks are trends that could potentially culminate in one or more level 1 or level 2 risks. For example, consider noncompliance with data protection laws (level 1), improper cloud storage configurations (level 2), and increasing complexity of regulatory requirements (level 3).

### Determine risk management strategy

For each risk, identify appropriate risk treatment options, such as avoiding, mitigating, transferring, or accepting the risk. Provide an explanation of the choice. For example, if you decide to accept a risk because the cost of mitigating it's too expensive, you should document that reasoning for future reference.

### Assign risk owners

Designate a primary risk owner for every risk. The risk owner has the responsibility of managing each risk. This person coordinates the risk management strategy across every team involved and is the initial point of contact for risk escalation.

## Document cloud risks

Document each risk and the details of the risk analysis. Create a list of risks (risk register) that contains all the information you need to identify, categorize, prioritize, and manage risks. Develop standardized language for risk documentation so everyone can easily understand the cloud risks. Consider including these elements:

- *Risk ID:* A unique identifier for each risk. Increment the identifier sequentially as you add new risks. If you remove risks, you can leave gaps in the sequence or fill the gaps in the sequence.
- *Risk management status:* The status of the risk (open, closed).
- *Risk category:* A label such as regulatory compliance, security, cost, operations, AI, or resource management.
- *Risk description:* A brief description of the risk.
- *Risk probability:* The probability of the risk occurring per year. Use a percentage or qualitative label.
- *Risk impact:* The impact on the organization if the risk occurs. Use a monetary amount or qualitative label.
- *Risk priority:* The severity of the risk (probability x impact). Use a dollar amount or qualitative label.
- *Risk level:* The type of risk. Use major threat (level 1), subrisk (level 2), or risk driver (level 3).
- *Risk management strategy:* The approach to manage the risk such as mitigate, accept, or avoid.
- *Risk management enforcement:* The techniques to enforce the risk management strategy.
- *Risk owner:* The individual managing the risk.
- *Risk closure date:* A date when the risk management strategy should be applied.

For more information, see [Risk list example](#example-risk-list).

## Communicate cloud risks

Clearly convey identified cloud risks to the executive sponsor and executive-level management. The goal is to ensure the organization prioritizes cloud risks. Provide regular updates on cloud risk management and communicate when you need extra resources to manage risks. Promote a culture where managing cloud risks management and governance is a part of daily operations.

## Review cloud risks

Review the current cloud risk list to ensure it's valid and accurate. Reviews should be regular and also in response to specific events. Maintain, update, or remove risks as needed. To review cloud risks, follow these recommendations:

- *Schedule regular assessments.* Set a recurring schedule to review and assess cloud risks, such as quarterly, biannually, or yearly. Find a review frequency that best accommodates personnel availability, the rate of cloud environment changes, and organizational risk tolerance.

- *Conduct event-based reviews.* Review risks in response to specific events, such as the failed prevention of a risk. Consider reviewing risks when you adopt new technologies, change business processes, and discover new security threats events. Also consider reviewing when technology, regulatory compliance, and organizational risk tolerance changes.

- *Review cloud governance policies.* Keep, update, or remove cloud governance policies to address new risks, existing risks, or outdated risks. Review the cloud governance policy statement and cloud governance enforcement strategy as needed. When you remove a risk, evaluate if the cloud governance policies associated with it are still relevant. Consult with stakeholders to remove the cloud governance policies or update the policies to associate them with a new risk.

## Example risk list

The following table is an example risk list, also known as a risk register. Tailor the example to fit the specific needs and context of your organization's Azure cloud environment.

|Risk ID|Risk management status|Risk category|Risk description|Risk probability|Risk impact|Risk priority|Risk level|Risk management strategy|Risk management enforcement|Risk owner|Risk closure date|
|---|---|---|---|---|---|---|---|---|---|---|---|
|R01|Open|Regulatory compliance|Noncompliance with sensitive data requirements|20% OR Medium|$100,000 OR High|$20,000 OR High|Level 2|Mitigate|Use Microsoft Purview for sensitive data monitoring. <br> Compliance reporting in Microsoft Purview.|Compliance lead|2024-04-01|
|R02|Open|Security|Unauthorized access to cloud services|30% OR High|$200,000 OR High|$60,000 OR Very high|Level 1|Mitigate|Microsoft Entra ID multifactor authentication (MFA). <br> Microsoft Entra ID Governance monthly access reviews.|Security lead|2024-03-15|
|R03|Open|Security|Insecure code management|20% OR Medium|$150,000 OR High|$30,000 OR High|Level 2|Mitigate| Use defined code repository. <br> Use quarantine pattern for public libraries. |Developer lead|2024-03-30|
|R04|Open|Cost|Overspending on cloud services due to overprovisioning and lack of monitoring|40% OR High|$50,000 OR Medium|$20,000 OR High|Level 2|Mitigate|Set budgets and alerts for workloads. <br>Review and apply Advisor cost recommendations.|Cost lead|2024-03-01|
|R05|Open|Operations|Service disruption due to Azure region outage|25% OR Medium|$150,000 OR High|$37,500 OR High|Level 1|Mitigate|Mission-critical workloads have active-active architecture. <br> Other workloads have active-passive architecture.|Operations lead|2024-03-20|
|R06|Open|Data|Loss of sensitive data due to improper encryption and data lifecycle management|35% OR High|$250,000 OR High|$87,500 OR Very high|Level 1|Mitigate|Apply encryption in transit and at rest. <br> Establish data lifecycle policies using Azure tools.|Data lead|2024-04-10|
|R07|Open|Resource management|Misconfiguration of cloud resources leading to unauthorized access and data exposure|30% OR High|$100,000 OR High|$30,000 OR Very high|Level 2|Mitigate|Use infrastructure as code (IaC). <br> Enforce tagging requirements using Azure Policy.|Resource lead|2024-03-25|
|R08|Open|AI|AI model producing biased decisions due to unrepresentative training data|15% OR Low|$200,000 OR High|$30,000 OR Moderately high|Level 3|Mitigate|Use content filtering mitigation techniques. <br>Red team AI models monthly.|AI lead|2024-05-01|

## Next step

> [!div class="nextstepaction"]
> [Document cloud governance policies](document-cloud-governance-policies.md)
