---
title: Create a VMware vSphere template for Windows Server 2019
description: Create a VMware vSphere template for Windows Server 2019.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: think-tank, e2e-hybrid
---

# Create a VMware vSphere template for Windows Server 2019

The following README will guide you on how to create a Windows Server 2019 VMware vSphere virtual machine template.

## Prerequisites

> [!NOTE]
> This guide assumes that you have some VMware vSphere familiarity and you have knowledge on how to install Windows Server. It also does not review either VMware or Windows best practices.

- [Download the latest Windows Server ISO file](https://www.microsoft.com/windows-server/trial)

- VMware vSphere 6.5 and above

- Although it can be used locally, for faster deployment, it is recommended to upload the file to a vSphere datastore or to vCenter content library.

## Creating Windows Server 2019 VM template

### Deploying and installing Windows Server

- Deploy new virtual machine

    ![A screenshot of how to create a new VMware vSphere virtual machine.](./img/vmware-winsrv2k19-template/winsrv-template-newvm-1.png)

    ![Second screenshot of how to create a new VMware vSphere virtual machine.](./img/vmware-winsrv2k19-template/winsrv-template-newvm-2.png)

    ![Third screenshot of how to create a new VMware vSphere virtual machine.](./img/vmware-winsrv2k19-template/winsrv-template-newvm-3.png)

    ![Fourth screenshot of how to create a new VMware vSphere virtual machine.](./img/vmware-winsrv2k19-template/winsrv-template-newvm-4.png)

    ![Fifth screenshot of how to create a new VMware vSphere virtual machine.](./img/vmware-winsrv2k19-template/winsrv-template-newvm-5.png)

    ![Sixth screenshot of how to create a new VMware vSphere virtual machine.](./img/vmware-winsrv2k19-template/winsrv-template-newvm-6.png)

- Make sure to select **Microsoft Windows Server 2016 or later (64-bit)** as the guest OS.

    ![A screenshot of Windows Server guest OS.](./img/vmware-winsrv2k19-template/winsrv-template-guest-os.png)

- Point to the Windows Server ISO file location.

    ![Seventh screenshot of how to create a new VMware vSphere virtual machine.](./img/vmware-winsrv2k19-template/winsrv-template-newvm-7.png)

    ![Eighth screenshot of how to create a new VMware vSphere virtual machine.](./img/vmware-winsrv2k19-template/winsrv-template-newvm-8.png)

- Power on the VM and start the Windows Server installation.

    ![First screenshot of a Windows Server installation.](./img/vmware-winsrv2k19-template/winsrv-template-installation-1.png)

    ![Second screenshot of a Windows Server installation.](./img/vmware-winsrv2k19-template/winsrv-template-installation-2.png)

    ![Third screenshot of a Windows Server installation.](./img/vmware-winsrv2k19-template/winsrv-template-installation-3.png)

    ![Fourth screenshot of a Windows Server installation.](./img/vmware-winsrv2k19-template/winsrv-template-installation-4.png)

    ![Fifth screenshot of a Windows Server installation.](./img/vmware-winsrv2k19-template/winsrv-template-installation-5.png)

    ![Sixth screenshot of a Windows Server installation.](./img/vmware-winsrv2k19-template/winsrv-template-installation-6.png)

    ![Seventh screenshot of a Windows Server installation.](./img/vmware-winsrv2k19-template/winsrv-template-installation-7.png)

### Post-installation

Before converting the VM to a template, few actions needs to be taken.

- Install VMware tools and restart

    ![First screenshot of a WMware Tools installation.](./img/vmware-winsrv2k19-template/winsrv-template-tools-1.png)

    ![Second screenshot of a WMware Tools installation.](./img/vmware-winsrv2k19-template/winsrv-template-tools-2.png)

    ![Third screenshot of a WMware Tools installation.](./img/vmware-winsrv2k19-template/winsrv-template-tools-3.png)

    ![Fourth screenshot of a WMware Tools installation.](./img/vmware-winsrv2k19-template/winsrv-template-tools-4.png)

    ![Fifth screenshot of a WMware Tools installation.](./img/vmware-winsrv2k19-template/winsrv-template-tools-5.png)

    ![Sixth screenshot of a WMware Tools installation.](./img/vmware-winsrv2k19-template/winsrv-template-tools-6.png)

    ![Seventh screenshot of a WMware Tools installation.](./img/vmware-winsrv2k19-template/winsrv-template-tools-7.png)

    ![Eighth screenshot of a WMware Tools installation.](./img/vmware-winsrv2k19-template/winsrv-template-tools-8.png)

    ![Ninth screenshot of a WMware Tools installation.](./img/vmware-winsrv2k19-template/winsrv-template-tools-9.png)

- Perform Windows updates

- Change PowerShell execution policy to `Bypass` by running the `Set-ExecutionPolicy -ExecutionPolicy Bypass` command in PowerShell (can be later tuned on via group policy or a PowerShell script).

- Allow WinRM communication to the OS by running the [`allow_winrm`](https://github.com/microsoft/azure_arc/blob/main/azure_arc_servers_jumpstart/vmware/winsrv/terraform/scripts/allow_winrm.ps1) PowerShell script.

- None of the below are mandatory but should be considered for a Windows template:

  - Disabling user account control (can be later tuned on via group policy or a PowerShell script)
  - Turn off Windows Defender Firewall (can be later tuned on via group policy or a PowerShell script)
  - Disabling Internet Explorer Enhanced Security Configuration (ESC) (can be later tuned on via group policy or a PowerShell script)
  - Enable remote desktop
  - In PowerShell, install [Chocolatey](https://chocolatey.org/install)

    ```powershell
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    ```

  - Install all baseline applications you may want to include in your template.

### Convert to template

Reduce the VM CPU count and memory resources to the minimum and convert the VM to template, switch the CD/DVD drive to client device as well disconnect it and convert the VM to template.

![A screenshot of how to reduce a virtual machine's CPU count and memory.](./img/vmware-winsrv2k19-template/winsrv-template-reduce.png)

![A screenshot of how to convert a virtual machine to a template.](./img/vmware-winsrv2k19-template/winsrv-template-convert.png)
