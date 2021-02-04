---
title: Deploy a local Windows server hosted by Vagrant and connect it to Azure Arc
description: Deploy a local Windows server hosted by Vagrant and connect it to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: think-tank, e2e-hybrid
---

# Deploy a local Windows server hosted by Vagrant and connect it to Azure Arc

The following README will guide you on how to deploy a local **Windows 10** virtual machine using [Vagrant](https://www.vagrantup.com/) and connect it as an Azure-Arc-enabled server resource.

## Prerequisites

* Clone the Azure Arc Jumpstart repository

    ```console
    git clone https://github.com/microsoft/azure-arc.git
    ```

* [Install or update Azure CLI to version 2.7 and above](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest). Use the below command to check your current installed version.

  ```console
  az --version
  ```

* Vagrant relies on an underlying hypervisor. For the purpose of this guide, we will be using "Oracle VM VirtualBox".

  * Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

    * If you are an OSX user, simply run ```brew cask install virtualbox```
    * If you are a Windows user, you can use the [Chocolatey package](https://chocolatey.org/packages/virtualbox)
    * If you are a Linux user, all package installation methods can be found [here](https://www.virtualbox.org/wiki/Linux-Downloads)

  * Install [Vagrant](https://www.vagrantup.com/docs/installation/)

    * If you are an OSX user, simply run ```brew cask install vagrant```
    * If you are a Windows user, you can use the [Chocolatey package](https://chocolatey.org/packages/vagrant)
    * If you are a Linux user, look [here](https://www.vagrantup.com/downloads.html)

* Create Azure service principal (SP)

    To connect the Vagrant virtual machine to Azure Arc, an Azure service principal assigned with the "Contributor" role is required. To create it, login to your Azure account run the below command (this can also be done in [Azure Cloud Shell](https://shell.azure.com/)).

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

    > **Note: It is optional but highly recommended to scope the SP to a specific [Azure subscription and resource group](https://docs.microsoft.com/cli/azure/ad/sp?view=azure-cli-latest)**

* The Vagrantfile executes a script on the VM OS to install all the needed artifacts as well to inject environment variables. Edit the [*scripts/vars.ps1*](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/local/vagrant/windows/scripts/vars.ps1) PowerShell script to match the Azure service principal you've just created.

  * subscriptionId=Your Azure subscription ID
  * appId=Your Azure service principal name
  * password=Your Azure service principal password
  * tenantId=Your Azure tenant ID
  * resourceGroup=Azure resource group name
  * location=Azure region

## Deployment

Like any Vagrant deployment, a [*Vagrantfile*](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/local/vagrant/windows/Vagrantfile) and a [Vagrant Box](https://www.vagrantup.com/docs/boxes.html) is needed. At a high-level, the deployment will:

1. Download the Windows 10 image file [Vagrant Box](https://app.vagrantup.com/StefanScherer/boxes/windows-10)
2. Execute the Arc installation script

After editing the ***scripts/vars.ps1*** script to match your environment, from the *Vagrantfile* folder, run ```vagrant up```. As this is the first time you are creating the VM, the first run will be **much slower** than the ones to follow. This is because the deployment is downloading the Windows 10 box for the first time.

![A screenshot of running the 'vagrant up' command.](./img/local-vagrant-windows/vagrant-win-cmd.png)

Once the download is complete, the actual provisioning will start. As you can see in the screenshot below, the process takes can take somewhere between 7 to 10 minutes.

![A screenshot of a completed 'vagrant up' command.](./img/local-vagrant-windows/vagrant-win-complete.png)

Upon completion, you will have a local Windows 10 VM deployed, connected as a new Azure-Arc-enabled server inside a new resource group.

![A screenshot of an Azure-Arc-enabled server in the Azure portal.](./img/local-vagrant-windows/vagrant-win-server.png)

![A screenshot of the details from an Azure-Arc-enabled server in the Azure portal.](./img/local-vagrant-windows/vagrant-win-server-details.png)

## Semi-Automated Deployment (Optional)

As you may noticed, the last step of the run is to register the VM as a new Azure-Arc-enabled server resource.

![Another screenshot of a completed 'vagrant up' command.](./img/local-vagrant-windows/vagrant-win-complete-2.png)

In a case you want to demo/control the actual registration process, to the following:

* In the [*install-arc-agent*](https://github.com/microsoft/azure-arc/blob/main/azure-arc-servers-jumpstart/local/vagrant/windows/scripts/install-arc-agent.ps1) PowerShell script, comment out the "Run connect command" section and save the file. You can also comment out or change the creation of the resource group.

    ![A screenshot of the 'install-arc-agent' PowerShell script.](./img/local-vagrant-windows/vagrant-win-install-arc-agent.png)

    ![A screenshot of the 'az group create' command.](./img/local-vagrant-windows/vagrant-win-az-group-create.png)

* RDP the VM using the ```vagrant rdp``` command. Use *vagrant/vagrant* as the username/password.

    ![A screenshot of accessing a Vagrant server with the Microsoft Remote Desktop Protocol.](./img/local-vagrant-windows/vagrant-win-rdp.png)

* Open PowerShell ISE **as Administrator** and edit the *C:\runtime\vars.ps1* with your environment variables.

    ![A screenshot of Windows PowerShell ISE.](./img/local-vagrant-windows/vagrant-win-ise.png)

* Paste the ```Invoke-Expression "C:\runtime\vars.ps1"``` commmand, the ```az group create --location $env:location --name $env:resourceGroup --subscription $env:subscriptionId``` command and the same *azcmagent connect* command you've just commented and execute the script.

    ![A screenshot of PowerShell ISE running a script.](./img/local-vagrant-windows/vagrant-win-ise-script.png)

## Delete the deployment

To delete the entire deployment, run the ```vagrant destroy -f``` command. The Vagrantfile includes a *before: destroy* Vagrant trigger which will run the command to delete the Azure resource group before destroying the actual VM. That way, you will be starting fresh next time.

![A screenshot of the 'vagrant destroy' command.](./img/local-vagrant-windows/vagrant-win-vagrant-destroy.png)
