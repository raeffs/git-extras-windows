
. init.ps1

function git-delete-submodule
{
    <#

    .SYNOPSIS
    Delete submodules

    .PARAMETER submodule
    The path of the submodule to delete.

    #>

    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$submodule
    )

    if (!(Test-Path .gitmodules -PathType Leaf)) { error ".gitmodules file not found" }

    if (!(git config --file=.gitmodules submodule.$submodule.url)) { error "submodule not found" }

    git submodule deinit $submodule
    git rm --cached $submodule
    rm .git/modules/$submodule -Recurse -Force
}

git-delete-submodule @args
