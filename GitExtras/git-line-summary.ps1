
. init.ps1

write "project : $(pwd | Split-Path -Leaf)"

$lines = 0
$linesByAuthor = @{}

git grep --cached -I -l -e $'' | % {
    git blame --line-porcelain "$_" |
        sls "^author " |
        % { "$_" -replace "^author ", "" } |
        % { $lines++; $linesByAuthor["$_"]++ }
}

write "lines   : $lines"
write "authors : "

$linesByAuthor.GetEnumerator() | 
    sort -Descending Value |
    select Key, Value, @{Name="Percentage"; Expression={ "{0:N2} %" -f  $(100 * $_.Value / $lines) }} |
    ft -HideTableHeaders -AutoSize -Property Value, Key, Percentage
