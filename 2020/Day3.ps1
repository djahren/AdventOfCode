$TextInput = gc "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day3_input.txt"
#$TextInput = gc "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day3_input_test.txt"
$Slopes = Import-Csv "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\Day3Slopes.csv"

$Map = $TextInput
function Extend-Map{
    for($I = 0; $I -lt $Map.Length; $I += 1){
        $Map[$I] += $TextInput[$I]
    }
}

$Multiplied = 1
foreach($Slope in $Slopes){
    $X = 0; $Y = 0; $TreeCount = 0
    while($Y -lt $Map.Length){
        if($X + $Slope.Right -ge $Map[0].Length){
            Extend-Map
        }
        #$Map
        #"X: $X Y: $Y"
        #$TreeCount

        if($Map[$Y][$X] -eq "#"){
            $TreeCount += 1
            #$Map[$Y][$X] = "!"
        }

        $X += $Slope.Right
        $Y += $Slope.Down
    }

    $TreeCount
    $Multiplied *= $TreeCount
}
$Multiplied