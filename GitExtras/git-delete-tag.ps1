
. init.ps1

function git-delete-tag
{
    <#

    .SYNOPSIS
    Delete tags

    .DESCRIPTION
    Deletes local and remote tags.

    .PARAMETER tags
    The name of the tag to delete. If multiple tags are provided, then they will all be deleted.

    #>

    param(
        [Parameter(Mandatory, Position = 0)]
        [string[]]$tags
    )

    $tags | 
        % { 
            $localTags = "$localTags $_"
            $originRefs = "$originRefs :refs/tags/$_"
        }

    git tag -d $localTags.Trim()
    git push origin $originRefs.Trim()
}

git-delete-tag @args
