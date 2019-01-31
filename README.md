# Version Number As A Build Date 

Auto incremental version number in a date format like: `Version 19.12.03.1643`. Script changes version attribute only.

Drop `pre-build.ps1` next to .sln file then add pre-build event action at the
`Visual Studio -> Project Settings -> Build Events -> Pre-build event command line`

```
powershell.exe -ExecutionPolicy Bypass -NoProfile -NonInteractive -File $(SolutionDir)pre-build.ps1 -ProjectDir "$(ProjectDir)\"
```

Do not remove last slash `\"`

# Optional Parameters

-PropertiesDir "Properties"

-AsmInfoFilename "AssemblyInfo.cs"