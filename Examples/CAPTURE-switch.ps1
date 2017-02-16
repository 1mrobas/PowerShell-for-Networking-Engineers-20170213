# switch list input file
$csvListSw = "CAPTURE-switch-list.csv"

# command list input file
$csvListCmd = "CAPTURE-switch-cmd-list.csv"

$captureDir = $workDir+"capture\"

#Load Lists
$csvSW=Import-Csv $csvListSw
$csvCMD=Import-Csv $csvListCmd

foreach($item in $csvSW)
{
  $dtstr=get-dtstr

  New-SshSession -ComputerName $item.mgmtIP -username $devUsr -password $devPwd
  $tmpsw=$item.name
  echo-task "Capturing on $tmpsw"
 
  foreach($item1 in $csvCMD)
  {
    "  - "+$item1.Cmd
    $cmd_output=Invoke-SshCommand -ComputerName $item.mgmtIP -Command $item1.cmd -Quiet
    
    $outfile=$captureDir+$item.name+"-"+$item1.cmd+" - "+$dtstr+".txt"
    out-file $outfile -encoding ascii 
    $cmd_output | out-file $outfile -encoding ascii -append
  }
  Remove-SshSession -RemoveAll
}