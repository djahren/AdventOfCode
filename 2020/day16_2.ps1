cd C:\Users\Ahren\Documents\WindowsPowerShell\AdventOfCode2020\
$TextInput = Get-Content .\day16_input_test.txt
$TextInput = Get-Content .\day16_input.txt

$Definitions = Get-Content .\Definitions.json | ConvertFrom-Json
$PositionsDone = @()

while($Definitions.ValidPositions.Count -ne $Definitions.Count){
    $SingleValidPos = $Definitions | Where {$_.ValidPositions.Count -eq 1}
    foreach($Single in $SingleValidPos | Where {$_.ValidPositions[0] -notin $PositionsDone}){
        $CurrentPosition = $Single.ValidPositions[0]
        foreach($Definition in $Definitions | Where {$_.ValidPositions -contains $CurrentPosition -and $_.Name -ne $Single.Name}){
            $Definition.ValidPositions = $Definition.ValidPositions | Where {$_ -ne $CurrentPosition}
        }
        $PositionsDone += $CurrentPosition
    }
    $Definitions; ""
}
