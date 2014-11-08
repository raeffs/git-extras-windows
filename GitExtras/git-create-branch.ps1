
param(
    [Parameter(Position=0, Mandatory=$true)]
    [string]$branch
)

. init.ps1

git push origin HEAD:refs/heads/$branch
git fetch origin
git checkout --track -b $branch origin/$branch
