$ErrorActionPreference = 'Stop'

$toolsPath  = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = $Env:ChocolateyPackageName
    FileFullPath64 = Get-Item $toolsPath\*.zip
    Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0