##### 
# Load input files
#  CSV-VLANlist
#####
Import-module .\demoVars.psm1
$listVLAN=Import-CSV $workDir"CSV-VLAN-list.csv"
$listSW=Import-CSV $workDir"CSV-LANSW-list.csv"

echo-inprogress "Adding VLANs to switches"
foreach($tmpsw in $listSW)
{
  $tmpswname=$tmpsw.name
  echo-inprogress "Switch $tmpswname"
  foreach($tmpvlan in $listVLAN)
  { 
    $tmpvlanname=$tmpvlan.name
    $funcRes=LAN-add-vlan -XMLurl $tmpsw.url -XMLcred $restCredentials -vlanname $tmpvlan.Name -vlanid $tmpvlan.VLAN 
    switch  ($funcRes)
    {
      0 { echo-task ">> Added VLAN $tmpvlanname" }
      1 { echo-infoNO ">> Skipped VLAN $tmpvlanname - already present"}
      9 { echo-error ">> Error adding VLAN $tmpvlanname"}
    }
  }
}
