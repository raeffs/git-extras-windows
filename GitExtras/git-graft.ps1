
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$source,
    [Parameter(Mandatory=$false, Position=1)]
    [string]$destination
)

. init.ps1

$(git checkout $destination; $?) -and
    $(git merge --no-ff $source; $?) -and
    $(git branch -d $source; $?) | null
