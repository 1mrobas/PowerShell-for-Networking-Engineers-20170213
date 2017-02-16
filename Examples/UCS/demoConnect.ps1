
<#####
# Connect to UCS1 and UCS2
#####>
echo-inprogress "Connecting to $ucs_sddcUCS1vip"
$global:ucsUCS1= Connect-Ucs -Name $ucs_sddcUCS1vip -Credential $ucsCredentials -NotDefault
echo-inprogress "Connecting to $ucs_sddcUCS2vip"
$global:ucsUCS2= Connect-Ucs -Name $ucs_sddcUCS2vip -Credential $ucsCredentials -NotDefault

echo-success "Connected to UCSes"
echo-task $ucsUCS1.Ucs
echo-task $ucsUCS2.Ucs

$global:ucsList=@() 
$ucsRow = @{ UCS=$ucsUCS1}
$global:ucsList += New-Object PSObject -Property $ucsRow

$ucsRow = @{ UCS=$ucsUCS2}
$global:ucsList += New-Object PSObject -Property $ucsRow
