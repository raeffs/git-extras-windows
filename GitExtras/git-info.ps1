
param(
    [switch]$noConfig
)

. init.ps1

write ""
write "## Remote URLs:"
git remote -v

write ""
write "## Remote Branches:"
git branch -r

write ""
write "## Local Branches:"
git branch

write ""
write "## Most Recent Commit:"
git log --max-count=1 --pretty=short
write "Type 'git log' for more commits, or 'git show <commit id>' for full commit details."

if (!$noConfig.IsPresent)
{
    write ""
    write "## Configuration (.git/config):"
    git config --list
}
