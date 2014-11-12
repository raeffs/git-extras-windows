
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$file
)

. init.ps1

git update-index --skip-worktree $file
