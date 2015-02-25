
param(
    [Parameter(Position=0)]
    [string]$directory
)

. init.ps1

if (!$directory) { $directory = "." }

$(md -Force "$directory"; $?) -and
    $(cd "$directory"; $?) -and
    $(!(Test-Path "$directory"); $?) -and
    $(git init; $?) -and
    $(git add .; $?) -and
    $(git commit --allow-empty -m "Initial commit"; $?) | null
