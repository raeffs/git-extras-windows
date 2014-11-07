
if ($env:HOME) { (Get-PSProvider 'FileSystem').Home = $env:HOME }

if ($args.Count -eq 0)
{
    Write-Host "branch required!" -ForegroundColor Red
    exit 1
}

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
