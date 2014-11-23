
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$file
)

. init.ps1

git filter-branch -f --index-filter "git rm -r --cached '$file' --ignore-unmatch" --prune-empty --tag-name-filter cat -- --all
