---
title: Use VMware PowerCLI to scale onboarding VMware vSphere Linux virtual machines to Azure Arc
description: Use VMware PowerCLI to scale onboarding VMware vSphere Linux virtual machines to Azure Arc.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

# Use VMware PowerCLI to scale onboarding VMware vSphere Linux virtual machines to Azure Arc

This article provides guidance for using the provided [VMware PowerCLI](https://code.vmware.com/web/dp/tool/vmware-powercli/) script so you can perform an automated scaled deployment of the Azure Arc connected machine agent in multiple VMware vSphere virtual machines and as a result, onboarding these VMs as an Azure Arc enabled servers.

This guide assumes you already have an exiting inventory of VMware virtual machines and will use the PowerCLI PowerShell module to automate the onboarding process of the VMs to Azure Arc.

## Prerequisites

1. Clone the Azure Arc Jumpstart repository.

    ```console
    git clone https://github.com/microsoft/azure_arc.git
    ```

2. [Install or update Azure CLI to version 2.7 and above](/cli/azure/install-azure-cli). Use the following command to check your current installed version.

    ```console
    az --version
    ```

3. Install VMware PowerCLI.

    > [!NOTE]
    > This guide was tested with the latest version of PowerCLI as of publication (12.0.0), but earlier versions are expected to work as well.

    - **Supported PowerShell versions:** VMware PowerCLI 12.0.0 is compatible with the following PowerShell versions:
        - Windows PowerShell 5.1
        - PowerShell 7
        - Detailed installation instructions can be found [here](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.esxi.install.doc/GUID-F02D0C2D-B226-4908-9E5C-2E783D41FE2D.html) but the easiest way is to use the `VMware.PowerCLI` module from the PowerShell gallery using the following command.

          ```powershell
          Install-Module -Name VMware.PowerCLI
          ```

4. To be able to read the VM inventory from vCenter as well as invoke a script on the VM OS level, the following permissions are needed:

    - [`VirtualMachine.GuestOperations`](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-6A952214-0E5E-4CCF-9D2A-90948FF643EC.html) user account

    - VMware vCenter Server user assigned with a [Read-only role](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.security.doc/GUID-93B962A7-93FA-4E96-B68F-AE66D3D6C663.html)

5. Create an Azure service principal.

    To connect the VMware vSphere virtual machine to Azure Arc, an Azure service principal assigned with the Contributor role is required. To create it, sign in to your Azure account and run the following command. You can also run this command in [Azure Cloud Shell](https://shell.azure.com/).

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

## Automation flow

The automation flow for this scenario includes these steps:

1. Edit the [`vars.ps1`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/scaled_deployment/powercli/linux/vars.ps1) PowerCLI script.

2. Upon execution of the [`scale-deploy.ps1`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/scaled_deployment/powercli/linux/scale_deploy.ps1) PowerShell script:

    - The script will auto-generate a `vars.sh` shell script with the user's Azure environment variables.

    - The script execution will initiate authentication against vCenter and will scan the targeted VM folder where Azure Arc candidate VMs are located and will copy both the auto-generated `vars.sh` and the `install_azure_arc_agent.sh` shell scripts to VM Linux OS located in `/vmware/scaled-deploy/powercli/linux` to each VM in that VM folder.

3. The `install_azure_arc_agent.sh` shell script will run on the VM guest OS and will install the Azure Arc connected machine agent in order to onboard the VM to Azure Arc.

## Predeployment

To demonstrate the before and after for this scenario, the below screenshots shows a dedicated, empty Azure resource group, a vCenter VM folder with candidate VMs and the `/var/opt/` directory showing no agent is installed.

![Screenshot of an An empty Azure resource group.](./media/vmware-scale-powercli/cli-linux-empty.png)

![A screenshot of a vanilla VMware vSphere virtual machine without an Azure Arc agent.](./media/vmware-scale-powercli/cli-linux-vanilla-1.png)

![Another screenshot of a vanilla VMware vSphere virtual machine without an Azure Arc agent.](./media/vmware-scale-powercli/cli-linux-vanilla-2.png)

## Deployment

Before running the PowerCLI script, you must set the [environment variables](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/scaled_deployment/powercli/linux/vars.ps1) which will be used by the `install_azure_arc_agent.sh` script. These variables are based on the Azure service principal you've just created, your Azure subscription and tenant, and your VMware vSphere credentials and data.

- Retrieve your Azure subscription ID and tenant ID using the `az account list` command

- Use the Azure service principal ID and password created in the prerequisites section:

    ![A screenshot of exporting environment variables.](./media/vmware-scale-powercli/cli-linux-export-variables.png)

- From the `azure_arc_servers_jumpstart\vmware\scaled-deploy\powercli\linux` folder, open a PowerShell session as an administrator and run the `scale-deploy.ps1` script.

    ![A screenshot of `scale_deploy.ps1`.](./media/vmware-scale-powercli/cli-linux-scale-deploy-1.png)

    ![A second screenshot of `scale_deploy.ps1`.](./media/vmware-scale-powercli/cli-linux-scale-deploy-2.png)

    ![A third screenshot of `scale_deploy.ps1`.](./media/vmware-scale-powercli/cli-linux-scale-deploy-3.png)

- Upon completion, the VM will have the Azure Arc connected machine agent installed as well as the Azure resource group populated with the new Azure Arc enabled servers.

    ![A screenshot of a machine with an Azure Arc Agent installed.](./media/vmware-scale-powercli/cli-linux-agent.png)

    ![A screenshot of new Azure Arc enabled servers in an Azure resource group.](./media/vmware-scale-powercli/cli-linux-servers-1.png)

    ![Another screenshot of new Azure Arc enabled servers in an Azure resource group.](./media/vmware-scale-powercli/cli-linux-servers-2.png)
