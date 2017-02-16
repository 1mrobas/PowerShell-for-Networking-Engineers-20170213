#####
#
# Test HTTP
# Output - save result to file
#
#####

#$captureDir = $workDir+"http\"

$dtstr=Get-Date -format "yyyMMdd-HHmmss"

$dstURI = "http://demomgmt1.flashstack.local:80/LOOPBACK"
$outFile = $captureDir+"WEB-TEST-"+$dtstr.ToString()+".csv"

out-file $outFile -encoding ascii 
out-file $outFile -encoding ascii -append -InputObject "##### HTTP test result"
"Year;Month;Day;Hour;Minute;Second;Msec;RTT" | out-file $outFile -encoding ascii -append

while(1)
{
  $dateNow = Get-Date
  $result = Measure-Command { $request = Invoke-WebRequest -Uri $dstURI } 
  $dateNow.Year.ToString()+"."+$dateNow.Month.ToString()+"."+$dateNow.Day.ToString()+"-"+$dateNow.Hour.ToString()+":"+$dateNow.Minute.ToString()+":"+$dateNow.Second.ToString()+"::"+$dateNow.Millisecond.ToString()+" >> "+$result.TotalMilliseconds
  $dateNow.Year.ToString()+";"+$dateNow.Month.ToString()+";"+$dateNow.Day.ToString()+";"+$dateNow.Hour.ToString()+";"+$dateNow.Minute.ToString()+";"+$dateNow.Second.ToString()+";"+$dateNow.Millisecond.ToString()+";"+$result.TotalMilliseconds | out-file $outFile -encoding ascii -append
  start-sleep -seconds 5
}