
. init.ps1

$since = "last week"

if ($args.Count -ne 0) { $since = "$args" }

write "... commits since $since"
git log --pretty='%an - %s' --after=$since
