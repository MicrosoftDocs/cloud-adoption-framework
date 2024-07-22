---
title: Platform automation considerations for Red Hat Enterprise Linux on Azure
description: Learn about the tools, features, and services to automate various tasks and manage the Red Hat Enterprise Linux lifecycle within your Azure environment.
author: AnthonyDelagarde
ms.author: joelsisk
ms.date: 07/24/2024
ms.topic: conceptual
---

# Platform automation considerations for Red Hat Enterprise Linux on Azure

This article describes how to manage automation for Red Hat Enterprise Linux (RHEL) on Azure. Review design considerations, design recommendations, and options for various tooling within the Azure ecosystem to achieve a consistent and stable environment. This article provides guidance that aligns with varying customer scenarios, business requirements, operational practices, and technical maturity.     

## Overview

When you automate RHEL for Azure landing zones, the goal is to align the Azure landing zone lifecycle management via the Red Hat Infrastructure Standard (RH-IS) and the associated Red Hat Infrastructure Standard Adoption Model (RH-ISAM). When you standardize systems, you provide a reliable foundation for the solution. The RH-IS defines the standard operating environment that comprises the default set of software components and configurations. You can apply these components and configurations to systems via the RH-ISAM, a set of DevOps or Git operation principles, Azure Resource Manager templates (ARM templates), Terraform, Azure CLI, and Azure PowerShell.

This practice includes provisioning, systems management, platform evolution, infrastructure operations, and application and workload lifecycles. You implement these operations through automation, like infrastructure as code (IaC) and configuration as code. To reduce errors and increase reliability, define and test configurations. To speed up mass migration, automate provisioning. Automated configurations reduce configuration drifts and ensure that systems function correctly. 

## Design considerations

Red Hat Identity Management (IdM) provides a centralized and unified platform that you can use to manage identity stores, authentication policies, and authorization policies for RHEL systems. In a hybrid scenario, you can extend your existing Red Hat IdM infrastructure across a virtual private network or Azure ExpressRoute. This configuration connects on-premises with the RHEL landing zone within Azure. To support hybrid cloud identity scenarios, extend your on-premises environment into Azure so that you can integrate your workloads with Microsoft Entra. For more information, see [Microsoft Entra authentication](/entra/identity/authentication/).

As an alternative identity management solution, you can join RHEL to create an external trust with Windows Active Directory or join directly into an existing Windows Server Active Directory forest. For more information, see [Integrate RHEL systems directly with Windows Server Active Directory](https://access.redhat.com/documentation/red_hat_enterprise_linux/8/html-single/integrating_rhel_systems_directly_with_windows_active_directory/index).   

[Red Hat Satellite](https://www.redhat.com/en/technologies/management/satellite) provides content that's delivered to managed RHEL systems. Satellite includes Red Hat packages and patches and includes non-Microsoft packages and custom packages that application development teams develop. Satellite also acts as the gateway to Red Hat Insights, which offers predictive analysis of configurations to recognize security or performance risks. If you deploy preconfigured RHEL pay-as-you-go images, you can take advantage of the [Red Hat Update Infrastructure for Azure](/azure/virtual-machines/workloads/redhat/redhat-rhui), which is an update tool that's built into the pay-as-you-go images.


### Red Hat Ansible Automation Platform design considerations

Red Hat Ansible Automation Platform (AAP) helps to standardize technical workflows and recurring tasks. You can use AAP to orchestrate workflows, provision processes for new systems, and create recurring operational tasks. To reduce complexity, use one common automation platform and language. Fully automated workflows accelerate application innovation and simplify mass workload migrations across on-premises and cloud environments.

Benefits of RHEL as a Platform automation strategy include:

- New systems have fully automated provisioning at scale, which improves mass migration speed. 

- Increased uniformity of tested systems' configuration and application installations across physical systems and virtual systems. 
- Continuous updates because patch management is immediately available.
- A standardized and simplified platform to deliver new applications and workloads. Staff has extra time to deliver increased innovation. 

You can implement: 

- A self-managed Ansible Automation Platform instance, either via on-premises infrastructure, cloud infrastructure, or both
  - Via a RHEL deployment
  - Via a Red Hat OpenShift Container Platform deployment
- A self-managed Ansible Automation Platform instance in a public cloud
- A managed Ansible Automation Platform instance in a public cloud 

### Red Hat Ansible Automation Platform, self-managed, on-premises/cloud

[Red Hat Ansible Automation Platform on Microsoft Azure ](https://www.redhat.com/en/technologies/management/ansible/azure) when deployed in self-managed mode in an on-premises and/or cloud infrastructure, provides the following benefits: 

- Architecture and scale - determine what is the most ideal architecture to support the automation platform, whether based on RHEL infrastructure or OpenShift operator deployment. Based on fleet size and 
  requirements, choose the number, as well as instance sizing, of controllers, execution nodes, and private automation hub instances. For more on architecture, design, configuration and scale, visit the 
  Ansible Platform [Red Hat Ansible Automation Platform Planning Guide](https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.4/html/red_hat_ansible_automation_platform_planning_guide/index). 

- Azure configuration -  automation architecture can be optimized for the organization’s Azure design and configuration.
- Automation mesh support - is an Ansible Automation Platform feature that allows organizations to distribute automation workloads across hybrid cloud peer-to-peer connections with each other using existing networks. Placement of hop nodes can be made based on security design criteria and network topologies.
- Automation Hub architecture - an Automation Hub architecture can be optimized for scale and placement of private automation hub instances to enhance secure automation content delivery and access to execution environment sources in close proximity to automation execution resources. Provide access to and manage all types of Ansible content and choose which Ansible content collections and versions are made available to automation consumers.

### Red Hat Ansible Automation Platform on Azure, managed or self-managed application 

[Red Hat Ansible Automation Platform on Microsoft Azure](https://www.redhat.com/en/technologies/management/ansible/azure) is available via managed application or self-managed application and provides the following:

- Ease-of-use leads to rapid ROI - Ansible Automation Platform on Azure can be deployed directly from the Azure Marketplace. This managed solution is active immediately after deployment, and enterprises can start automating the management of their Azure resources in minutes. Red Hat manages the infrastructure, leaving you free to think only about the systems that are critical to your enterprise.

- Streamlined integration - Ansible Automation Platform on Azure is already integrated with Azure services. The Ansible collection for Azure was developed and security tested by Microsoft and Red Hat for minimal setup and maximum support. Use Ansible Automation Platform on Azure as part of your hybrid cloud automation strategy to unify management and automation across hybrid cloud, Internet of Things (IoT), and edge deployments.
- Existing committed Azure spend - Enterprises can use existing committed spending with Microsoft to purchase Red Hat Ansible Automation Platform on Azure. Using committed spending lets teams across an entire organization deploy, configure, and automate seamlessly. Integrated billing means you get one bill—and full visibility into the cost. 
- Automation beyond the cloud - Ansible Automation Platform on Azure allows you to deploy in your Microsoft Azure cloud—and then extend across your infrastructure. Organizations can deploy, run, and scale applications across Azure and hybrid cloud environments.
- Support - Red Hat and Microsoft partnered to build Ansible Automation Platform on Azure to ensure consistent and security-focused operations. Red Hat manages, services, and supports the application so your IT team can focus on delivering automation strategies. 

### Other considerations, managed mode

Red Hat Ansible Automation Platform on Microsoft Azure in managed mode is installed as a managed application. Red Hat manages both the underlying Azure resources and the software running on it while that infrastructure runs in your Azure tenant.

The managed application resource group is separate from other resource groups in your tenant. Red Hat only has access to the managed application resource group, with no visibility into other tenant resources.

For information about how this works and how resources and access are isolated from the rest of your Azure resources, see [Azure managed applications overview](/azure/azure-resource-manager/managed-applications/overview). 	

Ansible Automation Platform on Microsoft Azure in managed mode uses the following resource groups:

- A new or existing resource group (RG) in your tenant. This resource group includes a single resource referring to the Ansible Automation Platform on Microsoft Azure managed application deployment. Red Hat has access to the managed app to perform support, maintenance, and upgrades, but the resource group is outside of Red Hat’s management.
	
- A multitenant managed resource group (MRG) that contains most of the infrastructure needed to operate Ansible Automation Platform on Microsoft Azure. This multitenant resource group is shared between the Red Hat tenant and your tenant. Red Hat has full administrative control and you have read-only access to the resource group. 
- An AKS node pool resource group (NPRG). Microsoft requires the NPRG for AKS deployments. It contains resources that AKS uses to function. It's created on deployment, and it's outside of Red Hat’s management. For more information, see [Microsoft AKS documentation](/azure/aks/faq#why-are-two-resource-groups-created-with-aks).

For Ansible Automation Platform on Microsoft Azure in managed mode, additionally consider: 

- When you install Ansible Automation Platform on Microsoft Azure, you choose whether the deployment is public or private. This affects how users can access the Ansible Automation Platform user interfaces.
 
- Regardless of whether you choose a public or private deployment, you must configure network peering for outbound communication from Ansible Automation Platform to the private networks that contain resources that you want to automate against. You can configure network peering from Ansible Automation Platform on Microsoft Azure to your private Azure virtual network and to on-premises or multicloud networks where transit routing with Azure exists. 

### Other considerations, self-managed mode 

Ansible Automation Platform on Microsoft Azure in self-managed mode, provides many of the same benefits of self-managed Ansible Automation platform, however, whereas managed mode runs within an AKS cluster, for self-managed mode, automation platform resources are VM-based.

For Ansible Automation Platform on Microsoft Azure in self-managed mode, additionally consider: 

- Event-Driven Ansible is included in the self-managed offering on Azure - Event driven automation helps you reduce manual tasks and deliver a more efficient IT environment focused on innovation. Event-Driven Ansible processes events, and determines the appropriate responses, and then executes automated actions to remediate the event.

- Offers - Available in 100 active managed node increments, and this is available in both public offers, or private offers. 
- VM resources that underpin Ansible Automation Platform on Microsoft Azure in self-managed mode can consist entirely of running from marketplace images or via a mix of marketplace images and customer-managed images. 

## Design recommendations

Red Hat Certified Content and Validated Content Collections from Red Hat Automation Hub should be utilized in operating the RHEL Platform for Azure Landing Zones. The following are a listing of the collections that hold prominent roles in the automation framework:

redhat.rhel_idm
- IdM primary configuration
- IdM replicas configuration 
- Integration and configuration of RHEL clients with IdM

redhat.satellite  |  redhat.satellite_operations  |  redhat.rhel_system_roles 

- Deploy Satellite and Capsule
- Create and configure Satellite objects and settings 
- Provision and configure RHEL systems 

ansible.*  |  ansible.controller  |  infra.controller_configuration 

- Configure Ansible Automation Platform 
- Create and configure AAP job templates, and settings 

[The Ansible collection for Azure](https://catalog.redhat.com/software/collection/azure/azcollection?tab=documentation) includes over 250 modules to interrogate, manage, and automate numerous Azure resource types included, but not limited to:

- Microsoft Entra ID
- Networking
- Azure SQL Database
- Azure Kubernetes Service (AKS)
- Storage
- Application security groups
- Azure Virtual Machines
- Azure Database Services
- Azure Container Registry
- Azure Key Vault

### Core platform infrastructure deployment

Refer to [Azure landing zone design guidance for platform automation considerations](/azure/cloud-adoption-framework/ready/considerations/automation) and establish the concepts and processes described in order to effectively deploy core platform infrastructure to support an RHEL Platform on Azure landing zones model.

- [Development lifecycle](/azure/cloud-adoption-framework/ready/considerations/development-strategy-development-lifecycle) explores key design considerations and recommendations for the creation of a landing zone using automation. This guidance discusses the repository, branch, automated builds, deployment, and rollback strategy.

- [IaC](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code) explains the benefits of implementing Azure landing zones using IaC. Learn about considerations around code structure, tools, and technology. 
- [Environments](/azure/cloud-adoption-framework/ready/considerations/environments) explains the purpose of using multiple environments to build, test, and release code with greater speed and frequency. This approach makes deployment as straightforward as possible.
- [Test-driven development](/azure/cloud-adoption-framework/ready/considerations/development-strategy-test-driven-development) addresses how to use unit testing to improve the quality of new features and improvements in the Azure landing zone codebase. 

With requisite source code management tooling in place, along with source code management processes established from the previous sections, Ansible automation code with accompanying IaC or configuration as code should be developed to deploy core infrastructure to support the RHEL Platform for Azure landing zones model. For greenfield deployments, the following tasks can be automated for a full environment implementation. Brownfield deployments would only need a subset of these tasks, as required by your use case.

- Create Azure resource groups

- Create virtual networks
- Create subnets 
- Create network security groups 
- Create RHEL 8.x & 9.x golden images for Azure via automated Red Hat Image Builder
- Create IdM primary VM (pre-Satellite provisioning) 
    - Configure IdM primary via Configuration as Code
- Create Satellite VM (pre-Satellite provisioning)
    - Configure Satellite via Configuration as Code
- Create Capsule VMs (Satellite provisioning)
    - Configure Capsules via Configuration as Code
- Create IdM replica VMs (Satellite provisioning)
    - Configure IdM replicas via Configuration as Code
- Create Ansible Automation Platform infrastructure (Satellite provisioning) 
       - Automation Controller VMs
       - Execution node VMs 
       - Hop node VMs (optional) 
       - Automation hub VMs 
       - Event-Driven Ansible VMs (if enabled) 
       - PostgreSQL Server and necessary databases for Controller, Hub, and Event-Driven Ansible components (HA and/or DR PostgreSQL requires additional automation, either via replication/log shipping or [Crunchy Postgres](https://www.crunchydata.com/solutions/ansible))
- Create load balancers (Application Gateways)
       - Frontend for Capsule VMs 
       - Frontend for AAP Controller VMs 
       - Frontend for Automation Hub VMs 
- Create application security groups
       - IdM infrastructure
       - AAP Infrastructure
       - Satellite/Capsule infrastructure 

### RHEL system lifecycle management  

Once core platform infrastructure is in place, automation for RHEL applications and workload lifecycles can be implemented. Refer to 'Deployment, management, and patching considerations' and 'Governance and compliance' sections for in-depth coverage of considerations to be made when forming automation pipelines. The following encapsulates an example automation workflow for a development lifecycle pipeline:

   - Update the Errata Filter end date and publish content in Satellite
   - Promote Content Views (CV)/Composite Content Views (CCV) to Development
   
   - Deploy RHEL Development test systems from Satellite Host Groups
        - RHEL 8.x & 9.x golden images for Azure via automated Red Hat Image Builder are defined as Azure compute resources in Satellite 
    - Update/create Azure network security group based on application communication paths
    - For multi-tier application stacks, update or create Azure application security group for additional layered security 
    - Update RHEL Development systems, deploy, and configure desired application from Satellite Development CV/CCV
        - Deploy to single RHEL instance for simple application stack
        - Deploy to several RHEL instances for multi-tier application stacks
        - Configure application stack 
    - Execute application testing framework 
        - On failure, notify OnCall automation administration to assist in troubleshooting/analysis, exit automation workflow, RHEL test systems remain deployed for post-mortem failure analysis
        - On test success, continue 
    - Promote CVs/CCVs to QA 
    - Destroy RHEL Development test systems

Subsequent stages in the  lifecycle pipeline are slightly different from the Development lifecycle stage, as only the Development stage uses the initial content publishing and initial CV/CCV promotion to Development. The following encapsulates an example automation workflow for non-Development lifecycle pipelines, i.e. QA, pre-Production, Production, etc. In this case, QA will be considered: 

- Deploy RHEL QA test systems from Satellite host groups
       - RHEL 8.x & 9.x golden images for Azure via automated Red Hat Image Builder are defined as Azure compute resources in Satellite
       
- Update/create Azure network security group based on application communication paths 
   - For multi-tier application stacks, update or create Azure application security group for additional, layered security 
- Update RHEL QA systems, deploy, and configure desired application from Satellite QA CV/CCV 
    - Deploy to single RHEL instance for simple application stack
    - Deploy to several RHEL instances for multi-tier application stacks 
    - Configure application stack
    - Run application testing framework 
    - On failure, notify OnCall automation administration to assist in troubleshooting/analysis, exit automation workflow, RHEL test systems remain deployed for post-mortem failure analysis 
    - On test success, continue 
    - Promote CVs/CCVs to production 
    - Destroy RHEL QA test systems

## Other design considerations leveraging native Azure tooling           

### Azure Automation

Process Automation in Azure Automation allows you to automate frequent, time-consuming, and error-prone management tasks. This service helps you focus on work that adds business value. By reducing errors and boosting efficiency, it also helps to lower your operational costs. For more information, see [here](/azure/automation/overview). 

Process automation supports the integration of Azure services and other third-party systems such as Red Hat required in deploying, configuring, and managing your end-to-end processes. The service allows you to author graphical PowerShell and Python [runbooks](/azure/automation/automation-runbook-types).  

Runbooks can be used for a wide range of automation tasks like managing resources, starting and stopping VMs, and handling maintenance tasks both within in Azure and targets outside Azure. It is recommended to ensure that you review the authentication scenarios which can be found [here](/azure/automation/automation-security-overview). You can find an overview of runbooks execution and recommendations [here](/azure/automation/automation-runbook-execution). 

Supported runbook types are detailed in the table below: 
[PowerShell](/azure/automation/automation-runbook-types#powershell-runbooks)  Textual runbook based on Windows PowerShell scripting. The currently supported versions are: PowerShell 7.2 (GA) and PowerShell 5.1 (GA). Since PowerShell 7.1 is no longer supported by parent product PowerShell, we recommend you create runbooks in long-term supported version PowerShell 7.2.

[Powershell Workflow](/azure/automation/automation-runbook-types#powershell-workflow-runbooks) Textual runbook based on Windows PowerShell Workflow scripting. 

[Python](/azure/automation/automation-runbook-types#python-runbooks) Textual runbook based on Python scripting. The currently supported versions are: Python 3.8 (GA) and Python 3.10 (preview). Since Python 2.7 is no longer supported by parent product Python, we recommend you to create runbooks in long term supported versions.

[Graphical](/azure/automation/automation-runbook-types#graphical-runbooks) Graphical runbook based on Windows PowerShell and created and edited completely in the graphical editor in Azure portal. 

[Graphical PowerShell Workflow](/azure/automation/automation-runbook-types#graphical-runbooks) Graphical runbook based on Windows PowerShell Workflow and created and edited completely in the graphical editor in Azure portal. 

[Webhooks](/azure/automation/automation-webhooks?tabs=portal) let you fulfill requests and ensure continuous delivery and operations by triggering automation from Azure Logic Apps, Azure Function, ITSM product or service, DevOps, and monitoring systems. 

Azure Arc represents a significant advancement in cloud computing, offering a unified management platform that extends Azure's capabilities to on-premises, multi-cloud, and edge environments. Azure Arc-enabled enables integration with the Azure Automation service using the VM extension framework to deploy the Hybrid Runbook Worker role and simplify onboarding to Update Management and Change Tracking and Inventory.

:::image type="content" source="images/arcecosystem.png" alt-text="Diagram that shows the Azure Arc ecosystem." border="false" lightbox="images/arcecosystem.png":::

You can find the prerequisites and steps to onboard a Linux machine in this article: [Connect an existing Linux server to Azure Arc.](/azure/cloud-adoption-framework/manage/hybrid/server/best-practices/onboard-server-linux)

### ARM templates

IaC using ARM templates provides a consistent declarative method to deploy and manage Azure resources. This feature allows you to define the infrastructure required for your applications in a JSON format. ARM templates are idempotent, meaning you can deploy the same template many times and get the same resource types in the same state. 

A complete overview of Azure Resource Manager (ARM) Templates can be found here, in addition best practices using ARM are detailed [here](/azure/azure-resource-manager/templates/).

#### JSON example

```json
{ 

  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#", 

  "contentVersion": "1.0.0.0", 

  "parameters": { 

    "location": { 

      "type": "string", 

      "defaultValue": "[resourceGroup().location]" 

    }, 

    "storageAccountName": { 

      "type": "string", 

      "defaultValue": "[format('toylaunch{0}', uniqueString(resourceGroup().id))]" 

    } 

  }, 

  "resources": [ 

    { 

      "type": "Microsoft.Storage/storageAccounts", 

      "apiVersion": "2021-06-01", 

      "name": "[parameters('storageAccountName')]", 

      "location": "[parameters('location')]", 

      "sku": { 

        "name": "Standard_LRS" 

      }, 

      "kind": "StorageV2", 

      "properties": { 

        "accessTier": "Hot" 

      } 

    } 

  ] 

}  
```
To help reduce the complexity of the JSON syntax, Bicep domain specific language can be used to reduce the learning curve for those new to Azure. Bicep is a transparent abstraction over ARM template JSON and doesn't lose any of the JSON template capabilities. During deployment, the Bicep CLI converts a Bicep file into ARM template JSON. 

The following examples show the difference between a Bicep file and the equivalent JSON template. Both examples deploy a storage account. 

#### Bicep example

```bicep
param location string = resourceGroup().location 

param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}' 

 

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = { 

  name: storageAccountName 

  location: location 

  sku: { 

    name: 'Standard_LRS' 

  } 

  kind: 'StorageV2' 

  properties: { 

    accessTier: 'Hot' 

  } 

} 
```

### Azure DevOps

Azure DevOps is a comprehensive set of development tools to provide project management, continuous integration and continuous delivery (CI/CD) services, and source code repositories for both cloud and on-premises environments. Combing these features along with Azure Test Plans, Azure Artifacts, Azure Logic Apps, and Azure Functions facilitate seamless collaboration, development, and delivery of modern software projects.

### Azure Boards

Agile software development for Cloud software development and project management. Current documentation on Azure Boards can be found [here](/azure/devops/boards/). Initial guidance on options and that can be configured and optimized are detailed [here](/azure/devops/boards/configure-customize).

To make the most of Azure Boards, understand how your teams use their tools and functions (for example, Scrum, Kanban, and Scrumban), and their dependencies on configurations and customizations. The following table summarizes the primary items you should consider as you structure your project. 

| Project level                        |    Team level                                                     |
|---|---|
| How many teams do you want to define | How you use your product backlog to plan and prioritize your work |   
| How to structure area paths to support portfolio management views <br> | Whether you track bugs as requirements or as tasks, or not use bugs at all                                                                            |
| Field customization                  | Whether or not you use tasks to track time and capacity           |
| Custom work item types (WITs)        | How you use portfolio backlog levels                              |   
| Portfolio backlog customizations     | How you use portfolio backlog levels                              |
| Workflow customization               | How you inform upper management of progress, status, and risks    |   

### Azure Pipelines

Azure Pipelines provides a quick, easy, and safe way to automate building your projects with consistent and quality code that's readily available to users. 

Use Azure Pipelines to support the following scenarios: 

- Works with any language or platform 
- Deploys to different types of targets at the same time 
- Integrates with Azure deployments 
- Builds on Windows, Linux, or Mac machines 
- Integrates with GitHub 
- Works with open-source projects 

Azure Pipelines has extensive documentation, the best place to find complete documentation can be found here.  

Depending on your organizational needs there are four core architectures for Azure Pipelines. 

- [Azure Pipelines baseline architecture](/azure/devops/pipelines/architectures/devops-pipelines-baseline-architecture)
- [Azure Pipelines architecture for Azure Web Apps](/azure/devops/pipelines/architectures/devops-pipelines-azure-web-apps-architecture)
- [Azure Pipelines architecture with DevTest Labs](/azure/devops/pipelines/architectures/devops-pipelines-devtest-iaas-architecture)
- [Azure Pipelines architecture for IaaS](/azure/devops/pipelines/architectures/devops-pipelines-iaas-vms-architecture)

### Azure Repos

Azure Repos provides two types of version control: 
- [Git](/azure/devops/repos/get-started/what-is-repos#git)
- [Centralized version control](/azure/devops/repos/get-started/what-is-repos#tfvc)

Connect your favorite development environment to Azure Repos to access your code. Share your code using: 
- [Command-line](/azure/devops/repos/git/share-your-code-in-git-cmdline)
- [Visual Studio Code](/azure/devops/repos/git/share-your-code-in-git-cmdline)
- [Xcode](/azure/devops/repos/git/share-your-code-in-git-xcode)
- [Eclipse](/previous-versions/azure/devops/all/java/download-eclipse-plug-in)
- [IntelliJ](/previous-versions/azure/devops/all/java/download-intellij-plug-in)

[Full documentation for Azure Repos Git](/azure/devops/repos/git/)
[Team Foundation Version Control (TFVC) Documentation](/azure/devops/repos/tfvc/)

### Release pipelines and Artifact sources 

Azure Artifacts allow developers to publish and consume various types of packages from feeds and public registries like PyPI, Maven Central, and NuGet.org. You can combine Azure Artifacts with Azure Pipelines to publish build and pipeline artifacts, deploy packages, or integrate files across different stages of your pipeline for building, testing, or deploying your application. 

See current documentation: 

- [Artifacts in Azure Pipelines - overview](/azure/devops/pipelines/artifacts/artifacts-overview)
- [Release pipelines and Artifact sources](/azure/devops/pipelines/release/artifacts)

Additional recommended reading:
- [Get started with permissions and access](/azure/devops/organizations/security/about-permissions)

### Integration of Azure Policy with Azure DevOps

While Azure Policy directly applies to resources within Azure environments, its principles and governance can indirectly influence Azure DevOps practices. Here’s how: 

- Compliance in CI/CD pipelines: You can integrate compliance checks into your Azure Pipelines. For example, ensuring that any infrastructure deployed through Azure DevOps complies with the policies defined in Azure Policy.

- Environment consistency: By using Azure Policy to enforce specific configurations or resource types, teams can ensure that the environments they deploy to through Azure DevOps are consistent and compliant. 
- Security and governance: Policies can enforce security standards and governance practices on the resources managed by Azure DevOps Projects, ensuring that the development lifecycle includes compliance with organizational and regulatory standards. 

To effectively integrate Azure Policy with Azure DevOps, teams often use Azure Policy's compliance data and audit capabilities to inform their DevOps practices, making adjustments to their pipelines or IaC definitions to align with the organizational policies enforced through Azure Policy. 

This integration ensures that resources deployed and managed through Azure DevOps are always in compliance with the company's governance standards, enhancing security, consistency, and cost management across Azure environments. 

### Azure PowerShell and Azure CLI

#### Azure PowerShell

[Install Azure PowerShell on Linux](/powershell/azure/install-azps-linux)
[Using Azure PowerShell in a Docker container](/powershell/azure/azureps-in-docker)
[Azure PowerShell documentation](/powershell/azure)

#### Azure CLI

[Install Azure CLI on Linux](/cli/azure/install-azure-cli-linux)
[How to run the Azure CLI in a Docker container](/cli/azure/run-azure-cli-docker)
[Azure CLI documentation](/cli/azure)

