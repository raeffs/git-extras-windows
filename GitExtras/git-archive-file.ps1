
. init.ps1

$branch = $(git name-rev HEAD --name-only)
$archiveName = $(gi $(pwd)).Name

if (sls "^tags/.+" -InputObject $branch -Quiet)
{
    $branch = $(git describe)
    write "Building for tag '$branch'"
    $filename = "$archiveName.$branch.zip"
}
else
{
    write "Building archive on branch '$branch'"
    $version = $(git describe --always --long)
    if ($branch -eq "master")
    {
        $filename = "$archiveName.$version.zip"
    }
    else
    {
        $filename = "$archiveName.$version.$branch.zip"
    }
}

$output = "$(pwd)\$filename"

git archive --format zip --output $output $branch

write "Saved to '$filename' ($($(gi $output).Length))"
