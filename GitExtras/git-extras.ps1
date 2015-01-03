
function GetVersion
{
    (gi "$(Split-Path -Path $global:MyInvocation.MyCommand.Definition -Parent)\git-extras.exe").VersionInfo.ProductVersion
}

function Update
{
    $version = GetVersion
    $installDir = Split-Path -Path $global:MyInvocation.MyCommand.Definition -Parent
    $tempExe = "$installDir\_git-extras.exe"
    $storedErrorActionPreference = $ErrorActionPreference

    pushd "$env:TEMP"
    $ErrorActionPreference = "Stop"
    try
    {
        if (Test-Path git-extras-windows) { rm git-extras-windows -Recurse -Force }
        git clone --depth 1 https://github.com/raeffs/git-extras-windows.git
        cd git-extras-windows
        . .\build
        cd GitExtras\bin\Release
        if (Test-Path $tempExe) { rm $tempExe -Force }
        ren "$installDir\git-extras.exe" $tempExe
        gci . -Exclude "GitExtras.*" |
            % { $file = $_; cp $file $installDir -Force }
        write "... updated git-extras-windows $version -> $(GetVersion)"
    }
    finally
    {
        $ErrorActionPreference = $storedErrorActionPreference
        popd
    }
}

function git-extras
{
    <#

    .SYNOPSIS
    Awesome GIT utilities

    .PARAMETER version
    Show git-extras version number.

    .PARAMETER update
    Self update.

    .PARAMETER help
    Show this help. This option can also be used for any of the extras commands.

    #>

    [CmdletBinding(DefaultParameterSetName = 'help')]
    param(
        [Parameter(ParameterSetName = 'version')]
        [switch]$version,
        [Parameter(ParameterSetName = 'update')]
        [switch]$update,
        [Parameter(ParameterSetName = 'help')]
        [switch]$help
    )
    
    switch ($PSCmdlet.ParameterSetName)
    {
        "version"
        {
            GetVersion
        }
        "update"
        {
            Update
        }
        "help"
        {
            Get-Help git-extras -Detailed
        }
    }
}

git-extras @args
