<#
Create ORGs
#>

$ORGTest = [regex]"^[A-Za-z0-9:.-_]*$"

#Load list
$List= Import-Csv “.\ORG.csv“

#Add ORGs
foreach($itemUCS in $ucsList)
{ 
  $ucsRes="Adding ORG to UCS system - "+$itemUCS.ucs.name
  echo-infoYES $ucsRes
  
  foreach($item in $List)
  { 
    #Get parent ORG to configure ORG at
    $CfgOrg = Get-UcsOrg -Name $item.ParentOrg -Ucs $itemUCS.ucs
    
    #create ORG
    if (($item.Name.Length -le 16) -and (($ORGTest.Match($item.Name).Success)))
    {  
      $ucsRes=Add-UcsOrg -Name $item.Name -Descr $item.Descr -Org $CfgOrg.Dn -Ucs $itemUCS.ucs
      $echoRes="Added ORG "+$ucsRes.name
      echo-task $echoRes
    }
  }
}