<#####
# vCenters & credentials
#####>
$global:vcInfra_name="infravc.sddc.local"
$global:vcUsr="administrator@vsphere.local"
$global:vcPwd="test123"

<#####
# UCSes and credentials
#####>
$global:ucs_sddcUCS1vip="sddcUCS1.sddc.local"
$global:ucs_sddcUCS2vip="sddcUCS2.sddc.local"
$ucsUsr="admin"
$ucsPwd=ConvertTo-SecureString -String "test123" -AsPlainText -Force
$global:ucsCredentials = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $ucsUsr, $ucsPwd

<#####
# Routers, switches
#####>
$global:devUsr="admin"
$global:devPwd="test123"


<#####
# REST API credentials
#####>
$restUsr="admin"
$restPwd=ConvertTo-SecureString -String "test123" -AsPlainText -Force
$global:restCredentials = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $restUsr, $restPwd

$global:urlSW1="http://demoN5K01.flashstack.local:8088/ins"
$global:nameSW1="demoN5K01.flashstack.local"
$global:shortnameSW1="demoN5K01"

