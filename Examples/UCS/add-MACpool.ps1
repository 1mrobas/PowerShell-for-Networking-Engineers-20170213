<#
Parameters
-Name
-Descr
-Org <OrgOrg>
-AssignmentOrder = default, sequential

Set individual values to non-default
#>


#Load list
$List= Import-Csv “.\MACpool.csv“


#Add pools
foreach($itemUCS in $ucsList)
{ 
  $ucsRes="Adding MAC pool to UCS system - "+$itemUCS.ucs.name
  echo-infoYES $ucsRes
  
  foreach($item in $List)
  { 
    $CfgOrg = Get-UcsOrg -Name $item.Org -Ucs $itemUCS.ucs

    $poolRes = Add-UCSMacPool -Name $item.Name -Descr $item.Comment -Org $CfgOrg.Dn -AssignmentOrder $item.Order -Ucs $itemUCS.ucs

    $toMAC=UCS-create-MAC -segment $item.ss -fabric $item.f -type $item.t -host $item.Size
    $fromMAC=UCS-create-MAC -segment $item.ss -fabric $item.f -type $item.t -host "01"

    if (($item.Size  -ne "") -and (($regexMAC.Match($fromMAC).Success)) -and (($regexMAC.Match($fromTo).Success)))
    {  
      $macRes=Add-UcsMACMemberBlock -MacPool $poolRes -From $fromMAC -To $toMAC
    }
    $echoRes="Added MAC pool "+$poolRes.name+" to ORG "+$item.Org
    echo-task $echoRes   
  }
}