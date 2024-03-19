---
title: Cloud governance
description: Learn what cloud governance is, why cloud governance is important, and how to establish governance in the cloud.
author: stephen-sumner
ms.author: ssumner
ms.date: 04/01/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Govern overview

The Govern methodology provides a structured approach for setting up and managing cloud governance in Azure. Cloud governance refers to methods enforce and monitor compliance with rules you define. These rules are known as cloud governance policies. Cloud governance policies specify what should or should not take place in the cloud. You create cloud governance policies to address identified risks to your organization. The goal of cloud governance is to ensure cloud use aligns (complies) with your cloud governance policies.

:::image type="content" source="./_images/govern.svg" alt-text="Diagram showing the process to set up and maintain cloud governance. The diagram shows five sequential steps: build a cloud governance team, document cloud governance policies, enforce cloud governance policies, and monitor cloud governance. The first step you perform once. The last four steps you perform once to set up cloud governance and continously to maintain cloud governance." lightbox="./_images/govern.svg" border="false":::

## Why govern the cloud?

Cloud governance benefits all organization using the cloud. Effective cloud governance minimizes avoidable risks. It defines and streamlines acceptable cloud usage across the organization. Cloud governance ensures your cloud environment is compliant with external regulations and aligned to your broader cloud strategy. Without cloud governance, your organization might encounter risks that cloud governance could help you avoid.

## How to govern the cloud?

Cloud governance is a continuous process. The Govern methodology divides cloud governance into five steps:

1. *Build a governance team*: Select a team of individuals responsible for cloud governance. The cloud governance team defines and maintains cloud governance policies while reporting on the overall progress of cloud governance.

2. *Assess cloud risks*: Identify and prioritize potential risks associated with the use of cloud. The risk assessment should evaluate risks unique to the organization, including regulatory compliance, security, operations, cost, data, resource management, and AI risks. Use Azure tools to help [assess cloud risks](./assess-cloud-risks.md#azure-facilitation-identifying-cloud-risks).

3. *Document cloud governance policies*: Document cloud governance policies that govern the use of the cloud. These policies set out the rules and guidelines for cloud usage to minimize the identified risks.

4. *Enforce cloud governance policies*: Enforce adherence to the cloud governance policies using automated tools or manual procedures. The goal is to ensure that the use of cloud services is in line with the established governance policies. Use Azure tools to help [enforce cloud governance policies](./enforce-cloud-governance-policies.md#azure-facilitation-enforcing-cloud-governance-policies-automatically).

5. *Monitor cloud governance*: Evaluate to ensure that cloud services are used according to the governance policies and adjusting as necessary. Use Azure tools to help [monitor cloud governance](./monitor-cloud-governance.md#azure-facilitation-configuring-cloud-governance-monitoring) and [set up alerts for non-compliance](./monitor-cloud-governance.md#azure-facilitation-configuring-cloud-governance-alerts).

Work though these five steps to establish cloud governance. Repeat steps one through four to maintain cloud governance over time.

## Next step

Build a cloud governance team to oversee the process of assessing cloud risks, defining cloud governance policies, enforcing cloud governance policies, and monitoring cloud governance.

> [!div class="nextstepaction"]
> [Cloud governance checklist](cloud-governance-checklist.md)
