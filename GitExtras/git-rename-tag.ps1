
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$old,
    [Parameter(Mandatory=$true, Position=1)]
    [string]$new
)

. init.ps1

git tag "$new" "$old"
git tag -d "$old"
git push origin "$new"
git push origin ":refs/tags/$old"
