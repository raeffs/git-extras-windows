
[CmdletBinding(DefaultParametersetName='soft')]
param(
    [Parameter(ParameterSetName='hard')]
    [switch]$hard,
    [Parameter(ParameterSetName='soft')]
    [switch]$soft,
    [Parameter(ParameterSetName='hard', Position=0)]
    [Parameter(ParameterSetName='soft', Position=0)]
    [int]$back
)

. init.ps1

$resetArgument = "^"
if ($back -gt 1) { $resetArgument = "~$back" }

switch ($PSCmdlet.ParameterSetName)
{
    'soft'
    {
        git reset --soft HEAD$resetArgument
        git reset
    }
    'hard'
    {
        git reset --hard HEAD$resetArgument
    }
}
