<#####
# Parameters
#   csvList - input CSV file with list of host alias names and WWPNs
# 
# Output
#   DevAlias.txt file 
#
#####>

#Get date & time
$today = get-date
$day = $today.Day
$mth = $today.Month
$year = $today.Year
$hour = $today.Hour
$min = $today.Minute
$sec = $today.Second
$date = "$year-$mth-$day-$hour$min$sec"

#### Fabric A
#Server PWWN list
  # $csvLi	st = Read-Host -Prompt "PWWN list: " 
  $csvList = "wwpnUCS-A.csv"
  $listCSV=Import-Csv $csvList

# $outFile = Read-Host -Prompt "Output file: "
  $outFile = $date+"-devalias-wwpnUCS-A.txt"

  out-file $outFile -encoding ascii 
  # out-file $outFile -encoding ascii -append -InputObject "! $date Device Alias Configuration"
  "device-alias database" | out-file $outFile -encoding ascii -append 
  foreach($item in $listCSV)
  {
    "device-alias name "+$item.Port+" pwwn "+$item.WWPN | out-file $outFile -encoding ascii -append
  }
  "";"device-alias commit" | out-file $outFile -encoding ascii -append 

#### Fabric B
#Server PWWN list
  $csvList = "wwpnUCS-B.csv"
  $listCSV=Import-Csv $csvList

# $outFile = Read-Host -Prompt "Output file: "
  $outFile = $date+"-devalias-wwpnUCS-B.txt"

  out-file $outFile -encoding ascii 
  # out-file $outFile -encoding ascii -append -InputObject "! $date Device Alias Configuration"
  "device-alias database" | out-file $outFile -encoding ascii -append 
  foreach($item in $listCSV)
  {
    "device-alias name "+$item.Port+" pwwn "+$item.WWPN | out-file $outFile -encoding ascii -append
  }
  "";"device-alias commit" | out-file $outFile -encoding ascii -append 