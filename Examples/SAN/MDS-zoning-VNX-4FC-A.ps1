#### change to enter zoneset name !!!!

<####
# Parameters
#   csvList - input CSV file with list of host alias names and WWPNs
# 
# Output
#   DevAlias.txt file 
#
#####>

###Get date & time
$today = get-date
$day = $today.Day
$mth = $today.Month
$year = $today.Year
$hour = $today.Hour
$min = $today.Minute
$sec = $today.Second
$date = "$year-$mth-$day-$hour$min$sec"

###Collect input parameters
#$csvStorageList=Read-Host -Prompt "Storage list:"
#$csvServerList=Read-Host -Prompt "Server HBA list:"

$csvStorageList="zone-VNX-A.csv"
$csvServerList="zone-srv-A.csv"

$fabricVSAN="11"
$zoneset="VSAN11ZONESET"
$outFile = $date+"-VNX-zone-11.txt"
$outFile2 = $date+"-VNX-zoneset-11.txt"

###Load lists
$listStorage=Import-Csv $csvStorageList
$listServer=Import-Csv $csvServerList



out-file $outFile -encoding ascii 

out-file $outFile2 -encoding ascii 
"zoneset name "+$zoneset+" vsan "+$fabricVSAN.ToString() | out-file $outFile2 -encoding ascii -append

###Zones
foreach($itemStorage in $listStorage)
{
  foreach($itemServer in $listServer)
  {
    #create zone
    "zone name "+$itemStorage.Name+"--"+$itemServer.Name+" vsan "+$fabricVSAN.ToString() | out-file $outFile -encoding ascii -append
    " member device-alias "+$itemServer.DevAlias | out-file $outFile -encoding ascii -append
    " member device-alias "+$itemStorage.DevAlias1 | out-file $outFile -encoding ascii -append
    " member device-alias "+$itemStorage.DevAlias2 | out-file $outFile -encoding ascii -append   
    " member device-alias "+$itemStorage.DevAlias3 | out-file $outFile -encoding ascii -append   
    " member device-alias "+$itemStorage.DevAlias4 | out-file $outFile -encoding ascii -append   
    "!" | out-file $outFile -encoding ascii -append
    #add member to zoneset
    " member "+$itemStorage.Name+"--"+$itemServer.Name | out-file $outFile2 -encoding ascii -append
    #commit zones  
    "zone commit vsan "+$fabricVSAN.ToString() | out-file $outFile -encoding ascii -append
    "!" | out-file $outFile -encoding ascii -append
  } 
}

#Commit and activat zoneset
"zoneset activate name "+$zoneset+" vsan "+$fabricVSAN.ToString() | out-file $outFile2 -encoding ascii -append
"zone commit vsan "+$fabricVSAN.ToString() | out-file $outFile2 -encoding ascii -append