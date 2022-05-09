---
title: Create a VMware vSphere template for Windows Server 2019
description: Create a VMware vSphere template for Windows Server 2019.
author: likamrat
ms.author: brblanch
ms.date: 05/09/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

# Create a VMware vSphere template for Windows Server 2019

This article provides guidance for creating a Windows Server 2019 VMware vSphere virtual machine (VM) template.

## Prerequisites

> [!NOTE]
> This guide assumes that you have some VMware vSphere familiarity and you have knowledge on how to install Windows Server.

- [Download the latest Windows Server ISO file](https://www.microsoft.com/windows-server/trial)

- VMware vSphere 6.5 and above

- It's recommended to upload the Windows Server ISO file to a vSphere datastore or to vCenter content library for faster development. Note that the ISO file can also be used locally.

## Creating Windows Server 2019 VM template

Learn how to deploy and install Windows server and convert VM to a template.

### Deploying and installing Windows Server

1. Deploy a new virtual machine.

    ![Screenshot of vSphere Client to select New virtual machine.](./media/vmware-template/windows-template-new-vm-1.png)

    ![Screenshot of New Virtual Machine page to create a new virtual machine and select Next.](./media/vmware-template/windows-template-new-vm-2.png)

    ![Screenshot of New Virtual Machine page to select a name and folder for the virtual machine.](./media/vmware-template/windows-template-new-vm-3.png)

    ![Screenshot of New Virtual Machine page to select a new compute resource.](./media/vmware-template/windows-template-new-vm-4.png)

    ![Screenshot of New Virtual Machine page to select storage.](./media/vmware-template/windows-template-new-vm-5.png)

    ![Screenshot of New Virtual Machine page to select compatibility.](./media/vmware-template/windows-template-new-vm-6.png)

2. Make sure to select **Microsoft Windows Server 2016 or later (64-bit)** as the guest OS.

    ![Screenshot of New Virtual Machine page to select a guest OS.](./media/vmware-template/windows-template-guest-os.png)

3. Point to the Windows Server ISO file location.

    ![Screenshot of New Virtual Machine page to customize hardware.](./media/vmware-template/windows-template-new-vm-7.png)

    ![Screenshot of New Virtual Machine page to review all the specifications selected.](./media/vmware-template/windows-template-new-vm-8.png)

- Power on the VM and start the Windows Server installation.

    ![Screenshot of vSphere Client to select Run button to start Windows Server.](./media/vmware-template/windows-template-installation-1.png)

    ![Screenshot of Windows Setup to select language and other preferences.](./media/vmware-template/windows-template-installation-2.png)

    ![Screenshot of Windows Setup to select Install now.](./media/vmware-template/windows-template-installation-3.png)

    ![Screenshot of Windows Setup to select the operating system you want to install.](./media/vmware-template/windows-template-installation-4.png)

    ![Screenshot of Windows Setup showing applicable notices and license terms.](./media/vmware-template/windows-template-installation-5.png)

    ![Screenshot of Windows Setup specifying the location to install Windows.](./media/vmware-template/windows-template-installation-6.png)

    ![Screenshot of Windows Setup showing the status of installation.](./media/vmware-template/windows-template-installation-7.png)

### Post-installation

Before converting the VM to a template, several actions are required.

1. Install VMware Tools and restart.

    ![Screenshot to install VM ware tools.](./media/vmware-template/windows-template-tools-1.png)

    ![Screenshot to select Mount to organize the disk image with VMware tools.](./media/vmware-template/windows-template-tools-2.png)

    ![Screenshot of the Windows explorer showing local disc space.](./media/vmware-template/windows-template-tools-3.png)

    ![Screenshot of VMware tools Setup to select Next for installation.](./media/vmware-template/windows-template-tools-4.png)

    ![Screenshot of VMware tools Setup window to select the type of installation as Typical.](./media/vmware-template/windows-template-tools-5.png)

    ![Screenshot of VMware tools Setup window to select Install button to begin the installation.](./media/vmware-template/windows-template-tools-6.png)

    ![Screenshot of VMware tools Setup showing that the setup is complete and select Finish.](./media/vmware-template/windows-template-tools-7.png)

    ![Screenshot of VMware tools Setup showing a dialog to restart your system.](./media/vmware-template/windows-template-tools-8.png)

    ![Screenshot of a VMware Tools Setup showing the summary of the installation.](./media/vmware-template/windows-template-tools-9.png)

2. Perform Windows updates.

3. Change PowerShell execution policy to `Bypass` by running the `Set-ExecutionPolicy -ExecutionPolicy Bypass` command in PowerShell (can be later tuned on via group policy or a PowerShell script).

4. Allow WinRM communication to the operating system by running the [`allow_winrm`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/winsrv/terraform/scripts/allow_winrm.ps1) PowerShell script.

5. It is suggested to consider the following steps for a windows template:

    - Disable user account control (can be later turned on using group policy or a PowerShell script)
    - Turn off Windows Defender Firewall (can be later turned on using group policy or a PowerShell script)
    - Disable Internet Explorer Enhanced Security Configuration (ESC) (can be later turned on using group policy or a PowerShell script)
    - Enable Remote Desktop Services
    - From PowerShell, install [Chocolatey](https://chocolatey.org/install)

      ```powershell
      Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
      ```

    - Install all the baseline applications that you want to include in your template.

### Convert to template

- Reduce the VM CPU count and memory resources to the minimum and convert the VM to template.
- Switch the CD/DVD drive to client device as well disconnect it and convert the VM to template.

![A screenshot of the virtual hardware settings for the virtual machine's CPU count and memory.](./media/vmware-template/windows-template-reduce.png)

![A screenshot of Templates showing the actions to Convert to Template](./media/vmware-template/windows-template-convert.png)
