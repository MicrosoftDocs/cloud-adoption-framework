---
title: "Enterprise-Scale platform automation and devops for <Insert narrative Name>"
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

### Design Considerations

Create and manage SPN specifically for Automation
Decide whether to use Azure marketplace image or custom built image
Secrets/creds management - KV
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