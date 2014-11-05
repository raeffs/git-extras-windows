
param(
    [switch]$local,
    [switch]$global
)

if ($env:HOME) { (Get-PSProvider 'FileSystem').Home = $env:HOME }

function ShowContent
{
    param($context, $file)

    if (!$file -or !(Test-Path $file)) { return }
    
    write "$context gitignore: $file"
    cat $file
}

function ShowGlobal
{
    ShowContent "Global" $(iex "git config --global core.excludesfile")
}

function ShowLocal
{
    ShowContent "Local" .gitignore
}

function AddPatterns
{
    param($file, $patterns)

    write "Adding pattern(s) to: $file"
    foreach ($pattern in $patterns)
    {
        write "... adding '$pattern'"
        $escapedPattern = [Regex]::Escape($pattern)
        if (!($file -and (Test-Path $file) -and $pattern -and (cat $file | sls "^$escapedPattern$")))
        {
            $pattern | Out-File $file -Append -Encoding utf8
        }
    }
}

function AddGlobal
{
    param($patterns)
    AddPatterns $(iex "git config --global core.excludesfile") $patterns
}

function AddLocal
{
    param($patterns)
    AddPatterns .gitignore $patterns
}

if ($args.Count -eq 0 -and !$local.IsPresent -and !$global.IsPresent)
{
    ShowGlobal
    write "---------------------------------"
    ShowLocal
}
else
{
    if ($global.IsPresent)
    {
        if ($args.Count -ne 0) { AddGlobal $args }
        ShowGlobal
    }
    else
    {
        if ($args.Count -ne 0) { AddLocal $args }
        ShowLocal
    }
}