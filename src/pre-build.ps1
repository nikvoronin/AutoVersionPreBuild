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
$asmInfoExists = Test-Path $asmInfoPath

if (!$asmInfoExists) { 
	Write-Host "ERROR: AssemblyInfo file not found at $asmInfoPath"
	Exit 1
}

function Get-VersionString {
	Get-Date -Format 'yy.M.d.HHmm'
}

$content = ""
foreach($line in [System.IO.File]::ReadLines($asmInfoPath)) {
    $attrName, $attrValue, $attrTail = $line.split('"');
    if ($attrName.contains('AssemblyVersion')) {
		$version = Get-VersionString
        $newline = "$attrName""$version""$attrTail"
    }
    else {
        $newline = "$line`r`n"
    }

    $content += $newline
}

$content.TrimEnd() | Out-File $asmInfoPath
