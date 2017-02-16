##### 
# Load input files
#  CSV-VLANlist
#####
Import-module .\demoVars.psm1
$listVLAN=Import-CSV $workDir"CSV-VLAN-list.csv"
$listSW=Import-CSV $workDir"CSV-LANSW-list.csv"

echo-inprogress "Deleting VLANs from switches"
foreach($tmpsw in $listSW)
{
  $tmpswname=$tmpsw.name
  echo-inprogress "Switch $tmpswname"
  foreach($tmpvlan in $listVLAN)
  { 
    $tmpvlanname=$tmpvlan.name
    $funcRes=LAN-delete-vlan -XMLurl $tmpsw.url -XMLcred $restCredentials -vlanid $tmpvlan.VLAN 
    switch  ($funcRes)
    {
      0 { echo-task ">> Deleted VLAN $tmpvlanname" }
      1 { echo-infoNO ">> Skipped VLAN $tmpvlanname - not present"}
      9 { echo-error ">> Error deleting VLAN $tmpvlanname"}
    }
  }
}
