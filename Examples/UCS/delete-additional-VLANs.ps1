#Load list
$listVLAN= Import-Csv "VLAN-add.csv"
$listNICtmpl=Import-Csv "VLAN-add2nictmpl.csv"


foreach($itemUCS in $ucsList)
{ 
  $ucsRes="Removing VLANs from NICs on "+$itemUCS.ucs.name
  echo-task $ucsRes
  
  foreach($itemNICtmpl in $listNICtmpl)
  { 
    $CfgOrg = Get-UcsOrg -Name $itemNICtmpl.Org -Ucs $itemUCS.ucs
    $cfgDN=$CfgOrg.dn+"/lan-conn-templ-"+$itemNICtmpl.Name
    $nictmpl = Get-UcsVnicTemplate -dn $cfgDN -Org $CfgOrg.Dn -Ucs $itemUCS.ucs
    $echoRes="  - Removing VLANs from "+$nictmpl.name
    echo-out $echoRes   

    foreach($itemVLAN in $listVLAN)
    { 
      $nicintf=Get-UcsVnicInterface -VnicTemplate $nictmpl -Name $itemVLAN.vlanname -Ucs $itemUCS.ucs
      $nictmplRes=Remove-UcsVnicInterface -VnicInterface $nicintf -Ucs $itemUCS.ucs -Force
      $echoRes="    - Removed VLAN "+$itemVLAN.vlanname
      echo-out $echoRes   
    }
  }  
  $ucsRes="DONE - VLANs removed from NICs on "+$itemUCS.ucs.name
  echo-task $ucsRes

  echo-out "    "
  echo-out "-------------------------------------------------------"
  echo-out "    "

  $ucsRes="Deleting VLANs from UCS system - "+$itemUCS.ucs.name
  echo-task $ucsRes
  
  foreach($item in $listVLAN)
  { 
    $ucsLanCloud = Get-UcsLanCloud -Ucs $itemUCS.ucs
    $vlanObj = Get-UcsVlan -Id $item.vlan -Ucs $itemUCS.ucs -LanCloud $ucsLanCloud
    $vlanRes = Remove-UcsVlan -Vlan $vlanObj -Ucs $itemUCS.ucs -Force
    $echoRes="    - Removed VLAN "+$vlanRes.name
    echo-out $echoRes    
  }
  echo-task "DONE - VLANs removed from LAN Cloud"
  echo-out "    "
  echo-out "======================================================="
  echo-out "    "
  
}