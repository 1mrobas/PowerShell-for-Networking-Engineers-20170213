#####
#
# Test PING
# Output - save result to file
#
#####

$captureDir = $workDir+"ping\"

$dtstr=get-dtstr

$dstIP = "www.cisco.com"
$outFile = $captureDir+"PING-TEST-"+$dtstr.ToString()+".csv"

out-file $outFile -encoding ascii 
"Year;Month;Day;Hour;Minute;Second;Msec;RTT" | out-file $outFile -encoding ascii -append

while(1)
{
  $dateNow = Get-Date
  $result = test-netconnection $dstIP
  $dateNow.Year.ToString()+"."+$dateNow.Month.ToString()+"."+$dateNow.Day.ToString()+"-"+$dateNow.Hour.ToString()+":"+$dateNow.Minute.ToString()+":"+$dateNow.Second.ToString()+"::"+$dateNow.Millisecond.ToString()+" >> "+$result.PingReplyDetails.RoundTripTime
  $dateNow.Year.ToString()+";"+$dateNow.Month.ToString()+";"+$dateNow.Day.ToString()+";"+$dateNow.Hour.ToString()+";"+$dateNow.Minute.ToString()+";"+$dateNow.Second.ToString()+";"+$dateNow.Millisecond.ToString()+";"+$result.PingReplyDetails.RoundTripTime | out-file $outFile -encoding ascii -append
  start-sleep -seconds 5
}