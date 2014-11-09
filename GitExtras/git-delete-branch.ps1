
. init.ps1

if ($args.Count -eq 0) { error "branch name required!" }

$localBranches = ""
$originBranches = ""
$originRefs = ""

foreach ($branch in $args)
{
    $localBranches += " $branch"
    $originBranches += " origin/$branch"
    $originRefs += " :refs/heads/$branch"
}

iex "git branch -D $localBranches"
iex "git branch -d -r $originBranches"
iex "git push origin $originRefs"
