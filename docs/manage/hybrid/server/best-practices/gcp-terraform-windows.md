---
title: Use a Terraform plan to deploy a Google Cloud Platform Windows instance and connect it to Azure Arc
description: Use a Terraform plan to deploy a Google Cloud Platform Windows instance and connect it to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

# Use a Terraform plan to deploy a Google Cloud Platform Windows instance and connect it to Azure Arc

This article provides guidance for using the provided [Terraform](https://www.terraform.io/) plan to deploy a Windows Server GCP instance and connect it as an Azure Arc enabled server resource.

## Prerequisites

1. Clone the Azure Arc Jumpstart repository.

    ```console
    git clone https://github.com/microsoft/azure_arc.git
    ```

2. [Install or update Azure CLI to version 2.7 and above](/cli/azure/install-azure-cli). Use the following command to check your current installed version.

    ```console
    az --version
    ```

3. [Install Terraform >= 0.12](https://learn.hashicorp.com/tutorials/terraform/install-cli)

4. **Google Cloud account with billing enabled:** [Create a free trial account](https://cloud.google.com/free). To create Windows Server virtual machines, you must upgraded your account to enable billing. Select **Billing** from the menu and then select **Upgrade** at the lower right.

    ![First screenshot showing how to enable billing on a GCP account.](./media/gcp-windows/billing-1.png)

    ![Second screenshot showing how to enable billing on a GCP account.](./media/gcp-windows/billing-2.png)

    ![Third screenshot showing how to enable billing on a GCP account.](./media/gcp-windows/billing-3.png)

    **Disclaimer:** To prevent unexpected charges, follow the "delete the deployment" section at the end of this article.

5. Create an Azure service principal.

    To connect the GCP virtual machine to Azure Arc, an Azure service principal assigned with the Contributor role is required. To create it, sign in to your Azure account and run the following command. You can also run this command in [Azure Cloud Shell](https://shell.azure.com/).

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

    > [!NOTE]
    > We highly recommend that you scope the service principal to a specific [Azure subscription and resource group](/cli/azure/ad/sp).

## Create a new GCP project

1. Browse to the [Google API console](https://console.cloud.google.com) and sign-in with your Google account. Once logged in, [create a new project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) named `Azure Arc demo`. After creating it, be sure to copy the project ID since it's usually different from the project name.

    ![First screenshot of the **New Project** page in the GCP console.](./media/gcp-windows/new-project-1.png)

    ![Second screenshot of the **New Project** page in the GCP console.](./media/gcp-windows/new-project-2.png)

2. Once the new project is created and selected in the dropdown at the top of the page, you must enable compute engine API access for the project. Click on **+ Enable APIs and Services** and search for *compute engine*. Then select **Enable** to enable API access.

    ![First screenshot of **Compute Engine API** in the GCP console.](./media/gcp-windows/comp-eng-api-1.png)

    ![Second screenshot of **Compute Engine API** in the GCP console.](./media/gcp-windows/comp-eng-api-2.png)

3. Next, set up a service account key, which Terraform will use to create and manage resources in your GCP project. Go to the [create service account key page](https://console.cloud.google.com/apis/credentials/serviceaccountkey). Select **New Service Account** from the dropdown, give it a name, select project then owner as the role, JSON as the key type, and select **Create**. This downloads a JSON file with all the credentials needed for Terraform to manage the resources. Copy the downloaded JSON file to the `azure_arc_servers_jumpstart/gcp/windows/terraform` directory.

    ![A screenshot of how to create a service account in the GCP console.](./media/gcp-windows/svc-account.png)

## Deployment

Before executing the Terraform plan, you must set and then export the environment variables which will be used by the plan. These variables are based on the Azure service principal you've just created, your Azure subscription and tenant, and the GCP project name.

1. Retrieve your Azure subscription ID and tenant ID using the `az account list` command.

2. The Terraform plan creates resources in both Microsoft Azure and Google Cloud Platform. It then executes a script on a GCP virtual machine to install the Azure Arc agent and all necessary artifacts. This script requires certain information about your GCP and Azure environments. Edit [`scripts/vars.sh`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/gcp/windows/terraform/scripts/vars.sh) and update each of the variables with the appropriate values.

    - `TF_VAR_subscription_id` = your Azure subscription ID
    - `TF_VAR_client_id` = your Azure service principal application ID
    - `TF_VAR_client_secret` = your Azure service principal password
    - `TF_VAR_tenant_id` = your Azure tenant ID
    - `TF_VAR_gcp_project_id` = GCP project ID
    - `TF_VAR_gcp_credentials_filename` = GCP credentials JSON filename

3. From CLI, navigate to the `azure_arc_servers_jumpstart/gcp/windows/terraform` directory of the cloned repo.

4. Export the environment variables you edited by running [`scripts/vars.sh`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/gcp/windows/terraform/scripts/vars.sh) with the source command as shown below. Terraform requires these to be set for the plan to execute properly.

    ```console
    source ./scripts/vars.sh
    ```

5. Run the `terraform init` command which will download the Terraform AzureRM provider.

    ![A screenshot of the `terraform init` command.](./media/gcp-windows/terraform-init.png)

6. Next, run the `terraform apply --auto-approve` command and wait for the plan to finish. Upon completion of the Terraform script, you will have deployed a GCP Windows Server 2019 VM and initiated a script to download the Azure Arc agent to the VM and connect the VM as a new Azure Arc enabled server inside a new Azure resource group. It will take a few minutes for the agent to finish provisioning so grab a coffee.

    ![A screenshot of the `terraform apply` command.](./media/gcp-windows/terraform-apply.png)

7. After a few minutes, you should be able to open the Azure portal and navigate to the `arc-gcp-demo` resource group. The Windows Server virtual machine created in GCP will be visible as a resource.

    ![A screenshot of an Azure Arc enabled server in the Azure portal.](./media/gcp-windows/server.png)

## Semi-automated deployment (optional)

The Terraform plan automatically installs the Azure Arc agent and connects the VM to Azure as a managed resource by executing a PowerShell script when the VM is first booted.

![A screenshot of the `azcmagent connect` command.](./media/gcp-windows/azcmagent-connect.png)

If you want to demo/control the actual registration process, do the following:

1. Before running the `terraform apply` command, open [`main.tf`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/gcp/windows/terraform/main.tf) and comment out the `windows-startup-script-ps1 = local-file.install_arc_agent-ps1.content` line and save the file.

    ![A screenshot showing `main.tf` being commented out to disable automatic onboarding of an Azure Arc agent.](./media/gcp-windows/main-tf.png)

2. Run `terraform apply --auto-approve` as instructed above.

3. Open the GCP console and navigate to the [compute instance page](https://console.cloud.google.com/compute/instances), and then select the VM that was created.

    ![A screenshot of a server in the GCP console.](./media/gcp-windows/gcp-server.png)

    ![A screenshot showing how to reset a password for a Windows server in the GCP console.](./media/gcp-windows/reset-password.png)

4. Create a user and password for the VM by selecting **Set Password** and specifying a user name.

    ![A screenshot showing how to set a username and password for a Windows server in the GCP console.](./media/gcp-windows/name-password.png)

5. RDP into the VM by selecting the RDP button from the VM page in the GCP console, and sign in with the username and password you just created.

    ![A screenshot showing how to RDP into a GCP instance.](./media/gcp-windows/gcp-rdp.png)

6. Once logged in, open PowerShell ISE **as Administrator**. Make sure you are running the x64 version of PowerShell ISE and not the x86 version. Once opened, select **File > New** to create an empty `.ps1` file. Then paste in the entire contents of `./scripts/install_arc_agent.ps1`. Click the play button to execute the script. When complete, you should see the output showing successful onboarding of the machine.

    ![Screenshot showing the Windows Powershell Integrated Scripting Environment with an Azure Arc agent connection script.](./media/gcp-windows/ise-script.png)

## Delete the deployment

To delete all the resources you created as part of this demo use the `terraform destroy --auto-approve` command as shown below.

  ![A screenshot of the `terraform destroy` command.](./media/gcp-windows/terraform-destroy.png)

Alternatively, you can delete the GCP VM directly from [GCP console](https://console.cloud.google.com/compute/instances).

  ![A screenshot showing how to delete a virtual machine from the GCP console.](./media/gcp-windows/delete-vm.png)
