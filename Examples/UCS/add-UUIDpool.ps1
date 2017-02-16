<#
Parameters
-Name
-Descr
-Org <OrgOrg>
-AssignmentOrder = default, sequential

Set individual values to non-default
#>

$UUIDTest = [regex]"^[A-Fa-f0-9-]*$"

#Load list
$List= Import-Csv “.\UUIDPool.csv“

#Add pools
foreach($itemUCS in $ucsList)
{ 
  $ucsRes="Adding UUID pool to UCS system - "+$itemUCS.ucs.name
  echo-infoYES $ucsRes
  
  foreach($item in $List)
  { 
    $CfgOrg = Get-UcsOrg -Name $item.Org -Ucs $itemUCS.ucs

    $poolRes = Add-UcsUuidSuffixPool -Org $CfgOrg.Dn -Name $item.Name -Descr $item.Descr -AssignmentOrder $item.Order -Prefix $item.Prefix -Ucs $itemUCS.ucs
    if (($item.From.Length -ne 0) -and (($UUIDTest.Match($item.From).Success)))
    {  
      $suffixRes=Add-UcsUuidSuffixBlock -UuidSuffixPool $poolRes -From $Item.From -To $Item.To
      $echoRes="Added UUID pool "+$poolRes.name
      echo-task $echoRes   
    }
  }
}