
. init.ps1

$ref = $(git symbolic-ref HEAD)
$branch = $ref -replace "refs/heads/"

git log origin/$branch..$branch "$args"
