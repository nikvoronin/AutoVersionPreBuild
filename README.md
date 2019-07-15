# Version Number As A Build Date 

Or a build date as a version number. Auto incremental version in a date format like: `Version 19.12.03.1643`. The script itself changes version attribute only.

Drop [pre-build.ps1](https://github.com/nikvoronin/AutoVersionPreBuild/blob/master/src/pre-build.ps1) next to .sln file then add at the<br/>
`Visual Studio -> Project Settings -> Build Events -> Pre-build event command line`

next line
```
powershell.exe -ExecutionPolicy Bypass -NoProfile -NonInteractive -File "$(SolutionDir)pre-build.ps1" -ProjectDir "$(ProjectDir)\"
```

Do not remove last slash `\"`

# Optional Parameters

-PropertiesDir "Properties"

-AsmInfoFilename "AssemblyInfo.cs"

## Example
```
powershell.exe -ExecutionPolicy Bypass -NoProfile -NonInteractive -File "$(SolutionDir)pre-build.ps1" -ProjectDir "$(ProjectDir)\" -PropertiesDir "Properties" -AsmInfoFilename "AssemblyInfo.cs"
```
