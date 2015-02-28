
. init.ps1

function Project { pwd | Split-Path -Leaf }

function RepositoryAge { git log --reverse --pretty=oneline --format="%ar" | select -First 1 | % { $_ -replace " ago", "" } }

function ActiveDays { (git log --pretty='format: %ai' $commitish | % { ("$_" -split ' ')[1] } | select -Unique).Count }

function CommitCount { (git log --oneline $commitish | select).Count }

function FileCount { (git ls-files | select).Count }

function Authors
{
    $totalCommitCount = (git log --oneline | select).Count

    git shortlog -n -s | % { $values = ("$_".Trim() -split '\t', 2) 
        New-Object PsObject -Property @{
            CommitCount = $values[0]
            Name = $values[1]
            Percentage = "{0:N2} %" -f $(100 * $values[0] / $totalCommitCount)
        }
    } | ft -HideTableHeaders -AutoSize -Property CommitCount, Name, Percentage
}

function git-summary
{
    <#

    .SYNOPSIS
    Shows a summary of the repository.

    .PARAMETER commitish
    Summarize only the range of commits included in the <commitish>.

    .PARAMETER line
    Summarize with lines other than commits

    #>

    param(
        [switch]$line,
        [Parameter(Position=0)]
        [string]$commitish
    )

    pushd "$(git root)"

    if ($line.IsPresent)
    {
        git line-summary
    }
    else
    {
        write "project  : $(Project)"
        write "repo age : $(RepositoryAge)"
        write "active   : $(ActiveDays) days"
        write "commits  : $(CommitCount)"
        if (!$commitish)
        {
            write "files    : $(FileCount)"
        }
        write "authors  : "
        Authors
    }

    popd
}

git-summary @args