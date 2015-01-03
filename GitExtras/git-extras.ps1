
function GetVersion
{
    (gi "$(Split-Path -Path $global:MyInvocation.MyCommand.Definition -Parent)\git-extras.exe").VersionInfo.ProductVersion
}

function Update
{
    $version = GetVersion
    $installDir = Split-Path -Path $global:MyInvocation.MyCommand.Definition -Parent

    pushd "$env:TEMP"
    try
    {
        if (Test-Path git-extras-windows) { rm git-extras-windows -Recurse -Force }
        git clone --depth 1 https://github.com/raeffs/git-extras-windows.git
        cd git-extras-windows
        . .\build
        cd GitExtras\bin\Release
        gci . -Exclude "GitExtras.*" |
            % { $file = $_; cp $file $installDir -Force }
        write "... updated git-extras-windows $version -> $(GetVersion)"
    }
    finally
    {
        popd
    }
}

function git-extras
{
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
            Write-Warning "Help not yet implemented!"
        }
    }

}

git-extras @args
