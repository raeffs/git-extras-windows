
. init.ps1

git branch --merged | sls -NotMatch "\*" | sls -NotMatch "master" | % { git branch -d "$_".Trim() }
