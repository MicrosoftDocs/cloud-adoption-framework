---
title: How to create a virtual network gateWay and connect through a private IP
description: Learn how to create a virtual network gateWay and connect through a private IP.
author: TBD
ms.author: TBD
ms.date: 11/06/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenarios
---

# How to create a virtual network gateWay and connect through a private IP

This document explains how to setup a virtual network gateway in Azure.

## Getting started

Create a virtual network gate in Azure Portal with the following steps:

- Search for virtual network gateway and click on that.
- Click on create and it will open a window.
- Fill all the details like Name, Region, Gateway type, sku, vnet and keep the rest to default values.
- Select the vnet which is associated with VM's created under the same resource group.
-Click on create then it will start deploying.

![TBD](images/vpngateway.png)
		
- Create a virtual network gateway with this Azure CLI command:
-
	```bash
	az network vnet-gateway create -g MyResourceGroup -n MyVnetGateway --public-ip-address MyGatewayIp --vnet MyVnet --gateway-type Vpn --sku VpnGw1 --vpn-type RouteBased --no-wait
	```

## Generate certificates

- Now open Windows PowerShell ISE and generate the root and child certificates.
- Command to generate root certificate
    ```bash
    $cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
    -Subject "CN=P2SRootCert" -KeyExportPolicy Exportable `
    -HashAlgorithm sha256 -KeyLength 2048 `
    -CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign
    ```
- The command to generate the child certificate:
     ```bash
    New-SelfSignedCertificate -Type Custom -DnsName P2SChildCert -KeySpec Signature `
    -Subject "CN=P2SChildCert" -KeyExportPolicy Exportable `
    -HashAlgorithm sha256 -KeyLength 2048 `
    -CertStoreLocation "Cert:\CurrentUser\My" `
    -Signer $cert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")
    ```

## Export certificates

- Open Microsoft Management Console (mmc) to export the certificates.
- Go to Run and type “mmc” to open certificates
- Under personal folder select certificates folder and it will open a page.
- Refresh the page and find Root and child certificates

Exporting certificate types:

- Exporting root certificates:

  - Select the root certificate, right click on the certificate then go to the All Tasks.
  - Click on export, will open a window and Click on Next.
  - Select “No, do not export private key” and Click Next.
  - Select “Base-64 encoded X.509(.cer) and Click Next.
  - Select the browse and select the path, give a name and click on Next.
  - By this you will get a message “Exported successfully”.
    
- Exporting child certificates:

  - Select the client certificate,right click on the certificate then go to the All Tasks.
  - Click on export, will open a window and click on Next.
  - Select “Yes, export private key” and Click on next.
  - Select the personal Information Exchange, PKCS, and click on Next.
  - Select the password checkbox and provide the password.
  - Select the encryption to TripleDES-SHA1 and click on Next.
  - Select the browse and select the path and give a name and click on Next.
  - By this you will get a message “Exported successfully”.
  - With the above to steps certificates are installed successfully to your local systems
  - Open the root certificate file in your favorite editor and copy the code.

## Configure the virtual network gateway

- Go to the resource group where the virtual network gateway is created.
- Go to Point-to-Site-configuration on the left panel.
- Click on Configure now in the center panel.
- Add the address pool (ex: 192.168.xx.0/24)
- Select the tunnel type to IKEv2
- Authentication type to Azure certification
- Paste the copied root certificate code in the portal and give name as root & click on Save.

## Download and Connect to VPN Client

- Download the VPN Client after saving the configuration from portal.
- Open the downloaded VPN Client zip file and open “WindowsAMD64” folder and install the “VPNClinetsetupAMD64” file.
- Go to **Control Panel\Network and Internet\Network Connections** to see your installed VPN.
- Right-click the VPN, and select **Connect**.
- A new window will appear. Select the **Connect** button to get connected.

The VPN Gateway connection is established.

## Log in to the VM

- Log in to VM with private IP through the SSH key.

- Run this command to set the password authentication:

  ```bash
  sudo vi /etc/ssh/sshd_config
  ```

- Update these parameters: Change the password authentication type from **no** to **yes**, find the commented UserLogin, remove the **#** comment, and change to **yes**.
  
- Press the ESC key and type “:wq!” to save the changes.

- Restart the SSHD:

  ```bash
  sudo systemctl restart sshd
  ```

- Set the password with this command:

  ```bash
  sudo passwd <username>

  For example: sudo passwd azureadmin

![Note:] The password must be 14 characters long. 

Password authentication has been completed.

## Log in to VM instance from a controller VM

- Log in to your client VM.

- Run these commands to connect to private VM:

  ```bash
  sudo ssh <username>@<private_IP>

  For example, sudo ssh azureadmin@102.xx.xx.xx
      
  
- It will prompt to enter the password. 

## Next steps
