$dlgTitle = "Select CSV file"
$dlgDir = "c:\Users\mrobas\Dropbox\Blogs, Presentations, Social, Marketing\2017\PowerShell for Network Engineers\Demos\"
$dlgFilter = "CSV files (*.csv)|*.csv"

$csvtmp = Read-OpenFileDialog -WindowTitle $dlgTitle -InitialDirectory $dlgDir -Filter $dlgFilter
$global:csv25=Import-Csv $csvtmp -Delimiter ";" -verbose

$csv25