
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$file
)

. init.ps1

$(touch $file; $?) -and $(git add $file; $?) | null
