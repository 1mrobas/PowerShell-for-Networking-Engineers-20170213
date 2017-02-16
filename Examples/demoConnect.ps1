<#### 
# Set working directory
#####>

cd $workDir

<#####
# Connect to vCenter
#####>
echo-inprogress "Connecting to $vcInfra_name"
$global:vcInfra=Connect-VIServer -Server $vcInfra_name -User $vcUsr -Password $vcPwd -WarningAction SilentlyContinue

<#####
# Connect to UCS1 and UCS2
#####>
echo-inprogress "Connecting to $ucs_sddcUCS1vip"
$global:ucsUCS1= Connect-Ucs -Name $ucs_sddcUCS1vip -Credential $ucsCredentials -NotDefault
echo-inprogress "Connecting to $ucs_sddcUCS2vip"
$global:ucsUCS2= Connect-Ucs -Name $ucs_sddcUCS2vip -Credential $ucsCredentials -NotDefault

echo-success "Connected to vCenters and UCSes"
echo-out $vcInfra.Name
echo-out $ucsUCS1.Ucs
echo-out $ucsUCS2.ucs

# Set-UcsPowerToolConfiguration -SupportMultipleDefaultUcs $true


