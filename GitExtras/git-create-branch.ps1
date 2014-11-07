
param(
    [Parameter(Position=0, Mandatory=$true)]
    [string]$branch
)

if ($env:HOME) { (Get-PSProvider 'FileSystem').Home = $env:HOME }

git push origin HEAD:refs/heads/$branch
git fetch origin
git checkout --track -b $branch origin/$branch
