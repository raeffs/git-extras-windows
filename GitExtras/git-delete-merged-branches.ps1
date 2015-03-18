
. init.ps1

git branch --no-color --merged | sls -NotMatch "\*" | sls -NotMatch "master" | sls -NotMatch "svn" | % { git branch -d "$_".Trim() }
