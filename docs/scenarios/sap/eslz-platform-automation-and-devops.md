---
title: "Enterprise-Scale platform automation and devops for SAP on Azure"
description: Describe how this enterprise-scale scenario can improve platform automation and devops of SAP
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Platform automation and devops for SAP Enterprise-Scale scenario

## Planning for a SAP AppOps approach
How to approach SID Automation with SAP. 

### Glossary

Term                                     | Description |
| :------------------------------------------ | ------------------------------
| `System`                       | An instance of an SAP application identified by a system ID (SID). Consists of one or more Virtual Machines and their supporting artifacts deployed to Azure to a resource group.
| `Landscape`                       | A collection of instances of the same SAP Application, for instance a development instance, a quality assurance instance and the production instance. Consists of multiple systems each in their own resource group
| `Environment`                       | Also known as development tiers, provides a way to partition the SAP Applications in an SAP Landscape, for instance development-, quality assurance- and production environment. The environment deployment will provide shared resources to all the systems in the environment, for example virtual network, key vaults.
<br>

The image below illustrates the dependencies between SAP Systems, landscapes and environments. The diagram has 3 SAP Landscapes (ECC, CRM and BW) and each of the landscapes have 3 tiers of the application (development, quality assurance and production)

![Architectural dependencies](media\SGC_Architectural_Principles.png)

Picture 1: Architectural Dependencies

#### **System**

The SAP system will contain the resources which are needed for the SAP application, these include the virtual machines, disks, load balancers, proximity placement groups, availability sets, subnets, network security groups etc. The systems are identified by a System Identifier (SID).

#### **Landscape**

The landscape defines an SAP application and all different tiers of if (development, quality assurance, production etc).

#### **Environment**

Environments provide a way to partition the systems into different tiers. They provides the following services to the SAP systems:

- Key vaults for credentials management, by default all systems in the same environment share the credentials.
- Virtual Network
- Storage accounts for
  - Terraform remote storage
  - SAP Installation media
  - Boot diagnostics for the Virtual Machines

### Design Considerations

Identify the number of environments needed:

- Define how environments are partitioned (by subscription, by virtual network, by subnet, etc.)
- Define SPN strategy for automation, will each environment have unique SPN?

Secrets/creds management, by default all systems in an environment will use the same credentials provident by the environment keyvault. Identify if systems exist that need unique credentials.

Decide whether to use Azure marketplace image or custom built image

Provide a managed SAP automation environment
Statefiles copies to be backed up, to safegaurd against file corruption
Store archival copies of the automation tool binaries
Naming conventions, using default SAP Automation standard is recommended

### Design Recommendations

Custom built images have several advantages e.g., customer specific OS configuration, security hardening, compliance tooling etc. Additionally, it can potentially streamline the management of image lifecycle
Azure KeyVault is the recommended solution for key management/key storage. SAP Automation will use SPN credentials from Azure KeyVault  
Three methods to ocrhestrate automation -               
    1) Begin by deploying Deployment Infrasturcture as a central Automation Controller VM per SAP env NP and Prod
    2) Utilise ADO for automation runs, bypasses requirement of deploying controller VM. Can begin from SAP library and SAP IaaS builds.
    3) Resrouce Provider (RP) based automation, script run calls can be made from Snow portal.
For instance, Terraform statefiles can be stored on RA-GRS based HOT storage accounts
Keep copies of Terraform/Ansible binary/library, specific version applicable to code
SAP Automation publishes a set of naming convention guidelines