$PuzzleInput = Get-Content .\d3_input.txt

#part1
$GammaRateBinary = @{}; $EpsilonRate = 0;
# $PowerConsumption = $GammaRateBinary * $EpsilonRate
for($BitPosition = 0; $BitPosition -lt $PuzzleInput[0].Length; $BitPosition++){
    "Position: $BitPosition"
    $Zeros = 0; $Ones = 0;
    foreach($Line in $PuzzleInput){
        $CurrentValue = [Char]$Line.Trim()[$BitPosition]
        switch ($CurrentValue) {
            0 { $Zeros++ }
            1 { $Ones++ }
            #Default {"WTF its a: $CurrentValue BitPos: $BitPosition Line: $Line" }
        }
    }
    $BitPower = [Math]::Pow(2, $PuzzleInput[0].Length - (1 + $BitPosition));
    $GammaRateBinary[$BitPower] = if($Zeros -gt $Ones){0}else{1}
}
"Final"
$GammaRateBinary
$GammaRate = 0; $EpsilonRate = 0;
foreach($Place in $GammaRateBinary.GetEnumerator()){
    switch ($Place.Value) {
        1 { $GammaRate += $Place.Name }
        0 { $EpsilonRate += $Place.Name }
        Default {}
    }
}

"Gamma = $GammaRate; Epsilon = $EpsilonRate"
"PowerConsumption = $($GammaRate * $EpsilonRate)"

#part2
