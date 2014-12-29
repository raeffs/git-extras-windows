
. init.ps1

$args | % {
    if (sls "^-.+" -InputObject $_ -Quiet -NotMatch)
    {
        if (!$firstBranch) { $firstBranch = "$_"; return }
        if (!$secondBranch) { $secondBranch = "$_"; return }
    }
    else
    {
        $passthrough = "$passthrough $_"
    }
}

if (!$firstBranch) { error "At least one branch is required!" }

if (!$secondBranch)
{
    $secondBranch = $firstBranch
    $firstBranch = ""
}

git log $passthrough.Trim() $firstBranch...$secondBranch --format="%m %h %s" --left-right
