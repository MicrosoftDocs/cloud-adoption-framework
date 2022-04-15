---
title: Enterprise-scale network topology and connectivity for Azure VMware Solution
description: 
author: fguerri
ms.author: 
ms.date: 
ms.topic: 
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
---

# Implement Expressroute connectivity for AVS without Global Reach
This article walks through the implementation of network connectivity between an AVS private cloud and on-prem sites connected to Azure over Expressroute, when Global Reach cannot be used. More information about this topology is available [here](./eslz-network-topology-connectivity.md). Typical cases where Global Reach is not applicable include, but are not limited to, the following:

- Traffic between AVS private clouds and on-prem sites must be inspected by a firewall running in an Azure VNet (typically, in the hub VNet of a hub&spoke network). 
- The Expressroute circuit that connects the on-prem site(s) with Azure has been deployed in a peering location that does not support Global Reach. For more information on Global Reach availability, please refer to the official [Expressroute documentation](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-global-reach#availability).  

Azure Virtual WAN users should not implment the topology covered in this article and consider Virtal WAN's Routing Policy/Routing Intent features instead. For more details and feature availability see [the official Virtual WAN documentation](https://docs.microsoft.com/en-us/azure/virtual-wan/how-to-routing-policies). 

## Prerequisites
This step-by-step guidance assumes that the following resources have been already deployed and configured:

- An AVS private cloud.
- An Azure VNet hosting an Expressroute gateway and a firewalling solution (Azure Firewall or third-party NVA clusters). The VNet is typically the hub VNet of an hub&spoke network deployed in a single Azure region. However, a fully-fledged hub&spoke topology is not strictly required to successfully implement the solution described in this article. This VNet will be referred to as the "Firewall VNet".
- A fully provisioned Expressroute circuit, connected both to the on-prem site(s) and the Expressroute Gateway hosted in the Firewall Vnet.

It is not required for the resources listed above to be in the same Azure subscription, nor in subscriptions associated to the same AAD tenant.

By followoing the steps in this article, the following new resources will be deployed:

- An Azure Virtual Network, referred to as "Transit VNet", peered to the Firewall VNet.
- An Azure Route Server hosted in the Transit VNet. 
- An Expressroute Gateway hosted in the Transit VNet.
- A Connection between the Expressroute Gateway in the Transit VNet and the AVS-provided Expressroute circuit.
- One or more third-party, BGPv4-capable NVAs .
- A Custom Route Table, attached to one the NVAs subnets (more details provided below).
- An Azure Route Server hosted in the Firewall VNet.

Connectivity among the AVS private cloud, the Transit VNet, the Firewall VNet and the on-prem site(s) is entirely based on Expressroute and VNet peering, both of which  work cross-subscription and cross-tenant. Therefore, the resources listed above can be deployed in different/multiple subscriptions, if so mandated by security/billing/governance requirements. 

It is not strictly required for all the components listed above to be in same Azure region. However, the latency and cost implications of deploying across multiple regions must be factored in and carefully evaluated. Latency increases with the geographical distance covered by traffic exchanged between the AVS private cloud and the on-prem sites. Cost is affected by the VNet peering type (intra-region vs. global) and maybe affected by the SKU of the Expressroute circuit that connects the on-prem siteS. The Expressroute Premium SKU is needed if the circuit's peering location and the Firewall VNet sit in different Azure Geographies. See [this article](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-locations#locations) for more information. 

The following address prefixes must be allocated for the Transit VNet:
 - a /27 (or larger) prefix for the GatewaySubnet (the subnet that hosts the Expressroute Gateway).
 - a /27 (or larger) prefix for the RouteServerSubnet (the subnet that hosts Azure Route Server).
 - two /28 (or larger) prefixes for the two subnets to which the BGP-capable NVAs will be attached.
The Transit Vnet's address space can be defined as the union of four non-contiguos prefixes (two /27 prefixies and two /28 prefixes) to minimize address space utilization. It is of course possible to allocate a single /25 prefix for the Transit Vnet, in which case a /27 prefix remains unused.

A /27 (or larger) prefix must be allocated for the RouteServerSubnet in the Firewall VNet. It can be carved out of unused ranges in the VNet's address space, or it can be added as a non-contigous prefix. 

The table below summarizes the address allocation requirements. All prefixes *must not* overlap with any other prefixes used in the AVS private cloud, in the Firewall VNet (and its directly connected spokes, if any) and in the remote site(s) connected over Expressroute.

| Virtual Network | Subnet            | Netmask | Notes                                                                     | 
|-----------------|-------------------|---------|---------------------------------------------------------------------------|
| Transit VNet    | GatewaySubnet     | /27     | The subnet must be named "GatewaySubnet"                                  |
| Transit VNet    | RouteServerSubnet | /27     | The subnet must be named "RouteServerSubnet"                              |
| Transit VNet    | AvsFacingSubnet   | /28     | The subnet name can be customized to fit any applicable naming convention |
| Transit VNet    | FwFacingSubnet    | /28     | The subnet name can be customized to fit any applicable naming convention |
| Firewall VNet   | RouteServerSubnet | /27     | The subnet must be named "RouteServerSubnet"                              |

## Logging into Azure subscriptions
As mentioned in the previous section, it is possible to deploy the required resources across multiple subscriptions and/or multiple regions. As the allocation of resources to subscriptions may vary greatly across real-world environments, this article does not provide prescriptive guidance as to where to deploy each resource. It is the reader's responsibility to properly set the Azure context for executing the code snippets provided below. Please review the official documentation for instructions on how to log into Azure and select a subscription to work in (with[Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/authenticate-azureps?view=azps-7.4.0) or [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/manage-azure-subscriptions-azure-cli)).   

## Step #1 - Provision the Transit VNet
In this step, you will deploy the Transit VNet. If needed, set the context to the subscription where the Transit VNet (and realted resources) must be deployed. After setting the variables to values that fit your environament, run the code snippet below.

```Azure CLI
# Define variables
transitRgName="TRANRG"
transitVnetName="transit-vnet"
transitVnetPrefixes="10.156.0.0/25"
transitLocation="westeurope"
transitGwSubnetPrefix="10.156.0.0/27"
transitArsSubnetPrefix="10.156.0.32/27"
transitAvsFacingSubnetPrefix="10.156.0.64/28"
transitFwFacingSubnetPrefix="10.156.0.80/28"

# Deploy Transit VNet and required subnets
az group create --name $transitRgName --location $transitLocation
az network vnet create \
        --name $transitVnetName \
        --address-prefixes $transitVnetPrefixes \
        --resource-group $transitRgName \
        --location $transitLocation
az network vnet subnet create \
        --name GatewaySubnet \
        --address-prefixes $transitGwSubnetPrefix \
        --resource-group $transitRgName \
        --vnet-name $transitVnetName     
az network vnet subnet create \
         --name AvsFacingSubnet \
        --address-prefixes $transitAvsFacingSubnetPrefix \
        --resource-group $transitRgName \
        --vnet-name $transitVnetName
az network vnet subnet create \
        --name FwFacingSubnet  \
        --address-prefixes $transitFwFacingSubnetPrefix \
        --resource-group $transitRgName \
        --vnet-name $transitVnetName
az network vnet subnet create \
        --name RouteServerSubnet \
        --address-prefixes $transitArsSubnetPrefix \
        --resource-group $transitRgName \
        --vnet-name $transitVnetName
```

When the Transit VNet is fully provisioned, peer it with the Firewall VNet. The peering relationship must be defined with the following settings:

- "Traffic to remote virtual network": Select "Allow (default)".
- "Traffic forwarded from remote virtual network": Select "Allow (default)".
- "Virtual network gateway or Route Server": Select "None (default)".

Different procedures exist to configure peering relationships between two VNets, depending whether they belong to the same subscription or two different subscriptions (and, potentially, AAD tenants). Please review [this article](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview#next-steps) for detailed instructions on how to peer the Firewall VNet and the Transit VNet in your environemnt. 

## Step #2 - Provision the Expressroute Gateway in the Transit VNet
In this step, you will provision an Expressroute Gateway in the Transit VNet and connect it to the AVS managed circuit. Review [this arcticle](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-about-virtual-network-gateways#gwsku) to select the most Expressroute Gateway SKU based on the estimated AVS traffic throughput. In order to find the identifier of the managed Expressroute circuit associated to your AVS private cloud and generate an authorization key open the Azure portal, browse to the AVS private cloud and follow the instructions available [here](https://docs.microsoft.com/en-us/azure/azure-vmware/tutorial-configure-networking#connect-expressroute-to-the-virtual-network-gateway). Use the circuit identifier and the authorization key to set the variables in the code snippet below. 

Note: If you closed the shell used in Step #2, you must set the variables defined in Step #2's code snippet again.

Note: Expressroute Gateways may take up to 40 minutes to deploy.

```Azure CLI
# Define variables
ergwSku="Choose the appropriate SKU, e.g. HighPerformance"
avsManagedErCircuitId="AVS managed Expressroute circuit ID"
avsManagederCircuitAuthKey="AVS managed Expressroute authorization key"

# Deploy Expressroute Gateway
az network public-ip create \
        --name transit-ergw-pip \
        --resource-group $transitRgName \
        --sku Standard \
        --version IPv4 \
        --zone 1 2 3 \
        --location $transitLocation
az network vnet-gateway create \
        --name transit-ergw \
        --vnet $transitVnetName \
        --resource-group $transitRgName \
        --gateway-type Expressroute \
        --sku $ergwSku \
        --public-ip-addresses transit-ergw-pip

# Connect Expressroute Gateway to AVS managed Expressroute circuit
trErgwId=$(az network vnet-gateway show --name transit-ergw --resource-group $transitRgName --query id --output tsv)
az network vpn-connection create \
        --name transit-to-avs \
        --resource-group $transitRgName \
        --vnet-gateway1 $trErgwId \
        --express-route-circuit2 $avsManagedErCircuitId \
        --authorization-key $avsManagederCircuitAuthKey
```
  
## Step #3 - Provision the BGP-capable NVAs
In this step you will provision the BGP-capable NVAs in the Transit VNet. At least two NVAs are recommended for high-availability. In order to make the code snippets aplicable to any Azure region, the two NVA instances are deployed in an availability set. It is possible to customize the code to deploy the instances in different availability zones, when working in regions that support them. High-throughput scenarios might require more than two NVAs. The approach presented in this article is horizontally-scalable up to the [maximum number of BGP peers supported by Azure Route Server](https://docs.microsoft.com/en-us/azure/route-server/route-server-faq#route-server-limits). 
Each NVA must have at least two NICs for traffic forwarding, attached to the FwFacingSubnet and the avsFacingSubnet. Additional interfaces, for example for management purposes, may be added, but are not required. 
In the code snippet below, define the static private IP addresses you want to assign to each interface. For each NVA instance, select an available IP addresses in the FwfacingSubnet and an availble IP address in the AvsFacingSubnet (created in Step #2). Please note that in Azure the first four IPs and the last IP in the subnet address prefix are reserved and cannot be assigne dto VMs. Also, set the credentials and the VM size. Before running the code snippet, make sure the context is set to the subscription where you have deployed the Transit VNet.

Note: If you closed the shell used to perform the previous steps (2-5), make sure you set the variables defined in Step #2 again.

```Azure CLI
# Define static IP addresses for the NVA NICs
nva0FwFacingIp='10.156.0.84'
nva0AvsFacingIp='10.156.0.68'
nva1FwFacingIp='10.156.0.85'
nva1AvsFacingIp='10.156.0.69'

# Define username and password for the NVAs
nvaUser='federico'
nvaPassword='Chang3M3NOW!!'

# Define VM size for the NVAs
nvaSize='Standard_D1_v2'
nvaImage='OpenLogic:CentOS:8_5:8.5.2022012100'

# Deploy NICs
az network nic create --name nva0-fwfacing-nic \
        --resource-group $transitRgName \
        --location $transitLocation \
        --vnet $transitVnetName \
        --subnet FwFacingSubnet \
        --ip-forwarding true \
        --private-ip-address $nva0FwFacingIp

az network nic create --name nva0-avsfacing-nic \
        --resource-group $transitRgName \
        --location $transitLocation \
        --vnet $transitVnetName \
        --subnet AvsFacingSubnet \
        --ip-forwarding true \
        --private-ip-address $nva0AvsFacingIp      

az network nic create --name nva1-fwfacing-nic \
        --resource-group $transitRgName \
        --location $transitLocation \
        --vnet $transitVnetName \
        --subnet FwFacingSubnet \
        --ip-forwarding true \
        --private-ip-address $nva1FwFacingIp

az network nic create --name nva1-avsfacing-nic \
        --resource-group $transitRgName \
        --location $transitLocation \
        --vnet $transitVnetName \
        --subnet AvsFacingSubnet \
        --ip-forwarding true \
        --private-ip-address $nva1AvsFacingIp    

# Deploy NVAs in an availability set
az vm availability-set create --name bgp-nva-aset --resource-group $transitRgName --location $transitLocation
az vm create --name bgp-nva-0 \
        --resource-group $transitRgName \
        --location $transitLocation \
        --image $nvaImage \
        --size $nvaSize \
        --availability-set bgp-nva-aset \
        --authentication-type password \
        --admin-username $nvaUser \
        --admin-password $nvaPassword \
        --storage-sku Standard_LRS \
        --nics nva0-fwfacing-nic nva0-avsfacing-nic

az vm create --name bgp-nva-1 \
        --resource-group $transitRgName \
        --location $transitLocation \
        --image $nvaImage \
        --size $nvaSize \
        --availability-set bgp-nva-aset \
        --authentication-type password \
        --admin-username $nvaUser \
        --admin-password $nvaPassword \
        --storage-sku Standard_LRS \
        --nics nva1-fwfacing-nic nva1-avsfacing-nic
```
## Step #4 - Provision the Azure Route Server in the Transit VNet
In this step you will provision an Azure Route Server instance in the Transit VNet. Before starting this step, make sure that the Expressroute Gateway in the Transit VNet has been successfully provisioned (Step #3). If needed, set the Azure context in such a way to operate in the subscrption that contains the Transit VNet and run the code snippet below.

Note: If you closed the shell used for steps 1-3, you must set the variables defined in Step #1 and Step #2 again.

```Azure CLI
# BGP-capable NVA's ASN
nvaAsn=65555

# Retrive Id of the RouteServerSubnet
trArsSubnetId=$(az network vnet subnet show \
        --name RouteServerSubnet \
        --vnet-name $transitVnetName \
        --resource-group $transitRgName \
        --query id --output tsv)

# Deploy Azure Route Server
az network public-ip create --name transit-ars-pip --resource-group $transitRgName --version IPv4 --sku Standard --zone 1 2 3 --location $transitLocation
az network routeserver create \
        --hosted-subnet $trArsSubnetId \
        --name transit-ars \
        --resource-group $transitRgName \
        --location $transitLocation \
        --public-ip-address transit-ars-pip
az network routeserver update --name transit-ars --resource-group $transitRgName --allow-b2b-traffic

# Define peerings with the BGP-capable NVAs
az network routeserver peering create --name nva0 \
        --routeserver transit-ars \
        --resource-group $transitRgName \
        --peer-ip $nva0AvsFacingIp \
        --peer-asn $nvaAsn
az network routeserver peering create --name nva1 \
        --routeserver transit-ars \
        --resource-group $transitRgName \
        --peer-ip $nva1AvsFacingIp \
        --peer-asn $nvaAsn
```

## Step #5 - Deploy Azure Route Server in the Firewall VNet
In this step, you will deploy an Azure Route Server instance the Firewall Vnet. The instructions below assume that a /27 (or larger) subnet can be added to the Firewall subnet, as described in the prerequsites setcion. 

Warning: Deploying a Route Server instance in a VNet that already contains an Expressroute Gateway will temporarily disrupt Expressroute connectivity. If you are working on a production environment, you need to perform this step during a scheduled maintenance window. More information is available [here](https://docs.microsoft.com/en-us/azure/route-server/troubleshoot-route-server#why-do-i-lose-connectivity-to-my-on-premises-network-over-expressroute-andor-azure-vpn-when-im-deploying-azure-route-server-to-a-virtual-network-that-already-has-expressroute-gateway-andor-azure-vpn-gateway).  

If needed, set the Azure context in such a way to operate in the subscrption that contains the Firewall VNet. If you closed the shell used in the prvious steps, please make sure you define the following variables again.

```Azure CLI
# Define static IP addresses for the NVA NICs. They must be the same as the one defined in Step #3
nva0FwFacingIp='10.156.0.84'
nva1FwFacingIp='10.156.0.85'

# BGP-capable NVA's ASN. It must be the same ASN defined in Step #4
nvaAsn=65555
```

Run the code snippet below to create the RouteServerSubnet and deploy an Azure Route Server instance in the Firewall subnet. 
Note: Azure Route Server takes about 20 minutes to deploy.

```Azure CLI
# Define variables
fwVnetName="hubvnet"
fwRgName="HUBRG"
fwArsSubnetPrefix="10.155.254.0/27"

# Create RouteServerSubnet
fwArsSubnetId=$(az network vnet subnet create \
        --name RouteServerSubnet \
        --address-prefixes $fwArsSubnetPrefix \
        --resource-group $fwRgName \
        --vnet-name $fwVnetName \
        --query id --output tsv)

# Deploy Route Server
fwLocation=$(az network vnet show --name $fwVnetName --resource-group $fwRgName --query location --output tsv)
az network public-ip create --name fw-ars-pip --resource-group $fwRgName --version IPv4 --sku Standard --zone 1 2 3 --location $fwLocation
az network routeserver create \
        --hosted-subnet $fwArsSubnetId \
        --name fw-ars \
        --resource-group $fwRgName \
        --location $fwLocation \
        --public-ip-address fw-ars-pip
az network routeserver update --name fw-ars-pip --resource-group $fwRgName --allow-b2b-traffic

# Define peerings with the BGP-capable NVAs
az network routeserver peering create --name nva0 \
        --routeserver fw-ars \
        --resource-group $fwRgName \
        --peer-ip $nva0FwFacingIp \
        --peer-asn $nvaAsn
az network routeserver peering create --name nva1 \
        --routeserver fw-ars \
        --resource-group $fwRgName \
        --peer-ip $nva1FwFacingIp \
        --peer-asn $nvaAsn
```
## Step #6 - Add AVS routes to the Firewall VNet's GatewaySubnet
In this step, you will configure the custom route table associated to the Firewall VNet's GatewaySubnet. This is needed to route traffic originating from the on-prem site(s) and destined to the AVS private cloud via the firewalling solution hosted in the Firewall Vnet. The custom route table must contain routes for the AVS private cloud /22 network block and for each IP subnet associated to NSX-T segments. The next hop must be the firewalling solution's IP (for Azure Firewall, this is the instance's private IP; For firewall clusters based on third-party NVAs, it is typically the frontend IP of the cluster's Azure Internal Load Balancer). These routes are meant to override the ones automatically injected in the Firewall VNet's route table by Route Server, in such a way to steer traffic destined to AVS to the firewall, instead of directly to the BGP-capable NVAs.

If, in your enviroment, the Firewall VNet's GatewaySubnet does not have an associated custom route table, create one by running the code snippet below. If a custom route table aleady exists for the GatewaySubnet, skip this action.

```Azure CLI
az network route-table create --name gwsubnet-rt --resource-group $fwRgName --disable-bgp-route-propagation false
az network vnet subnet update --name GatewaySubnet --resource-group $fwRgName --vnet-name $fwVnetName --route-table gwsubnet-rt  
```

To retrive the IP prefixes used in your AVS Private Cloud, set the context to the subscription that contain it and execute the follwoing snippet.

```Azure CLI
az vmware workload-network segment list \
        --private-cloud $avsPrivateCloudName \
        --resource-group avsPrivateCloudRg \
        --query [].subnet.gatewayAddress --output tsv

az vmware private-cloud show --name avs-cloud-hp --resource-group rg-cloud-hepereir --query networkBlock --output tsv
```
Add a custom route for each prefix returned by the script above. WORK IN PROGRESS - ADD CLI COMMANDS TO AUTOMATE

## Step #7 - Configure routing on the BGP-capable NVAs
In this step you finalize the routing configuration of your BGP-capable NVAs. Configuration details may vary depending on which NVAs are used. This section provides general guidelines for establishing BGP sessions with the Route Servers in the Firewall and in the Transit VNets. Specific instructions are provided for configuring BGP session on CentOS VMs running [FRRouting](https://frrouting.org/).

### General routing requirements
- Azure Route Servers always use the reserved ASN 65515. The BGP capable NVAs must use a different ASN (not included in the Azure-reserved range 65515-65520). As such, all sessions between NVAs and Route servers are external BGP (eBGP) sessions.
- Azure Route Servers are attached to dedicated subnets in their respective VNets. As such, BGP sessions with the BGP capable NVAs are established between interfaces that do not share a common subnet. Therefore, eBGP multihop must be supported and enabled on the NVAs.
- Static routes must be defined in the NVAs' guest OS route tables to ensure reachability of the Route Servers (which are non-directly-connected external BGP peers). It is recommended to define static routes for the entire prefix of the RouteServerSubnets.
- As Route Servers in both the Firewall and the Transit VNet use ASN 65515, propagating routes between AVS and the on-prem sites requires removing ASN 65515 from the AS Path - to prevent the BGP loop detection mechanisms to drop routes. Route maps can be used for this purpose on most commercially avaialable BGP routing solutions. 
-  As ASN 65515 is removed, a different mechanism than the default BGP loop detection must be used to avoid reflecting routes learned by each Route Server instance to the same instance. BGP communities or AS Path manupulation can be used. See next section for an example.
- Route aggregation for the AVS /22 network block. As described in Step #6, routes for all prefixes used in the AVS private cloud must be manually added to the Firewall VNet's GatewaySubnet (see Step #6). To reduce overhead, the BGP-capable applainces should summarize all the routes for AVS management networks and advertsie the entire /22 prefix instead of the smaller ones actually announdced by AVS.  

### FFRouting Configuration
The general routing requirements described in the previous section can be addressed with the following BGP configuration. More specifically:
- All sessions are defined with multihop support enabled.
- Ingress route maps are used to (1) remove ASN 65515 from the AS Path and (2) manipulate the AS Path in such a way to track where each route originates from (AVS private cloud or Azure native/on-prem sites). In the example below, two route maps (FROMAVS, FROMHUB) are used to prepend ASN 65444 to all routes learned from Azure/on-prem sites and ASN 65333 to all routes orginated by AVS.
- Egress route maps are used to prevent reflecting routes back to the speakers from which they were received. In the example below, two route maps (BLOCKAVSROUTE and BLOCKHUBROUTE) are used to prevent routes with ASN 65444 in their AS Path (i.e. routes learned from Azure native/on-prem sites) to be re-advertsied to the Route Server instance in the Firewall VNet; and to prevent routes with ASN 65333 in their AS Path (i.e. routes learned from AVS) to be re-advertsied to the Route Server instance in the Transit VNet.
- Routes for prefixes included in the AVS Private Cloud's network block are suppressed. A single route for the entire /22 prfix is announecd instead.

```
router bgp 65555 //ASN announced by transit appliances
neighbor 10.10.10.36 remote-as 65515  //transit vnet route server #0
neighbor 10.10.10.36 ebgp-multihop 2
neighbor 10.10.10.37 remote-as 65515 //transit vnet route server #1
neighbor 10.10.10.37 ebgp-multihop 2
neighbor 10.57.0.36 remote-as 65515 //hub vnet route server #0
neighbor 10.57.0.36 ebgp-multihop 2
neighbor 10.57.0.37 remote-as 65515 // hub vnet route server #1
neighbor 10.57.0.37 ebgp-multihop 2
!
address-family ipv4 unicast
  aggregate-address 172.16.0.0/22 as-set summary-only  // AVS private cloud /22 block
  neighbor 10.10.10.36 route-map FROMAVS in
  neighbor 10.10.10.36 route-map BLOCKAVSROUTE out
  neighbor 10.10.10.37 route-map FROMAVS in
  neighbor 10.10.10.37 route-map BLOCKAVSROUTE out
  neighbor 10.57.0.36 route-map FROMHUB in
  neighbor 10.57.0.36 route-map BLOCKHUBROUTE out
  neighbor 10.57.0.37 route-map FROMHUB in
  neighbor 10.57.0.37 route-map BLOCKHUBROUTE out
exit-address-family
!
bgp as-path access-list AVSROUTE permit 65333_
bgp as-path access-list CONTAINS65515 permit _65515_
bgp as-path access-list CONTAINS65515 permit 65515_
bgp as-path access-list HUBROUTE permit 65444_
!
route-map FROMHUB permit 10  // remove 65515 and prepend 65444 to all routes from hub/on-prem
match as-path CONTAINS65515
set as-path exclude 65515
set as-path prepend 65444
!
route-map FROMAVS permit 10 // remove 65515 and prepend 65333 to all routes from AVS
match as-path CONTAINS65515
set as-path exclude 65515
set as-path prepend 65333
!
route-map BLOCKHUBROUTE deny 10 // Do not propagate routes from hub
match as-path HUBROUTE
!
route-map BLOCKHUBROUTE permit 20
!
route-map BLOCKAVSROUTE deny 10  // Do not propagate routes from AVS
match as-path AVSROUTE
!
route-map BLOCKAVSROUTE permit 20
!
```