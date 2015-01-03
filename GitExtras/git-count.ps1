
. init.ps1

function git-count
{
    <#

    .SYNOPSIS
    Show commit count

    .DESCRIPTION
    Show commit count.

    .PARAMETER all
    Show commit count details.

    #>

    param(
        [switch]$all
    )

    if ($all.IsPresent)
    {
        git shortlog -n -s | % { $values = ("$_".Trim() -split '\t', 2); write "$($values[1]) ($($values[0]))" }
        write ""
    }

    write "total $(git rev-list --count HEAD)"
}

git-count @args
