
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

function TouchFile
{
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$filename
    )

    if (Test-Path $filename)
    {
        (gci $filename).LastWriteTime = Get-Date
    }
    else
    {
        echo $null > $filename
    }
}

Set-Alias -Name error -Value ExitWithError
Set-Alias -Name touch -Value TouchFile
Set-Alias -Name null -Value Out-Null

[System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8
