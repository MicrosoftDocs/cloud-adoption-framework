---
title: Use a Terraform plan to deploy an Amazon Web Services Amazon Elastic Compute Cloud instance and connect it to Azure Arc
description: Use a Terraform plan to deploy an Amazon Web Services Amazon Elastic Compute Cloud instance and connect it to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: think-tank, e2e-hybrid
---

# Use a Terraform plan to deploy an Amazon Web Services Amazon Elastic Compute Cloud instance and connect it to Azure Arc

The following README will guide you on how to use the provided [Terraform](https://www.terraform.io/) plan to deploy an Amazon Web Services (AWS) Amazon Elastic Compute Cloud (Amazon EC2) instance and connect it as an Azure Arc enabled server resource.

## Prerequisites

- Clone the Azure Arc Jumpstart repository.

    ```console
    git clone https://github.com/microsoft/azure-arc.git
    ```

- [Install or update Azure CLI to version 2.7 and above](/cli/azure/install-azure-cli). Use the following command to check your current installed version.

  ```console
  az --version
  ```

- [Generate SSH key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) (or use existing SSH key)

- [Create free AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)

- [Install Terraform >=0.12](https://learn.hashicorp.com/terraform/getting-started/install.html)

- Create an Azure service principal.

    To connect the AWS virtual machine to Azure Arc, an Azure service principal assigned with the Contributor role is required. To create it, sign in to your Azure account and run the following command. You can also run this command in [Azure Cloud Shell](https://shell.azure.com/).

    ```console
    az login
    az ad sp create-for-rbac -n "<Unique SP Name>" --role contributor
    ```

    For example:

    ```console
    az ad sp create-for-rbac -n "http://AzureArcAWS" --role contributor
    ```

    Output should look like this:

    ```json
    {
    "appId": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    "displayName": "AzureArcAWS",
    "name": "http://AzureArcAWS",
    "password": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    "tenant": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    }
    ```

    > [!NOTE]
    > We highly recommend that you scope the service principal to a specific [Azure subscription and resource group](/cli/azure/ad/sp).

## Create an AWS identity

In order for Terraform to create resources in AWS, we will need to create a new AWS IAM role with appropriate permissions and configure Terraform to use it.

- Sign in to the [AWS management console](https://console.aws.amazon.com)

- After signing in, select the **Services** dropdown in the top left. Under **Security, Identity, and Compliance**, select **IAM** to access the [identity and access management page](https://console.aws.amazon.com/iam/home)

    ![A screenshot of an AWS cloud console.](./img/aws-ubuntu/aws-ubuntu-console.png)

    ![A screenshot of identity and access management in the AWS cloud console.](./img/aws-ubuntu/aws-ubuntu-iam.png)

- Click on **Users** from the left menu, and then select **Add user** to create a new IAM user.

    ![A screenshot of creating a new user in an AWS cloud console.](./img/aws-ubuntu/aws-ubuntu-new-user-1.png)

- On the **Add User** page, name the user `Terraform` and select the **Programmatic Access** check box, and then select **Next**.

    ![Second screenshot of creating a new user in an AWS cloud console.](./img/aws-ubuntu/aws-ubuntu-new-user-2.png)

- On the **Set Permissions** page, select **Attach existing policies directly** and then check the box next to **AmazonEC2FullAccess** as seen in the screenshot, and then select **Next**.

    ![Third screenshot of creating a new user in an AWS cloud console.](./img/aws-ubuntu/aws-ubuntu-new-user-3.png)

- On the **Tags** page, assign a tag with a key of `azure-arc-demo` and select **Next** to proceed to the **Review** page.

    ![A screenshot of tags in an AWS cloud console.](./img/aws-ubuntu/aws-ubuntu-tags.png)

- Verify that everything is correct and select **Create user** when ready.

    ![Fourth screenshot of creating a user in an AWS cloud console.](./img/aws-ubuntu/aws-ubuntu-new-user-4.png)

- After the user is created, you will see the user's access key ID and secret access key. Copy these values before selecting **Close**. On the next page, you can see an example of what this should look like. Once you have these keys, you will be able to use them with Terraform to create AWS resources.

    ![A screenshot of creating a user successfully in an AWS cloud console.](./img/aws-ubuntu/aws-ubuntu-new-user-5.png)

## Configure Terraform

Before executing the Terraform plan, you must export the environment variables which will be used by the plan. These variables are based on your Azure subscription and tenant, the Azure service principal, and the AWS IAM user and keys you just created.

- Retrieve your Azure subscription ID and tenant ID using the `az account list` command.

- The Terraform plan creates resources in both Microsoft Azure and AWS. It then executes a script on an AWS EC2 virtual machine to install the Azure Arc agent and all necessary artifacts. This script requires certain information about your AWS and Azure environments. Edit [`scripts/vars.sh`](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/aws/ubuntu/terraform/scripts/vars.sh) and update each of the variables with the appropriate values.

  - Tf-VAR-subscription-ID=your Azure subscription ID
  - Tf-VAR-client-ID=your Azure service principal application ID
  - Tf-VAR-client-secret=your Azure service principal password
  - Tf-VAR-tenant-ID=your Azure tenant ID
  - AWS-ACCESS-key-ID=AWS access key
  - AWS-SECRET-access-key=AWS secret key

- From the Azure CLI, navigate to the `azure-arc-servers-jumpstart/aws/ubuntu/terraform` directory of the cloned repo.

- Export the environment variables you edited by running [`scripts/vars.sh`](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/aws/ubuntu/terraform/scripts/vars.sh) with the source command as shown below. Terraform requires these to be set for the plan to execute properly. Note that this script will also be automatically executed remotely on the AWS virtual machine as part of the Terraform deployment.

    ```console
    source ./scripts/vars.sh
    ```

- Make sure your SSH keys are available in *~/.ssh* and named `id-rsa.pub` and `id-rsa`. If you followed the ssh-keygen guide above to create your key then this should already be setup correctly. If not, you may need to modify [`main.tf`](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/aws/ubuntu/terraform/main.tf) to use a key with a different path.

- Run the `terraform init` command which will download the Terraform AzureRM provider.

    ![A screenshot of the 'terraform init' command.](./img/aws-ubuntu/aws-ubuntu-terraform-init.png)

## Deployment

- Run the `terraform apply --auto-approve` command and wait for the plan to finish. Upon completion, you will have an AWS Amazon Linux 2 EC2 instance deployed and connected as a new Azure Arc enabled server inside a new resource group.

- Open the Azure portal and navigate to the `arc-aws-demo` resource group. The virtual machine created in AWS will be visible as a resource.

    ![A screenshot showing an Azure Arc enabled server in the Azure portal.](./img/aws-ubuntu/aws-ubuntu-server.png)

    ![A screenshot of AWS console displaying EC2 instances.](./img/aws-ubuntu/aws-ubuntu-ec2-instances.png)

## Semi-automated deployment (optional)

As you may have noticed, the last step of the run is to register the VM as a new Azure Arc enabled server resource.
    ![A screenshot of the 'azcmagent connect' command.](./img/aws-ubuntu/aws-ubuntu-azcmagent-1.png)

If you want to demo/control the actual registration process, do the following:

- In the [`install-azure-arc-agent.sh.tmpl`](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/aws/ubuntu/terraform/scripts/install-arc-agent.sh.tmpl) script template, comment out the `run connect command` section and save the file.

    ![A screenshot showing 'main.tf' being commented out to disable automatic onboarding of an Azure Arc agent.](./img/aws-ubuntu/aws-ubuntu-main-tf.png)

- Get the public IP of the AWS VM by running `terraform output`.

    ![A screenshot of a terraform output.](./img/aws-ubuntu/aws-ubuntu-terraform.png)

- SSH the VM using the `ssh ubuntu@xx.xx.xx.xx` where `xx.xx.xx.xx` is the host IP.

    ![A screenshot of an SSH key connecting to an EC2 server.](./img/aws-ubuntu/aws-ubuntu-ssh.png)

- Export all the environment variables in [`vars.sh`](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/aws/ubuntu/terraform/scripts/vars.sh).

    ![A screenshot of environment variables exporting with 'vars.sh'.](./img/aws-ubuntu/aws-ubuntu-export-variables.png)

- Run the following command:

    ```console
    azcmagent connect --service-principal-id $TF-VAR-client-id --service-principal-secret $TF-VAR-client-secret --resource-group "arc-aws-demo" --tenant-id $TF-VAR-tenant-id --location "westus2" --subscription-id $TF-VAR-subscription-id
    ```

    ![Another screenshot of the 'azcmagent connect' command.](./img/aws-ubuntu/aws-ubuntu-azcmagent-2.png)

- When complete, your VM will be registered with Azure Arc and visible in the resource group via the Azure portal.

## Delete the deployment

To delete all the resources you created as part of this demo use the `terraform destroy --auto-approve` command as shown below.

  ![A screenshot of the 'terraform destroy' command.](./img/aws-ubuntu/aws-ubuntu-terraform-destroy.png)

Alternatively, you can delete the AWS EC2 instance directly by terminating it from the [AWS console](https://console.aws.amazon.com/ec2/v2/home). Note that it will take a few minutes for the instance to actually be removed.

  ![A screenshot of how to terminate an instance in the AWS console.](./img/aws-ubuntu/aws-ubuntu-terminate.png)

If you delete the instance manually, then you should also delete `*./scripts/install-azure-arc-agent.sh` which is created by the Terraform plan.
