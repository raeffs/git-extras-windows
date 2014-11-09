
if ($env:HOME) { (Get-PSProvider 'FileSystem').Home = $env:HOME }

function ExitWithError
{
    param(
        [Parameter(Position=0)]
        [string]$message
    )

    Write-Host $message -ForegroundColor Red
    exit 1
}

Set-Alias -Name error -Value ExitWithError
Set-Alias -Name null -Value Out-Null
