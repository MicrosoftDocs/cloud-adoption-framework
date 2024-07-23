---
title: Platform automation considerations for Red Hat Enterprise Linux on Azure
description: Learn about the tools, features, and services to automate various tasks and manage the Red Hat Enterprise Linux lifecycle within your Azure environment.
author: Paul Armstrong, Mike Savage, Michael Finkelstein, Robert Erenberg-Andersen, Alexander Bokovoy, and Joel Sisko
ms.author: AnthonyDelagarde
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

- A self-managed AAP instance either via on-premises infrastructure, cloud infrastructure, or both.
  - Via a RHEL deployment
  - Via a Red Hat OpenShift Container Platform deployment

- A self-managed AAP instance in a public cloud.
- A managed AAP instance in a public cloud.

### Red Hat AAP, self-managed, on-premises/cloud

Deploy [Red Hat AAP on Microsoft Azure](https://www.redhat.com/en/technologies/management/ansible/azure) in self-managed mode in an on-premises and/or cloud infrastructure to get the following benefits: 

- **Architecture and scale**: Determine your ideal architecture to support the automation platform, whether based on RHEL infrastructure or OpenShift operator deployment. Based on your fleet size and requirements, choose the number and the instance sizing of controllers, execution nodes, and private automation hub instances. For more information about architecture, design, configuration, and scale, see [Red Hat AAP planning guide](https://access.redhat.com/documentation/red_hat_ansible_automation_platform/2.4/html/red_hat_ansible_automation_platform_planning_guide/index). 

- **Azure configuration**:  Optimize the automation architecture for your organization's Azure design and configuration.
- **Automation mesh support**: Use this AAP feature to distribute automation workloads across hybrid cloud peer-to-peer connections by using existing networks. Place hop nodes in a location based on your security design criteria and network topology.
- **Automation hub architecture**: Optimize an automation hub architecture for scale and placement of private automation hub instances. Optimized configurations enhance secure automation content delivery and access to execution environment sources in close proximity to automation execution resources. Provide access to and manage Ansible content. Choose which Ansible content collections and versions are available to automation consumers.

### Red Hat AAP on Azure, managed or self-managed application 

[Red Hat AAP on Microsoft Azure](https://www.redhat.com/technologies/management/ansible/azure) is available via a managed application or self-managed application. AAP provides the following benefits:

- **Ease-of-use leads to rapid return on investment (ROI)**: You can deploy AAP on Azure directly from Azure Marketplace. This managed solution is active immediately after deployment, and you can start automating the management of your Azure resources in minutes. Red Hat manages the infrastructure, so you're free to think only about the systems that are critical to your enterprise.

- **Streamlined integration**: AAP on Azure is integrated with Azure services. The Ansible collection for Azure was developed and security tested by Microsoft and Red Hat for minimal setup and maximum support. Use AAP on Azure as part of your hybrid cloud automation strategy to unify management and automation across hybrid cloud, Internet of Things, and edge deployments.
- **Existing committed Azure spend**: You can use existing committed spending with Microsoft to purchase Red Hat AAP on Azure. Use committed spending so that teams across your entire organization can deploy, configure, and automate seamlessly. Integrated billing means you get one bill and full visibility into the cost. 
- **Automation beyond the cloud**: With AAP on Azure, you can deploy in your Microsoft Azure cloud and then extend across your infrastructure. Deploy, run, and scale applications across Azure and hybrid cloud environments.
- **Support**: Red Hat and Microsoft partnered to build AAP on Azure to ensure consistent and security-focused operations. Red Hat manages, services, and supports the application so that your IT team can focus on delivering automation strategies. 

### Other considerations for managed mode

AAP on Microsoft Azure in managed mode is installed as a managed application. Red Hat manages both the underlying Azure resources and the software that runs on it. That infrastructure runs in your Azure tenant.

The managed application resource group is separate from other resource groups in your tenant. Red Hat only has access to the managed application resource group, with no visibility into other tenant resources.

For information about this implementation, see [Azure managed applications overview](/azure/azure-resource-manager/managed-applications/overview). 	

AAP on Microsoft Azure in managed mode uses the following resource groups:

- *A new or existing resource group in your tenant*. This resource group includes a single resource that refers to the AAP on Microsoft Azure managed application deployment. Red Hat has access to the managed app to perform support, maintenance, and upgrades. But the resource group is outside of Red Hat's management.
	
- *A multitenant managed resource group (MRG)* that contains most of the required infrastructure to operate AAP on Microsoft Azure. The Red Hat tenant and your tenant shares this multitenant resource group. Red Hat has full administrative control. You have read-only access to the resource group. 
- *An AKS node pool resource group (NPRG)*. Microsoft requires an NPRG for AKS deployments. An NPRG contains resources that AKS uses to function. This resource group is created on deployment, and it's outside of Red Hat's management. For more information, see [Microsoft AKS documentation](/azure/aks/faq#why-are-two-resource-groups-created-with-aks).

For AAP on Microsoft Azure in managed mode, also consider: 

- When you install AAP on Microsoft Azure, you choose whether the deployment is public or private. This affects how users can access the AAP user interfaces.
 
- Regardless of whether you choose a public or private deployment, you must configure network peering for outbound communication from AAP to the private networks that contain resources that you want to automate against. You can configure network peering from AAP on Microsoft Azure to your private Azure virtual network and to on-premises or multicloud networks where transit routing with Azure exists. 

### Other considerations for self-managed mode 

AAP on Microsoft Azure in self-managed mode provides many of the same benefits of self-managed AAP. But where managed mode runs within an AKS cluster, self-managed mode automation platform resources are VM-based.

For AAP on Microsoft Azure in self-managed mode, also consider: 

- Event-Driven Ansible is included in the self-managed offering on Azure. Event-driven automation helps you reduce manual tasks and deliver an efficient IT environment that focuses on innovation. Event-Driven Ansible processes events, determines the appropriate responses, and then runs automated actions to remediate the event.

- Offers - Available in 100 active managed node increments, and this is available in both public offers, or private offers. 
- VM resources that underpin AAP on Microsoft Azure in self-managed mode can consist entirely of Azure Marketplace images or a mix of Azure Marketplace images and customer-managed images. 

## Design recommendations

When you operate the RHEL Platform for Azure landing zones, use Red Hat-certified content and validated content collections from Red Hat Automation Hub. The following collections have prominent roles in the automation framework:

- redhat.rhel_idm
  - IdM primary configuration
  - IdM replicas configuration 
  - Integration and configuration of RHEL clients with IdM

- redhat.satellite  |  redhat.satellite_operations  |  redhat.rhel_system_roles 
  - Deploy Satellite and Capsule
  - Create and configure Satellite objects and settings 
  - Provision and configure RHEL systems 

- ansible.*  |  ansible.controller  |  infra.controller_configuration 
  - Configure AAP 
  - Create and configure AAP job templates and settings 

[The Ansible collection for Azure](https://catalog.redhat.com/software/collection/azure/azcollection?tab=documentation) includes over 250 modules to interrogate, manage, and automate Azure resource types, such as:

- Microsoft Entra ID
- Networking
- Azure SQL Database
- AKS
- Storage
- Application security groups
- Azure Virtual Machines
- Azure database services
- Azure Container Registry
- Azure Key Vault

### Core platform infrastructure deployment

Establish concepts and processes to effectively deploy core platform infrastructure and support an RHEL Platform on Azure landing zones model.

For more information, see:

- [Azure landing zone design guidance for platform automation considerations](/azure/cloud-adoption-framework/ready/considerations/automation).

- [Development lifecycle](/azure/cloud-adoption-framework/ready/considerations/development-strategy-development-lifecycle). Explore key design considerations and recommendations about using automation to create a landing zone. This guidance discusses the repository, branch, automated builds, deployment, and rollback strategy.

- [IaC](/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code). Explore the benefits of implementing Azure landing zones via IaC. Learn about considerations related to code structure, tools, and technology. 
- [Environments](/azure/cloud-adoption-framework/ready/considerations/environments). Explore the purpose of using multiple environments to build, test, and release code with greater speed and frequency. This approach makes deployment as straightforward as possible.
- [Test-driven development](/azure/cloud-adoption-framework/ready/considerations/development-strategy-test-driven-development). Learn how to use unit testing to improve the quality of new features and improvements in the Azure landing zone codebase. 

If you have the requisite source code management tooling in place and the source code management processes established from the previous sections, you can implement automation. Develop Ansible automation code with accompanying IaC or configuration as code to deploy core infrastructure and support the RHEL Platform for Azure landing zones model. For greenfield deployments, you can automate the following tasks for a full environment implementation. Brownfield deployments only need the tasks that your use case requires.

- Create Azure resource groups.

- Create virtual networks.
- Create subnets. 
- Create network security groups.
- Create RHEL 8.x and 9.x golden images for Azure via automated Red Hat Image Builder.
- Create an IdM primary VM (pre-Satellite provisioning). Configure the IdM primary VM via configuration as code.
- Create a Satellite VM (pre-Satellite provisioning). Configure Satellite via configuration as code.
- Create Capsule VMs (Satellite provisioning). Configure Capsules via configuration as code.
- Create IdM replica VMs (Satellite provisioning). Configure IdM replicas via configuration as code.
- Create AAP infrastructure (Satellite provisioning), including:
    - Automation controller VMs.
    - Execution node VMs.
    - Hop node VMs (optional).
    - Automation Hub VMs.
    - Event-Driven Ansible VMs (if enabled).
    - Azure Database for PostgreSQL Server and necessary databases for the controller, Hub, and Event-Driven Ansible components. High availability or disaster recovery Azure Database for PostgreSQL configurations require additional automation, either via replication shipping, log shipping, or [Crunchy Postgres](https://www.crunchydata.com/solutions/ansible).
- Create load balancers (application gateways).
    - Front end for Capsule VMs 
    - Front end for AAP controller VMs 
    - Front end for Automation Hub VMs 
- Create application security groups.
    - IdM infrastructure
    - AAP infrastructure
    - Satellite or Capsule infrastructure 

### RHEL system lifecycle management  

After core platform infrastructure is in place, you can implement automation for RHEL applications and workload lifecycles. Refer to 'Deployment, management, and patching considerations' and 'Governance and compliance' sections for in-depth coverage of considerations to be made when forming automation pipelines. The following encapsulates an example automation workflow for a development lifecycle pipeline:

- Update the errata filter end date, and publish content in Satellite.

- Promote content views (CV) and composite content views (CCV) to development.
- Deploy RHEL development test systems from Satellite host groups.
    - RHEL 8.x and 9.x golden images for Azure via automated Red Hat Image Builder are defined as Azure compute resources in Satellite. 
- Update or create Azure network security groups based on application communication paths.
- For multi-tier application stacks, update or create Azure application security groups for extra layered security.
- Update RHEL development systems, and deploy and configure desired applications from Satellite development CV or CCV.
  - Deploy to single RHEL instance for a simple application stack.
  - Deploy to several RHEL instances for multi-tier application stacks.
  - Configure an application stack.
- Run an application testing framework.
  - On failure, notify OnCall automation administration to assist in troubleshooting and analysis. Exit the automation workflow. RHEL test systems remain deployed for post-mortem failure analysis.
  - On test success, continue.
- Promote CVs and CCVs to quality assurance (QA).
- Destroy RHEL development test systems.

Subsequent stages in the lifecycle pipeline are slightly different from the development lifecycle stage. Only the development stage uses the initial content publishing and initial CV and CCV promotion to development. The following example describes an automation workflow for non-development lifecycle pipelines, for example QA, pre-production, and  production pipelines.

- Deploy RHEL QA test systems from Satellite host groups.
  - RHEL 8.x and 9.x golden images for Azure via automated Red Hat Image Builder are defined as Azure compute resources in Satellite.
       
- Update or create Azure network security groups based on application communication paths.
  - For multi-tier application stacks, update or create Azure application security groups for extra layered security. 
- Update RHEL QA systems, and deploy and configure desired applications from Satellite QA CV or CCV.
  - Deploy to a single RHEL instance for a simple application stack.
  - Deploy to several RHEL instances for multi-tier application stacks. 
  - Configure an application stack.
  - Run an application testing framework.
    - On failure, notify OnCall automation administration to assist in troubleshooting and analysis. Exit the automation workflow. RHEL test systems remain deployed for post-mortem failure analysis.
    - On test success, continue.
  - Promote CVs and CCVs to production.
  - Destroy RHEL QA test systems.

## Other design considerations for Azure-native tooling           

### Azure Automation

To automate frequent, time-consuming, and error-prone management tasks, you can use the process automation feature in Azure Automation. This feature helps you focus on work that adds business value. Process automation reduces errors and boosts efficiency, which helps lower your operational costs. For more information, see [Automation overview](/azure/automation/overview). 

Process automation supports the integration of Azure services and other partner systems, such as Red Hat, that you need to deploy, configure, and manage your end-to-end processes. You can also use this feature to author graphical PowerShell and Python [runbooks](/azure/automation/automation-runbook-types).  

You can use runbooks for a wide range of automation tasks, like managing resources, starting and stopping VMs, and handling maintenance tasks both within Azure and outside Azure. To review the authentication scenarios,  [Azure Automation account authentication overview](/azure/automation/automation-security-overview). For more information, see [Runbook execution in Azure Automation](/azure/automation/automation-runbook-execution). 

The following table describes the supported runbook types. 

| Runbook type | Description |
|---|---|
| [PowerShell](/azure/automation/automation-runbook-types#powershell-runbooks) | A textual runbook that's based on Windows PowerShell scripting. The currently supported versions are: PowerShell 7.2 (GA) and PowerShell 5.1 (GA). PowerShell 7.1 is no longer supported by parent product PowerShell, so we recommend that you create runbooks in the long-term supported version PowerShell 7.2. |
[PowerShell Workflow](/azure/automation/automation-runbook-types#powershell-workflow-runbooks) | A textual runbook that's based on Windows PowerShell Workflow scripting. |
[Python](/azure/automation/automation-runbook-types#python-runbooks) | A textual runbook that's based on Python scripting. The currently supported versions are: Python 3.8 (GA) and Python 3.10 (preview). Python 2.7 is no longer supported by parent product Python, so we recommend that you create runbooks in long-term supported versions. |
[Graphical](/azure/automation/automation-runbook-types#graphical-runbooks) | A graphical runbook that's based on Windows PowerShell and created and edited completely in the graphical editor in the Azure portal. |
[Graphical PowerShell Workflow](/azure/automation/automation-runbook-types#graphical-runbooks) | A graphical runbook that's based on Windows PowerShell Workflow and created and edited completely in the graphical editor in the Azure portal. |

Use [webhooks](/azure/automation/automation-webhooks) to fulfill requests and ensure continuous delivery and operations by triggering automation via Azure Logic Apps, Azure Functions, IT service management products or services, DevOps, or monitoring systems.

Azure Arc represents a significant advancement in cloud computing and offers a unified management platform that extends Azure capabilities to on-premises, multi-cloud, and edge environments. Azure Arc integrates with the Azure Automation service via the VM extension framework to deploy the hybrid runbook worker role and simplify onboarding to the update management, change tracking, and inventory features.

:::image type="content" source="images/rhel-platform-automation-devops/arc-ecosystem.png" alt-text="Diagram that shows the Azure Arc ecosystem." border="false" lightbox="images/rhel-platform-automation-devops/arc-ecosystem.png":::

For more information, see [Connect an existing Linux server to Azure Arc](/azure/cloud-adoption-framework/manage/hybrid/server/best-practices/onboard-server-linux).

### ARM templates

IaC via ARM templates provides a consistent declarative method to deploy and manage Azure resources. Use this feature to define the required infrastructure for your applications in a JSON format. ARM templates are idempotent, meaning you can deploy the same template many times and get the same resource types in the same state. 

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

Azure DevOps is a comprehensive set of development tools to provide project management, continuous integration and continuous delivery (CI/CD) services, and source code repositories for both cloud and on-premises environments. Combing these features along with Azure Test Plans, Azure Artifacts, Logic Apps, and Azure Functions facilitate seamless collaboration, development, and delivery of modern software projects.

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
- [Git](/azure/devops/repos/get-started/what-is-reposs#git)
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

While Azure Policy directly applies to resources within Azure environments, its principles and governance can indirectly influence Azure DevOps practices. Here's how: 

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

[Install Azure CLI on Linux](/cli/azure/install-azure-cli-linuxs)
[How to run the Azure CLI in a Docker container](/cli/azure/run-azure-cli-docker)
[Azure CLI documentation](/cli/azure)

