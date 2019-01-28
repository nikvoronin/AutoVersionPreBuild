# Auto version number with help of Pre-build events and Powershell

Visual Studio 2017 &rarr; Project Settings &rarr; Build Events &rarr; Pre-build event command line:

```
powershell.exe -ExecutionPolicy Bypass -NoProfile -NonInteractive -File $(SolutionDir)pre-build.ps1 -projectPath "$(ProjectDir)\"
```

