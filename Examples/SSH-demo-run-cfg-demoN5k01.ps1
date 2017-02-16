Import-Module .\demoVars.psm1


$devName="demoN5K01.flashstack.local"
$ssh1=New-SshSession -ComputerName $devName -Username $devUsr -Password $devPwd

$cmd_output=Invoke-SshCommand -ComputerName $devName -Command "show run" -Quiet

$dtstr=get-dtstr
$outfile="demoN5K01-run-cfg"+$dtstr+".txt"
$cmd_output | Out-File $outfile