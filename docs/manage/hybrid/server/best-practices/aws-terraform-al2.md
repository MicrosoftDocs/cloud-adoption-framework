---
title: Use a Terraform plan to deploy an Amazon Linux 2 instance on Amazon Elastic Compute Cloud and connect it to Azure Arc
description: Use a Terraform plan to deploy an Amazon Linux 2 instance on Amazon Elastic Compute Cloud and connect it to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

# Use a Terraform plan to deploy an Amazon Linux 2 instance on Amazon Elastic Compute Cloud and connect it to Azure Arc

This article provides guidance for using the provided [Terraform](https://www.terraform.io/) plan to deploy an Amazon Web Services (AWS) Amazon Elastic Compute Cloud (EC2) Linux 2 instance and connect it as an Azure Arc enabled server resource.

## Prerequisites

1. Clone the Azure Arc Jumpstart repository.

    ```console
    git clone https://github.com/microsoft/azure_arc.git
    ```

2. [Install or update Azure CLI](/cli/azure/install-azure-cli). Azure CLI should be running version 2.7.0 or later. Use `az --version` to check your current installed version.

3. [Generate SSH key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) (or use existing SSH key)

4. [Create free AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)

5. [Install Terraform >= 0.12](https://learn.hashicorp.com/tutorials/terraform/install-cli)

6. Create an Azure service principal.

    To connect the AWS virtual machine to Azure Arc, an Azure service principal assigned with the Contributor role is required. To create it, sign in to your Azure account and run the following commands:

    ```console
    az login
    az ad sp create-for-rbac -n "http://AzureArcAWS" --role contributor
    ```

    Output should look similar to this:

    ```json
    {
      "appId": "XXXXXXXXXXXXXXXXXXXXXXXX",
      "displayName": "AzureArcAWS",
      "name": "http://AzureArcAWS",
      "password": "XXXXXXXXXXXXXXXXXXXXXXXX",
      "tenant": "XXXXXXXXXXXXXXXXXXXXXXXX"
    }
    ```

    > [!NOTE]
    > We highly recommend that you scope the service principal to a specific [Azure subscription and resource group](/cli/azure/ad/sp).

## Create an AWS identity

In order for Terraform to create resources in AWS, we will need to create a new AWS IAM role with appropriate permissions and configure Terraform to use it.

1. Sign in to the [AWS management console](https://console.aws.amazon.com/console/home)

2. After signing in, select the **Services** dropdown in the top left. Under **Security, Identity, and Compliance**, select **IAM** to access the [identity and access management page](https://console.aws.amazon.com/iam/home)

    ![A screenshot of the AWS cloud console.](./media/aws-terraform-al2/al2-aws-console.png)

    ![A screenshot of an identity and access management AWS cloud console.](./media/aws-terraform-al2/al2-aws-iam.png)

3. Click on **Users** from the left menu, and then select **Add user** to create a new IAM user.

    ![A screenshot of how to create a new user in an AWS cloud console.](./media/aws-terraform-al2/al2-new-user-1.png)

4. On the **Add User** page, name the user `Terraform` and select the **Programmatic Access** check box, and then select **Next**

    ![Second screenshot of how to create a new user in an AWS cloud console.](./media/aws-terraform-al2/al2-new-user-2.png)

5. On the **Set Permissions** page, select **Attach existing policies directly** and then check the box next to **AmazonEC2FullAccess** as seen in the screenshot, and then select **Next**

    ![Third screenshot of how to create a new user in an AWS cloud console.](./media/aws-terraform-al2/al2-new-user-3.png)

6. On the **Tags** page, assign a tag with a key of `azure-arc-demo`, then select **Next** to proceed to the review page.

    ![A screenshot of tags in an AWS cloud console.](./media/aws-terraform-al2/al2-tags.png)

7. Verify that everything is correct, then select **Create user**.

    ![Fourth screenshot of how to create a new user in an AWS cloud console.](./media/aws-terraform-al2/al2-new-user-4.png)

8. After the user is created, you will see the user's access key ID and secret access key. Copy these values down before selecting **Close**. On the next page, you can see an example of what this should look like. Once you have these keys, you will be able to use them with Terraform to create AWS resources.

    ![A screenshot of creating a user successfully in an AWS cloud console.](./media/aws-terraform-al2/al2-new-user-5.png)

## Configure Terraform

Before executing the Terraform plan, you must export the environment variables which will be used by the plan. These variables are based on your Azure subscription and tenant, the Azure service principal, and the AWS IAM user and keys you just created.

1. Retrieve your Azure subscription ID and tenant ID using the `az account list` command.

2. The Terraform plan creates resources in both Microsoft Azure and AWS. It then executes a script on an AWS EC2 virtual machine to install the Azure Arc agent and all necessary artifacts. This script requires certain information about your AWS and Azure environments. Edit [`scripts/vars.sh`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/aws/AL2/terraform/scripts/vars.sh) and update each of the variables with the appropriate values.

    - `TF_VAR_subscription_id`= your Azure subscription ID
    - `TF_VAR_client_id`= your Azure service principal application ID
    - `TF_VAR_client_secret` = your Azure service principal password
    - `TF_VAR_tenant_id`= your Azure tenant ID
    - `AWS_ACCESS_KEY_ID` = AWS access key
    - `AWS_SECRET_ACCESS_KEY` = AWS secret key

3. From the Azure CLI, navigate to the `azure_arc_servers_jumpstart/aws/al2/terraform` directory of the cloned repo.

4. Export the environment variables you edited by running [`scripts/vars.sh`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/aws/AL2/terraform/scripts/vars.sh) with the source command as shown below. Terraform requires these to be set for the plan to execute properly. Note that this script will also be automatically executed remotely on the AWS virtual machine as part of the Terraform deployment.

    ```console
    source ./scripts/vars.sh
    ```

5. Make sure your SSH keys are available in `~/.ssh` and named `id_rsa.pub` and `id_rsa`. If you followed the ssh-keygen guide above to create your key then this should already be setup correctly. If not, you may need to modify [`main.tf`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/aws/AL2/terraform/main.tf) to use a key with a different path.

6. Run the `terraform init` command which will download the Terraform AzureRM provider.

    ![A screenshot of the `terraform init` command.](./media/aws-terraform-al2/al2-terraform-init.png)

## Deployment

1. Run the `terraform apply --auto-approve` command and wait for the plan to finish. Upon completion, you will have an AWS Amazon Linux 2 EC2 instance deployed and connected as a new Azure Arc enabled server inside a new resource group.

2. Open the Azure portal and navigate to the `arc-servers-demo` resource group. The virtual machine created in AWS will be visible as a resource.

    ![A screenshot showing an Azure Arc enabled server in the Azure portal.](./media/aws-terraform-al2/al2-server.png)

## Semi-automated deployment (optional)

As you may have noticed, the last step of the run is to register the VM as a new Azure Arc enabled server resource.

  ![A screenshot of the `azcmagent connect` command.](./media/aws-terraform-al2/al2-azcmagent.png)

If you want to demo/control the actual registration process, do the following:

1. In the [`install_arc_agent.sh.tmpl`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/aws/AL2/terraform/scripts/install_arc_agent.sh.tmpl) script template, comment out the `run connect command` section and save the file.

    ![A screenshot of the `azcmagent connect` command commented out.](./media/aws-terraform-al2/al2-azcmagent-commented.png)

2. Get the public IP of the AWS VM by running `terraform output`.

    ![A screenshot of a terraform output.](./media/aws-terraform-al2/al2-terraform-output.png)

3. SSH to the VM using the `ssh ec2-user@xx.xx.xx.xx`, where `xx.xx.xx.xx` is the host IP.

    ![A screenshot of an SSH key connecting to an EC2 server.](./media/aws-terraform-al2/al2-ssh.png)

4. Export all the environment variables in [`vars.sh`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/aws/AL2/terraform/scripts/vars.sh)

    ![A screenshot of exported environment variables in `var.sh`.](./media/aws-terraform-al2/al2-export-variables.png)

5. Run the following command:

    ```console
    azcmagent connect --service-principal-id $TF_VAR_client_id --service-principal-secret $TF_VAR_client_secret --resource-group "Arc-Servers-Demo" --tenant-id $TF_VAR_tenant_id --location "westus2" --subscription-id $TF_VAR_subscription_id
    ```

    ![Another screenshot of the `azcmagent connect` command.](./media/aws-terraform-al2/al2-azcmagent-2.png)

6. When complete, your VM will be registered with Azure Arc and visible in the resource group via the Azure portal.

## Delete the deployment

To delete all the resources you created as part of this demo, use the `terraform destroy --auto-approve` command as shown below.
    ![A screenshot of the `terraform destroy` command.](./media/aws-terraform-al2/al2-terraform-destroy.png)

Alternatively, you can delete the AWS EC2 instance directly by terminating it from the [AWS console](https://console.aws.amazon.com/ec2/v2/home).
    ![A screenshot of how to terminate an instance in the AWS console.](./media/aws-terraform-al2/al2-terminate.png)
