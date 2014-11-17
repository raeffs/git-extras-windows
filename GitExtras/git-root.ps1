
param(
    [switch]$relative
)

. init.ps1

if ($relative.IsPresent)
{
    git rev-parse --show-prefix
}
else
{
    git rev-parse --show-toplevel
}
