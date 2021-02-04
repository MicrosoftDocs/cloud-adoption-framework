---
title: Use a terraform plan to deploy a Google Cloud Platform Windows instance and connect it to Azure Arc
description: Use a terraform plan to deploy a Google Cloud Platform Windows instance and connect it to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: think-tank, e2e-hybrid
---

# Use a terraform plan to deploy a Google Cloud Platform Windows instance and connect it to Azure Arc

The following README will guide you on how to use the provided [Terraform](https://www.terraform.io/) plan to deploy a Windows Server GCP instance and connect it as an Azure-Arc-enabled server resource.

## Prerequisites

* Clone the Azure Arc Jumpstart repository

    ```console
    git clone https://github.com/microsoft/azure-arc.git
    ```

* [Install or update Azure CLI to version 2.7 and above](https://docs.microsoft.com/cli/azure/install-azure-cli). Use the below command to check your current installed version.

  ```console
  az --version
  ```

* [Install Terraform >=0.12](https://learn.hashicorp.com/terraform/getting-started/install.html)

* Google Cloud account with billing enabled - [Create a free trial account](https://cloud.google.com/free). To create Windows Server virtual machines, you must upgraded your account to enable billing. Click Billing from the menu and then select Upgrade in the lower right.

    ![First screenshot showing how to enable billing on a GCP account.](./img/gcp-windows/billing-1.png)

    ![Second screenshot showing how to enable billing on a GCP account.](./img/gcp-windows/billing-2.png)

    ![Third screenshot showing how to enable billing on a GCP account.](./img/gcp-windows/billing-3.png)

    ***Disclaimer*** - **To prevent unexpected charges, please follow the "Delete the deployment" section at the end of this README**

* Create Azure service principal (SP)

    To connect the GCP virtual machine to Azure Arc, an Azure service principal assigned with the "Contributor" role is required. To create it, login to your Azure account run the below command (this can also be done in [Azure Cloud Shell](https://shell.azure.com/)).

    ```console
    az login
    az ad sp create-for-rbac -n "<Unique SP Name>" --role contributor
    ```

    For example:

    ```console
    az ad sp create-for-rbac -n "http://AzureArcGCP" --role contributor
    ```

    Output should look like this:

    ```json
    {
    "appId": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    "displayName": "AzureArcGCP",
    "name": "http://AzureArcGCP",
    "password": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    "tenant": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    }
    ```

    > **Note: It is optional but highly recommended to scope the SP to a specific [Azure subscription and resource group](https://docs.microsoft.com/cli/azure/ad/sp)**

## Create a new GCP Project

* Browse to <https://console.cloud.google.com> and login with your Google Cloud account. Once logged in, [create a new project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) named "Azure Arc Demo". After creating it, be sure to copy down the project id as it is usually different then the project name.

    ![First screenshot of the 'New Project' screen in the GCP console.](./img/gcp-windows/new-project-1.png)

    ![Second screenshot of the 'New Project' screen in the GCP console.](./img/gcp-windows/new-project-2.png)

* Once the new project is created and selected in the dropdown at the top of the page, you must enable Compute Engine API access for the project. Click on "+Enable APIs and Services" and search for "Compute Engine". Then click Enable to enable API access.

    ![First screenshot of 'Compute Engine API' in the GCP console.](./img/gcp-windows/comp-eng-api-1.png)

    ![Second screenshot of 'Compute Engine API' in the GCP console.](./img/gcp-windows/comp-eng-api-2.png)

* Next, set up a service account key, which Terraform will use to create and manage resources in your GCP project. Go to the [create service account key page](https://console.cloud.google.com/apis/credentials/serviceaccountkey). Select "New Service Account" from the dropdown, give it a name, select Project then Owner as the role, JSON as the key type, and click Create. This downloads a JSON file with all the credentials that will be needed for Terraform to manage the resources. Copy the downloaded JSON file to the *azure-arc-servers-jumpstart/gcp/windows/terraform* directory.

    ![A screenshot of how to create a service account in the GCP console.](./img/gcp-windows/svc-account.png)

## Deployment

Before executing the Terraform plan, you must set and then export the environment variables which will be used by the plan. These variables are based on the Azure service principal you've just created, your Azure subscription and tenant, and the GCP project name.

* Retrieve your Azure subscription ID and tenant ID using the ```az account list``` command.

* The Terraform plan creates resources in both Microsoft Azure and Google Cloud. It then executes a script on a Google Cloud virtual machine to install the Azure Arc agent and all necessary artifacts. This script requires certain information about your Google Cloud and Azure environments. Edit [*scripts/vars.sh*](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/gcp/windows/terraform/scripts/vars.sh) and update each of the variables with the appropriate values.

  * TF-VAR-subscription-id=Your Azure subscription ID
  * TF-VAR-client-id=Your Azure service principal app id
  * TF-VAR-client-secret=Your Azure service principal password
  * TF-VAR-tenant-id=Your Azure tenant ID
  * TF-VAR-gcp-project-id=GCP project id
  * TF-VAR-gcp-credentials-filename=GCP credentials json filename

* From CLI, navigate to the [*azure-arc-servers-jumpstart/gcp/windows/terraform*](https://github.com/microsoft/azure-arc/tree/main/azure-arc-servers-jumpstart/gcp/windows/terraform) directory of the cloned repo.

* Export the environment variables you edited by running [*scripts/vars.sh*](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/gcp/windows/terraform/scripts/vars.sh) with the source command as shown below. Terraform requires these to be set for the plan to execute properly.

    ```console
    source ./scripts/vars.sh
    ```

* Run the ```terraform init``` command which will download the Terraform AzureRM provider.

    ![A screenshot of the 'terraform init' command.](./img/gcp-windows/terraform-init.png)

* Next, run the ```terraform apply --auto-approve``` command and wait for the plan to finish. Upon completion of the Terraform script, you will have deployed a GCP Windows Server 2019 VM and initiated a script to download the Azure Arc agent to the VM and connect the VM as a new Azure-Arc-enabled server inside a new Azure resource group. It will take a few minutes for the agent to finish provisioning so grab a coffee.

    ![A screenshot of the 'terraform apply' command.](./img/gcp-windows/terraform-apply.png)

* After a few minutes, you should be able to open the Azure portal and navigate to the resource group "Arc-GCP-Demo". The Windows Server virtual machine created in GCP will be visible as a resource.

    ![A screenshot of an Azure-Arc-enabled server in the Azure portal.](./img/gcp-windows/server.png)

## Semi-Automated Deployment (Optional)

The Terraform plan automatically installs the Azure Arc agent and connects the VM to Azure as a managed resource by executing a PowerShell script when the VM is first booted.
    ![A screenshot of the 'azcmagent connect' command.](./img/gcp-windows/azcmagent-connect.png)

If you want to demo/control the actual registration process, do the following:

* Before running the ```terraform apply``` command, open [*main.tf*](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/gcp/windows/terraform/main.tf) and comment out the ```windows-startup-script-ps1 = local-file.install-arc-agent-ps1.content``` line and save the file.

    ![A screenshot showing 'main.tf' being commented out to disable automatic onboarding of an Azure Arc agent.](./img/gcp-windows/main-tf.png)

* Run ```terraform apply --auto-approve``` as instructed above.

* Open the Google Cloud console and navigate to the [Compute Instance page](https://console.cloud.google.com/compute/instances), then click on the VM that was created.

    ![A screenshot of a server in the GCP console.](./img/gcp-windows/gcp-server.png)

    ![A screenshot showing how to reset a password for a Windows server in the GCP.](./img/gcp-windows/reset-password.png)

* Create a user and password for the VM by clicking "Set Password" and specifying a username.

    ![A screenshot showing how to set a username and password for a Windows server in the GCP.](./img/gcp-windows/name-pword.png)

* RDP into the VM by clicking the RDP button from the VM page in Google Cloud console, and login with the username and password you just created.

    ![A screenshot showing how to RDP into a GCP instance.](./img/gcp-windows/gcp-rdp.png)

* Once logged in, open PowerShell ISE **as Administrator**. Make sure you are running the x64 version of PowerShell ISE and not x86. Once open, select File->New to create an empty .ps1 file. Then paste in the entire contents of *./scripts/install-arc-agent.ps1]*. Click the play button to execute the script. When complete, you should see the output showing successful onboarding of the machine.

    ![Screenshot showing the Windows Powershell Integrated Scripting Environment with an Azure Arc agent connection script.](./img/gcp-windows/ise-script.png)

## Delete the deployment

To delete all the resources you created as part of this demo use the ```terraform destroy --auto-approve``` command as shown below.
    ![A screenshot of the 'terraform destroy' command.](./img/gcp-windows/terraform-destroy.png)

Alternatively, you can delete the GCP VM directly from [GCP Console](https://console.cloud.google.com/compute/instances).
    ![A screenshot showing how to delete a virtual machine from the GCP console.](./img/gcp-windows/delete-vm.png)
