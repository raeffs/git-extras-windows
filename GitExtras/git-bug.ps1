
param(
    [switch]$finish,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$name
)

. init.ps1

$branch = "bug/$name"

if ($finish.IsPresent)
{
    $(git merge --no-ff $branch; $?) -and $(git delete-branch $branch; $?) | null
}
else
{
    $(git checkout -b $branch; $?) -or $(git checkout $branch; $?) | null
}
