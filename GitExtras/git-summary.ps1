
param(
    [switch]$line,
    [Parameter(Position=0)]
    [string]$commit
)

. init.ps1

function Project { pwd | Split-Path -Leaf }

function RepositoryAge { git log --reverse --pretty=oneline --format="%ar" | select -First 1 | % { $_ -replace " ago", "" } }

function ActiveDays { (git log --pretty='format: %ai' $commit | % { ("$_" -split ' ')[1] } | select -Unique).Count }

function CommitCount { (git log --oneline $commit | select).Count }

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
    if (!$commit)
    {
        write "files    : $(FileCount)"
    }
    write "authors  : "
    Authors
}
