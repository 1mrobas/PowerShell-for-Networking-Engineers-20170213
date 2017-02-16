Import-Module .\demoVars.psm1


$devName=read-Host -Prompt "Hostname or IP: "
$cmd1=read-Host -Prompt "Command: "
$ssh1=New-SshSession -ComputerName $devName -Username $devUsr -Password $devPwd

$cmd_output=Invoke-SshCommand -ComputerName $devName -Command $cmd1 -Quiet

$dtstr=get-dtstr
$outfile=$devName+"-"+$cmd1+$dtstr+".txt"
$cmd_output | Out-File $outfile