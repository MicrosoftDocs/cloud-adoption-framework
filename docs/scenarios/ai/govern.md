---
title: Governing AI in Azure
description: Learn how to govern AI in Azure by managing risks, ensuring compliance, and managing data effectively.
author: Zimmergren
ms.author: tozimmergren
ms.date: 06/12/2024
ms.topic: conceptual
ms.collection: ce-skilling-ai-copilot
---

# Governing AI in Azure

AI governance is a key factor for effective AI adoption. Use the Govern methodology from the Cloud Adoption Framework as a starting point for your process and extend it with AI-specific considerations based on the guidance in this section.

AI governance usually refers to policies, processes, and standards that direct the organization's creation, deployment, and management of AI.

An AI adoption governance strategy should consider ethical guidelines, regulatory compliance considerations, accountability structures, and operational procedures. This helps make sure AI technologies are used in a responsible, efficient, and safe manner.

With this guidance, you get examples of how to reduce risks, increase transparency, and ensure that AI systems match the organization’s strategic objectives, while protecting stakeholder interests.

## Checklist

The following table provides an overview of recommended components to embrace in your AI governance processes.

|AI governance plan component|Description|
|---|---|
| Establish an AI governance team |  |
| Assess AI risks |  |
| Enforce AI governance policies | |
| Monitor AI governance | |

## Establish an AI governance team

In the Cloud Adoption Framework, the Govern methodology provides guidance on how to [establish a governance function](/azure/cloud-adoption-framework/govern/build-cloud-governance-team) within your organization. This function is responsible for ensuring that the organization’s cloud resources are used in a compliant, secure, and efficient manner. When adopting AI, you should extend this governance function to cater for the specific risks and challenges associated with AI.

By extending your cloud governance team to include AI governance, you can ensure that AI systems are developed, deployed, and managed in a responsible and compliant manner. This team should be responsible for setting AI governance policies, monitoring compliance, and providing guidance and support to AI development teams. For enterprises, the governance function might exist within the AI center of Excellence (CoE), which is responsible for driving AI adoption across the organization.

For more information on the functions of an AI Center of Excellence team, see [AI Center of Excellence](./ai-center-of-excellence.md).

## Assess AI risks

Risks are associated with all areas of business. With AI, there are new types of risks to consider. You should use the prescribed process in the CAF Govern methodology to [assess risk](/azure/cloud-adoption-framework/govern/assess-cloud-risks). As you build your [risk list](/azure/cloud-adoption-framework/govern/assess-cloud-risks#example-risk-list), consider applying an AI lens to cater for the potential risks and impact of adopting AI.

### Example AI risk list

Here are some common AI risks to consider for your risk list:

|Risk ID|Risk category|Risk description|Business risk|Technical risk|
|---|---|---|---|---|---|
|R01|Regulatory compliance|**Non-compliance with data protection laws.**<br> Failure to adhere to local or international laws can result in fines and legal consequences.|Yes|No|
|R02|Regulatory compliance|**Violations of industry-specific regulations.**<br> Some industries, like healthcare and finance, have additional regulations that must be met, such as HIPAA or FINRA.|Yes|No|
|R03|Regulatory compliance|**Breach of international data transfer rules.**<br> Not handing data correctly across borders can lead to violations of laws governing international data transfer, such as the EU-US. Privacy Shield.|Yes|No|
|R04|Ethical|**Unfair treatment of users or customers.**<br> Biased AI decisions can result in discriminatory practices affecting certain groups of users or customers.|Yes|No|
|R05|Ethical|**Lack of transparency in AI decision-making.**<br> Without proper transparency, it’s difficult to understand and justify decisions from AI, undermining trust and accountability.|Yes|No|
|R06|Ethical|**Inaccurate predictions.**<br> If a model is flawed, it might produce incorrect predictions or classifications, leading to poor business decisions and potential financial losses.|Yes|No|
|R07|Security|**AI system breaches**: Malicious actors might target AI systems, manipulating outputs or stealing proprietary data and algorithms.|Yes|Yes|
|R08|Security|**Insider threats.**<br> Employees with access to AI systems and data might misuse their privileges, either intentionally or not, compromising security.|Yes|Yes|
|R09|Cost|**Unexpected costs.**<br> AI projects can be expensive, and costs can spiral out of control if not managed properly.|Yes|No|
|R10|Cost|**Underutilization of AI resources.**<br> If AI resources aren't used efficiently, it can lead to wasted resources and missed opportunities, and a poor sustainability score.|Yes|No|
|R11|Legal|**Copyright issues.**<br> Many Large Language Models (LLMs) are trained on a vast amount of data, which might contain copyrighted material if it's from an internet source.|Yes|No|

## Enforce AI governance policies

With risks identified, you should establish policies to mitigate them. You should use the prescribed process in the CAF Govern methodology to [Enforce cloud governance policies](/azure/cloud-adoption-framework/govern/enforce-cloud-governance-policies). Policies should be enforced across the organization to ensure that AI systems are developed, deployed, and managed in a responsible and compliant manner. Some policies might be possible to implement using built-in tools and services in Azure, while others might require manual enforcement and monitoring.

### Example AI governance policies

Here are some examples of AI governance policies:

| Policy ID | Policy category | Risk IDs | Policy statement | Purpose | Scope | Remediation | Monitoring |
|---|---|---|---|---|---|---|---|
| RC01 | Regulatory compliance | [R01](#example-ai-risk-list) | Store and process data in compliant geographic regions. | Regulatory compliance | Workload teams, platform team | Use Azure Policy to configure data residency and compliance requirements policies to ensure data is stored in approved specific regions. | <li> Azure Policy |
| RC02 | Regulatory compliance | [R02](#example-ai-risk-list), [R03](#example-ai-risk-list) | Enforce regulatory compliance with Microsoft Defender for Cloud. | Regulatory compliance | Workload teams, platform team | Use Microsoft Defender for Cloud to enforce regulatory compliance requirements in your Azure environment. Use Microsoft Purview to enforce and monitor compliance in your wider organization. | <li> Microsoft Purview.<br> <li> Microsoft Defender for Cloud. |
| RC03 | Regulatory compliance | [R02](#example-ai-risk-list), [R03](#example-ai-risk-list) | Document and audit regulatory compliance continuously. | Regulatory compliance | AI Center of Excellence, platform team | Use compliance management tools, such as Microsoft Purview Compliance Manager and Microsoft Defender for Cloud, to track and manage compliance activities and documentation. | <li> Microsoft Purview Compliance Manager.<br> <li> Microsoft Defender for Cloud. |
| ET01 | Ethical | [R04](#example-ai-risk-list), [R05](#example-ai-risk-list) | Develop, maintain, and enforce ethical guidelines. | Ethical | AI Center of Excellence |Integrate the Responsible AI principles in your AI strategy adoption roadmaps. | <li> Manual. |
| ET02 | Ethical | [R04](#example-ai-risk-list), [R05](#example-ai-risk-list) | Conduct bias and fairness checks for Azure Machine Learning models. | Ethical | Workload team, AI development teams | - Use the Fairlearn toolkit to assess and mitigate bias in AI models. <br>- Use the Azure Responsible AI Dashboard for tools and guidelines to ensure ethical AI practices.| <li> Manual. |
| LE01 | Legal | [R11](#example-ai-risk-list) | Validate source references and output transparency. | Legal | AI Center of Excellence, platform team | Ensure visibility into data sources used, and the methods of the data retrieval. | <li> Manual. |

## Monitor AI governance

- Monitor your AI governance.
- Add examples of how.

## Next steps

> [!div class="nextstepaction"]
> [Managing generative AI in Azure](./manage.md)
