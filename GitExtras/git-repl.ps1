
. init.ps1

function git-repl
{
    <#

    .SYNOPSIS
    git read-eval-print-loop

    #>

    git version
    write "git-extras-windows version $(git extras -version)"
    write "type 'ls' to ls files below current directory, '!command' to execute any command or just 'subcommand' to execute any git subcommand"

    while ($true)
    {
        $branch = (git symbolic-ref HEAD 2>$null) -replace 'refs/heads/',''
        $prompt = "git> "
        if ($branch) { $prompt = "git ($branch)> " }

        Write-Host $prompt -NoNewline
        #$cmd = Read-Host -Prompt "$prompt" does not allow !
        $cmd = Read-Host

        if ($cmd -eq "") { continue }

        switch ($cmd)
        {
            "ls" { $cmd = "ls-files" }
            "quit" { return }
        }

        if ($cmd -like "!*") { iex $cmd.Substring(1) }
        elseif ($cmd -like "git*") { iex $cmd }
        else { git "$cmd" }
    }

    write ""
}

git-repl @args
