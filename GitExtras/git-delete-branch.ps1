
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

git branch -D $localBranches
git branch -d -r $originBranches
git push origin $originRefs
