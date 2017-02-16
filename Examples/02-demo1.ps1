$var1 = "Hello World!"

$var2 = 100

$csvFile1 = read-Host -Prompt "Input CSV file: "

$dlgTitle = "Select CSV file"
$dlgDir = "c:\Users\mrobas\Dropbox\Blogs, Presentations, Social, Marketing\2017\PowerShell for Network Engineers\Demos\"
$dlgFilter = "CSV files (*.csv)|*.csv"

$csvFile2 = Read-OpenFileDialog -WindowTitle $dlgTitle -InitialDirectory $dlgDir -Filter $dlgFilter
if (![string]::IsNullOrEmpty($csvFile2)) 
  { Write-Host "You've selected the file: $csvFile2" }
else 
  { "You did not select a file." }
