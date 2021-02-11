---
title: Use Ansible to scale onboarding Amazon Web Services Amazon Elastic Compute Cloud instances to Azure Arc
description: Use Ansible to scale onboarding Amazon Web Services Amazon Elastic Compute Cloud instances to Azure Arc
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: think-tank, e2e-hybrid
---

# Use Ansible to scale onboarding Amazon Web Services Amazon Elastic Compute Cloud instances to Azure Arc

The following README will guide you how to use [Ansible](https://www.ansible.com/) to scale onboarding Amazon Web Services (AWS) Amazon Elastic Compute Cloud (Amazon EC2) instances to Azure Arc.

This guide assumes that you have a basic understanding of Ansible. A basic Ansible playbook and configuration is provided that uses the [`amazon.aws.aws-ec2`](https://docs.ansible.com/ansible/latest/collections/amazon/aws/aws-ec2-inventory.html) plugin for dynamic loading of EC2 server inventory.

This guide can be used even if you do not already have an existing Ansible test environment and includes a Terraform plan that will create a sample AWS EC2 server inventory comprised of four Windows Server 2019 servers and four Ubuntu servers along with a basic CentOS 7 Ansible control server with a simple configuration.

> [!WARNING]
> The provided Ansible sample workbook uses WinRM with password authentication and HTTP to configure Windows-based servers. This is not advisable for production environments. If you are planning to use Ansible with Windows hosts in a production environment then you should use [WinRM over HTTPS](/troubleshoot/windows-client/system-management-components/configure-winrm-for-https) with a certificate.

## Prerequisites

- Clone the Azure Arc Jumpstart repository.

    ```console
    git clone https://github.com/microsoft/azure_arc.git
    ```

- [Install or update Azure CLI to version 2.7 and above](/cli/azure/install-azure-cli). Use the following command to check your current installed version.

  ```console
  az --version
  ```

- [Generate SSH key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) (or use an existing SSH key)

- [Create a free AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)

- [Install Terraform >= V0.13](https://learn.hashicorp.com/tutorials/terraform/install-cli)

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

In order for Terraform to create resources in AWS, we'll need to create a new AWS IAM role with appropriate permissions and configure Terraform to use it.

- Sign in to the [AWS management console](https://console.aws.amazon.com/console/home)

- After signing in, select the **Services** dropdown in the top left. Under **Security, Identity, and Compliance**, select **IAM** to access the [identity and access management page](https://console.aws.amazon.com/iam/home)

    ![A screenshot of an AWS cloud console.](./img/aws-scale-ansible/ansible-aws-console.png)

    ![A screenshot of identity and access management in the AWS cloud console.](./img/aws-scale-ansible/ansible-iam.png)

- Select **Users** from the left menu, and then select **Add user** to create a new IAM user.

    ![A screenshot of a new user in an AWS cloud console.](./img/aws-scale-ansible/ansible-new-user-1.png)

- On the **Add User** page, name the user **Terraform** and select the **Programmatic Access** check box, and then select **Next**

    ![Second screenshot of a new user being created in an AWS cloud console.](./img/aws-scale-ansible/ansible-new-user-2.png)

- On the next page, **Set Permissions**, select **Attach existing policies directly** then check the box next to **AmazonEC2FullAccess** as shown in the screenshot, and then select **Next**.

    ![Third screenshot of a new user being created in an AWS cloud console.](./img/aws-scale-ansible/ansible-new-user-3.png)

- On the **Tags** page, assign a tag with a key of `azure-arc-demo` and select **Next** to proceed to the **Review** page.

    ![A screenshot of tags in an AWS cloud console.](./img/aws-scale-ansible/ansible-tags.png)

- Verify that everything is correct and select **Create user**.

    ![Fourth screenshot of a new user in an AWS cloud console.](./img/aws-scale-ansible/ansible-new-user-4.png)

- After the user is created, you will see the user's access key ID and secret access key. Copy these values down before selecting **Close**. On the next page, you can see an example of what this should look like. Once you have these keys, you will be able to use them with Terraform to create AWS resources.

    ![A screenshot of creating a user successfully in an AWS cloud console.](./img/aws-scale-ansible/ansible-new-user-5.png)

## Option 1: Create a sample AWS server inventory and Ansible control server using Terraform and onboard the servers to Azure Arc

> [!NOTE]
> If you already have an existing AWS server inventory and Ansible server, skip to option 2.

### Configure Terraform

Before executing the Terraform plan, you must export the environment variables which will be used by the plan. These variables are based on your Azure subscription and tenant, the Azure service principal, and the AWS IAM user and keys you just created.

- Retrieve your Azure subscription ID and tenant ID using the `az account list` command.

- The Terraform plan creates resources in both Microsoft Azure and AWS. It then executes a script on an AWS EC2 virtual machine to install Ansible and all necessary artifacts. This Terraform plan requires certain information about your AWS and Azure environments which it accesses using environment variables. Edit [`scripts/vars.sh`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/aws/scaled_deployment/ansible/terraform/scripts/vars.sh) and update each of the variables with the appropriate values.

  - `TF-VAR-subscription-id` = your Azure subscription ID
  - `TF-VAR-client-id` = your Azure service principal application ID
  - `TF-VAR-client-secret` = your Azure service principal password
  - `TF-VAR-tenant-id` = your Azure tenant ID
  - `AWS-ACCESS-KEY-ID` = AWS access key
  - `AWS-SECRET-ACCESS-KEY` = AWS secret key

- From your shell, navigate to the `azure_arc_servers_jumpstart/aws/scaled_deployment/ansible/terraform`) directory of the cloned repository.

- Export the environment variables you edited by running [`scripts/vars.sh`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/aws/scaled_deployment/ansible/terraform/scripts/vars.sh) with the source command as shown below. Terraform requires these to be set for the plan to execute properly.

    ```console
    source ./scripts/vars.sh
    ```

- Make sure your SSH keys are available in `~/.ssh` and named `id-rsa.pub` and `id-rsa`. If you followed the SSH keygen guide above to create your key then this should already be setup correctly. If not, you may need to modify [`aws-infrastructure.tf`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/aws/scaled_deployment/ansible/terraform/aws_infra.tf) to use a key with a different path.

- Run the `terraform init` command which will download the required Terraform providers.

    ![A screenshot of the `terraform init` command.](./img/aws-scale-ansible/terraform-init.png)

### Deploy server infrastructure

- From the `azure_arc_servers_jumpstart/aws/scaled_deployment/ansible/terraform` directory, run `terraform apply --auto-approve` and wait for the plan to finish. Upon successful completion, you will have four Windows Server 2019 servers, four Ubuntu servers, and one CentOS 7 Ansible control server.

- Open the AWS console and verify that you can see the created servers.

    ![A screenshot of AWS console displaying EC2 instances.](./img/aws-scale-ansible/ec2-instances.png)

### Run the Ansible playbook to onboard the AWS EC2 instances as Azure Arc enabled servers

- When the Terraform plan completes, it displays the public IP of the Ansible control server in an output variable named `ansible-ip`. SSH into the Ansible server by running `ssh centos@xx.xx.xx.xx`, where `xx.xx.xx.xx` is substituted for your Ansible server's IP address.

    ![A screenshot of an SSH key connecting to a remote server with Ansible.](./img/aws-scale-ansible/ansible-ssh.png)

- Change directory to the `ansible` directory by running `cd ansible`. This folder contains the sample Ansible configuration and the playbook we will use to onboard the servers to Azure Arc.

    ![A screenshot of a shell script listing the '' file.](./img/aws-scale-ansible/ansible-cfg.png)

- The `aw-ec2` Ansible plugin requires AWS credentials to dynamically read your AWS server inventory. We will export these as environment variables. Run the following commands, replacing the values for `AWS-ACCESS-KEY-ID` and `AWS-SECRET-ACCESS-KEY` with the AWS credentials you created earlier.

    ```console
    export AWS-ACCESS-KEY-ID="XXXXXXXXXXXXXXXXX"
    export AWS-SECRET-ACCESS-KEY="XXXXXXXXXXXXXXX"
    ```

- Replace the placeholder values for Azure tenant ID and subscription ID in the [`group-vars/all.yml`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/aws/scaled_deployment/ansible/terraform/ansible_config/group_vars/all.yml) file with the appropriate values for your environment.

    ![A screenshot of variables in a YAML file.](./img/aws-scale-ansible/yml-variables.png)

- Run the Ansible playbook by executing the following command, substituting your Azure service principal ID and service principal secret.

    ```console
    ansible-playbook arc-agent.yml -i ansible-plugins/inventory-uswest2-aws-ec2.yml --extra-vars '{"service-principal-id": "XXXXXXX-XXXXX-XXXXXXX", "service-principal-secret": "XXXXXXXXXXXXXXXXXXXXXXXX"}'
    ```

    If the playbook run is successful, you should see output similar to the below screenshot.

    ![A screenshot of an Ansible playbook running.](./img/aws-scale-ansible/ansible-playbook.png)

- Open the Azure portal and navigate to the arc-aws-demo` resource group. You should see the Azure Arc enabled servers listed.

    ![A screenshot of the Azure portal onboarding Azure Arc enabled servers.](./img/aws-scale-ansible/onboarding-servers.png)

### Clean up environment by deleting resources

To delete all the resources you created as part of this demo, use the `terraform destroy --auto-approve` command as shown.

![A screenshot of the `terraform destroy` command.](./img/aws-scale-ansible/terraform-destroy.png)

## Option 2: Onboarding an existing AWS server inventory to Azure Arc using your own Ansible control server

> [!NOTE]
> If you do not have an existing AWS server inventory and Ansible server, navigate back to option 1.

### Review provided Ansible configuration and playbook

Navigate to the `ansible-config` directory and review the provided configuration. The provided configuration contains a basic `ansible.cfg` file. This file enables the [`amazon.aws.aws-ec2`](https://docs.ansible.com/ansible/latest/collections/amazon/aws/aws-ec2-inventory.html) Ansible plugin which dynamically loads your server inventory by using an AWS IAM role. Ensure that the IAM role you are using has sufficient privileges to access the inventory you wish to onboard.

![A screenshot showing the details of an `ansible.cfg` file.](./img/aws-scale-ansible/ansible-cfg-details.png)

The file [`inventory-uswest2-aws-ec2.yml`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/aws/scaled_deployment/ansible/terraform/ansible_config/ansible_plugins/inventory_uswest2_aws_ec2.yml) configures the `aws-ec2` plugin to pull inventory from `uswest2` region and group assets by applied tags. Adjust this file as needed to support onboarding your server inventory, such as changing the region or adjusting groups or filters.

The files in `./ansible-config/group-vars` should be adjusted to provide the credentials you wish to use to onboard various Ansible host groups.

When you have adjusted the provided configuration to support your environment, run the Ansible playbook by executing the following command, substituting your Azure service principal ID and service principal secret.

```console
ansible-playbook arc-agent.yml -i ansible-plugins/inventory-uswest2-aws-ec2.yml --extra-vars '{"service-principal-id": "XXXXXXX-XXXXX-XXXXXXX", "service-principal-secret": "XXXXXXXXXXXXXXXXXXXXXXXX"}'
```

As earlier, if the playbook run is successful, you should see an output that similar to the following screenshot:

![A screenshot of an Ansible playbook running.](./img/aws-scale-ansible/ansible-playbook.png)

As earlier, open Azure portal and navigate to the arc-aws-demo` resource group. You should see the Azure Arc enabled servers listed.

![A screenshot of the Azure portal showing Azure Arc enabled servers.](./img/aws-scale-ansible/onboarding-servers.png)
