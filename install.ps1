
function install
{
    param(
        [Parameter(Position = 0)]
        [string]$targetDirectory,
        [switch]$skipPath
    )

    $ErrorActionPreference = "Stop"

    if (!$targetDirectory)
    {
        $targetDirectory = Read-Host -Prompt "Specify the directory for the installation [default: '$($env:ProgramFiles)\git-extras-windows']"
        if (!$targetDirectory) { $targetDirectory = "$($env:ProgramFiles)\git-extras-windows" }
    }

    if (!(Test-Path $targetDirectory -PathType Container)) { mkdir $targetDirectory }

    $archiveFile = "$($env:TEMP)\git-extras-windows.zip"
    $tempDirectory = "$($env:TEMP)\git-extras-windows-master"

    Invoke-WebRequest "https://github.com/raeffs/git-extras-windows/archive/master.zip" -OutFile $archiveFile
    $shell = New-Object -ComObject Shell.Application
    foreach ($item in $shell.Namespace($archiveFile).items())
    {
        $shell.Namespace($env:TEMP).copyhere($item, 20)
    }

    pushd $tempDirectory
    . .\build.ps1
    popd

    gci "$tempDirectory\GitExtras\bin\Release" -Exclude "gitextras.*" | % { move $_.FullName $targetDirectory -Force }

    if (!$skipPath.IsPresent)
    {
        [Environment]::SetEnvironmentVariable("Path", "$([Environment]::GetEnvironmentVariable("Path", "Machine"));$targetDirectory", "Machine")
    }

    rm $tempDirectory -Recurse -Force
    rm $archiveFile

    write "Successfully installed!"
}

install @args
