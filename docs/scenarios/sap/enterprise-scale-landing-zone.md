---
title: Enterprise-scale support for SAP on Azure construction set
description:  Learn about Enterprise-scale construction sets that let you build platform workload landing zones.
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise-scale support for SAP on Azure construction set
  
Enterprise-scale construction sets provide specific architectural approach and reference implementation that enables effective construction and operationalization of platform workload landing zones within the Cloud Adoption Framework Enterprise scale landing zone. The SAP on Azure construction set is implementations for after a customer has successfully implemented enterprise-scale landing zone. Review the enterprise-scale [overview](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/) and [implementation guidance](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/implementation) before deploying the SAP on Azure construction set.

## Adopting the SAP on Azure construction set

Not all customers adopt SAP on Azure in the same way. The Cloud Adoption Framework for Azure enterprise-scale SAP on Azure construction set architecture varies between customers. The technical considerations and design recommendations of the SAP on Azure construction set might lead to different trade-offs based on your organization's scenario. If you follow the core recommendations, the resulting architecture sets your organization on a path to a sustainable scale. The SAP on Azure construction set is modular by design. Customers can customize environmental variables. The construction set approach to landing zones includes three sets of assets to support cloud teams:

- [Design guidelines](#design-guidelines)
- [Architecture](#architecture)
- [Implementation](#implementation)

## Design guidelines

You have to make critical decisions that drive the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone. Consider these six critical design areas:

- [Identity and Access Management](eslz-identity-and-access-management.md)
- [Network topology and connectivity](eslz-network-topology-and-connectivity.md)
- [Management and monitoring](eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance,  and compliance](eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps](eslz-platform-automation-and-devops.md)

## Architecture

The following image shows a conceptual reference architecture that demonstrates design areas:

![A diagram depicting the SAP construction set conceptual reference architecture.](media/Overview_Architecture.png)

## Implementation

 **SAP on Azure Deployment Automation Framework** is a collection of processes combined with a flexible workflow. The [SAP Deployment Automation Framework repository](https://github.com/Azure/sap-hana/tree/beta/v2.3) has code that automatically deploys SAP landscapes in the Azure Cloud.

The templates are split into two categories:

- Terraform modules: Deploy the infrastructure components in Azure: VMs, network, storage, and so on.
- Ansible playbooks: Run different roles to:
  - Set up and deploy VMs.
  - Install SAP HANA.
  - Install other required applications.

  Deploy and install the Ansible playbook components on the infrastructure that the Terraform modules built.

  ![SAP Reference Implementation](media/Overview_Automation.png)

## Next steps

Review the SAP on Azure construction set critical design areas to make complete considerations and recommendations for your SAP on Azure construction set architecture. [Identity and Access Management](./eslz-identity-and-access-management.md)
