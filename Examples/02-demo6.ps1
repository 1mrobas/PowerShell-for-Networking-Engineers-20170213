$dtstr=get-dtstr
$outfile="hcInfra_ESXi-"+$dtstr+".csv"

Get-VMHost -Server $vcInfra |
Select @{N="ESXi";E={$_.Name}},
@{N="Connection State";E={$_.ConnectionState}} ,
@{N="CPU";E={$_.NumCpu}} ,
@{N="Memory";E={$_.MemoryTotalGB}} ,
@{N="Version";E={$_.Version}} |
Export-Csv $outfile -Delimiter ";" -NoTypeInformation