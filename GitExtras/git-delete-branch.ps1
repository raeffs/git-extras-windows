
. init.ps1

if ($args.Count -eq 0) { error "branch name required!" }

foreach ($branch in $args)
{
    $remote = $(git config branch.$branch.remote)
    if (!$remote) { $remote = "origin" }
    $ref = $(git config branch.$branch.merge)
    if (!$ref) { $ref = "refs/heads/$branch" }

    git branch -D $branch
    git branch -d -r $remote/$branch
    git push $remote :$ref
}
