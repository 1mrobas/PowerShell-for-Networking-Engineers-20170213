<#
Create ORGs
#>

$ORGTest = [regex]"^[A-Za-z0-9:.-_]*$"

#Load list
$List= Import-Csv “.\ORG.csv“


foreach($itemUCS in $ucsList)
{ 
  $ucsRes="Deleting ORG from UCS system - "+$itemUCS.ucs.name
  echo-infoYES $ucsRes

  foreach($item in $List)
  { 
    #Remove ORG
    if (($item.Name.Length -le 16) -and (($ORGTest.Match($item.Name).Success)))
    {  
      $ucsRes=Remove-UcsOrg -Org $item.Name -Ucs $itemUCS.ucs -Force
      $echoRes="Deleted ORG "+$ucsRes.name
      echo-task $echoRes      
    }
  }
}