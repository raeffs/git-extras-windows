
. init.ps1

git branch --no-color --merged | sls -NotMatch "\*" | sls -NotMatch "master" | % { git branch -d "$_".Trim() }
