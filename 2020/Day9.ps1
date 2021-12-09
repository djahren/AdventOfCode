$TextInput = Get-Content "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day9_input_test.txt"; $PreambleLength = 5
$TextInput = Get-Content "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day9_input.txt"; $PreambleLength = 25

$ConvertedInput = $TextInput | %{[Int64]$_}


$Start = $PreambleLength
while($Start -lt $ConvertedInput.Length){
    $Preamble = @()
    $Found = $false
    for($I = $Start - $PreambleLength; $I -lt $Start; $I += 1){
        $Preamble += $ConvertedInput[$I]
        $Subtracted = $ConvertedInput[$Start] - $ConvertedInput[$I]
        if($Subtracted -in  $Preamble -and $Subtracted -ne $ConvertedInput[$I]){
            $Found = $true
            break
        }
    }
    if(-not $Found){
         $InvalidNum = $ConvertedInput[$Start]
         $InvalidNum
    }
    $Start += 1
}

$Start = 0; $Found = $false
while($Start -lt $ConvertedInput.Count -2){
    $Sum = 0; $Index = $Start;
    while($Sum -lt $InvalidNum){
        $Sum += $ConvertedInput[$Index]
        if($Sum -eq $InvalidNum){
            $Found = $true
            "Sum: $Sum Start: $Start Index: $Index"
            break
        }
        $Index += 1
    }
    if($Found){break}
    $Start += 1
}

$ContigRange = @()
for($I = $Start; $I -le $Index; $I += 1){
    $ContigRange += $ConvertedInput[$I]
}

$ContigRange

$Smallest = $ContigRange | Sort | Select -First 1
$Largest = $ContigRange | Sort | Select -Last 1

$EncryptionWeakness = $Smallest + $Largest

"Smallest: $Smallest Largest:$Largest Weakness: $EncryptionWeakness"