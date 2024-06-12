---
title: Governing AI in Azure
description: Learn how to govern AI in Azure by managing risks, ensuring compliance, and managing data effectively.
author: Zimmergren
ms.author: tozimmergren
ms.date: 05/07/2024
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Governing AI in Azure

AI governance is a key factor for effective AI adoption. Use the Govern methodology from the Cloud Adoption Framework as a starting point for your process and extend it with AI-specific considerations based on the guidance in this section.

AI governance usually refers to policies, processes, and standards that direct the organization's creation, deployment, and management of AI.

An AI adoption governance strategy should consider ethical guidelines, regulatory compliance considerations, accountability structures, and operational procedures to make sure AI technologies are used in a responsible, efficient, and safe manner.

With this guidance, you get examples of how to reduce risks, increase transparency, and ensure that AI systems match the organization’s strategic objectives while protecting stakeholder interests.

## Checklist

The following table provides an overview of recommended components to embrace in your AI governance processes.

|AI governance plan component|Description|
|---|---|
| Understand the importance of governing AI | |
| Establish an AI governance team (AI COE)|  |
| Assess and document AI risks | Use the Cloud Adoption Framework Govern methodology to establish a governance function within your organization. Apply an AI lens to cater for the potential risks and impact of adopting AI. |
| Enforce AI governance policies | |
| Monitor AI governance | |

## Establish an AI governance team

> Point to Govern's section for establishing a team.
> Expand with specific functions as per an AI CoE -> Link to the AI CoE article.

## Assess AI risks

Risks are associated with all areas of business. With AI, there are new types of risks to consider. You should use the prescribed process in the CAF Govern methodology to [assess risk](/azure/cloud-adoption-framework/govern/assess-cloud-risks). As you build your [risk list](/azure/cloud-adoption-framework/govern/assess-cloud-risks#example-risk-list), consider applying an AI lens to cater for the potential risks and impact of adopting AI.

Here are some common AI risks to consider for your risk list:

### Example AI risk list

#### Version 1

|Risk ID|Risk management status|Risk category|Risk description|Risk probability|Risk impact|Risk priority|
|---|---|---|---|---|---|---|---|---|---|---|---|
|R01|Open|Regulatory compliance|**Non-compliance with data protection laws.**<br> Failure to adhere to laws such as GDPR or CCPA can result in fines and legal consequences.|Medium|High|High|
|R02|Open|Regulatory compliance|**Violations of industry-specific regulations.**<br> Some industries, like healthcare and finance, have additional regulations that must be met, such as HIPAA or FINRA.|Medium|High|High|
|R03|Open|Regulatory compliance|**Breach of international data transfer rules.**<br> Not handing data correctly across borders can lead to violations of laws governing international data transfer, such as the EU-US. Privacy Shield.|Medium|High|High|
|R04|Open|Ethical|**Unfair treatment of users or customers.**<br> Biased AI decisions can result in discriminatory practices affecting certain groups of users or customers.|Medium|High|High|
|R05|Open|Ethical|**Lack of transparency in AI decision-making.**<br> Without proper transparency, it’s difficult to understand and justify decisions from AI, undermining trust and accountability.|Medium|High|High|
|R06|Open|Ethical|**Inaccurate predictions.**<br> If a model is flawed, it might produce incorrect predictions or classifications, leading to poor business decisions and potential financial losses.|Medium|High|High|
|R07|Open|Security|**AI system breaches**: Malicious actors might target AI systems, manipulating outputs or stealing proprietary data and algorithms.|Medium|High|High|
|R08|Open|Security|**Insider threats.**<br> Employees with access to AI systems and data might misuse their privileges, either intentionally or not, compromising security.|Medium|High|High|
|R09|Open|Cost|**Unexpected costs.**<br> AI projects can be expensive, and costs can spiral out of control if not managed properly.|Medium|High|High|
|R10|Open|Cost|**Underutilization of AI resources.**<br> If AI resources are not used efficiently, it can lead to wasted resources and missed opportunities, and a poor sustainability score.|Medium|High|High|

#### Version 2

|Risk category|Example risk|
|---------|-------------|
|Regulatory compliance|**Non-compliance with data protection laws**: Failure to adhere to laws such as GDPR or CCPA can result in fines and legal consequences.|
|Regulatory compliance|**Violations of industry-specific regulations**: Some industries, like healthcare and finance, have additional regulations that must be met, such as HIPAA or FINRA.|
|Regulatory compliance|**Breach of international data transfer rules**: Not handing data correctly across borders can lead to violations of laws governing international data transfer, such as the EU-US. Privacy Shield.|
|Ethical|**Unfair treatment of users or customers**: Biased AI decisions can result in discriminatory practices affecting certain groups of users or customers. |
|Ethical|**Lack of transparency in AI decision-making**: Without proper transparency, it’s difficult to understand and justify decisions from AI, undermining trust and accountability. |
|Operational|**Inaccurate predictions**: If a model is flawed, it might produce incorrect predictions or classifications, leading to poor business decisions and potential financial losses.|
|Security|**AI system hacking**: Malicious actors might target AI systems, manipulating outputs or stealing proprietary data and algorithms.|
|Security|**Insider threats**: Employees with access to AI systems and data might misuse their privileges, either intentionally or not, compromising security.|
|Reputational|**Negative brand perception, loss of customer trust**: If AI is perceived as invasive, unsafe or unethical, it can damage the company’s reputation and brand.|
|Cost|**Unexpected costs**: AI projects can be expensive, and costs can spiral out of control if not managed properly.|
|Cost|**Underutilization of AI resources**: If AI resources are not used efficiently, it can lead to wasted resources and missed opportunities, and a poor sustainability score.|

### Example AI governance policies

With risks identified, you should establish policies to mitigate them. These policies should be enforced across the organization to ensure that AI systems are developed, deployed, and managed in a responsible and compliant manner. Some policies might be possible to implement using built-in tools and services in Azure, while others might require manual enforcement and monitoring.

Here are some examples of AI governance policies:

| Policy ID | Policy category | Risk IDs | Policy statement | Purpose | Scope | Remediation | Monitoring |
|-----------|-----------------|---------|------------------|---------|-------|-------------| ---------- |
| RC01 | Regulatory compliance | [R01](#example-ai-risk-list) | Store and process data in compliant geographic regions. | Regulatory compliance | Workload teams, platform team | Use Azure Policy to configure data residency and compliance requirements policies to ensure data is stored in approved specific regions. | Azure Policy |
| RC02 | Regulatory compliance | [R02](#example-ai-risk-list), [R03](#example-ai-risk-list) | Enforce regulatory compliance with Microsoft Defender for Cloud. | Regulatory compliance | Workload teams, platform team | Use Microsoft Defender for Cloud to enforce regulatory compliance requirements in your Azure environment. Use Microsoft Purview to enforce and monitor compliance in your wider organization. | Microsoft Defender for Cloud. Microsoft Purview. |
| ET01 | Ethical | [R04](#example-ai-risk-list), [R05](#example-ai-risk-list) | Develop, maintain, and enforce ethical guidelines, and conduct bias and fairness checks. | Ethical | AI CoE | - If you develop your own models with Azure Machine Learning, consider using the Fairlearn toolkit in Azure ML to assess and mitigate bias in AI models.<br> - Lean on the Azure Responsible AI Dashboard for tools and guidelines to ensure ethical AI practices.<br> - Integrate the Responsible AI principles in your AI strategy adoption roadmaps. | Manual. |

## Monitor AI governance

- Monitor your AI governance.
- Add examples of how.

## Next steps

> [!div class="nextstepaction"]
> [Managing generative AI in Azure](./manage.md)
