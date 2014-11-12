
. init.ps1

git ls-files -v | sls "^S " | % { "$_" -replace "S ", "" }
