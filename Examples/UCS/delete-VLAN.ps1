#Load list
$List= Import-Csv "VLAN.csv"

foreach($itemUCS in $ucsList)
{ 
  $ucsRes="Deleting VLAN from UCS system - "+$itemUCS.ucs.name
  echo-infoYES $ucsRes

  foreach($item in $List)
  { 
    $ucsLanCloud = Get-UcsLanCloud -Ucs $itemUCS.ucs
    $vlanObj = Get-UcsVlan -Id $item.vlan -Ucs $itemUCS.ucs -LanCloud $ucsLanCloud
    $vlanRes = Remove-UcsVlan -Vlan $vlanObj -Ucs $itemUCS.ucs -Force
    $echoRes="Removed VLAN "+$vlanRes.name
    echo-task $echoRes
  }
}