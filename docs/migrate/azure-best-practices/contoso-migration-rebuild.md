---
title: Rebuild an on-premises application in Azure
description: Learn how Contoso rebuilds an application in Azure by using Azure App Service, Azure Kubernetes Service (AKS), Azure Cosmos DB, Azure Functions, and Azure Cognitive Services.
author: BrianBlanchard
ms.author: brblanch
ms.date: 7/1/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Rebuild an on-premises application in Azure

This article demonstrates how the fictional company Contoso rebuilds a two-tier Windows .NET application that's running on VMware virtual machines (VMs) as part of a migration to Azure. Contoso migrates the front-end VM to an Azure App Service web app. Contoso builds the application back end by using microservices that are deployed to containers managed by Azure Kubernetes Service (AKS). The site interacts with Azure Functions to provide pet photo functionality.

The SmartHotel360 application used in this example is provided under an open-source license. If you want to use it for your own testing purposes, you can download it from [GitHub](https://github.com/Microsoft/SmartHotel360).

## Business drivers

The Contoso IT leadership team has worked closely with business partners to understand what they want to achieve with this migration:

- **Address business growth.** Contoso is growing and wants to provide differentiated experiences for customers on Contoso websites.
- **Be agile.** Contoso must be able to react faster than the changes in the marketplace to enable their success in a global economy.
- **Scale.** As the business grows successfully, the Contoso IT team must provide systems that can grow at the same pace.
- **Reduce costs.** Contoso wants to minimize licensing costs.

## Migration goals

The Contoso cloud team has pinned down application requirements for this migration. These requirements were used to determine the best migration method:

- The application in Azure must remain as critical as it is today on-premises. It should perform well and scale easily.
- The application shouldn't use infrastructure as a service (IaaS) components. Everything should be built to use platform as a service (PaaS) or serverless services.
- Application builds should run in cloud services, and containers should reside in a private, enterprise-wide registry in the cloud.
- The API service that's used for pet photos should be accurate and reliable in the real world, because decisions made by the application must be honored in their hotels. Any pet granted access is allowed to stay at the hotels.
- To meet requirements for a DevOps pipeline, Contoso will use a Git repository in Azure Repos for source code management. Automated builds and releases will be used to build code and deploy to Azure App Service, Azure Functions, and AKS.
- Separate continuous integration/continuous development (CI/CD) pipelines are needed for microservices on the back end and for the website on the front end.
- The back-end services and the front-end web app have different release cycles. To meet this requirement, Contoso will deploy two different pipelines.
- Contoso needs management approval for all front-end website deployment, and the CI/CD pipeline must provide this.

## Solution design

After pinning down their goals and requirements, Contoso designs and reviews a deployment solution, and identifies the migration process, including the Azure services that will be used for the migration.

### Current application

- The SmartHotel360 on-premises application is tiered across two VMs (`WEBVM` and `SQLVM`).
- The VMs are located on VMware ESXi host `contosohost1.contoso.com` (version 6.5).
- The VMware environment is managed by vCenter Server 6.5 (`vcenter.contoso.com`), running on a VM.
- Contoso has an on-premises datacenter (`contoso-datacenter`), with an on-premises domain controller (`contosodc1`).
- The on-premises VMs in the Contoso datacenter will be decommissioned after the migration is done.

### Proposed architecture

- The front end of the application is deployed as an Azure App Service web app in the primary Azure region.
- An Azure function provides uploads of pet photos, and the site interacts with this functionality.
- The pet photo function uses the Computer Vision API of Azure Cognitive Services along with Azure Cosmos DB.
- The back end of the site is built by using microservices. These microservices will be deployed to containers that are managed in AKS.
- Containers will be built using Azure DevOps and then pushed to Azure Container Registry.
- For now, Contoso will manually deploy the web app and function code by using Visual Studio.
- Contoso will deploy microservices by using a PowerShell script that calls Kubernetes command-line tools.

    ![Diagram of scenario architecture for migration to Azure.](./media/contoso-migration-rebuild/architecture.png)
    *Figure 1: Scenario architecture.*

### Solution review

Contoso evaluates the proposed design by putting together a pros and cons list.

| Consideration | Details |
| --- | --- |
| **Pros** | Using PaaS and serverless solutions for the end-to-end deployment significantly reduces the management time that Contoso must provide. <br><br> Moving to a microservices-based architecture allows Contoso to easily extend the solution over time. <br><br> New functionality can be brought online without disrupting any of the existing solutions' code bases. <br><br> The web app will be configured with multiple instances, with no single point of failure. <br><br> Autoscaling will be enabled so that the application can handle differing traffic volumes. <br><br> With the move to PaaS services, Contoso can retire out-of-date solutions that run on the Windows Server 2008 R2 operating system. <br><br> Azure Cosmos DB has built-in fault tolerance, which requires no configuration by Contoso. This means that the data tier is no longer a single point of failover. |
| **Cons** | Containers are more complex than other migration options. The learning curve could be an issue for Contoso. They introduce a new level of complexity that provides value in spite of the curve. <br><br> The operations team at Contoso needs to ramp up to understand and support Azure, containers, and microservices for the application. <br><br> Contoso hasn't fully implemented DevOps for the entire solution. Contoso needs to consider that for the deployment of services to AKS, Azure Functions, and Azure App Service. |

### Migration process

1. Contoso provisions Azure Container Registry, AKS, and Azure Cosmos DB.
2. Contoso provisions the infrastructure for the deployment, including the Azure App Service web app, storage account, function, and API.
3. After the infrastructure is in place, Contoso builds their microservices container images by using Azure DevOps, which pushes the images to the container registry.
4. Contoso deploys these microservices to AKS by using a PowerShell script.
5. Finally, Contoso deploys the function and web app.

    ![Diagram of the migration process from preparation to deployment in the cloud.](./media/contoso-migration-rebuild/migration-process.png)
    *Figure 2: The migration process.*

### Azure services

| Service | Description | Cost |
|---|---|---|
| [Azure Kubernetes Service](https://azure.microsoft.com/services/kubernetes-service/) | Simplifies Kubernetes management, deployment, and operations. Provides a fully managed Kubernetes container orchestration service. | AKS is a free service. Pay for only the VMs and the associated storage and networking resources that are consumed. [Learn more](https://azure.microsoft.com/pricing/details/kubernetes-service/). |
| [Azure Functions](https://azure.microsoft.com/services/functions/) | Accelerates development with an event-driven, serverless compute experience. Scale on demand. | Pay only for consumed resources. Plan is billed based on per-second resource consumption and executions. [Learn more](https://azure.microsoft.com/pricing/details/functions/). |
| [Azure Container Registry](https://azure.microsoft.com/services/container-registry/) | Stores images for all types of container deployments. | Cost is based on features, storage, and usage duration. [Learn more](https://azure.microsoft.com/pricing/details/container-registry/). |
| [Azure App Service](https://azure.microsoft.com/services/app-service/) | Quickly build, deploy, and scale enterprise-grade web, mobile, and API apps that run on any platform. | App Service plans are billed on a per-second basis. [Learn more](https://azure.microsoft.com/pricing/details/app-service/windows/). |

## Prerequisites

Here's what Contoso needs for this scenario:

| Requirements | Details |
| --- | --- |
| Azure subscription | <li> Contoso created subscriptions in an earlier article. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/). <li> If you create a free account, you're the admin of your subscription and can perform all actions. <li> If you use an existing subscription and you're not the admin, you need to work with the admin to assign Owner or Contributor permissions to you. |
| Azure infrastructure | <li> Learn [how Contoso set up an Azure infrastructure](./contoso-migration-infrastructure.md). |
| Developer prerequisites | Contoso needs the following tools on a developer workstation: <li> [Visual Studio Community 2017 version 15.5](https://visualstudio.microsoft.com/vs/community/) <li> .NET workload, enabled <li> [Git](https://git-scm.com) <li> [Azure PowerShell](https://azure.microsoft.com/downloads/) <li> [The Azure CLI](/cli/azure/install-azure-cli) <li> [Docker Community Edition (Windows 10) or Docker Enterprise Edition (Windows Server)](https://docs.docker.com/docker-for-windows/install/), set to use Windows containers |

## Scenario steps

Here's how Contoso will run the migration:

> [!div class="checklist"]
>
> - **Step 1: Provision AKS and Azure Container Registry.** Contoso provisions the managed AKS cluster and the container registry by using PowerShell.
> - **Step 2: Build Docker containers.** Contoso sets up continuous integration (CI) for Docker containers by using Azure DevOps and pushes the containers to the container registry.
> - **Step 3: Deploy back-end microservices.** Contoso deploys the rest of the infrastructure that will be used by back-end microservices.
> - **Step 4: Deploy front-end infrastructure.** Contoso deploys the front-end infrastructure, including Blob Storage for the pet phones, Azure Cosmos DB, and the Computer Vision API.
> - **Step 5: Migrate the back end.** Contoso deploys microservices and runs them on AKS to migrate the back end.
> - **Step 6: Publish the front end.** Contoso publishes the SmartHotel360 application to Azure App Service along with the function app to be called by the pet service.

## Provision back-end resources

Contoso admins run a deployment script to create the managed Kubernetes cluster by using AKS and Azure Container Registry. The instructions for this section use the [`SmartHotel360-Backend`](https://github.com/Microsoft/SmartHotel360-Backend) GitHub repository. The repository contains all the software for this part of the deployment.

### Ensure that prerequisites are met

Before they start, Contoso admins ensure that all prerequisite software is installed on the dev machine they're using for the deployment. They clone the repository locally to the dev machine by using Git:

`git clone https://github.com/Microsoft/SmartHotel360-Backend.git`

### Provision AKS and Azure Container Registry

The Contoso admins provision AKS and Azure Container Registry as follows:

1. In Visual Studio Code, they open the folder and go to the `/deploy/k8s` directory, which contains the script `gen-aks-env.ps1`.

2. They run the script to create the managed Kubernetes cluster, using AKS and Azure Container Registry.

    ![Screenshot showing the AKS script in Visual Studio Code.](./media/contoso-migration-rebuild/aks1.png)
    *Figure 3: Creating the managed Kubernetes cluster.*

3. With the file open, they update the $location parameter to `eastus2`, and save the file.

    ![Screenshot showing AKS $location parameter updated to eastus2.](./media/contoso-migration-rebuild/aks2.png)
    *Figure 4: Saving the file.*

4. They select **View** > **Integrated terminal** to open the integrated terminal in Visual Studio Code.

    ![Screenshot showing the **Integrated Terminal** link.](./media/contoso-migration-rebuild/aks3.png)
    *Figure 5: The terminal in Visual Studio Code.*

5. In the PowerShell integrated terminal, they sign in to Azure using the `Connect-AzureRmAccount` command. For more information, see [Get started with PowerShell](/powershell/azure/get-started-azureps).

    ![Screenshot of the sign-in window for the PowerShell integrated terminal.](./media/contoso-migration-rebuild/aks4.png)
    *Figure 6: The PowerShell integrated terminal.*

6. They authenticate the Azure CLI by running the `az login` command and following the instructions to authenticate using their web browser. Learn more about [signing in with the Azure CLI](/cli/azure/authenticate-azure-cli).

    ![Screenshot showing the authentication window for the Azure CLI.](./media/contoso-migration-rebuild/aks5.png)
    *Figure 7: Authenticating the Azure CLI.*

7. They run the following command while passing the resource group name of `ContosoRG`, the name of the AKS cluster `smarthotel-aks-eus2`, and the new registry name.

    `.\gen-aks-env.ps1  -resourceGroupName ContosoRg -orchestratorName smarthotelakseus2 -registryName smarthotelacreus2`

    ![Screenshot showing the smarthotel commands on the resource group pane.](./media/contoso-migration-rebuild/aks6.png)
    *Figure 8: Running the command.*

8. Azure creates another resource group that contains the resources for the AKS cluster.

    ![Screenshot of resource group creation.](./media/contoso-migration-rebuild/aks7.png)
    *Figure 9: Azure creating a resource group.*

9. After the deployment is finished, they install the `kubectl` command-line tool. The tool is already installed on the Azure Cloud Shell.

    `az aks install-cli`

10. They verify the connection to the cluster by running the `kubectl get nodes` command. The node has the same name as the VM in the automatically created resource group.

    ![Screenshot showing verification of the connection to the cluster.](./media/contoso-migration-rebuild/aks8.png)
    *Figure 10: Verifying the connection to the cluster.*

11. They run the following command to start the Kubernetes dashboard:

    `az aks browse --resource-group ContosoRG --name smarthotelakseus2`

12. A browser tab opens to the dashboard. This is a tunneled connection that uses the Azure CLI.

    ![Screenshot showing a tunneled connection.](./media/contoso-migration-rebuild/aks9.png)
    *Figure 11: A tunneled connection.*

## Step 2: Configure the back-end pipeline

### Create an Azure DevOps project and build

Contoso creates an Azure DevOps project, configures a CI build to create the container, and then pushes it to the container registry. The instructions in this section use the [`SmartHotel360-Backend`](https://github.com/Microsoft/SmartHotel360-Backend) repository.

1. From `visualstudio.com`, they create a new organization (`contosodevops360.visualstudio.com`) and configure it to use Git.

2. They create a new project (`SmartHotelBackend`), selecting **Git** for version control and **Agile** for the workflow.

    ![Screenshot of the Azure DevOps **Create new project** pane.](./media/contoso-migration-rebuild/vsts1.png)
    *Figure 12: Creating a new project.*

3. They import the [GitHub repo](https://github.com/Microsoft/SmartHotel360-Backend).

    ![Screenshot of the Azure DevOps **Import a Git repository** pane.](./media/contoso-migration-rebuild/vsts2.png)
    *Figure 13: Importing the GitHub repo.*

4. In **Pipelines**, they select **Build** and create a new pipeline by using Azure Repos Git as a source from the repository.

    ![Screenshot of DevOps pane for creating a new pipeline.](./media/contoso-migration-rebuild/vsts3.png)
    *Figure 14: Creating a new pipeline.*

5. They select **Empty job**.

    ![Screenshot of the **Empty job** link in Azure DevOps.](./media/contoso-migration-rebuild/vsts4.png)
    *Figure 15: Starting with an empty job.*

6. They select **Hosted Linux Preview** for the build pipeline.

    ![Screenshot of setting up the build pipeline in Azure DevOps.](./media/contoso-migration-rebuild/vsts5.png)
    *Figure 16: Setting up the build pipeline.*

7. In **Step 1**, they add a **Docker Compose** task. This task builds the Docker Compose.

    ![Screenshot of building a Docker Compose task in Azure DevOps.](./media/contoso-migration-rebuild/vsts6.png)
    *Figure 17: Building the Docker Compose.*

8. They repeat and add another **Docker Compose** task. This one pushes the containers to the container registry.

     ![Screenshot of adding another Docker Compose task in Azure DevOps.](./media/contoso-migration-rebuild/vsts7.png)
    *Figure 18: Adding another Docker Compose task.*

9. They select the first task to build and configure the build with the Azure subscription, authorization, and Container Registry.

    ![Screenshot of building and configuring the build in Azure DevOps.](./media/contoso-migration-rebuild/vsts8.png)
    *Figure 19: Building and configuring the build.*

10. They specify the path of the `docker-compose.yaml` file in the `src` folder of the repo. They choose to build service images and include the latest tag. When the action changes to **Build service images**, the name of the Azure DevOps task changes to **Build services automatically**.

    ![Screenshot of various task-building specifics in Azure DevOps.](./media/contoso-migration-rebuild/vsts9.png)
    *Figure 20: The specifics of the task.*

11. Now, they configure the second Docker task (to push). They select the subscription and the container registry (`smarthotelacreus2`).

    ![Screenshot of configuring the second Docker task in Azure DevOps.](./media/contoso-migration-rebuild/vsts10.png)
    *Figure 21: Configuring the second Docker task.*

12. They enter the `docker-compose.yaml` file name and select **Push service images**, including the latest tag. When the action changes to **Push service images**, the name of the Azure DevOps task changes to **Push services automatically**.

    ![Screenshot of changing the Azure DevOps task name.](./media/contoso-migration-rebuild/vsts11.png)
    *Figure 22: Changing the Azure DevOps task name.*

13. With the Azure DevOps tasks configured, Contoso saves the build pipeline and starts the build process.

    ![Screenshot of starting the build process in Azure DevOps.](./media/contoso-migration-rebuild/vsts12.png)
    *Figure 23: Starting the build process.*

14. They select the build job to check progress.

    ![Screenshot of checking build progress in Azure DevOps.](./media/contoso-migration-rebuild/vsts13.png)
    *Figure 24: Checking the progress.*

15. After the build finishes, the container registry shows the new repos, which are populated with the containers used by the microservices.

    ![Screenshot of viewing new repos after the build finishes in Azure DevOps.](./media/contoso-migration-rebuild/vsts14.png)
    *Figure 25: Viewing new repos after the build finishes.*

### Deploy the back-end infrastructure

With the AKS cluster created and the Docker images built, Contoso admins now deploy the rest of the infrastructure that will be used by back-end microservices.

- Instructions in this section use the [`SmartHotel360-Backend`](https://github.com/Microsoft/SmartHotel360-Backend) repo.
- In the `/deploy/k8s/arm` folder, there's a single script to create all items.

The admins deploy the infrastructure as follows:

1. They open a developer command prompt and then use the command `az login` for the Azure subscription.

2. They use the `deploy.cmd` file to deploy the Azure resources in the `ContosoRG` resource group and `East US 2` region by typing the following command:

    `.\deploy.cmd azuredeploy ContosoRG -c eastus2`

    ![Screenshot of deploying the back end.](./media/contoso-migration-rebuild/backend1.png)
    *Figure 26: Deploying the back end.*

3. In the Azure portal, they capture the connection string for each database for later use.

    ![Screenshot showing the connection string for each database.](./media/contoso-migration-rebuild/backend2.png)
    *Figure 27: Capturing the connection string for each database.*

### Create the back-end release pipeline

Now, Contoso admins do the following:

- Deploy the NGINX ingress controller to allow inbound traffic to the services.
- Deploy the microservices to the AKS cluster.
- As a first step, admins update the connection strings to the microservices by using Azure DevOps. They then configure a new Azure DevOps release pipeline to deploy the microservices.
- The instructions in this section use the [`SmartHotel360-Backend`](https://github.com/Microsoft/SmartHotel360-Backend) repo.
- Some of the configuration settings (for example, Active Directory B2C) aren't covered in this article. For more information about these settings, review the previously mentioned `SmartHotel360-Backend` repo.

The admins create the pipeline:

1. In Visual Studio, they update the `/deploy/k8s/config_local.yml` file with the database connection information that they noted earlier.

2. They open Azure DevOps and, in the `SmartHotel360` project, they select **+ New pipeline** on the **Releases** pane.

    ![Screenshot showing the **New pipeline** button in Azure DevOps.](./media/contoso-migration-rebuild/back-pipe2.png)
    *Figure 29: Creating a new pipeline.*

3. They select **Empty Job** to start the pipeline without a template.
4. They provide the stage and pipeline names.

      ![Screenshot showing creation of a stage name in Azure DevOps.](./media/contoso-migration-rebuild/back-pipe4.png)
    *Figure 30: The stage name.*

      ![Screenshot showing creation of a pipeline name in Azure DevOps.](./media/contoso-migration-rebuild/back-pipe5.png)
    *Figure 31: The pipeline name.*

5. They add an artifact.

     ![Screenshot showing adding an artifact in Azure DevOps.](./media/contoso-migration-rebuild/back-pipe6.png)
    *Figure 32: Adding an artifact.*

6. They select **Git** as the source type and specify the project, source, and main branch for the SmartHotel360 application.

    ![Screenshot of the **Add an artifact** pane, with Git as the source type.](./media/contoso-migration-rebuild/back-pipe7.png)
    *Figure 33: The artifact settings pane.*

7. They select the task link.

    ![Screenshot showing the task link highlighted in Azure DevOps.](./media/contoso-migration-rebuild/back-pipe8.png)
    *Figure 34: The task link.*

8. They add a new Azure PowerShell task so that they can run a PowerShell script in an Azure environment.

    ![Screenshot of adding a new PowerShell task in Azure.](./media/contoso-migration-rebuild/back-pipe9.png)
    *Figure 35: Adding a new PowerShell task.*

9. They select the Azure subscription for the task and select the `deploy.ps1` script from the Git repo.

    ![Screenshot of selecting a script to run from the Git repo.](./media/contoso-migration-rebuild/back-pipe10.png)
    *Figure 36: Running the script.*

10. They add arguments to the script. The script will delete all cluster content (except **ingress** and **ingress controller**), and deploy the microservices.

    ![Screenshot showing arguments to be added to the script.](./media/contoso-migration-rebuild/back-pipe11.png)
    *Figure 37: Adding arguments to the script.*

11. They set the preferred Azure PowerShell version to the latest version, and save the pipeline.

12. They go back to the **Create a new release** pane and manually create a new release.

    ![Screenshot of the **Create a new release** pane.](./media/contoso-migration-rebuild/back-pipe12.png)
    *Figure 38: Manually creating a new release.*

13. After they create the release, they select it and, under **Actions**, they select **Deploy**.

      ![Screenshot highlighting the **Deploy** button for deploying a release.](./media/contoso-migration-rebuild/back-pipe13.png)
    *Figure 39: Deploying a release.*

14. When the deployment is complete, they run the following command to check the status of services, using the Azure Cloud Shell: `kubectl get services`.

## Step 3: Provision front-end services

Contoso admins need to deploy the infrastructure that will be used by the front-end applications. They create:

- A Blob Storage container to store the pet images.
- An Azure Cosmos DB database to store documents containing pet information.
- The Computer Vision API for the website.

Instructions for this section use the [`SmartHotel360-Website`](https://github.com/microsoft/SmartHotel360-Website) repo.

### Create Blob Storage containers

1. In the Azure portal, the admins open the storage account that was created, and then select **Blobs**.
2. They create a new container named `Pets` with the public-access level set for the container. Users will upload their pet photos to this container.

    ![Screenshot of creating a new container in the Azure portal.](./media/contoso-migration-rebuild/blob1.png)
    *Figure 40: Creating a new container.*

3. They create a second new container named `settings`. A file with all the front-end app settings will be placed in this container.

    ![Screenshot of creating a second new container in the Azure portal.](./media/contoso-migration-rebuild/blob2.png)
    *Figure 41: Creating a second container.*

4. They capture the access details for the storage account in a text file for future reference.

    ![Screenshot of a text file capturing access details.](./media/contoso-migration-rebuild/blob3.png)
    *Figure 42: A text file capturing access details.*

### Provision an Azure Cosmos DB database

Contoso admins provision an Azure Cosmos DB database to be used for pet information.

1. They create an **Azure Cosmos DB** database in Azure Marketplace.

    ![Screenshot showing the creation of an Azure Cosmos DB database in Azure Marketplace.](./media/contoso-migration-rebuild/cosmos1.png)
    *Figure 43: Creating an Azure Cosmos DB database.*

2. They specify a name `contososmarthotel`, select the SQL API, and place it in the production resource group `ContosoRG` in the main region `East US 2`.

    ![Screenshot of the Azure Cosmos DB database name and other settings.](./media/contoso-migration-rebuild/cosmos2.png)
    *Figure 44: Naming an Azure Cosmos DB database.*

3. They add a new collection to the database, with default capacity and throughput.

    ![Screenshot of the **Add Collection** pane for Azure Cosmos DB.](./media/contoso-migration-rebuild/cosmos3.png)
    *Figure 45: Adding a new collection to the database.*

4. They note the connection information for the database for future reference.

    ![Screenshot of the connection information for the Azure Cosmos DB database.](./media/contoso-migration-rebuild/cosmos4.png)
    *Figure 46: The connection information for the database.*

### Provision the Computer Vision API

Contoso admins provision the Computer Vision API. The API will be called by the function, to evaluate pictures that are uploaded by users.

1. The admins create a **Computer Vision** instance in Azure Marketplace.

     ![Screenshot of creating a new computer vision instance in Azure Marketplace.](./media/contoso-migration-rebuild/vision1.png)
    *Figure 47: A new instance in Azure Marketplace.*

2. They provision the API (`smarthotelpets`) in the production resource group `ContosoRG`, in the main region (`East US 2`).

    ![Screenshot of setting up an API in a production resource group.](./media/contoso-migration-rebuild/vision2.png)
    *Figure 48: Provisioning an API in a production resource group.*

3. They save the connection settings for the API to a text file for later reference.

     ![Screenshot of saving the API connection settings to a text file.](./media/contoso-migration-rebuild/vision3.png)
    *Figure 49: Saving the API connection settings.*

### Provision the Azure web app

Contoso admins provision the web app by using the Azure portal.

1. They select **Web App** in the portal.

    ![Screenshot of selecting a web app in the Azure portal.](./media/contoso-migration-rebuild/web-app1.png)
    *Figure 50: Selecting the web app.*

2. They provide a web app name (`smarthotelcontoso`), run it on Windows, and place it in the production resource group `ContosoRG`. They create a new Application Insights instance for application monitoring.

    ![Screenshot of providing a web app name and other details.](./media/contoso-migration-rebuild/web-app2.png)
    *Figure 51: The web app name.*

3. After they're done, the admins browse to the address of the application to check on whether it has been created successfully.

4. In the Azure portal, they create a staging slot for the code. The pipeline will be deployed to this slot. This approach ensures that code isn't put into production until the admins perform a release.

    ![Screenshot of adding a web app staging slot.](./media/contoso-migration-rebuild/web-app3.png)
    *Figure 52: Adding a web app staging slot.*

### Provision the function app

In the Azure portal, Contoso admins provision the function app.

1. They select **Function App**.

    ![Screenshot showing the creation of a function app.](./media/contoso-migration-rebuild/function-app1.png)
    *Figure 53: Selecting the function app.*

2. They provide a name for the function app (`smarthotelpetchecker`). They place the function app in the production resource group (`ContosoRG`). They set the hosting place to **Consumption Plan**, and place the function app in the `East US 2` region. A new storage account is created along with an Application Insights instance for monitoring.

    ![Screenshot showing the function app's settings.](./media/contoso-migration-rebuild/function-app2.png)
    *Figure 54: Function app settings.*

3. After they've deployed the function app, the admins browse to its address to verify that it has been created successfully.

## Step 4: Set up the front-end pipeline

Contoso admins create two different projects for the front-end site.

1. In Azure DevOps, they create a project named `SmartHotelFrontEnd`.

    ![Screenshot of the creation of a front-end project.](./media/contoso-migration-rebuild/function-app1.png)
    *Figure 55: Creating a front-end project.*

2. They import the [`SmartHotel360-Website`](https://github.com/Microsoft/SmartHotel360-Website) Git repository into the new project.

3. For the function app, they create another Azure DevOps project (`SmartHotelPetChecker`) and import the [PetChecker](https://github.com/sonahander/SmartHotel360-PetCheckerFunction) Git repository into this project.

### Configure the web app

Now Contoso admins configure the web app to use Contoso resources.

1. The admins connect to the Azure DevOps project and clone the repository locally to the development machine.
2. In Visual Studio, they open the folder to show all the files in the repo.

    ![Screenshot of Visual Studio showing a folder with all the files in the repo.](./media/contoso-migration-rebuild/configure-webapp1.png)
    *Figure 56: Viewing all files in the repo.*

3. They update the configuration changes as required.

    - When the web app starts up, it looks for the `SettingsUrl` app setting.
    - This variable must contain a URL that points to a configuration file.
    - By default, the setting that's used is a public endpoint.

4. They update the `/config-sample.json/sample.json` file.

    - This is the configuration file for the web when it uses the public endpoint.
    - They edit the `urls` and `pets_config` sections with the values for the AKS API endpoints, storage accounts, and Azure Cosmos DB database.
    - The URLs should match the DNS name of the new web app that Contoso will create.
    - For Contoso, this is `smarthotelcontoso.eastus2.cloudapp.azure.com`.

    ![Screenshot of the .json settings in Visual Studio.](./media/contoso-migration-rebuild/configure-webapp2.png)
    *Figure 57: The .json settings.*

5. After they update the file, the admins rename it `smarthotelsettingsurl` and upload it to the Blob Storage they created earlier.

    ![Screenshot of renaming and uploading the .json file.](./media/contoso-migration-rebuild/configure-webapp3.png)
    *Figure 58: Renaming and uploading the file.*

6. They select the file to get the URL. The URL is used by the application when it pulls down the configuration files.

    ![Screenshot of the URL of the file that's used by the application.](./media/contoso-migration-rebuild/configure-webapp4.png)
    *Figure 59: The application URL.*

7. In the `appsettings.Production.json` file, they update the `SettingsURL` to the URL of the new file.

    ![Screenshot of updating the URL to the new file.](./media/contoso-migration-rebuild/configure-webapp5.png)
    *Figure 60: Updating the URL to the new file.*

### Deploy the website to Azure App Service

Contoso admins can now publish the website.

1. They open Azure DevOps and, in the `SmartHotelFrontEnd` project in **Builds and Releases**, they select **+ New pipeline**.
2. They select **Azure DevOps Git** as a source.
3. They select the **ASP.NET Core** template.
4. They review the pipeline and check to ensure that **Publish Web Projects** and **Zip Published Projects** are selected.

    ![Screenshot of the web project's pipeline settings.](./media/contoso-migration-rebuild/vsts-publish-front2.png)
    *Figure 61: Pipeline settings.*

5. In **Triggers**, they enable continuous integration and add the main branch. This ensures that the build pipeline starts each time the solution has new code committed to the main branch.

    ![Screenshot of enabling continuous integration and adding the main branch.](./media/contoso-migration-rebuild/vsts-publish-front3.png)
    *Figure 62: Enabling continuous integration.*

6. They select **Save & Queue** to start a build.
7. After the build finishes, they configure a release pipeline by using **Azure App Service Deployment**.
8. They provide a stage name, **Staging**.

    ![Screenshot of providing a stage name for the environment.](./media/contoso-migration-rebuild/vsts-publish-front4.png)
    *Figure 63: Naming the environment.*

9. They add an artifact and select the build that they've configured.

    ![Screenshot of adding an artifact, with Build as the source type.](./media/contoso-migration-rebuild/vsts-publish-front5.png)
    *Figure 64: Adding an artifact.*

10. They select the lightning bolt icon on the artifact and then set continuous deployment to **Enabled**.

    ![Screenshot of enabling continuous deployment.](./media/contoso-migration-rebuild/vsts-publish-front6.png)
    *Figure 65: Enabling continuous deployment.*

11. In **Environment**, they select **1 job, 1 task** under **Staging**.

12. After selecting the subscription and web app name, the admins open the **Deploy Azure App Service** task. The deployment is configured to use the **staging** deployment slot. This automatically builds code for review and approval in this slot.

     ![Screenshot of deploying the web app to a slot.](./media/contoso-migration-rebuild/vsts-publish-front7.png)
    *Figure 66: Deploying to a slot.*

13. In the **Pipeline**, they add a new stage.

    ![Screenshot of the Pipeline tab and adding a new stage.](./media/contoso-migration-rebuild/vsts-publish-front8.png)
    *Figure 67: Adding a new stage.*

14. They select **Azure App Service deployment with slot** and then name the environment **Prod**.

15. They select **1 job, 2 tasks** and then select the subscription, the app service name, and the **staging** slot.

    ![Screenshot showing naming the environment.](./media/contoso-migration-rebuild/vsts-publish-front10.png)
    *Figure 68: Naming the environment.*

16. They remove the **Deploy Azure App Service to Slot** from the pipeline. It was placed there by the previous steps.

    ![Screenshot showing removing a slot from the pipeline.](./media/contoso-migration-rebuild/vsts-publish-front11.png)
    *Figure 69: Removing a slot from the pipeline.*

17. They save the pipeline. On the pipeline, they select **Post-deployment conditions**.

    ![Screenshot of the **Post-deployment conditions** button.](./media/contoso-migration-rebuild/vsts-publish-front12.png)
    *Figure 70: Post-deployment conditions.*

18. They enable **Post-deployment approvals** and then add a dev lead as the approver.

    ![Screenshot of the enabled post-deployment approvers list.](./media/contoso-migration-rebuild/vsts-publish-front13.png)
    *Figure 71: Adding an approver.*

19. In the build pipeline, the admins manually kick off a build. This triggers the new release pipeline, which deploys the site to the staging slot. For Contoso, the URL for the slot is `https://smarthotelcontoso-staging.azurewebsites.net/`.

20. After the build finishes and the release is deployed to the slot, Azure DevOps emails the dev lead for approval.

21. The dev lead selects **View approval** and can approve or reject the request in the Azure DevOps portal.

    ![Screenshot of the post-deployment approval **Approve or reject** link.](./media/contoso-migration-rebuild/vsts-publish-front14.png)
    *Figure 72: A pending release approval request.*

22. The dev lead makes a comment and approves. This starts swapping the **staging** and **prod** slots and moves the build into production.

    ![Screenshot of post-deployment approval and comment.](./media/contoso-migration-rebuild/vsts-publish-front15.png)
    *Figure 73: Moving the build into production.*

23. The pipeline completes the swap.

    ![Screenshot showing the statuses of the build deployment.](./media/contoso-migration-rebuild/vsts-publish-front16.png)
    *Figure 74: Completing the swap.*

24. The team checks the **prod** slot to verify that the web app is in production at `https://smarthotelcontoso.azurewebsites.net/`.

### Deploy the PetChecker function app

Contoso admins deploy the application by doing the following:

1. They clone the repository locally to the development machine by connecting to the Azure DevOps project.
2. In Visual Studio, they open the folder to show all the files in the repo.
3. They open the `src/PetCheckerFunction/local.settings.json` file and add the app settings for storage, the Azure Cosmos DB database, and the Computer Vision API.

    ![Screenshot of the app settings in the .json file in Visual Studio.](./media/contoso-migration-rebuild/function5.png)
    *Figure 75: Deploying the function.*

4. They commit the code and sync it back to Azure DevOps, pushing their changes.
5. They add a new build pipeline and then select **Azure DevOps Git** for the source.
6. They select the **ASP.NET Core (.NET Framework)** template.
7. They accept the defaults for the template.
8. Under **Triggers**, they select **Enable continuous integration** and then select **Save & Queue** to start a build.
9. After the build succeeds, they build a release pipeline, adding **Azure App Service deployment with slot**.

10. They name the environment **Prod** and then select the subscription. They set the **App type** to **Function App** and the app service name as `smarthotelpetchecker`.

    ![Screenshot of the app type and app service name.](./media/contoso-migration-rebuild/petchecker2.png)
    *Figure 76: The function app.*

11. They add an artifact, **Build**.

    ![Screenshot of adding an artifact, with the Build source type.](./media/contoso-migration-rebuild/petchecker3.png)
    *Figure 77: Adding an artifact.*

12. They enable **Continuous deployment trigger** and then select **Save**.

13. They select **Queue new build** to run the full CI/CD pipeline.

14. After the function is deployed, it appears in the Azure portal with the status **Running**.

    ![Screenshot of the function app, showing a **Running** status.](./media/contoso-migration-rebuild/function6.png)
    *Figure 78: Updating the function's status.*

15. They browse to the pet checker application, at `http://smarthotel360public.azurewebsites.net/pets`, to verify that it's working properly.

16. They select the avatar to upload a picture.

    ![Screenshot of the pane for assigning a picture to an avatar.](./media/contoso-migration-rebuild/function7.png)
    *Figure 79: Assigning a picture to an avatar.*

17. The first photo they want to check is of a small dog.

    ![Screenshot showing a photo of a dog.](./media/contoso-migration-rebuild/function8.png)
    *Figure 80: Checking the photo.*

18. The application returns an acceptance message.

    ![Screenshot of an acceptance message.](./media/contoso-migration-rebuild/function9.png)
    *Figure 81: An acceptance message.*

## Review the deployment

With the migrated resources in Azure, Contoso now needs to fully operationalize and secure the new infrastructure.

### Security

- Contoso needs to ensure that the new databases are secure. To learn more, see [Overview of Azure SQL Database and SQL Managed Instance security capabilities](/azure/azure-sql/database/security-overview).
- The application must be updated to use SSL with certificates. The container instance should be redeployed to answer on 443.
- Contoso should consider using Azure Key Vault to help protect secrets for their Service Fabric applications. To learn more, see [Manage encrypted secrets in Service Fabric applications](/azure/service-fabric/service-fabric-application-secret-management).

### Backups and disaster recovery

- Contoso needs to review [backup requirements for Azure SQL Database](/azure/azure-sql/database/automated-backups-overview).
- Contoso should consider implementing [SQL failover groups to provide regional failover for the database](/azure/azure-sql/database/auto-failover-group-overview).
- Contoso can use [geo-replication for the Azure Container Registry Premium SKU](/azure/container-registry/container-registry-geo-replication).
- Azure Cosmos DB is backed up automatically. To learn more, see [Online backup and on-demand data restore in Azure Cosmos DB](/azure/cosmos-db/online-backup-and-restore).

### Licensing and cost optimization

- After all resources are deployed, Contoso should assign Azure tags based on their [infrastructure planning](./contoso-migration-infrastructure.md#set-up-tagging).
- All licensing is built into the cost of the PaaS services that Contoso is consuming. This will be deducted from the Enterprise Agreement.
- Contoso will enable [Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview) to help monitor and manage the Azure resources.

## Conclusion

In this article, Contoso rebuilds the SmartHotel360 application in Azure. The on-premises application front-end VM is rebuilt for Azure App Service web apps. The application back end is built by using microservices that are deployed to containers managed by AKS. Contoso enhanced functionality with a pet photo application.

## Suggested skills

Microsoft Learn is a new approach to learning. Readiness for the new skills and responsibilities that come with cloud adoption doesn't come easily. Microsoft Learn provides a more rewarding approach to hands-on learning that helps you achieve your goals faster. With Microsoft Learn, you can earn points, rise through levels, and achieve more.

Here are two examples of tailored learning paths on Microsoft Learn that align with the Contoso SmartHotel360 application in Azure.

<!-- docsTest:casing "computer vision functionality" -->

- [Deploy a website to Azure with Azure App Service](/learn/paths/deploy-a-website-with-azure-app-service/): By creating web apps in Azure, you can publish and manage your website easily without having to work with the underlying servers, storage, or network assets. Instead, you can focus on your website features and rely on the robust Azure platform to help provide secure access to your site.

- [Process and classify images with the Azure cognitive vision services](/learn/paths/process-classify-images-with-azure-cognitive-vision-services/): Azure Cognitive Services offers prebuilt functionality to enable computer vision functionality in your applications. Learn how to use the Azure cognitive vision services to detect faces, tag and classify images, and identify objects.
