
## **_Virtual Network GateWay Creating & Connecting through private IP_** 

This document explains how to setup Virtual Network Gateway in Azure.

-	Create a virtual network gate in Azure Portal way by the following steps:

	-	Search for Virtual network gate way and click on that.
	-	Click on create and it will open a window.
	-	Fill all the details like Name, Region, Gateway type, sku, vnet and keep the rest to default values.
        -   Select the vnet which is associated with VM's created under the same resource group.
	-	Click on create then it will start deploying.
	
		![image](images/vpngateway.png)
		
-	Create Virtual Network gateway by Azure CLI command
	```bash
	az network vnet-gateway create -g MyResourceGroup -n MyVnetGateway --public-ip-address MyGatewayIp --vnet MyVnet --gateway-type Vpn --sku VpnGw1 --vpn-type RouteBased --no-wait
	```
- **Generate Certificates:**
-   Now open Windows PowerShell ISE and generate the root and child certificates.
    -   Command to generate root certificate
        ```bash
            $cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
            -Subject "CN=P2SRootCert" -KeyExportPolicy Exportable `
            -HashAlgorithm sha256 -KeyLength 2048 `
            -CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign
        ```
    -   Command to generate child certificate
        ```bash
            New-SelfSignedCertificate -Type Custom -DnsName P2SChildCert -KeySpec Signature `
            -Subject "CN=P2SChildCert" -KeyExportPolicy Exportable `
            -HashAlgorithm sha256 -KeyLength 2048 `
            -CertStoreLocation "Cert:\CurrentUser\My" `
            -Signer $cert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")
        ```
-   **Export Certificates:**
-   Open Microsoft Management Console (mmc) to export the certificates.
    - Go to Run and type “mmc” it will open certificates
    - Under personal folder select certificates folder and it will open a page.
    - Refresh the page and find Root and child certificates
-   Export certificates
    -   Exporting root certificate:
        -   Select the root certificate, right click on the certificate then go to the All Tasks.
        -   Click on export, will open a window and Click on Next.
        -   Select “No, do not export private key” and Click Next.
        -   Select “Base-64 encoded X.509(.cer) and Click Next.
        -   Select the browse and select the path, give a name and click on Next.
        -   By this you will get a message “Exported successfully”.
    -   Exporting child certificate:
        -   Select the client certificate,right click on the certificate then go to the All Tasks.
        -   Click on export, will open a window and click on Next.
        -   Select “Yes, export private key” and Click on next.
        -   Select the personal Information Exchange (PKCS) and click on Next.
        -   Select the password checkbox and provide the password.
        -   Select the encryption to TripleDES-SHA1 and click on Next.
        -   Select the browse and select the path and give a name and click on Next.
        -   By this you will get a message “Exported successfully”.
    -   With the above to steps certificates are installed successfully to your local systems
    -   Open the root certificate file in your favorite editor and copy the code.

-   **Configure Virtual Network Gateway:**
    -	Go to the resource group where the Virtual Network Gateway is created.
    -   Go to Point-to-Site-configuration on the left panel.
    -   Click on Configure now in the center panel.
    -   Add the address pool (ex: 192.168.xx.0/24)
    -   Select the tunnel type to IKEv2
    -   Authentication type to Azure certification
    -   Paste the copied root certificate code in the portal and give name as root & click on Save.

-   **Download and Connect to VPN Client:**

    -   Download the VPN Client after saving the configuration from portal.
    -   Open the downloaded VPN Client zip file and open “WindowsAMD64” folder and install the“VPNClinetsetupAMD64” file.
    -   Go to “Control Panel\Network and Internet\Network Connections” there you will see your installed VPN.
    -   Select the VPN, right click on it and click on connect.
    -   It will open a window and click on connect button to get connected.
    -   By the above steps VPN Gateway connection is established.

-   **Login to VM:**
    -   Login to VM with private IP through ssh key
    -   Now run the following command to set the password authentication
        ```bash
        sudo vi /etc/ssh/sshd_config
        ```
    -   update the following parameters
        -   Change the password authentication type from no to “yes”.
        -   Now find the commented UserLogin and remove the # comment and modify to “yes”.
        -   Now save the file by “press ESC key and type “:wq!” it will save the modifications.
    -   Restart the sshd 
        ```bash
        sudo systemctl restart sshd
        ```
    -   Set the password by the following command
        ```bash
        sudo passwd <username>
        # Example: sudo passwd azureadmin
        ```
        -   Note: Password must be 14 characters long.
    -   With the above steps password authentication is completed.

-   **Login to VM instance from Controller VM:**
    -   Login to your client VM
    -   Connect to private VM by run the following commands.
        ```bash
        sudo ssh <username>@<private_IP>
        # Example: sudo ssh azureadmin@102.xx.xx.xx
        ```
    -   It will prompt to enter the password.
    -   Login into VM with private IP is successful.
