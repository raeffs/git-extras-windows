
$msBuildPaths = @(
    "$env:windir\Microsoft.NET\Framework\v4.0.30319\msbuild.exe",
    "$env:ProgramFiles\MSBuild\12.0\bin\msbuild.exe",
    "${env:ProgramFiles(x86)}\MSBuild\12.0\bin\msbuild.exe",
    "$env:ProgramFiles\MSBuild\14.0\bin\msbuild.exe",
    "${env:ProgramFiles(x86)}\MSBuild\14.0\bin\msbuild.exe"    
)

$msBuildPaths | % { if (Test-Path $_ -PathType Leaf) { $msBuild = $_ } }

if (!$msBuild) { throw "Could not find MsBuild!" }

iex "$msBuild GitExtras\GitExtras.sln /p:Configuration=""Release"" /p:Platform=""Any CPU"""
