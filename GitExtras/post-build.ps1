
param($outputDir, $targetName)

cd $outputDir
gci . -Filter "git-*.ps1" | % { $script = $_; gci $targetName | cp -Destination { $script.Name -replace ".ps1", ".exe" } }
