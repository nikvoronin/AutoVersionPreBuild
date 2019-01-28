<#
Project Settings -> Build Events -> Pre-build event command line:
powershell.exe -ExecutionPolicy Bypass -NoProfile -NonInteractive -File $(SolutionDir)pre-build.ps1 -projectPath "$(ProjectDir)\"
#>

param (
    [string]$projectPath = "Properties\"
)

$assemblyInfoPath = "$($projectPath)Properties\AssemblyInfo.cs"

$title = "AutoVersionPreBuild"
$description = ""
$company = ""
$product = ""
$owner = "Owner Name"
$trademark = ""

$version = Get-Date -Format 'yy.M.d.HHmm'
$year = Get-Date -Format 'yyyy'

$content = @"
using System.Reflection;

[assembly: AssemblyTitle("$title")]
[assembly: AssemblyDescription("$description")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("$company")]
[assembly: AssemblyProduct("$product")]
[assembly: AssemblyCopyright("Copyright (c) $year")]
[assembly: AssemblyTrademark("$trademark")]
[assembly: AssemblyCulture("")]
[assembly: AssemblyVersion("$version")]
"@

$content | Out-File $assemblyInfoPath