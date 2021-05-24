---
title: Create a VMware vSphere template for Ubuntu server 18.04
description: Create a VMware vSphere template for Ubuntu server 18.04.
author: likamrat
ms.author: brblanch
ms.date: 01/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, e2e-hybrid
---

<!-- cspell:ignore netplan -->

# Create a VMware vSphere template for Ubuntu server 18.04

This article provides guidance for creating an Ubuntu Server 18.04 VMware vSphere virtual machine template.

## Prerequisites

> [!NOTE]
> This guide assumes that you have some VMware vSphere familiarity. It's not designed to review either VMware or Ubuntu best practices.

- [Download the latest Ubuntu server 18.04 ISO file](https://releases.ubuntu.com/18.04/)

- VMware vSphere 6.5 and above

- Although it can be used locally, for faster deployment, upload the file to a vSphere datastore or to vCenter content library.

## Creating Ubuntu 18.04 VM template

### Deploying and installing Ubuntu

- Deploy new virtual machine

    ![A screenshot of how to create a new VMware vSphere virtual machine.](./media/vmware-template/ubuntu-template-new-vm-1.png)

    ![Second screenshot of how to create a new VMware vSphere virtual machine.](./media/vmware-template/ubuntu-template-new-vm-2.png)

    ![Third screenshot of how to create a new VMware vSphere virtual machine.](./media/vmware-template/ubuntu-template-new-vm-3.png)

    ![Fourth screenshot of how to create a new VMware vSphere virtual machine.](./media/vmware-template/ubuntu-template-new-vm-4.png)

    ![Fifth screenshot of how to create a new VMware vSphere virtual machine.](./media/vmware-template/ubuntu-template-new-vm-5.png)

    ![Sixth screenshot of how to create a new VMware vSphere virtual machine.](./media/vmware-template/ubuntu-template-new-vm-6.png)

- Make sure to select **Ubuntu Linux (64-bit)** as the guest OS.

    ![A screenshot of Ubuntu Linux (64-bit) guest OS.](./media/vmware-template/ubuntu-template-guest-os.png)

- Point to the Ubuntu server ISO file location.

    ![Seventh screenshot of how to create a new VMware vSphere virtual machine.](./media/vmware-template/ubuntu-template-new-vm-7.png)

    ![Eighth screenshot of how to create a new VMware vSphere virtual machine.](./media/vmware-template/ubuntu-template-new-vm-8.png)

- Power on the VM and start the Ubuntu installation. No specific instructions here but:

  - (Optional:) Consider using static IP
  - Install OpenSSH server

    ![First screenshot of an Ubuntu installation](./media/vmware-template/ubuntu-template-installation-1.png)

    ![Second screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-2.png)

    ![Third screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-3.png)

    ![Fourth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-4.png)

    ![Fifth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-5.png)

    ![Sixth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-6.png)

    ![Seventh screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-7.png)

    ![Eighth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-8.png)

    ![Ninth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-9.png)

    ![Tenth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-10.png)

    ![Eleventh screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-11.png)

    ![Twelfth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-12.png)

    ![Thirteenth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-13.png)

    ![Fourteenth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-14.png)

    ![Fifteenth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-15.png)

    ![Sixteenth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-16.png)

    ![Seventeenth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-17.png)

    ![Eighteenth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-18.png)

    ![Nineteenth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-19.png)

    ![Twentieth screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-20.png)

    ![Twenty-first screenshot of an Ubuntu installation.](./media/vmware-template/ubuntu-template-installation-21.png)

### Post-installation

Before converting the VM to a template, several actions are needed.

- Update your OS packages:

    ```console
    sudo apt-get update
    sudo apt-get upgrade -y
    ```

- Prevent cloudconfig from preserving the original hostname and reset the hostname:

    ```console
    sudo sed -i 's/preserve_hostname: false/preserve_hostname: true/g' /etc/cloud/cloud.cfg
    sudo truncate -s0 /etc/hostname
    sudo hostnamectl set-hostname localhost
    ```

- Remove the current network configuration:

    ```console
    sudo rm /etc/netplan/50-cloud-init.yaml
    ```

- Clean shell history and shutdown the VM:

    ```console
    cat /dev/null > ~/.bash_history && history -c
    sudo shutdown now
    ```

### Convert to template

Reduce the VM CPU count and memory resources to the minimum and convert the VM to template, switch the CD/DVD drive to client device as well disconnect it and convert the VM to template.

![A screenshot of how to reduce a virtual machine's CPU count and memory.](./media/vmware-template/ubuntu-template-reduce.png)

![A screenshot of how to convert a virtual machine to a template.](./media/vmware-template/ubuntu-template-convert.png)
