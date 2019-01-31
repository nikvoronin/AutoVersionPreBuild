<#
Drop pre-build.ps1 next to .sln file then add pre-build event action at the
Visual Studio -> Project Settings -> Build Events -> Pre-build event command line:
powershell.exe -ExecutionPolicy Bypass -NoProfile -NonInteractive -File $(SolutionDir)pre-build.ps1 -ProjectDir "$(ProjectDir)\"
#>

param (
    [string]$ProjectDir = '.\',
    [string]$PropertiesDir = 'Properties',
	[string]$AsmInfoFilename = 'AssemblyInfo.cs'
)

$ProjectDir = ($ProjectDir, "$ProjectDir\")[!$ProjectDir.EndsWith('\')]
$PropertiesDir = ($PropertiesDir, "$PropertiesDir\")[!$PropertiesDir.EndsWith('\')]
$asmInfoPath = "$ProjectDir$PropertiesDir$AsmInfoFilename"
$asmInfoPresent = Test-Path $asmInfoPath

if (!$asmInfoPresent) { 
	Write-Host "ERROR: Assembly info file not found at $asmInfoPath"
	Exit 1 
}

function Get-VersionString {
	Get-Date -Format 'yy.M.d.HHmm'
}

$content = ""
$pattern = '\[assembly: AssemblyVersion\("(.*)"\)\]'
foreach($line in [System.IO.File]::ReadLines($asmInfoPath)) {
	if($line -match $pattern) {
		$version = Get-VersionString
		$line = "[assembly: AssemblyVersion(""$version"")]";
	}

    $content += "$line`r`n"
}

$content.TrimEnd() | Out-File $asmInfoPath
