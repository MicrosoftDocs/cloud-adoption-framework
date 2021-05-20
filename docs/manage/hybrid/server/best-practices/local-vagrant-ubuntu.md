---
title: Deploy a local Ubuntu server hosted with Vagrant and connect it to Azure Arc
description: Deploy a local Ubuntu server hosted with Vagrant and connect it to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

# Deploy a local Ubuntu server hosted with Vagrant and connect it to Azure Arc

This article provides guidance for deploying a local **Ubuntu** virtual machine using [Vagrant](https://www.vagrantup.com/) and connect it as an Azure Arc enabled server resource.

## Prerequisites

1. Clone the Azure Arc Jumpstart repository.

    ```console
    git clone https://github.com/microsoft/azure_arc.git
    ```

2. [Install or update Azure CLI to version 2.7 and above](/cli/azure/install-azure-cli). Use the following command to check your current installed version.

    ```console
    az --version
    ```

3. Vagrant relies on an underlying hypervisor. For this guide, we will be using "Oracle VM VirtualBox".

    1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

        - If you are a macOS user, run `brew cask install virtualbox`
        - If you are a Windows user, you can use the [Chocolatey package](https://chocolatey.org/packages/virtualbox)
        - If you are a Linux user, all package installation methods can be found [here](https://www.virtualbox.org/wiki/Linux_Downloads)

    2. Install [Vagrant](https://www.vagrantup.com/docs/installation)

        - If you are a macOS user, run `brew cask install vagrant`
        - If you are a Windows user, you can use the [Chocolatey package](https://chocolatey.org/packages/vagrant)
        - If you are a Linux user, look [here](https://www.vagrantup.com/downloads)

4. Create an Azure service principal.

    To connect the Vagrant virtual machine to Azure Arc, an Azure service principal assigned with the Contributor role is required. To create it, sign in to your Azure account and run the following command. You can also run this command in [Azure Cloud Shell](https://shell.azure.com/).

    ```console
    az login
    az ad sp create-for-rbac -n "<Unique SP Name>" --role contributor
    ```

    For example:

    ```console
    az ad sp create-for-rbac -n "http://AzureArcServers" --role contributor
    ```

    Output should look like this:

    ```json
    {
      "appId": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX",
      "displayName": "AzureArcServers",
      "name": "http://AzureArcServers",
      "password": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX",
      "tenant": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    }
    ```

    > [!NOTE]
    > We highly recommend that you scope the service principal to a specific [Azure subscription and resource group](/cli/azure/ad/sp).

5. The Vagrant file executes a script on the VM OS to install all the needed artifacts and to inject environment variables. Edit the [`scripts/vars.sh`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/local/vagrant/ubuntu/scripts/vars.sh) shell script to match the Azure service principal you created.

    - `subscriptionId` = your Azure subscription ID
    - `appId` = your Azure service principal name
    - `password` = your Azure service principal password
    - `tenantId` = your Azure tenant ID
    - `resourceGroup` = Azure resource group name
    - `location` = Azure region

## Deployment

Like any Vagrant deployment, a [vagrantfile](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/local/vagrant/ubuntu/Vagrantfile) and a [Vagrant box](https://www.vagrantup.com/docs/boxes) is needed. At a high-level, the deployment will:

- Download the Ubuntu 16.04 image file [Vagrant box](https://app.vagrantup.com/ubuntu/boxes/xenial64)
- Execute the installation script

After editing the `scripts/vars.sh` script to match your environment, from the `Vagrantfile` folder, run `vagrant up`. Since this is the first time creating the VM, the first run will be **much slower** than the ones to follow, because the deployment is downloading the Ubuntu box for the first time.

![A screenshot of the `vagrant up` command.](./media/local-vagrant/vagrant-ubuntu-vagrant-up.png)

Once the download is complete, the provisioning begins. As shown in the following screenshot, the process takes no longer than three minutes.

![A screenshot of a completed `vagrant up` command.](./media/local-vagrant/vagrant-ubuntu-vagrant-up-complete.png)

Upon completion, you will have a local Ubuntu VM deployed, connected as a new Azure Arc enabled server, inside a new resource group.

![A screenshot of an Azure Arc enabled server in the Azure portal.](./media/local-vagrant/vagrant-ubuntu-server.png)

![A screenshot of details from an Azure Arc enabled server in the Azure portal.](./media/local-vagrant/vagrant-ubuntu-server-details.png)

## Semi-automated deployment (optional)

The last step is to register the VM as a new Azure Arc enabled server resource.

![Another screenshot of the `vagrant up` command.](./media/local-vagrant/vagrant-ubuntu-vagrant-up-2.png)

If you want to demo/control the actual registration process, complete the following steps:

1. In the [`install_arc_agent`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/local/vagrant/ubuntu/scripts/install_arc_agent.sh) shell script, comment out the `run connect command` section and save the file. You can also comment out or change the creation of the resource group.

    ![A screenshot of the `azcmagent connect` command.](./media/local-vagrant/vagrant-ubuntu-azcmagent.png)

    ![A screenshot of the `az group create` command.](./media/local-vagrant/vagrant-ubuntu-az-group-create.png)

2. SSH to the VM using the `vagrant ssh` command.

    ![A screenshot of an SSH key connecting to the Vagrant machine.](./media/local-vagrant/vagrant-ubuntu-ssh.png)

3. Run the same `azcmagent connect` command you commented out using your environment variables.

    ![Another screenshot of the `azcmagent connect` command.](./media/local-vagrant/vagrant-ubuntu-azcmagent-2.png)

## Delete the deployment

To delete the entire deployment, run the `vagrant destroy -f` command. The vagrantfile includes a `before: destroy` Vagrant trigger, which will run a script to delete the Azure resource group before destroying the actual VM.

![A screenshot of the `vagrant destroy` command.](./media/local-vagrant/vagrant-ubuntu-vagrant-destroy.png)
