#####
#
# Test with ping
# Input file with IP destinations
# Output - save result to file
#
#####

$captureDir = $workDir+"ping\"
$dtstr=get-dtstr
$csvFile = "PING-test-list.csv"
$csvList=Import-Csv $csvFile

# Set output file
$outFile = $captureDir+"CONN-VERIFY-"+$dtstr.ToString()+".csv"

# Set buffer size in bytes
$bufSize = "32"


# create output file
out-file $outFile -encoding ascii 
out-file $outFile -encoding ascii -append -InputObject "##### Ping test result"
"Dst Name,Dst IP,Success" | out-file $outFile -encoding ascii -append


foreach($item in $csvList)
{
  $PingRes = Test-Connection -quiet -ComputerName $item.dstIP -Count 3 -BufferSize $bufSize -ErrorAction 0
  if($PingRes) {$pingMsg="OK"} else {$pingMsg="FAIL"}
  $item.name+";"+$item.dstIP+";"+$pingMsg | out-file $outFile -encoding ascii -append
  
  $echoRes=$item.name+" - "+$pingMsg 
  if ($PingRes) { echo-task $echoRes } else { echo-infoNO $echoRes }
}