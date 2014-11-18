
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$file,
    [Parameter(Position=1)]
    [string]$commit
)

. init.ps1

if (Test-Path "$file" -PathType Leaf)
{
    git rm --cached -q -f -- "$file"
    if ($commit)
    {
        git checkout "$commit" -- "$file"
        write "Reset '$file' to $commit"
    }
    else
    {
        git checkout HEAD -- "$file"
        write "Reset '$file' to HEAD"
    }
}
else
{
    write "File '$file' not found in '$(pwd)'"
}
