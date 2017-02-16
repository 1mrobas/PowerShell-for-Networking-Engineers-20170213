#Load list
$listVLAN= Import-Csv "VLAN-add.csv"
$listNICtmpl=Import-Csv "VLAN-add2nictmpl.csv"


foreach($itemUCS in $ucsList)
{ 
  $ucsRes="Adding VLANs to UCS system - "+$itemUCS.ucs.name
  echo-task $ucsRes
  
  foreach($item in $listVLAN)
  { 
    $ucsLanCloud = Get-UcsLanCloud -Ucs $itemUCS.ucs
    $vlanRes = Add-UcsVlan -Id $item.vlan -Name $item.vlanname -LanCloud $ucsLanCloud -Ucs $itemUCS.ucs
    $echoRes="  + Added VLAN "+$vlanRes.name
    echo-out $echoRes
  }
  echo-task "DONE - VLANs added to LAN Cloud"

  echo-out "    "
  echo-out "-------------------------------------------------------"
  echo-out "    "
    
  $ucsRes="Adding VLANs to NICs on "+$itemUCS.ucs.name
  echo-task $ucsRes
  
  foreach($itemNICtmpl in $listNICtmpl)
  { 
    $CfgOrg = Get-UcsOrg -Name $itemNICtmpl.Org -Ucs $itemUCS.ucs
    $cfgDN=$CfgOrg.dn+"/lan-conn-templ-"+$itemNICtmpl.Name
    $nictmpl = Get-UcsVnicTemplate -dn $cfgDN -Org $CfgOrg.Dn -Ucs $itemUCS.ucs

    $echoRes="  + Adding VLANs to "+$nictmpl.name
    echo-out $echoRes   

    foreach($itemVLAN in $listVLAN)
    { 
      $nictmplRes=Add-UcsVnicInterface -Name $itemVLAN.vlanname -VnicTemplate $nictmpl -DefaultNet $itemVLAN.native
      $echoRes="    + Added VLAN "+$itemVLAN.vlanname
      echo-out $echoRes   
    }
  }  
  $ucsRes="DONE - VLANs added to NICs on "+$itemUCS.ucs.name
  echo-task $ucsRes
  echo-out "    "
  echo-out "======================================================="
  echo-out "    "

}