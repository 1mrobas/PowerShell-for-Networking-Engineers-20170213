."C:/Program Files (x86)/VMware/Infrastructure/PowerCLI/Scripts/Initialize-PowerCLIEnvironment.ps1"
Import-Module PureStoragePowerShellSDK
Import-Module PureStoragePowerShellToolkit
Import-Module Cisco.IMC
Import-Module Cisco.UCS.Core
Import-Module Cisco.UCS.DesiredStateConfiguration
Import-Module Cisco.UCSManager
Import-Module SSH-Sessions
Import-Module PSExcel

Get-Module

function prompt {
  $p = Split-Path -leaf -path (Get-Location)
  "$p> "
}

#cd "c:\temp\"
