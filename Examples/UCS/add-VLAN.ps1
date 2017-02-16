#Load list
$List= Import-Csv "VLAN.csv"

foreach($itemUCS in $ucsList)
{ 
  $ucsRes="Adding VLANs to UCS system - "+$itemUCS.ucs.name
  echo-infoYES $ucsRes
  
  foreach($item in $List)
  { 
    $ucsLanCloud = Get-UcsLanCloud -Ucs $itemUCS.ucs
    $vlanRes = Add-UcsVlan -Id $item.vlan -Name $item.vlanname -LanCloud $ucsLanCloud -Ucs $itemUCS.ucs
    $echoRes="Added VLAN "+$vlanRes.name
    echo-task $echoRes
  }
}