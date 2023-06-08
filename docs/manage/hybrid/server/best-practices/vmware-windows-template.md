---
title: Create a VMware vSphere template for Windows Server 2019
description: Create a VMware vSphere template for Windows Server 2019.
author: likamrat
ms.author: martinek
ms.date: 05/09/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

# Create a VMware vSphere template for Windows Server 2019

This article guides you through the process for creating a Windows Server 2019 VMware vSphere virtual machine (VM) template.

## Prerequisites

> [!NOTE]
> This guide assumes that you have some familiarity with VMware vSphere and know how to install Windows Server.

- Make sure you have [the latest Windows Server ISO file](https://www.microsoft.com/windows-server/trial) downloaded.
    - It's recommended to upload the Windows Server ISO file to a vSphere datastore or to vCenter content library for faster development. Note that the ISO file can also be used locally.

- Make sure you have VMware vSphere version 6.5 or above.

## Create a Windows Server 2019 VM template

Learn how to deploy and install Windows Server and convert VM to a template.

### Deploy and install Windows Server

1. Deploy a new virtual machine.

    ![Screenshot of vSphere client window that shows where you select the New Virtual Machine option.](./media/vmware-template/windows-template-new-vm-1.png)

    ![Screenshot of the "Select a creation type" section of the New Virtual Machine creation pane.](./media/vmware-template/windows-template-new-vm-2.png)

    ![Screenshot of the "Select a name and folder" section of the New Virtual Machine creation pane.](./media/vmware-template/windows-template-new-vm-3.png)

    ![Screenshot of the "Select a compute resource" section of the New Virtual Machine creation pane.](./media/vmware-template/windows-template-new-vm-4.png)

    ![Screenshot of the "Select storage" section of the New Virtual Machine creation pane.](./media/vmware-template/windows-template-new-vm-5.png)

    ![Screenshot of the "Select compatibility" section of the New Virtual Machine creation pane.](./media/vmware-template/windows-template-new-vm-6.png)

2. Make sure you select **Microsoft Windows Server 2016 or later (64-bit)** as the guest OS.

    ![Screenshot of the "Select a guest OS" section of the New Virtual Machine creation pane.](./media/vmware-template/windows-template-guest-os.png)

3. Point to the Windows Server ISO file location.

    ![Screenshot of the "Customize hardware" section of the New Virtual Machine creation pane.](./media/vmware-template/windows-template-new-vm-7.png)

    ![Screenshot of the "Ready to complete" section of the New Virtual Machine creation pane.](./media/vmware-template/windows-template-new-vm-8.png)

- Power on your new VM and install Windows Server.

    ![Screenshot of the Windows Server run button in the vSphere client.](./media/vmware-template/windows-template-installation-1.png)

    ![Screenshot of Windows Setup window containing options for language and other preferences.](./media/vmware-template/windows-template-installation-2.png)

    ![Screenshot of Windows Setup window showing the "Install now" button.](./media/vmware-template/windows-template-installation-3.png)

    ![Screenshot of Windows Setup window where you select which operating system you want to install.](./media/vmware-template/windows-template-installation-4.png)

    ![Screenshot of Windows Setup window displaying Applicable notices and license terms.](./media/vmware-template/windows-template-installation-5.png)

    ![Screenshot of Windows Setup window where you select the location for your Windows Server installation.](./media/vmware-template/windows-template-installation-6.png)

    ![Screenshot of Windows Setup window showing the installation status.](./media/vmware-template/windows-template-installation-7.png)

### Post-installation

Before you convert your VM to a template, complete the following steps.

1. Install VMware Tools and restart.

    ![Screenshot showing the Install VMware tools button location.](./media/vmware-template/windows-template-tools-1.png)

    ![Screenshot showing install instructions for VMware tools.](./media/vmware-template/windows-template-tools-2.png)

    ![Screenshot of VMware Tools DVD Drive in the Windows Explorer window.](./media/vmware-template/windows-template-tools-3.png)

    ![Screenshot of VMware Tools Setup window containing the installation wizard.](./media/vmware-template/windows-template-tools-4.png)

    ![Screenshot of the VMware Tools Setup window where you select the "Typical" installation type.](./media/vmware-template/windows-template-tools-5.png)

    ![Screenshot of the VMware Tools Setup window saying it's ready to install.](./media/vmware-template/windows-template-tools-6.png)

    ![Screenshot of the VMware Tools Setup window showing that setup is complete.](./media/vmware-template/windows-template-tools-7.png)

    ![Screenshot of the VMware Tools Setup dialog box requiring a system restart.](./media/vmware-template/windows-template-tools-8.png)

    ![Screenshot of the vSphere client showing VMware Tools status.](./media/vmware-template/windows-template-tools-9.png)

2. Perform Windows updates.

3. Change PowerShell execution policy to `Bypass` by running the `Set-ExecutionPolicy -ExecutionPolicy Bypass` command in PowerShell (you can also turn this on later using group policy or a PowerShell script).

4. Allow communication between WinRM and the OS by running the [`allow_winrm`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/winsrv/terraform/scripts/allow_winrm.ps1) PowerShell script

5. Consider following these extra steps when creating a windows template:

    - Disable user account control (you can also turn this on later using group policy or a PowerShell script).
    - Turn off Windows Defender Firewall (you can also turn this on later using group policy or a PowerShell script).
    - - Disable Internet Explorer Enhanced Security Configuration (ESC) (you can also turn this on later using group policy or a PowerShell script).
    - Enable Remote Desktop Services.
    - Use PowerShell to install [Chocolatey](https://chocolatey.org/install).

      ```powershell
      Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
      ```

    - Install all baseline applications you might want to include in your template.
    
> [!NOTE]
> This guide is about creating VM templates. Additional care should be taken to make sure your VM deployments have appropriate controls in place to meet your security requirements.

### Convert VM to a template

- Reduce the VM's CPU count and memory resources to the minimum.
- Switch the CD/DVD drive to client device, disconnect it, and convert the VM to a template.

![Screenshot of the virtual hardware settings page options.](./media/vmware-template/windows-template-reduce.png)

![Screenshot of the vSphere client showing Convert to Template button location.](./media/vmware-template/windows-template-convert.png)
