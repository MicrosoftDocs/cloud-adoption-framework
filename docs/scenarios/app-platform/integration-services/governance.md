---
title: Governance considerations for the Azure Integration Services landing zone accelerator
description: Learn about design considerations and recommendations for governance in the Azure Integration Services landing zone accelerator.
author: claytonsiemens77
ms.author: csiemens
ms.date: 03/15/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal
---
# Governance considerations for the Azure Integration Services landing zone accelerator

# Governance

Governance involves making sure any policies you have in place are being followed, and that you can show your applications are compliant with any legal, financial, regulatory, or internal requirements they are subject to. For smaller applications, this may be a manual process; for larger applications, automation is essential. Azure contains several offerings designed to make the compliance and governance process easier.

Note that this section deals with the [Control Plane](/azure/azure-resource-manager/management/control-plane-and-data-plane) only - meaning how we create, manage, and configure the resources in Azure (generally via the **Azure Resource Manager**). This section does not deal with governance of the Data Plane - meaning how the endpoints for your
resources are governed or secured or monitored.

## Design Considerations

- Have you defined the roles and responsibilities for all individuals that will interact with your resources?

- Have you defined a Disaster Recovery (DR) plan, and do you need to automate this? For example, do you need to automatically provision redundant resources in geographically disparate regions?

- Do you have specific **Recovery Time Objective** (RTO) and **Recovery Point Objective** (RPO) policies that need to be adhered to?

- Do you have an alert or escalation plan that needs to be implemented?

- What industry, legal, or financial regulations are your resources subject to, and how do you ensure that you are compliant?

- What tooling do you have for managing all your resources? Do you need to perform manual remediation, or can you automate this? How are you alerted if any part of your estate is not in compliance?

## Design Recommendations

- Use **[Azure Policy](/azure/governance/policy/overview)** to enforce organizational standards, and help you assess compliance. Azure Policy can provide you with an aggregated view, enabling to evaluate the overall state of your environment, with the ability to drill down to per-resource per-policy granularity. For example, you
  can have policies that look for unauthorized or expensive resources; or which look for resources that are provisioned without adequate  security.

- Automate your deployments using a **Continuous Integration/Continuous Deployment** (CI/CD) tool like Azure DevOps and Terraform. This will help ensure that any policies you have in place are followed, without the need for manual configuration.

- Use **[Automation tasks](/azure/logic-apps/create-automation-tasks-azure-resources)** to automate tasks e.g., to send alerts on weekly or monthly spend on resources; or to archive or delete old data. Automation tasks use Logic Apps (Consumption) workflows to achieve this.

- Use **[Role-based access control](/azure/role-based-access-control/overview)** (RBAC) to restrict user and application access to differing levels of scope.

- Use monitoring tools such as **[Azure Monitor](/azure/azure-monitor/overview)** or to identify where resources are either in breach of policy, or to identify resources that will breach policy soon.

- Enable **[Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction)** to help identify resources that are in breach of security of endpoint
  policies.

## Recommended Content

- [What is Azure Policy?](/azure/governance/policy/overview)

- [Manage Azure resources and monitor costs by creating automation tasks](/azure/logic-apps/create-automation-tasks-azure-resources)

- [Azure RBAC documentation](/azure/role-based-access-control/)